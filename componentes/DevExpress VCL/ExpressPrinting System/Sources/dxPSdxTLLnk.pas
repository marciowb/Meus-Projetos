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
                                
unit dxPSdxTLLnk;

interface

{$I cxVer.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, 
  Menus, StdCtrls, ExtCtrls, ComCtrls, ImgList, dxCntner, dxTL, dxTLClms, 
  dxExEdtr, dxPSGlbl, dxBase, dxPSCore, cxDrawTextUtils;

type
  TdxTreeListPaintOption = 
    (tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, 
     tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoImages,
     tlpoStateImages, tlpoTransparentColumnGraphic, tlpoGraphicAsText,
     tlpo3DEffects, tlpoSoft3D, tlpoRowFooterGrid, tlpoCheckMarksAsText, 
     tlpoTreeLines, tlpoExpandButtons);
  TdxTreeListPaintOptions = set of TdxTreeListPaintOption;
  
  TdxTreeListLinkCellType = 
    (tlctUnknown, tlstBand, tlstCell, tlstFooter, tlstGroupFooter, tlstHeader, tlstPreview);
    
  TdxTreeListDrawMode = (tldmStrict, tldmOddEven, tldmBorrowSource);
  
  PdxTreeListBand = ^TdxTreeListBand;
  PdxTreeListColumn = ^TdxTreeListColumn;
  PdxTreeListNode = ^TdxTreeListNode;

  TdxTreeListColumnHelperClass = class of TdxTreeListColumnHelper;
  
  TdxTreeListColumnHelper = class(TdxCustomClassMapItem)
  protected
    class procedure GetImageLists(AColumn: TdxTreeListColumn; AProc: TdxPSGetImageListProc); virtual;
  public
    class function ColumnClass: TdxTreeListColumnClass; virtual;
    class function PairClass: TClass; override;
    class procedure Register;
  end;

  TdxTreeListImageColumnHelper = class(TdxTreeListColumnHelper)
  protected
    class procedure GetImageLists(AColumn: TdxTreeListColumn; AProc: TdxPSGetImageListProc); override;
  public
    class function ColumnClass: TdxTreeListColumnClass; override;
  end;
  
  TdxTLReportLinkCustomDrawBandCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; ABand: TdxTreeListBand;
    var AText: string; var AColor: TColor; AFont: TFont; 
    var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
    var ADone: Boolean) of object;
    
  TdxTLReportLinkCustomDrawCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode;
    AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor; 
    AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
    var ADone: Boolean) of object;
    
  TdxTLReportLinkCustomDrawFooterCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode;
    AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor; 
    AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
    var ADone: Boolean) of object;
    
  TdxTLReportLinkCustomDrawHeaderCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; AColumn: TdxTreeListColumn;
    var AText: string; var AColor: TColor; AFont: TFont; 
    var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
    var ASorted: TdxCellSortOrder; var ADone: Boolean) of object;
    
  TdxTLReportLinkCustomDrawPreviewCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode; 
    var AText: string; var AColor, ATextColor: TColor; AFont: TFont; 
    var ADone: Boolean) of object;
    
  TdxTLReportLinkCustomDrawRowFooterCellEvent = procedure(Sender: TBasedxReportLink;
    ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode;
    AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: string; 
    var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
    var ATextAlignY: TcxTextAlignY; var ADone: Boolean) of object;

  TCustomdxTreeListReportLink = class(TBasedxReportLink)
  private 
    FAutoNodesExpand: Boolean;
    FBandColor: TColor;
    FBandFont: TFont;
    FBandsOnEveryPage: Boolean;
    FDrawMode: TdxTreeListDrawMode;
    FEvenColor: TColor;
    FEvenFont: TFont;
    FExpandLevel: Integer;
    FExtendedSelect: Boolean;
    FFixedTransparent: Boolean;
    FFooterFont: TFont;
    FGraphicAsTextValue: string;
    FGridLineColor: TColor;
    FGroupNodeColor: TColor;
    FGroupNodeFont: TFont;
    FHeaderColor: TColor;
    FHeaderFont: TFont;
    FHorzDelimitByBands: Boolean;
    FIsGraphicAsTextValueAssigned: Boolean;
    FOddFont: TFont;
    FOnlySelected: Boolean;
    FOptions: TdxTreeListPaintOptions;
    FPreviewColor: TColor;
    FPreviewFont: TFont;
    FPreviewLineCount: Integer;
    FRowFooterColor: TColor;
    FRowFooterFont: TFont;
    FSupportedCustomDraw: Boolean;
    FTreeLineColor: TColor;

    FOnCustomDrawBandCell: TdxTLReportLinkCustomDrawBandCellEvent;
    FOnCustomDrawCell: TdxTLReportLinkCustomDrawCellEvent;
    FOnCustomDrawFooterCell: TdxTLReportLinkCustomDrawFooterCellEvent;
    FOnCustomDrawHeaderCell: TdxTLReportLinkCustomDrawHeaderCellEvent;
    FOnCustomDrawPreviewCell: TdxTLReportLinkCustomDrawPreviewCellEvent;
    FOnCustomDrawRowFooterCell: TdxTLReportLinkCustomDrawRowFooterCellEvent;
    
    FAbsoluteIndexes: TList;
    FColumnInfos: TList;
    FNodes: TList;

    FBandFontIndex: Integer;
    FBandHeight: Integer;
    FCustomDrawFontChanged: Boolean;
    FEvenFontIndex: Integer;
    FEvenHyperLinkFontIndex: Integer;
    FFooterPanelHeight: Integer;
    FFooterRowHeight: Integer;
    FFullWidth: Integer;
    FGroupNodeFontIndex: Integer;
    FGroupRowHeight: Integer;
    FGroupFooterRowHeight: Integer;
    FFooterFontIndex: Integer;
    FHeaderFontIndex: Integer;
    FHeaderRowHeight: Integer;
    FHorzDelimiterCell: TdxReportCell;
    FHyperLinkFontIndex: Integer;
    FOddHyperLinkFontIndex: Integer;
    FOddFontIndex: Integer;
    FPaintStyle: TdxTreeListPaintStyle;
    FPreviewFontIndex: Integer;
    FPreviewHeight: Integer;
    FPreviewLineHeight: Integer;
    FRowFooterFontIndex: Integer;    
    FRowHeight: Integer;
    FSaveFont: TFont;
    FShowRoot: Boolean;
        
    function GetCustomTreeList: TCustomdxTreeListControl;
    function GetExpandLevel: Integer;
    function GetExtendedColorManage: Boolean;
    function GetGraphicAsTextValue: string;
    function GetOddColor: TColor;
    function GetOptions: TdxTreeListPaintOptions;
    function GetUseColumnFont: Boolean;
    function IsGraphicAsTextValueStored: Boolean;
    procedure SetAutoNodesExpand(Value: Boolean);
    procedure SetBandFont(Value: TFont);
    procedure SetBandColor(Value: TColor);
    procedure SetBandsOnEveryPage(Value: Boolean);
    procedure SetDrawMode(Value: TdxTreeListDrawMode);
    procedure SetEvenColor(Value: TColor);
    procedure SetEvenFont(Value: TFont);
    procedure SetExpandLevel(Value: Integer);
    procedure SetExtendedColorManage(Value: Boolean);
    procedure SetExtendedSelect(Value: Boolean);
    procedure SetFixedTransparent(Value: Boolean);
    procedure SetFooterFont(Value: TFont);
    procedure SetGraphicAsTextValue(const Value: string);
    procedure SetGridLineColor(Value: TColor);
    procedure SetGroupNodeColor(Value: TColor);
    procedure SetGroupNodeFont(Value: TFont);
    procedure SetHeaderColor(Value: TColor);
    procedure SetHeaderFont(Value: TFont);
    procedure SetHorzDelimitByBands(Value: Boolean);
    procedure SetOddFont(Value: TFont);
    procedure SetOddColor(Value: TColor);
    procedure SetPreviewLineCount(Value: Integer);
    procedure SetOnCustomDrawBandCell(Value: TdxTLReportLinkCustomDrawBandCellEvent);
    procedure SetOnCustomDrawCell(Value: TdxTLReportLinkCustomDrawCellEvent);
    procedure SetOnCustomDrawFooterCell(Value: TdxTLReportLinkCustomDrawFooterCellEvent);
    procedure SetOnCustomDrawHeaderCell(Value: TdxTLReportLinkCustomDrawHeaderCellEvent);
    procedure SetOnCustomDrawPreviewCell(Value: TdxTLReportLinkCustomDrawPreviewCellEvent);
    procedure SetOnCustomDrawRowFooterCell(Value: TdxTLReportLinkCustomDrawRowFooterCellEvent);
    procedure SetOnlySelected(Value: Boolean);
    procedure SetOptions(Value: TdxTreeListPaintOptions);
    procedure SetPreviewColor(Value: TColor);
    procedure SetPreviewFont(Value: TFont);
    procedure SetRowFooterColor(Value: TColor);
    procedure SetRowFooterFont(Value: TFont);
    procedure SetSupportCustomDraw(Value: Boolean);
    procedure SetTreeLineColor(Value: TColor);
    procedure SetUseColumnFont(Value: Boolean);

    procedure AddNodes;
    procedure CalcAbsoluteIndexes;
    procedure CalcColumnInfos(AReportCells: TdxReportCells);
    procedure CalcDelimiterCell(AReportCells: TdxReportCells);
    procedure CalcFontIndexes(AReportCells: TdxReportCells);
    procedure FreeHeaderInfos;

    function CanDrawImages(ANode: TdxTreeListNode): Boolean;
    function CanDrawStateImages(ANode: TdxTreeListNode): Boolean;
    function CanUseOddEvenMode(ANode: TdxTreeListNode; ANodeIndex: Integer): Boolean;
    procedure CustomDrawFontChanged(Sender: TObject);
    function GetBandLeft(AVisibleIndex: Integer): Integer;
    function GetBandRect(AVisibleIndex: Integer): TRect;
    function GetBandRegionHeight: Integer;
    function GetBandWidth(AVisibleIndex: Integer): Integer;
    function GetCellColor(ANode: TdxTreeListNode; AColumnIndex, ANodeIndex: Integer): TColor;
    function GetCellCustomDrawInfo(AItem: TdxReportVisualItem; ANode: PdxTreeListNode; 
      AColumn: PdxTreeListColumn; ABand: PdxTreeListBand; 
      AFooterIndex: PInteger): TdxTreeListLinkCellType;
    function GetEvenNodeFontIndex(AColumn: TdxTreeListColumn): Integer;
    function GetOddEvenModeCellColor(ANodeIndex: Integer): TColor;
    function GetOddEvenModeFontIndex(AColumn: TdxTreeListColumn; ANodeIndex: Integer): Integer;
    function GetOddNodeFontIndex(AColumn: TdxTreeListColumn): Integer;
    function GetCellFontIndex(ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ANodeIndex: Integer): Integer;
    procedure GetCellRect(AAbsoluteIndex: Integer; ACellType: TdxTreeListLinkCellType; 
      var R: TRect);
    procedure GetColumnInfos(AAbsoluteIndex: Integer; ABandIndex, ARowIndex,
      AColIndex, ARowCount, AColCount: PInteger; AIsFirstColumn, AIsLastColumn: PBoolean);
    function GetLevelColor(ANode: TdxTreeListNode; ANodeIndex: Integer): TColor;
    function GetPreviewColor(ANodeIndex: Integer): TColor;
    function GetPreviewFontIndex(ANode: TdxTreeListNode; ANodeIndex: Integer): Integer;
    function AreSelectedNodesExist: Boolean;
    function IsCellTransparent(ANode: TdxTreeListNode): Boolean;
    function IsLevelTransparent(ANode: TdxTreeListNode): Boolean;
    function IsExtendedSelect: Boolean;
    function IsHyperLinkColumnsExists: Boolean;
    function IsPreviewTransparent(ANode: TdxTreeListNode): Boolean;
    function IsSelectedNode(ANode: TdxTreeListNode): Boolean;
    function MakeLookAndFeel: TdxLookAndFeel;
    function NeedGroupNodeFontIndex(ANode: TdxTreeListNode; AFontIndex: Integer): Boolean;

    procedure ReadIsGraphicAsTextValueAssigned(AReader: TReader);
    procedure WriteIsGraphicAsTextValueAssigned(AWriter: TWriter);
  protected
    FIndent: Integer;
    procedure DefineProperties(Filer: TFiler); override;
    
    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    function IsDrawFootersOnEveryPage: Boolean; override;
    function IsDrawHeadersOnEveryPage: Boolean; override;
    procedure MakeDelimiters(AReportCells: TdxReportCells; 
      AHorzDelimiters, AVertDelimiters: TList); override;

    procedure AssignValues(ADataItem: TAbstractdxReportCellData;
      ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn); virtual; abstract;
    function GetDataClass(AColumn: TdxTreeListColumn; 
      ANode: TdxTreeListNode): TdxReportCellDataClass; virtual;
    function GetGroupColumnIndex(ANode: TdxTreeListNode): Integer; virtual;
    procedure GetImageListsFromColumns(AProc: TdxPSGetImageListProc); virtual;
    procedure GetOwnedImageLists(AProc: TdxPSGetImageListProc); virtual;
    function GetReferenceColumn(AColumn: TdxTreeListColumn;
      ANode: TdxTreeListNode): TdxTreeListColumn; virtual;
    function GetCheckColumnGlyph(AColumn: TdxTreeListColumn): TBitmap; virtual;
    function IsCheckColumn(AColumn: TdxTreeListColumn): Boolean; virtual;
    function IsGraphicColumn(AColumn: TdxTreeListColumn): Boolean; virtual;
    function IsHyperLinkColumn(AColumn: TdxTreeListColumn): Boolean; virtual;
    procedure PrepareConstruct(AReportCells: TdxReportCells); virtual;
    procedure UnprepareConstruct(AReportCells: TdxReportCells); virtual;
    
    { custom draw support }    
    procedure CustomDraw(AItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); override;
    procedure DoCustomDrawBandCell(ACanvas: TCanvas; ABoundsRect, 
      AClientRect: TRect; ABand: TdxTreeListBand; var AText: string; 
      var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
      var ATextAlignY: TcxTextAlignY; var ADone: Boolean); virtual;
    procedure DoCustomDrawCell(ACanvas: TCanvas; ABoundsRect, AClientRect: TRect;
      ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; var AText: string; 
      var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
      var ATextAlignY: TcxTextAlignY; var ADone: Boolean); virtual;
    procedure DoCustomDrawFooterCell(ACanvas: TCanvas; ABoundsRect, 
      AClientRect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; 
      var AText: string;  var AColor: TColor; AFont: TFont; 
      var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;
    procedure DoCustomDrawHeaderCell(ACanvas: TCanvas; ABoundsRect, 
      AClientRect: TRect; AColumn: TdxTreeListColumn; var AText: string; 
      var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
      var ATextAlignY: TcxTextAlignY; var ASorted: TdxCellSortOrder; 
      var ADone: Boolean); virtual;
    procedure DoCustomDrawPreviewCell(ACanvas: TCanvas; ABoundsRect, 
      AClientRect: TRect; ANode: TdxTreeListNode; var AText: string; 
      var AColor: TColor; AFont: TFont; var ADone: Boolean); virtual;
    procedure DoCustomDrawRowFooterCell(ACanvas: TCanvas; ABoundsRect, 
      AClientRect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; 
      AFooterIndex: Integer; var AText: string; var AColor: TColor; AFont: TFont; 
      var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
      var ADone: Boolean); virtual;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; override;

    { options access }
    function AutoCalcPreviewLines: Boolean;
    function CheckMarksAsText: Boolean;
    function FlatCheckMarks: Boolean;
    function GraphicsAsText: Boolean;
    function OddEvenMode: Boolean;
    function ShowBands: Boolean;
    function ShowExpandButtons: Boolean;
    function ShowFooters: Boolean;
    function ShowGrid: Boolean;
    function ShowHeaders: Boolean;
    function ShowImages: Boolean;
    function ShowPreview: Boolean;
    function ShowPreviewGrid: Boolean;
    function ShowRowFooterGrid: Boolean;
    function ShowRowFooters: Boolean;
    function ShowStateImages: Boolean;
    function ShowTreeLines: Boolean;    
    function TransparentColumnGraphics: Boolean;
    function Use3DEffects: Boolean;
    function UseSoft3D: Boolean;

    property CustomTreeList: TCustomdxTreeListControl read GetCustomTreeList;
    property OnCustomDrawBandCell: TdxTLReportLinkCustomDrawBandCellEvent
      read FOnCustomDrawBandCell write SetOnCustomDrawBandCell;
    property OnCustomDrawCell: TdxTLReportLinkCustomDrawCellEvent
      read FOnCustomDrawCell write SetOnCustomDrawCell;
    property OnCustomDrawFooterCell: TdxTLReportLinkCustomDrawFooterCellEvent
      read FOnCustomDrawFooterCell write SetOnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell: TdxTLReportLinkCustomDrawHeaderCellEvent
      read FOnCustomDrawHeaderCell write SetOnCustomDrawHeaderCell;
    property OnCustomDrawPreviewCell: TdxTLReportLinkCustomDrawPreviewCellEvent
      read FOnCustomDrawPreviewCell write SetOnCustomDrawPreviewCell;
    property OnCustomDrawRowFooterCell: TdxTLReportLinkCustomDrawRowFooterCellEvent
      read FOnCustomDrawRowFooterCell write SetOnCustomDrawRowFooterCell;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function DefaultGraphicAsTextValue: string; virtual;

    function IsDBGridLink: Boolean; virtual;
    function IsDBTreeListLink: Boolean; virtual;
    function IsTreeListLink: Boolean; virtual;
  published
    property AutoNodesExpand: Boolean read FAutoNodesExpand write SetAutoNodesExpand default False;
    property BandColor: TColor read FBandColor write SetBandColor default dxDefaultFixedColor;//clSilver;
    property BandFont: TFont read FBandFont write SetBandFont stored IsFontStored;
    property BandsOnEveryPage: Boolean read FBandsOnEveryPage write SetBandsOnEveryPage default True;
    property Color;
    property DrawMode: TdxTreeListDrawMode read FDrawMode write SetDrawMode default tldmStrict;
    property ExpandLevel: Integer read GetExpandLevel write SetExpandLevel default -1; {full expand}
   {obsolete - use instead: DrawMode = tldmBorrowSource}
    property ExtendedColorManage: Boolean read GetExtendedColorManage write SetExtendedColorManage default False;
    property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect default True;
    property EvenColor: TColor read FEvenColor write SetEvenColor default clWhite;
    property EvenFont: TFont read FEvenFont write SetEvenFont stored IsFontStored;
    property FixedTransparent: Boolean read FFixedTransparent write SetFixedTransparent default False;
    property Font;
    property FooterFont: TFont read FFooterFont write SetFooterFont stored IsFontStored;
    property GraphicAsTextValue: string read GetGraphicAsTextValue write SetGraphicAsTextValue stored IsGraphicAsTextValueStored;
    property GridLineColor: TColor read FGridLineColor write SetGridLineColor default clBlack;
    property GroupNodeFont: TFont read FGroupNodeFont write SetGroupNodeFont stored IsFontStored;
    property GroupNodeColor: TColor read FGroupNodeColor write SetGroupNodeColor default dxDefaultFixedColor;//clSilver;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default dxDefaultFixedColor;//clSilver;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont stored IsFontStored;
    property HorzDelimitByBands: Boolean read FHorzDelimitByBands write SetHorzDelimitByBands default False;
    property OddColor: TColor read GetOddColor write SetOddColor default clWhite;
    property OddFont: TFont read FOddFont write SetOddFont stored IsFontStored;
    property OnlySelected: Boolean read FOnlySelected write SetOnlySelected default False;
    property Options: TdxTreeListPaintOptions read GetOptions write SetOptions
      default [tlpoBands..tlpoStateImages, tlpoSoft3D, tlpoRowFooterGrid, tlpoTreeLines, tlpoExpandButtons];
    property FootersOnEveryPage;
    property HeadersOnEveryPage default True;
    property PreviewColor: TColor read FPreviewColor write SetPreviewColor default clWhite;
    property PreviewFont: TFont read FPreviewFont write SetPreviewFont stored IsFontStored;
    property PreviewLineCount: Integer read FPreviewLineCount write SetPreviewLineCount default -1;
    property RowFooterColor: TColor read FRowFooterColor write SetRowFooterColor default dxDefaultFixedColor;//clSilver;
    property RowFooterFont: TFont read FRowFooterFont write SetRowFooterFont stored IsFontStored;
    property ScaleFonts;
    property SupportedCustomDraw: Boolean read FSupportedCustomDraw write SetSupportCustomDraw default False;
    property Transparent;
    property TreeLineColor: TColor read FTreeLineColor write SetTreeLineColor default clGray;
    property UseHorzDelimiters;
    property UseVertDelimiters;
    {obsolete -> you should use DrawMode = tldmBorrowSource}
    property UseColumnFont: Boolean read GetUseColumnFont write SetUseColumnFont default False;
  end;

  TdxTreeListReportLink = class(TCustomdxTreeListReportLink)
  private
    function GetTreeList: TdxTreeList;
  protected
    procedure AssignValues(ADataItem: TAbstractdxReportCellData;
      ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn); override;
    function GetDataClass(AColumn: TdxTreeListColumn; 
      ANode: TdxTreeListNode): TdxReportCellDataClass; override;
    procedure GetOwnedImageLists(AProc: TdxPSGetImageListProc); override;  
  public
    property TreeList: TdxTreeList read GetTreeList;
  published
    property OnCustomDrawBandCell;
    property OnCustomDrawCell;
    property OnCustomDrawFooterCell;
    property OnCustomDrawHeaderCell;
    property OnCustomDrawPreviewCell;
    property OnCustomDrawRowFooterCell;
  end;

  TdxTLReportLinkDesignWindow = class(TStandarddxReportLinkDesignWindow)
    PageControl1: TPageControl;
    tshColors: TTabSheet;
    tshFonts: TTabSheet;
    pnlPreview: TPanel;
    chbxTransparent: TCheckBox;
    chbxFixedTransparent: TCheckBox;
    gbxTransparent: TGroupBox;
    lblColor: TLabel;
    bvlColorHolder: TBevel;
    gbxFixedTransparent: TGroupBox;
    lblBandColor: TLabel;
    lblHeaderColor: TLabel;
    lblRowFooterColor: TLabel;
    bvlBandColorHolder: TBevel;
    bvlHeaderColorHolder: TBevel;
    bvlRowFooterColorHolder: TBevel;
    lblGridLineColor: TLabel;
    bvlGridLineColorHolder: TBevel;
    dxTLPreview: TdxTreeList;
    dxTLPreviewColumn1: TdxTreeListColumn;
    ilTLImages: TImageList;
    btnChangeFont: TButton;
    lblGroupNodeColor: TLabel;
    bvlGroupNodeColorHolder: TBevel;
    lblPreviewColor: TLabel;
    bvlPreviewColorHolder: TBevel;
    dxTLPreviewColumn3: TdxTreeListCheckColumn;
    lbxFonts: TListBox;
    dxTLPreviewColumn4: TdxTreeListImageColumn;
    tshBehaviors: TTabSheet;
    lblEvenColor: TLabel;
    bvlEvenColorHolder: TBevel;
    tshOptions: TTabSheet;
    Bevel11: TBevel;
    chbxShowGrid: TCheckBox;
    chbxShowNodeGrid: TCheckBox;
    chbxShowBands: TCheckBox;
    chbxShowHeaders: TCheckBox;
    chbxShowFooters: TCheckBox;
    chbxShowGroupFooters: TCheckBox;
    imgShow: TImage;
    lblShow: TLabel;
    chbxTransparentColumnGraphic: TCheckBox;
    chbxDisplayGraphicsAsText: TCheckBox;
    chbxShowStateImages: TCheckBox;
    chbxShowImages: TCheckBox;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Image3: TImage;
    chbxOnlySelected: TCheckBox;
    chbxExtendedSelect: TCheckBox;
    chbxAutoNodesExpand: TCheckBox;
    Image4: TImage;
    lblExpandLevel: TLabel;
    bvlExpandLevelHolder: TBevel;
    lblSelection: TLabel;
    lblExpanding: TLabel;
    lblRefinements: TLabel;
    bvlRefinements: TBevel;
    imgRefinements: TImage;
    lblLookAndFeel: TLabel;
    Image8: TImage;
    Bevel15: TBevel;
    chbxUse3DEffects: TCheckBox;
    chbxUseSoft3D: TCheckBox;
    Bevel16: TBevel;
    bvlShowImages: TBevel;
    pmChangeFont: TPopupMenu;
    miChangeFont: TMenuItem;
    bvlTreeLineColorHolder: TBevel;
    lblTreeLineColor: TLabel;
    tshPreview: TTabSheet;
    Bevel9: TBevel;
    lblPreviewLineCount: TLabel;
    bvlPreviewLineCountHolder: TBevel;
    lblPreview: TLabel;
    imgPreview: TImage;
    chbxShowPreview: TCheckBox;
    chbxAutoCalcPreviewLines: TCheckBox;
    chbxShowExpandButtons: TCheckBox;
    chbxShowTreeLines: TCheckBox;
    Bevel2: TBevel;
    lblDrawMode: TLabel;
    cbxDrawMode: TComboBox;
    Bevel10: TBevel;
    Image1: TImage;
    lblOnEveryPage: TLabel;
    chbxBandsOnEveryPage: TCheckBox;
    chbxHeadersOnEveryPage: TCheckBox;
    chbxFootersOnEveryPage: TCheckBox;
    chbxCheckMarksAsText: TCheckBox;
    chbxFlatCheckMarks: TCheckBox;
    lblPreviewWindow: TStaticText;
    stTransparent: TStaticText;
    stFixedTransparent: TStaticText;
    procedure FontClick(Sender: TObject);
    procedure chbxTransparentClick(Sender: TObject);
    procedure lblColorClick(Sender: TObject);
    procedure lblExpandLevelClick(Sender: TObject);
    procedure chbxOnlySelectedClick(Sender: TObject);
    procedure chbxExtendedSelectClick(Sender: TObject);
    procedure dxTLPreviewGetFooterCellText(Sender: TObject;
      ANode: TdxTreeListNode; AColumn, AFooterIndex: Integer;
      var AText: string);
    procedure dxTLPreviewGetPreviewText(Sender: TObject;
      ANode: TdxTreeListNode; var AText: string);
    procedure dxTLPreviewIsExistFooterCell(Sender: TObject;
      AColumn: Integer; var AExist: Boolean);
    procedure dxTLPreviewIsExistRowFooterCell(Sender: TObject;
      ANode: TdxTreeListNode; AColumn, AFooterIndex: Integer;
      var AExist: Boolean);
    procedure dxTLPreviewIsLevelFooter(Sender: TObject; ALevel: Integer;
      var AExist: Boolean);
    procedure dxTLPreviewCustomDrawFooterNode(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxTLPreviewCustomDrawFooter(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure btnChangeFontClick(Sender: TObject);
    procedure FontsMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dxTLPreviewCustomDrawPreviewCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      ASelected: Boolean; var AText: string; var AColor,
      ATextColor: TColor; AFont: TFont; var ADone: Boolean);
    procedure FontsKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbxFontsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lbxFontsClick(Sender: TObject);
    procedure dxTLPreviewColumn4CustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: string; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure chbxAutoNodesExpandClick(Sender: TObject);
    procedure chbxHeadersOnEveryPageClick(Sender: TObject);
    procedure chbxBandsOnEveryPageClick(Sender: TObject);
    procedure chbxFootersOnEveryPageClick(Sender: TObject);
    procedure dxTLPreviewCustomDrawColumnHeader(Sender: TObject;
      AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
      var AText: string; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
      var ADone: Boolean);
    procedure dxTLPreviewCustomDrawBand(Sender: TObject;
      ABand: TdxTreeListBand; ACanvas: TCanvas; ARect: TRect;
      var AText: string; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ADone: Boolean);
    procedure chbxAutoCalcPreviewLinesClick(Sender: TObject);
    procedure dxTLPreviewCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxTLPreviewGetPreviewLineCount(Sender: TObject;
      ANode: TdxTreeListNode; var LCount: Integer);
    procedure chbxShowClick(Sender: TObject);
    procedure cbxDrawModeChange(Sender: TObject);
    procedure lblDrawModeClick(Sender: TObject);
    procedure pmChangeFontPopup(Sender: TObject);
    procedure lbxFontsDblClick(Sender: TObject);
    procedure dxTLPreviewColumn3CustomDrawCell(Sender: TObject;
      ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
      AColumn: TdxTreeListColumn; ASelected, AFocused,
      ANewItemRow: Boolean; var AText: String; var AColor: TColor;
      AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure cbxDrawModeDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure stTransparentClick(Sender: TObject);
    procedure stFixedTransparentClick(Sender: TObject);
  private
    ccbxColor: TCustomComboBox;
    ccbxEvenColor: TCustomComboBox;
    ccbxBandColor: TCustomComboBox;
    ccbxHeaderColor: TCustomComboBox;
    ccbxGroupNodeColor: TCustomComboBox;
    ccbxPreviewColor: TCustomComboBox;
    ccbxRowFooterColor: TCustomComboBox;
    ccbxGridLineColor: TCustomComboBox;
    ccbxTreeLineColor: TCustomComboBox;
    seExpandLevel: TCustomEdit;
    sePreviewLineCount: TCustomEdit;
    FPreviewBox: TCustomControl;
    procedure ccbxColorChange(Sender: TObject);
    procedure CreateControls;
    procedure DoChangeFont(AIndex: Integer);
    procedure ExpandLevelChange(Sender: TObject);
    procedure FillTreeListData;
    function GetFontByIndex(AIndex: Integer): TFont;
    function GetFontInfoText(AIndex: Integer): string;
    function GetMaxWidth: Integer;
    function GetNodeFont(ANode: TdxTreeListNode; ANodeIndex: Integer): TFont;
    function GetNodeIndex(ANode: TdxTreeListNode): Integer;
    function GetPreviewFont(ANode: TdxTreeListNode; ANodeIndex: Integer): TFont;    
    function GetReportLink: TCustomdxTreeListReportLink;
    function IsChangeFontEnabled: Boolean;
    function IsDisableIndex(AIndex: Integer): Boolean;    
    procedure pbxPreviewPaint(Sender: TObject);
    procedure PreviewLineCountChange(Sender: TObject);
    procedure SetColorByTag(ATag: Integer; AColor: TColor);
    procedure SetupPreview;
    procedure CMDialogChar(var Msg: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    procedure DoInitialize; override;
    {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; override;
    {$ENDIF}
    procedure LoadStrings; override;
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); override;
    procedure UpdateControlsState; override;
    procedure UpdatePreview; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ReportLink: TCustomdxTreeListReportLink read GetReportLink;
  end;

  TdxTreeListColumnMapperProc = function(AColumn: TdxTreeListColumn;
    AReportLink: TCustomdxTreeListReportLink; ANode: TdxTreeListNode): TdxReportCellDataClass;
    
  TdxTreeListAssignDataProc = procedure(AReportLink: TCustomdxTreeListReportLink;
    ADataItem: TAbstractdxReportCellData; TreeList: TCustomdxTreeList;
    ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);

function DefaultdxTreeListMapperProc(AColumn: TdxTreeListColumn;
  AReportLink: TCustomdxTreeListReportLink; ANode: TdxTreeListNode): TdxReportCellDataClass;
procedure DefaultdxTreeListAssignDataProc(AReportLink: TCustomdxTreeListReportLink;
  ADataItem: TAbstractdxReportCellData; TreeList: TCustomdxTreeList;
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);

var
  FdxTreeListAssignDataProc: TdxTreeListAssignDataProc = nil;
  FdxTreeListColumnMapperProc: TdxTreeListColumnMapperProc = nil;
  FPicture: TPicture;
  
const
  dxDefaultTreeListPaintOptions: TdxTreeListPaintOptions = 
    [tlpoBands, tlpoHeaders, tlpoFooters, tlpoRowFooters, tlpoPreview, 
     tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks, tlpoImages, tlpoStateImages, 
     tlpoSoft3D, tlpoRowFooterGrid, tlpoTreeLines, tlpoExpandButtons];
  
implementation

{$R *.DFM}

uses
  Math, {$IFDEF DELPHI7} Themes, UxTheme, {$ENDIF} cxClasses, dxExtCtrls, 
  dxPSRes, dxPSPopupMan, dxPrnDev, dxPSUtl;

const
  SortOrderMap: array[TdxTreeListColumnSort] of TdxCellSortOrder = (csoNone, csoDown, csoUp);
  TreeLineStylesMap: array[TdxTreeLineStyle] of TdxPSTreeLineStyle = (tlsSolid, tlsDot);
    
function GetDesignerString(AnIndex: Integer): string;
begin
  case AnIndex of 
    0: Result := cxGetResourceString(@sdxItem1Description);
    1: Result := cxGetResourceString(@sdxItem2Description); 
    2: Result := cxGetResourceString(@sdxItem3Description);
    3: Result := cxGetResourceString(@sdxItem4Description); 
    4: Result := cxGetResourceString(@sdxItem5Description); 
    5: Result := cxGetResourceString(@sdxItem6Description); 
   else
     Result := cxGetResourceString(@sdxItem7Description);
   end;  
end;

type
  TdxTreeListAccess = class(TCustomdxTreeListControl);
  TdxTreeListColumnAccess = class(TdxTreeListColumn);
  TdxTreeListGraphicColumnAccess = class(TdxTreeListGraphicColumn);
  TdxTreeListWrapperColumnAccess = class(TdxTreeListWrapperColumn);

  PdxColumnInfo = ^TdxColumnInfo;
  TdxColumnInfo = record
    BandIndex: Integer;
    ColIndex: Integer;
    ColCount: Integer;
    RowIndex: Integer;
    RowCount: Integer;
    ColumnLeft: Integer;
    ColumnRight: Integer;    
    CellTop: Integer;
    CellBottom: Integer;
    FooterTop: Integer;
    FooterBottom: Integer;
    HeaderTop: Integer;
    HeaderBottom: Integer;
    NodeFooterTop: Integer;
    NodeFooterBottom: Integer;
    IsFirstColumn: Boolean;
    IsLastColumn: Boolean;
    IsHeaderMultiline: Boolean;
    IsMultiline: Boolean;
    FontIndex: Integer;
  end;

  TdxColumnHelpersFactory = class(TdxCustomClassMaps)
  private
    function GetHelperClass(Column: TdxTreeListColumn): TdxTreeListColumnHelperClass;
  public
    class function Instance: TdxColumnHelpersFactory; reintroduce; overload; 
    property HelperClasses[Column: TdxTreeListColumn]: TdxTreeListColumnHelperClass read GetHelperClass; default;
  end;

function dxColumnHelpersFactory: TdxColumnHelpersFactory;  
begin
  Result := TdxColumnHelpersFactory.Instance;
end;

class function TdxColumnHelpersFactory.Instance: TdxColumnHelpersFactory;
begin
  Result := inherited Instance as TdxColumnHelpersFactory;
end;

function TdxColumnHelpersFactory.GetHelperClass(Column: TdxTreeListColumn): TdxTreeListColumnHelperClass;
begin
  Result := TdxTreeListColumnHelperClass(PairClasses[Column.ClassType]);
end;
     
{ TdxTreeListColumnHelper }    

class function TdxTreeListColumnHelper.ColumnClass: TdxTreeListColumnClass;
begin
  Result := TdxTreeListColumn;
end;

class function TdxTreeListColumnHelper.PairClass: TClass;
begin
  Result := ColumnClass;
end;

class procedure TdxTreeListColumnHelper.Register;
begin
  dxColumnHelpersFactory.Register(Self);
end;

class procedure TdxTreeListColumnHelper.GetImageLists(AColumn: TdxTreeListColumn; 
  AProc: TdxPSGetImageListProc);
begin
end;

{ TdxTreeListImageColumnHelper }

class function TdxTreeListImageColumnHelper.ColumnClass: TdxTreeListColumnClass;
begin
  Result := TdxTreeListImageColumn;
end;
    
class procedure TdxTreeListImageColumnHelper.GetImageLists(AColumn: TdxTreeListColumn; 
  AProc: TdxPSGetImageListProc);
begin
  inherited GetImageLists(AColumn, AProc);
  AProc(TdxTreeListImageColumn(AColumn).Images);
end;

{ Utility routines }

function IsValidPointer(const AData: Integer): Boolean;
begin
  Result := DWORD(AData) > SysInit.HInstance;
end;

function ExposeTreeList(ATreeList: TCustomdxTreeListControl): TdxTreeListAccess;
begin
  Result := TdxTreeListAccess(ATreeList);
end;

{ - generic text columns -
  TdxTreeListColumn, TdxTreeListMaskColumn, TdxTreeListButtonColumn,
  TdxTreeListDateColumn, TdxTreeListSpinColumn, TdxTreeListPickColumn,
  TdxTreeListCalcColumn, TdxTreeListHyperLinkColumn, TdxTreeListTimeColumn,
  TdxTreeListCurrencyColumn, TdxTreeListMemoColumn, TdxTreeListMRUColumn,
  TdxTreeListBlobColumn, TdxTreeListWrapperColumn, TdxTreeListPopupColumn }
         
function DefaultdxTreeListMapperProc(AColumn: TdxTreeListColumn;
  AReportLink: TCustomdxTreeListReportLink; ANode: TdxTreeListNode): TdxReportCellDataClass;
const
  CheckClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellCheckImage, TdxReportCellString);
  ImageClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellGraphic, TdxReportCellImage);  
  GraphicClasses: array[Boolean] of TdxReportCellDataClass = (TdxReportCellString, TdxReportCellGraphic);
begin
  if AColumn is TdxTreeListCheckColumn then
    Result := CheckClasses[tlpoCheckMarksAsText in AReportLink.Options]
  else
    if AColumn is TdxTreeListImageColumn then
      Result := ImageClasses[TdxTreeListImageColumn(AColumn).ShowDescription]
    else  
      Result := GraphicClasses[(AColumn is TdxTreeListGraphicColumn) and not (tlpoGraphicAsText in AReportLink.Options)];
end;

procedure DefaultdxTreeListAssignDataProc(AReportLink: TCustomdxTreeListReportLink;
  ADataItem: TAbstractdxReportCellData; TreeList: TCustomdxTreeList;
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);
var
  ATreeList: TdxTreeListAccess;
  S: string;
  AImageIndex, Stub: Integer;
  AState: TCheckBoxState;
  NullStyle: TdxShowNullFieldStyle;
  GraphicClass: TGraphicClass;
begin
  ATreeList := TdxTreeListAccess(TreeList);
  
  if ADataItem is TdxReportCellCheck then
  begin
    with TdxReportCellCheckImage(ADataItem) do
    begin
      S := ATreeList.GetNodeString(ANode, AColumn.Index);
      AState := TCheckBoxState(TdxTreeListCheckColumn(AReferenceColumn).GetCheckBoxState(S));
      NullStyle := TdxTreeListCheckColumn(AReferenceColumn).ShowNullFieldStyle;
      Enabled := not ((AState = cbGrayed) and (NullStyle > nsUnchecked));
      Checked := (AState = cbChecked) or 
        ((AState = cbGrayed) and (NullStyle = nsGrayedChecked));
      FlatBorder := AReportLink.FlatCheckMarks;
      if not TdxTreeListCheckColumn(AReferenceColumn).Glyph.Empty then 
      begin
        Glyph := TdxTreeListCheckColumn(AReferenceColumn).Glyph;
        GlyphCount := TdxTreeListCheckColumn(AReferenceColumn).GlyphCount;
      end;  
    end;
    Exit;
  end;
    
  if AReferenceColumn is TdxTreeListMemoColumn then
  begin
    with TdxReportCellString(ADataItem) do
    begin
      Text := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      EndEllipsis := (aoDrawEndEllipsis in TreeList.Options);
      Multiline := True;
      TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, AColumn.Index)];
      TextAlignY := taTop;
    end;
    Exit;
  end;  
  
  if ADataItem is TdxReportCellImage then
  begin
    with TdxReportCellImage(ADataItem) do
    begin
      S := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      Text := AReferenceColumn.GetDisplayValue(ANode, S);
      EndEllipsis := True;
      Multiline := TdxTreeListImageColumn(AReferenceColumn).MultilineText;
      TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, {AReferenceColumn ?}AColumn.Index)];
      if Multiline then
        TextAlignY := dxMultilineTextAlignY[Multiline]
      else
        TextAlignY := dxTextAlignY[AReferenceColumn.VertAlignment];
      S := ATreeList.GetCellText(ANode, AColumn.Index);
      TdxTreeListImageColumn(AReferenceColumn).GetIndexes(S, AImageIndex, Stub);
      ImageList := TdxTreeListImageColumn(AReferenceColumn).Images;
      ImageIndex := AImageIndex;
      MakeSpaceForEmptyImage := True;
    end;
    Exit;
  end; 
   
  if ADataItem is TdxReportCellGraphic then
  begin
    if AReferenceColumn is TdxTreeListGraphicColumn then
    begin
      GraphicClass := TdxTreeListGraphicColumnAccess(AReferenceColumn).GetGraphicClass(ANode);
      LoadPicture(FPicture, GraphicClass, ANode.Values[AColumn.Index]);
      if GraphicClass = nil then GraphicClass := TBitmap;
      with TdxReportCellGraphic(ADataItem) do
      begin
        Image := FPicture.Graphic;
        ImageTransparent := 
          (tlpoTransparentColumnGraphic in AReportLink.Options) or GraphicClass.InheritsFrom(TIcon);
        if not GraphicClass.InheritsFrom(TIcon) and TdxTreeListGraphicColumn(AReferenceColumn).Stretch then
          DrawMode := gdmStretchProportional
        else 
          if TdxTreeListGraphicColumn(AReferenceColumn).Center then 
            DrawMode := gdmCenter
          else  
            DrawMode := gdmNone;
      end
    end
    else // AColumn is TdxTreeListImageColumn
    begin
      with TdxReportCellGraphic(ADataItem) do
      begin
        ImageTransparent := True;
        ImageList := TdxTreeListImageColumn(AReferenceColumn).Images;
        S := ATreeList.GetCellText(ANode, AColumn.Index);
        TdxTreeListImageColumn(AReferenceColumn).GetIndexes(S, AImageIndex, Stub);
        ImageIndex := AImageIndex;
        DrawMode := gdmCenter;
      end
    end;
    Exit;
  end;
    
  with TdxReportCellString(ADataItem) do
  begin
    if (AReferenceColumn is TdxTreeListGraphicColumn) then
    begin
      Text := AReportLink.GraphicAsTextValue;
      Multiline := False;
    end
    else
    begin
      Text := ATreeList.GetDisplayValue(ANode, AColumn.Index);
      Multiline := TdxTreeListGraphicColumnAccess(AReferenceColumn).IsColumnMultiline or 
        ((ATreeList.GetHeaderMaxRowCount = 1) and (aoRowAutoHeight in ATreeList.OptionsEx)); 
    end;
    EndEllipsis := ATreeList.IsDrawEndEllipsis;
    TextAlignX := dxTextAlignX[ATreeList.GetCellAlignment(ANode, {AReferenceColumn ?}AColumn.Index)];
    if Multiline then
      TextAlignY := dxMultilineTextAlignY[Multiline]
    else
      if AReferenceColumn.VertAlignment in [tlTop, tlCenter] then
        TextAlignY := taCenterY
      else
        TextAlignY := taBottom;
      //TextAlignY := dxTextAlignY[AReferenceColumn.VertAlignment];
  end;
end;

{ TCustomdxTreeListReportLink }

constructor TCustomdxTreeListReportLink.Create(AOwner: TComponent);

  function CreateFont: TFont;
  begin
    Result := TFont.Create;
    Result.OnChange := FontChanged;
  end;
  
begin
  inherited;
  FBandFont := CreateFont;
  FEvenFont := CreateFont;
  FFooterFont := CreateFont;
  FGroupNodeFont := CreateFont;
  FHeaderFont := CreateFont;
  FOddFont := CreateFont;
  FPreviewFont := CreateFont;
  FRowFooterFont := CreateFont;
  InternalRestoreDefaults;
  LinkModified(False);
  FNodes := TList.Create;
  
  FSaveFont := TFont.Create;
  FSaveFont.OnChange := CustomDrawFontChanged;
end;

destructor TCustomdxTreeListReportLink.Destroy;
begin
  FreeAndNil(FSaveFont);
  FreeAndNil(FNodes);
  FreeAndNil(FRowFooterFont);
  FreeAndNil(FPreviewFont);
  FreeAndNil(FOddFont);
  FreeAndNil(FHeaderFont);
  FreeAndNil(FGroupNodeFont);
  FreeAndNil(FFooterFont);
  FreeAndNil(FEvenFont);
  FreeAndNil(FBandFont);
  inherited;
end;

procedure TCustomdxTreeListReportLink.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxTreeListReportLink then
    with TCustomdxTreeListReportLink(Source) do 
    begin               
      Self.FIsGraphicAsTextValueAssigned := FIsGraphicAsTextValueAssigned;
    
      Self.AutoNodesExpand := AutoNodesExpand;
      Self.BandsOnEveryPage := BandsOnEveryPage;
      Self.DrawMode := DrawMode;
      Self.ExpandLevel := ExpandLevel;
      Self.ExtendedSelect := ExtendedSelect;
      Self.FixedTransparent := FixedTransparent;
      Self.OnlySelected := OnlySelected;
      Self.Options := Options;
      Self.PreviewLineCount := PreviewLineCount;
      Self.SupportedCustomDraw := SupportedCustomDraw;

      Self.BandColor := BandColor;
      Self.EvenColor := EvenColor;
      Self.GroupNodeColor := GroupNodeColor;
      Self.GridLineColor := GridLineColor;
      Self.HeaderColor := HeaderColor;
      Self.PreviewColor := PreviewColor;
      Self.RowFooterColor := RowFooterColor;

      Self.BandFont := BandFont;
      Self.EvenFont := EvenFont;
      Self.HeaderFont := HeaderFont;
      Self.OddFont := OddFont;
      Self.PreviewFont := PreviewFont;
      Self.FooterFont := FooterFont;
      Self.GroupNodeFont := GroupNodeFont;
      Self.RowFooterFont := RowFooterFont;
    end;
end;
                                
function TCustomdxTreeListReportLink.DefaultGraphicAsTextValue: string;
begin
  Result := cxGetResourceString(@sdxGraphicAsTextValue);
end;

function TCustomdxTreeListReportLink.IsDBTreeListLink: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeListReportLink.IsDBGridLink: Boolean;
begin
  Result := False;
end;

function TCustomdxTreeListReportLink.IsTreeListLink: Boolean;
begin
  Result := True;
end;

procedure TCustomdxTreeListReportLink.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsGraphicAsTextValueAssigned', ReadIsGraphicAsTextValueAssigned, 
    WriteIsGraphicAsTextValueAssigned,
    FIsGraphicAsTextValueAssigned and (GraphicAsTextValue = ''));
end;

function TCustomdxTreeListReportLink.GetCustomTreeList: TCustomdxTreeListControl;
begin
  Result := TCustomdxTreeListControl(Component);
end;

function TCustomdxTreeListReportLink.GetCellCustomDrawInfo(AItem: TdxReportVisualItem;  
  ANode: PdxTreeListNode; AColumn: PdxTreeListColumn; ABand: PdxTreeListBand; 
  AFooterIndex: PInteger): TdxTreeListLinkCellType;
begin
  Result := tlctUnknown;
  with AItem do 
  begin
    try
      if IsValidPointer(Data) and (Data <> 0) and (TObject(Data) is TClass) then 
        if TObject(Data) is TdxTreeListBand then 
          Result := tlstBand
        else 
          if TObject(Data) is TdxTreeListColumn then 
          begin
            if Parent <> nil then 
              if Parent.Data = 0 then
                Result := tlstFooter
              else 
                if TClass(Parent.Data) = TdxTreeListColumn then 
                  Result := tlstHeader
                else 
                  if IsValidPointer(Parent.Data) and (TObject(Parent.Data) is TdxTreeListNode) then 
                    if (Parent.Parent <> nil) and (Parent.Parent.Data <> 0) then
                      Result := tlstGroupFooter
                    else  
                      Result := tlstCell;
          end
          else 
            if TObject(Data) is TdxTreeListNode then Result := tlstPreview;
    except
      // eat exception if any Node or Column already deleted
    end;  
      
    if Result <> tlctUnknown then 
    begin
      if (ABand <> nil) and (Result = tlstBand) then 
        ABand^ := TdxTreeListBand(Data);
      if (AColumn <> nil) and (Result in [tlstCell, tlstFooter, tlstHeader, tlstGroupFooter]) then 
        AColumn^ := TdxTreeListColumn(Data);
      if (ANode <> nil) and (Result in [tlstCell, tlstHeader, tlstPreview, tlstGroupFooter]) then
        ANode^ := TdxTreeListNode(Parent.Data);
      if (AFooterIndex <> nil) and (Result = tlstGroupFooter) then
        AFooterIndex^ := Parent.Parent.Data - 1;
    end;    
  end;    
end;

procedure TCustomdxTreeListReportLink.CustomDrawFontChanged(Sender: TObject);
begin
  FCustomDrawFontChanged := True;
end;

procedure TCustomdxTreeListReportLink.CustomDraw(AItem: TAbstractdxReportCellData;
  ACanvas: TCanvas; ABoundsRect, AClientRect: TRect; var ADone: Boolean);
var
  ABand: TdxTreeListBand;
  AColumn: TdxTreeListColumn;
  ANode: TdxTreeListNode;
  AFooterIndex: Integer;
  AColor: TColor;
  ASorted: TdxCellSortOrder;
  AText: string;
  ATextAlignX: TcxTextAlignX;
  ATextAlignY: TcxTextAlignY;
  AType: TdxTreeListLinkCellType;
begin
  if AItem.Data = 0 then Exit;
  AType := GetCellCustomDrawInfo(AItem, @ANode, @AColumn, @ABand, @AFooterIndex);
  if AType = tlctUnknown then Exit;
  
  with TdxReportCellString(AItem) do
  begin
    AColor := ColorToRGB(Color);
    if Transparent then AColor := clNone;
    FSaveFont.Assign(Font);
    FCustomDrawFontChanged := False;
    AText := Text;
    if AType = tlstHeader then ASorted := SortOrder;
    if AType <> tlstPreview then 
    begin
      ATextAlignX := TextAlignX;
      ATextAlignY := TextAlignY;
    end;  
    case AType of 
      tlstBand:
        DoCustomDrawBandCell(ACanvas, ABoundsRect, AClientRect, ABand, AText,
          AColor, FSaveFont, ATextAlignX, ATextAlignY, ADone);
      tlstCell:
        DoCustomDrawCell(ACanvas, ABoundsRect, AClientRect, ANode, AColumn, AText,
          AColor, FSaveFont, ATextAlignX, ATextAlignY, ADone);
      tlstFooter:
        DoCustomDrawFooterCell(ACanvas, ABoundsRect, AClientRect, ANode, AColumn,
          AText, AColor, FSaveFont, ATextAlignX, ATextAlignY, ADone);
      tlstGroupFooter:
        DoCustomDrawRowFooterCell(ACanvas, ABoundsRect, AClientRect, ANode, AColumn, 
          AFooterIndex, AText, AColor, FSaveFont, ATextAlignX, ATextAlignY, ADone);
      tlstHeader:
        DoCustomDrawHeaderCell(ACanvas, ABoundsRect, AClientRect, AColumn, AText,
          AColor, FSaveFont, ATextAlignX, ATextAlignY, ASorted, ADone);
      tlstPreview:                                          
        DoCustomDrawPreviewCell(ACanvas, ABoundsRect, AClientRect, ANode, AText,
          AColor, FSaveFont, ADone);
    end;
    if not ADone then
    begin
      if FCustomDrawFontChanged then
      begin 
        SelectObject(ACanvas.Handle, FSaveFont.Handle);
        SetTextColor(ACanvas.Handle, ColorToRGB(FSaveFont.Color));
        FontIndex := -1;
      end;  
      if AColor <> clNone then
      begin
        Color := AColor;
        Transparent := False;
      end;
      Text := AText;
      if AType = tlstHeader then SortOrder := ASorted;
      if AType <> tlstPreview then 
      begin
        TextAlignX := ATextAlignX;
        TextAlignY := ATextAlignY;
      end;  
    end;
  end;
end;

procedure TCustomdxTreeListReportLink.SetSupportCustomDraw(Value: Boolean);
begin
  if FSupportedCustomDraw <> Value then
  begin
    FSupportedCustomDraw := Value;
    LinkModified(True);
  end;
end;

function TCustomdxTreeListReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
begin
  Result := SupportedCustomDraw;
  if Result and (Item <> nil) then
    if Item.Data = 0 then
      Result := False
    else
      case GetCellCustomDrawInfo(Item, nil, nil, nil, nil) of
        tlstBand:
          Result := Assigned(FOnCustomDrawBandCell);
        tlstCell:
          Result := Assigned(FOnCustomDrawCell);
        tlstFooter:
          Result := Assigned(FOnCustomDrawFooterCell);
        tlstGroupFooter: 
          Result := Assigned(FOnCustomDrawRowFooterCell);
        tlstHeader:
          Result := Assigned(FOnCustomDrawHeaderCell);
        tlstPreview: 
          Result := Assigned(FOnCustomDrawPreviewCell);
      end;    
end;

function TCustomdxTreeListReportLink.TransparentColumnGraphics: Boolean;
begin
  Result := (tlpoTransparentColumnGraphic in Options);
end;

function TCustomdxTreeListReportLink.IsDrawFootersOnEveryPage: Boolean;
begin
  Result := not IsAggregated and FootersOnEveryPage and ShowFooters and 
    (CustomTreeList <> nil) and (CustomTreeList.Count > 0);
end;

function TCustomdxTreeListReportLink.IsDrawHeadersOnEveryPage: Boolean;
begin
  Result := not IsAggregated and BandsOnEveryPage and 
    (ShowBands or (HeadersOnEveryPage and ShowHeaders)) and 
    (CustomTreeList <> nil) and (CustomTreeList.Count > 0);
end;

function TCustomdxTreeListReportLink.GetCheckColumnGlyph(AColumn: TdxTreeListColumn): TBitmap;
begin
  Result := TdxTreeListCheckColumn(AColumn).Glyph;
  if (Result <> nil) and Result.Empty then 
    Result := nil;
end;

function TCustomdxTreeListReportLink.IsCheckColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxTreeListCheckColumn;
end;

function TCustomdxTreeListReportLink.IsGraphicColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxTreeListGraphicColumn;
end;

function TCustomdxTreeListReportLink.IsHyperLinkColumn(AColumn: TdxTreeListColumn): Boolean;
begin
  Result := AColumn is TdxTreeListHyperLinkColumn;
end;

function TCustomdxTreeListReportLink.IsHyperLinkColumnsExists: Boolean;    
var
  I, AbsoluteIndex: Integer;
begin
  with FAbsoluteIndexes do
    for I := 0 to Count - 1 do 
    begin
      AbsoluteIndex := Integer(List^[I]);
      if IsHyperLinkColumn(CustomTreeList.Columns[AbsoluteIndex]) then
      begin
        Result := True;
        Exit;
      end;  
    end;   
  Result := False;   
end;

function TCustomdxTreeListReportLink.GetExpandLevel: Integer;
begin
  if IsDBGridLink or IsDBTreeListLink then
    Result := -1
  else
    Result := FExpandLevel;
end;

procedure TCustomdxTreeListReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited GetImageLists(AProc);
  GetOwnedImageLists(AProc);
  GetImageListsFromColumns(AProc);
end;

procedure TCustomdxTreeListReportLink.InternalRestoreFromOriginal;

  procedure XorOption(var AOptions: TdxTreeListPaintOptions; AItem: TdxTreeListPaintOption; AValue: Boolean);
  begin
    if AValue then
      Include(AOptions, AItem)
    else
      Exclude(AOptions, AItem);
  end;

begin
  inherited;

  with ExposeTreeList(CustomTreeList) do 
  begin
    PreviewLineCount := PreviewLines;
    if aoAutoCalcPreviewLines in OptionsEx then 
      PreviewLineCount := -1;

    Self.BandFont := BandFont;
    Self.Font := Font;
    Self.HeaderFont := HeaderFont;
    Self.PreviewFont := PreviewFont;
    Self.GroupNodeFont := Font;
    Self.GroupNodeFont.Color := GroupNodeTextColor;
    Self.FooterFont := Font;
    Self.RowFooterFont := FooterFont;

    FBandColor := BandColor;
    FGroupNodeColor := GroupNodeColor;
    FGridLineColor := GetGridColor(Color);
    FHeaderColor := HeaderColor;
    FRowFooterColor := RowFooterColor;
    FTreeLineColor := TreeLineColor;
    
    XorOption(FOptions, tlpoBands, ShowBands);
    XorOption(FOptions, tlpoHeaders, ShowHeader);
    XorOption(FOptions, tlpoFooters, ShowFooter);  
    XorOption(FOptions, tlpoRowFooters, ShowRowFooter);    
    XorOption(FOptions, tlpoGrid, ShowGrid);
    XorOption(FOptions, tlpoPreviewGrid, ShowPreviewGrid);
    XorOption(FOptions, tlpoPreview, aoPreview in CustomTreeList.Options);  
    XorOption(FOptions, tlpoImages, Images <> nil);    
    XorOption(FOptions, tlpoStateImages, StateImages <> nil);        
    XorOption(FOptions, tlpo3DEffects, LookAndFeel in [lfStandard, lfFlat]);            
    XorOption(FOptions, tlpoSoft3D, LookAndFeel = lfFlat);
    XorOption(FOptions, tlpoTreeLines, (PaintStyle = psStandard) and ShowLines);    
    XorOption(FOptions, tlpoExpandButtons, ShowButtons);    
  end;  
end;

procedure TCustomdxTreeListReportLink.InternalRestoreDefaults;
begin
  inherited;
  FAutoNodesExpand := False;
  BandsOnEveryPage := True;
  DrawMode := tldmStrict;
  FixedTransparent := False;
  FOnlySelected := False;
  HeadersOnEveryPage := True;
  Options := dxDefaultTreeListPaintOptions;
  FPreviewLineCount := -1;
  FSupportedCustomDraw := False;

  FBandColor := dxDefaultFixedColor;
  FEvenColor := Color;
  FGridLineColor := dxDefaultGridLineColor;
  FGroupNodeColor := dxDefaultFixedColor;
  FHeaderColor := dxDefaultFixedColor;
  FRowFooterColor := dxDefaultFixedColor;
  FPreviewColor := Color;
  FTreeLineColor := dxDefaultTreeLineColor;

  BandFont := DefaultFont;
  EvenFont := DefaultFont;
  FooterFont := DefaultFont;  
  GroupNodeFont := DefaultFont;
  HeaderFont := DefaultFont;
  OddFont := DefaultFont;  
  PreviewFont := DefaultFont;
  RowFooterFont := FooterFont;

  FExpandLevel := -1;
  FExtendedSelect := True;
  FIsGraphicAsTextValueAssigned := False;
end;

function TCustomdxTreeListReportLink.AutoCalcPreviewLines: Boolean;
begin
  Result := PreviewLineCount = -1;
end;

function TCustomdxTreeListReportLink.CheckMarksAsText: Boolean;
begin
  Result := tlpoCheckMarksAsText in Options;
end;

function TCustomdxTreeListReportLink.FlatCheckMarks: Boolean;
begin
  Result := tlpoFlatCheckMarks in Options;
end;

function TCustomdxTreeListReportLink.ShowBands: Boolean;
begin
  Result := tlpoBands in Options;
end;

function TCustomdxTreeListReportLink.GraphicsAsText: Boolean;
begin
  Result := (tlpoGraphicAsText in Options);
end;

function TCustomdxTreeListReportLink.ShowGrid: Boolean;
begin
  Result := ((DrawMode < tldmBorrowSource) and (tlpoGrid in Options)) or 
    ((DrawMode = tldmBorrowSource) and 
    ((CustomTreeList = nil) or ExposeTreeList(CustomTreeList).ShowGrid));
end;

function TCustomdxTreeListReportLink.ShowHeaders: Boolean;
begin
  Result := tlpoHeaders in Options;
end;

function TCustomdxTreeListReportLink.ShowExpandButtons: Boolean;
begin
  Result := tlpoExpandButtons in Options;
end;

function TCustomdxTreeListReportLink.ShowFooters: Boolean;
begin
  Result := tlpoFooters in Options;
end;

function TCustomdxTreeListReportLink.ShowPreview: Boolean;
begin
  Result := tlpoPreview in Options;
end;

function TCustomdxTreeListReportLink.ShowPreviewGrid: Boolean;
begin
  Result := ((DrawMode < tldmBorrowSource) and (tlpoPreviewGrid in Options)) or 
    ((DrawMode = tldmBorrowSource) and 
     ((CustomTreeList = nil) or ExposeTreeList(CustomTreeList).ShowPreviewGrid));
end;

function TCustomdxTreeListReportLink.ShowRowFooterGrid: Boolean;
begin
  Result := tlpoRowFooterGrid in Options;
end;

function TCustomdxTreeListReportLink.IsExtendedSelect: Boolean;
begin
  Result := AreSelectedNodesExist and ExtendedSelect;
end;

function TCustomdxTreeListReportLink.ShowRowFooters: Boolean;
begin
  Result := tlpoRowFooters in Options;
end;

function TCustomdxTreeListReportLink.ShowImages: Boolean;
begin
  Result := tlpoImages in Options;
end;

function TCustomdxTreeListReportLink.ShowStateImages: Boolean;
begin
  Result := tlpoStateImages in Options;
end;

function TCustomdxTreeListReportLink.ShowTreeLines: Boolean;    
begin
  Result := tlpoTreeLines in Options;
end;

function TCustomdxTreeListReportLink.CanDrawImages(ANode: TdxTreeListNode): Boolean;
begin
  with ExposeTreeList(CustomTreeList) do
    Result := ShowImages and Assigned(Images) and
      (ANode.ImageIndex > -1) and (ANode.ImageIndex < Images.Count);
end;

function TCustomdxTreeListReportLink.CanDrawStateImages(ANode: TdxTreeListNode): Boolean;
begin
  with ExposeTreeList(CustomTreeList) do 
    Result := ShowStateImages and Assigned(StateImages) and
      (ANode.StateIndex > -1) and (ANode.StateIndex < StateImages.Count);
end;

function TCustomdxTreeListReportLink.OddEvenMode: Boolean;
begin
  Result := DrawMode = tldmOddEven;
end;

function TCustomdxTreeListReportLink.Use3DEffects: Boolean;
begin
  Result := tlpo3DEffects in Options;
end;

function TCustomdxTreeListReportLink.UseSoft3D: Boolean;
begin
  Result := tlpoSoft3D in Options;
end;

procedure TCustomdxTreeListReportLink.SetExtendedSelect(Value: Boolean);
begin
  if FExtendedSelect <> Value then
  begin
    FExtendedSelect := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnlySelected(Value: Boolean);
begin
  if FOnlySelected <> Value then
  begin
    FOnlySelected := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetAutoNodesExpand(Value: Boolean);
begin
  if FAutoNodesExpand <> Value then
  begin
    FAutoNodesExpand := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetDrawMode(Value: TdxTreeListDrawMode);
begin
  if FDrawMode <> Value then
  begin
    FDrawMode := Value;
    LinkModified(True);
  end;
end;

function TCustomdxTreeListReportLink.GetOptions: TdxTreeListPaintOptions;
begin
  Result := FOptions;
end;

procedure TCustomdxTreeListReportLink.SetOptions(Value: TdxTreeListPaintOptions);
begin
  if FOptions <> Value then
  begin
    FOptions := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetBandsOnEveryPage(Value: Boolean);
begin
  if not IsAggregated then
    if FBandsOnEveryPage <> Value then
    begin
      FBandsOnEveryPage := Value;
      LinkModified(True);
    end;
end;

procedure TCustomdxTreeListReportLink.SetBandFont(Value: TFont);
begin
  BandFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetOddFont(Value: TFont);
begin
  OddFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetEvenFont(Value: TFont);
begin
  EvenFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetHeaderFont(Value: TFont);
begin
  HeaderFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetGroupNodeFont(Value: TFont);
begin
  GroupNodeFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetPreviewFont(Value: TFont);
begin
  PreviewFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetFooterFont(Value: TFont);
begin
  FFooterFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetRowFooterFont(Value: TFont);
begin
  FRowFooterFont.Assign(Value);
end;

procedure TCustomdxTreeListReportLink.SetBandColor(Value: TColor);
begin
  if FBandColor <> Value then
  begin
    FBandColor := Value;
    if tlpoBands in Options then 
      LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetEvenColor(Value: TColor);
begin
  if FEvenColor <> Value then
  begin
    FEvenColor := Value;
    if OddEvenMode then 
      LinkModified(True);
  end;
end;

function TCustomdxTreeListReportLink.GetOddColor: TColor;
begin
  Result := Color;
end;

procedure TCustomdxTreeListReportLink.SetOddColor(Value: TColor);
begin
  inherited Color := Value;
end;

procedure TCustomdxTreeListReportLink.SetGroupNodeColor(Value: TColor);
begin
  if FGroupNodeColor <> Value then
  begin
    FGroupNodeColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetGridLineColor(Value: TColor);
begin
  if FGridLineColor <> Value then
  begin
    FGridLineColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetHeaderColor(Value: TColor);
begin
  if FHeaderColor <> Value then
  begin
    FHeaderColor := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetPreviewColor(Value: TColor);
begin
  if FPreviewColor <> Value then
  begin
    FPreviewColor := Value;
    if tlpoPreview in Options then 
      LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetRowFooterColor(Value: TColor);
begin
  if FRowFooterColor <> Value then
  begin
    FRowFooterColor := Value;
    if tlpoRowFooters in Options then 
      LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetHorzDelimitByBands(Value: Boolean);
begin
  if FHorzDelimitByBands <> Value then
  begin
    FHorzDelimitByBands := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetFixedTransparent(Value: Boolean);
begin
  if FFixedTransparent <> Value then
  begin
    FFixedTransparent := Value;
    LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetExpandLevel(Value: Integer);
begin
  if Value < -1 then 
    Value := -1;
  if FExpandLevel <> Value then
  begin
    FExpandLevel := Value;
    if AutoNodesExpand then LinkModified(True);
  end;
end;

function TCustomdxTreeListReportLink.GetExtendedColorManage: Boolean;
begin
  Result := DrawMode = tldmBorrowSource;
end;

function TCustomdxTreeListReportLink.GetGraphicAsTextValue: string;
begin
  if FIsGraphicAsTextValueAssigned then
    Result := FGraphicAsTextValue
  else
    Result := DefaultGraphicAsTextValue;  
end;

procedure TCustomdxTreeListReportLink.SetExtendedColorManage(Value: Boolean);
begin
  DrawMode := tldmBorrowSource;
end;

function TCustomdxTreeListReportLink.GetUseColumnFont: Boolean;
begin
  Result := DrawMode = tldmBorrowSource;
end;

procedure TCustomdxTreeListReportLink.SetTreeLineColor(Value: TColor);
begin
  if FTreeLineColor <> Value then 
  begin
    FTreeLineColor := Value;
    LinkModified(True);
  end;  
end;

procedure TCustomdxTreeListReportLink.SetUseColumnFont(Value: Boolean);
begin
  DrawMode := tldmBorrowSource;
end;

procedure TCustomdxTreeListReportLink.SetPreviewLineCount(Value: Integer);
begin
  if Value < -1 then 
    Value := -1;
  if FPreviewLineCount <> Value then
  begin
    FPreviewLineCount := Value;
    if tlpoPreview in Options then LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawBandCell
  (Value: TdxTLReportLinkCustomDrawBandCellEvent);
begin
  if @FOnCustomDrawBandCell <> @Value then
  begin
    FOnCustomDrawBandCell := Value;
    if IsSupportedCustomDraw(nil) then 
      LinkModified(True);    
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawCell
  (Value: TdxTLReportLinkCustomDrawCellEvent);
begin
  if @FOnCustomDrawCell <> @Value then
  begin
    FOnCustomDrawCell := Value;
    if IsSupportedCustomDraw(nil) then 
      LinkModified(True);    
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawFooterCell
  (Value: TdxTLReportLinkCustomDrawFooterCellEvent);
begin
  if @FOnCustomDrawFooterCell <> @Value then
  begin
    FOnCustomDrawFooterCell := Value;
    if IsSupportedCustomDraw(nil) then 
      LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawHeaderCell
  (Value: TdxTLReportLinkCustomDrawHeaderCellEvent);
begin
  if @FOnCustomDrawHeaderCell <> @Value then
  begin
    FOnCustomDrawHeaderCell := Value;
    if IsSupportedCustomDraw(nil) then 
      LinkModified(True);
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawPreviewCell
  (Value: TdxTLReportLinkCustomDrawPreviewCellEvent);
begin
  if @FOnCustomDrawPreviewCell <> @Value then
  begin
    FOnCustomDrawPreviewCell := Value;
    if IsSupportedCustomDraw(nil) then  
      LinkModified(True);    
  end;
end;

procedure TCustomdxTreeListReportLink.SetOnCustomDrawRowFooterCell
  (Value: TdxTLReportLinkCustomDrawRowFooterCellEvent);
begin
  if @FOnCustomDrawRowFooterCell <> @Value then
  begin
    FOnCustomDrawRowFooterCell := Value;
    if IsSupportedCustomDraw(nil) then 
      LinkModified(True);    
  end;
end;

function TCustomdxTreeListReportLink.GetDataClass(AColumn: TdxTreeListColumn; 
  ANode: TdxTreeListNode): TdxReportCellDataClass;
begin
  Result := nil;
end;

function TCustomdxTreeListReportLink.GetGroupColumnIndex(
  ANode: TdxTreeListNode): Integer;
begin
  Result := 0;
end;

procedure TCustomdxTreeListReportLink.GetOwnedImageLists(AProc: TdxPSGetImageListProc);
begin
end;

procedure TCustomdxTreeListReportLink.GetImageListsFromColumns(AProc: TdxPSGetImageListProc);
var
  I: Integer;
  Column: TdxTreeListColumn;
begin
  for I := 0 to CustomTreeList.ColumnCount - 1 do
  begin
    Column := CustomTreeList.Columns[I];
    dxColumnHelpersFactory[Column].GetImageLists(Column, AProc);
  end;
end;

function TCustomdxTreeListReportLink.IsGraphicAsTextValueStored: Boolean;
begin
  Result := FIsGraphicAsTextValueAssigned and (GraphicAsTextValue <> DefaultGraphicAsTextValue);
end;

procedure TCustomdxTreeListReportLink.SetGraphicAsTextValue(const Value: string);
begin
  if GraphicAsTextValue <> Value then
  begin
    FGraphicAsTextValue := Value;
    FIsGraphicAsTextValueAssigned := True;
    if tlpoGraphicAsText in Options then LinkModified(True);
  end;
end;

function TCustomdxTreeListReportLink.GetReferenceColumn(AColumn: TdxTreeListColumn;
  ANode: TdxTreeListNode): TdxTreeListColumn;
begin
  if AColumn is TdxTreeListWrapperColumn then
  begin
    Result := TdxTreeListWrapperColumnAccess(AColumn).ReferenceColumn(ANode);
    if Result = nil then
      Result := AColumn;
  end
  else
    Result := AColumn;
end;

procedure TCustomdxTreeListReportLink.PrepareConstruct(AReportCells: TdxReportCells);
  
  function CalcRowHeight(DC: HDC; AFont: TFont; AMinHeight: Integer; AKeepParity: Boolean): Integer;
  begin
    Result := Renderer.CalcTextPatternHeight(DC, AFont);
    if Result < AMinHeight then 
      Result := AMinHeight;
    if AKeepParity and Odd(Result) then 
      Inc(Result);
  end;

var
  DC: HDC;
begin
  DC := GetDC(0);                                   
  try                   
    FRowHeight := CalcRowHeight(DC, Font, CustomTreeList.RowHeight, True);
    FHeaderRowHeight := 3 + CalcRowHeight(DC, HeaderFont, CustomTreeList.HeaderRowHeight, False);  
    FFooterRowHeight := CalcRowHeight(DC, FooterFont, 4 + CustomTreeList.FooterRowHeight, False);  
    FGroupRowHeight := CalcRowHeight(DC, GroupNodeFont, CustomTreeList.RowHeight, False);  
    FGroupFooterRowHeight := 2 + CalcRowHeight(DC, RowFooterFont, CustomTreeList.FooterRowHeight, True);
    FBandHeight := CalcRowHeight(DC, BandFont, CustomTreeList.BandPanelHeight, False);  
    FPreviewLineHeight := CalcRowHeight(DC, PreviewFont, CustomTreeList.DescTextHeight, True);
  finally
    ReleaseDC(0, DC);
  end;

  FFooterPanelHeight := FFooterRowHeight * 
    ExposeTreeList(CustomTreeList).GetHeaderMaxRowCount + Byte(Use3DEffects);

  FFullWidth := GetBandRect(ExposeTreeList(CustomTreeList).GetBandCount - 1).Right;
  FIndent := ExposeTreeList(CustomTreeList).Indent;
  FPaintStyle := ExposeTreeList(CustomTreeList).PaintStyle;  
  FShowRoot := ExposeTreeList(CustomTreeList).ShowRoot;
  
  FAbsoluteIndexes := TList.Create;
  CalcAbsoluteIndexes;
  CalcColumnInfos(AReportCells);
  CalcFontIndexes(AReportCells);
  AddNodes;
end;

procedure TCustomdxTreeListReportLink.UnprepareConstruct(AReportCells: TdxReportCells);
begin
  FreeHeaderInfos;
  FreeAndNil(FAbsoluteIndexes);
end;

function TCustomdxTreeListReportLink.GetBandRegionHeight: Integer;
begin
  Result := Byte(ShowBands) * Self.FBandHeight
end;

function TCustomdxTreeListReportLink.GetBandRect(AVisibleIndex: Integer): TRect;
begin
  with Result do
  begin
    Left := GetBandLeft(AVisibleIndex);
    Top := 0;
    Right := Left + GetBandWidth(AVisibleIndex);
    Bottom := Top + GetBandRegionHeight;
//  ver 2.3     
//    Inc(Left, Byte(Use3DEffects));
//    Inc(Top, Byte(Use3DEffects));
  end;
end;

procedure TCustomdxTreeListReportLink.ConstructReport(AReportCells: TdxReportCells);
var
  ATreeList: TdxTreeListAccess;
  
  function GetHeaderRegionHeight: Integer;
  begin
    if ShowHeaders then
      Result := 0 + ATreeList.GetHeaderMaxRowCount * FHeaderRowHeight
    else
      Result := 0;
  end;

  function IsNodeImagesExists(ANode: TdxTreeListNode): Boolean;
  begin
    Result := CanDrawImages(ANode) or CanDrawStateImages(ANode);
  end;

  function GetColumnFont(AIndex: Integer): TFont;
  begin
    Result := ATreeList.GetColumnFont(AIndex);
  end;

  function GetTextIndent(ANode: TdxTreeListNode): Integer;
  begin
    Result := ANode.Level * (FIndent + 0);
    if ((FPaintStyle = psStandard) and FShowRoot) or 
      ((FPaintStyle = psOutlook) and (ANode.Count > 0)) then 
      Inc(Result, FIndent);
    if CanDrawStateImages(ANode) then Inc(Result, ATreeList.StateImages.Width);
    if CanDrawImages(ANode) then Inc(Result, ATreeList.Images.Width);
  end;

  function GetDataItemSides(ANode: TdxTreeListNode; AAbsoluteIndex: Integer): TdxCellSides;
  var
    RowIndex: Integer;
    IsFirstColumn, IsLastColumn: Boolean;
  begin
    Result := [];
    GetColumnInfos(AAbsoluteIndex, nil, @RowIndex, nil, nil, nil, @IsFirstColumn, @IsLastColumn);
    if ShowGrid then
    begin
      if (RowIndex = 0) or (ShowPreviewGrid) then {!}//} or (ANode = FNodes.List^[0])) then
        Include(Result, csTop);
      if ShowPreviewGrid then
        Include(Result, csBottom);
      if ShowPreviewGrid or IsLastColumn then
        Include(Result, csRight);
      if IsFirstColumn then
      begin
        if ExposeTreeList(CustomTreeList).IsRowGroup(ANode) or not IsNodeImagesExists(ANode) then 
          Include(Result, csLeft)
      end  
      else 
        if ShowPreviewGrid then Include(Result, csLeft)
    end
    else 
    begin
      if (ANode = FNodes.List^[0]) and (RowIndex = 0) then
        Include(Result, csTop);
      if IsLastColumn then
        Include(Result, csRight);
    end;    
  end;

  function CalcColumnHeight(DC: HDC; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; 
    AnAbsoluteIndex, APreviewHeight, ARowHeight: Integer): Integer;
  var
    Glyph: TBitmap;
    S: string;
    R: TRect;
  begin
    if IsGraphicColumn(AColumn) then 
      Result := ATreeList.GetRowHeight(ANode, ARowHeight, True) - APreviewHeight
    else
      if IsCheckColumn(AColumn) then
      begin
        Glyph := GetCheckColumnGlyph(AColumn);
        if Glyph <> nil then
          Result := Glyph.Height
        else
          Result := dxPSGlbl.CheckHeight;
      end    
      else
      begin  
        if UseColumnFont and ATreeList.IsExistColumnFont(AnAbsoluteIndex) then
          SelectObject(DC, ATreeList.GetColumnFont(AnAbsoluteIndex).Handle);
        S := ATreeList.GetDisplayValue(ANode, AnAbsoluteIndex);
        if S <> '' then
        begin
          R := Rect(0, 0, ATreeList.GetHeaderBoundsWidth(AnAbsoluteIndex), 0);
          Result := Renderer.CalcTextRect(DC, S, R, True, nil);
        end
        else
          Result := FRowHeight;
      end;    
  end;
  
  function CalcRowAutoHeight(DC: HDC; ANode: TdxTreeListNode; APreviewHeight: Integer): Integer;
  var
    PrevFont: HFONT;
    I, AbsoluteIndex, V: Integer;
    Column: TdxTreeListColumn;    
  begin
    Result := 0;
    PrevFont := SelectObject(DC, Font.Handle);
    for I := 0 to FAbsoluteIndexes.Count - 1 do
    begin
      AbsoluteIndex := Integer(FAbsoluteIndexes.List[I]);
      Column := ATreeList.Columns[AbsoluteIndex];
      Column := GetReferenceColumn(Column, ANode);
      V := CalcColumnHeight(DC, ANode, Column, AbsoluteIndex, APreviewHeight, FRowHeight);
      if Result < V then 
        Result := V;
    end;
    SelectObject(DC, PrevFont);
  end;

  function CalcPreviewHeight(DC: hDC; const S: string; AWidth: Integer): Integer;
  var
    R: TRect;
  begin
    R := Rect(0, 0, AWidth, 0);
    Result := Renderer.CalcTextRect(DC, S, R, True, PreviewFont);
  end;

  function GetPreviewHeight(DC: hDC; ANode: TdxTreeListNode; AWidth: Integer): Integer;
  var
    S: string;
  begin
    if AutoCalcPreviewLines then
    begin
      S := ATreeList.GetPreviewText(ANode);
      if S <> '' then
        Result := CalcPreviewHeight(DC, S, AWidth - ATreeList.IndentDesc)
      else
        Result := 0;
    end
    else
      Result := PreviewLineCount * FPreviewLineHeight;
  end;

  function GetNodeHeight(ANode: TdxTreeListNode; AWidth: Integer; 
    APreviewHeight: PInteger): Integer;
  var
    NeedAllocateDC: Boolean;
    DC: HDC;
    V: Integer;
  begin
    with ExposeTreeList(CustomTreeList) do
      if IsRowGroup(ANode) then
        if FRowHeight < FGroupRowHeight then
          Result := FGroupRowHeight
        else
          Result := FRowHeight
      else
      begin
        NeedAllocateDC := 
          ((aoPreview in CustomTreeList.Options) and AutoCalcPreviewLines) or
          (IsRowAutoHeight and (GetHeaderMaxRowCount = 1));
        DC := 0;
        if NeedAllocateDC then DC := GetDC(0);
        try
          if (aoPreview in CustomTreeList.Options) then 
            V := GetPreviewHeight(DC, ANode, AWidth)
          else
            V := 0;  
          
          if IsRowAutoHeight and (GetHeaderMaxRowCount = 1) then
            Result := CalcRowAutoHeight(DC, ANode, V)
          else
            Result := GetHeaderMaxRowCount * FRowHeight;
        finally
          if NeedAllocateDC then ReleaseDC(0, DC);          
        end;  
        
        if (APreviewHeight <> nil) and ShowPreview then
        begin
          APreviewHeight^ := V;
          Inc(Result, V);
        end;
      end
  end;

  function GetCellHeight(ANode: TdxTreeListNode; AAbsoluteIndex: PInteger;
    ACellType: TdxTreeListLinkCellType; AParent: TdxReportCell): Integer;
  var
    BandIndex, RowIndex, ColIndex: Integer;
    UseParentHeight: Boolean;
  begin
    if AParent <> nil then
    begin
      UseParentHeight := ATreeList.IsRowAutoHeight and (ATreeList.GetHeaderMaxRowCount = 1);
      if UseParentHeight and (ACellType = tlstCell) then
        UseParentHeight := UseParentHeight or ATreeList.IsRowGroup(ANode); // and (GetPreviewLineCount(ANode) = 0)
    end
    else
      UseParentHeight := False;
      
    if UseParentHeight then 
      Result := AParent.Height - FPreviewHeight
    else
    begin
      if AAbsoluteIndex <> nil then
      begin
        GetColumnInfos(AAbsoluteIndex^, @BandIndex, @RowIndex, @ColIndex, nil, nil, nil, nil);
        Result := ATreeList.GetHeaderLineCount(ATreeList.GetVisibleBandIndex(BandIndex), RowIndex, ColIndex);
      end
      else
        Result := ATreeList.GetHeaderMaxRowCount;
        
      case ACellType of
        tlstCell: 
          Result := Result * FRowHeight;
        tlstFooter: 
          Result := Result * FFooterRowHeight + 3;
        tlstGroupFooter: 
          Result := Result * FGroupFooterRowHeight + 3;
        tlstHeader: 
          Result := 0 + Result * FHeaderRowHeight;
      end;
    end;
  end;

  function GetDataItemRect(ANode: TdxTreeListNode; AAbsoluteIndex: Integer; 
    AParent: TdxReportCell): TRect;
  var 
    IsFirstColumn, IsLastColumn: Boolean;
  begin
    GetCellRect(AAbsoluteIndex, tlstCell, Result);
    if ExposeTreeList(CustomTreeList).IsRowAutoHeight and (ExposeTreeList(CustomTreeList).GetHeaderMaxRowCount = 1) then        
      Result.Bottom := AParent.Height - FPreviewHeight;
    GetColumnInfos(AAbsoluteIndex, nil, nil, nil, nil, nil,  @IsFirstColumn, @IsLastColumn);
    if IsLastColumn then 
      Result.Right := FFullWidth;      
    if IsFirstColumn then 
      Result.Left := GetTextIndent(ANode);
  end;

 { Bands }
  procedure InsertBandItem(AVisibleIndex: Integer; AParent: TdxReportCell);
  var
    DataItem: TAbstractdxReportCellData;
  begin
    DataItem := TdxReportCellString.Create(AParent);
    with TdxReportCellString(DataItem) do
    begin
      FontIndex := FBandFontIndex;
      Text := ATreeList.GetBandText(AVisibleIndex);
      Multiline := ATreeList.BandRowCount > 1;
      EndEllipsis := not Multiline;
      CellSides := csAll;
      Transparent := True;
      TextAlignX := dxTextAlignX[ATreeList.GetBandAlignment(AVisibleIndex)];
      TextAlignY := taTop;
      
      if Use3DEffects then
      begin
        EdgeMode := cem3DEffects;
        Edge3DStyle := cesRaised;
        Edge3DSoft := UseSoft3D;
      end
      else
        EdgeMode := cemPattern;
        
      BoundsRect := GetBandRect(AVisibleIndex);
      if IsSupportedCustomDraw(nil) then
        Data := Integer(ATreeList.Bands[AVisibleIndex]);
    end;
  end;

  procedure InsertBands;
  var
    CellParent, Cell: TdxReportCell;
    I: Integer;
  begin
    if not IsAggregated and BandsOnEveryPage and (CustomTreeList.Count > 0) then
      CellParent := AReportCells.HeaderCells
    else  
      CellParent := AReportCells.Cells;
    Cell := TdxReportCell.Create(CellParent);
    with Cell do
    begin
      CellSides := csAll;
      Transparent := FixedTransparent;
      if not Transparent then Color := BandColor;
      BoundsRect := Rect(0, 0, FFullWidth, GetBandRegionHeight);
    end;
    for I := 0 to ExposeTreeList(CustomTreeList).GetBandCount - 1 do
      InsertBandItem(I, Cell);
  end;

  { Headers }
  function GetHeaderRect(AAbsoluteIndex: Integer; AParent: TdxReportCell): TRect;
  begin
    GetCellRect(AAbsoluteIndex, tlstHeader, Result);  
  end;

  procedure InsertHeaderItem(AAbsoluteIndex: Integer; AParent: TdxReportCell);
  var    
    IsMultilined: Boolean;
    DataItem: TdxReportCellImage;
  begin
    IsMultilined := PdxColumnInfo(FColumnInfos.List^[AAbsoluteIndex])^.IsHeaderMultiline;
    DataItem := TdxReportCellImage.Create(AParent);
    with DataItem do
    begin
      FontIndex := FHeaderFontIndex;
      Transparent := True;
      CellSides := csAll;
      BoundsRect := GetHeaderRect(AAbsoluteIndex, AParent);
      Text := ATreeList.GetHeaderText(AAbsoluteIndex);
      EndEllipsis := not IsMultilined;
      Multiline := IsMultilined;
      TextAlignX := dxTextAlignX[ATreeList.GetHeaderAlignment(AAbsoluteIndex)];
      TextAlignY := dxMultilineTextAlignY[Multiline];
      SortOrder := SortOrderMap[ATreeList.GetHeaderSorted(AAbsoluteIndex)];
      MakeSpaceForEmptyImage := False;
      
      if Use3DEffects then 
      begin
        EdgeMode := cem3DEffects;
        Edge3DStyle := cesRaised;
        Edge3DSoft := UseSoft3D;
      end  
      else
        EdgeMode := cemPattern;
        
      if ATreeList.IsExistHeaderGlyph(AAbsoluteIndex) then
        Image := ATreeList.GetHeaderGlyph(AAbsoluteIndex);
      if IsSupportedCustomDraw(nil) then
        Data := Integer(ATreeList.Columns[AAbsoluteIndex]);
    end;
  end;

  procedure InsertHeaders;
  var
    CellParent, Cell: TdxReportCell;
    PrevSibl: TdxReportItem;
    I: Integer;
  begin
    if not IsAggregated and BandsOnEveryPage and HeadersOnEveryPage and (CustomTreeList.Count > 0) then
      CellParent := AReportCells.HeaderCells
    else
      CellParent := AReportCells.Cells;
    Cell := TdxReportCell.Create(CellParent);
    with Cell do
    begin
      CellSides := csAll;
      Transparent := FixedTransparent;
      if not Transparent then Color := HeaderColor;
      BoundsRect := Bounds(GetBandLeft(0), 0, FFullWidth, GetHeaderRegionHeight);
      PrevSibl := GetPrevSibling;
      if PrevSibl <> nil then 
        Top := TdxReportVisualItem(PrevSibl).BoundsRect.Bottom;
      if IsSupportedCustomDraw(nil) then
        Data := Integer(TdxTreeListColumn);
    end;
    for I := 0 to FAbsoluteIndexes.Count - 1 do
      InsertHeaderItem(Integer(FAbsoluteIndexes.List^[I]), Cell);
  end;

  { Footers }
  function GetFooterRect(AAbsoluteIndex: Integer; AParent: TdxReportCell): TRect;
  var 
    IsFirstColumn, IsLastColumn: Boolean;
  begin
    GetCellRect(AAbsoluteIndex, tlstFooter, Result);
    InflateRect(Result, -1, -3);
    Inc(Result.Left);
    Inc(Result.Top);
    with Result do 
    begin
      GetColumnInfos(AAbsoluteIndex, nil, nil, nil, nil, nil, @IsFirstColumn, @IsLastColumn);
      if IsLastColumn then Dec(Right, 2);
      if IsFirstColumn then Inc(Left, 2);
    end;  
  end;

  procedure InsertFooterItem(AAbsoluteIndex: Integer; AParent: TdxReportCell);
  var
    DataItem: TAbstractdxReportCellData;
  begin
    DataItem := TdxReportCellString.Create(AParent);
    with TdxReportCellString(DataItem) do
    begin
      FontIndex := FFooterFontIndex;
      Text := ATreeList.GetFooterCellText(nil, AAbsoluteIndex, -1);
      Transparent := True;
      BoundsRect := GetFooterRect(AAbsoluteIndex, AParent);
      if Use3DEffects then 
      begin
        EdgeMode := cem3DEffects;
        Edge3DStyle := cesSunken;
        Edge3DSoft := True;
      end  
      else
        EdgeMode := cemPattern;
        
      CellSides := csAll;
      TextAlignX := dxTextAlignX[ATreeList.GetFooterCellAlignment(nil, AAbsoluteIndex, -1)];
      TextAlignY := taCenterY;
      if IsSupportedCustomDraw(nil) then
        Data := Integer(ATreeList.Columns[AAbsoluteIndex]);
    end;
  end;

  procedure InsertFooters;
  var
    CellParent, Cell: TdxReportCell;
//    R: TRect;
    PrevSibl: TdxReportItem;
    I, AbsoluteIndex: Integer;    
  begin
    if not IsAggregated and FootersOnEveryPage and (ATreeList.Count > 0) then
      CellParent := AReportCells.FooterCells
    else
      CellParent := AReportCells.Cells;
    Cell := TdxReportCell.Create(CellParent);
    with Cell do
    begin
      CellSides := csAll;
      Transparent := FixedTransparent;
      if not Transparent then 
        Color := HeaderColor;
      if Use3DEffects then
      begin
        EdgeMode := cem3DEffects;
        Edge3DStyle := cesRaised;
        Edge3DSoft := UseSoft3D;
      end  
      else  
        EdgeMode := cemPattern;

      { 2.3 }
      BoundsRect := Rect(0, 0, FFullWidth, GetCellHeight(nil, nil, tlstFooter, nil));
      PrevSibl := GetPrevSibling;
      if PrevSibl <> nil then
        Top := TdxReportCell(PrevSibl).BoundsRect.Bottom;
    end;
    for I := 0 to FAbsoluteIndexes.Count - 1 do
    begin
      AbsoluteIndex := Integer(FAbsoluteIndexes.List^[I]);
      if ATreeList.IsExistFooterCell(AbsoluteIndex) then
        InsertFooterItem(AbsoluteIndex, Cell);
    end;
  end;

  procedure InsertStub;
  var
    Last: TdxReportCell;
  begin
    Last := AReportCells.Cells.LastCell;
    if Last <> nil then
      with TdxReportCell.Create(AReportCells.Cells) do
      begin
        BoundsRect := Bounds(0, Last.BoundsRect.Bottom, FFullWidth, 1);
        CellSides := [csTop];
        Transparent := True;
      end;
  end;

  function GetNodeParentAtLevel(ANode: TdxTreeListNode; AtLevel: Integer): TdxTreeListNode;
  begin
    Result := ANode;
    if (FPaintStyle = psOutlook) and (ANode.Count = 0) then 
      Result := Result.Parent;
      
    while AtLevel > 0 do 
    begin
      Result := Result.Parent;
      Dec(AtLevel);
    end;
  end;
  
  { RowFooters }
  function GetRowFooterCount(Node: TdxTreeListNode): Integer;
  var
    ANode: TdxTreeListNode;
  begin
    Result := 0;
    if (Node = nil) or (Node.Count <> 0) or not Node.IsLast then Exit;
//    if (Node <> nil) and (Node.Count = 0) and Node.IsLast then
    ANode := Node.Parent;
    while (Node <> nil) and Node.IsLast do
    begin
      if ExposeTreeList(CustomTreeList).IsLevelFooter(ANode.Level) then 
        Inc(Result);
      Node := ANode;
      ANode := ANode.Parent;
    end
  end;

  function GetRowFooterItemIndent(ANode: TdxTreeListNode): Integer;
  begin
    Result := (FIndent + 0) * (ANode.Level + Ord(FShowRoot and (FPaintStyle = psStandard)));
    if CanDrawStateImages(ANode) then
      Inc(Result, ATreeList.StateImages.Width)
    else 
      if CanDrawImages(ANode) then 
        Inc(Result, ATreeList.Images.Width);
  end;

  function GetRowFooterRect(ANode: TdxTreeListNode; AAbsoluteIndex: Integer; 
     AParent: TdxReportCell): TRect;
  var 
    Level: Integer;
    IsFirstColumn, IsLastColumn: Boolean;
  begin
    GetCellRect(AAbsoluteIndex, tlstGroupFooter, Result);
    Level := ANode.Level - Ord(not FShowRoot and (FPaintStyle = psStandard));
    OffsetRect(Result, -Level * (FIndent + 0), 0);

    GetColumnInfos(AAbsoluteIndex, nil, nil, nil, nil, nil, @IsFirstColumn, @IsLastColumn);
    if IsFirstColumn then 
      Inc(Result.Left, GetRowFooterItemIndent(ANode) + 1);
    InflateRect(Result, -2, -3);
    Inc(Result.Right);
    if IsLastColumn then Dec(Result.Right, 2);
  end;
  
  procedure InsertRowFooterItem(ANode, AFooterNode: TdxTreeListNode; 
    AAbsoluteIndex: Integer; AFooterIndex: Integer; AParent: TdxReportCell);
  var
    DataItem: TAbstractdxReportCellData;
  begin
    DataItem := TdxReportCellString.Create(AParent);
    with TdxReportCellString(DataItem) do
    begin
      FontIndex := FRowFooterFontIndex;
      Text := ATreeList.GetFooterCellText(AFooterNode, AAbsoluteIndex, AFooterIndex);
      Transparent := True;
      CellSides := [];
      if ShowGrid and ShowRowFooterGrid then
        CellSides := csAll;
      BoundsRect := GetRowFooterRect(ANode, AAbsoluteIndex, AParent);
      TextAlignX := dxTextAlignX[ATreeList.GetFooterCellAlignment(AFooterNode, AAbsoluteIndex, AFooterIndex)];
      TextAlignY := taCenterY;
      MultiLine := False;
      if Use3DEffects then 
      begin
        EdgeMode := cem3DEffects;
        Edge3DStyle := cesSunken;
        Edge3DSoft := True;
      end  
      else  
        EdgeMode := cemPattern;
        
      if IsSupportedCustomDraw(nil) then
        Data := Integer(CustomTreeList.Columns[AAbsoluteIndex]);
    end;
  end;
  
  procedure SetupExpandButtonAndTreeLines(AItem: TdxReportCellExpandButton; AIndex: Integer; 
    ANode: TdxTreeListNode; AGroupFooter: Boolean);

    function GetExpandButtonSize: Integer;
    begin
      if FPaintStyle = psStandard then 
        Result := 9
      else
        if Use3dEffects then
          if UseSoft3D then
            Result := 11
          else  
            Result := 12
        else
          Result := 12;
    end;

    function GetIndentShowButton(AtLevel: Integer; ANode: TdxTreeListNode): Boolean;
    begin
      Result := ShowExpandButtons and ((FPaintStyle = psStandard) or (ANode.Count <> 0)) and 
        (GetNodeParentAtLevel(ANode, AtLevel) = ANode) and ANode.HasChildren;
    end;

    function GetIndentButtonExpanded(ANode: TdxTreeListNode): Boolean;
    begin
      if AutoNodesExpand then 
        Result := ANode.Expanded or ((ANode.Count <> 0) and ((ExpandLevel = -1) or (ExpandLevel > ANode.Level)))
      else
        Result := ANode.Expanded;
    end;
  
    function GetIndentTreeLineMode(AtLevel: Integer; ANode: TdxTreeListNode): TdxPSTreeLineMode;
    var
      Parent: TdxTreeListNode;
    begin
      if ShowTreeLines and (FPaintStyle = psStandard) then 
      begin
        Parent := GetNodeParentAtLevel(ANode, AtLevel);
        if Parent = ANode then 
          if ANode.IsLast then
            Result := tlmBottomRightCorner
          else
            if (ANode.Level = 0) and (ANode.Index = 0) then             
              Result :=  tlmTopRightCorner  
            else
              Result := tlmCross
        else
          if (Parent <> nil) and Parent.IsLast then
            Result := tlmNone
          else
            Result := tlmVertical;
      end      
      else
        Result := tlmNone
    end;

    function GetIndentTreeLineModeInFooter(AtLevel: Integer; ANode: TdxTreeListNode): TdxPSTreeLineMode;
    var
      Parent: TdxTreeListNode;
    begin
      if ShowTreeLines and (FPaintStyle = psStandard) then 
      begin
        Parent := GetNodeParentAtLevel(ANode, AtLevel);
        if (Parent = nil) or Parent.IsLast then
          Result := tlmNone
        else  
          Result := tlmVertical;
      end
      else
        Result := tlmNone
    end;
  
  begin
    with AItem do 
    begin
      ShowButton := not AGroupFooter and GetIndentShowButton(AIndex, ANode);
      if ShowButton then 
      begin
        ButtonBorder3D := Use3DEffects and (FPaintStyle = psOutlook);
        ButtonBorder3DSoft := UseSoft3D and (FPaintStyle = psOutlook);
        ButtonBorderShadow := not ButtonBorder3D and (FPaintStyle = psOutlook);
        ButtonExpanded := GetIndentButtonExpanded(ANode);
        ButtonSize := GetExpandButtonSize;
      end;  
      if AGroupFooter then 
        TreeLineMode := GetIndentTreeLineModeInFooter(AIndex, ANode)
      else  
        TreeLineMode := GetIndentTreeLineMode(AIndex, ANode);
    end;  
  end;
  
  procedure InsertRowFooters(ANode, AFooterNode: TdxTreeListNode; 
     AParent: TdxReportCell; AFooterIndex: Integer);
  var
    I, J, AAbsoluteIndex, ALevel, RowFooterHeight: Integer;
    ACell: TdxReportCell;
    APrevSibl: TdxReportItem;
    ADataItem: TAbstractdxReportCellData;
    Node: TdxTreeListNode;
  begin
    if FPaintStyle = psStandard then 
      ALevel := ANode.Level - 1 - Ord(not FShowRoot) 
    else
      ALevel := ANode.Level - 1; //Byte(ANode.Count = 0);
      
    RowFooterHeight := GetCellHeight(ANode, nil, tlstGroupFooter, nil);
    ACell := TdxReportCell.Create(AParent);
    with ACell do
    begin
      Transparent := True;//(ALevel > -1) or FixedTransparent;
      if not Transparent then Color := RowFooterColor;
      CellSides := [csLeft, csRight];
      if not Transparent and ShowGrid then
        CellSides := CellSides + [csTop, csBottom];
      BoundsRect := Rect(0, 0, FFullWidth, RowFooterHeight);
      APrevSibl := GetPrevSibling;
      if Assigned(APrevSibl) then
        Top := TdxReportCell(APrevSibl).BoundsRect.Bottom;
      if IsSupportedCustomDraw(nil) then
        Data := 1 + AFooterIndex;
    end;

    ADataItem := nil;
    Node := AFooterNode;
    for I := 0 to ALevel do
    begin
      ADataItem := TdxReportCellExpandButton.Create(ACell);
      with TdxReportCellExpandButton(ADataItem) do
      begin
        BoundsRect := Rect(0, 0, FIndent + 0, RowFooterHeight);
        APrevSibl := GetPrevSibling;
        if APrevSibl <> nil then
          Left := TdxReportVisualItem(APrevSibl).BoundsRect.Right;
        CellSides := [];
        if ShowGrid then
        begin
          CellSides := CellSides + [csLeft, csRight];
          if I = ALevel then CellSides := CellSides + [csBottom];
        end  
        else 
          if I = 0 then
            CellSides := CellSides + [csLeft];
        Node := AFooterNode;
        for J := AFooterNode.Level - 1 downto I + Byte(FPaintStyle = psStandard) do
          Node := Node.Parent;
        Transparent := IsLevelTransparent(Node);
        if OddEvenMode and (FPaintStyle = psStandard) then 
          Transparent := FixedTransparent;
        if not Transparent then 
          Color := GetLevelColor(Node, -1);

        // 2.3 ExpandButtons and TreeLines
        SetupExpandButtonAndTreeLines(TdxReportCellExpandButton(ADataItem), ALevel - I, ANode.Parent, True);
      end;
    end;
    
    ACell := TdxReportCell.Create(ACell);
    with ACell do
    begin
      CellSides := [csRight];
      if ShowGrid then
        CellSides := CellSides + [csLeft, csTop, csBottom];
      Transparent := FixedTransparent;
      if not Transparent then 
 {2.0}  if DrawMode = tldmBorrowSource then 
          Color := GetLevelColor(Node, -1)
        else
          Color := RowFooterColor;
      I := 0;
      if Assigned(ADataItem) then 
        I := ADataItem.BoundsRect.Right;
      BoundsRect := Rect(I, 0, FFullWidth, RowFooterHeight);               
      if IsSupportedCustomDraw(nil) then 
        Data := Integer(AFooterNode);
    end;
    
    for I := 0 to FAbsoluteIndexes.Count - 1 do
    begin
      AAbsoluteIndex := Integer(FAbsoluteIndexes.List^[I]);
      if ATreeList.IsExistRowFooterCell(AFooterNode, AAbsoluteIndex, AFooterIndex) then
        InsertRowFooterItem(ANode, AFooterNode, AAbsoluteIndex, AFooterIndex, ACell);
    end;
  end;
  
{Preview}
  function GetPreviewCellSides(ANode: TdxTreeListNode): TdxCellSides;
  begin
    Result := [csRight];
    if ShowGrid then
    begin
      Include(Result, csBottom);
      if (FPaintStyle = psOutlook) and not IsNodeImagesExists(ANode) then
        Include(Result, csLeft);
      if ShowPreviewGrid then
        Include(Result, csTop);
    end;
  end;  

{Nodes}
  function IsLastNodeEx(Node, ANode: TdxTreeListNode): Boolean;
  begin
    repeat
      Result := ANode.IsLast;      
      ANode := ANode.Parent;
    until not Result or (ANode = nil) or (ANode = Node);
  end;
  
  procedure ProcessCells(ANode: TdxTreeListNode; AParent: TdxReportCell; ANodeIndex: Integer);
  var
    I, AAbsoluteIndex, ACellHeight, ALevel: Integer;
    ADataClass: TdxReportCellDataClass;
    ADataItem: TAbstractdxReportCellData;
    ACell: TdxReportCell;
    APrevSibl: TdxReportItem;
    ParentNode: TdxTreeListNode;
    Column, ReferenceColumn: TdxTreeListColumn;
  begin
    if not ATreeList.IsRowGroup(ANode) and ShowPreview then
      ACellHeight := GetNodeHeight(ANode, FFullWidth - GetTextIndent(ANode), @FPreviewHeight)
    else
    begin
      ACellHeight := GetNodeHeight(ANode, 0, nil);
      FPreviewHeight := 0;
    end;

    ACell := TdxReportCell.Create(AParent);
    with ACell do
    begin
      BoundsRect := Rect(0, 0, FFullWidth, ACellHeight);
      APrevSibl := GetPrevSibling;
      if Assigned(APrevSibl) then
        Top := TdxReportCell(APrevSibl).BoundsRect.Bottom;
      CellSides := [csLeft, csRight];
      if (ANode = FNodes.List^[0]) then
        CellSides := CellSides + [csTop];
      Transparent := IsLevelTransparent(ANode);
      if not Transparent then 
        Color := GetLevelColor(ANode, ANodeIndex);
      if IsSupportedCustomDraw(nil) then
        Data := Integer(ANode);
    end;

    if FPaintStyle = psStandard then
      ALevel := ANode.Level - Ord(not FShowRoot)
    else
      ALevel := ANode.Level - 1 + Ord(ANode.Count <> 0);    

    for I := 0 to ALevel do
    begin
      ParentNode := GetNodeParentAtLevel(ANode, ALevel - I);// + Ord(FPaintStyle = psOutlook));
      //for J := ANode.Level - 1 downto I + Byte(FPaintStyle = psStandard) do
      //  ParentNode := ParentNode.Parent;
      ADataItem := TdxReportCellExpandButton.Create(ACell);
      with TdxReportCellExpandButton(ADataItem) do
      begin
        BoundsRect := Bounds(0, 0, FIndent + 0, ACellHeight);
        APrevSibl := GetPrevSibling;
        if APrevSibl <> nil then
          Left := TdxReportVisualItem(APrevSibl).BoundsRect.Right;
        CellSides := [];
        
        if ShowGrid then
        begin
          CellSides := CellSides + [csLeft];
          if ANode.Parent = nil then 
            CellSides := CellSides + [csTop];
          if not ((FPaintStyle = psOutlook) and (I = ALevel) and (ANode.Count <> 0)) then 
            CellSides := CellSides + [csRight];
          if FPaintStyle = psStandard then
          begin
            if I = ALevel then
            begin
              CellSides := CellSides + [csTop];
              if ANode.Count = 0 then CellSides := CellSides + [csBottom];
            end;
          end
          else
            if (I = ALevel) and (ANode.Count > 0) then
              CellSides := CellSides + [csTop];
              
          if ((ANode.Count = 0) or (not ANode.Expanded and not AutoNodesExpand)) and 
            (not ShowRowFooters or (ATreeList.GetRowFooterCount(ANode) = 0)) and
            IsLastNodeEx(ParentNode, ANode) then 
            CellSides := CellSides + [csBottom];
        end
        else
        begin
          if I = 0 then 
            CellSides := CellSides + [csLeft];
          if ANode = FNodes.List^[0] then 
            CellSides := CellSides + [csTop];
          if ANode = FNodes.Last then 
            CellSides := CellSides + [csBottom];
        end;
        
        Transparent := IsLevelTransparent(ParentNode);
        if not Transparent then 
          Color := GetLevelColor(ParentNode, ANodeIndex);

        // 2.3 ExpandButtons and TreeLines          
        SetupExpandButtonAndTreeLines(TdxReportCellExpandButton(ADataItem), ALevel - I, ANode, False)
      end;
    end;

    if IsTreeListLink or IsDBTreeListLink then
    begin
      { state images }
      if CanDrawStateImages(ANode) then
      begin
        ADataItem := TdxReportCellGraphic.Create(ACell);
        with TdxReportCellGraphic(ADataItem) do
        begin
          CellSides := [];
          if {ShowPreviewGrid and }ShowGrid then 
          begin
            CellSides := [csTop, csBottom];
            if (ANode.Count = 0) or (not ANode.Expanded and not AutoNodesExpand) then
              CellSides := CellSides + [csLeft];
          end;  
          DrawMode := gdmCenter;
          Transparent := True;
          if OddEvenMode and not Self.Transparent and (FPaintStyle = psOutlook) and (ANode.Count = 0) then 
          begin
            Transparent := False;
            if Odd(ANodeIndex) then
              Color := OddColor 
            else
              Color := EvenColor;
          end;
          ImageList := ATreeList.StateImages;
          ImageIndex := ANode.StateIndex;
          BoundsRect := Bounds(0, 0, ImageList.Width, Parent.Height);
          APrevSibl := GetPrevSibling;
          if APrevSibl <> nil then
            Left := TdxReportCell(APrevSibl).BoundsRect.Right;
        end;
      end;

      { images }
      if CanDrawImages(ANode) then
      begin
        ADataItem := TdxReportCellGraphic.Create(ACell);
        with TdxReportCellGraphic(ADataItem) do
        begin
          CellSides := [];
          if {ShowPreviewGrid and }ShowGrid then 
          begin
            CellSides := [csTop, csBottom];
            if not CanDrawStateImages(ANode) and (ANode.Count = 0) or (not ANode.Expanded and not AutoNodesExpand) then 
              CellSides := CellSides + [csLeft];
          end;    
          DrawMode := gdmCenter;
          Transparent := True;
          if OddEvenMode and not Self.Transparent and (FPaintStyle = psOutlook) and (ANode.Count = 0) then 
          begin
            Transparent := False;
            if Odd(ANodeIndex) then
              Color := OddColor
            else
              Color := EvenColor;
          end;
          ImageList := ATreeList.Images;
          ImageIndex := ANode.ImageIndex;
          BoundsRect := Bounds(0, 0, ImageList.Width, Parent.Height);
          APrevSibl := GetPrevSibling;
          if APrevSibl <> nil then
            Left := TdxReportCell(APrevSibl).BoundsRect.Right;
        end;
      end;
    end;

    if not ATreeList.IsRowGroup(ANode) then
    begin
      for I := 0 to FAbsoluteIndexes.Count - 1 do
      begin
        AAbsoluteIndex := Integer(FAbsoluteIndexes.List^[I]);
        Column := ATreeList.Columns[AAbsoluteIndex];
        ReferenceColumn := GetReferenceColumn(Column, ANode);
        ADataClass := GetDataClass(ReferenceColumn, ANode);
        if (ADataClass <> nil) then
        begin
          ADataItem := ADataClass.Create(ACell);
          AssignValues(ADataItem, ANode, Column, ReferenceColumn);
          with ADataItem do 
          begin
            CellSides := GetDataItemSides(ANode, AAbsoluteIndex);
            BoundsRect := GetDataItemRect(ANode, AAbsoluteIndex, ACell);
            Transparent := IsCellTransparent(ANode);
            if not Transparent then
              Color := GetCellColor(ANode, AAbsoluteIndex, ANodeIndex);
            FontIndex := GetCellFontIndex(ANode, Column, ANodeIndex);
            if IsSupportedCustomDraw(nil) then
              Data := Integer(Column);
          end;    
        end;
      end
    end  
    else
    begin
      ADataItem := TdxReportCellString.Create(ACell);
      with TdxReportCellString(ADataItem) do
      begin
        Column := ATreeList.Columns[GetGroupColumnIndex(ANode)];
        Text := ATreeList.GetNodeString(ANode, Column.Index);
        TextAlignY := taCenterY;
        Transparent := IsCellTransparent(ANode);
        if not Transparent then 
          Color := GetCellColor(ANode, 0, -1);
        FontIndex := FGroupNodeFontIndex;
        BoundsRect := Rect(GetTextIndent(ANode), 0, FFullWidth, ACellHeight);
        if ShowGrid then 
          CellSides := [csTop..csBottom]
        else  // ver. 2.3
          CellSides := [csRight];
        if IsSupportedCustomDraw(nil) then 
          Data := Integer(Column);
      end;
    end;

{preview}
    if not ATreeList.IsRowGroup(ANode) and ShowPreview and (FPreviewHeight <> 0) then
    begin
      ADataItem := TdxReportCellString.Create(ACell);
      with TdxReportCellString(ADataItem) do
      begin
        CellSides := GetPreviewCellSides(ANode);
        Multiline := True;
        Text := ATreeList.GetPreviewText(ANode);
        TextAlignY := dxMultilineTextAlignY[Multiline];
        Transparent := IsPreviewTransparent(ANode);
        if not Transparent then 
          Color := GetPreviewColor(ANodeIndex);
        FontIndex := GetPreviewFontIndex(ANode, ANodeIndex);
        Indent := ATreeList.IndentDesc;
        BoundsRect := 
          Rect(GetTextIndent(ANode), ACellHeight - FPreviewHeight, FFullWidth, ACellHeight);
        if IsSupportedCustomDraw(nil) then
          ADataItem.Data := Integer(ANode);
      end;
    end;

{row footers}
    if ShowRowFooters and ANode.IsLast and (ANode.Count = 0) then
    begin
      ParentNode := ANode;
      for I := 0 to ATreeList.GetRowFooterCount(ANode) - 1 do
      begin
        InsertRowFooters(ParentNode, ANode, AParent, I);
        ParentNode := ParentNode.Parent;
      end;
    end;
  end;

  procedure IterateNodes;
  var
    I, M: Integer;
    Node: TdxTreeListNode;
  begin
    M := 0;
    for I := 0 to FNodes.Count - 1 do
    begin
      Inc(M);
      Node := TdxTreeListNode(FNodes.List^[I]);
      if ATreeList.IsRowGroup(Node) or ((ATreeList.PaintStyle = psOutlook) and (Node.Count > 0)) then 
        M := 0;
      ProcessCells(Node, AReportCells.Cells, M);
      AReportCells.DoProgress(MulDiv(I, 100, FNodes.Count));        
      if AbortBuilding then Break;
    end;
  end;

begin
  if Component = nil then Exit;
  inherited ConstructReport(AReportCells);
  PrepareConstruct(AReportCells);
  try
    if (FAbsoluteIndexes.Count > 0) then
    begin
      ATreeList := ExposeTreeList(CustomTreeList);
      
      AReportCells.BorderColor := GridLineColor;
      AReportCells.TreeLineColor := TreeLineColor;
      if ATreeList.PaintStyle = psStandard then
        AReportCells.ExpandButtonBorderColor := clBtnShadow
      else  
        AReportCells.ExpandButtonBorderColor := clBlack;
      AReportCells.TreeLineStyle := TreeLineStylesMap[ATreeList.TreeLineStyle];      
      
      with AReportCells.Cells do
      begin
        Color := dxDefaultColor;
        CellSides := [];
        Transparent := True;
        FontIndex := 0;
      end;
      if IsDrawHeadersOnEveryPage then
        with AReportCells.HeaderCells do
        begin
          Color := dxDefaultFixedColor;
          CellSides := [];
          Transparent := False;
          FontIndex := FHeaderFontIndex;
        end;
      if IsDrawFootersOnEveryPage then
        with AReportCells.FooterCells do
        begin
          Color := dxDefaultFixedColor;
          CellSides := [];
          Transparent := False;
          FontIndex := FFooterFontIndex;
        end;

      if ShowBands then InsertBands;
      if ShowHeaders then InsertHeaders;
      if (FNodes <> nil) and (FNodes.Count > 0) then 
        IterateNodes;

      if not AbortBuilding then
        if ShowFooters then
          InsertFooters
        else
          InsertStub;

      if not AbortBuilding then    
      begin
        with AReportCells do
        begin
          if Cells.CellCount > 0 then
            Cells.BoundsRect := Rect(0, 0, FFullWidth, Cells.LastCell.BoundsRect.Bottom);
          if IsDrawHeadersOnEveryPage and (HeaderCells.CellCount > 0) then
            HeaderCells.BoundsRect := Rect(0, 0, FFullWidth, HeaderCells.LastCell.BoundsRect.Bottom);
          if IsDrawFootersOnEveryPage and (FooterCells.CellCount > 0) then
            FooterCells.BoundsRect := Rect(0, 0, FFullWidth, FooterCells.LastCell.BoundsRect.Bottom);
        end;
        CalcDelimiterCell(AReportCells);
      end;
    end;
  finally
    UnprepareConstruct(AReportCells);
  end;
end;

function TCustomdxTreeListReportLink.GetBandLeft(AVisibleIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to AVisibleIndex - 1 do
    Inc(Result, GetBandWidth(I));
end;

function TCustomdxTreeListReportLink.GetBandWidth(AVisibleIndex: Integer): Integer;
begin
  Result := ExposeTreeList(CustomTreeList).GetBandWidth(AVisibleIndex);
  if (AVisibleIndex = 0) then
    Inc(Result, ExposeTreeList(CustomTreeList).GetIndentWidth);
end;

function TCustomdxTreeListReportLink.GetPreviewColor(ANodeIndex: Integer): TColor;
begin
  case DrawMode of
    tldmStrict:
      Result := PreviewColor;
    tldmOddEven:
      if Odd(ANodeIndex) then
        Result := OddColor
      else
        Result := EvenColor
  else
    Result := PreviewColor;    
  end;
end;

function TCustomdxTreeListReportLink.CanUseOddEvenMode(ANode: TdxTreeListNode; 
  ANodeIndex: Integer): Boolean;
begin
  Result := (DrawMode = tldmOddEven) and (ANodeIndex <> -1) and 
    ((FPaintStyle <> psOutlook) or (ANode.Count = 0))
end;

function TCustomdxTreeListReportLink.GetOddEvenModeCellColor(ANodeIndex: Integer): TColor;
begin
  if Odd(ANodeIndex) then
    Result := OddColor
  else
    Result := EvenColor;
end;

function TCustomdxTreeListReportLink.GetCellColor(ANode: TdxTreeListNode;
  AColumnIndex: Integer; ANodeIndex: Integer): TColor;
begin
  if CanUseOddEvenMode(ANode, ANodeIndex) then
    Result := GetOddEvenModeCellColor(ANodeIndex)
  else 
    if DrawMode = tldmBorrowSource then
      if (FPaintStyle = psOutlook) and (ANode.Count > 0) then
      begin
        Result := GroupNodeColor;
        ExposeTreeList(CustomTreeList).DoGetLevelColor(ANode.Level, Result);
      end
      else
      begin
        Result := ExposeTreeList(CustomTreeList).GetColumnColor(AColumnIndex);
        if (Result = ExposeTreeList(CustomTreeList).Color) then 
          Result := Color;
      end  
    else
      if (FPaintStyle = psOutlook) and (ANode.Count > 0) then 
        Result := GroupNodeColor
      else 
        Result := Color;
end;  

function TCustomdxTreeListReportLink.IsPreviewTransparent(ANode: TdxTreeListNode): Boolean;
begin
  if (FPaintStyle = psStandard) or (ANode.Count = 0) then
    Result := Transparent
  else
    Result := True;
end;

function TCustomdxTreeListReportLink.IsCellTransparent(ANode: TdxTreeListNode): Boolean; 
begin
  if (FPaintStyle = psStandard) or (ANode.Count = 0) then
    Result := Transparent
  else
    Result := FixedTransparent;
end;

function TCustomdxTreeListReportLink.GetLevelColor(ANode: TdxTreeListNode; 
  ANodeIndex: Integer): TColor;
begin
  if FPaintStyle = psStandard then
  begin
    case DrawMode of
      tldmStrict:
        Result := Color;
      tldmOddEven:
        if ANodeIndex = -1 then
          Result := RowFooterColor
        else
          if Odd(ANodeIndex) then
            Result := OddColor
          else
            Result := EvenColor;
    else {tldmBorrowSource}
      Result := ExposeTreeList(CustomTreeList).Color
    end    
  end  
  else
  begin
    if (ANode = nil) or (ANode.Count = 0) then 
      Result := ColorToRGB(Color)
    else
      Result := ColorToRGB(GroupNodeColor);
      
    if (DrawMode = tldmBorrowSource) and (ANode <> nil) and (ANode.Count <> 0) then 
      ExposeTreeList(CustomTreeList).DoGetLevelColor(ANode.Level, Result)
  end;
end;

function TCustomdxTreeListReportLink.IsLevelTransparent(ANode: TdxTreeListNode): Boolean;
begin
  if (FPaintStyle = psStandard) or (ANode.Count = 0) then
    Result := Transparent
  else
    Result := FixedTransparent;
end;

function TCustomdxTreeListReportLink.GetOddNodeFontIndex(AColumn: TdxTreeListColumn): Integer;
begin
  if IsHyperLinkColumn(AColumn) then 
    Result := FOddHyperLinkFontIndex
  else
    Result := FOddFontIndex;
end;

function TCustomdxTreeListReportLink.GetEvenNodeFontIndex(AColumn: TdxTreeListColumn): Integer;
begin
  if IsHyperLinkColumn(AColumn) then 
    Result := FEvenHyperLinkFontIndex
  else
    Result := FEvenFontIndex;
end;

function TCustomdxTreeListReportLink.GetOddEvenModeFontIndex(AColumn: TdxTreeListColumn; 
  ANodeIndex: Integer): Integer;
begin
  if Odd(ANodeIndex) then
    Result := GetOddNodeFontIndex(AColumn)
  else
    Result := GetEvenNodeFontIndex(AColumn);
end;

function TCustomdxTreeListReportLink.MakeLookAndFeel: TdxLookAndFeel;
begin
  if Use3DEffects then
  begin
    if UseSoft3D then 
      Result := lfFlat
    else  
      Result := lfStandard;
  end    
  else
    Result := lfUltraFlat;
end;

function TCustomdxTreeListReportLink.NeedGroupNodeFontIndex(ANode: TdxTreeListNode; 
  AFontIndex: Integer): Boolean;
begin
  Result := (AFontIndex = FFontIndex) and ((FPaintStyle = psOutLook) and (ANode.Count > 0));
end;

function TCustomdxTreeListReportLink.AreSelectedNodesExist: Boolean;
begin
  Result := OnlySelected and (ExposeTreeList(CustomTreeList).SelectedCount > 0);
end;

function TCustomdxTreeListReportLink.GetCellFontIndex(ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ANodeIndex: Integer): Integer;
begin
  if CanUseOddEvenMode(ANode, ANodeIndex) then
    Result := GetOddEvenModeFontIndex(AColumn, ANodeIndex)
  else  
  begin
    if ExposeTreeList(CustomTreeList).IsRowGroup(ANode) then 
      Result := FGroupNodeFontIndex
    else  
    begin
      if DrawMode = tldmBorrowSource then 
      begin
        Result := PdxColumnInfo(FColumnInfos.List^[AColumn.Index]).FontIndex;
        if NeedGroupNodeFontIndex(ANode, Result) then 
          Result := FGroupNodeFontIndex;
      end
      else
      begin
        if IsHyperLinkColumn(AColumn) then 
          Result := FHyperLinkFontIndex
        else
          Result := FFontIndex;
      end;
    end;      
  end;
end;      

function TCustomdxTreeListReportLink.GetPreviewFontIndex(ANode: TdxTreeListNode;
  ANodeIndex: Integer): Integer;
begin  
  if CanUseOddEvenMode(ANode, ANodeIndex) then
  begin
    if Odd(ANodeIndex) then
      Result := FOddFontIndex
    else
      Result := FEvenFontIndex
  end    
  else  
    Result := FPreviewFontIndex;    
end;      

function TCustomdxTreeListReportLink.IsSelectedNode(ANode: TdxTreeListNode): Boolean;

  function IsExistSelectedChild(ANode: TdxTreeListNode): Boolean;
  var
    I, J: Integer;
  begin
    Result := False;
    with ExposeTreeList(CustomTreeList) do 
      for I := 0 to ANode.Count - 1 do
      begin
        for J := 0 to SelectedCount - 1 do
        begin
          Result := ANode[I] = SelectedNodes[J];
          if Result then Exit;
        end;
        if ANode[I].Count > 0 then
        begin
          Result := IsExistSelectedChild(ANode[I]);
          if Result then Exit;
        end;
      end;
  end;

  function FindInOriginal(ANode: TdxTreeListNode): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    with ExposeTreeList(CustomTreeList) do 
      for I := 0 to SelectedCount - 1 do
      begin
        Result := ANode = SelectedNodes[I];
        //Result := ANode.Selected;
        if Result then Exit;
      end;
  end;

  function FindInChildren(ANode: TdxTreeListNode): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 0 to ANode.Count - 1 do
    begin
      Result := FindInOriginal(ANode[I]);
      if Result then
        Break
      else 
        if ANode[I].Count > 0 then
          Result := FindInChildren(ANode[I]);
      if Result then Break;
    end;
  end;

  function FindInParent(ANode: TdxTreeListNode): Boolean;
  begin
    Result := False;
    ANode := ANode.Parent;
    while Assigned(ANode) do
    begin
      Result := FindInOriginal(ANode);
      //if not Result then Result := FindInChildren(ANode);
      if Result then Break;
      ANode := ANode.Parent;
    end;
  end;

begin
  Result := FindInOriginal(ANode);
  if not Result and (ANode.Count > 0) then
    Result := FindInChildren(ANode);
  if not Result and not IsExtendedSelect then
    Result := FindInParent(ANode);
end;

procedure TCustomdxTreeListReportLink.AddNodes;

  procedure AddNode(ANode: TdxTreeListNode);
  var
    I: Integer;
    Node: TdxTreeListNode;
  begin
    FNodes.Add(ANode);
    if ANode.Expanded or (AutoNodesExpand and ((ExpandLevel = -1) or (ExpandLevel > ANode.Level))) then
      for I := 0 to ANode.Count - 1 do
      begin
        Node := ANode[I];
        if not AreSelectedNodesExist or IsSelectedNode(Node) then 
          AddNode(Node);
      end;
  end;
  
var
  I: Integer;
  Node: TdxTreeListNode;
begin
  FNodes.Clear;
  if CustomTreeList.Count > 0 then
  begin
    if not AutoNodesExpand then 
    begin
      if OnlySelected then                                             
        FNodes.Capacity := ExposeTreeList(CustomTreeList).SelectedCount
      else  
        FNodes.Capacity := ExposeTreeList(CustomTreeList).GetAbsoluteCount;
    end;

    for I := 0 to CustomTreeList.Count - 1 do
    begin
      Node := CustomTreeList.Items[I];
      if not AreSelectedNodesExist or IsSelectedNode(Node) then
        AddNode(Node);
    end;
  end;  
end;

procedure TCustomdxTreeListReportLink.CalcColumnInfos(AReportCells: TdxReportCells);
type
  PIntArray = ^TIntArray;
  TIntArray = array[0..0] of Integer;
var
  ATreeList: TdxTreeListAccess;
  Column: TdxTreeListColumnAccess;
  I, J, LineCount, HeaderWidth, AbsoluteIndex: Integer;
  HeaderInfo: PdxColumnInfo;
  F: TFont;
  HyperLinkColumn: Boolean;
begin
  if FAbsoluteIndexes.Count = 0 then Exit;
  
  ATreeList := ExposeTreeList(CustomTreeList);

  FColumnInfos := TList.Create;
  
{$IFOPT R+}{$DEFINE PREVRANGECHECK}{$R-}{$ENDIF}
  FColumnInfos.Count := 
    1 + Math.MaxIntValue(Slice(PIntArray(FAbsoluteIndexes.List)^, FAbsoluteIndexes.Count));
{$IFDEF SAVERANGECHECK}{$UNDEF PREVRANGECHECK}{$R+}{$ENDIF}

  F := TFont.Create;
  try
    with FAbsoluteIndexes do
      for I := 0 to Count - 1 do
      begin
        AbsoluteIndex := Integer(List^[I]);
        Column := TdxTreeListColumnAccess(ATreeList.Columns[AbsoluteIndex]);
        New(HeaderInfo);
        with HeaderInfo^ do
        begin
          HyperLinkColumn := IsHyperLinkColumn(Column);
          if UseColumnFont and (ATreeList.IsExistColumnFont(AbsoluteIndex) or HyperLinkColumn) then 
          begin
            F.Assign(ATreeList.GetColumnFont(AbsoluteIndex));
            if HyperLinkColumn then
            begin
              //F.Color := clBlue; // TODO: HyperLinkColumn Font Color
              F.Style := [fsUnderline];
            end;  
            FontIndex := AddFontToPool(F);
          end    
          else
            FontIndex := FFontIndex;
          
          BandIndex := ATreeList.GetVisibleBandIndex(ATreeList.GetHeaderBandIndex(AbsoluteIndex));
          RowIndex := ATreeList.GetHeaderRowIndex(AbsoluteIndex);
          RowCount := ATreeList.GetHeaderRowCount(BandIndex);
          ColIndex := ATreeList.GetHeaderColIndex(AbsoluteIndex);
          ColCount := ATreeList.GetHeaderColCount(BandIndex, RowIndex);
              
          ColumnLeft := GetBandLeft(BandIndex);
          for J := 0 to ColIndex - 1 do
          begin 
            HeaderWidth := ATreeList.GetHeaderBoundsWidth(ATreeList.GetHeaderAbsoluteIndex(BandIndex, RowIndex, J));
            Inc(ColumnLeft, HeaderWidth);
          end;    
          ColumnRight := ColumnLeft + ATreeList.GetHeaderBoundsWidth(AbsoluteIndex);
          CellTop := 0;
          FooterTop := 0;
          HeaderTop := 0;
          NodeFooterTop := 0;
          for J := 0 to RowIndex - 1 do
          begin
            LineCount := ATreeList.GetHeaderLineCount(BandIndex, J, ColIndex);
            Inc(CellTop,  LineCount * FRowHeight);
            Inc(FooterTop, LineCount * FFooterRowHeight);
            Inc(HeaderTop, LineCount * FHeaderRowHeight);
            Inc(NodeFooterTop, LineCount * FGroupFooterRowHeight);
          end;
          LineCount := ATreeList.GetHeaderLineCount(BandIndex, RowIndex, ColIndex);
          CellBottom := CellTop + LineCount * FRowHeight;
          FooterBottom :=  FooterTop + LineCount * FFooterRowHeight + 3;
          HeaderBottom := HeaderTop + LineCount * FHeaderRowHeight + 0;
          NodeFooterBottom := NodeFooterTop + LineCount * FGroupFooterRowHeight + 3;
          IsFirstColumn := (BandIndex = 0) and (ColIndex = 0);
          IsLastColumn := (BandIndex = ATreeList.GetBandCount - 1) and (ColIndex = ColCount - 1);

          IsHeaderMultiline := (ATreeList.GetHeaderLineCount(BandIndex, RowIndex, ColIndex) > 1) or 
            (ATreeList.GetHeaderLineRowCount > 1);

          IsMultiline := (ATreeList.GetHeaderLineCount(BandIndex, RowIndex, ColIndex) > 1) or 
            ((ATreeList.GetHeaderLineRowCount > 1) and Column.IsColumnMultiline);
            
          //IsMultiline := (ATreeList.GetHeaderLineCount(ATreeList.GetVisibleBandIndex(BandIndex), RowIndex, ColIndex) > 1) or 
          //  ((ATreeList.GetHeaderLineRowCount > 1) and Column.IsColumnMultiline);
        end;
        FColumnInfos.List^[AbsoluteIndex] := HeaderInfo;
      end;
  finally
    F.Free;
  end;  
end;

procedure TCustomdxTreeListReportLink.CalcDelimiterCell(AReportCells: TdxReportCells);
var
  TreeList: TdxTreeListAccess;
  I: Integer;
begin
  TreeList := ExposeTreeList(CustomTreeList);
  FHorzDelimiterCell := nil;
  if UseHorzDelimiters then 
  begin
    if ShowBands and HorzDelimitByBands then
      if not IsAggregated and BandsOnEveryPage and (CustomTreeList.Count > 0) then
        FHorzDelimiterCell := AReportCells.HeaderCells[0]
      else
        FHorzDelimiterCell := AReportCells.Cells[0]
    else 
      if ShowHeaders then
        if not IsAggregated and BandsOnEveryPage and HeadersOnEveryPage and (CustomTreeList.Count > 0)then
          FHorzDelimiterCell := AReportCells.HeaderCells[Byte(ShowBands)]
        else
          FHorzDelimiterCell := AReportCells.Cells[Byte(ShowBands)]
    else 
      if ShowBands then
        FHorzDelimiterCell := AReportCells.Cells[Byte(IsAggregated or not BandsOnEveryPage)]
      else 
        if AReportCells.Cells.CellCount > 0 then
          FHorzDelimiterCell := AReportCells.Cells[0]
  end;
  
  if FHorzDelimiterCell <> nil then
    if not ShowBands and not ShowHeaders and (CustomTreeList.Count > 0) and 
      (AReportCells.Cells.CellCount > 0) and
       TreeList.IsRowGroup(TdxTreeListNode(FNodes.List[0])) then
    begin
      I := 0;
      while (I < FNodes.Count) and TreeList.IsRowGroup(TdxTreeListNode(FNodes.List[I])) do
        Inc(I);
      if I < FNodes.Count then
        FHorzDelimiterCell := FHorzDelimiterCell.Parent.Cells[I]
      else
        FHorzDelimiterCell := nil;
    end;
end;

procedure TCustomdxTreeListReportLink.FreeHeaderInfos;
var
  I: Integer;
begin
  if FColumnInfos = nil then Exit;
  with FColumnInfos do
  begin
    for I := 0 to Count - 1 do
      if List^[I] <> nil then 
        Dispose(PdxColumnInfo(List^[I]));
  end;      
  FColumnInfos.Free;
  FColumnInfos := nil;
end;

procedure TCustomdxTreeListReportLink.CalcFontIndexes(AReportCells: TdxReportCells);
var
  F: TFont;
begin
  if FAbsoluteIndexes.Count = 0 then Exit;

  FBandFontIndex := AddFontToPool(BandFont);
  FEvenFontIndex := AddFontToPool(EvenFont);
  FGroupNodeFontIndex := AddFontToPool(GroupNodeFont);
  FFooterFontIndex := AddFontToPool(FooterFont);
  FHeaderFontIndex := AddFontToPool(HeaderFont);
  FOddFontIndex := AddFontToPool(OddFont);
  FPreviewFontIndex := AddFontToPool(PreviewFont);
  FRowFooterFontIndex := AddFontToPool(RowFooterFont);
  if IsHyperLinkColumnsExists then 
  begin
    F := TFont.Create;
    try
      F.Assign(Self.Font);
      F.Style := F.Style + [fsUnderline];
      FHyperLinkFontIndex := AddFontToPool(F);
      if (DrawMode = tldmOddEven) then 
      begin
        F.Assign(Self.OddFont);
        F.Style := F.Style + [fsUnderline];
        FOddHyperLinkFontIndex := AddFontToPool(F);
        F.Assign(Self.EvenFont);
        F.Style := F.Style + [fsUnderline];
        FEvenHyperLinkFontIndex := AddFontToPool(F);
      end;
    finally
      F.Free;
    end;  
  end;  
end;

procedure TCustomdxTreeListReportLink.GetColumnInfos(AAbsoluteIndex: Integer;
  ABandIndex, ARowIndex, AColIndex, ARowCount, AColCount: PInteger; 
  AIsFirstColumn, AIsLastColumn: PBoolean);
begin
  with PdxColumnInfo(FColumnInfos.List^[AAbsoluteIndex])^ do
  begin
    if ABandIndex <> nil then ABandIndex^ := BandIndex;
    if AColIndex <> nil then AColIndex^ := ColIndex;
    if AColCount <> nil then AColCount^ := ColCount;
    if ARowIndex <> nil then ARowIndex^ := RowIndex;
    if ARowCount <> nil then ARowCount^ := RowCount;
    if AIsFirstColumn <> nil then AIsFirstColumn^ := IsFirstColumn;
    if AIsLastColumn <> nil then AIsLastColumn^ := IsLastColumn;    
  end;
end;

procedure TCustomdxTreeListReportLink.GetCellRect(AAbsoluteIndex: Integer; 
  ACellType: TdxTreeListLinkCellType; var R: TRect);
begin
  with PdxColumnInfo(FColumnInfos.List^[AAbsoluteIndex])^ do
  begin
    R.Left := ColumnLeft;
    R.Right := ColumnRight;
    case ACellType of 
      tlstCell: 
        begin
          R.Top := CellTop;
          R.Bottom := CellBottom;
        end;
      tlstFooter:
        begin
          R.Top := FooterTop;
          R.Bottom := FooterBottom;
        end;
      tlstGroupFooter:
        begin
          R.Top := NodeFooterTop;
          R.Bottom := NodeFooterBottom;
        end;
      tlstHeader:
        begin
          R.Top := HeaderTop;
          R.Bottom := HeaderBottom;
        end;
    else
      R.Top := 0;
      R.Bottom := 0;
    end;
  end;  
end;

procedure TCustomdxTreeListReportLink.CalcAbsoluteIndexes;
var
  I, J, K, Ind: Integer;
begin
  with ExposeTreeList(CustomTreeList) do
  begin
    for I := 0 to GetBandCount - 1 do
      for J := 0 to GetHeaderRowCount(I) - 1 do
        for K := 0 to GetHeaderColCount(I, J) - 1 do
        begin
          Ind := GetHeaderAbsoluteIndex(I, J, K);
          FAbsoluteIndexes.Add(Pointer(Ind));
        end;  
  end;      
end;

procedure TCustomdxTreeListReportLink.MakeDelimiters(AReportCells: TdxReportCells;
  AHorzDelimiters, AVertDelimiters: TList);

  procedure IterateChildrens(ACell: TdxReportCell);
  var
    I: Integer;
    Cell: TdxReportCell;
  begin
    for I := 0 to ACell.CellCount - 1 do
    begin
      Cell := ACell[I];
      AVertDelimiters.Add(Pointer(Cell.AbsoluteOrigin.Y));
      if Cell.HasChildren then 
        IterateChildrens(Cell);
    end;
  end;
  
var
 I: Integer;
begin
  inherited MakeDelimiters(AReportCells, AHorzDelimiters, AVertDelimiters);

  if (AReportCells.Cells.CellCount > 0) or 
    (IsDrawHeadersOnEveryPage and (AReportCells.HeaderCells.CellCount > 0)) or
    (IsDrawFootersOnEveryPage and (AReportCells.FooterCells.CellCount > 0)) then
  begin
    {horz.}  
    if UseHorzDelimiters and (FHorzDelimiterCell <> nil) then
      for I := 0 to FHorzDelimiterCell.DataItemCount - 1 do
        with FHorzDelimiterCell.DataItems[I] do
        begin
          AHorzDelimiters.Add(Pointer(AbsoluteOrigin.X));
          AHorzDelimiters.Add(Pointer(AbsoluteOrigin.X + Width));
        end;
    
    {vert.}
    if UseVertDelimiters then 
    begin
      if AReportCells.Cells.CellCount > 0 then
        IterateChildrens(AReportCells.Cells);
      //if (IsDrawHeadersOnEveryPage and (AReportCells.HeaderCells.CellCount > 0)) then
      if not IsDrawHeadersOnEveryPage then
        IterateChildrens(AReportCells.HeaderCells);
      //if (IsDrawFootersOnEveryPage and (AReportCells.FooterCells.CellCount > 0)) then
      if not IsDrawFootersOnEveryPage then    
        IterateChildrens(AReportCells.FooterCells);
    end;    
  end
  else
  begin
    AHorzDelimiters.Add(Pointer(1));
    AVertDelimiters.Add(Pointer(1));
  end;
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawBandCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; ABand: TdxTreeListBand; var AText: string; 
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawBandCell) then
    FOnCustomDrawBandCell(Self, ACanvas, ABoundsRect, AClientRect, ABand, AText,
      AColor, AFont, ATextAlignX, ATextAlignY, ADone);
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode; 
  AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor; 
  AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawCell) then
    FOnCustomDrawCell(Self, ACanvas, ABoundsRect, AClientRect, ANode, AColumn, 
      AText, AColor, AFont, ATextAlignX, ATextAlignY, ADone);
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawFooterCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode; 
  AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor; 
  AFont: TFont; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawFooterCell) then
    FOnCustomDrawFooterCell(Self, ACanvas, ABoundsRect, AClientRect, ANode, 
      AColumn, AText, AColor, AFont, ATextAlignX, ATextAlignY, ADone);
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawHeaderCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; AColumn: TdxTreeListColumn; var AText: string;
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX;
  var ATextAlignY: TcxTextAlignY; var ASorted: TdxCellSortOrder; 
  var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawHeaderCell) then
    FOnCustomDrawHeaderCell(Self, ACanvas, ABoundsRect, AClientRect, AColumn,
      AText, AColor, AFont, ATextAlignX, ATextAlignY, ASorted, ADone);
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawPreviewCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode; var AText: string;
  var AColor: TColor; AFont: TFont; var ADone: Boolean);
var
  ATextColor, C: TColor;  
begin
  if Assigned(FOnCustomDrawPreviewCell) then
  begin
    ATextColor := AFont.Color;
    C := ATextColor;
    FOnCustomDrawPreviewCell(Self, ACanvas, ABoundsRect, AClientRect, ANode, AText,
      AColor, ATextColor, AFont, ADone);
    if C <> ATextColor then AFont.Color := ATextColor;
  end;    
end;

procedure TCustomdxTreeListReportLink.DoCustomDrawRowFooterCell(ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; ANode: TdxTreeListNode; 
  AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: string; 
  var AColor: TColor; AFont: TFont; var ATextAlignX: TcxTextAlignX; 
  var ATextAlignY: TcxTextAlignY; var ADone: Boolean);
begin
  if Assigned(FOnCustomDrawRowFooterCell) then
    FOnCustomDrawRowFooterCell(Self, ACanvas, ABoundsRect, AClientRect, ANode,
      AColumn, AFooterIndex, AText, AColor, AFont, ATextAlignX, ATextAlignY, ADone);
end;

procedure TCustomdxTreeListReportLink.ReadIsGraphicAsTextValueAssigned(AReader: TReader);
begin
  FIsGraphicAsTextValueAssigned := AReader.ReadBoolean;
end;

procedure TCustomdxTreeListReportLink.WriteIsGraphicAsTextValueAssigned(AWriter: TWriter);
begin
  AWriter.WriteBoolean(FIsGraphicAsTextValueAssigned);
end;

{ TdxTreeListReportLink }

procedure TdxTreeListReportLink.AssignValues(ADataItem: TAbstractdxReportCellData;
  ANode: TdxTreeListNode; AColumn, AReferenceColumn: TdxTreeListColumn);
begin
  if Assigned(FdxTreeListAssignDataProc) then
    FdxTreeListAssignDataProc(Self, ADataItem, TreeList, ANode, AColumn, AReferenceColumn);
end;

function TdxTreeListReportLink.GetDataClass(AColumn: TdxTreeListColumn; 
  ANode: TdxTreeListNode): TdxReportCellDataClass;
begin
  if Assigned(FdxTreeListColumnMapperProc) then
    Result := FdxTreeListColumnMapperProc(AColumn, Self, ANode)
  else
    Result := nil;
end;

procedure TdxTreeListReportLink.GetOwnedImageLists(AProc: TdxPSGetImageListProc);
begin
  inherited GetOwnedImageLists(AProc);
  AProc(TreeList.Images);
  AProc(TreeList.StateImages);
end;

function TdxTreeListReportLink.GetTreeList: TdxTreeList;
begin
  Result := TdxTreeList(Component)
end;

{ TdxTLReportLinkDesignWindow }

constructor TdxTLReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  HelpContext := dxhcTreeListReportLinkDesigner;
  inherited Create(AOwner);
  CreateControls;
  FillTreeListData;
  dxTLPreview.FullExpand;
  PageControl1.ActivePage := PageControl1.Pages[0];
  dxPSPopupMenuController.RegisterControl(lbxFonts);
end;

destructor TdxTLReportLinkDesignWindow.Destroy;
begin
  dxPSPopupMenuController.UnregisterControl(lbxFonts);
  inherited Destroy;
end;

procedure TdxTLReportLinkDesignWindow.FillTreeListData;

  procedure AddNodeData(ANode: TdxTreeListNode; const AText1, AText2, AText3: string; 
    AValue: Integer; AData: Integer);
  begin
    with ANode do
    begin
      Strings[0] := AText1;
      Strings[1] := AText2;
      Strings[2] := AText3;  
      Values[2] := IntToStr(AValue);
      Data := Pointer(AData);
      StateIndex := 1;    
      ImageIndex := 0;
      SelectedIndex := 0;
    end;  
  end;  
  
var
  Node: TdxTreeListNode;
begin
  dxTLPreview.Bands[0].Caption := cxGetResourceString(@sdxTLBand);
  dxTLPreview.Columns[0].Caption := cxGetResourceString(@sdxTLColumnName);
  dxTLPreview.Columns[1].Caption := cxGetResourceString(@sdxTLColumnAxisymmetric);
  dxTLPreview.Columns[2].Caption := cxGetResourceString(@sdxTLColumnItemShape);
  
  dxTLPreview.ClearNodes;       
  Node := dxTLPreview.Add;
  AddNodeData(Node, sdxRegular, dxBoolToStr(True), cxGetResourceString(@sdxItemShapeAsText), -1, 0);
  AddNodeData(Node.AddChild, cxGetResourceString(@sdxItem1Name), dxBoolToStr(True), cxGetResourceString(@sdxItemShapeAsText), 2, 1);
  AddNodeData(Node.AddChild, cxGetResourceString(@sdxItem2Name), dxBoolToStr(True), cxGetResourceString(@sdxItemShapeAsText), 3, 2);
  AddNodeData(Node.AddChild, cxGetResourceString(@sdxItem3Name), dxBoolToStr(True), cxGetResourceString(@sdxItemShapeAsText), 4, 3);
  AddNodeData(Node.AddChild, cxGetResourceString(@sdxItem4Name), dxBoolToStr(False), cxGetResourceString(@sdxItemShapeAsText), 6, 4);
    
  Node := dxTLPreview.Add;
  AddNodeData(Node, cxGetResourceString(@sdxIrregular), dxBoolToStr(False), cxGetResourceString(@sdxItemShapeAsText), -1, 5);  
  AddNodeData(Node.AddChild, cxGetResourceString(@sdxItem5Name), dxBoolToStr(False), cxGetResourceString(@sdxItemShapeAsText), 5, 6);
end;

function TdxTLReportLinkDesignWindow.GetReportLink: TCustomdxTreeListReportLink;
begin
  Result := inherited ReportLink as TCustomdxTreeListReportLink;
end;

procedure TdxTLReportLinkDesignWindow.pbxPreviewPaint(Sender: TObject);
begin
  with TdxPSPaintPanel(Sender) do 
    PaintPreview(Canvas, ClientRect);
end;

procedure FrameRectColor(DC: HDC; const R: TRect; AColor: TColor);
var
  Brush: HBRUSH;
begin
  Brush := CreateSolidBrush(ColorToRGB(AColor));
  FrameRect(DC, R, Brush);
  DeleteObject(Brush);
end;

procedure FillRectColor(DC: HDC; const R: TRect; AColor: TColor);
var
  Brush: HBRUSH;
begin
  Brush := CreateSolidBrush(ColorToRGB(AColor));
  FillRect(DC, R, Brush);
  DeleteObject(Brush);
end;

const
  Alignments: array[TAlignment] of UINT = (DT_LEFT, DT_RIGHT, DT_CENTER);

procedure DrawTextRect(ACanvas: TCanvas; R: TRect; const AText: string; 
  AAlignment: TAlignment; AColor: TColor);
var
  DC: HDC;  
begin
  DC := ACanvas.Handle;
  FillRectColor(DC, R, AColor);
  InflateRect(R, -2, 0);  
  SetBkMode(DC, Windows.TRANSPARENT);
  DrawText(DC, PChar(AText), Length(AText), R, DT_SINGLELINE or DT_VCENTER or Alignments[AAlignment]);
end;  

procedure DrawFooterRect(ACanvas: TCanvas; R: TRect; const AText: string; 
  AAlignment: TAlignment; ALookAndFeel: TdxLookAndFeel; ABorderColor, AColor: TColor);
var
  DC: HDC;
begin
  DC := ACanvas.Handle;
  case ALookAndFeel of
    lfStandard, lfFlat:
      DrawEdge(DC, R, BDR_SUNKENOUTER, BF_RECT or BF_SOFT);
    lfUltraFlat:
      FrameRectColor(DC, R, ABorderColor);
  end;    
  InflateRect(R, -1, -1);
  DrawTextRect(ACanvas, R, AText, AAlignment, AColor);
end;

procedure DrawHeaderRect(ACanvas: TCanvas; R: TRect; const AText: string; 
  AAlignment: TAlignment; ALookAndFeel: TdxLookAndFeel; ABorderColor, AColor: TColor);
var
  DC: HDC;
begin
  DC := ACanvas.Handle;
  case ALookAndFeel of
    lfStandard:
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT or BF_TOP);  
        DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
        Dec(R.Right); Dec(R.Bottom);        
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_RIGHT or BF_BOTTOM);
      end;
    lfFlat:
      begin
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_LEFT or BF_TOP);  
        DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RIGHT or BF_BOTTOM);
      end;  
    lfUltraFlat:
      begin
        Dec(R.Left); Dec(R.Top);
        FrameRectColor(DC, R, ABorderColor);  
      end;
  end;    
  InflateRect(R, -1, -1);
  DrawTextRect(ACanvas, R, AText, AAlignment, AColor);
end;

procedure TdxTLReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
var
  DC: HDC;
  R2: TRect;
  DrawInfo: TdxGridDrawInfo;
begin
  inherited;
  DC := ACanvas.Handle;
  Inc(R.Left);
  Inc(R.Top);
  dxTLPreview.PaintTo(DC, R.Left, R.Top);

  dxTLPreview.CalcDrawInfo(DrawInfo);
  try
    R2 := DrawInfo.EmptyRectBottom;
    if not IsRectEmpty(R2) then 
    begin
      OffsetRect(R2, R.Left, R.Top);
      FillRectColor(DC, R2, clWindow);
    end;  
  finally
    dxTLPreview.FreeDrawInfo(DrawInfo);
  end;
  
  Dec(R.Left);
  Dec(R.Top);
  FrameRectColor(DC, R, ReportLink.GridLineColor);
end;

procedure TdxTLReportLinkDesignWindow.SetupPreview;
begin
  if ReportLink.Component <> nil then
    with dxTLPreview do
    begin
      if ReportLink.IsDBGridLink then
      begin
        Images := nil;
        StateImages := nil;
      end;
      PaintStyle := ReportLink.FPaintStyle;
      FullExpand;
    end;
end;

procedure TdxTLReportLinkDesignWindow.CreateControls;

  function CreateColorCombo(AParent: TWinControl; AHost: TControl;
    ATag: Integer; AAutoColor: TColor; ALabel: TLabel): TdxPSColorCombo;
  begin
    Result := TdxPSColorCombo.Create(Self);
    with TdxPSColorCombo(Result) do
    begin
      BoundsRect := AHost.BoundsRect;
      Tag := ATag;
      Parent := AParent;
      ColorTypes := [ctPure];
      ShowColorName := True;
      ShowAutoColor := True;
      AutoColor := AAutoColor;
      OnChange := ccbxColorChange;
    end;
    ALabel.FocusControl := Result;
    AHost.Visible := False;
  end;
  
begin
  ccbxColor := 
    CreateColorCombo(gbxTransparent, bvlColorHolder, 0, dxDefaultColor, lblColor);
  ccbxEvenColor := 
    CreateColorCombo(gbxTransparent, bvlEvenColorHolder, 1, dxDefaultColor, lblEvenColor);
  ccbxPreviewColor := 
    CreateColorCombo(gbxTransparent, bvlPreviewColorHolder, 2, dxDefaultColor, lblPreviewColor);
  ccbxBandColor := 
    CreateColorCombo(gbxFixedTransparent, bvlBandColorHolder, 3, dxDefaultFixedColor, lblBandColor);
  
  ccbxHeaderColor := 
    CreateColorCombo(gbxFixedTransparent, bvlHeaderColorHolder, 5, dxDefaultFixedColor, lblHeaderColor);
  ccbxGroupNodeColor := 
    CreateColorCombo(gbxFixedTransparent, bvlGroupNodeColorHolder, 4, dxDefaultFixedColor, lblGroupNodeColor);
  ccbxRowFooterColor := 
    CreateColorCombo(gbxFixedTransparent, bvlRowFooterColorHolder, 6, dxDefaultFixedColor, lblRowFooterColor);

  ccbxGridLineColor := 
    CreateColorCombo(tshColors, bvlGridLineColorHolder, 7, dxDefaultGridLineColor, lblGridLineColor);
  ccbxGridLineColor.TabOrder := ccbxGridLineColor.Parent.ControlCount - 1;

  ccbxTreeLineColor := 
    CreateColorCombo(tshColors, bvlTreeLineColorHolder, 8, dxDefaultTreeLineColor, lblTreeLineColor);
  ccbxTreeLineColor.TabOrder := ccbxTreeLineColor.Parent.ControlCount - 1;
  
  seExpandLevel := TdxPSSpinEdit.Create(Self);
  with TdxPSSpinEdit(seExpandLevel) do
  begin
    BoundsRect := bvlExpandLevelHolder.BoundsRect;
    MinValue := -1;
    MaxValue := 100;
    Flat := False;
    Parent := tshBehaviors;
    TabOrder := chbxAutoNodesExpand.TabOrder + 1;
    OnChange := ExpandLevelChange;
  end;
  lblExpandLevel.FocusControl := seExpandLevel;

  sePreviewLineCount := TdxPSSpinEdit.Create(Self);
  with TdxPSSpinEdit(sePreviewLineCount) do
  begin
    BoundsRect := bvlPreviewLineCountHolder.BoundsRect;
    MinValue := 0;
    MaxValue := 100;
    Flat := False;
    Parent := tshPreview;
    TabOrder := chbxAutoCalcPreviewLines.TabOrder + 1;
    OnChange := PreviewLineCountChange;
  end;
  lblPreviewLineCount.FocusControl := sePreviewLineCount;

  FPreviewBox := TdxPSPaintPanel.Create(Self);
  with TdxPSPaintPanel(FPreviewBox) do
  begin
    Parent := pnlPreview;
    Height := dxTLPreview.Height + 1;
    Width := dxTLPreview.Width + 1;
    Left := (Parent.Width - Width) div 2;
    Top := (Parent.Height - Height) div 2;
    EdgeInner := esNone;
    EdgeOuter := esNone;
    OnPaint := pbxPreviewPaint;
  end;
end;

{$IFDEF DELPHI7}
function TdxTLReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := pnlPreview;
end;
{$ENDIF}

procedure TdxTLReportLinkDesignWindow.LoadStrings;
begin
  inherited LoadStrings;
  tshOptions.Caption := cxGetResourceString(@sdxOptions);
  tshFonts.Caption := cxGetResourceString(@sdxFonts);
  tshColors.Caption := cxGetResourceString(@sdxColors);
  tshBehaviors.Caption := cxGetResourceString(@sdxBehaviors);
  tshPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblPreviewWindow.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  lblDrawMode.Caption := cxGetResourceString(@sdxDrawMode);
  with cbxDrawMode.Items do 
  begin
    BeginUpdate;
    try
      Clear;
      AddObject(cxGetResourceString(@sdxDrawModeStrict), TObject(tldmStrict));
      AddObject(cxGetResourceString(@sdxDrawModeOddEven), TObject(tldmOddEven)); 
      AddObject(cxGetResourceString(@sdxDrawModeBorrow), TObject(tldmBorrowSource));
    finally
      EndUpdate;
    end;
  end;
  
  lblShow.Caption := cxGetResourceString(@sdxShow);

  chbxShowExpandButtons.Caption := cxGetResourceString(@sdxExpandButtons);
  chbxShowTreeLines.Caption := cxGetResourceString(@sdxTreeLines);
  
  chbxShowGrid.Caption := cxGetResourceString(@sdxGrid);
  chbxShowNodeGrid.Caption := cxGetResourceString(@sdxNodesGrid);
//  chbxShowGroupFooterGrid.Caption := cxGetResourceString(@sdxGroupFooterGrid);

  chbxShowImages.Caption := cxGetResourceString(@sdxImages);
  chbxShowStateImages.Caption := cxGetResourceString(@sdxStateImages);
  
  chbxBandsOnEveryPage.Caption := cxGetResourceString(@sdxBandsOnEveryPage);
  chbxHeadersOnEveryPage.Caption := cxGetResourceString(@sdxHeadersOnEveryPage);
  chbxFootersOnEveryPage.Caption := cxGetResourceString(@sdxFootersOnEveryPage);
  chbxAutoNodesExpand.Caption := cxGetResourceString(@sdxAutoNodesExpand);
  chbxOnlySelected.Caption := cxGetResourceString(@sdxOnlySelected);
  chbxExtendedSelect.Caption := cxGetResourceString(@sdxExtendedSelect);
  lblExpandLevel.Caption := cxGetResourceString(@sdxExpandLevel);
  lblPreview.Caption := DropAmpersand(cxGetResourceString(@sdxPreview));

  stTransparent.Caption := ' ' + cxGetResourceString(@sdxTransparent) + ' ';
  stFixedTransparent.Caption := ' ' + cxGetResourceString(@sdxFixedTransparent) + ' ';

  lblColor.Caption := cxGetResourceString(@sdxColor);
  lblEvenColor.Caption := cxGetResourceString(@sdxEvenColor);
  lblPreviewColor.Caption := cxGetResourceString(@sdxPreviewColor);
  
  lblBandColor.Caption := cxGetResourceString(@sdxBandColor);
  lblHeaderColor.Caption := cxGetResourceString(@sdxHeaderColor);
  lblRowFooterColor.Caption := cxGetResourceString(@sdxGroupFooterColor);
  lblGroupNodeColor.Caption := cxGetResourceString(@sdxGroupNodeColor);
  lblGridLineColor.Caption := cxGetResourceString(@sdxGridLinesColor);
  lblTreeLineColor.Caption := cxGetResourceString(@sdxTreeLinesColor);
  
  with lbxFonts.Items do 
  begin
    BeginUpdate;
    try
      Clear;
      Add(cxGetResourceString(@sdxBandFont));
      Add(cxGetResourceString(@sdxFont));
      Add(cxGetResourceString(@sdxOddFont));
      Add(cxGetResourceString(@sdxEvenFont));
      Add(cxGetResourceString(@sdxGroupNodeFont));
      Add(cxGetResourceString(@sdxFooterFont));
      Add(cxGetResourceString(@sdxHeaderFont));
      Add(cxGetResourceString(@sdxPreviewFont));
      Add(cxGetResourceString(@sdxGroupFooterFont));
    finally
      EndUpdate;
    end;
  end;  

  btnChangeFont.Caption := cxGetResourceString(@sdxBtnChangeFont);
  miChangeFont.Caption := cxGetResourceString(@sdxBtnChangeFont);
  
  chbxShowBands.Caption := cxGetResourceString(@sdxBands);
  chbxShowHeaders.Caption := cxGetResourceString(@sdxHeaders);
  chbxShowFooters.Caption := cxGetResourceString(@sdxFooters);
  chbxShowGroupFooters.Caption := cxGetResourceString(@sdxGroupFooters);
  chbxShowPreview.Caption := DropAmpersand(cxGetResourceString(@sdxVisible));
  chbxAutoCalcPreviewLines.Caption := cxGetResourceString(@sdxAutoCalcPreviewLineCount);
  lblPreviewLineCount.Caption := cxGetResourceString(@sdxPreviewLineCount);
 
  lblOnEveryPage.Caption := cxGetResourceString(@sdxOnEveryPage);
  lblSelection.Caption := cxGetResourceString(@sdxSelection);
  lblExpanding.Caption := cxGetResourceString(@sdxExpanding);
  lblLookAndFeel.Caption := cxGetResourceString(@sdxLookAndFeel);
  lblRefinements.Caption := cxGetResourceString(@sdxRefinements);
  
  chbxUse3DEffects.Caption := cxGetResourceString(@sdxUse3DEffects);
  chbxUseSoft3D.Caption := cxGetResourceString(@sdxSoft3D);
  
  chbxTransparentColumnGraphic.Caption := cxGetResourceString(@sdxTransparentColumnGraphics);
  chbxDisplayGraphicsAsText.Caption := cxGetResourceString(@sdxDisplayGraphicsAsText);
  chbxFlatCheckMarks.Caption := cxGetResourceString(@sdxFlatCheckMarks);
  chbxCheckMarksAsText.Caption := cxGetResourceString(@sdxCheckMarksAsText);
end;

procedure TdxTLReportLinkDesignWindow.CMDialogChar(var Msg: TCMDialogChar);
var
  I: Integer;
begin
  inherited;
  with PageControl1 do
    for I := 0 to PageCount - 1 do
      if IsAccel(Msg.CharCode, Pages[I].Caption) then
      begin
        Msg.Result := 1;
        ActivePage := Pages[I];
        Exit;
      end;
end;
                         
procedure TdxTLReportLinkDesignWindow.UpdateControlsState;
begin
  inherited;
  
  if ReportLink.OddEvenMode then
    lblColor.Caption := cxGetResourceString(@sdxOddColor)
  else  
    lblColor.Caption := cxGetResourceString(@sdxColor);
    
  chbxBandsOnEveryPage.Checked := ReportLink.BandsOnEveryPage;
  chbxBandsOnEveryPage.Enabled := not ReportLink.IsAggregated;
  
  chbxHeadersOnEveryPage.Enabled := not ReportLink.IsAggregated and chbxBandsOnEveryPage.Checked;
  chbxHeadersOnEveryPage.Checked := ReportLink.HeadersOnEveryPage;
                                                                
  chbxFootersOnEveryPage.Enabled := not ReportLink.IsAggregated;
  chbxFootersOnEveryPage.Checked := ReportLink.FootersOnEveryPage;

//  chbxShowTreeLines.Enabled := not ReportLink.IsDBGridLink;  
  if ReportLink.CustomTreeList <> nil then
    with ExposeTreeList(ReportLink.CustomTreeList) do
    begin
      lblTreeLineColor.Visible := PaintStyle = psStandard;
      ccbxTreeLineColor.Visible := PaintStyle = psStandard;
      chbxShowTreeLines.Enabled := PaintStyle = psStandard;
    end;
    
  chbxOnlySelected.Checked := ReportLink.OnlySelected;
  chbxAutoNodesExpand.Checked := ReportLink.AutoNodesExpand;

  chbxExtendedSelect.Enabled := chbxOnlySelected.Checked;
  seExpandLevel.Visible := ReportLink.IsTreeListLink;
  lblExpandLevel.Visible := seExpandLevel.Visible;
  if seExpandLevel.Visible then
  begin
    seExpandLevel.Enabled := chbxAutoNodesExpand.Checked and not chbxOnlySelected.Checked;
    lblExpandLevel.Enabled := seExpandLevel.Enabled;
  end;

  //bvlShowImages.Visible := not ReportLink.IsDBGridLink;
  chbxShowStateImages.Enabled := not ReportLink.IsDBGridLink;
  chbxShowImages.Enabled := not ReportLink.IsDBGridLink;  
  
  chbxAutoCalcPreviewLines.Enabled := ReportLink.ShowPreview;
  sePreviewLineCount.Enabled := ReportLink.ShowPreview and not ReportLink.AutoCalcPreviewLines;
  lblPreviewLineCount.Enabled := sePreviewLineCount.Enabled;
  
  chbxShowNodeGrid.Enabled := chbxShowGrid.Checked;
  //chbxShowGroupFooterGrid.Enabled := chbxShowGrid.Checked;
  
  chbxUseSoft3D.Enabled := chbxUse3DEffects.Checked;
  
  ccbxColor.Enabled := not chbxTransparent.Checked;
  lblColor.Enabled := ccbxColor.Enabled;
  ccbxEvenColor.Enabled := not chbxTransparent.Checked and ReportLink.OddEvenMode;
  lblEvenColor.Enabled := ccbxEvenColor.Enabled;
  ccbxPreviewColor.Enabled := not chbxTransparent.Checked and not ReportLink.OddEvenMode;
  lblPreviewColor.Enabled := ccbxPreviewColor.Enabled;

  ccbxBandColor.Enabled := not chbxFixedTransparent.Checked;
  lblBandColor.Enabled := ccbxBandColor.Enabled;
  ccbxGroupNodeColor.Enabled := not chbxFixedTransparent.Checked;
  lblGroupNodeColor.Enabled := ccbxGroupNodeColor.Enabled;

  ccbxHeaderColor.Enabled := not chbxFixedTransparent.Checked;
  lblHeaderColor.Enabled := ccbxHeaderColor.Enabled;
  ccbxRowFooterColor.Enabled := not chbxFixedTransparent.Checked;
  lblRowFooterColor.Enabled := ccbxRowFooterColor.Enabled;

  if ReportLink.Use3DEffects then
    dxTLPreview.LookAndFeel := TdxLookAndFeel(ReportLink.UseSoft3D)
  else
    dxTLPreview.LookAndFeel := lfFlat;

   
  dxTLPreview.HandleNeeded;
  btnChangeFont.Enabled := IsChangeFontEnabled;
  lbxFonts.Perform(LB_SETHORIZONTALEXTENT, GetMaxWidth, 0);
end;

function TdxTLReportLinkDesignWindow.IsChangeFontEnabled: Boolean;
var
  I: Integer;
begin
  if ReportLink.OddEvenMode then 
    Result := lbxFonts.SelCount > 0
  else  
  begin
    Result := True;  
    for I := 0 to lbxFonts.Items.Count - 1 do 
      if lbxFonts.Selected[I] and not (I in [2, 3]) then Exit;
    Result := False;
  end;
end;

function TdxTLReportLinkDesignWindow.IsDisableIndex(AIndex: Integer): Boolean;
begin
  Result := not ReportLink.OddEvenMode and (AIndex in [2, 3]);
end;

procedure TdxTLReportLinkDesignWindow.DoInitialize;
begin
  inherited;
  with lbxFonts do 
  begin
    Canvas.Font := Font;
    ItemHeight := 1 + lbxFonts.Canvas.TextHeight('Wg') + 2;
    Height := 4{border} + GetSystemMetrics(SM_CYHSCROLL) + Items.Count * ItemHeight;
  end;  
  btnChangeFont.Top := lbxFonts.Top + lbxFonts.Height + 6;  
  
  with ReportLink do 
  begin
    chbxShowBands.Checked := ShowBands;
    chbxShowHeaders.Checked := ShowHeaders;
    chbxShowFooters.Checked := ShowFooters;    
    chbxShowGroupFooters.Checked := ShowRowFooters;        
    chbxShowPreview.Checked := ShowPreview;
    chbxAutoCalcPreviewLines.Checked := AutoCalcPreviewLines;
    TdxPSSpinEdit(sePreviewLineCount).Enabled := ShowPreview and not AutoCalcPreviewLines;
    TdxPSSpinEdit(sePreviewLineCount).MinValue := -Byte(AutoCalcPreviewLines);
    TdxPSSpinEdit(sePreviewLineCount).Value := PreviewLineCount;
    
    chbxShowGrid.Checked := ShowGrid;
    chbxShowNodeGrid.Checked := ShowPreviewGrid;
    //chbxShowGroupFooterGrid.Checked := ShowRowFooterGrid;    

    chbxShowImages.Checked := ShowImages;
    chbxShowStateImages.Checked := ShowStateImages;    

    cbxDrawMode.ItemIndex := Integer(DrawMode);
    
    if OddEvenMode then
      lblColor.Caption := cxGetResourceString(@sdxOddColor);

    chbxTransparent.Checked := Transparent;
    chbxFixedTransparent.Checked := FixedTransparent;
    
    TdxPSColorCombo(ccbxColor).ColorValue := ReportLink.Color;
    TdxPSColorCombo(ccbxEvenColor).ColorValue := EvenColor;
    TdxPSColorCombo(ccbxPreviewColor).ColorValue := PreviewColor;
    TdxPSColorCombo(ccbxBandColor).ColorValue := BandColor;
    TdxPSColorCombo(ccbxHeaderColor).ColorValue := HeaderColor;
    TdxPSColorCombo(ccbxGridLineColor).ColorValue := GridLineColor;
    TdxPSColorCombo(ccbxGroupNodeColor).ColorValue := GroupNodeColor;
    TdxPSColorCombo(ccbxRowFooterColor).ColorValue := RowFooterColor;

    TdxPSSpinEdit(seExpandLevel).Enabled := not chbxOnlySelected.Checked;
    TdxPSSpinEdit(seExpandLevel).Value := ExpandLevel;
    
    chbxOnlySelected.Checked := OnlySelected;
    chbxExtendedSelect.Checked := ExtendedSelect;
    
    chbxUse3DEffects.Checked := Use3DEffects;
    chbxUseSoft3D.Checked := UseSoft3D;    
   
    chbxTransparentColumnGraphic.Checked := TransparentColumnGraphics;
    chbxDisplayGraphicsAsText.Checked := GraphicsAsText;

    chbxFlatCheckMarks.Checked := FlatCheckMarks;
    chbxCheckMarksAsText.Checked := CheckMarksAsText;

    chbxShowExpandButtons.Checked := ShowExpandButtons;
    chbxShowTreeLines.Checked := ShowTreeLines;
  end;
  SetupPreview;
  UpdatePreview;
  
  lbxFonts.Invalidate;
end;

procedure TdxTLReportLinkDesignWindow.ExpandLevelChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.ExpandLevel := TdxPSSpinEdit(Sender).AsInteger;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.PreviewLineCountChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PreviewLineCount := TdxPSSpinEdit(Sender).AsInteger;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.UpdatePreview;
var
  R: TRect;
begin
  inherited;
  R := dxTLPreview.BoundsRect;
  InflateRect(R, 1, 1);
  Dec(R.Right);
  if ReportLink.Use3DEffects and not ReportLink.UseSoft3D then 
    Dec(R.Bottom); 
    
  dxTLPreview.BeginUpdate;
  try
    if ReportLink.FixedTransparent then
    begin
      dxTLPreview.BandColor := clWindow;
      dxTLPreview.HeaderColor := clWindow;
      dxTLPreview.RowFooterColor := clWindow;
      dxTLPreview.GroupNodeColor := clWindow;
    end
    else
    begin
      dxTLPreview.BandColor := ReportLink.BandColor;
      dxTLPreview.GroupNodeColor := ReportLink.GroupNodeColor;
      dxTLPreview.HeaderColor := ReportLink.HeaderColor;
      dxTLPreview.RowFooterColor := ReportLink.RowFooterColor;
    end;
    
    if ReportLink.Transparent then
      dxTLPreview.Color := clWindow
    else
      dxTLPreview.Color := ReportLink.Color;

    dxTLPreview.GridLineColor := ReportLink.GridLineColor;
    dxTLPreview.TreeLineColor := ReportLink.TreeLineColor;    

    dxTLPreview.BandFont := ReportLink.BandFont;
    dxTLPreview.BandFont.Size := 8;
    dxTLPreview.HeaderFont := ReportLink.HeaderFont;
    dxTLPreview.HeaderFont.Size := 8;    
    dxTLPreview.Font := ReportLink.Font;
    dxTLPreview.Font.Size := 8;        
    dxTLPreview.PreviewFont := ReportLink.PreviewFont;
    dxTLPreview.PreviewFont.Size := 8;
    
    dxTLPreview.ShowGrid := ReportLink.ShowGrid;
    dxTLPreview.ShowPreviewGrid := ReportLink.ShowPreviewGrid;
    dxTLPreview.ShowBands := ReportLink.ShowBands;
    dxTLPreview.ShowHeader := ReportLink.ShowHeaders;
    dxTLPreview.ShowFooter := ReportLink.ShowFooters;
    dxTLPreview.ShowRowFooter := ReportLink.ShowRowFooters;
    
    dxTLPreview.ShowButtons := ReportLink.ShowExpandButtons;
    dxTLPreview.ShowLines := ReportLink.ShowTreeLines;
    if dxTLPreview.PaintStyle = psOutlook then 
    begin
      if ReportLink.Use3DEffects then 
      begin
        if ReportLink.UseSoft3D then 
          dxTLPreview.LookAndFeel := lfFlat
        else  
          dxTLPreview.LookAndFeel := lfStandard
      end    
      else
        dxTLPreview.LookAndFeel := lfUltraFlat;//ExposeTreeList(ReportLink.CustomTreeList).LookAndFeel;
    end;  
    
    
    if ReportLink.ShowPreview then
      dxTLPreview.Options := dxTLPreview.Options + [aoPreview]
    else
      dxTLPreview.Options := dxTLPreview.Options - [aoPreview];
      
    if tlpoImages in ReportLink.Options then
      dxTLPreview.Images := ilTLImages
    else
      dxTLPreview.Images := nil;
      
    if tlpoStateImages in ReportLink.Options then
      dxTLPreview.StateImages := ilTLImages
    else
      dxTLPreview.StateImages := nil;
      
    dxTLPreviewColumn3.Border3D := not ReportLink.FlatCheckMarks;
  finally
    dxTLPreview.EndUpdate;
  end;
  FPreviewBox.Invalidate;
end;

procedure TdxTLReportLinkDesignWindow.SetColorByTag(ATag: Integer; AColor: TColor);
begin
  with ReportLink do 
    case ATag of
      0: Color := AColor;
      1: EvenColor := AColor;
      2: PreviewColor := AColor;
      3: BandColor := AColor;
      4: GroupNodeColor := AColor;
      5: HeaderColor := AColor;
      6: RowFooterColor := AColor;
      7: GridLineColor := AColor;
      8: TreeLineColor := AColor;      
    end;
end;

procedure TdxTLReportLinkDesignWindow.ccbxColorChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with TdxPSColorCombo(Sender) do 
    SetColorByTag(Tag, ColorValue);
  UpdatePreview;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.FontClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  if ReportLink.OddEvenMode or (lbxFonts.ItemIndex <> 2) then
    DoChangeFont(lbxFonts.ItemIndex);
end;

procedure TdxTLReportLinkDesignWindow.DoChangeFont(AIndex: Integer);
var
  I: Integer;
begin
  with dxPSGlbl.FontDialog do 
  begin
    Font := GetFontByIndex(AIndex);
    if Execute then
    begin
      for I := 0 to lbxFonts.Items.Count - 1 do
        if lbxFonts.Selected[I] then 
          GetFontByIndex(I).Assign(Font);
        
      lbxFonts.Refresh;
      UpdatePreview;
      Modified := True;
    end;
  end;  
end;

procedure TdxTLReportLinkDesignWindow.btnChangeFontClick(Sender: TObject);
begin
  if lbxFonts.SelCount > 0 then DoChangeFont(lbxFonts.ItemIndex);
end;

procedure TdxTLReportLinkDesignWindow.pmChangeFontPopup(Sender: TObject);
begin
  miChangeFont.Enabled := btnChangeFont.Enabled;
end;

procedure TdxTLReportLinkDesignWindow.chbxTransparentClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  
  case TCheckBox(Sender).Tag of
    0: ReportLink.Transparent := TCheckBox(Sender).checked;
    1: ReportLink.FixedTransparent := TCheckBox(Sender).checked;
  end;
  UpdatePreview;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.stTransparentClick(Sender: TObject);
begin
  if chbxTransparent.CanFocus then  ActiveControl := chbxTransparent;
  chbxTransparent.Checked := not chbxTransparent.Checked;
end;

procedure TdxTLReportLinkDesignWindow.stFixedTransparentClick(Sender: TObject);
begin
  if chbxFixedTransparent.CanFocus then ActiveControl := chbxFixedTransparent;
  chbxFixedTransparent.Checked := not chbxFixedTransparent.Checked;
end;

procedure TdxTLReportLinkDesignWindow.chbxHeadersOnEveryPageClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.HeadersOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.chbxBandsOnEveryPageClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.BandsOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.chbxFootersOnEveryPageClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.FootersOnEveryPage := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.chbxAutoNodesExpandClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.AutoNodesExpand := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.chbxOnlySelectedClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.OnlySelected := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.chbxExtendedSelectClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.ExtendedSelect := TCheckBox(Sender).Checked;
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.lblColorClick(Sender: TObject);
begin
  ActiveControl := TLabel(Sender).FocusControl;
  TCustomComboBox(ActiveControl).DroppedDown := True;
end;

procedure TdxTLReportLinkDesignWindow.lblExpandLevelClick(Sender: TObject);
begin
  if TLabel(Sender).FocusControl <> nil then
    ActiveControl := TLabel(Sender).FocusControl;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewGetFooterCellText(
  Sender: TObject; ANode: TdxTreeListNode; AColumn, AFooterIndex: Integer;
  var AText: string);
begin
  if AFooterIndex = -1 then
    AText := Format(cxGetResourceString(@sdxCountIs), [6])
  else
    AText := Format(cxGetResourceString(@sdxCountIs), [ANode.Parent.Count]);
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewGetPreviewText(
  Sender: TObject; ANode: TdxTreeListNode; var AText: string);
begin
  AText := GetDesignerString(Integer(ANode.Data));
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewIsExistFooterCell(
  Sender: TObject; AColumn: Integer; var AExist: Boolean);
begin
  AExist := AColumn = 0;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewIsExistRowFooterCell(
  Sender: TObject; ANode: TdxTreeListNode; AColumn, AFooterIndex: Integer;
  var AExist: Boolean);
begin
  AExist := AColumn = 0;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewIsLevelFooter(Sender: TObject;
  ALevel: Integer; var AExist: Boolean);
begin
  AExist := True;
end;

procedure TdxTLReportLinkDesignWindow.FontsMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
const
  FLastIndex: Integer = -1;
var
  W: Integer;
  S: string;
  AIndex: Integer;
begin
  AIndex := lbxFonts.ItemAtPos(Point(X, Y), True);
  if (AIndex = -1) or (AIndex = FLastIndex) then Exit;
  lbxFonts.Hint := '';
  Application.CancelHint;
  S := GetFontInfoText(AIndex);
  W := lbxFonts.Canvas.TextWidth(S);
  if W > lbxFonts.Width - lbxFonts.Canvas.TextWidth(lbxFonts.Items[AIndex]) then
  begin
    lbxFonts.Hint := S;
    FLastIndex := AIndex;
  end;
end;

procedure TdxTLReportLinkDesignWindow.FontsKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  ItemIndex: Integer;  
begin
  if (ReportLink.DrawMode <> tldmOddEven) and (Key in [VK_UP, VK_DOWN]) then 
  begin
    ItemIndex := TListBox(Sender).ItemIndex;
    case Key of
      VK_UP: 
        if IsDisableIndex(ItemIndex - 1) then 
          while IsDisableIndex(ItemIndex - 1) do Dec(ItemIndex);
      VK_DOWN:
        if IsDisableIndex(ItemIndex + 1) then 
          while IsDisableIndex(ItemIndex + 1) do Inc(ItemIndex);
    end;
    TListBox(Sender).ItemIndex := ItemIndex;
  end;  
  if (Key = VK_RETURN) and (ssCtrl in Shift) then
    btnChangeFont.Click;
end;

function TdxTLReportLinkDesignWindow.GetFontByIndex(AIndex: Integer): TFont;
begin
  Result := nil;
  with ReportLink do 
    case AIndex of
      0: Result := BandFont;
      1: Result := Font;
      2: Result := OddFont;    
      3: Result := EvenFont;
      4: Result := GroupNodeFont;
      5: Result := FooterFont;
      6: Result := HeaderFont;
      7: Result := PreviewFont;
      8: Result := RowFooterFont;
    end;
end;

procedure TdxTLReportLinkDesignWindow.lbxFontsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);

  function GetMaxLength: Integer;
  var
    I, V: Integer;
  begin
    Result := 0;
    with TListBox(Control) do
      for I := 0 to Items.Count - 1 do
      begin
        V := Canvas.TextWidth(Items[I]);
        if V > Result then Result := V;
      end;
    Inc(Result, 8);
  end;

  function GetFontColor(AIndex: Integer): TColor;
  begin
    if IsDisableIndex(AIndex) then
      Result := ColorToRGB(clBtnFace)
    else
      Result := ColorToRGB(clWindowText);//GetFontByIndex(AIndex).Color;
  end;

const
  FirstEntry: Boolean = True;
  MaxLength: Integer = 0;
var
  R: TRect;
  BrushColor, FontColor: TColor;
  S: string;
begin
  if FirstEntry then
  begin
    MaxLength := GetMaxLength;
    FirstEntry := False;
  end;
  
  with TListBox(Control) do
  begin
    BrushColor := Canvas.Brush.Color;
    if IsDisableIndex(Index) then
      Canvas.Brush.Color := ColorToRGB(clWindow);
      
    with Rect do 
      R := Classes.Rect(Left, Top, Left + MaxLength, Bottom);
      
    FontColor := Canvas.Font.Color;
    if not (odSelected in State) or IsDisableIndex(Index) then 
      Canvas.Font.Color := GetFontColor(Index);
      
    Canvas.TextRect(R, R.Left + 2, R.Top + 2, Items[Index]);
    R.Left := R.Right;
    Inc(R.Right);
    Canvas.Brush.Color := ColorToRGB(clBtnShadow);
    Canvas.FrameRect(R);
    if IsDisableIndex(Index) then    
      Canvas.Brush.Color := ColorToRGB(clWindow)
    else
      Canvas.Brush.Color := BrushColor;
    R.Left := R.Right;
    R.Right := Rect.Right;
    S := GetFontInfoText(Index);
    Canvas.TextRect(R, R.Left + 2, R.Top + 2, S);
    if not (odSelected in State) or IsDisableIndex(Index) then 
      Canvas.Font.Color := FontColor;
    if (odFocused in State) and IsDisableIndex(Index) then 
      Canvas.DrawFocusRect(Rect);    
    Canvas.Brush.Color := BrushColor;
  end  
end;

function TdxTLReportLinkDesignWindow.GetFontInfoText(AIndex: Integer): string;
begin
  Result := FormatFontInfo(GetFontByIndex(AIndex));  
end;

function TdxTLReportLinkDesignWindow.GetMaxWidth: Integer;
var
  I, L, L2, W, W2: Integer;
begin
  with lbxFonts do
  begin
    W := Canvas.TextWidth(Items[0] + 'X');
    for I := 1 to Items.Count - 1 do
    begin
      L := Canvas.TextWidth(Items[I] + 'X');
      if L > W then W := L;
    end;
    
    W2 := Canvas.TextWidth(GetFontInfoText(0) + 'X');
    for I := 1 to Items.Count - 1 do
    begin
      L2 := Canvas.TextWidth(GetFontInfoText(I) + 'X');
      if L2 > W2 then W2 := L2;
    end;
  end;
  Result := W + W2 + 2 + 8 + 3;
end;

procedure TdxTLReportLinkDesignWindow.lbxFontsClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  UpdateControlsState;
end;

procedure TdxTLReportLinkDesignWindow.lbxFontsDblClick(Sender: TObject);
begin
  if btnChangeFont.Enabled then btnChangeFont.Click;
end;

function TdxTLReportLinkDesignWindow.GetNodeIndex(ANode: TdxTreeListNode): Integer;
begin
  if TdxTreeListAccess(ANode.Owner).PaintStyle = psOutlook then
  begin
    if ANode.Count > 0 then
      Result := -1
    else
      Result := ANode.Index
  end    
  else
    Result := ANode.AbsoluteIndex;
  Inc(Result);
end;

function TdxTLReportLinkDesignWindow.GetNodeFont(ANode: TdxTreeListNode; 
  ANodeIndex: Integer): TFont;
var  
  TreeList: TdxTreeListAccess;
begin
  TreeList := TdxTreeListAccess(ANode.Owner);
  with ReportLink do 
    if TreeList.IsRowGroup(ANode) or ((FPaintStyle = psOutLook) and (ANode.Count > 0)) then 
      Result := GroupNodeFont
    else 
      if (DrawMode = tldmOddEven) and ((TreeList.PaintStyle = psStandard) or (ANode.Count = 0)) then
      begin
        if Odd(ANodeIndex) then 
          Result := OddFont
        else
          Result := EvenFont
      end    
      else
        Result := Font;
end;

function TdxTLReportLinkDesignWindow.GetPreviewFont(ANode: TdxTreeListNode; 
  ANodeIndex: Integer): TFont;
var  
  TreeList: TdxTreeListAccess;
begin
  TreeList := TdxTreeListAccess(ANode.Owner);
  with ReportLink do 
    if (DrawMode = tldmOddEven) and ((TreeList.PaintStyle = psStandard) or (ANode.Count = 0)) then
    begin
      if Odd(ANodeIndex) then 
        Result := OddFont
      else
        Result := EvenFont
    end    
    else
      Result := PreviewFont;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawPreviewCell(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  ASelected: Boolean; var AText: string; var AColor, ATextColor: TColor;
  AFont: TFont; var ADone: Boolean);
var
  AIndex: Integer;
begin
  with ReportLink do 
  begin
    AIndex := GetNodeIndex(ANode);
    if not IsPreviewTransparent(ANode) then AColor := GetPreviewColor(AIndex);
    AFont.Assign(GetPreviewFont(ANode, AIndex));
    AFont.Size := 8;
    ATextColor := AFont.Color;
  end;   
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawCell(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
var
  AIndex: Integer;
begin
  AIndex := GetNodeIndex(ANode);
  with ReportLink do 
  begin
    if not IsCellTransparent(ANode) then 
      AColor := GetCellColor(ANode, AColumn.Index, AIndex);
    AFont.Assign(GetNodeFont(ANode, AIndex));
    AFont.Size := 8;
  end;    
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewColumn4CustomDrawCell(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);

  function GetText: string;
  begin
    if ANode.Values[AColumn.Index] <> -1 then
      Result := ReportLink.GraphicAsTextValue
    else  
      Result := '';
  end;
  
  procedure DrawImages(AImages: TCustomImageList);
  var
    Index: Integer;
  begin
    FillRectColor(ACanvas.Handle, ARect, AColor);
    Index := ANode.Values[AColumn.Index];
    if Index <> -1 then 
      with ARect do
        AImages.Draw(ACanvas, Left + (Right - Left - AImages.Width) div 2, Top + 1, Index);
  end;
  
begin
  if ReportLink.GraphicsAsText then 
    DrawTextRect(ACanvas, ARect, GetText, taCenter, AColor)
  else
    DrawImages(TdxTreeListImageColumn(AColumn).Images);
  ADone := True;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewColumn3CustomDrawCell(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ReportLink.CheckMarksAsText then 
  begin
    DrawTextRect(ACanvas, ARect, AText, taCenter, AColor);
    ADone := True;
  end;  
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawColumnHeader(
  Sender: TObject; AColumn: TdxTreeListColumn; ACanvas: TCanvas;
  ARect: TRect; var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
  var ADone: Boolean);
begin
  DrawHeaderRect(ACanvas, ARect, AText, AAlignment, ReportLink.MakeLookAndFeel, 
    ReportLink.GridLineColor, AColor);
  ADone := True;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawBand(
  Sender: TObject; ABand: TdxTreeListBand; ACanvas: TCanvas; ARect: TRect;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  DrawHeaderRect(ACanvas, ARect, AText, AAlignment, ReportLink.MakeLookAndFeel, 
    ReportLink.GridLineColor, AColor);
  ADone := True;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawFooter(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; var AText: string; var AColor: TColor;
  AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);

  function GetInteriorColor: TColor;
  begin
    with ReportLink do
      if FixedTransparent then
        Result := clWindow
      else
        Result := HeaderColor;
  end;
  
  function GetBorderColor: TColor;
  begin
    with ReportLink do
      if ShowGrid and ShowRowFooterGrid and not Use3DEffects then
        Result := GridLineColor
      else
        Result := GetInteriorColor;
  end;

  procedure DrawFooterFrame(ACanvas: TCanvas);
  var
    DrawInfo: TdxGridDrawInfo;
  begin
    TdxTreeList(Sender).CalcDrawInfo(DrawInfo);
    try
      Inc(DrawInfo.FooterRect.Top);
      FillRectColor(ACanvas.Handle, DrawInfo.FooterRect, AColor);
    finally
      TdxTreeList(Sender).FreeDrawInfo(DrawInfo);
    end;
  end;
      
begin
  AFont.Assign(ReportLink.FooterFont);
  AFont.Size := 8;

  if not ReportLink.Use3DEffects and (AColumn.Index = 0) then
    DrawFooterFrame(ACanvas);
    
  InflateRect(ARect, 1, 1);
  DrawFooterRect(ACanvas, ARect, AText, AAlignment, ReportLink.MakeLookAndFeel,
    GetBorderColor, GetInteriorColor);    
    
  ADone := True;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewCustomDrawFooterNode(
  Sender: TObject; ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; AFooterIndex: Integer; var AText: string;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);

  function GetInteriorColor: TColor;
  begin
    with ReportLink do
      if FixedTransparent then
        Result := clWindow
      else
        Result := RowFooterColor;
  end;
  
  function GetBorderColor: TColor;
  begin
    with ReportLink do
      if ShowGrid and ShowRowFooterGrid and not Use3DEffects then
        Result := GridLineColor
      else
        Result := GetInteriorColor;
  end;
  
begin
  AFont.Assign(ReportLink.RowFooterFont);
  AFont.Size := 8;
  
  InflateRect(ARect, 1, 1);
  DrawFooterRect(ACanvas, ARect, AText, AAlignment, ReportLink.MakeLookAndFeel, 
    GetBorderColor, GetInteriorColor);
    
  ADone := True;
end;

procedure TdxTLReportLinkDesignWindow.dxTLPreviewGetPreviewLineCount(
  Sender: TObject; ANode: TdxTreeListNode; var LCount: Integer);
begin
  if ReportLink <> nil then
    if ReportLink.IsDBGridLink and (ANode.Count > 0) then
      LCount := 0;
end;

procedure TdxTLReportLinkDesignWindow.chbxShowClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  with ReportLink do 
    if TCheckBox(Sender).Checked then
      Options := Options + [TdxTreeListPaintOption(TCheckBox(Sender).Tag)]
    else
      Options := Options - [TdxTreeListPaintOption(TCheckBox(Sender).Tag)];
  Modified := True;
  UpdatePreview;
end;

procedure TdxTLReportLinkDesignWindow.chbxAutoCalcPreviewLinesClick(Sender: TObject);
begin
  if LockControlsUpdate then Exit;
  ReportLink.PreviewLineCount := -Byte(TCheckBox(Sender).Checked);
  TdxPSSpinEdit(sePreviewLineCount).MinValue := -Byte(ReportLink.AutoCalcPreviewLines);
  TdxPSSpinEdit(sePreviewLineCount).Value := -Byte(ReportLink.AutoCalcPreviewLines);
  Modified := True;
end;

procedure TdxTLReportLinkDesignWindow.cbxDrawModeChange(Sender: TObject);
begin
  if LockControlsUpdate then Exit;  
  ReportLink.DrawMode := TdxTreeListDrawMode(TComboBox(Sender).ItemIndex);
  Modified := True;
  UpdatePreview;
end;

procedure TdxTLReportLinkDesignWindow.lblDrawModeClick(Sender: TObject);
begin
  if TLabel(Sender).FocusControl <> nil then
  begin
    ActiveControl := TLabel(Sender).FocusControl;
    if ActiveControl is TComboBox then 
      TComboBox(ActiveControl).DroppedDown := True;
  end;  
end;

procedure TdxTLReportLinkDesignWindow.PageControl1Change(Sender: TObject);
begin
  lblPreviewWindow.Parent := TPageControl(Sender).ActivePage;
end;

procedure TdxTLReportLinkDesignWindow.cbxDrawModeDrawItem(
  Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);                                    
const
  ImageIndexMap: array[TdxTreeListDrawMode] of Integer = (0, 1, 3);
begin
  with TComboBox(Control) do 
    dxPSUtl.dxDrawComboBoxItem(Canvas, Rect, Items[Index], dxPSUtl.dxPSDrawModeImages, 
      ImageIndexMap[TdxTreeListDrawMode(Items.Objects[Index])], State);
end;

procedure RegisterHelpers;
begin
  TdxTreeListColumnHelper.Register;
  TdxTreeListImageColumnHelper.Register;
end;

procedure UnregisterHelpers;
begin
  TdxColumnHelpersFactory.ReleaseInstance;
end;

initialization
  if not Assigned(FdxTreeListAssignDataProc) then 
    FdxTreeListAssignDataProc := DefaultdxTreeListAssignDataProc;
  if not Assigned(FdxTreeListColumnMapperProc) then 
    FdxTreeListColumnMapperProc := DefaultdxTreeListMapperProc;

  RegisterHelpers;  
  dxPSCore.dxPSRegisterReportLink(TdxTreeListReportLink, TdxTreeList, TdxTLReportLinkDesignWindow);
  FPicture := TPicture.Create;
  
finalization
  FreeAndNil(FPicture);
  dxPSCore.dxPSUnregisterReportLink(TdxTreeListReportLink, TdxTreeList, TdxTLReportLinkDesignWindow);
  UnregisterHelpers;
  
  @FdxTreeListAssignDataProc := nil;
  @FdxTreeListColumnMapperProc := nil;
  
end.
