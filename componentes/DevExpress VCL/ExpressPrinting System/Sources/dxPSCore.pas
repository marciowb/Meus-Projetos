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

unit dxPSCore;

interface

{$I cxVer.inc}

{$IFNDEF DELPHI6}
{$IFNDEF BCB}
{$L+}  // to avoid internal error in Delphi5
{$ENDIF}
{$ENDIF}

(*$HPPEMIT '#include <ole2.hpp>*)
(*$HPPEMIT '#define HRGN unsigned'*)

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls,
  ActiveX, Menus, Forms, ImgList, Types,
{$IFDEF DELPHI5}
  Contnrs,
{$ENDIF}
  dxMessages, dxCore, cxClasses, cxControls, cxGraphics,
  dxBase, dxPSGlbl, dxPSSngltn, dxPSEngn, dxPSESys, dxPSForm, dxBkgnd,
  dxPrnPg, dxPgsDlg, dxPrnDlg, dxWrap, cxDrawTextUtils, dxPSFillPatterns;
                   
type
  EdxPrintEngine = class(EdxException);  
  EdxReportLink = class(EdxPrintEngine);
  EdxPSExplorer = class(EdxPrintEngine);
  EdxComponentPrinter = class(EdxPrintEngine);

  EdxInvalidStorageVersion = class(EdxComponentPrinter)
  private
    FVersion: UINT;
  public  
    constructor Create(AVersion: UINT);
    property Version: UINT read FVersion write FVersion;
  end;

  TCustomdxPSExplorerContextCommand = class;
  
  IdxPSExplorerContextCommandBuilder = interface
  ['{EE36E842-FD6A-4A89-A343-A32828AEFE3D}']
    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand);
    procedure UpdateExplorerContextCommands;
  end;
  
  IdxPSExplorerContextCommands = interface
  ['{DC3A582D-7E33-410F-A235-680A846824D3}']
    procedure BuildCommandSet(ABuilder: IdxPSExplorerContextCommandBuilder);
  end;

  IdxPSExplorerContextCommands2 = interface
  ['{E4D68CF3-AD07-4220-B892-92C8F9B3F966}']
    procedure FinalizeCommand(ACommand: TCustomdxPSExplorerContextCommand);
    procedure InitializeCommand(ACommand: TCustomdxPSExplorerContextCommand);
  end;

  IdxReportLinkController = interface
  ['{120F53E4-1B09-46EF-B42D-04AB8BBCC374}']
    function GetControlSiteBounds(AControl: TControl): TRect;
  end;       
    
  TdxPSReportDocument = class;
  TdxPSReportRenderer = class;  
  TdxReportLinkClass = class of TBasedxReportLink;
  TBasedxReportLink = class;
  TdxCompositionReportLink = class;
  TCustomdxComponentPrinter = class;
  TCustomdxPSExplorerTreeContainer = class;
  TAbstractdxReportLinkDesigner = class;
  TAbstractdxPreviewWindowDesigner = class;
  TAbstractdxReportLinkDesignWindow = class;
  TdxReportLinkDesignWindowClass = class of TAbstractdxReportLinkDesignWindow;
  TBasedxPreviewWindow = class;

  TdxReportVisualItemClass = class of TdxReportVisualItem;
  TdxReportVisualItem = class;
  TdxReportCellDataClass = class of TAbstractdxReportCellData;
  TAbstractdxReportCellData = class;
  TdxReportCellClass = class of TdxReportCell;
  TdxReportCell = class;
  TdxReportCellsClass = class of TdxReportCells;
  TdxReportCells = class;

  TdxPSCellBorderClass = class of TdxPSCustomCellBorder;
  TdxPSCustomCellBorder = class;
  TdxPSCellBorderPainterClass = class of TdxPSCellBorderPainter;  
  TdxPSCellBorderPainter = class;

  TdxPSReportGroupLookAndFeelClass = class of TdxPSReportGroupLookAndFeel;
  TdxPSReportGroupLookAndFeel = class;
  TdxPSReportGroupLookAndFeelPainterClass = class of TdxPSReportGroupLookAndFeelPainter;
  TdxPSReportGroupLookAndFeelPainter = class;  

 
  { Data Reader\Writer }

  TdxPSDataReaderClass = class of TdxPSDataReader;
  
  TdxPSDataReader = class(TReader)
  protected                                              
    class function SupportsStorageVersion(AVersion: Integer): Boolean; virtual;
  public
    class procedure Register; virtual;
    class procedure Unregister; virtual;
    
    function ReadCellBorderClass: TdxPSCellBorderClass;
    function ReadClass: TClass;
    function ReadFillPatternClass: TdxPSFillPatternClass;
    function ReadFont(AFont: TFont): TFont;
    function ReadGraphicClass: TGraphicClass;
    procedure ReadImage(AnImage: TGraphic);
    procedure ReadImageList(AnImageList: TCustomImageList);
    function ReadLinkClass: TdxReportLinkClass;
    function ReadLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
    function ReadPoint: TPoint;
    function ReadPSVersion: TdxPSVersion;
    function ReadRect: TRect;
    procedure SkipBytes(Count: {$IFDEF DELPHI6} Int64 {$ELSE} Integer {$ENDIF});
  end;

  TdxPSDataWriterClass = class of TdxPSDataWriter;
  
  TdxPSDataWriter = class(TWriter)
  protected
    class function SupportsStorageVersion(AVersion: Integer): Boolean; virtual;
  public
    class procedure Register; virtual;
    class procedure Unregister; virtual;
  
    procedure WriteClassName(AClass: TClass); overload;
    procedure WriteClassName(AnObject: TObject); overload;
    procedure WriteFont(AFont: TFont);
    procedure WriteImage(AnImage: TGraphic);
    procedure WriteImageList(AnImageList: TCustomImageList);
    procedure WritePoint(const Pt: TPoint);
    procedure WritePSVersion(const AVersion: TdxPSVersion);
    procedure WriteRect(const R: TRect);
  end;

  { Report Renderers }
  
  TdxWindowScalePair = record
    Numerator: Integer;
    Denominator: Integer;
  end;  

  TdxContinuedIndexPair = class
  public
    StartIndex: Integer;
    EndIndex: Integer;
  end;

  TdxPageOverlayIndexes = class(TList)
  private
    function GetItem(Index: Integer): Integer;
    procedure SetItem(Index, Value: Integer);
  public
    function Add(AValue: Integer): Integer;
    property Items[Index: Integer]: Integer read GetItem write SetItem; default;
  end;
  
  TdxPSReportRenderInfo = class;

  TdxPSPageRenderInfoClass = class of TdxPSPageRenderInfo;
  
  TdxPSPageRenderInfo = class
  private
    FIndexPairs: TList;
    FIsEmptyPage: Boolean;
    FIsEmptyPageCalculated: Boolean;
    FOverlays: TList;
    FPageIndex: Integer;
    FRenderInfo: TdxPSReportRenderInfo;
    function GetColIndex: Integer;
    function GetFooterBounds: TRect;
    function GetHeaderBounds: TRect;
    function GetIndexPair(Index: Integer): TdxContinuedIndexPair;
    function GetIndexPairCount: Integer;
    function GetIsBottomPage: Boolean;
    function GetIsEmptyPage: Boolean;
    function GetIsTopPage: Boolean;
    function GetOverlay(Index: Integer): TdxPageOverlayIndexes;
    function GetOverlayCount: Integer;
    function GetPrinterPage: TdxPrinterPage;
    function GetReportCells: TdxReportCells;
    function GetReportLink: TBasedxReportLink;
    function GetRowIndex: Integer;
    function GetTitleBounds: TRect;
    function GetTitleHeight: Integer;
    procedure SetIndexPair(Index: Integer; Value: TdxContinuedIndexPair);

    procedure FreeAndNilIndexPairs;
    procedure FreeAndNilOverlays;
  protected
    function AreRectsIntersected(const R1, R2: TRect): Boolean;

    procedure CalculateBounds; virtual;
    function CalculateIndexPairCount: Integer; virtual;
    procedure CalculateIndexPairs; virtual;
    function CalculateIsEmptyPage: Boolean; virtual;
    procedure CalculateOffsets;
    procedure CalculateOverlayIndexes;

    property IsEmptyPageCalculated: Boolean read FIsEmptyPageCalculated write FIsEmptyPageCalculated;
  public
    ContentBounds: TRect;
    DataOffset: TPoint;
    DetailBounds: TRect;
    TitleOffset: TPoint;
    constructor Create(ARenderInfo: TdxPSReportRenderInfo; APageIndex: Integer); virtual;
    destructor Destroy; override;
    procedure Calculate; virtual;

    function HasDetails: Boolean; virtual;
    function HasFooter: Boolean; virtual;
    function HasHeader: Boolean; virtual;
    function HasTitle: Boolean; virtual;

    property ColIndex: Integer read GetColIndex;
    property FooterBounds: TRect read GetFooterBounds;
    property HeaderBounds: TRect read GetHeaderBounds;
    property IndexPairCount: Integer read GetIndexPairCount;
    property IndexPairs[Index: Integer]: TdxContinuedIndexPair read GetIndexPair write SetIndexPair;
    property IsBottomPage: Boolean read GetIsBottomPage;
    property IsEmptyPage: Boolean read GetIsEmptyPage;
    property IsTopPage: Boolean read GetIsTopPage;
    property OverlayCount: Integer read GetOverlayCount;
    property Overlays[Index: Integer]: TdxPageOverlayIndexes read GetOverlay;
    property PageIndex: Integer read FPageIndex;
    property PrinterPage: TdxPrinterPage read GetPrinterPage;
    property RenderInfo: TdxPSReportRenderInfo read FRenderInfo;
    property ReportCells: TdxReportCells read GetReportCells;
    property ReportLink: TBasedxReportLink read GetReportLink;
    property RowIndex: Integer read GetRowIndex;
    property TitleBounds: TRect read GetTitleBounds;
    property TitleHeight: Integer read GetTitleHeight;
  end;

  TdxPSReportRenderInfoClass = class of TdxPSReportRenderInfo;
  
  TdxPSReportRenderInfo = class
  private
    FBaseContentFont: TFont;
    FDelimitersX: TList;
    FDelimitersY: TList;
    FEmptyPageCount: Integer;
    FGridLinesColor: TColor;
    FHardDelimitersY: TList;
    //FIsTitleHeightCalculated: Boolean;
    FLockCounter: Integer;
    FPageDelimitersX: TList;
    FPageDelimitersY: TList;
    FPageRenderInfos: TList;
    FReportLink: TBasedxReportLink;
    //FTitleHeight: Integer;
    function GetBreakPagesByHardDelimiters: Boolean;
    function GetDelimiterX(Index: Integer): Integer;
    function GetDelimiterXCount: Integer;
    function GetDelimiterY(Index: Integer): Integer;
    function GetDelimiterYCount: Integer;
    function GetEmptyPageCount: Integer;
    function GetFooterHeight: Integer;
    function GetHeaderHeight: Integer;
    function GetLocked: Boolean;
    function GetPageDelimiterX(Index: Integer): Integer;
    function GetPageDelimiterXCount: Integer;
    function GetPageDelimiterY(Index: Integer): Integer;
    function GetPageDelimiterYCount: Integer;
    function GetPageRenderInfo(Index: Integer): TdxPSPageRenderInfo;
    function GetPageRenderInfoCount: Integer;
    function GetPrinterPage: TdxPrinterPage;
    function GetReportCells: TdxReportCells;
    function GetReportHeight: Integer;
    function GetReportWidth: Integer;
    function GetScaleFactor: Integer;
    function GetTitleAdjustOnReportScale: Boolean;
    function GetTitleFont: TFont;
    function GetTitleText: string;
    function GetUseHardVertDelimiters: Boolean;
    function GetUseHorzDelimiters: Boolean;
    function GetUseVertDelimiters: Boolean;
    function GetTitleHeight: Integer;
    procedure SetBaseContentFont(Value: TFont);
    
    function IsNonEmptyPage(const ABounds: TRect): Boolean;
  protected
    function CalculateEmptyPageCount: Integer; virtual;
    procedure CalculateHeaderAndFooterBounds; virtual;
    function CalculatePageContentHeight(APageIndex: Integer): Integer; virtual;
    function CalculatePageContentWidth(APageIndex: Integer): Integer; virtual;
    procedure CalculatePageCount; virtual;
    procedure CalculatePageDelimiters; virtual;
    function CalculatePageDetailBounds(APageCol, APageRow: Integer): TRect; virtual;
    procedure CalculatePageHeaderAndFooterBounds; virtual;
    procedure CalculatePageRenderInfos; virtual;
    procedure CalculatePageRealAndVirtualIndexes(APageIndex: Integer; out AVirtualPageIndex, ARealPageIndex: Integer); virtual;
    //function CalculateTitleHeight: Integer; virtual;
    procedure CalculateTitleBounds; virtual;
    procedure DoCalculate; virtual;
    
    function GetNonEmptyPageCount: Integer; virtual;
    function GetPageColCount: Integer; virtual;
    function GetPageRowCount: Integer; virtual;
    function GetPageSize: TPoint; virtual;
    function GetPaintSize: TPoint; virtual;
    function GetUnitsPerInch: Integer; virtual;
    function GetWindowScalePair: TdxWindowScalePair; virtual;
    procedure SetUnitsPerInch(Value: Integer); virtual;
    
    procedure ClearPageRenderInfos;
    function CreatePageRenderInfo(APageIndex: Integer): TdxPSPageRenderInfo; virtual;
    procedure FreeAndNilPageRenderInfos;
    function GetPageRenderInfoClass: TdxPSPageRenderInfoClass; virtual;
    procedure Refresh; virtual;
    
    function HasPageTitle(APageIndex: Integer): Boolean;
    function IsHardDelimiter(AValue: Integer): Boolean;
    
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure ReadDelimiters(AReader: TdxPSDataReader);
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
    procedure WriteDelimiters(AWriter: TdxPSDataWriter);

    procedure AddPageDelimiterX(AValue: Integer);
    procedure AddPageDelimiterY(AValue: Integer);
    procedure PageDelimiterXClear;
    procedure PageDelimiterYClear;

    procedure AddStandardDelimiters;
    procedure EliminateDuplicatesAndSortDelimiters(AList: TList);
    procedure GetDelimiters;
    procedure MakeDelimiters;
    procedure MakeHardDelimiters;
    procedure TrancateDelimiters(AList: TList; AValue: Integer);
    
    function LoMetricRectToInternalUnits(const R: TRect): TRect;
    function LoMetricValueToInternalUnits(Value: Integer): Integer; virtual;
    function RealPageIndexToVirtualPageIndex(APageIndex: Integer; ATakeIntoAccountEmptyPages: Boolean): Integer; virtual;
    function VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer; virtual;
    
    property DelimiterXList: TList read FDelimitersX;
    property DelimiterYList: TList read FDelimitersY;
    property HardDelimiterYList: TList read FHardDelimitersY;
  public
    CanUseHFOnEveryPageMode: Boolean;
    FooterBounds: TRect;
    HeaderBounds: TRect;
    PageFooterBounds: TRect;
    PageHeaderBounds: TRect;
    TitleBounds: TRect;
    VirtualPageCount: Integer;
    
    constructor Create(AReportLink: TBasedxReportLink); virtual;
    destructor Destroy; override;
    
    procedure Calculate;
    function CalculateTitleHeight: Integer; virtual;
    function CanRenderPage(AVirtualPageIndex: Integer): Boolean; virtual;
    function IsDrawPageFootNoteOnPage(APageIndex: Integer): Boolean; virtual;
    function IsDrawPageTitleOnPage(APageIndex: Integer): Boolean; virtual;

    procedure Lock;
    procedure Unlock;
    
    property BaseContentFont: TFont read FBaseContentFont write SetBaseContentFont;
    property BreakPagesByHardDelimiters: Boolean read GetBreakPagesByHardDelimiters;
    property DelimitersX[Index: Integer]: Integer read GetDelimiterX;
    property DelimiterXCount: Integer read GetDelimiterXCount;
    property DelimitersY[Index: Integer]: Integer read GetDelimiterY;
    property DelimiterYCount: Integer read GetDelimiterYCount;
    property EmptyPageCount: Integer read GetEmptyPageCount;
    property FooterHeight: Integer read GetFooterHeight;
    property GridLinesColor: TColor read FGridLinesColor write FGridLinesColor;
    property HeaderHeight: Integer read GetHeaderHeight;
    property Locked: Boolean read GetLocked;
    property NonEmptyPageCount: Integer read GetNonEmptyPageCount;
    property PageColCount: Integer read GetPageColCount;
    property PageDelimitersX[Index: Integer]: Integer read GetPageDelimiterX;
    property PageDelimiterXCount: Integer read GetPageDelimiterXCount;
    property PageDelimitersY[Index: Integer]: Integer read GetPageDelimiterY;
    property PageDelimiterYCount: Integer read GetPageDelimiterYCount;
    property PageRenderInfoCount: Integer read GetPageRenderInfoCount;
    property PageRenderInfos[Index: Integer]: TdxPSPageRenderInfo read GetPageRenderInfo;
    property PageRowCount: Integer read GetPageRowCount;
    property PageSize: TPoint read GetPageSize;
    property PaintSize: TPoint read GetPaintSize;
    property PrinterPage: TdxPrinterPage read GetPrinterPage;
    property ReportCells: TdxReportCells read GetReportCells;
    property ReportHeight: Integer read GetReportHeight;
    property ReportLink: TBasedxReportLink read FReportLink;
    property ReportWidth: Integer read GetReportWidth;
    property ScaleFactor: Integer read GetScaleFactor;
    property TitleAdjustOnReportScale: Boolean read GetTitleAdjustOnReportScale;
    property TitleFont: TFont read GetTitleFont;
    property TitleHeight: Integer read GetTitleHeight;
    property TitleText: string read GetTitleText;
    property UnitsPerInch: Integer read GetUnitsPerInch write SetUnitsPerInch;
    property UseHardVertDelimiters: Boolean read GetUseHardVertDelimiters;
    property UseHorzDelimiters: Boolean read GetUseHorzDelimiters;
    property UseVertDelimiters: Boolean read GetUseVertDelimiters;
    property WindowScalePair: TdxWindowScalePair read GetWindowScalePair;
  end;

  TdxCellCheckPos = (ccpLeft, ccpCenter, ccpRight);
  TdxCellEdgeKind = (cekInner, cekOuter);
  TdxCellEdgeMode = (cemPattern, cem3DEffects);
  TdxCellEdgeStyle = (cesRaised, cesSunken);
  TdxCellSide = (csLeft, csTop, csRight, csBottom);
  TdxCellSides = set of TdxCellSide;
  TdxCellSortOrder = (csoNone, csoUp, csoDown);
  TdxCellUpDown = csoUp..csoDown;                                        
  TdxCheckButtonEdgeStyle = (cbesNone, cbes3D, cbesSoft3D, cbesBoldFlat, cbesUltraFlat, cbesSingle);
  TdxGraphicDrawMode = (gdmNone, gdmCenter, gdmStretch, gdmStretchProportional, gdmCenterAndStretchProportional);
  TdxImageLayout = (ilImageTopLeft, ilImageTopCenter, ilImageTopRight, ilImageCenterLeft, 
    ilImageCenterCenter, ilImageCenterRight, ilImageBottomLeft, ilImageBottomCenter, ilImageBottomRight);

  TdxCellImageBuffering = (cibDefault, cibNone, cibAlways);
{$IFDEF BCBCOMPATIBLE}
  TdxCellImageActualBuffering = TdxCellImageBuffering;
{$ELSE}
  TdxCellImageActualBuffering = cibNone..cibAlways;
{$ENDIF}

  TdxPSCellBorderSalientType = (bstOuter, bstInner);

  TdxPSTreeLineMode = (tlmNone, tlmVertical, tlmCross, tlmTopRightCorner, tlmBottomRightCorner);
  TdxPSTreeLinePart = (tlpTop, tlpRight, tlpBottom);
  TdxPSTreeLineParts = set of TdxPSTreeLinePart;
  TdxPSTreeLineStyle = (tlsSolid, tlsDot);

  TdxPSCellBorderPainter = class
  private
    FItem: TdxReportVisualItem;
    FRenderer: TdxPSReportRenderer;
    function GetLineThickness: Integer;
  protected
    class function GetBorderBounds(const R: TRect; ASide: TdxCellSide; ALineThickness: Integer): TRect; virtual;
    class function GetBottomShadowBounds(const R: TRect; AShadowDepth: Integer): TRect;
    class function GetBottomShadowRestSpaceBounds(const R: TRect; AShadowDepth: Integer): TRect;
    class function GetRightShadowBounds(const R: TRect; AShadowDepth: Integer): TRect;
    class function GetRightShadowRestSpaceBounds(const R: TRect; AShadowDepth: Integer): TRect;
    class procedure InflateRect(var R: TRect; ASides: TdxCellSides; ALineThickness: Integer);
  public
    constructor Create(ARenderer: TdxPSReportRenderer); virtual;

    class procedure DrawFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
      ATLBrush, ABRBrush: HBRUSH; ALineThickness: Integer; AThickness: Integer = 1);
    class procedure DrawShadow(DC: HDC; const R: TRect; AShadowDepth: Integer; 
      AShadowBrush, ARestSpaceBrush: HBRUSH);
    procedure Paint(DC: HDC); virtual;
    
    function BorderClass: TdxPSCellBorderClass; overload; virtual;
    function Item: TdxReportVisualItem; overload; virtual;
    function Renderer: TdxPSReportRenderer; overload; virtual;

    property LineThickness: Integer read GetLineThickness;
  end;

  TdxPSCustomCellBorder = class(TPersistent)
  protected            
    class function Edge3DSoft: Boolean; virtual;
    class function Edge3DStyle: TdxCellEdgeStyle; virtual;
    class function EdgeMode: TdxCellEdgeMode; virtual;

    class function GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer; virtual;
    class function GetPainterClass: TdxPSCellBorderPainterClass; virtual;
  public
    class procedure Register; virtual;
    class procedure Unregister; virtual;
    
    class function Solid: Boolean; virtual;
    class function Thickness: Integer; virtual;  
  end;

  TdxPSCellNullBorderPainter = class(TdxPSCellBorderPainter)
  public
    procedure Paint(DC: HDC); override;
  end;
  
  TdxPSCellNullBorder = class(TdxPSCustomCellBorder)
  protected
    class function GetPainterClass: TdxPSCellBorderPainterClass; override;
  public
    class function Thickness: Integer; override;
  end;

  TdxPSCellFlatBorder = class(TdxPSCustomCellBorder)
  protected
    class function GetPainterClass: TdxPSCellBorderPainterClass; override;
  end;
  
  TdxPSCellBoldFlatBorder = class(TdxPSCellFlatBorder)
  public
    class function Thickness: Integer; override;
  end;

  TdxPSCellUltraFlatBorder = class(TdxPSCellFlatBorder)
  public
    class function Thickness: Integer; override;
  end;

  TdxPSCell3DBorderClass = class of TdxPSCustomCell3DBorder;
  
  TdxPSCell3DBorderPainter = class(TdxPSCellBorderPainter)
  public
    class procedure Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
      AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH; 
      ALineThickness: Integer); overload; virtual; 
    class procedure Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
      ACellBorders: TdxPSCell3DBorderClass; ALineThickness: Integer); overload; virtual; 
    procedure Paint(DC: HDC); override;  

    function BorderClass: TdxPSCell3DBorderClass; reintroduce; overload;
  end;
             
  TdxPSCustomCell3DBorder = class(TdxPSCustomCellBorder)
  protected
    class function EdgeMode: TdxCellEdgeMode; override;
    
    class function GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer; override;
    class function GetPainterClass: TdxPSCellBorderPainterClass; override;
  public
    class function Solid: Boolean; override;
    class function Thickness: Integer; override;

    class function BottomRightInnerBrush: HBRUSH; virtual;
    class function BottomRightInnerColor: TColor; virtual;
    class function BottomRightOuterBrush: HBRUSH; virtual;
    class function BottomRightOuterColor: TColor; virtual;
    class function TopLeftInnerBrush: HBRUSH; virtual;
    class function TopLeftInnerColor: TColor; virtual;
    class function TopLeftOuterBrush: HBRUSH; virtual;
    class function TopLeftOuterColor: TColor; virtual;
  end;

  TdxPSCellRaisedBorder = class(TdxPSCustomCell3DBorder)
  protected
    class function Edge3DSoft: Boolean; override;
    class function Edge3DStyle: TdxCellEdgeStyle; override;
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
    class function BottomRightOuterBrush: HBRUSH; override;
    class function BottomRightOuterColor: TColor; override;
    class function TopLeftInnerBrush: HBRUSH; override;
    class function TopLeftInnerColor: TColor; override;
    class function TopLeftOuterBrush: HBRUSH; override;
    class function TopLeftOuterColor: TColor; override;
  end;
  
  TdxPSCellRaisedSoftBorder = class(TdxPSCellRaisedBorder)
  protected
    class function Edge3DSoft: Boolean; override;
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
  end;
  
  TdxPSCellSunkenBorder = class(TdxPSCustomCell3DBorder)
  protected
    class function Edge3DSoft: Boolean; override;
    class function Edge3DStyle: TdxCellEdgeStyle; override;
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
    class function BottomRightOuterBrush: HBRUSH; override;
    class function BottomRightOuterColor: TColor; override;
    class function TopLeftInnerBrush: HBRUSH; override;
    class function TopLeftInnerColor: TColor; override;
    class function TopLeftOuterBrush: HBRUSH; override;
    class function TopLeftOuterColor: TColor; override;
  end;
                                
  TdxPSCellSunkenSoftBorder = class(TdxPSCellSunkenBorder)
  protected
    class function Edge3DSoft: Boolean; override;
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
    class function TopLeftInnerBrush: HBRUSH; override;
    class function TopLeftInnerColor: TColor; override;
  end;

  TdxPSCellTwistedBorderPainter = class(TdxPSCell3DBorderPainter)
  public
    class procedure Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides;
      ACellBorders: TdxPSCell3DBorderClass; ALineThickness: Integer); override;
    class procedure Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides;
      AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH; ALineThickness: Integer); override;
  end;
  
  TdxPSCellTwistedBorder = class(TdxPSCustomCell3DBorder)
  protected
    class function GetPainterClass: TdxPSCellBorderPainterClass; override;
  end;

  TdxPSCellEtchedBorder = class(TdxPSCellTwistedBorder)
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
    class function BottomRightOuterBrush: HBRUSH; override;
    class function BottomRightOuterColor: TColor; override;
    class function TopLeftInnerBrush: HBRUSH; override;
    class function TopLeftInnerColor: TColor; override;
    class function TopLeftOuterBrush: HBRUSH; override;
    class function TopLeftOuterColor: TColor; override;
  end;

  TdxPSCellBumpedBorder = class(TdxPSCellTwistedBorder)
  public
    class function BottomRightInnerBrush: HBRUSH; override;
    class function BottomRightInnerColor: TColor; override;
    class function BottomRightOuterBrush: HBRUSH; override;
    class function BottomRightOuterColor: TColor; override;
    class function TopLeftInnerBrush: HBRUSH; override;
    class function TopLeftInnerColor: TColor; override;
    class function TopLeftOuterBrush: HBRUSH; override;
    class function TopLeftOuterColor: TColor; override;
  end;

  TdxPSColorBorderPainter = class(TdxPSCellBorderPainter)
  protected
    function GetSideColor(ASide: TdxCellSide): TColor; virtual;
  public
    procedure Paint(DC: HDC); override;
    property SideColor[ASide: TdxCellSide]: TColor read GetSideColor;
  end;

  TdxPSColorBorder = class(TdxPSCellUltraFlatBorder{TdxPSCustomCellBorder})
  protected
    class function GetPainterClass: TdxPSCellBorderPainterClass; override;
  end;

  TdxPSBackgroundBitmapPool = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetItem(Index: Integer): TBitmap;
  protected
    procedure ReadData(AReader: TdxPSDataReader);
    procedure WriteData(AWriter: TdxPSDataWriter);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TdxPSBackgroundBitmapPool);
    
    function Add(ABitmap: TBitmap): Integer;
    procedure Clear;
    procedure Delete(AnIndex: Integer);
    function Find(ABitmap: TBitmap; out AnIndex: Integer): Boolean;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TBitmap read GetItem; default;
  end;
  
  TdxPSBrushPoolItem = class
  private
    FBrush: HBRUSH;
    FColor: TColor;
    function GetBrush: HBRUSH;
  public
    constructor Create(AColor: TColor);
    destructor Destroy; override;

    property Brush: HBRUSH read GetBrush;
    property Color: TColor read FColor;
  end;

  TdxPSReportBrushPool = class
  private
    FItems: TList;
    function GetBrush(AColor: TColor): HBRUSH;
    function GetCount: Integer;
    function GetItem(Index: Integer): TdxPSBrushPoolItem;
  protected  
    function Add(AColor: TColor): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function IndexOf(AColor: TColor): Integer;

    property Brushes[AColor: TColor]: HBRUSH read GetBrush; default;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TdxPSBrushPoolItem read GetItem;
  end;

  TdxPSReportRendererClass = class of TdxPSReportRenderer;

  TdxPSFontPoolItem = class
  private
    FFont: TFont;
    FOriginalSize: Integer;
    procedure SetFont(Value: TFont);
  public
    constructor Create(AFont: TFont);
    destructor Destroy; override;

    property Font: TFont read FFont write SetFont;
    property OriginalSize: Integer read FOriginalSize write FOriginalSize;
  end;

  TdxPSReportFontPool = class
  private
    FItems: TList;
    function GetCount: Integer;
    function GetFont(Index: Integer): TFont;
    function GetItem(Index: Integer): TdxPSFontPoolItem;
  protected  
    FLocked: Boolean;
    function CreateFont(AFont: TFont): Integer;
    procedure FontChanged(Sender: TObject);
    procedure PrepareFonts(UPI: Integer);

    procedure ReadData(AReader: TdxPSDataReader);
    procedure WriteData(AWriter: TdxPSDataWriter);
  public
    constructor Create;
    destructor Destroy; override;

    function Add(AFont: TFont): Integer;
    procedure Clear;
    function IndexOf(AFont: TFont): Integer;
    
    property Count: Integer read GetCount;
    property Fonts[Index: Integer]: TFont read GetFont; default;
    property Items[Index: Integer]: TdxPSFontPoolItem read GetItem;
  end;

  TdxPSCachedGraphicInfo = class
  protected
    Renderer: TdxPSReportRenderer;
    SourceGraphic, PreparedGraphic: TGraphic;
    UnitsPerInch: Integer;
    UnitsPerPixel: Integer;
    ViewPortRect: TRect;
    ZoomFactor: Integer;
    procedure SaveModeInfo;
  public
    constructor Create(ARenderer: TdxPSReportRenderer); virtual;
    function Check(ASourceGraphic: TGraphic; ABitmap: TBitmap;  var APreparedGraphic: TGraphic): Boolean;
    procedure Clear;
  end;

  TdxPSRenderStage = (rsFirstPass, rsSecondPass);
  TdxPSRenderStages = set of TdxPSRenderStage;
     
  TdxPSReportRenderer = class
  private
    FBorderColor: TColor;
    FBorderPainters: TList;
    FBrushPool: TdxPSReportBrushPool;
    FCachedGraphicInfo: TdxPSCachedGraphicInfo;
    FCanvas: TCanvas;
    FCheckBitmap: TBitmap;
    FDC: HDC;
    FDrawBitmap: TBitmap;
    FDrawMask: TBitmap;
    FGroupLookAndFeelPainters: TList;
    FHFStrings: TStrings;
    FIsRendering: Boolean;
    FLineThickness: Integer;
    FMarlettFont10: TFont;
    FMarlettFont8: TFont;
    FPPI: Integer;
    FPrevMode: Integer;
    FPrevWindowExt: TSize;
    FPrevWindowOrg: TPoint;
    FPrevViewPortExt: TSize;
    FPrevViewPortOrg: TPoint;
    FRenderingPageIndex: Integer; // virtual index
    FRenderStage: TdxPSRenderStages;
    FReportLink: TBasedxReportLink;
    FSaveColor: TColor;
    FSaveFont: TFont;
    FSavePixelsPerInch: Integer;
    FSymbolFont: TFont;
    FUnitsPerPixel: Integer;
    FViewPortRect: TRect;
    FZoomFactor: Integer;
    function GetBorderPainterItem(Index: Integer): TdxPSCellBorderPainter;
    function GetBorderPainterCount: Integer;
    function GetGroupLookAndFeelPainter(Index: Integer): TdxPSReportGroupLookAndFeelPainter;
    function GetGroupLookAndFeelPainterCount: Integer;
    function GetHalfLineThickness: Integer;
    function GetIsPrinting: Boolean;    
    function GetPageRenderInfo: TdxPSPageRenderInfo;
    function GetRenderInfo: TdxPSReportRenderInfo;
    function GetReportCells: TdxReportCells;
  protected
    function CustomDrawReportItem(AnItem: TAbstractdxReportCellData): Boolean;
    procedure Get3DBorderBrushes(AnItem: TdxReportVisualItem; var AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH);
    procedure Get3DBorderColors(AnItem: TdxReportVisualItem; var AOuterTLColor, AOuterBRColor, AInnerTLColor, AInnerBRColor: TColor);
    
    function GetUnitsPerInch: Integer; virtual;

    function CreateBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
    function FindBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
    procedure FreeAndNilBorderPainters;

    function CreateReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
    function FindReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
    procedure FreeAndNilReportGroupLookAndFeelPainters;
    
    procedure PrepareCanvasForCustomDraw(AFont: TFont; AColor: TColor);
    procedure PrepareFonts;
    procedure PrepareGDIObjects; virtual;
    procedure PrepareLogicalCoordinates; virtual;
    procedure PrepareLogicalUnits; virtual;
    function PreparedPageIndex(APageIndex: Integer): Integer;
    procedure PrepareRenderPage; virtual;
    procedure PrepareWindow; virtual;
    procedure PrepareViewPort; virtual;
    procedure RenderCell(ACell: TdxReportCell; const OriginRect: TRect);
    procedure RenderDelimiters;
    procedure RenderEntirePage(ARealPageIndex: Integer); virtual;
    procedure RenderPageContent; virtual;
    procedure RenderPageContentPart(ACell: TdxReportCell;StartIndex, EndIndex: Integer; const OriginRect: TRect);
    procedure RenderPageOverlay(AnOverlayIndex: Integer; AnOverlay: TdxPageOverlayIndexes; const OriginRect: TRect); virtual;
    procedure RenderPageBackground(ARealPageIndex: Integer); virtual;
    procedure RenderPageFooter(ARealPageIndex: Integer); virtual;
    procedure RenderPageHeader(ARealPageIndex: Integer); virtual;
    procedure RenderPageHeaderOrFooter(HF: TCustomdxPageObject; APageIndex: Integer; ARect: TRect); virtual;
    procedure RenderPageHeaderOrFooterContent(HF: TCustomdxPageObject; APageIndex: Integer; ARect: TRect; 
      ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean); virtual;
    procedure RenderPageHeaderOrFooterContentPart(ATitlePart: TdxPageTitlePart; AStrings: TStrings; 
      ATextAlignY: TcxTextAlignY; ALineHeight, ADestWidth, ADestHeight: Integer; const ARect: TRect);
    procedure RenderPageTitleContent(const AText: string; ARect: TRect; ATextAlignX: TcxTextAlignX;
      ATextAlignY: TcxTextAlignY; AColor: TColor; AFont: TFont; ATransparent: Boolean); virtual;
    procedure RenderPageTitle; virtual;
    procedure RestoreMapMode; virtual;
    procedure SaveMapMode; virtual;
    procedure UnprepareCanvasForCustomDraw;
    procedure UnprepareGDIObjects; virtual;
    procedure UnprepareLogicalUnits; virtual;
    procedure UnprepareRenderPage; virtual;

    property BorderPainterCount: Integer read GetBorderPainterCount;
    property BorderPainters[Index: Integer]: TdxPSCellBorderPainter read GetBorderPainterItem;
    property BrushPool: TdxPSReportBrushPool read FBrushPool;
    property CachedGraphicInfo: TdxPSCachedGraphicInfo read FCachedGraphicInfo;
    property GroupLookAndFeelPainterCount: Integer read GetGroupLookAndFeelPainterCount;
    property GroupLookAndFeelPainters[Index: Integer]: TdxPSReportGroupLookAndFeelPainter read GetGroupLookAndFeelPainter;
  public
    constructor Create(AReportLink: TBasedxReportLink); virtual;
    destructor Destroy; override;

    function CalcTextHeight(DC: HDC; const AText: string; AWordBreak: Boolean; 
      AFont: TFont = nil; ABaseWidth: Integer = -1): Integer;
    function CalcTextLineCount(DC: HDC; const AText: string; AFont: TFont = nil;
      ABaseWidth: Integer = -1): Integer;
    function CalcTextPatternHeight(DC: HDC; AFont: TFont = nil): Integer;
    function CalcTextRect(DC: HDC; const AText: string; var ARect: TRect; 
      AWordBreak: Boolean; AFont: TFont = nil): Integer; overload;
    function CalcTextRect(DC: HDC; const AText: string; var ARect: TRect; 
      AFormat: DWORD; AFont: TFont = nil): Integer; overload;
    function CalcTextWidth(DC: HDC; const AText: string; AFont: TFont = nil): Integer;    

    procedure DrawCheckBox(DC: HDC; var R: TRect; AChecked, AEnabled, AIsRadio: Boolean;
      AEdgeStyle: TdxCheckButtonEdgeStyle; ABorderColor: TColor = clWindowText); virtual;
    procedure DrawEdge(DC: HDC; var R: TRect; AEdgeMode: TdxCellEdgeMode;
      AEdge3DEdge: TdxCellEdgeStyle; ASides: TdxCellSides; ASoft: Boolean; 
      ABorderColor: TColor = -1); virtual;
    procedure DrawEllipse(DC: HDC; R: TRect; AForeColor, ABackColor: TColor; 
      APattern: TdxPSFillPatternClass; ABorderColor: TColor; 
      ABorderThickness: Integer = 1); virtual;
    procedure DrawExpandButton(DC: HDC; var R: TRect; 
      AExpanded, ADrawBorder, AEdge3D, AEdge3DSoft, AShadow, AFillInterior: Boolean; 
      ABorderColor, AInteriorColor: TColor); virtual;
    procedure DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte); // Draw indvidual glyph from Font (used to render SortMark, ExpandButton, CheckBox Glyphs and so on)
    procedure DrawGraphic(DC: HDC; var R: TRect; const AClipRect: TRect;
      AImageList: TCustomImageList; AImageIndex: Integer; AGraphic: TGraphic; 
      AGraphicTransparent, ATransparent: Boolean;  AColor: TColor); virtual;
    procedure DrawGraphicEx(DC: HDC; R: TRect; const AClipRect: TRect;
      AImageList: TCustomImageList; AImageIndex: Integer; AGraphic: TGraphic; 
      AGraphicTransparent, ATransparent: Boolean; AColor, ABkColor: TColor; 
      APattern: TdxPSFillPatternClass; AnActualImageBuffering: TdxCellImageActualBuffering = cibAlways); virtual;
    procedure DrawRectangle(DC: HDC; R: TRect; AForeColor, ABackColor: TColor; 
      AContentPattern: TdxPSFillPatternClass; ABorderColor: TColor; 
      ABorderThickness: Integer = 1); virtual;
    procedure DrawRoundRect(DC: HDC; R: TRect; AnEllipseWidth, AnEllipseHeight: Integer; 
      AForeColor, ABackColor: TColor; AContentPattern: TdxPSFillPatternClass; 
      ABorderColor: TColor; ABorderThickness: Integer = 1); virtual;
    procedure DrawSortMark(DC: HDC; var R: TRect; ASortOrder: TdxCellSortOrder; AMono: Boolean); virtual;
    procedure DrawText(DC: HDC; var R: TRect; AMaxLineCount: Integer;
      ALeftIndent, ARightIndent: Integer; const AText: string; AFont: TFont; 
      ABkColor: TColor; ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY; 
      AFillBackground, AMultiline, AEndEllipsis: Boolean; APreventLeftTextExceed: Boolean = True; 
      APreventTopTextExceed: Boolean = True; AHidePrefix: Boolean = True);
    procedure DrawTextEx(DC: HDC; var R: TRect; AMaxLineCount: Integer; 
      ALeftIndent, ARightIndent: Integer; const AText: string; AFont: TFont; AFormat: DWORD);
    function MakeTextFormat(ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY; 
      AMultiline, AEndEllipsis, APreventLeftTextExceed, APreventTopTextExceed, AHidePrefix: Boolean): DWORD;
    procedure FillEllipse(DC: HDC; const R: TRect; AColor: TColor); virtual;
    procedure FillEllipseEx(DC: HDC; const R: TRect; AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass); virtual;
    procedure FillRect(DC: HDC; const R: TRect; AColor: TColor); virtual;
    procedure FillRectEx(DC: HDC; const R: TRect; AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass); virtual;
    procedure FillRoundRect(DC: HDC; const R: TRect; 
      AnEllipseWidth, AnEllipseHeight: Integer; AColor: TColor); virtual;
    procedure FillRoundRectEx(DC: HDC; const R: TRect; AnEllipseWidth, AnEllipseHeight: Integer; 
      AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass); virtual;    
    procedure FillRgn(DC: HDC; Rgn: HRGN; AColor: TColor); virtual;
    procedure FillRgnEx(DC: HDC; Rgn: HRGN; AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass); virtual;
    procedure FrameEllipse(DC: HDC; R: TRect; AColor: TColor; AThickness: Integer = 1);
    procedure FrameRect(DC: HDC; R: TRect; AColor: TColor; ASides: TdxCellSides = [csLeft..csBottom];
      AThickness: Integer = 1); virtual;
    procedure FrameRoundRect(DC: HDC; R: TRect; AnEllipseWidth, AnEllipseHeight: Integer;
      AColor: TColor; AThickness: Integer = 1); virtual;   

    function GetBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
    function GetBrushByColor(AColor: TColor): HBRUSH;
    function GetPatternBrush(APattern: TdxPSFillPatternClass; AColor: TColor): HBRUSH;
    function GetReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
    
    function ExcludeClipRect(const R: TRect): Integer;
    function GetClipRgn: HRGN;
    function IntersectClipRect(const R: TRect): HRGN;
    procedure RestoreClipRgn(var Rgn: HRGN);

    procedure RenderPage(ACanvas: TCanvas; const APageBounds: TRect; 
      APageIndex, AContinuousPageIndex, AZoomFactor: Integer); virtual;

    property BorderColor: TColor read FBorderColor;
    property Canvas: TCanvas read FCanvas write FCanvas;
    property DC: HDC read FDC write FDC; 
    property HalfLineThickness: Integer read GetHalfLineThickness;
    property IsPrinting: Boolean read GetIsPrinting;
    property IsRendering: Boolean read FIsRendering;
    property LineThickness: Integer read FLineThickness write FLineThickness;
    property MarlettFont10: TFont read FMarlettFont10;
    property MarlettFont8: TFont read FMarlettFont8;
    property PageRenderInfo: TdxPSPageRenderInfo read GetPageRenderInfo;
    property PPI: Integer read FPPI write FPPI; // PixelsPerInch for current DC
    property RenderInfo: TdxPSReportRenderInfo read GetRenderInfo;
    property RenderingPageIndex: Integer read FRenderingPageIndex; // virtual
    property RenderStage: TdxPSRenderStages read FRenderStage;
    property ReportCells: TdxReportCells read GetReportCells;
    property ReportLink: TBasedxReportLink read FReportLink;
    property SymbolFont: TFont read FSymbolFont;
    property UnitsPerInch: Integer read GetUnitsPerInch;
    property UnitsPerPixel: Integer read FUnitsPerPixel write FUnitsPerPixel;
    property ViewPortRect: TRect read FViewPortRect;
    property ZoomFactor: Integer read FZoomFactor;
  end;

  { Report Items }
  
  TdxReportItemClass = class of TdxReportItem;
    
  TdxReportItem = class(TPersistent)
  private
    FData: Integer;
    FParent: TdxReportCell;
    function GetIndex: Integer;
    function GetReportCells: TdxReportCells; virtual;
    procedure SetIndex(Value: Integer);
    procedure SetParent(Value: TdxReportCell);
  protected
    function AsCell: TdxReportCell;
    function GetTopLevelParent: TdxReportCell;    
    class function IsCell: Boolean; virtual;
    
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
    class function Serializable: Boolean; virtual;
  public
    constructor Create(AParent: TdxReportCell); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    class function ReportItemClass: TdxReportItemClass;    

    class procedure Register; virtual;
    class procedure Unregister; virtual;
    
    function Clone(AParent: TdxReportCell): TdxReportItem;
    function GetNextSibling: TdxReportItem;
    function GetPrevSibling: TdxReportItem;
    function HasParent: Boolean;
    function IsFirstItem: Boolean;
    function IsLastItem: Boolean;

    property Data: Integer read FData write FData;
    property Index: Integer read GetIndex write SetIndex;
    property Parent: TdxReportCell read FParent write SetParent;
    property ReportCells: TdxReportCells read GetReportCells;
    property TopLevelParent: TdxReportCell read GetTopLevelParent;
  end;

  TdxReportVisualItem = class(TdxReportItem)
  private
    FBackgroundBitmapIndex: Integer;
    FBorderClass: TdxPSCellBorderClass;
    FBorderColor: TColor;
    FBoundsRect: TRect;
    FCellSideColors: array[TdxCellSide] of TColor;
    FColor: TColor;
    FFontIndex: Integer;
    FFormat: DWORD;
    function GetAbsoluteOrigin: TPoint;
    function GetAbsoluteRect: TRect;
    function GetBackgroundBitmap: TBitmap;
    function GetBackgroundBitmapHeight: Integer;
    function GetBackgroundBitmapPool: TdxPSBackgroundBitmapPool;
    function GetBackgroundBitmapTileOrigin: TPoint;
    function GetBackgroundBitmapTileStartIndexX: Integer;
    function GetBackgroundBitmapTileStartIndexY: Integer;
    function GetBackgroundBitmapTileStopIndexX: Integer;
    function GetBackgroundBitmapTileStopIndexY: Integer;
    function GetBackgroundBitmapWidth: Integer;
    function GetBorderBrush: HBRUSH;
    function GetBorderColor: TColor;
    function GetCellSides: TdxCellSides;
    function GetCellSideColors(ASide: TdxCellSide): TColor;
    function GetContentBrush: HBRUSH;
    function GetEdge3DSoft: Boolean;
    function GetEdge3DStyle: TdxCellEdgeStyle;
    function GetEdgeMode: TdxCellEdgeMode;
    function GetExcludeFromClipRgn: Boolean;
    function GetFont: TFont;
    function GetHeight: Integer;
    function GetIsPrinting: Boolean;
    function GetLeft: Integer;
    function GetLineThickness: Integer;
    function GetOrigin: TPoint;
    function GetParentBrush: HBRUSH;
    function GetParentColor: TColor;
    function GetRenderer: TdxPSReportRenderer;
    function GetShadowBrush: HBRUSH;
    function GetShowShadow: Boolean;
    function GetTop: Integer;
    function GetTransparent: Boolean;
    function GetWidth: Integer;
    function GetVisible: Boolean;
    procedure SetBackgroundBitmapIndex(Value: Integer);
    procedure SetBorderClass(Value: TdxPSCellBorderClass);
    procedure SetBoundsRect(const Value: TRect);
    procedure SetCellSides(Value: TdxCellSides);
    procedure SetCellSideColors(ASide: TdxCellSide; AValue: TColor);
    procedure SetColor(Value: TColor);
    procedure SetEdge3DSoft(Value: Boolean);
    procedure SetEdge3DStyle(Value: TdxCellEdgeStyle);
    procedure SetEdgeMode(Value: TdxCellEdgeMode);
    procedure SetExcludeFromClipRgn(Value: Boolean);
    procedure SetFont(Value: TFont);
    procedure SetFormat(Value: DWORD);
    procedure SetHeight(Value: Integer);
    procedure SetLeft(Value: Integer);
    procedure SetOrigin(const Value: TPoint);
    procedure SetShowShadow(Value: Boolean);
    procedure SetTop(Value: Integer);
    procedure SetTransparent(Value: Boolean);
    procedure SetWidth(Value: Integer);
    procedure SetVisible(Value: Boolean);
  protected
    procedure BoundsChanged; virtual;
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); virtual;
    procedure DoExcludeFromClipRgn(DC: HDC; const R: TRect; var AResult: Integer);    

    function GetBackgroundBitmapTileBounds(Col, Row: Integer): TRect; virtual;
    function GetBackgroundBounds(DC: HDC): TRect; virtual;
    function GetBorderClass: TdxPSCellBorderClass; virtual;
    function GetBorderEdgeBounds(ASide: TdxCellSide; const AOuterRect: TRect): TRect; virtual;
    function GetBorderEdgeClass(ASide: TdxCellSide): TdxPSCellBorderClass; virtual;
    function GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer; virtual;
    function GetBorderEdgeThickness(ASide: TdxCellSide): Integer; virtual;
    function GetBorderBounds(DC: HDC): TRect; virtual;

    function GetBorderOuterBoundsRelativeTo(DC: HDC; const R: TRect): TRect;
    function GetInnerBoundsRelativeTo(DC: HDC; const R: TRect): TRect;
    function GetOuterBoundsRelativeTo(DC: HDC; const R: TRect): TRect;

    function GetBorderPainter: TdxPSCellBorderPainter;
    function GetBorderPainterClass: TdxPSCellBorderPainterClass; virtual;
    procedure InitBorderPainter(ABorderPainter: TdxPSCellBorderPainter); virtual;
    function HasBorderColoration: Boolean; virtual;

    function GetFormatBit(ABit: DWORD): Boolean;
    procedure SetFormatBit(ABit: DWORD; Value: Boolean);

    function GetContentBkColor: TColor; virtual;
    function GetContentPattern: TdxPSFillPatternClass; virtual;
    function GetShadowColor: TColor; virtual;
    function GetShadowDepth: Integer; virtual;
    procedure SetContentBkColor(Value: TColor); virtual;
    procedure SetContentPattern(Value: TdxPSFillPatternClass); virtual;
    procedure SetFontIndex(Value: Integer); virtual;
    procedure SetShadowColor(Value: TColor); virtual;
    procedure SetShadowDepth(Value: Integer); virtual;
 
    function IsBackgroundBitmapDrawn: Boolean; virtual;
    function IsBackgroundDrawn: Boolean; virtual;    
    function IsBordersDrawn: Boolean; virtual;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
    
    property BackgroundBitmapHeight: Integer read GetBackgroundBitmapHeight;
    property BackgroundBitmapTileBounds[Col, Row: Integer]: TRect read GetBackgroundBitmapTileBounds;
    property BackgroundBitmapTileOrigin: TPoint read GetBackgroundBitmapTileOrigin;
    property BackgroundBitmapTileStartIndexX: Integer read GetBackgroundBitmapTileStartIndexX;
    property BackgroundBitmapTileStartIndexY: Integer read GetBackgroundBitmapTileStartIndexY;
    property BackgroundBitmapTileStopIndexX: Integer read GetBackgroundBitmapTileStopIndexX;
    property BackgroundBitmapTileStopIndexY: Integer read GetBackgroundBitmapTileStopIndexY;
    property BackgroundBitmapWidth: Integer read GetBackgroundBitmapWidth;

    property Format: DWORD read FFormat write SetFormat;
    property IsPrinting: Boolean read GetIsPrinting;
    property LineThickness: Integer read GetLineThickness;
    property Renderer: TdxPSReportRenderer read GetRenderer;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    procedure AdjustContent(DC: HDC); virtual;

    procedure DrawBackground(DC: HDC); virtual;
    procedure DrawBackgroundBitmap(DC: HDC); virtual;
    procedure DrawBackgroundBitmapTile(DC: HDC; const Rect: TRect); virtual;
    procedure DrawBackgroundRect(DC: HDC; const R: TRect);
    procedure DrawBorders(DC: HDC); virtual;

    function GetBorderOuterBounds(DC: HDC): TRect; virtual;
    function GetInnerBounds(DC: HDC): TRect; virtual;
    function GetOuterBounds(DC: HDC): TRect; virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;

    function CalculateLineCount(DC: HDC): Integer; virtual;

    function MeasureBordersHeight(DC: HDC): Integer; virtual;
    function MeasureBordersWidth(DC: HDC): Integer; virtual;
    function MeasureContentHeight(DC: HDC): Integer; virtual;
    function MeasureContentWidth(DC: HDC): Integer; virtual;
    function MeasureFontHeight(DC: HDC): Integer; virtual;
    function MeasureHeight(DC: HDC): Integer; virtual;
    function MeasureWidth(DC: HDC): Integer; virtual;

    // for backward compatibility
    class function MapBorderClass(AEdgeMode: TdxCellEdgeMode; AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean): TdxPSCellBorderClass;

    property AbsoluteOrigin: TPoint read GetAbsoluteOrigin;
    property AbsoluteRect: TRect read GetAbsoluteRect;
    property BackgroundBitmap: TBitmap read GetBackgroundBitmap;
    property BackgroundBitmapIndex: Integer read FBackgroundBitmapIndex write SetBackgroundBitmapIndex;
    property BackgroundBitmapPool: TdxPSBackgroundBitmapPool read GetBackgroundBitmapPool;
    property BorderBrush: HBRUSH read GetBorderBrush;
    property BorderClass: TdxPSCellBorderClass read GetBorderClass write SetBorderClass;
    property BorderColor: TColor read GetBorderColor write FBorderColor; // clDefault;
    property BorderEdgeClasses[Side: TdxCellSide]: TdxPSCellBorderClass read GetBorderEdgeClass;
    property BorderEdgeSalients[Side: TdxCellSide; Salient: TdxPSCellBorderSalientType]: Integer read GetBorderEdgeSalient;
    property BorderEdgeThicknesses[Side: TdxCellSide]: Integer read GetBorderEdgeThickness;
    property BorderPainter: TdxPSCellBorderPainter read GetBorderPainter;
    property BorderPainterClass: TdxPSCellBorderPainterClass read GetBorderPainterClass;
    property BoundsRect: TRect read FBoundsRect write SetBoundsRect;
    property CellSides: TdxCellSides read GetCellSides write SetCellSides;     {csAll}
    property CellSideColors[ASide: TdxCellSide]: TColor read GetCellSideColors write SetCellSideColors;
    property Color: TColor read FColor write SetColor;
    property ContentBkColor: TColor read GetContentBkColor write SetContentBkColor;
    property ContentBrush: HBRUSH read GetContentBrush;
    property ContentPattern: TdxPSFillPatternClass read GetContentPattern write SetContentPattern;
    property Edge3DSoft: Boolean read GetEdge3DSoft write SetEdge3DSoft;             // obsolete - use BorderClass instead
    property Edge3DStyle: TdxCellEdgeStyle read GetEdge3DStyle write SetEdge3DStyle; // obsolete - use BorderClass instead 
    property EdgeMode: TdxCellEdgeMode read GetEdgeMode write SetEdgeMode;           // obsolete - use BorderClass instead 
    property ExcludeFromClipRgn: Boolean read GetExcludeFromClipRgn write SetExcludeFromClipRgn;
    property Font: TFont read GetFont write SetFont;
    property FontIndex: Integer read FFontIndex write SetFontIndex;
    property Height: Integer read GetHeight write SetHeight;
    property Left: Integer read GetLeft write SetLeft;
    property Origin: TPoint read GetOrigin write SetOrigin;
    property ParentBrush: HBRUSH read GetParentBrush;
    property ParentColor: TColor read GetParentColor;
    property ShadowBrush: HBRUSH read GetShadowBrush;
    property ShadowColor: TColor read GetShadowColor write SetShadowColor;
    property ShadowDepth: Integer read GetShadowDepth write SetShadowDepth;
    property ShowShadow: Boolean read GetShowShadow write SetShowShadow;
    property Top: Integer read GetTop write SetTop;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property Width: Integer read GetWidth write SetWidth;
    property Visible: Boolean read GetVisible write SetVisible;
  end;
             
  TdxReportCell = class(TdxReportVisualItem)
  private
    FCellList: TList;
    FDataList: TList;
    FReportCells: TdxReportCells;
    function GetAbsoluteIndex: Integer;
    function GetCellCount: Integer;
    function GetCell(Index: Integer): TdxReportCell;
    function GetClipChildren: Boolean;
    function GetDataItemCount: Integer;
    function GetDataItem(Index: Integer): TAbstractdxReportCellData;
    function GetIsTopLevel: Boolean;
    function GetLevel: Integer;
    function GetReportCells: TdxReportCells; override;
    procedure CellListNeeded;
    procedure CellListRelease;
    procedure DataListNeeded;
    procedure DataListRelease;
    procedure InsertCell(AnItem: TdxReportCell);
    procedure InsertDataItem(AnItem: TdxReportItem);
    procedure InsertItem(AnItem: TdxReportItem);
    procedure MoveCell(ACurIndex, ANewIndex: Integer);
    procedure MoveDataItem(ACurIndex, ANewIndex: Integer);
    procedure MoveItem(AnItem: TdxReportItem; ACurIndex, ANewIndex: Integer);
    procedure RemoveCell(AnItem: TdxReportCell);
    procedure RemoveDataItem(AnItem: TdxReportItem);
    procedure RemoveItem(AnItem: TdxReportItem);
    procedure SetClipChildren(Value: Boolean);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override; 
    function GetBackgroundBitmapTileBounds(Col, Row: Integer): TRect; override;
    function GetBackgroundBounds(DC: HDC): TRect; override;
    function GetBorderBounds(DC: HDC): TRect; override;
    class function IsCell: Boolean; override;
    
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    procedure ReadCells(AReader: TdxPSDataReader); virtual;
    procedure ReadDataItems(AReader: TdxPSDataReader); virtual;
    procedure ReadProperties(AReader: TdxPSDataReader); virtual;
    procedure WriteCells(AWriter: TdxPSDataWriter); virtual;
    procedure WriteDataItems(AWriter: TdxPSDataWriter); virtual; 
    procedure WriteProperties(AWriter: TdxPSDataWriter); virtual;    
  public
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure DrawContent(DC: HDC; DrawRect: TRect; const OriginRect: TRect; AStage: TdxPSRenderStages); virtual;
    procedure DrawItself(DC: HDC; AStage: TdxPSRenderStages); virtual;
    procedure DrawNestedCells(DC: HDC; DrawRect: TRect; const OriginRect: TRect; AStage: TdxPSRenderStages); virtual;
    procedure DrawNestedDataItems(DC: HDC; const OriginRect: TRect; AStage: TdxPSRenderStages); virtual;
    function ExcludeNestedItems(DC: HDC; const OriginRect: TRect): Integer; virtual;

    function GetBorderOuterBounds(DC: HDC): TRect; override;
    function GetInnerBounds(DC: HDC): TRect; override;
    function GetOuterBounds(DC: HDC): TRect; override;

    function MeasureHeight(DC: HDC): Integer; override;
    function MeasureWidth(DC: HDC): Integer; override;
    
    function AddCell: TdxReportCell;
    function AddDataItem(AClass: TdxReportCellDataClass): TAbstractdxReportCellData;
    procedure AllocateSpaceForCells(ACapacity: Integer);
    procedure AllocateSpaceForDatas(ACapacity: Integer);
    procedure ClearAll;
    procedure ClearCells;
    procedure ClearDataItems;
    procedure DeleteCell(Index: Integer);
    procedure DeleteDataItem(Index: Integer);
    function FirstCell: TdxReportCell;
    function HasChildren: Boolean;
    function IndexOf(AnItem: TdxReportItem): Integer;
    function LastCell: TdxReportCell;

    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property CellCount: Integer read GetCellCount;
    property Cells[Index: Integer]: TdxReportCell read GetCell; default;
    property ClipChildren: Boolean read GetClipChildren write SetClipChildren;
    property DataItemCount: Integer read GetDataItemCount;
    property DataItems[Index: Integer]: TAbstractdxReportCellData read GetDataItem;
    property IsTopLevel: Boolean read GetIsTopLevel;    
    property Level: Integer read GetLevel;
  end;

  TdxReportGroup = class;
  
  TdxPSReportGroupLookAndFeelPainter = class
  private
    FGroup: TdxReportGroup;
    FLookAndFeel: TdxPSReportGroupLookAndFeel; 
    FRenderer: TdxPSReportRenderer; 
  protected
    procedure DrawBorders(DC: HDC); virtual;
    procedure DrawCaptionText(DC: HDC); virtual;
    procedure Initialize(ALookAndFeel: TdxPSReportGroupLookAndFeel; AGroup: TdxReportGroup); virtual;

    function Group: TdxReportGroup; overload; virtual;
    function LookAndFeel: TdxPSReportGroupLookAndFeel; overload; virtual;
  public  
    constructor Create(ARenderer: TdxPSReportRenderer); virtual;
    procedure Paint(DC: HDC); virtual;
    property Renderer: TdxPSReportRenderer read FRenderer;
  end;
  
  TdxPSReportGroupLookAndFeel = class(TPersistent)
  private
    FCaptionHeight: Integer;
    FCaptionFontIndex: Integer;
    FCaptionIndent: Integer;
    FColor: TColor;
    FData: Pointer;
    FFontIndex: Integer;
    FReportCells: TdxReportCells;
    function GetCaptionFont: TFont;
    function GetFont: TFont;
    function GetRenderer: TdxPSReportRenderer;
    procedure SetCaptionFont(Value: TFont);
    procedure SetCaptionFontIndex(Value: Integer);
    procedure SetFont(Value: TFont);
    procedure SetFontIndex(Value: Integer);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); virtual;

    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;

    function GetBorderEdgeThickness(AGroup: TdxReportGroup; ASide: TdxCellSide): Integer; virtual;    
    function GetBorderThickness: Integer; virtual;
    function GetColor: TColor; virtual;
    procedure SetBorderThickness(Value: Integer); virtual;

    function GetCaptionAreaHeight(AGroup: TdxReportGroup): Integer; virtual;
    function GetCaptionBounds(AGroup: TdxReportGroup): TRect; virtual;
    function GetCaptionColor: TColor; virtual;
    function GetCaptionHeight(AGroup: TdxReportGroup): Integer; virtual;
    function GetCaptionIndent: Integer; virtual;
    function GetCaptionLeftRestSpaceBounds(AGroup: TdxReportGroup): TRect; virtual;
    function GetCaptionRightRestSpaceBounds(AGroup: TdxReportGroup): TRect; virtual;
    function GetCaptionTextBounds(AGroup: TdxReportGroup): TRect; virtual;
    
    function GetPainter: TdxPSReportGroupLookAndFeelPainter;    
    class function GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass; virtual;
    
    property BorderThickness: Integer read GetBorderThickness write SetBorderThickness;
    property CaptionColor: TColor read GetCaptionColor;
    property CaptionIndent: Integer read GetCaptionIndent;
    property Renderer: TdxPSReportRenderer read GetRenderer;
    property ReportCells: TdxReportCells read FReportCells;
  public
    constructor Create(AReportCells: TdxReportCells); virtual;
    procedure Assign(Source: TPersistent); override;
    
    class function BorderClass: TdxPSCellBorderClass; virtual;
    class function DefaultBorderSides: TdxCellSides; virtual;
    class function Name: string; virtual;
    
    class procedure Register; virtual;
    class procedure Unregister; virtual;

    procedure Paint(DC: HDC; AGroup: TdxReportGroup);
    procedure Prepare(DC: HDC); virtual;

    property CaptionFont: TFont read GetCaptionFont write SetCaptionFont;
    property CaptionFontIndex: Integer read FCaptionFontIndex write SetCaptionFontIndex;
    property Color: TColor read GetColor write FColor;
    property Data: Pointer read FData write FData;
    property Font: TFont read GetFont write SetFont;
    property FontIndex: Integer read FFontIndex write SetFontIndex;
  end;

  TdxPSReportGroupNullLookAndFeel = class;
  
  TdxPSReportGroupNullLookAndFeelPainter = class(TdxPSReportGroupLookAndFeelPainter)
  public
    procedure Paint(DC: HDC); override;
  end;  
  
  TdxPSReportGroupNullLookAndFeel = class(TdxPSReportGroupLookAndFeel)
  protected
    function GetBorderThickness: Integer; override;
    function GetCaptionHeight(AGroup: TdxReportGroup): Integer; override;
    class function GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass; override;
  public
    class function BorderClass: TdxPSCellBorderClass; override;
    class function DefaultBorderSides: TdxCellSides; override;
    class function Name: string; override;
  end;
  
  TdxPSReportGroupStandardLookAndFeel = class;
  
  TdxPSReportGroupStandardLookAndFeelPainter = class(TdxPSReportGroupLookAndFeelPainter)
  protected
    procedure DrawBorders(DC: HDC); override;
    procedure DrawCaptionRestSpace(DC: HDC); virtual;
    function LookAndFeel: TdxPSReportGroupStandardLookAndFeel; reintroduce; overload;
  public
    procedure Paint(DC: HDC); override;
  end;
  
  TdxPSReportGroupStandardLookAndFeel = class(TdxPSReportGroupLookAndFeel)
  protected
    class function GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass; override;
  public
    class function BorderClass: TdxPSCellBorderClass; override;  
    class function Name: string; override;

    property CaptionFont;
    property CaptionFontIndex;
  end;

  TdxPSReportGroupOfficeLookAndFeel = class(TdxPSReportGroupStandardLookAndFeel)
  protected
    function GetCaptionIndent: Integer; override;  
  public
    class function DefaultBorderSides: TdxCellSides; override;
    class function Name: string; override;
  end;
  
  TdxPSReportGroupWebLookAndFeel = class;
  
  TdxPSReportGroupWebLookAndFeelPainter = class(TdxPSReportGroupLookAndFeelPainter)
  protected
    procedure DrawBorders(DC: HDC); override;
    procedure DrawCaptionSeparator(DC: HDC); virtual;
    function LookAndFeel: TdxPSReportGroupWebLookAndFeel; reintroduce; overload;
  public
    procedure Paint(DC: HDC); override;
  end;
  
  TdxPSReportGroupWebLookAndFeel = class(TdxPSReportGroupLookAndFeel)
  private
    FBorderColor: TColor;
    FBorderThickness: Integer;
    FCaptionColor: TColor;
    FCaptionSeparatorColor: TColor;
    FCaptionSeparatorThickness: Integer;
    procedure SetCaptionSeparatorThickness(Value: Integer);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    function GetBorderEdgeThickness(AGroup: TdxReportGroup; ASide: TdxCellSide): Integer; override;
    function GetBorderThickness: Integer; override;
    procedure SetBorderThickness(Value: Integer); override;

    function GetBorderColor: TColor; virtual;
    function GetCaptionColor: TColor; override;
    function GetCaptionSeparatorColor: TColor; virtual;
    
    function GetCaptionAreaHeight(AGroup: TdxReportGroup): Integer; override;
    function GetCaptionBounds(AGroup: TdxReportGroup): TRect; override;
    function GetCaptionLeftRestSpaceBounds(AGroup: TdxReportGroup): TRect; override;
    function GetCaptionRightRestSpaceBounds(AGroup: TdxReportGroup): TRect; override;
    function GetCaptionSeparatorBounds(AGroup: TdxReportGroup): TRect; virtual;
    function GetCaptionTextBounds(AGroup: TdxReportGroup): TRect; override;
    
    class function GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass; override;
  public
    constructor Create(AReportCells: TdxReportCells); override;
    procedure Assign(Source: TPersistent); override;

    class function BorderClass: TdxPSCellBorderClass; override;  
    class function Name: string; override;
    
    property BorderColor: TColor read GetBorderColor write FBorderColor;
    property BorderThickness;
    property CaptionColor write FCaptionColor;
    property CaptionFont;
    property CaptionSeparatorColor: TColor read GetCaptionSeparatorColor write FCaptionSeparatorColor;
    property CaptionSeparatorThickness: Integer read FCaptionSeparatorThickness write SetCaptionSeparatorThickness;
  end;
  
  TdxReportGroup = class(TdxReportCell)
  private
    FCaptionText: string;
    FCaptionTextWidth: Integer;
    FLookAndFeel: TdxPSReportGroupLookAndFeel;
    //FStreamedLookAndFeelIndex: Integer;
    function GetCaptionAlignment: TcxTextAlignX;
    function GetCaptionTextWidth: Integer;
    function GetCaptionTransparent: Boolean;
    function GetLookAndFeel: TdxPSReportGroupLookAndFeel;
    function GetLookAndFeelIndex: Integer;
    function GetShowCaption: Boolean;
    function GetUseOwnBorderClass: Boolean;
    procedure SetCaptionAlignment(Value: TcxTextAlignX);
    procedure SetCaptionTransparent(Value: Boolean);
    procedure SetLookAndFeel(Value: TdxPSReportGroupLookAndFeel);
    procedure SetShowCaption(Value: Boolean);
    procedure SetUseOwnBorderClass(Value: Boolean);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;
    procedure InternalDrawBorders(DC: HDC); virtual;
    
    function GetBorderClass: TdxPSCellBorderClass; override;
    function GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer; override;
    function GetBorderEdgeThickness(ASide: TdxCellSide): Integer; override;
    function InternalGetBorderEdgeThickness(ASide: TdxCellSide): Integer;

    function IsBordersDrawn: Boolean; override;
    
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property CaptionTextWidth: Integer read GetCaptionTextWidth;
    property LookAndFeelIndex: Integer read GetLookAndFeelIndex;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    procedure DrawBorders(DC: HDC); override;
    
    procedure CalculateCaptionTextWidth(DC: HDC);
    function GetBorderOuterBounds(DC: HDC): TRect; override;

    property CaptionAlignment: TcxTextAlignX read GetCaptionAlignment write SetCaptionAlignment;
    property CaptionText: string read FCaptionText write FCaptionText;
    property CaptionTransparent: Boolean read GetCaptionTransparent write SetCaptionTransparent;
    property LookAndFeel: TdxPSReportGroupLookAndFeel read GetLookAndFeel write SetLookAndFeel;
    property ShowCaption: Boolean read GetShowCaption write SetShowCaption;
    property UseOwnBorderClass: Boolean read GetUseOwnBorderClass write SetUseOwnBorderClass;
  end;
  
  TdxReportCells = class(TPersistent)
  private
    FBorderColor: TColor;
    FBorderWidth: Integer;
    FCells: TdxReportCell;
    FExpandButtonBorderColor: TColor;
    FFooterCells: TdxReportCell;
    FGroupBorderColor: TColor;
    FGroupCaptionColor: TColor;
    FGroupCaptionSeparatorColor: TColor;
    FGroupColor: TColor;
    FHeaderCells: TdxReportCell;
    FImageLists: TList;
    FLookAndFeel: TdxPSReportGroupLookAndFeel;
    FLookAndFeels: TList;
    FOverlays: TList;
    FOwnImageLists: Boolean;
    FShadowColor: TColor;
    FShadowDepth: Integer;
    FReportLink: TBasedxReportLink;
    FTreeLineColor: TColor;
    FTreeLineStyle: TdxPSTreeLineStyle;
    function GetAreFooterCellsAllocated: Boolean;
    function GetAreHeaderCellsAllocated: Boolean;    
    function GetBoundsRect: TRect;
    function GetCount: Integer;
    function GetFont: TFont;
    function GetFooterBoundsRect: TRect;
    function GetFooterCellCount: Integer;
    function GetFooterCells: TdxReportCell;
    function GetHeaderBoundsRect: TRect;
    function GetHeaderCellCount: Integer;
    function GetHeaderCells: TdxReportCell;
    function GetImageList(Index: Integer): TCustomImageList;
    function GetImageListCount: Integer;
    function GetLookAndFeel(Index: Integer): TdxPSReportGroupLookAndFeel;
    function GetLookAndFeelCount: Integer;
    function GetOverlay(Index: Integer): TdxReportCell;
    function GetOverlayCount: Integer;
    function GetRenderer: TdxPSReportRenderer;
    procedure SetBorderColor(Value: TColor);
    procedure SetShadowColor(Value: TColor);
    procedure SetShadowDepth(Value: Integer);
    procedure SetTreeLineColor(Value: TColor);
    
    procedure CreateFooterCells;
    procedure CreateHeaderCells;
  protected
    procedure AfterReadData(AReader: TdxPSDataReader); virtual;
    procedure AfterWriteData(AWriter: TdxPSDataWriter); virtual;
    procedure BeforeReadData(AReader: TdxPSDataReader); virtual;
    procedure BeforeWriteData(AWriter: TdxPSDataWriter); virtual;
    
    procedure ReadCells(AReader: TdxPSDataReader);
    procedure ReadHeaderCells(AReader: TdxPSDataReader);
    procedure ReadFooterCells(AReader: TdxPSDataReader);
    procedure ReadImageLists(AReader: TdxPSDataReader);
    procedure ReadLookAndFeels(AReader: TdxPSDataReader);
    procedure ReadOverlayCells(AReader: TdxPSDataReader);
    procedure ReadProperties(AReader: TdxPSDataReader);
    
    procedure WriteCells(AWriter: TdxPSDataWriter);
    procedure WriteFooterCells(AWriter: TdxPSDataWriter);
    procedure WriteHeaderCells(AWriter: TdxPSDataWriter);
    procedure WriteImageLists(AWriter: TdxPSDataWriter);
    procedure WriteLookAndFeels(AWriter: TdxPSDataWriter);
    procedure WriteOverlayCells(AWriter: TdxPSDataWriter);
    procedure WriteProperties(AWriter: TdxPSDataWriter);
    
    function CalculateOverlaysHeight: Integer;
    function CalculateOverlaysWidth: Integer;
    function CalculateTotalHeight: Integer;
    function CalculateTotalWidth: Integer;
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); virtual;
    function GetCellTopLevelParent(AnItem: TdxReportItem): TdxReportCell; virtual;

    procedure FreeAndNilReportGroupLookAndFeels;
    procedure PrepareReportGroupsLookAndFeels(DC: HDC);
        
    procedure AddImageList(AnImageList: TCustomImageList);
    procedure ClearImageLists;
    procedure FreeAndNilImageLists;
    procedure GetImageLists;

    property ImageListCount: Integer read GetImageListCount;
    property OwnImageLists: Boolean read FOwnImageLists write FOwnImageLists;
    property Renderer: TdxPSReportRenderer read GetRenderer;
  public
    constructor Create(AReportLink: TBasedxReportLink); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure ClearItems;

    procedure ClearLookAndFeels;
    function CreateGroupLookAndFeel(AClass: TdxPSReportGroupLookAndFeelClass; ACheckExisting: Boolean = True): TdxPSReportGroupLookAndFeel;
    function FindGroupLookAndFeelByClass(AClass: TdxPSReportGroupLookAndFeelClass): TdxPSReportGroupLookAndFeel;
    function FindGroupLookAndFeelByData(AData: Pointer): TdxPSReportGroupLookAndFeel;
    function IndexOfImageList(AnImageList: TCustomImageList): Integer;
    function IndexOfReportGroupLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel): Integer;

    procedure DoProgress(const APercentDone: Double);

    function AddOverlay: TdxReportCell;
    procedure AppendOverlays(Source: TdxReportCells; AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
    procedure AssignOverlays(Source: TdxReportCells; AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
    procedure ClearOverlays;
    procedure DeleteOverlay(AnOverlay: TdxReportCell);
    procedure FreeAndNilOverlays;
    function HasOverlays: Boolean;
    function IndexOfOverlay(AnOverlay: TdxReportCell): Integer;
    
    function GetFontByIndex(AnIndex: Integer): TFont;
    function GetIndexByFont(AFont: TFont): Integer;
    
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;

    property AreFooterCellsAllocated: Boolean read GetAreFooterCellsAllocated;
    property AreHeaderCellsAllocated: Boolean read GetAreHeaderCellsAllocated;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BorderWidth: Integer read FBorderWidth write FBorderWidth;
    property BoundsRect: TRect read GetBoundsRect;
    property Cells: TdxReportCell read FCells;
    property Count: Integer read GetCount;
    property ExpandButtonBorderColor: TColor read FExpandButtonBorderColor write FExpandButtonBorderColor default clBlack;
    property Font: TFont read GetFont;
    property FooterBoundsRect: TRect read GetFooterBoundsRect;
    property FooterCellCount: Integer read GetFooterCellCount;
    property FooterCells: TdxReportCell read GetFooterCells;
    property GroupBorderColor: TColor read FGroupBorderColor write FGroupBorderColor;
    property GroupCaptionColor: TColor read FGroupCaptionColor write FGroupCaptionColor;
    property GroupCaptionSeparatorColor: TColor read FGroupCaptionSeparatorColor write FGroupCaptionSeparatorColor;
    property GroupColor: TColor read FGroupColor write FGroupColor;
    property HeaderBoundsRect: TRect read GetHeaderBoundsRect;
    property HeaderCellCount: Integer read GetHeaderCellCount;
    property HeaderCells: TdxReportCell read GetHeaderCells;
    property ImageLists[Index: Integer]: TCustomImageList read GetImageList;
    property LookAndFeel: TdxPSReportGroupLookAndFeel read FLookAndFeel write FLookAndFeel;
    property LookAndFeelCount: Integer read GetLookAndFeelCount;
    property LookAndFeels[Index: Integer]: TdxPSReportGroupLookAndFeel read GetLookAndFeel;
    property OverlayCount: Integer read GetOverlayCount;
    property Overlays[Index: Integer]: TdxReportCell read GetOverlay;
    property ReportLink: TBasedxReportLink read FReportLink;
    property ShadowColor: TColor read FShadowColor write SetShadowColor;
    property ShadowDepth: Integer read FShadowDepth write SetShadowDepth;
    property TreeLineColor: TColor read FTreeLineColor write SetTreeLineColor;
    property TreeLineStyle: TdxPSTreeLineStyle read FTreeLineStyle write FTreeLineStyle default tlsDot;
  end;
  
  TAbstractdxReportCellData = class(TdxReportVisualItem)
  private
    function GetBreakByChars: Boolean;
    function GetEndEllipsis: Boolean;
    function GetHidePrefix: Boolean;
    function GetMultiline: Boolean;
    function GetPreventLeftTextExceed: Boolean;
    function GetPreventTopTextExceed: Boolean;
    function GetSortOrder: TdxCellSortOrder;
    function GetTextAlignX: TcxTextAlignX;
    function GetTextAlignY: TcxTextAlignY;
    procedure SetBreakByChars(Value: Boolean);
    procedure SetEndEllipsis(Value: Boolean);
    procedure SetHidePrefix(Value: Boolean);
    procedure SetMultiline(Value: Boolean);
    procedure SetPreventLeftTextExceed(Value: Boolean);
    procedure SetPreventTopTextExceed(Value: Boolean);
    procedure SetSortOrder(Value: TdxCellSortOrder);
    procedure SetTextAlignX(Value: TcxTextAlignX);
    procedure SetTextAlignY(Value: TcxTextAlignY);
  protected
    function CustomDraw(DC: HDC): Boolean; virtual;
    function GetAbsoluteEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect; virtual;    
    function GetDefaultDTFormat: DWORD; virtual;
    function GetEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect; virtual;
    function GetDTFormat: DWORD; virtual;
    function IsCustomDrawn: Boolean; virtual;
    function IsDrawingNeeded(DC: HDC; AStage: TdxPSRenderStages; const ARect: TRect): Boolean; virtual;
    function IsDrawn(DC: HDC; AStage: TdxPSRenderStages; const ARect: TRect): Boolean; virtual;

    property BreakByChars: Boolean read GetBreakByChars write SetBreakByChars default True;
    property EndEllipsis: Boolean read GetEndEllipsis write SetEndEllipsis default False;
    property HidePrefix: Boolean read GetHidePrefix write SetHidePrefix default False;
    property Multiline: Boolean read GetMultiline write SetMultiline default False;
    property PreventLeftTextExceed: Boolean read GetPreventLeftTextExceed write SetPreventLeftTextExceed;
    property PreventTopTextExceed: Boolean read GetPreventTopTextExceed write SetPreventTopTextExceed;    
    property SortOrder: TdxCellSortOrder read GetSortOrder write SetSortOrder default csoNone;
    property TextAlignX: TcxTextAlignX read GetTextAlignX write SetTextAlignX default taLeft;
    property TextAlignY: TcxTextAlignY read GetTextAlignY write SetTextAlignY default taCenterY;
  public
    constructor Create(AParent: TdxReportCell); override;

    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); virtual;
    function GetCustomDrawID: Integer; virtual;
    
    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;

    property DefaultDTFormat: DWORD read GetDefaultDTFormat;
    property DTFormat: DWORD read GetDTFormat;
  end;

  TdxReportCellBoxClass = class of TdxReportCellBox;

  TdxReportCellBox = class(TAbstractdxReportCellData);

  TdxReportCellTextClass = class of TdxReportCellText;

  TdxReportCellText = class(TAbstractdxReportCellData)
  private
    FIndent: Cardinal;
    FSortMarkRegionSize: Integer;
    function GetAdjustFont: Boolean;
    function GetIndent: Integer;
    function GetSortMarkRegionSize: Integer;
    procedure SetAdjustFont(Value: Boolean);
    procedure SetIndent(Value: Integer);
  protected
    function GetText: string; virtual; abstract;
    procedure SetText(const Value: string); virtual; abstract;

    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;
    function GetSortMarkBounds(DC: HDC): TRect; virtual;
    function GetTextBounds(DC: HDC): TRect; virtual;
    function IsSortMarkDrawn: Boolean; virtual;
    function IsTextDrawn: Boolean; virtual;

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property AdjustFont: Boolean read GetAdjustFont write SetAdjustFont;
    property Indent: Integer read GetIndent write SetIndent;
    property SortMarkRegionSize: Integer read GetSortMarkRegionSize;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;
    procedure DrawSortMark(DC: HDC); virtual;
    procedure DrawText(DC: HDC); virtual;

    function CalculateLineCount(DC: HDC): Integer; override;
    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;
    function MeasureFontHeight(DC: HDC): Integer; override;

    property EndEllipsis;
    property HidePrefix;
    property Multiline;
    property SortOrder;
    property Text: string read GetText write SetText;
  end;

  TdxReportCellStringClass = class of TdxReportCellString;
    
  TdxReportCellString = class(TdxReportCellText)
  private
    FText: string;
  protected
    function GetText: string; override;
    procedure SetText(const Value: string); override;
  public
    property AdjustFont;
    property Indent;
    property PreventLeftTextExceed;
    property PreventTopTextExceed;
    property TextAlignX;
    property TextAlignY;
  end;

  TdxReportCellImageContainer = class(TdxReportCellString)
  private
    function GetImageTransparent: Boolean;    
    procedure SetImageTransparent(Value: Boolean);
  protected
    function GetImageAreaBounds(DC: HDC): TRect; virtual;
    function GetImageBounds(DC: HDC): TRect; virtual;
    procedure GetImageSizes(var AImageWidth, AImageHeight: Integer); virtual;
    function HasImage: Boolean; virtual;
    function IsImageBackgroundDrawn: Boolean; virtual;
    function IsImageDrawn: Boolean; virtual;
    function IsTextBackgroundDrawn: Boolean; virtual;
    property ImageTransparent: Boolean read GetImageTransparent write SetImageTransparent default True;    
  public  
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;  
    procedure DrawImage(DC: HDC); virtual;
    procedure DrawImageBackground(DC: HDC); virtual;
    procedure DrawTextBackground(DC: HDC); virtual;
  end;
        
  TdxCustomReportCellCheckClass = class of TdxCustomReportCellCheck;
        
  TdxCustomReportCellCheck = class(TdxReportCellImageContainer)
  private
    function GetBoldBorder: Boolean;
    function GetButtonEdgeStyle: TdxCheckButtonEdgeStyle;
    function GetChecked: Boolean;
    function GetCheckPos: TdxCellCheckPos;
    function GetEnabled: Boolean;
    function GetFlatBorder: Boolean;
    function GetState: TCheckBoxState;
    procedure SetBoldBorder(Value: Boolean);
    procedure SetButtonEdgeStyle(Value: TdxCheckButtonEdgeStyle);
    procedure SetCheckPos(Value: TdxCellCheckPos);
    procedure SetEnabled(Value: Boolean);
    procedure SetFlatBorder(Value: Boolean);
  protected
    function GetCheckBounds(DC: HDC): TRect; virtual;
    function GetImageAreaBounds(DC: HDC): TRect; override;
    function GetImageBounds(DC: HDC): TRect; override;
    procedure GetImageSizes(var AImageWidth, AImageHeight: Integer); override;
    function GetTextBounds(DC: HDC): TRect; override;
    function HasImage: Boolean; override;
    function IsImageBackgroundDrawn: Boolean; override;
    class function IsRadio: Boolean; virtual;
    procedure SetChecked(Value: Boolean); virtual;
    
    property BoldBorder: Boolean read GetBoldBorder write SetBoldBorder;  // obsolete
    property FlatBorder: Boolean read GetFlatBorder write SetFlatBorder; // obsolete
    property State: TCheckBoxState read GetState;
  public
    constructor Create(AParent: TdxReportCell); override;

    procedure DrawCheck(DC: HDC); virtual;
    procedure DrawImage(DC: HDC); override;
    
    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;

    property ButtonEdgeStyle: TdxCheckButtonEdgeStyle read GetButtonEdgeStyle write SetButtonEdgeStyle default cbesUltraFlat;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property CheckPos: TdxCellCheckPos read GetCheckPos write SetCheckPos default ccpCenter;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
  end;

  TdxReportCellCheck = class(TdxCustomReportCellCheck)
  public
    property BoldBorder;
    property FlatBorder;
    property State;
  end;

  TdxCustomReportCellRadio = class(TdxReportCellCheck)
  protected
    class function IsRadio: Boolean; override;
  end;
  
  TdxReportCellRadio = class(TdxCustomReportCellRadio)
  end;
  
  TdxCustomReportCellCheckImage = class(TdxReportCellCheck)
  private
    function GetGlyphPartialBounds: TRect;
  protected
    procedure GetImageSizes(var AImageWidth, AImageHeight: Integer); override;

    function GetGlyph: TBitmap; virtual;
    function GetGlyphCount: Integer; virtual;
    function GetGlyphIndex: Integer; virtual;    
    procedure SetGlyph(Value: TBitmap); virtual;
    procedure SetGlyphCount(Value: Integer); virtual;

    function HasGlyph: Boolean; virtual;
    procedure ReleaseGlyph; virtual;
    
    procedure ReadData(AReader: TdxPSDataReader); override;    
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read GetGlyphCount write SetGlyphCount;
    property GlyphIndex: Integer read GetGlyphIndex;
    property GlyphPartialBounds: TRect read GetGlyphPartialBounds;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure DrawCheck(DC: HDC); override;
    procedure DrawCheckGlyph(DC: HDC); virtual;
  end;

  TdxReportCellCheckImage = class(TdxCustomReportCellCheckImage)
  private
    FGlyph: TBitmap;
  protected
    function GetGlyphCount: Integer; override;
    function GetGlyph: TBitmap; override;
    procedure SetGlyph(Value: TBitmap); override;
    procedure SetGlyphCount(Value: Integer); override;

    function HasGlyph: Boolean; override;
    procedure ReleaseGlyph; override;
  public  
    property Glyph;
    property GlyphCount;
    property GlyphIndex;
    property GlyphPartialBounds;
  end;

  TdxCustomReportButtonGroupClass = class of TdxCustomReportButtonGroup;
  
  TdxCustomReportButtonGroup = class(TdxReportGroup)
  private
    FColumnCount: Integer;
    FInterColumnsMinSpace: Integer;
    FInterRowsMinSpace: Integer;
    FIndents: TRect;
    FItemSize: TSize;
    function GetButtonEdgeStyle: TdxCheckButtonEdgeStyle;
    function GetCheckPos: TdxCellCheckPos;
    function GetItem(Index: Integer): TdxCustomReportCellCheck;
    function GetItemColumn(Index: Integer): Integer;
    function GetItemCount: Integer;
    function GetItemRow(Index: Integer): Integer;
    function GetRowCount: Integer;
    procedure SetButtonEdgeStyle(Value: TdxCheckButtonEdgeStyle);
    procedure SetCheckPos(Value: TdxCellCheckPos);
    procedure SetColumnCount(Value: Integer);
    procedure SetInterColumnsMinSpace(Value: Integer);
    procedure SetInterRowsMinSpace(Value: Integer);
    procedure SetIndents(Value: TRect);
  protected
    FLocked: Boolean;
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;
    procedure SetFontIndex(Value: Integer); override;
    
    procedure ReadDataItems(AReader: TdxPSDataReader); override;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    class function GetItemClass: TdxCustomReportCellCheckClass; virtual;
    procedure InitializeItem(AnItem: TdxCustomReportCellCheck); virtual;
    
    property ItemSize: TSize read FItemSize;
    property Locked: Boolean read FLocked write FLocked;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;    

    procedure AdjustContent(DC: HDC); override;
    
    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;
    
    function Add(const AText: string = ''): TdxCustomReportCellCheck;
    procedure Clear;
    procedure Delete(Index: Integer);
    function FindItem(const ACaption: string): Integer;

    property ButtonEdgeStyle: TdxCheckButtonEdgeStyle read GetButtonEdgeStyle write SetButtonEdgeStyle default cbesUltraFlat;
    property CheckPos: TdxCellCheckPos read GetCheckPos write SetCheckPos default ccpCenter;
    property ColumnCount: Integer read FColumnCount write SetColumnCount;
    property Indents: TRect read FIndents write SetIndents;
    property InterColumnsMinSpace: Integer read FInterColumnsMinSpace write SetInterColumnsMinSpace;
    property InterRowsMinSpace: Integer read FInterRowsMinSpace write SetInterRowsMinSpace;
    property ItemColumns[Index: Integer]: Integer read GetItemColumn;
    property ItemCount: Integer read GetItemCount;
    property ItemRows[Index: Integer]: Integer read GetItemRow;
    property Items[Index: Integer]: TdxCustomReportCellCheck read GetItem;
    property RowCount: Integer read GetRowCount;
  end;

  TdxReportRadioGroup = class(TdxCustomReportButtonGroup)
  private
    function GetItem(Index: Integer): TdxCustomReportCellRadio;
    function GetItemIndex: Integer;
    procedure SetItemIndex(Value: Integer);
  protected
    class function GetItemClass: TdxCustomReportCellCheckClass; override;
  public
    function Add(const AText: string = ''): TdxCustomReportCellRadio;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Items[Index: Integer]: TdxCustomReportCellRadio read GetItem;
  end;

  TdxReportCheckGroup = class(TdxCustomReportButtonGroup)
  private
    FGlyph: TBitmap;
    FGlyphCount: Integer;
    function GetGlyph: TBitmap;
    function GetItem(Index: Integer): TdxCustomReportCellCheckImage;
    function GetItemChecked(Index: Integer): Boolean;
    function GetItemEnabled(Index: Integer): Boolean;
    function GetItemState(Index: Integer): TCheckBoxState;
    procedure SetGlyph(Value: TBitmap);
    procedure SetGlyphCount(Value: Integer);
    procedure SetItemChecked(Index: Integer; Value: Boolean);
    procedure SetItemEnabled(Index: Integer; Value: Boolean);
  protected
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    class function GetItemClass: TdxCustomReportCellCheckClass; override;
    procedure InitializeItem(AnItem: TdxCustomReportCellCheck); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    
    function Add(const AText: string = ''): TdxCustomReportCellCheckImage;
    function HasGlyph: Boolean;
    procedure ReleaseGlyph;

    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property GlyphCount: Integer read FGlyphCount write SetGlyphCount;
    property Items[Index: Integer]: TdxCustomReportCellCheckImage read GetItem;
    property ItemsChecked[Index: Integer]: Boolean read GetItemChecked write SetItemChecked;
    property ItemsEnabled[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
    property ItemsState[Index: Integer]: TCheckBoxState read GetItemState;
  end;
    
  TCustomdxReportCellImageContainer = class(TdxReportCellImageContainer) 
  private
    FImage: TGraphic;
    FImageIndex: Integer;
    FImageList: TCustomImageList;
    FOverlayImageIndex: Integer;
    procedure SetImage(Value: TGraphic);
  protected
    function GetActualImageBuffering: TdxCellImageActualBuffering; virtual;
    function GetImageBuffering: TdxCellImageBuffering; virtual;
    procedure GetImageSizes(var AImageWidth, AImageHeight: Integer); override;
    function HasImage: Boolean; override;
    procedure PrepareImage;
    procedure SetImageBuffering(Value: TdxCellImageBuffering); virtual;

    function GetImageListIndex: Integer;
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;

    property ActualImageBuffering: TdxCellImageActualBuffering read GetActualImageBuffering;
    property ImageBuffering: TdxCellImageBuffering read GetImageBuffering write SetImageBuffering;
  public
    constructor Create(AParent: TdxReportCell); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    
    function CreateImage(AGraphicClass: TGraphicClass): TGraphic; virtual;
    procedure DrawImage(DC: HDC); override;

    property Image: TGraphic read FImage write SetImage;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property ImageList: TCustomImageList read FImageList write FImageList;
    property ImageTransparent;
    property OverlayImageIndex: Integer read FOverlayImageIndex write FOverlayImageIndex;
  end;

  TdxReportCellImageClass = class of TdxReportCellImage;
                         
  TdxReportCellImage = class(TCustomdxReportCellImageContainer)
  private                                  
    function GetImageLayout: TdxImageLayout;    
    function GetIsTextDrawnForCenteredImage: Boolean;
    function GetIsTextShiftedForHorizontallyCenteredImage: Boolean;
    function GetMakeSpaceForEmptyImage: Boolean;
    procedure SetImageLayout(Value: TdxImageLayout);
    procedure SetIsTextDrawnForCenteredImage(Value: Boolean);
    procedure SetIsTextShiftedForHorizontallyCenteredImage(Value: Boolean);
    procedure SetMakeSpaceForEmptyImage(Value: Boolean);
  protected
    function GetHalfContentWidth(DC: HDC): Integer;
    function GetImageAreaBounds(DC: HDC): TRect; override;
    function GetImageBounds(DC: HDC): TRect; override;
    function GetTextBounds(DC: HDC): TRect; override;
    function IsImageBackgroundDrawn: Boolean; override;
    function IsTextDrawn: Boolean; override;
    function IsTextBackgroundDrawn: Boolean; override;
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;

    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;
    
    property ImageLayout: TdxImageLayout read GetImageLayout write SetImageLayout default ilImageCenterLeft;
    property ImageTransparent;
    property IsTextDrawnForCenteredImage: Boolean read GetIsTextDrawnForCenteredImage write SetIsTextDrawnForCenteredImage default False;
    property IsTextShiftedForHorizontallyCenteredImage: Boolean read GetIsTextShiftedForHorizontallyCenteredImage write SetIsTextShiftedForHorizontallyCenteredImage default True;
    property MakeSpaceForEmptyImage: Boolean read GetMakeSpaceForEmptyImage write SetMakeSpaceForEmptyImage default True;
  end;

  TdxReportCellGraphicClass = class of TdxReportCellGraphic;
  
  TdxReportCellGraphic = class(TCustomdxReportCellImageContainer)
  private
    FCenter: Boolean;
    FProportional: Boolean;
    FStretch: Boolean;
    procedure CalculateDrawMode;
    function GetImage: TGraphic;
    function GetDrawMode: TdxGraphicDrawMode;
    function GetRealStretch: Boolean;
    procedure SetImage(Value: TGraphic);
    procedure SetCenter(Value: Boolean);
    procedure SetDrawMode(Value: TdxGraphicDrawMode);
    procedure SetProportional(Value: Boolean);
    procedure SetStretch(Value: Boolean);
  protected
    function GetImageBounds(DC: HDC): TRect; override;
    function GetImageBuffering: TdxCellImageBuffering; override;
    function GetTextBounds(DC: HDC): TRect; override;
    procedure SetImageBuffering(Value: TdxCellImageBuffering); override;
  public
    constructor Create(AParent: TdxReportCell); override;
    //procedure Assign(Source: TPersistent); override;

    function MeasureFontHeight(DC: HDC): Integer; override;
    function MeasureContentHeight(DC: HDC): Integer; override;
    function MeasureContentWidth(DC: HDC): Integer; override;

    property Center: Boolean read FCenter write SetCenter;
    property DrawMode: TdxGraphicDrawMode read GetDrawMode write SetDrawMode default gdmNone;
    property Image: TGraphic read GetImage write SetImage;
    property ImageBuffering;
    property ImageTransparent;
    property Proportional: Boolean read FProportional write SetProportional;
    property RealStretch: Boolean read GetRealStretch;
    property Stretch: Boolean read FStretch write SetStretch;
  end;

  TdxReportCellExpandButtonAlignHorz = (bahLeft, bahCenter, bahRight);
  TdxReportCellExpandButtonAlignVert = (bavTop, bavCenter, bavBottom);
  
  TdxReportCellExpandButtonClass = class of TdxReportCellExpandButton;
  
  TdxReportCellExpandButton = class(TAbstractdxReportCellData)
  private
    FButtonInteriorColor: TColor;
    FButtonSize: Integer;
    function GetActualButtonSize: Integer;
    function GetButtonBorder3D: Boolean;
    function GetButtonBorder3DSoft: Boolean;
    function GetButtonBorderShadow: Boolean;
    function GetButtonExpanded: Boolean;
    function GetButtonTransparent: Boolean;
    function GetKeepOddSize: Boolean;
    function GetShowButton: Boolean;
    function GetShowButtonBorder: Boolean;
    function GetTreeLineMode: TdxPSTreeLineMode;
    procedure SetButtonBorder3D(Value: Boolean);
    procedure SetButtonBorder3DSoft(Value: Boolean);
    procedure SetButtonBorderShadow(Value: Boolean);
    procedure SetButtonExpanded(Value: Boolean);
    procedure SetButtonTransparent(Value: Boolean);
    procedure SetKeepOddSize(Value: Boolean);
    procedure SetShowButton(Value: Boolean);
    procedure SetShowButtonBorder(Value: Boolean);
    procedure SetTreeLineMode(Value: TdxPSTreeLineMode);
  protected
    procedure ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); override;

    function AreTreeLinesDrawn: Boolean;
    function CalculateButtonBounds: TRect; virtual;

    function GetButtonAlignHorz: TdxReportCellExpandButtonAlignHorz; virtual;
    function GetButtonAlignVert: TdxReportCellExpandButtonAlignVert; virtual;
    function GetButtonIndents: TRect; virtual;
    procedure SetButtonAlignHorz(Value: TdxReportCellExpandButtonAlignHorz); virtual;
    procedure SetButtonAlignVert(Value: TdxReportCellExpandButtonAlignVert); virtual;
    
    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;   
  public
    constructor Create(AParent: TdxReportCell); override;
    procedure Assign(Source: TPersistent); override;
    
    procedure DrawContent(DC: HDC; AStage: TdxPSRenderStages); override;  
    procedure DrawExpandButton(DC: HDC); virtual;
    procedure DrawTreeLines(DC: HDC); virtual;

    function GetButtonBounds(DC: HDC): TRect; virtual;
    
    property ActualButtonSize: Integer read GetActualButtonSize;
    property ButtonAlignHorz: TdxReportCellExpandButtonAlignHorz read GetButtonAlignHorz write SetButtonAlignHorz default bahCenter;
    property ButtonAlignVert: TdxReportCellExpandButtonAlignVert read GetButtonAlignVert write SetButtonAlignVert default bavCenter;
    property ButtonBorder3D: Boolean read GetButtonBorder3D write SetButtonBorder3D default False;
    property ButtonBorder3DSoft: Boolean read GetButtonBorder3DSoft write SetButtonBorder3DSoft default False;
    property ButtonBorderShadow: Boolean read GetButtonBorderShadow write SetButtonBorderShadow default False;
    property ButtonExpanded: Boolean read GetButtonExpanded write SetButtonExpanded default False;
    property ButtonIndents: TRect read GetButtonIndents;
    property ButtonInteriorColor: TColor read FButtonInteriorColor write FButtonInteriorColor default clNone;
    property ButtonSize: Integer read FButtonSize write FButtonSize default 9;
    property ButtonTransparent: Boolean read GetButtonTransparent write SetButtonTransparent default True;
    property KeepOddSize: Boolean read GetKeepOddSize write SetKeepOddSize default True;
    property ShowButton: Boolean read GetShowButton write SetShowButton default False;
    property ShowButtonBorder: Boolean read GetShowButtonBorder write SetShowButtonBorder default True;
    property TreeLineMode: TdxPSTreeLineMode read GetTreeLineMode write SetTreeLineMode default tlmNone;
  end;
  
  TdxReportCellExpandButtonEx = class(TdxReportCellExpandButton)
  private
    FFormatEx: DWORD;
  protected
    function GetButtonAlignHorz: TdxReportCellExpandButtonAlignHorz; override;
    function GetButtonAlignVert: TdxReportCellExpandButtonAlignVert; override; 
    function GetButtonIndents: TRect; override;
    procedure SetButtonAlignHorz(Value: TdxReportCellExpandButtonAlignHorz); override;
    procedure SetButtonAlignVert(Value: TdxReportCellExpandButtonAlignVert); override; 

    procedure ReadData(AReader: TdxPSDataReader); override;
    procedure WriteData(AWriter: TdxPSDataWriter); override;
    
    property FormatEx: DWORD read FFormatEx write FFormatEx;
  end;
  
  { Explorer }
  
  TdxPSExplorerRefreshStage = (ersBefore, ersAfter);

  TCustomdxPSExplorerItemStateInfo = record
    Count: Integer;
    UniqueIDSize: Integer;
    // UniqueID: TBytes follows by UniqueIDSize with Length UniqueIDSize
  end;
    
  TCustomdxPSExplorer = class;
  TCustomdxPSExplorerItem = class;
  TdxPSExplorerFolder = class;
  TdxPSExplorerItem = class;
  
 
  IdxPSExplorerTreeContainerHost = interface
  ['{4E52E062-EDCF-4A58-8212-45EAE673F506}']
    function GetFlat: Boolean;
    function GetReportLink: TBasedxReportLink;
    function GetTreeContainerParent: TWinControl;
    
    procedure UpdateState;

    property Flat: Boolean read GetFlat;
    property ReportLink: TBasedxReportLink read GetReportLink;
    property TreeContainerParent: TWinControl read GetTreeContainerParent;
  end;
  

  TdxPSExplorerChangeNotifier = class
  private
    FExplorer: TCustomdxPSExplorer;
    procedure SetExplorer(Value: TCustomdxPSExplorer);
  protected
    procedure ExplorerRefresh(AStage: TdxPSExplorerRefreshStage); virtual; abstract;
    procedure FolderPopulated(AFolder: TdxPSExplorerFolder); virtual; abstract;
    procedure ItemAdded(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure ItemDataLoaded(AnItem: TdxPSExplorerItem); virtual; abstract;
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); virtual; abstract;
    procedure ItemDeleted(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure ItemParentChanged(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure ItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure ItemRenamed(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer);
    destructor Destroy; override;

    property Explorer: TCustomdxPSExplorer read FExplorer write SetExplorer;
  end;

  TdxPSExplorerChangeNotifierAdapter = class(TdxPSExplorerChangeNotifier)
  protected
    procedure ExplorerRefresh(AStage: TdxPSExplorerRefreshStage); override;
    procedure FolderPopulated(AFolder: TdxPSExplorerFolder); override;
    procedure ItemAdded(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemDataLoaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDeleted(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemParentChanged(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemRenamed(AnItem: TCustomdxPSExplorerItem); override;
  end;

  TdxPSExplorerTreeChangeNotifier = class(TdxPSExplorerChangeNotifierAdapter)
  private
    FTreeContainer: TCustomdxPSExplorerTreeContainer;
  protected
    procedure ExplorerRefresh(AStage: TdxPSExplorerRefreshStage); override;
    procedure FolderPopulated(AFolder: TdxPSExplorerFolder); override;
    procedure ItemAdded(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemDataLoaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); override;
    procedure ItemDeleted(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemParentChanged(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem); override;
    procedure ItemRenamed(AnItem: TCustomdxPSExplorerItem); override;
  public
    constructor Create(ATreeContainer: TCustomdxPSExplorerTreeContainer; ARegister: Boolean = True);
    property TreeContainer: TCustomdxPSExplorerTreeContainer read FTreeContainer;
  end;
  
  TCustomdxPSExplorerTreeContainerClass = class of TCustomdxPSExplorerTreeContainer;
  
  TCustomdxPSExplorerTreeContainer = class
  private
    FControl: TWinControl;
    FChangeNotifier: TdxPSExplorerTreeChangeNotifier;
    FExplorer: TCustomdxPSExplorer;
    FHost: IdxPSExplorerTreeContainerHost;
  protected
    { Next virtual (abstract) methods must be overriden in descendants }
    procedure AddItem(AParent: TdxPSExplorerFolder; AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure Clear; virtual; abstract;
    procedure DeleteItem(AnItem: TCustomdxPSExplorerItem); virtual;
    procedure InvalidateItem(AnItem: TCustomdxPSExplorerItem); virtual;
    procedure MoveItem(AnItem: TCustomdxPSExplorerItem); virtual; abstract;
    procedure RenameItem(AnItem: TCustomdxPSExplorerItem); virtual; abstract;

    function GetCreationParent: TdxPSExplorerFolder; virtual; abstract;
    function GetFocusedItem: TCustomdxPSExplorerItem; virtual; abstract;
    function GetIsEditing: Boolean; virtual; abstract;
    function GetIsFolderSelected: Boolean; virtual; abstract;
    function GetIsItemSelected: Boolean; virtual; abstract;
    function GetIsRootSelected: Boolean; virtual; abstract;
    function GetSelectedFolder: TdxPSExplorerFolder; virtual; abstract;
    function GetSelectedItem: TCustomdxPSExplorerItem; virtual; abstract;
    function GetSelectedItemText: string; virtual; abstract;
    procedure SetFocusedItem(Value: TCustomdxPSExplorerItem); virtual; abstract;
    procedure SetSelectedItem(Value: TCustomdxPSExplorerItem); virtual; abstract;
    procedure SetSelectedItemText(const Value: string); virtual; abstract;

    procedure RestoreState; virtual;
    procedure SaveState; virtual;
    
    procedure CreateTreeContainer;
    procedure InitializeTreeContainer; virtual;
    procedure ProcessKeyDown(var Key: Word; Shift: TShiftState); virtual;
    procedure ProcessKeyPress(var Key: Char); virtual;
    
    property ChangeNotifier: TdxPSExplorerTreeChangeNotifier read FChangeNotifier;
    property Host: IdxPSExplorerTreeContainerHost read FHost;
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer; AHost: IdxPSExplorerTreeContainerHost); virtual;
    destructor Destroy; override;

    class function ControlClass: TWinControlClass; virtual;    
    class procedure Register;
    class procedure Unregister;

    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    { Follow virtual (abstract) methods must be overriden in descendants }
    function BeginEdit(AnImmediate: Boolean = True): Boolean; virtual; abstract;
    procedure EndEdit(ACancel: Boolean); virtual; abstract;

    procedure CollapseItem(AnItem: TCustomdxPSExplorerItem; ARecursive: Boolean = False); virtual; abstract;
    procedure ExpandItem(AnItem: TCustomdxPSExplorerItem; ARecursive: Boolean = False); virtual; abstract;
    procedure MakeItemVisible(AnItem: TCustomdxPSExplorerItem); virtual; abstract;

    function CanCreateFolder: Boolean; virtual;
    function CanCreateItem: Boolean; virtual;
    function CanDeleteSelection: Boolean; virtual;
    function CanLoadSelectedItemData: Boolean; virtual;
    function CanRefresh: Boolean; virtual;
    function CanRenameSelectedItem: Boolean; virtual;
    function CanShowPropertySheetsForSelectedItem: Boolean; virtual;
    function CanUnloadItemData: Boolean; virtual;
    function CreateItem: TdxPSExplorerItem; virtual;
    procedure DeleteSelection(AShowMessage: Boolean = True); virtual;
    function IsSelectedItemCurrentlyLoaded: Boolean;
    procedure LoadSelectedItemData; virtual;
    procedure RenameSelectedItem; virtual;
    function ShowSelectedItemPropertySheets: Boolean;
    procedure UnloadItemData; virtual;
    
    { Follow abstract methods must be overriden in descendants }
    function GetDropTarget(X, Y: Integer): TdxPSExplorerFolder; virtual; abstract;
    function GetItemAt(X, Y: Integer): TCustomdxPSExplorerItem; virtual; abstract;
    
    function CanFocus: Boolean; virtual;
    procedure SetFocus; virtual;

    procedure RefreshSorting(ANode: TObject); overload; virtual;
    procedure RefreshSorting(AFolder: TdxPSExplorerFolder); overload; virtual;
    
    property Control: TWinControl read FControl;
    property CreationParent: TdxPSExplorerFolder read GetCreationParent;
    property Explorer: TCustomdxPSExplorer read FExplorer;
    property FocusedItem: TCustomdxPSExplorerItem read GetFocusedItem write SetFocusedItem;
    property IsEditing: Boolean read GetIsEditing;
    property IsFolderSelected: Boolean read GetIsFolderSelected;
    property IsItemSelected: Boolean read GetIsItemSelected;
    property IsRootSelected: Boolean read GetIsRootSelected;
    property SelectedFolder: TdxPSExplorerFolder read GetSelectedFolder;
    property SelectedItem: TCustomdxPSExplorerItem read GetSelectedItem write SetSelectedItem;
    property SelectedItemText: string read GetSelectedItemText write SetSelectedItemText;
  end;
  
  TdxPSExplorerTreeBuilderClass = class of TdxPSExplorerTreeBuilder;
  
  TdxPSExplorerTreeBuilder = class
  protected
    class procedure BuildTree(AnExplorer: TCustomdxPSExplorer; 
      ATreeContainer: TCustomdxPSExplorerTreeContainer); virtual;
    class procedure CreateFolderNode(ATreeContainer: TCustomdxPSExplorerTreeContainer;
      AParent, AFolder: TdxPSExplorerFolder); virtual;
    class procedure CreateItemNode(ATreeContainer: TCustomdxPSExplorerTreeContainer;
      AParent: TdxPSExplorerFolder; AnItem: TCustomdxPSExplorerItem); virtual;
    class procedure PopulateTreeFolder(ATreeContainer: TCustomdxPSExplorerTreeContainer; 
      AFolder: TdxPSExplorerFolder); virtual;
  public
    class procedure Register;
    class procedure Unregister;
  end;
  
  TdxPSStreamMode = (smRead, smWrite, smReadWrite);
  
  TCustomdxPSExplorerItemPropertySheetsClass = class of TCustomdxPSExplorerItemPropertySheets;

  TCustomdxPSExplorerItemPropertySheets = class(TCustomdxPSForm)
  private
    FExplorerItem: TCustomdxPSExplorerItem;
    class function FormClass: TCustomdxPSExplorerItemPropertySheetsClass;
  protected
    procedure Done; virtual;
    procedure Initialize; virtual;
  public
    constructor CreateEx(AnExplorerItem: TCustomdxPSExplorerItem); virtual;
     
    class function Execute(AnExplorerItem: TCustomdxPSExplorerItem): Boolean;
    function ExplorerItem: TCustomdxPSExplorerItem; overload; virtual;
  end;
  
  TCustomdxPSExplorerItemComparator = class
  public
    class function CompareItems(AnItem1, AnItem2: Pointer): Integer;
  end;

  TCustomdxPSExplorerItemHelper = class
  public
    class function GetHasChildren(AFolder: TdxPSExplorerFolder): Boolean; virtual;
    class function GetImageIndex(AnItem: TCustomdxPSExplorerItem): Integer; virtual;
    class function GetSelectedIndex(AnItem: TCustomdxPSExplorerItem): Integer; virtual;
    class procedure SetHasChildren(AFolder: TdxPSExplorerFolder; Value: Boolean); virtual;
  end;
  
  TCustomdxPSExplorerItemClass = class of TCustomdxPSExplorerItem;
  
  TCustomdxPSExplorerItem = class
  private
    FExplorer: TCustomdxPSExplorer;
    FName: string;
    FParent: TdxPSExplorerFolder;
    FWindowHandle: HWND;
    procedure SetParent(Value: TdxPSExplorerFolder);
  protected
    function CompareTo(AnItem: TCustomdxPSExplorerItem): Integer; virtual;

    function DoDelete: Boolean; virtual;
    function DoMove(AParent: TdxPSExplorerFolder): Boolean; virtual;
    function DoRename(var ANewName: string): Boolean; virtual;

    function GetDisplayName: string; virtual;
    function GetImageIndex: Integer; virtual;
    function GetInfoTip: string; virtual;
    function GetNewName(AReportLink: TBasedxReportLink): string; virtual;
    function GetSelectedIndex: Integer; virtual;

    procedure InternalDelete; virtual;
    procedure InternalMove(AParent: TdxPSExplorerFolder); virtual;
    procedure InternalRename(const AName: string); virtual;
    procedure SetName(const Value: string); virtual;

    function GetItemStateInfo: TCustomdxPSExplorerItemStateInfo; virtual;
    procedure WriteState(AStream: TStream); virtual;

    procedure WndProc(var Message: TMessage); virtual;
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer; AParent: TdxPSExplorerFolder); virtual;
    destructor Destroy; override;

    function Explorer: TCustomdxPSExplorer; overload; virtual; 

    function CanAccept(AnItem: TCustomdxPSExplorerItem): Boolean; virtual;
    function CanDelete: Boolean; virtual;
    function CanMove: Boolean; virtual;
    function CanMoveTo(AParent: TCustomdxPSExplorerItem): Boolean; overload; virtual; 
    function CanRename: Boolean; virtual;
    function CanRenameTo(const AName: string): Boolean; virtual;
    procedure Delete; virtual;
    function GetUniqueID(out AnUniqueID: TBytes): Integer; virtual; // returns Length of needed memory
    function HasAsParent(AnItem: TCustomdxPSExplorerItem): Boolean;
    function IsNameChanged(const ANewName: string): Boolean; virtual;
    
    class function HasPropertySheets: Boolean;
    class function PropertySheetsClass: TCustomdxPSExplorerItemPropertySheetsClass; virtual;
    function ShowPropertySheets: Boolean;
    
    function CannotRenameMessageText(const AOldName, ANewName: string): string; virtual;
    function DeleteMessageText: string; virtual;
    function OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string; virtual;
    
    property DisplayName: string read GetDisplayName;
    property InfoTip: string read GetInfoTip;
    property Name: string read FName write SetName;
    property Parent: TdxPSExplorerFolder read FParent write SetParent;
  end;

  TdxPSExplorerFolderHelper = class(TCustomdxPSExplorerItemHelper)
  public
    class function GetHasChildren(AFolder: TdxPSExplorerFolder): Boolean; override;
    class procedure SetHasChildren(AFolder: TdxPSExplorerFolder; Value: Boolean); override;
  end;
  
  TdxPSExplorerFolderClass = class of TdxPSExplorerFolder;
  
  TdxPSExplorerFolder = class(TCustomdxPSExplorerItem)
  private
    FFolders: TList;
    FHasChildren: Boolean;
    FItems: TList;
    function GetFolder(Index: Integer): TdxPSExplorerFolder;
    function GetFolderCount: Integer;
    function GetHasChildren: Boolean;
    function GetIsRoot: Boolean;
    function GetItem(Index: Integer): TdxPSExplorerItem;
    function GetItemCount: Integer;
    function GetItemList(AnItem: TCustomdxPSExplorerItem): TList; overload;
    function GetItemList(AnItemClass: TCustomdxPSExplorerItemClass): TList; overload;
    procedure SetHasChildren(Value: Boolean);
  protected
    function CompareTo(AnItem: TCustomdxPSExplorerItem): Integer; override;
    function GetImageIndex: Integer; override;
    function GetNewName(AReportLink: TBasedxReportLink): string; override;
    function GetSelectedIndex: Integer; override;

    function GetItemStateInfo: TCustomdxPSExplorerItemStateInfo; override;
    procedure WriteState(AStream: TStream); override;

    procedure LoadData; virtual;

    procedure Add(AnItem: TCustomdxPSExplorerItem);
    procedure Remove(AnItem: TCustomdxPSExplorerItem);

    procedure FreeAndNilFolders;
    procedure FreeAndNilItems;
    
    property HasChildren: Boolean read GetHasChildren write SetHasChildren;
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer; AParent: TdxPSExplorerFolder); override;
    destructor Destroy; override;

    function CanAccept(AnItem: TCustomdxPSExplorerItem): Boolean; override;
    function CanRenameTo(const AName: string): Boolean; override;
    function CreateFolder: TdxPSExplorerFolder; virtual;
    function CreateItem(AReportLink: TBasedxReportLink): TdxPSExplorerItem; virtual;
    procedure Populate;

    procedure Delete; override;
    procedure DeleteFolders; virtual;
    procedure DeleteItems; virtual;
    
    function HasFolders: Boolean; virtual;
    function HasItems: Boolean; virtual;
    function HasLoadedItem: Boolean; virtual;

    function FolderByName(const AName: string): TdxPSExplorerFolder; virtual;
    function ItemByName(const AName: string): TdxPSExplorerItem; virtual;

    function CannotRenameMessageText(const AOldName, ANewName: string): string; override;
    function DeleteMessageText: string; override;
    function OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string; override;
    
    property FolderCount: Integer read GetFolderCount;
    property Folders[Index: Integer]: TdxPSExplorerFolder read GetFolder; default;
    property IsRoot: Boolean read GetIsRoot;
    property ItemCount: Integer read GetItemCount;
    property Items[Index: Integer]: TdxPSExplorerItem read GetItem;
  end;
  
  TdxPSExplorerItemClass = class of TdxPSExplorerItem;
  
  TdxPSExplorerItem = class(TCustomdxPSExplorerItem)
  private
    FHasInvalidData: Boolean;
    FReportDocument: TdxPSReportDocument;
    function GetIsCurrentlyLoaded: Boolean;
    procedure SetHasInvalidData(Value: Boolean);
  protected
    function CompareTo(AnItem: TCustomdxPSExplorerItem): Integer; override;
    function DoDelete: Boolean; override;
    function GetFormCaption: string; virtual;
    function GetImageIndex: Integer; override;
    function GetInfoTip: string; override;
    function GetNewName(AReportLink: TBasedxReportLink): string; override;
    function GetSelectedIndex: Integer; override;
    procedure InternalDelete; override;

    procedure DocumentChanged(Sender: TObject); virtual;
    procedure SaveDocument; virtual;
    
    procedure SetReportData(AReportLink: TBasedxReportLink); virtual;

    property FormCaption: string read GetFormCaption;
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer; AParent: TdxPSExplorerFolder); override;
    destructor Destroy; override;
    
    function CanLoadData: Boolean; virtual;
    function CanRenameTo(const AName: string): Boolean; override;

    function CannotRenameMessageText(const AOldName, ANewName: string): string; override;
    function DataLoadErrorText: string; virtual;
    function DeleteMessageText: string; override;
    function OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string; override;

    function CreateDataStream(AMode: TdxPSStreamMode): TStream; virtual;
    procedure RetrieveReportData(AReportLink: TBasedxReportLink); virtual;
    
    function IsLoading: Boolean; virtual;
    procedure Load(AReportLink: TBasedxReportLink);
    procedure Unload;
    
    class function PropertySheetsClass: TCustomdxPSExplorerItemPropertySheetsClass; override;
    
    property HasInvalidData: Boolean read FHasInvalidData write SetHasInvalidData;
    property IsCurrentlyLoaded: Boolean read GetIsCurrentlyLoaded;
    property ReportDocument: TdxPSReportDocument read FReportDocument;
  end;

  TCustomdxPSExplorerContextCommandClass = class of TCustomdxPSExplorerContextCommand;
  
  TCustomdxPSExplorerContextCommand = class(TPersistent)
  private
    FBitmap: TBitmap;
    FCaption: string;
    FData: Integer;
    FExplorer: TCustomdxPSExplorer;
    FHint: string;
    FShortCut: TShortCut;
    procedure SetBitmap(Value: TBitmap);
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer); virtual;
    destructor Destroy; override;
    
    function Enabled: Boolean; virtual;
    procedure Execute; virtual;
    
    function Explorer: TCustomdxPSExplorer; overload; virtual;
    
    property Bitmap: TBitmap read FBitmap write SetBitmap;
    property Caption: string read FCaption write FCaption;
    property Data: Integer read FData Write FData;
    property Hint: string read FHint write FHint;
    property ShortCut: TShortCut read FShortCut write FShortCut;
  end;

  TdxPSExplorerContextCommandSeparator = class(TCustomdxPSExplorerContextCommand)
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer); override;
    function Enabled: Boolean; override;
  end;
  
  TdxPSExplorerRefreshContextCommand = class(TCustomdxPSExplorerContextCommand)
  public
    constructor Create(AnExplorer: TCustomdxPSExplorer); override;
    procedure Execute; override;
  end;
  
  TdxPSExplorerState = (esItemCreating, esFolderCreating, esLoading, esRefreshing);
  TdxPSExplorerStates = set of TdxPSExplorerState;

  TdxPSExplorerItemDataLoadErrorEvent = procedure(Sender: TCustomdxPSExplorer; 
    AnItem: TdxPSExplorerItem; var AShowErrorMessage: Boolean; var AText: string) of object;
    
  TdxPSExplorerClass = class of TCustomdxPSExplorer;
  
  TCustomdxPSExplorer = class(TComponent, {$IFNDEF DELPHI6} IUnknown, {$ENDIF} 
    IdxPSExplorerContextCommands, IdxPSExplorerContextCommands2)
  private
    FActiveFolder: TdxPSExplorerFolder;
    FCommands: TList;
    FFilterLinkClass: TComponentClass;
    FLoadedItem: TdxPSExplorerItem;
    FLoadingCounter: Integer;
    FLockCounter: Integer;
    FNotifiers: TList;
    FRefreshCounter: Integer;
    FRoot: TdxPSExplorerFolder;
    FState: TdxPSExplorerStates;
    FStateStream: TStream;
    FOnItemDataLoadError: TdxPSExplorerItemDataLoadErrorEvent;
    function GetCommand(Index: Integer): TCustomdxPSExplorerContextCommand;
    function GetCommandCount: Integer;
    function GetFilterLink: string;
    function GetNotifier(Index: Integer): TdxPSExplorerChangeNotifier;
    function GetNotifierCount: Integer;
    function GetRoot: TdxPSExplorerFolder;
    procedure SetFilterLink(const Value: string);
  protected
   {$IFNDEF DELPHI6}
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; override;
    function _Addref: Integer; stdcall;
    function _Release: Integer; stdcall;
   {$ENDIF}    

    { IdxPSExplorerContextCommands }
    procedure BuildCommandSet(ABuilder: IdxPSExplorerContextCommandBuilder); virtual;
    { IdxPSExplorerContextCommands2 }
    procedure FinalizeCommand(ACommand: TCustomdxPSExplorerContextCommand); virtual;
    procedure InitializeCommand(ACommand: TCustomdxPSExplorerContextCommand); virtual;
    
    function AddCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
    function AddCommandSeparator: TdxPSExplorerContextCommandSeparator;
    procedure ClearCommands;
    function CreateCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
    function CreateCommandSeparator: TdxPSExplorerContextCommandSeparator;
    function FindCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
    procedure FreeAndNilCommands;
    
    class function AcceptItemNameChar(AnItem: TCustomdxPSExplorerItem; Ch: Char): Boolean; virtual;
    function CreateItemDataStream(AnItem: TdxPSExplorerItem; AMode: TdxPSStreamMode): TStream; virtual; abstract;
    class function GetFolderClass: TdxPSExplorerFolderClass; virtual;
    class function GetItemClass: TdxPSExplorerItemClass; virtual;
    class function GetRootFolderClass: TdxPSExplorerFolderClass; virtual;
    function GetRootDisplayName: string; virtual;
    procedure LoadData(AFolder: TdxPSExplorerFolder);
                                    
    function CanDelete(AnItem: TCustomdxPSExplorerItem): Boolean; virtual;
    function CanMove(AnItem: TCustomdxPSExplorerItem): Boolean; virtual;
    function CanMoveTo(AnItem, AParent: TCustomdxPSExplorerItem): Boolean; virtual;
    function CanRename(AnItem: TCustomdxPSExplorerItem): Boolean; virtual;
    function CanRenameTo(AnItem: TCustomdxPSExplorerItem; const AName: string): Boolean; virtual;
    procedure Delete(AnItem: TCustomdxPSExplorerItem); virtual;
    procedure MoveTo(AnItem: TCustomdxPSExplorerItem; AParent: TdxPSExplorerFolder); virtual; 
    procedure PopulateFolder(AFolder: TdxPSExplorerFolder); virtual;
    procedure RenameTo(AnItem: TCustomdxPSExplorerItem; AName: string); virtual;

    procedure AfterRefresh;
    procedure BeforeRefresh;
    procedure DoRefresh; virtual;
    procedure RootNeeded;
    
    procedure DoItemDataLoadError(AnItem: TdxPSExplorerItem); dynamic;
    procedure DoLoadData(AFolder: TdxPSExplorerFolder); virtual; abstract;
    procedure InternalSetLoadedItem(Value: TdxPSExplorerItem);
    
    procedure PopulateTreeFolder(ATreeContainer: TCustomdxPSExplorerTreeContainer; AFolder: TdxPSExplorerFolder);
    
    procedure LoadState;
    procedure SaveState;
    
    procedure NotifyFolderPopulated(AFolder: TdxPSExplorerFolder);
    procedure NotifyItemAdded(AnItem: TCustomdxPSExplorerItem);
    procedure NotifyItemDataLoaded(AnItem: TdxPSExplorerItem);
    procedure NotifyItemDataUnloaded(AnItem: TdxPSExplorerItem);
    procedure NotifyItemDeleted(AnItem: TCustomdxPSExplorerItem);
    procedure NotifyItemParentChanged(AnItem: TCustomdxPSExplorerItem);
    procedure NotifyItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem);
    procedure NotifyItemRenamed(AnItem: TCustomdxPSExplorerItem);
    procedure NotifyRefresh(AStage: TdxPSExplorerRefreshStage);

    function AreNotificationsLocked: Boolean;
    function IndexOfNotifier(ANotifier: TdxPSExplorerChangeNotifier): Integer;
    procedure LockNotifications;
    procedure ReleaseAndNilNotifiers;
    procedure UnlockNotifications;
    
    procedure BeginLoading;
    procedure EndLoading;
    function IsLoading: Boolean;
    
    property CommandCount: Integer read GetCommandCount;
    property Commands[Index: Integer]: TCustomdxPSExplorerContextCommand read GetCommand;
    property NotifierCount: Integer read GetNotifierCount;
    property Notifiers[Index: Integer]: TdxPSExplorerChangeNotifier read GetNotifier;
  public 
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function LoadedItem: TdxPSExplorerItem; overload; virtual;
    
    function CanCreateFolder: Boolean; virtual;
    function CanCreateItem: Boolean; virtual;
    function CreateNewFolder(AParent: TdxPSExplorerFolder): TdxPSExplorerFolder; virtual;
    function CreateNewItem(AParent: TdxPSExplorerFolder; AReportLink: TBasedxReportLink): TdxPSExplorerItem; virtual;
    
    procedure BuildTree(ATreeContainer: TCustomdxPSExplorerTreeContainer);
    function CreateTree(const AHost: IdxPSExplorerTreeContainerHost): TCustomdxPSExplorerTreeContainer;

    function FindCustomItemByUniqueID(const AnUniqueID: TBytes): TCustomdxPSExplorerItem; virtual;   
    procedure LoadItemData(AnItem: TdxPSExplorerItem; AReportLink: TBasedxReportLink); overload;
    procedure UnloadItemData(AnItem: TdxPSExplorerItem); overload;
    procedure Refresh; virtual;

    procedure RegisterNotifier(ANotifier: TdxPSExplorerChangeNotifier);
    procedure UnregisterNotifier(ANotifier: TdxPSExplorerChangeNotifier);
    
    property ActiveFolder: TdxPSExplorerFolder read FActiveFolder Write FActiveFolder;
    property FilterLinkClass: TComponentClass read FFilterLinkClass write FFilterLinkClass;
    property Root: TdxPSExplorerFolder read GetRoot;
    property State: TdxPSExplorerStates read FState;
  published
    property FilterLink: string read GetFilterLink write SetFilterLink;
    property OnItemDataLoadError: TdxPSExplorerItemDataLoadErrorEvent read FOnItemDataLoadError write FOnItemDataLoadError;
  end;

  TdxReportFootNoteMode = (fnmNone, fnmOnLastPage, fnmOnEveryBottomPage);
  TdxReportTitleMode = (tmNone, tmOnFirstPage, tmOnEveryTopPage);

  TdxReportTitle = class(TPersistent)
  private
    FAdjustOnReportScale: Boolean;
    FColor: TColor;
    FDefaultFont: TFont;
    FFont: TFont;
    FLockCalcViewInfos: Boolean;
    FMode: TdxReportTitleMode;
    FReportLink: TBasedxReportLink;
    FText: string;
    FTextAlignX: TcxTextAlignX;
    FTextAlignY: TcxTextAlignY;
    FTransparent: Boolean;
    FUpdateCount: Integer;
    function IsFontStored: Boolean;
    procedure SetAdjustOnReportScale(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetMode(Value: TdxReportTitleMode);
    procedure SetText(const Value: string);
    procedure SetTextAlignX(Value: TcxTextAlignX);
    procedure SetTextAlignY(Value: TcxTextAlignY);
    procedure SetTransparent(Value: Boolean);

    procedure CalculateRenderInfos;
    procedure FontChanged(Sender: TObject);
  protected
    procedure DoRestoreDefaults; virtual;
    procedure InitializeDefaultFont(AFont: TFont); virtual;
    
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
    
    property LockCalcViewInfos: Boolean read FLockCalcViewInfos;
  public
    constructor Create(AReportLink: TBasedxReportLink);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;

    function DefaultFont: TFont; virtual;
    procedure RestoreDefaults;

    property ReportLink: TBasedxReportLink read FReportLink;
  published
    property AdjustOnReportScale: Boolean read FAdjustOnReportScale write SetAdjustOnReportScale default False;
    property Color: TColor read FColor write SetColor default clWhite;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property Mode: TdxReportTitleMode read FMode write SetMode default tmOnEveryTopPage;
    property Text: string read FText write SetText;
    property TextAlignX: TcxTextAlignX read FTextAlignX write SetTextAlignX default taCenterX;
    property TextAlignY: TcxTextAlignY read FTextAlignY write SetTextAlignY default taCenterY;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
  end;
  
  TdxPSReportDocumentClass = class of TdxPSReportDocument;
  
  TdxPSReportDocument = class(TPersistent)
  private
    FCaption: string;
    FCreationDate: TDateTime;
    FCreator: string;
    FDescription: string;
    FIsCaptionAssigned: Boolean;
    FIsCreatorAssigned: Boolean;
    FIsDescriptionAssigned: Boolean;
    FPreview: TMetafile;
    FReportLink: TBasedxReportLink;
    FUpdateCount: Integer;
    FOnChanged: TNotifyEvent;
    function GetCaption: string;
    function GetCreator: string;
    function GetDescription: string;
    function IsCaptionStored: Boolean;
    function IsCreatorStored: Boolean;
    function IsDesciptionStored: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetCreator(const Value: string);
    procedure SetDescription(const Value: string);
    
    procedure ReadIsCaptionAssigned(Reader: TReader);
    procedure ReadIsCreatorAssigned(Reader: TReader);
    procedure ReadIsDescriptionAssigned(Reader: TReader);
    procedure WriteIsCaptionAssigned(Writer: TWriter);
    procedure WriteIsCreatorAssigned(Writer: TWriter);
    procedure WriteIsDescriptionAssigned(Writer: TWriter);
  protected  
    procedure DefineProperties(Filer: TFiler); override;

    procedure Changed; virtual;
    procedure DoAssign(Source: TdxPSReportDocument); virtual;
    procedure DoRestoreDefaults; virtual;
    function GetInfoTip: string; virtual;

    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;

    property UpdateCount: Integer read FUpdateCount write FUpdateCount;
  public
    constructor Create(AReportLink: TBasedxReportLink); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure BeginUpdate;
    procedure CancelUpdate;
    procedure EndUpdate;
    function IsUpdateLocked: Boolean;

    function DefaultCaption: string; virtual;
    function DefaultCreator: string; virtual;
    function DefaultDescription: string; virtual;
    
    procedure RestoreDefaults; 
    procedure RetrievePreview; virtual;
    
    property InfoTip: string read GetInfoTip;
    property Preview: TMetafile read FPreview;
    property ReportLink: TBasedxReportLink read FReportLink;
    
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
  published  
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property CreationDate: TDateTime read FCreationDate write SetCreationDate;
    property Creator: string read GetCreator write SetCreator stored IsCreatorStored;
    property Description: string read GetDescription write SetDescription stored IsDesciptionStored;
  end;
  
  TdxPSDataStorageOffsetTableClass = class of TdxPSDataStorageOffsetTable;
             
  TdxPSDataStorageOffsetTable = class
  protected
    procedure DoAssign(Source: TdxPSDataStorageOffsetTable); virtual;
  public
    Information: Longint;
    Document: Longint;
    Title: Longint;
    Data: Longint;
    Reserved1: Longint;
    Reserved2: Longint;
    Reserved3: Longint;
    Reserved4: Longint;
    constructor Create(ATemplate: TdxPSDataStorageOffsetTable = nil); virtual;
    procedure Assign(Source: TdxPSDataStorageOffsetTable); virtual;
    procedure Clear; virtual;
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
  end;
  PdxPSDataStorageOffsetTable = TdxPSDataStorageOffsetTable; // for backward compatibility
 
  TdxPSDataStorageInfoClass = class of TdxPSDataStorageInfo;
 
  TdxPSDataStorageInfo = class
  public
    StorageVersion: Integer;
    PrintingSystemVersion: TdxPSVersion;
    LinkClassName: string[255];
    ComponentClassName: string[255];
    LinkClass: TdxReportLinkClass;
    ComponentClass: TComponentClass;
    constructor Create(AReportLink: TBasedxReportLink); virtual;
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
  end;
  PdxPSDataStorageInfo = TdxPSDataStorageInfo; // for backward compatibility
  
  TdxAssignedFormatValue = (fvDate, fvTime, fvPageNumber);
  TdxAssignedFormatValues = set of TdxAssignedFormatValue;

  TdxReportLinkState = (rlsDataLoading, rlsDataSaving);
  TdxReportLinkStates = set of TdxReportLinkState;
  
  TdxReportLinkDataSource = (rldsComponent, rldsExternalStorage);

  TdxCustomDrawReportLinkTitleEvent = procedure(Sender: TBasedxReportLink; 
    ACanvas: TCanvas; ARect: TRect; ANom, ADenom: Integer; 
    var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY; 
    var AColor: TColor; AFont: TFont; var ADone: Boolean) of object;

  TdxCustomDrawReportLinkHFEvent = procedure(Sender: TObject; ACanvas: TCanvas; 
    APageIndex: Integer; var ARect: TRect; ANom, ADenom: Integer;
    var ADefaultDrawText, ADefaultDrawBackground: Boolean) of object;

  TdxFilterStyleEvent = procedure(Sender: TBasedxReportLink; 
    AStyle: TBasedxPrintStyle; var ASupported: Boolean) of object;

  TdxMeasureReportLinkTitleEvent = procedure(Sender: TBasedxReportLink; 
    var AHeight: Integer) of object;
    
  TdxPSGetImageListProc = procedure(AnImageList: TCustomImageList) of object;

  
  IdxPSNativeWin32ControlHandleSupport = interface
  ['{4B649281-A283-4CAC-98D4-08E779A7F9C8}']
    function GetNativeHandle: THandle;
    procedure SetNativeHandle(Value: THandle);
    property NativeHandle: THandle read GetNativeHandle write SetNativeHandle;
  end;
  

  TBasedxReportLink = class(TComponent {$IFNDEF DELPHI6}, IUnknown {$ENDIF})
  private
    FActive: Boolean;
    FAssignedFormatValues: TdxAssignedFormatValues;
    FBuiltIn: Boolean;
    FComponent: TComponent;
    FComponentPrinter: TCustomdxComponentPrinter;
    FController: TBasedxReportLink;
    FCurrentPage: Integer;
    FData: Pointer;
    FDateFormat: Integer;
    FDataSource: TdxReportLinkDataSource;
    FDataStream: TStream;
    FDefaultFont: TFont;
    FDesignerCaption: string;
    FDesignerHelpContext: THelpContext;
    FDesignWindow: TAbstractdxReportLinkDesignWindow;
    FFont: TFont;
    FFootersOnEveryPage: Boolean;
    FHeadersOnEveryPage: Boolean;
    FInternalStreaming: Boolean;
    FIsDesignerCaptionAssigned: Boolean;
    FIsInvalidReport: Boolean;
    FPageNumberFormat: TdxPageNumberFormat;
    FPrinterPage: TdxPrinterPage;
    FRebuildNeeded: Boolean;
    FRenderer: TdxPSReportRenderer;
    FRenderInfo: TdxPSReportRenderInfo;
    FReportCells: TdxReportCells;
    FReportDocument: TdxPSReportDocument;
    FReportTitle: TdxReportTitle;
    FSavedReportDocument: TdxPSReportDocument;
    FSavedReportTitle: TdxReportTitle;
    FScaleFonts: Boolean;
    FShowDesigner: Boolean;
    FShowEmptyPages: Boolean;
    FShowPageFooter: Boolean;
    FShowPageHeader: Boolean;
    FState: TdxReportLinkStates;
    FStartPageIndex: Integer;
    FStorageName: string;
    FStyleManager: TdxPrintStyleManager;
    FSubscriber: TdxEventSubscriber;
    FTimeFormat: Integer;
    FTransparent: Boolean;
    FUseHorzDelimiters: Boolean;
    FUseVertDelimiters: Boolean;

    FBackgroundBitmapPool: TdxPSBackgroundBitmapPool;
    FFontPool: TdxPSReportFontPool;
    FPainting: Boolean;
    FPrepared: Boolean;
    FStreamedActive: Boolean;

    FOnChangeComponent: TNotifyEvent;
    FOnCustomDrawPageFooter: TdxCustomDrawReportLinkHFEvent;
    FOnCustomDrawPageHeader: TdxCustomDrawReportLinkHFEvent;
    FOnCustomDrawReportLinkTitle: TdxCustomDrawReportLinkTitleEvent;
    FOnDataSourceChanged: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FOnFilterStyle: TdxFilterStyleEvent;
    FOnMeasureReportLinkTitle: TdxMeasureReportLinkTitleEvent;

    function GetAbortBuilding: Boolean;
    function GetCaption: string;
    function GetCurrentPrintStyle: TBasedxPrintStyle;
    function GetDateFormat: Integer;
    function GetDateTime: TDateTime;
    function GetDescription: string;
    function GetDesignerCaption: string;
    function GetFontPool: TdxPSReportFontPool;
    function GetHasDesignWindow: Boolean;
    function GetHasPreviewWindow: Boolean;
    function GetIndex: Integer;
    function GetIsAggregated: Boolean;
    function GetIsBuilding: Boolean;
    function GetIsCurrentLink: Boolean;
    function GetPageHeight: Integer;
    function GetPageNumberFormat: TdxPageNumberFormat;
    function GetPageWidth: Integer;
    function GetPreviewWindow: TBasedxPreviewWindow;
    function GetRealPrinterPage: TdxPrinterPage;
    function GetReportTitleMode: TdxReportTitleMode;
    function GetReportTitleText: string;
    function GetRenderer: TdxPSReportRenderer;
    function GetRenderInfo: TdxPSReportRenderInfo;
    function GetRenderStage: TdxPSRenderStages;
    function GetShowEmptyPages: Boolean;
    function GetShowPageFooter: Boolean;
    function GetShowPageHeader: Boolean;    
    ///function GetShrinkToPageHeight: Boolean;
    function GetShrinkToPageWidth: Boolean;
    function GetStartPageIndex: Integer;
    function GetTimeFormat: Integer;
    function GetVirtualPageCount: Integer;
    function IsDateFormatStored: Boolean;
    function IsDesignerCaptionStored: Boolean; 
    function IsPageNumberFormatStored: Boolean;
    function IsTimeFormatStored: Boolean;
    procedure SetAbortBuilding(Value: Boolean);
    procedure SetAssignedFormatValues(Value: TdxAssignedFormatValues);
    procedure SetCaption(const Value: string);
    procedure SetComponentPrinter(Value: TCustomdxComponentPrinter);
    procedure SetCurrentPage(Value: Integer);
    procedure SetDateFormat(Value: Integer);
    procedure SetDataSource(Value: TdxReportLinkDataSource);
    procedure SetDateTime(const Value: TDateTime);
    procedure SetDesignerCaption(const Value: string);
    procedure SetDescription(const Value: string);
    procedure SetIndex(Value: Integer);
    procedure SetIsCurrentLink(Value: Boolean);
    procedure SetPageNumberFormat(Value: TdxPageNumberFormat);
    procedure SetPrinterPage(Value: TdxPrinterPage);
    procedure SetRealPrinterPage(Value: TdxPrinterPage);
    procedure SetReportDocument(Value: TdxPSReportDocument);
    procedure SetReportTitle(Value: TdxReportTitle);
    procedure SetReportTitleMode(Value: TdxReportTitleMode);
    procedure SetReportTitleText(const Value: string);
    procedure SetShowEmptyPages(Value: Boolean);
    procedure SetShowPageFooter(Value: Boolean);
    procedure SetShowPageHeader(Value: Boolean);
    //procedure SetShrinkToPageHeight(Value: Boolean);
    procedure SetShrinkToPageWidth(Value: Boolean);
    procedure SetStartPageIndex(Value: Integer);
    procedure SetStorageName(const Value: string);
    procedure SetStyleManager(Value: TdxPrintStyleManager);
    procedure SetTimeFormat(Value: Integer);
    procedure SetUseHorzDelimiters(Value: Boolean);
    procedure SetUseVertDelimiters(Value: Boolean);

    procedure AssignFormats(AnItem: TdxAssignedFormatValue; AValue: Boolean);
    function CurrentComposition: TdxCompositionReportLink;
    procedure PaintPage(ACanvas: TCanvas; const APageBounds: TRect; 
      APageIndex, AContinuousPageIndex, AZoomFactor: Integer); virtual;
    function ValidateMargins: Boolean;
    
    procedure DefineStylesClick(Sender: TObject);
    procedure StyleClick(Sender: TObject);

    procedure ReadBuiltIn(Reader: TReader);
    procedure ReadComponentName(AReader: TReader);
    procedure ReadIsDesignerCaptionAssigned(Reader: TReader);
    procedure ReadStyleManagerName(AReader: TReader);
    procedure WriteBuiltIn(Writer: TWriter);
    procedure WriteComponentName(AWriter: TWriter);
    procedure WriteIsDesignerCaptionAssigned(Writer: TWriter);
    procedure WriteStyleManagerName(AWriter: TWriter);
  protected
    FColor: TColor;
    FFontIndex: Integer;
   {$IFNDEF DELPHI6}
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; override;
    function _Addref: Integer; stdcall;
    function _Release: Integer; stdcall;
   {$ENDIF}    
    procedure AssignTo(Dest: TPersistent); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ReadState(Reader: TReader); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure SetParentComponent(AParent: TComponent); override;
    
    { Render Info}
    procedure CalculateRenderInfos;
    procedure ClearGDIPools;
    function CreateRenderInfo: TdxPSReportRenderInfo; virtual;
    procedure FreeRenderInfos;
    function GetRenderInfoClass: TdxPSReportRenderInfoClass; virtual;    

    function CreateRenderer: TdxPSReportRenderer; virtual;
    procedure FreeRenderer;
    function GetRendererClass: TdxPSReportRendererClass; virtual;

    procedure InitializeDefaultFont(AFont: TFont); virtual;
    procedure InternalGetDelimiters(ADelimitersHorz, ADelimitersVert: TList);

    function IsEntirePageCustomDrawn: Boolean;
    function IsHeaderOrFooterCustomDrawn(AHFObject: TCustomdxPageObject): Boolean;
    function IsTitleCustomDrawn: Boolean;

    function NeedCalcEmptyPages: Boolean;
    function PageReady(APageIndex: Integer): Boolean; {obsolete: always returns True}
    procedure PrepareFonts(UPI: Integer);

    procedure PrepareLongOperation;
    procedure UnprepareLongOperation;

    function CreateReportDocument: TdxPSReportDocument;
    procedure DocumentChanged(Sender: TObject); virtual;
    class function GetReportDocumentClass: TdxPSReportDocumentClass; virtual;

    function CreateReportCells: TdxReportCells; virtual;
    function GetReportCellsClass: TdxReportCellsClass; virtual;

    { Read/Write Data }
    class function CreateDataReader(AStream: TStream): TdxPSDataReader;
    class function CreateDataWriter(AStream: TStream): TdxPSDataWriter;
    class function GetDataReaderClass: TdxPSDataReaderClass; virtual;
    class function GetDataWriterClass: TdxPSDataWriterClass; virtual;
    procedure InternalLoadDataFromStream(AStream: TStream);
    procedure InternalReadData(AReader: TdxPSDataReader); virtual;
    procedure InternalWriteData(AWriter: TdxPSDataWriter); virtual;
    function IsRebuildNeededAndAllowed(ACheckPreviewMode: Boolean): Boolean;

    function RetrieveStorageInfo: TdxPSDataStorageInfo; virtual;
    procedure ReadData(AReader: TdxPSDataReader); virtual;
    class function ReadOffsetTable(AReader: TdxPSDataReader): TdxPSDataStorageOffsetTable; virtual;
    class procedure ReadReportDocument(AReader: TdxPSDataReader; AReportDocument: TdxPSReportDocument); virtual;
    class function ReadStorageInfo(AReader: TdxPSDataReader): TdxPSDataStorageInfo; virtual;
    class procedure SkipStorageInfo(AReader: TdxPSDataReader);
    procedure ReadTitle(AReader: TdxPSDataReader); virtual;
    procedure WriteData(AWriter: TdxPSDataWriter); virtual;
    class procedure WriteOffsetTable(AWriter: TdxPSDataWriter; AnOffsetTable: TdxPSDataStorageOffsetTable); virtual;
    class procedure WriteReportDocument(AWriter: TdxPSDataWriter; AReportDocument: TdxPSReportDocument); virtual;
    class procedure WriteStorageInfo(AWriter: TdxPSDataWriter; AStorageInfo: TdxPSDataStorageInfo); virtual;
    procedure WriteTitle(AWriter: TdxPSDataWriter); virtual;

    { Read/Write Link Data}
    procedure ReadBackgroundBitmapPool(AReader: TdxPSDataReader);
    procedure ReadFontPool(AReader: TdxPSDataReader);
    procedure ReadRenderInfo(AReader: TdxPSDataReader);
    procedure ReadReportData(AReader: TdxPSDataReader);
    procedure WriteBackgroundBitmapPool(AWriter: TdxPSDataWriter);
    procedure WriteFontPool(AWriter: TdxPSDataWriter);
    procedure WriteRenderInfo(AWriter: TdxPSDataWriter);
    procedure WriteReportData(AWriter: TdxPSDataWriter);
    
    { properties read/write virtual methods }
    function GetAllowContinuousPageIndexes: Boolean; virtual;
    function GetAlwaysBufferedGraphics: Boolean; virtual;
    function GetContinuousPageIndexes: Boolean; virtual;    
    function GetEmptyPagesCanExist: Boolean; virtual;
    function GetRealScaleFactor: Integer; virtual;
    function GetReportHeight: Integer; virtual;
    function GetReportWidth: Integer; virtual;
    function IsFontStored: Boolean; virtual;
    procedure SetActive(Value: Boolean); virtual;
    procedure SetColor(Value: TColor); virtual;
    procedure SetComponent(Value: TComponent); virtual;
    procedure SetContinuousPageIndexes(Value: Boolean); virtual;
    procedure SetFont(Value: TFont); virtual;
    procedure SetFootersOnEveryPage(Value: Boolean); virtual;
    procedure SetHeadersOnEveryPage(Value: Boolean); virtual;
    procedure SetTransparent(Value: Boolean); virtual;

    procedure FontChanged(Sender: TObject); virtual;
    procedure LinkModified(Value: Boolean); virtual;
    
    procedure AfterDesignReport(ADone: Boolean); virtual;
    procedure BeforeDesignReport; virtual;
    
    procedure AfterPrinting; virtual;
    procedure BeforePrinting; virtual;

    function CalculateActualScaleFactor: Integer; virtual;
    function CannotActivateReportErrorString: string; virtual;
    procedure ConstructReport(AReportCells: TdxReportCells); virtual;
    procedure ConvertCoords; virtual;
    
    procedure CustomDraw(AnItem: TAbstractdxReportCellData; ACanvas: TCanvas;
      ABoundsRect, AClientRect: TRect; var ADone: Boolean); virtual;
    function GetDesignerClass: TdxReportLinkDesignWindowClass; virtual;
    procedure DoApplyInDesigner; virtual;
    procedure DoCreateReport; virtual;
    procedure DoCreateReportData;
    procedure DoDataProviderDontPresent; dynamic;
    procedure DoDestroyReport; virtual;
    procedure DoPageParamsChanged; virtual;
    procedure CopyDataStreamFrom(AStream: TStream);
    procedure FinalizeDataStream; virtual;
    function GetBreakPagesByHardDelimiters: Boolean; virtual;
    function GetCriticalSize(AReportCells: TdxReportCells): Integer; virtual;
    procedure GetImageLists(AProc: TdxPSGetImageListProc); virtual;
    function GetPageCount: Integer; virtual;
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; virtual;
    function GetUseHardVertDelimiters: Boolean; virtual;
    function GetVisiblePageCount: Integer; virtual;
    procedure InternalActivate; virtual;
    procedure InternalRestoreDefaults; virtual;
    procedure InternalRestoreFromOriginal; virtual;
    function IsDrawFootersOnEveryPage: Boolean; virtual;
    function IsDrawHeadersOnEveryPage: Boolean; virtual;
    function IsScaleGridLines: Boolean; virtual;
    function IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean; virtual;
    procedure MakeDelimiters(AReportCells: TdxReportCells; AHorzDelimiters, AVertDelimiters: TList); virtual;
    procedure MakeHardDelimiters(AReportCells: TdxReportCells; AVertDelimiters: TList); virtual;
    procedure PageParamsChanged(Sender: TdxPrinterPage; AStyle: TBasedxPrintStyle;
      AUpdateCodes: TdxPrinterPageUpdateCodes); virtual;
    function PossibleCustomDraw(AnItem: TAbstractdxReportCellData): Boolean; virtual;  
    procedure PrepareReportGroupsLookAndFeels;
    procedure RetrievePageAsImage(APageIndex: Integer; AGraphicClass: TGraphicClass; AGraphic: TGraphic);
    procedure RetrievePageAsImageCallBack(AComponentPrinter: TCustomdxComponentPrinter;
      AReportLink: TBasedxReportLink; AIndex, APageIndex: Integer; const AGraphic: TGraphic; 
      AData: Pointer; var AContinue: Boolean);
    procedure ShowEmptyPagesChanged; virtual;
    procedure ShowPageFooterChanged; virtual;
    procedure ShowPageHeaderChanged; virtual;
    procedure StdProcessDataSourceDontPresent; virtual;
    procedure TunePixelsNumerator(AReportCells: TdxReportCells); virtual;
    
    procedure ComponentUnsupportedError(AComponent: TComponent);

    procedure DoChangeComponent; dynamic;
    procedure DoCustomDrawEntirePage(ACanvas: TCanvas; R: TRect; ARealPageIndex: Integer); virtual;
    procedure DoCustomDrawPageHeaderOrFooter(AHFObject: TCustomdxPageObject;
      ACanvas: TCanvas; APageIndex: Integer; R: TRect;
      var ADefaultDrawText, ADefaultDrawBackground: Boolean); virtual;
    procedure DoParentCustomDrawPageHeaderOrFooter(
      AHFObject: TCustomdxPageObject; ACanvas: TCanvas; APageIndex: Integer;
      R: TRect; var ADefaultDrawText, ADefaultDrawBackground: Boolean;
      APixelsNumerator: Integer); virtual;
    procedure DoParentCustomDrawReportTitle(ACanvas: TCanvas; R: TRect;
      var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
      var AColor: TColor; AFont: TFont; var ADone: Boolean;
      APixelsNumerator: Integer); virtual;
    procedure DoCustomDrawPageTitle(ACanvas: TCanvas; R: TRect;
      var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
      var AColor: TColor; AFont: TFont; var ADone: Boolean); virtual;

    procedure DoDataSourceChanged; dynamic;
    procedure DoDestroy; dynamic;
    procedure DoMeasureReportLinkTitle(var AHeight: Integer); virtual;
    procedure DoProgress(const APercentDone: Double); dynamic;
    function IsComposable(AComposition: TdxCompositionReportLink): Boolean; virtual;
    function IsSupportedStyle(APrintStyle: TBasedxPrintStyle): Boolean; virtual;
    function NeedTwoPassRendering: Boolean; virtual;
    
    procedure DesignerModified;
    procedure DesignerUpdate(TheAll: Boolean);
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;    
    function IsLoading: Boolean;

    property AllowContinuousPageIndexes: Boolean read GetAllowContinuousPageIndexes;
    property AlwaysBufferedGraphics: Boolean read GetAlwaysBufferedGraphics;
    property BackgroundBitmapPool: TdxPSBackgroundBitmapPool read FBackgroundBitmapPool;
    property BreakPagesByHardDelimiters: Boolean read GetBreakPagesByHardDelimiters;
    property Color: TColor read FColor write SetColor default clWhite;
    property ContinuousPageIndexes: Boolean read GetContinuousPageIndexes write SetContinuousPageIndexes default False;
    //property Controller: TBasedxReportLink read FController write FController;
    property DataStream: TStream read FDataStream;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property FontPool: TdxPSReportFontPool read GetFontPool;
    property FootersOnEveryPage: Boolean read FFootersOnEveryPage write SetFootersOnEveryPage default False;
    property HeadersOnEveryPage: Boolean read FHeadersOnEveryPage write SetHeadersOnEveryPage default False;
    property InternalStreaming: Boolean read FInternalStreaming write FInternalStreaming;
    property IsBuilding: Boolean read GetIsBuilding;
    property IsInvalidReport: Boolean read FIsInvalidReport;  //stored in external storage
    property PageHeight: Integer read GetPageHeight;
    property PageWidth: Integer read GetPageWidth;
    property Renderer: TdxPSReportRenderer read GetRenderer;
    property RenderInfo: TdxPSReportRenderInfo read GetRenderInfo;
    property ScaleFonts: Boolean read FScaleFonts write FScaleFonts default True;
    property State: TdxReportLinkStates read FState;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property UseHardVertDelimiters: Boolean read GetUseHardVertDelimiters;
    property UseHorzDelimiters: Boolean read FUseHorzDelimiters write SetUseHorzDelimiters default True;
    property UseVertDelimiters: Boolean read FUseVertDelimiters write SetUseVertDelimiters default True;
    property VirtualPageCount: Integer read GetVirtualPageCount;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeforeDestruction; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    procedure LoadFromRegistry(const APath: string);
    procedure SaveToRegistry(const APath: string);
    
    class function Aggregable: Boolean; virtual;
    class function CanBeUsedAsStub: Boolean; virtual; // when data loaded from external storage  
    class function Serializable: Boolean; virtual;

    function DefaultDateFormat: Integer; virtual;
    function DefaultDesignerCaption: string; virtual;
    function DefaultFont: TFont; virtual;
    function DefaultPageNumberFormat: TdxPageNumberFormat; virtual;
    function DefaultTimeFormat: Integer; virtual;

    procedure RestoreDefaults; virtual;
    procedure RestoreFromOriginal; virtual;
    
    function CheckToDesign: Boolean;
    function DataProviderPresent: Boolean; virtual;
    function DesignerExists(AComponentClass: TComponentClass): Boolean; virtual;
    function DesignReport: Boolean;
    procedure DestroyReport; virtual;
    procedure GetPageColRowCount(out APageColCount, APageRowCount: Integer); virtual;
    procedure Initialize; virtual;
    function IsEmptyPage(AVirtualPageIndex: Integer): Boolean; virtual;
    function IsEmptyReport: Boolean; virtual;
    procedure RebuildReport; virtual;
    { Use this routine when you attempt to assign ReportLink to Component that actually is in a DLL }
    { Don't use this routine in regular cases, i.e. ReportLink is in the same executable file }
    procedure SetComponentUnconditionally(Value: TComponent);
    
    class procedure GetSupportedComponentList(AList: TdxClassList);
    class function IsSupportedCompClass(AComponentClass: TClass): Boolean; virtual; 
    class function LinkClass: TdxReportLinkClass;
    class function Supports(AnObject: TObject{TComponent}): Boolean; overload;
    class function Supports(AClass: TClass): Boolean; overload;
    
    function Print(AShowDialog: Boolean; APPrintDlgData: PdxPrintDlgData): Boolean;
    procedure PrintEx(APageNums: TdxPageNumbers; ACopies: Integer; ACollate: Boolean);
    procedure PrintPages(const APageIndexes: array of Integer);
    procedure PrintPagesEx(const APageIndexes: array of Integer; APageNums: TdxPageNumbers; 
      ACopyCount: Integer; ACollate: Boolean);

    procedure Preview(Modal: Boolean = True);
    function PreviewExists: Boolean;

    procedure BuildPageSetupMenu(ARootItem: TComponent; AData: Pointer; 
      AIncludeDefineItem: Boolean = True);
    procedure DefinePrintStylesDlg;
    procedure GetFilteredStyles(AStrings: TStrings);
    function PageSetup: Boolean;
    function PageSetupEx(AActivePageIndex: Integer; AShowPreviewBtn, AShowPrintBtn: Boolean; 
      out APreviewBtnClicked, APrintBtnClicked: Boolean): Boolean; overload;
    function PageSetupEx(AActivePageIndex: Integer; 
      APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean; overload; {$IFDEF DELPHI6} deprecated; {$ENDIF}

    function ShowDateTimeFormatsDlg: Boolean;
    function ShowPageNumberFormatsDlg: Boolean;
    function ShowTitlePropertiesDlg: Boolean;

    function SupportsScaling: Boolean; virtual;
        
    function CanChangeTitle: Boolean;
    function SupportsTitle: Boolean; virtual;
    
    function CanLoadData: Boolean; virtual;
    function CanSaveData: Boolean; virtual;
    function CanUnloadData: Boolean; virtual;
    function GetNewReportStorageName: string; virtual;
    procedure LoadDataFromFile(const AName: string); virtual;
    procedure LoadDataFromStream(AStream: TStream); virtual;
    procedure SaveDataToFile(const AName: string); virtual;
    procedure SaveDataToStream(AStream: TStream); virtual;

    class function ExtractComponentClass(AStream: TStream; ARaiseException: Boolean = False): TComponentClass;
    class function ExtractLinkClass(AStream: TStream; ARaiseException: Boolean = False): TdxReportLinkClass;
    class function ExtractOffsetTable(AStream: TStream; ARaiseException: Boolean = False): TdxPSDataStorageOffsetTable;
    class function ExtractReportDocument(AStream: TStream; ARaiseException: Boolean = False): TdxPSReportDocument;
    class function ExtractStorageInfo(AStream: TStream; ARaiseException: Boolean = False): TdxPSDataStorageInfo;
    class function ExtractStorageVersion(AStream: TStream; ARaiseException: Boolean = False): Integer;
    class procedure FinalizeStorageInfo(var AStorageInfo: TdxPSDataStorageInfo);
    class function PossibleDataStorage(AStream: TStream; ARaiseException: Boolean = False): Boolean; overload;
    class function PossibleDataStorage(const AFileName: string; ARaiseException: Boolean = False): Boolean; overload;

    function AddBackgroundBitmapToPool(ABitmap: TBitmap): Integer;
    function AddFontToPool(AFont: TFont): Integer;

    function CreateGroupLookAndFeel(AClass: TdxPSReportGroupLookAndFeelClass; ACheckExisting: Boolean = True): TdxPSReportGroupLookAndFeel;
    function FindGroupLookAndFeelByClass(AClass: TdxPSReportGroupLookAndFeelClass): TdxPSReportGroupLookAndFeel;
    function IndexOfReportGroupLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel): Integer;
    
    procedure DrawPageHeader(APageIndex: Integer; ARect: TRect;
      ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
    procedure DrawPageFooter(APageIndex: Integer; ARect: TRect;
      ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);

    procedure DrawCheckBox(Canvas: TCanvas; var R: TRect; Checked, Enabled, FlatBorder: Boolean; 
      BoldBorder: Boolean = False); overload; virtual; 
    procedure DrawCheckBox(Canvas: TCanvas; var R: TRect; Checked, Enabled, IsRadio: Boolean; 
      EdgeStyle: TdxCheckButtonEdgeStyle; BorderColor: TColor = clWindowText); overload; virtual; 
    procedure drawEdge(Canvas: TCanvas; var R: TRect; EdgeMode: TdxCellEdgeMode;
      InnerEdge, OuterEdge: TdxCellEdgeStyle; Sides: TdxCellSides = [csLeft..csBottom];
      Soft: Boolean = True); virtual;
    procedure DrawEllipse(Canvas: TCanvas; R: TRect; ForeColor, BkColor: TColor; 
      Pattern: TdxPSFillPatternClass; BorderColor: TColor; BorderThickness: Integer = 1); virtual;
    procedure DrawExpandButton(Canvas: TCanvas; var R: TRect; 
      Expanded, DrawBorder, Edge3D, Edge3DSoft, Shadow, FillInterior: Boolean; 
      BorderColor, InteriorColor: TColor); virtual;
    procedure DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
    procedure DrawGraphic(Canvas: TCanvas; var R: TRect; const ClipRect: TRect;
      ImageList: TCustomImageList; ImageIndex: Integer; Graphic: TGraphic; 
      GraphicTransparent, Transparent: Boolean; BkColor: TColor); virtual;
    procedure DrawGraphicEx(Canvas: TCanvas; var R: TRect; const ClipRect: TRect; 
      ImageList: TCustomImageList; ImageIndex: Integer; Graphic: TGraphic; 
      GraphicTransparent, Transparent: Boolean; BkColor, ForeColor: TColor; 
      Pattern: TdxPSFillPatternClass; AnActualImageBuffering: TdxCellImageActualBuffering = cibAlways); virtual;
    procedure DrawRectangle(Canvas: TCanvas; R: TRect; ForeColor, BkColor: TColor; 
      ContentPattern: TdxPSFillPatternClass; BorderColor: TColor; 
      BorderThickness: Integer = 1); virtual;
    procedure DrawRoundRect(Canvas: TCanvas; R: TRect; CornerWidth, CornerHeight: Integer; 
      ForeColor, BkColor: TColor; ContentPattern: TdxPSFillPatternClass; 
      BorderColor: TColor; BorderThickness: Integer = 1); virtual;
    procedure DrawSortMark(Canvas: TCanvas; var R: TRect; SortOrder: TdxCellSortOrder; Mono: Boolean); virtual;
    procedure drawText(Canvas: TCanvas; var R: TRect; AIndent: Integer;
      const Text: string; Font: TFont; BkColor: TColor; TextAlignX: TcxTextAlignX;
      TextAlignY: TcxTextAlignY; FillBackground, Multiline, EndEllipsis: Boolean); virtual;
    procedure drawTextEx(Canvas: TCanvas; var R: TRect; MaxLineCount: Integer;
      LeftIndent, RightIndent: Integer; const Text: string; Font: TFont; 
      BkColor: TColor; TextAlignX: TcxTextAlignX; TextAlignY: TcxTextAlignY; 
      FillBackground, Multiline, EndEllipsis, PreventLeftTextExceed, PreventTopTextExceed: Boolean); virtual;
    procedure FillEllipse(Canvas: TCanvas; const R: TRect; Color: TColor); virtual;
    procedure FillEllipseEx(Canvas: TCanvas; const R: TRect; ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass); virtual;
    procedure FillRectEx(Canvas: TCanvas; const R: TRect; ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass); virtual;
    procedure FillRoundRect(Canvas: TCanvas; const R: TRect; CornerWidth, CornerHeight: Integer; Color: TColor); virtual;
    procedure FillRoundRectEx(Canvas: TCanvas; const R: TRect; CornerWidth, CornerHeight: Integer; 
      ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass); virtual;    
    procedure FillRgnEx(Canvas: TCanvas; Rgn: HRGN; ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass); virtual; 
    procedure FrameEllipse(Canvas: TCanvas; R: TRect; Color: TColor; Thickness: Integer = 1);
    procedure frameRect(Canvas: TCanvas; R: TRect; Color: TColor; Sides: TdxCellSides = [csLeft..csBottom];
      Thickness: Integer = 1);
    procedure FrameRoundRect(Canvas: TCanvas; R: TRect; CornerWidth, CornerHeight: Integer;
      Color: TColor; Thickness: Integer = 1); virtual;   
      
    { for internal use only }        
    function RealPageIndexToVirtualPageIndex(APageIndex: Integer;
      ATakeIntoAccountEmptyPages: Boolean): Integer; virtual;
    function VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer; virtual;

    property AbortBuilding: Boolean read GetAbortBuilding write SetAbortBuilding;
    property BuiltIn: Boolean read FBuiltIn write FBuiltIn;
    property ComponentPrinter: TCustomdxComponentPrinter read FComponentPrinter  write SetComponentPrinter;
    property Controller: TBasedxReportLink read FController write FController;
    property CurrentPage: Integer read FCurrentPage write SetCurrentPage;
    property CurrentPrintStyle: TBasedxPrintStyle read GetCurrentPrintStyle;
    property Data: Pointer read FData write FData;
    property DataSource: TdxReportLinkDataSource read FDataSource write SetDataSource;
    property DesignWindow: TAbstractdxReportLinkDesignWindow read FDesignWindow;
    property EmptyPagesCanExist: Boolean read GetEmptyPagesCanExist;
    property HasDesignWindow: Boolean read GetHasDesignWindow;
    property HasPreviewWindow: Boolean read GetHasPreviewWindow;
    property IsAggregated: Boolean read GetIsAggregated;
    property PageCount: Integer read GetPageCount;
    property PreviewWindow: TBasedxPreviewWindow read GetPreviewWindow;
    property RealPrinterPage: TdxPrinterPage read GetRealPrinterPage write SetRealPrinterPage;
    property RealScaleFactor: Integer read GetRealScaleFactor;
    property RebuildNeeded: Boolean read FRebuildNeeded;
    property RenderStage: TdxPSRenderStages read GetRenderStage;
    property ReportCells: TdxReportCells read FReportCells;
    property ReportHeight: Integer read GetReportHeight;
    property ReportWidth: Integer read GetReportWidth;
    property ShowEmptyPages: Boolean read GetShowEmptyPages write SetShowEmptyPages  default False;
    property VisiblePageCount: Integer read GetVisiblePageCount;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Caption: string read GetCaption write SetCaption stored False;
    property Component: TComponent read FComponent write SetComponent;
    property Description: string read GetDescription write SetDescription stored False;
    property DateFormat: Integer read GetDateFormat write SetDateFormat stored IsDateFormatStored default 0;
    property DateTime: TDateTime read GetDateTime write SetDateTime stored False;
    property DesignerCaption: string read GetDesignerCaption write SetDesignerCaption stored IsDesignerCaptionStored;
    property DesignerHelpContext: THelpContext read FDesignerHelpContext write FDesignerHelpContext default 0;
    property Index: Integer read GetIndex write SetIndex stored False;
    property IsCurrentLink: Boolean read GetIsCurrentLink write SetIsCurrentLink stored False;
    property PageNumberFormat: TdxPageNumberFormat read GetPageNumberFormat write SetPageNumberFormat stored IsPageNumberFormatStored;
    property PrinterPage: TdxPrinterPage read FPrinterPage write SetPrinterPage;
    property ReportDocument: TdxPSReportDocument read FReportDocument write SetReportDocument;
    property ReportTitle: TdxReportTitle read FReportTitle write SetReportTitle;
    property ReportTitleMode: TdxReportTitleMode read GetReportTitleMode write SetReportTitleMode stored False default tmOnEveryTopPage;
    property ReportTitleText: string read GetReportTitleText write SetReportTitleText stored False;
    property ShowDesigner: Boolean read FShowDesigner write FShowDesigner stored False;
    property ShowPageFooter: Boolean read GetShowPageFooter write SetShowPageFooter default True;
    property ShowPageHeader: Boolean read GetShowPageHeader write SetShowPageHeader default True;
    //property ShrinkToPageHeight: Boolean read GetShrinkToPageHeight write SetShrinkToPageHeight default False;
    property ShrinkToPageWidth: Boolean read GetShrinkToPageWidth write SetShrinkToPageWidth default False;
    property StartPageIndex: Integer read GetStartPageIndex write SetStartPageIndex default 1;
    property StorageName: string read FStorageName write SetStorageName;
    property StyleManager: TdxPrintStyleManager read FStyleManager write SetStyleManager;
    property TimeFormat: Integer read GetTimeFormat write SetTimeFormat stored IsTimeFormatStored default 0;
    property AssignedFormatValues: TdxAssignedFormatValues read FAssignedFormatValues write SetAssignedFormatValues default [];  //must be last

    property OnChangeComponent: TNotifyEvent read FOnChangeComponent write FOnChangeComponent;
    property OnCustomDrawPageFooter: TdxCustomDrawReportLinkHFEvent read FOnCustomDrawPageFooter write FOnCustomDrawPageFooter;
    property OnCustomDrawPageHeader: TdxCustomDrawReportLinkHFEvent read FOnCustomDrawPageHeader write FOnCustomDrawPageHeader;
    property OnCustomDrawReportLinkTitle: TdxCustomDrawReportLinkTitleEvent read FOnCustomDrawReportLinkTitle write FOnCustomDrawReportLinkTitle;
    property OnDataSourceChanged: TNotifyEvent read FOnDataSourceChanged write FOnDataSourceChanged;
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
    property OnFilterStyle: TdxFilterStyleEvent read FOnFilterStyle write FOnFilterStyle;
    property OnMeasureReportLinkTitle: TdxMeasureReportLinkTitleEvent read FOnMeasureReportLinkTitle write FOnMeasureReportLinkTitle;
  end;

  TdxCompositionLinkItem = class(TCollectionItem)
  private
    FBuiltIn: Boolean;
    FReportLink: TBasedxReportLink;
    FLoadingReportLinkName: string;
    procedure SetReportLink(Value: TBasedxReportLink);
    procedure ReadData(Reader: TReader);
    procedure ReadLinkName(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    procedure WriteLinkName(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;  
    procedure SetIndex(Value: Integer); override;
    function Composition: TdxCompositionReportLink;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    property BuiltIn: Boolean read FBuiltIn write FBuiltIn;
  published
    property ReportLink: TBasedxReportLink read FReportLink write SetReportLink;
  end;

  TdxCompositionLinkItems = class(TCollection)
  private
    FComposition: TdxCompositionReportLink;
    FDontNeedRebuild: Boolean;
    function GetItem(Index: Integer): TdxCompositionLinkItem;
    procedure SetItem(Index: Integer; Value: TdxCompositionLinkItem);
  protected
    procedure CorrectLinksAfterLoadings;
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AComposition: TdxCompositionReportLink);
    
    function Add: TdxCompositionLinkItem;
    function AddLink(AReportLink: TBasedxReportLink): TdxCompositionLinkItem;
    procedure DeleteItemsByLink(AReportLink: TBasedxReportLink);
    procedure DeleteNonBuiltIns;
    procedure GetLinkEntries(AReportLink: TBasedxReportLink; AList: TList); // returns list of Items
    function IndexOfLink(AReportLink: TBasedxReportLink): Integer;          // returns first entry for AReportLink in Items
    function IsLinkComposable(AReportLink: TBasedxReportLink): Boolean;
    function LinkExists(AReportLink: TBasedxReportLink): Boolean;
    function NextAssignedItem(AnItem: TdxCompositionLinkItem): TdxCompositionLinkItem;
    function NonBuiltInsExists: Boolean;
    function PrevAssignedItem(AnItem: TdxCompositionLinkItem): TdxCompositionLinkItem;
    
    property Composition: TdxCompositionReportLink read FComposition;
    property Items[Index: Integer]: TdxCompositionLinkItem read GetItem write SetItem; default;
  end;

  TdxPSCompositionReportRenderInfo = class(TdxPSReportRenderInfo)
  private
    FNonEmptyPageCount: Integer;
    FPageColCount: Integer;
    FPageRowCount: Integer;
    FStartIndexes: TList;
    function GetReportLink: TdxCompositionReportLink;
    function GetStartIndex(Index: Integer): Integer;
    function GetStartIndexCount: Integer;
    procedure SetStartIndex(Index: Integer; Value: Integer);
  protected
    function CalculateNonEmptyPageCount: Integer; virtual;
    function CalculatePageColCount: Integer; virtual;
    function CalculatePageRowCount: Integer; virtual;
    
    procedure DoCalculate; override;
    procedure Refresh; override;
    
    function GetNonEmptyPageCount: Integer; override;
    function GetPageColCount: Integer; override;
    function GetPageRowCount: Integer; override;
    
    function RealPageIndexToVirtualPageIndex(APageIndex: Integer; ATakeIntoAccountEmptyPages: Boolean): Integer; override;
    function VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer; override;

    procedure GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex: Integer; 
      var APageIndexRelativeToLink: Integer; var AnItem: TdxCompositionLinkItem);
  public
    constructor Create(AReportLink: TBasedxReportLink); override;
    destructor Destroy; override;

    property ReportLink: TdxCompositionReportLink read GetReportLink;
    property StartIndexCount: Integer read GetStartIndexCount;
    property StartIndexes[Index: Integer]: Integer read GetStartIndex write SetStartIndex;
  end;

  TdxPSCompositionReportRenderer = class(TdxPSReportRenderer)
  private
    function GetRenderInfo: TdxPSCompositionReportRenderInfo;
    function GetReportLink: TdxCompositionReportLink;
  public
    procedure RenderPage(ACanvas: TCanvas; const APageBounds: TRect; 
      APageIndex, AContinuousPageIndex, AZoomFactor: Integer); override;

    property RenderInfo: TdxPSCompositionReportRenderInfo read GetRenderInfo;    
    property ReportLink: TdxCompositionReportLink read GetReportLink;
  end;

  TdxPSReportCompositionDocument = class(TdxPSReportDocument)
  private
    function GetReportLink: TdxCompositionReportLink;
  public
    function DefaultDescription: string; override;
    property ReportLink: TdxCompositionReportLink read GetReportLink;
  end;
  
  TdxCompositionReportLinkEvent = procedure(Sender: TdxCompositionReportLink;
    AItem: TdxCompositionLinkItem) of object;
  
  TdxCompositionState = (csRebuildReportLink);
  TdxCompositionStates = set of TdxCompositionState;
  
  TdxCompositionOption = (coCanEdit, coShowDescription);
  TdxCompositionOptions = set of TdxCompositionOption;

  TdxCompositionReportLink = class(TBasedxReportLink)
  private
    FCompositionState: TdxCompositionStates;
    FContinuousPageIndexes: Boolean;
    FDesignerOptions: TdxCompositionOptions;
    FInvalidatedLinks: TList;
    FItems: TdxCompositionLinkItems;
    FOnAfterBuildReport: TdxCompositionReportLinkEvent;
    FOnBeforeBuildReport: TdxCompositionReportLinkEvent;
    function GetRenderer: TdxPSCompositionReportRenderer;
    function GetRenderInfo: TdxPSCompositionReportRenderInfo;
    function GetReportDocument: TdxPSReportCompositionDocument;
    procedure SetItems(Value: TdxCompositionLinkItems);
    procedure SetReportDocument(Value: TdxPSReportCompositionDocument);
    
    procedure ActivateLink(AReportLink: TBasedxReportLink);
    procedure UpdateComposition(AUpdateCodes: TdxPrinterPageUpdateCodes);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;

    procedure ConstructReport(AReportCells: TdxReportCells); override;
    procedure DoCreateReport; override;
    function GetRendererClass: TdxPSReportRendererClass; override;
    function GetRenderInfoClass: TdxPSReportRenderInfoClass; override;
    procedure InternalRestoreDefaults; override;
    procedure InternalRestoreFromOriginal; override;
    procedure ShowEmptyPagesChanged; override;
    procedure ShowPageFooterChanged; override;
    procedure ShowPageHeaderChanged; override;
    procedure StdProcessDataSourceDontPresent; override;

    function GetAllowContinuousPageIndexes: Boolean; override;
    function GetContinuousPageIndexes: Boolean; override;
    function GetEmptyPagesCanExist: Boolean; override;
    function GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean; override;
    function GetReportHeight: Integer; override;
    function GetReportWidth: Integer; override;
    procedure SetContinuousPageIndexes(Value: Boolean); override;

    procedure DoAfterBuildReport(AItem: TdxCompositionLinkItem); dynamic;
    procedure DoBeforeBuildReport(AItem: TdxCompositionLinkItem); dynamic;

    class function GetReportDocumentClass: TdxPSReportDocumentClass; override;

    property Renderer: TdxPSCompositionReportRenderer read GetRenderer;
    property RenderInfo: TdxPSCompositionReportRenderInfo read GetRenderInfo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DefaultDesignerCaption: string; override;

    { for internal use only }
    function RealPageIndexToVirtualPageIndex(APageIndex: Integer;
      ATakeIntoAccountEmptyPages: Boolean): Integer; override;
    function VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer; override;

    class function CanBeUsedAsStub: Boolean; override;
    class function Serializable: Boolean; override;
    function DataProviderPresent: Boolean; override;
    function IsEmptyPage(AVirtualPageIndex: Integer): Boolean; override;
    function SupportsTitle: Boolean; override;

    procedure GetItems(AStrings: TStrings; AExcludeUnassigned: Boolean);

    property CompositionState: TdxCompositionStates read FCompositionState;
    property ReportDocument: TdxPSReportCompositionDocument read GetReportDocument write SetReportDocument;
  published
    property ContinuousPageIndexes default True;
    property DesignerOptions: TdxCompositionOptions read FDesignerOptions write FDesignerOptions
      default [coCanEdit, coShowDescription];
    property Items: TdxCompositionLinkItems read FItems write SetItems;

    property OnAfterBuildReport: TdxCompositionReportLinkEvent read FOnAfterBuildReport write FOnAfterBuildReport;    
    property OnBeforeBuildReport: TdxCompositionReportLinkEvent read FOnBeforeBuildReport write FOnBeforeBuildReport;
  end;
  
  { Report PropertySheets }
  
  TdxReportLinkDesignWindowState = (dwsInitialize);
  TdxReportLinkDesignWindowStates = set of TdxReportLinkDesignWindowState;
  
  TAbstractdxReportLinkDesignWindow = class(TCustomdxPSForm)
  private
    FApplyed: Boolean;
    FModified: Boolean;
    FPrevKeyPreview: Boolean;
    FReportLink: TBasedxReportLink;
    function GetComponent: TComponent;
    function GetIsDesigning: Boolean;
    function IsCaptionStored: Boolean;
    procedure SetModified(Value: Boolean);
    procedure WMHelp(var message: TWMHelp); message WM_HELP;
  protected
    FState: TdxReportLinkDesignWindowStates;
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;

    procedure AfterRebuildReport; virtual;
    procedure BeforeRebuildReport; virtual;
    
    procedure Initialize; virtual;
    procedure LoadStrings; virtual;
    procedure UpdateControlsState; virtual;
    
    property Applyed: Boolean read FApplyed write FApplyed;
    property Component: TComponent read GetComponent;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; virtual;
    
    property IsDesigning: Boolean read GetIsDesigning;
    property Modified: Boolean read FModified write SetModified;
    property ReportLink: TBasedxReportLink read FReportLink write FReportLink;
    property State: TdxReportLinkDesignWindowStates read FState;
  published
    property Caption stored IsCaptionStored;
  end;

  TStandarddxReportLinkDesignWindow = class(TAbstractdxReportLinkDesignWindow)
  private
    FAtLeastOneTimeApplied: Boolean;
    FUpdateControlsCount: Integer;
    procedure SetAtLeastOneTimeApplied(Value: Boolean);
    
    procedure CreateStdButtons;
    procedure PlaceStdButtons;
    procedure RegroupStdButtons;
  protected
   {$IFDEF DELPHI7} 
    FPrevPreviewHostWindowProc: TWndMethod;
   {$ENDIF} 
    procedure Resize; override;

    function CanApply: Boolean; virtual;
    procedure DoApply; virtual;
    procedure Initialize; override;
    procedure LoadStrings; override; 
    procedure UpdateControlsState; override;

    procedure ApplyClick(Sender: TObject); virtual;
    procedure RestoreDefaultsClick(Sender: TObject); virtual;
    procedure RestoreOriginalClick(Sender: TObject); virtual;
    procedure TitlePropertiesClick(Sender: TObject); virtual;
        
    procedure DoInitialize; virtual;
   {$IFDEF DELPHI7}
    function GetPreviewHost: TCustomPanel; virtual; 
    procedure PreviewHostWindowProc(var Message: TMessage); virtual;
   {$ENDIF} 
    procedure PaintPreview(ACanvas: TCanvas; R: TRect); virtual;
    procedure UpdatePreview; virtual;

    property AtLeastOneTimeApplied: Boolean read FAtLeastOneTimeApplied write SetAtLeastOneTimeApplied;
   {$IFDEF DELPHI7} 
    property PreviewHost: TCustomPanel read GetPreviewHost;
   {$ENDIF} 
    property UpdateControlsCount: Integer read FUpdateControlsCount;
  public
    constructor Create(AOwner: TComponent); override;
   {$IFDEF DELPHI7} 
    destructor Destroy; override;
   {$ENDIF} 
   
    procedure BeginUpdateControls; virtual;
    procedure EndUpdateControls; virtual;
    function LockControlsUpdate: Boolean;
  published
    btnApply: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    btnOK: TButton;
    btnRestoreDefaults: TButton;
    btnRestoreOriginal: TButton;
    btnTitleProperties: TButton;
  end;

  { Print Styles }

  TdxPSPrintStyle = class(TBasedxPrintStyle)
  private
    FOnAfterGenerating: TNotifyEvent;
    FOnAfterPrinting: TNotifyEvent;
    FOnBeforeGenerating: TNotifyEvent;
    FOnBeforePrinting: TNotifyEvent;
    procedure AfterGenerating;
    procedure BeforeGenerating;
  protected
    procedure AddStdHFFunctions; virtual;
    
    procedure DoAfterGenerating; virtual;
    procedure DoAfterPrinting; override;
    procedure DoBeforeGenerating; virtual;
    procedure DoBeforePrinting; override;

    procedure InitializeDefaultStyleGlyph(ABitmap: TBitmap); override;
  public
    constructor Create(AOwner: TComponent); override;
    
    function DefaultPageFooterText(APart: TdxPageTitlePart): string; override;
    function DefaultStyleCaption: string; override;
  published
    property OnAfterGenerating: TNotifyEvent read FOnAfterGenerating write FOnAfterGenerating;
    property OnAfterPrinting: TNotifyEvent read FOnAfterPrinting write FOnAfterPrinting;
    property OnBeforeGenerating: TNotifyEvent read FOnBeforeGenerating write FOnBeforeGenerating;
    property OnBeforePrinting: TNotifyEvent read FOnBeforePrinting write FOnBeforePrinting;
  end;

  { Preview Window}
  
  TdxPreviewEnableOption = (peoCanChangeMargins, peoHelp, peoPageBackground, peoPageSetup, 
    peoPreferences, peoPrint, peoReportDesign);
  TdxPreviewEnableOptions = set of TdxPreviewEnableOption;
  TdxPreviewVisibleOption = (pvoHelp, pvoPageBackground, pvoPageSetup, pvoPreferences, 
    pvoPrint, pvoReportDesign, pvoPrintStyles, pvoReportFileOperations, pvoPageMargins);
  TdxPreviewVisibleOptions = set of TdxPreviewVisibleOption;
  TdxPSPreviewState = (prsNone, prsEditHeaders, prsEditFooters);
  TdxPSThumbnailsSize = (tsSmall, tsLarge);

 {$IFDEF OLEDRAGANDDROP} 
 {$ENDIF}  
  
  TdxPreviewWindowClass = class of TBasedxPreviewWindow;    
                                              
  TBasedxPreviewWindow = class(TCustomdxPSForm, {$IFNDEF DELPHI6} IUnknown, {$ENDIF} 
    IdxPSExplorerContextCommandBuilder {$IFDEF OLEDRAGANDDROP}, IDropTarget{$ENDIF})
  private
   {$IFDEF OLEDRAGANDDROP}
    FDraggedFileName: string;
   {$ENDIF} 
    function GetReportLink: TBasedxReportLink;
  protected
   {$IFNDEF DELPHI6}
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; override;
    function _Addref: Integer; stdcall;
    function _Release: Integer; stdcall;
   {$ENDIF}
   {$IFDEF OLEDRAGANDDROP}
    { IDropTarget }
    function IDropTarget.DragEnter = IDropTarget_DragEnter;
    function IDropTarget.DragOver = IDropTarget_DragOver;
    function IDropTarget.DragLeave = IDropTarget_DragLeave;
    function IDropTarget.Drop = IDropTarget_Drop;

    function IDropTarget_DragEnter(const DataObj: IDataObject; grfKeyState: Longint; 
      Pt: TPoint; var dwEffect: Longint): HRESULT;  stdcall; 
    function IDropTarget_DragOver(grfKeyState: Longint; Pt: TPoint; 
      var dwEffect: Longint): HRESULT;  stdcall; 
    function IDropTarget_DragLeave: HRESULT;  stdcall; 
    function IDropTarget_Drop(const DataObj: IDataObject; grfKeyState: Longint; Pt: TPoint; 
      var dwEffect: Longint): HRESULT;  stdcall; 
   {$ENDIF}
         
    procedure AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand); virtual;
    procedure UpdateExplorerContextCommands; virtual;

    function GetActivePageIndex: Integer; virtual; abstract;
    function GetBackground: TdxBackground; virtual; abstract;
    function GetComponentPrinter: TCustomdxComponentPrinter; virtual; abstract;
    function GetExplorerTree: TCustomdxPSExplorerTreeContainer; virtual; 
    function GetHFEditPart: TdxPageTitlePart; virtual;
    function GetPageCount: Integer; virtual; abstract;
    function GetPreviewEnableOptions: TdxPreviewEnableOptions; virtual; abstract;
    function GetPreviewVisibleOptions: TdxPreviewVisibleOptions; virtual; abstract;
    function GetSaveZoomPosition: Boolean; virtual; abstract;
    function GetShowExplorer: Boolean; virtual;
    function GetShowThumbnails: Boolean; virtual;
    function GetState: TdxPSPreviewState; virtual;
    function GetThumbnailsSize: TdxPSThumbnailsSize; virtual; abstract;
    function GetVisiblePageSize: TPoint; virtual; abstract;
    function GetZoomFactor: Integer; virtual; abstract;
    procedure SetActivePageIndex(Value: Integer); virtual; abstract;
    procedure SetBackground(const Value: TdxBackground); virtual; abstract;
    procedure SetComponentPrinter(const Value: TCustomdxComponentPrinter); virtual; abstract;
    procedure SetHFEditPart(const Value: TdxPageTitlePart); virtual; abstract;
    procedure SetPageCount(Value: Integer); virtual; abstract;
    procedure SetPreviewEnableOptions(const Value: TdxPreviewEnableOptions); virtual; abstract;
    procedure SetPreviewVisibleOptions(const Value: TdxPreviewVisibleOptions); virtual; abstract;
    procedure SetSaveZoomPosition(Value: Boolean); virtual; abstract;
    procedure SetShowExplorer(Value: Boolean); virtual;
    procedure SetShowThumbnails(Value: Boolean); virtual;
    procedure SetState(const Value: TdxPSPreviewState); virtual; abstract;
    procedure SetThumbnailsSize(const Value: TdxPSThumbnailsSize); virtual; abstract;
    procedure SetZoomFactor(Value: Integer); virtual; abstract;

    procedure BeginUpdate; virtual;
    procedure CancelUpdate; virtual;
    procedure EndUpdate; virtual;
    function Locked: Boolean; virtual;
    procedure UpdateCaption;

    procedure CreationComplete; virtual;
    procedure PaintPage(Sender: TObject; ACanvas: TCanvas; ARect: TRect; APageIndex: Integer); virtual;
    procedure PaintThumbnailPage(Sender: TObject; ACanvas: TCanvas; ARect: TRect; APageIndex: Integer); virtual;
    
   {$IFDEF OLEDRAGANDDROP}
    function CanDrop: Boolean; virtual;
    function DoCanAccept: Boolean; virtual;
    procedure DoDrop; virtual;
    property DraggedFileName: string read FDraggedFileName;
   {$ENDIF}
  public
    destructor Destroy; override;

    procedure GoToFirstPage; virtual; abstract;
    procedure GoToLastPage; virtual; abstract;
    procedure GoToNextPage; virtual; abstract;
    procedure GoToPrevPage; virtual; abstract;

    procedure InitContent; virtual;
    procedure InvalidateContent; virtual;
    procedure InvalidatePage(APageIndex: Integer); virtual;
    procedure InvalidateAllPages; virtual;
    procedure InvalidatePagesContent; virtual;
    procedure InvalidatePagesHeaderContent; virtual;
    procedure InvalidatePagesFooterContent; virtual;

    procedure RebuildReport; virtual;

    procedure UpdateControls; virtual;

    property ActivePageIndex: Integer read GetActivePageIndex write SetActivePageIndex;
    property Background: TdxBackground read GetBackground write SetBackground;
    property ComponentPrinter: TCustomdxComponentPrinter read GetComponentPrinter write SetComponentPrinter;
    property EnableOptions: TdxPreviewEnableOptions read GetPreviewEnableOptions write SetPreviewEnableOptions;
    property ExplorerTree: TCustomdxPSExplorerTreeContainer read GetExplorerTree;
    property HFEditPart: TdxPageTitlePart read GetHFEditPart write SetHFEditPart;
    property PageCount: Integer read GetPageCount write SetPageCount;
    property ReportLink: TBasedxReportLink read GetReportLink;
    property SaveZoomPosition: Boolean read GetSaveZoomPosition write SetSaveZoomPosition;
    property ShowExplorer: Boolean read GetShowExplorer write SetShowExplorer;
    property ShowThumbnails: Boolean read GetShowThumbnails write SetShowThumbnails;
    property State: TdxPSPreviewState read GetState write SetState;
    property ThumbnailsSize: TdxPSThumbnailsSize read GetThumbnailsSize write SetThumbnailsSize;
    property VisibleOptions: TdxPreviewVisibleOptions read GetPreviewVisibleOptions write SetPreviewVisibleOptions;
    property VisiblePageSize: TPoint read GetVisiblePageSize;
    property ZoomFactor: Integer read GetZoomFactor write SetZoomFactor;
  end;

  TdxPreviewOptions = class;
  
  TdxComponentPrinterThumbnailsOptions = class(TPersistent)
  private
    FDefaultFont: TFont;
    FFont: TFont;
    FPreviewOptions: TdxPreviewOptions;
    FShowPageNumbers: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetShowPageNumbers(Value: Boolean);
  protected
    procedure InitializeDefaultFont(AFont: TFont); virtual;
    function IsFontStored: Boolean; virtual;
  public
    constructor Create(APreviewOptions: TdxPreviewOptions); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    function DefaultFont: TFont; virtual;
    procedure RestoreDefaults; virtual;

    property PreviewOptions: TdxPreviewOptions read FPreviewOptions;
  published
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property ShowPageNumbers: Boolean read FShowPageNumbers write SetShowPageNumbers default True;
  end;
                 
  TdxPreviewOptions = class(TdxBaseObject)
  private
    FCaption: string;
    FComponentPrinter: TCustomdxComponentPrinter;
    FDefaultIcon: TIcon;
    FEnableOptions: TdxPreviewEnableOptions;
    FIcon: TIcon;
    FHelpContext: THelpContext;
    FIsBoundsAssigned: Boolean;
    FIsCaptionAssigned: Boolean;
    FIsIconAssigned: Boolean;                
    FRect: TRect;
    FSavePosition: Boolean;
    FSaveZoomPosition: Boolean;
    FShowExplorer: Boolean;
    FThumbnailsOptions: TdxComponentPrinterThumbnailsOptions;
    FVisibleOptions: TdxPreviewVisibleOptions;
    FWindowState: TWindowState;
    function GetCaption: string;
    function GetHelpFile: string;
    function GetIcon: TIcon;
    function GetPosition(index: Integer): Integer;
    function GetRect: TRect;
    function GetRegistryPath: string;
    function IsBoundsStored: Boolean;
    function IsCaptionStored: Boolean;
    function IsIconStored: Boolean;
    procedure SetCaption(const Value: string);
    procedure SetEnableOptions(Value: TdxPreviewEnableOptions);
    procedure SetHelpContext(Value: THelpContext);
    procedure SetHelpFile(const Value: string);
    procedure SetIcon(Value: TIcon);
    procedure SetPosition(Index: Integer; Value: Integer);
    procedure SetRect(Value: TRect);
    procedure SetRegistryPath(const Value: string);
    procedure SetShowExplorer(Value: Boolean);
    procedure SetThumbnailsOptions(Value: TdxComponentPrinterThumbnailsOptions);
    procedure SetVisibleOptions(Value: TdxPreviewVisibleOptions);
    procedure SetWindowState(Value: TWindowState);
    
    function HasPreviewWindow: Boolean;
    function PreviewWindow: TBasedxPreviewWindow;

    procedure ReadBoundsRect(Stream: TStream);
    procedure ReadIsCaptionAssigned(Reader: TReader);
    procedure ReadIsIconAssigned(Reader: TReader);
    procedure WriteBoundsRect(Stream: TStream);
    procedure WriteIsCaptionAssigned(Writer: TWriter);
    procedure WriteIsIconAssigned(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;

    procedure DoAssign(Source: TdxBaseObject); override;
    procedure DoRestoreDefaults; override;

    function GetIsIconAssigned: Boolean;
    procedure IconChanged(Sender: TObject); virtual;
    procedure InitializeDefaultIcon(AnIcon: TIcon); virtual;
    procedure RefreshIsIconAssigned;
  public
    constructor Create; override;
    destructor Destroy; override;

    function DefaultCaption: string; virtual;
    function DefaultIcon: TIcon; virtual;
    function DefaultRect: TRect; virtual;

    procedure RestoreOriginalIcon;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);

    property ComponentPrinter: TCustomdxComponentPrinter read FComponentPrinter;
    property IsIconAssigned: Boolean read FIsIconAssigned;
    property Rect: TRect read GetRect write SetRect;
  published
    property EnableOptions: TdxPreviewEnableOptions read FEnableOptions write SetEnableOptions
      default [peoCanChangeMargins, peoPageBackground, peoPageSetup, peoPreferences, peoPrint, peoReportDesign];
    property Caption: string read GetCaption write SetCaption stored IsCaptionStored;
    property Height: Integer index 0 read GetPosition write SetPosition stored False;
    property HelpFile: string read GetHelpFile write SetHelpFile stored False;
    property HelpContext: THelpContext read FHelpContext write SetHelpContext default 0;
    property Icon: TIcon read GetIcon write SetIcon stored IsIconStored;
    property Left: Integer index 1 read GetPosition write SetPosition stored False;
    property RegistryPath: string read GetRegistryPath write SetRegistryPath stored False;
    property SavePosition: Boolean read FSavePosition write FSavePosition stored False default True;
    property SaveZoomPosition: Boolean read FSaveZoomPosition write FSaveZoomPosition default True;
    property ShowExplorer: Boolean read FShowExplorer write SetShowExplorer default False;
    property ThumbnailsOptions: TdxComponentPrinterThumbnailsOptions read FThumbnailsOptions write SetThumbnailsOptions;
    property Top: Integer index 2 read GetPosition write SetPosition stored False;
    property VisibleOptions: TdxPreviewVisibleOptions read FVisibleOptions write SetVisibleOptions
      default [pvoPageSetup, pvoPageBackground, pvoPreferences, pvoPrint, pvoReportDesign, pvoPrintStyles, 
               pvoReportFileOperations, pvoPageMargins];
    property Width: Integer index 3 read GetPosition write SetPosition stored False;
    property WindowState: TWindowState read FWindowState write SetWindowState default wsNormal;
  end;

  { ComponentPrinter }
  
  TdxBeforeDesignReportEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    ADesignWindow: TAbstractdxReportLinkDesignWindow) of object;
  
  TdxCustomDrawPageEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    ACanvas: TCanvas; APageIndex: Integer; ARect: TRect; ANom, ADenom: Integer) of object;
    
  TdxCustomDrawReportTitleEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    ACanvas: TCanvas; ARect: TRect; ANom, ADenom: Integer;
    var TextAlignX: TcxTextAlignX; var TextAlignY: TcxTextAlignY;
    var AColor: TColor; AFont: TFont; var ADone: Boolean) of object;
    
  TdxCustomDrawPageHFEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    ACanvas: TCanvas; APageIndex: Integer; var ARect: TRect; ANom, ADenom: Integer;
    var ADefaultDrawText, ADefaultDrawBackground: Boolean) of object;

  TdxDesignReportEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    var ADone: Boolean) of object;

  TdxGenerateReportProgressEvent = procedure(Sender: TObject;
    AReportLink: TBasedxReportLink; APercentDone: Double {'##0.00'}) of object;

  TdxGetPrintTitleEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    var ATitle: string) of object;

  TdxPrintDlgDataEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink; 
    var APrintDlgData: TdxPrintDlgData) of object;
  
  TdxMeasureReportTitleEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    var AHeight: Integer) of object;

  TdxNewPageEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    APageIndex: Integer) of object;

  TdxPageSetupEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    ADone: Boolean) of object;

  TdxPreviewEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink) of object;

  TdxPrintDeviceProblemEvent = procedure(Sender: TObject; var ADone: Boolean) of object;

  TdxReportLinkNotifyEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink) of object;

  TdxStartPrintEvent = procedure(Sender: TObject; AReportLink: TBasedxReportLink;
    APageCount: Integer) of object;
    
  TdxCPOption = (cpoAutoRebuildBeforePreview, cpoAutoRebuildBeforePrint,
    cpoGenerateReportProgressEvent, cpoShowHourGlass, cpoDropStorageModeAfterPreview);
  TdxCPOptions = set of TdxCPOption;

  TdxCPState = (cpsBuilding, cpsDesigning, cpsPreviewing, cpsPrinting, cpsPrintDialog, 
    cpsPageSetupDialog, cpsDefineStylesDialog, cpsCustomizing, cpsLoading, cpsSaving, 
    cpsExplore);
  TdxCPStates = set of TdxCPState;

  TdxPSBuildStage = (bsStart, bsProgress, bsEnd);
  TdxPSPrintStage = (psStart, psProgress, psEnd);
  
  TdxPSComponentPrinterExplorerChangeNotifier = class(TdxPSExplorerChangeNotifierAdapter)
  private
    FComponentPrinter: TCustomdxComponentPrinter;
  protected
    procedure ItemDataUnloaded(AnItem: TdxPSExplorerItem); override;  
  public
    constructor Create(AComponentPrinter: TCustomdxComponentPrinter);
    property ComponentPrinter: TCustomdxComponentPrinter read FComponentPrinter;
  end;
  
  TCustomdxComponentPrinter = class(TComponent)
  private
    FAbortBuilding: Boolean;
    FAbortPrinting: Boolean;
    FAutoUpdateDateTime: Boolean;
    FBeepAfterLongOperations: Boolean;
    FCurrentLink: TBasedxReportLink;
    FDateFormat: Integer;
    FExplorer: TCustomdxPSExplorer;
    FExplorerChangeNotifier: TdxPSComponentPrinterExplorerChangeNotifier;
    FExplorerStubLink: TBasedxReportLink;
    FInternalStreaming: Boolean;
    FLongOperationTime: Integer;
    FOptions: TdxCPOptions;
    FPageNumberFormat: TdxPageNumberFormat;
    FPreviewOptions: TdxPreviewOptions;
    FPreviewWindow: TBasedxPreviewWindow;
    FPreviewWindowDesigner: TAbstractdxPreviewWindowDesigner;
    FPrintFileList: TStrings;
    FPrintTitle: string;
    FReportLinkDesigner: TAbstractdxReportLinkDesigner;
    FReportLinks: TList;
    FState: TdxCPStates;
    FTimeFormat: Integer;
    FVersion: Integer;

    FOnAddReportLink: TdxReportLinkNotifyEvent;
    FOnAfterPreview: TdxPreviewEvent;
    FOnBeforeDesignReport: TdxBeforeDesignReportEvent;
    FOnBeforePreview: TdxPreviewEvent;
    FOnChangeComponent: TdxReportLinkNotifyEvent;
    FOnChangeCurrentLink: TNotifyEvent;
    FOnCustomDrawPage: TdxCustomDrawPageEvent;
    FOnCustomDrawPageFooter: TdxCustomDrawPageHFEvent;
    FOnCustomDrawPageHeader: TdxCustomDrawPageHFEvent;
    FOnCustomDrawReportTitle: TdxCustomDrawReportTitleEvent;
    FOnDeleteReportLink: TdxReportLinkNotifyEvent;
    FOnDesignReport: TdxDesignReportEvent;
    FOnEndGenerateReport: TdxReportLinkNotifyEvent;
    FOnEndPrint: TdxReportLinkNotifyEvent;
    FOnFinalizePrintDlgData: TdxPrintDlgDataEvent;
    FOnGenerateReportProgress: TdxGenerateReportProgressEvent;
    FOnGetPrintTitle: TdxGetPrintTitleEvent;
    FOnInitializePrintDlgData: TdxPrintDlgDataEvent;
    FOnMeasureReportTitle: TdxMeasureReportTitleEvent;
    FOnNewPage: TdxNewPageEvent;
    FOnPageSetup: TdxPageSetupEvent;
    FOnPrintDeviceBusy: TdxPrintDeviceProblemEvent;
    FOnPrintDeviceError: TdxPrintDeviceProblemEvent;
    FOnStartGenerateReport: TdxReportLinkNotifyEvent;
    FOnStartPrint: TdxStartPrintEvent;

    FEndTime: DWORD;
    FHFTextEntryChooseSubscriber: TdxEventSubscriber;
    FLongOperationCounter: Integer;
    FMemoryStream: TStream;
    FModalPreview: Boolean;
    FPrintAll: Boolean;
    FSaveCollate: Boolean;
    FSaveCopies: Integer;
    FSavePageIndex: Integer;
    FSavePrintToFile: Boolean;
    FStartTime: DWORD;
    FWindowHandle: HWND;
    function GetCurrentLinkIndex: Integer;
    function GetExplorerRealStubLink: TBasedxReportLink;
    function GetIsExplorerMode: Boolean;
    function GetLinkCount: Integer;
    function GetPreviewCaption: string;
    function GetReportLink(index: Integer): TBasedxReportLink;
    procedure SetAbortBuilding(Value: Boolean);
    procedure SetAbortPrinting(Value: Boolean);
    procedure SetAutoUpdateDateTime(Value: Boolean);
    procedure SetCurrentLink(Value: TBasedxReportLink);
    procedure SetCurrentLinkIndex(Value: Integer);
    procedure SetDateFormat(Value: Integer);
    procedure SetExplorer(Value: TCustomdxPSExplorer);
    procedure SetExplorerStubLink(Value: TBasedxReportLink);
    procedure SetLongOperationTime(Value: Integer);
    procedure SetPageNumberFormat(Value: TdxPageNumberFormat);
    procedure SetPreviewOptions(Value: TdxPreviewOptions);
    procedure SetupPreviewProperties(APreviewWindow: TBasedxPreviewWindow);
    procedure SetPrintFileList(Value: TStrings);
    procedure SetReportLink(index: Integer; Value: TBasedxReportLink);
    procedure SetTimeFormat(Value: Integer);

    function BeginPrintPages(const Source: string; out APageIndexes: TIntegers): Boolean;
    procedure EndPrintPages(var APageIndexes: TIntegers);

    function CreatePreviewWindow(AReportLink: TBasedxReportLink): TBasedxPreviewWindow;
    procedure DestroyPreviewWindow;
    
    procedure FinalizeDefaultPrintDlgData(AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData); virtual;
    procedure InitializeDefaultPrintDlgData(AReportLink: TBasedxReportLink; out APrintDlgData: TdxPrintDlgData); virtual;

    procedure InitDevModeFromPrinterPageSettings(APrinterPage: TdxPrinterPage);

    function PrintDialog(AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData): Boolean;
    function PrintPagesAsStringEx(const APages: string; APageNums: TdxPageNumbers; 
      ACopyCount: Integer; ACollate: Boolean; AReportLink: TBasedxReportLink = nil): Boolean;
    procedure PrnDlgPageSetup(Sender: TObject; var ADone: Boolean;
      APreviewBtnClicked, APrintBtnClicked: PBoolean);

    procedure RaiseBuildingEvent(AReportLink: TBasedxReportLink;
      const APercentCompleted: Double; AStage: TdxPSBuildStage);
    procedure RaisePrintingEvent(AReportLink: TBasedxReportLink;
      APageIndex, APageCount: Integer; AStage: TdxPSPrintStage);

    procedure ActivateLink(AReportLink: TBasedxReportLink);
    function CheckLink(Value: TBasedxReportLink): TBasedxReportLink;
    function CreateLink(ALinkClass: TdxReportLinkClass;
      AComponent: TComponent; AOwner: TComponent): TBasedxReportLink;
    procedure DeactivateLink(AReportLink: TBasedxReportLink);      
    procedure InsertLink(Value: TBasedxReportLink);
    procedure MoveLink(ACurIndex, ANewIndex: Integer);
    procedure RemoveLink(Value: TBasedxReportLink);
    procedure ResyncCurrentLink(AIndex: Integer);

    procedure OnHFTextEntryChosen(Sender: TObject; const AEntry: string);
    
    { design-time support }
    procedure DesignerModified;
    procedure DesignerUpdate(AnItem: TBasedxReportLink);
    function IsDesigning: Boolean;
    function IsDestroying: Boolean;
    function IsLoading: Boolean;

    procedure ShowExistingPreviewWindow;
    procedure WndProc(var Message: TMessage);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;

    procedure DoAddReportLink(AReportLink: TBasedxReportLink); dynamic;
    procedure DoAfterPreview(AReportLink: TBasedxReportLink); dynamic;
    procedure DoBeforeDesignReport(AReportLink: TBasedxReportLink); dynamic;
    procedure DoBeforeDestroyReport(AReportLink: TBasedxReportLink); dynamic;
    procedure DoBeforePreview(AReportLink: TBasedxReportLink); dynamic;
    procedure DoChangeComponent(AReportLink: TBasedxReportLink); dynamic;
    procedure DoChangeCurrentLink; dynamic;
    procedure DoCustomDrawEntirePage(AReportLink: TBasedxReportLink; ACanvas: TCanvas;
      APageIndex: Integer; ARect: TRect; ANom, ADenom: Integer); virtual;
    procedure DoCustomDrawPageHeaderOrFooter(AReportLink: TBasedxReportLink;
      AHFObject: TCustomdxPageObject; ACanvas: TCanvas; APageIndex: Integer;
      R: TRect; var ADefaultDrawText, ADefaultDrawBackground: Boolean;
      APixelsNumerator: Integer = 0); virtual;
    procedure DoCustomDrawReportTitle(AReportLink: TBasedxReportLink; ACanvas: TCanvas;
      ARect: TRect; var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
      var AColor: TColor; AFont: TFont; var ADone: Boolean;
      APixelsNumerator: Integer = 0); virtual;
    procedure DoDeleteReportLink(AReportLink: TBasedxReportLink); dynamic;
    procedure DoDesignReport(AReportLink: TBasedxReportLink; ADone: Boolean); dynamic;
    procedure DoEndPrint(AReportLink: TBasedxReportLink); dynamic;
    procedure DoFinalizePrintDlgData(AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData); dynamic;
    procedure DoInitializePrintDlgData(AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData); dynamic;
    procedure DoMeasureReportTitle(AReportLink: TBasedxReportLink; var AHeight: Integer); virtual;
    procedure DoNewPage(AReportLink: TBasedxReportLink; APageIndex: Integer); dynamic;
    procedure DoPageParamsChanged(AReportLink: TBasedxReportLink);
    procedure DoPageSetup(AReportLink: TBasedxReportLink; ADone: Boolean); dynamic;
    procedure DoPrintDeviceBusy; dynamic;
    procedure DoPrintDeviceError; dynamic;
    procedure DoProgress(AReportLink: TBasedxReportLink; const PercentDone: Double); dynamic;
    procedure DoStartPrint(AReportLink: TBasedxReportLink; FullPageCount: Integer); dynamic;
    procedure DoStartUpdateReport(AReportLink: TBasedxReportLink); dynamic;
    procedure DoEndUpdateReport(AReportLink: TBasedxReportLink); dynamic;
    function GetPrintTitle(AReportLink: TBasedxReportLink): string; dynamic;
    procedure StdProcessPrintDeviceBusy; virtual;
    procedure StdProcessPrintDeviceError; virtual;

    function IsCustomPrintDlgData: Boolean;
    
    function IsForegroundPreviewWindow: Boolean;
    function IsGenerateReportProgressEvent: Boolean;
    function IsRebuildBeforeOutput(AForceRebuild: Boolean): Boolean;
    function IsRebuildBeforePreview: Boolean;
    function IsRebuildBeforePrint: Boolean;
    function IsShowHourGlass: Boolean;

    procedure PaintThumbnailPage(ACanvas: TCanvas; APageIndex: Integer; 
      const APageBounds, AContentBounds: TRect; AReportLink: TBasedxReportLink = nil);
    procedure PaintThumbnailPageIndex(ACanvas: TCanvas; const R: TRect; APageIndex: Integer);
    
    procedure FormatChanged(AReportLink: TBasedxReportLink);
    procedure PreparePageSetup;
    procedure PrepareBuildReport(AReportLink: TBasedxReportLink);
    procedure PrepareLongOperation;
    procedure PreparePrintDevice;
    procedure PrepareReport(AReportLink: TBasedxReportLink);
    procedure PrintPage(AReportLink: TBasedxReportLink; APageIndex: Integer); virtual;
    procedure UnprepareBuildReport(AReportLink: TBasedxReportLink);
    procedure UnprepareLongOperation;
    procedure UnpreparePageSetup;
    procedure UnpreparePrintDevice;
    procedure UnprepareReport(AReportLink: TBasedxReportLink);

    { Stream loading }
    procedure AfterLoadFromStream(AStream: TStream);
    procedure BeforeLoadFromStream(AStream: TStream);
    procedure ErrorLoadFromStream(AStream: TStream);
    procedure LoadItselfFromStream(AStream: TStream);    
    procedure LoadLinksFromStream(AStream: TStream);    
    procedure LoadVersionFromStream(AStream: TStream; var AVersion: Integer);
    procedure PrepareLoadFromStream(AStream: TStream);    
    procedure UnprepareLoadFromStream(AStream: TStream);
    { Stream saving}
    procedure PrepareSaveToStream(AStream: TStream);    
    procedure SaveItselfToStream(AStream: TStream);
    procedure SaveLinksToStream(AStream: TStream);    
    procedure SaveVersionToStream(AStream: TStream);
    procedure UnprepareSaveToStream(AStream: TStream);    
    
    property ExplorerChangeNotifier: TdxPSComponentPrinterExplorerChangeNotifier read FExplorerChangeNotifier;
    property PreviewCaption: string read GetPreviewCaption;
    property OnAfterPreview: TdxPreviewEvent read FOnAfterPreview  write FOnAfterPreview;
    property OnBeforeDesignReport: TdxBeforeDesignReportEvent read FOnBeforeDesignReport write FOnBeforeDesignReport;
    property OnBeforePreview: TdxPreviewEvent read FOnBeforePreview  write FOnBeforePreview;
    property OnChangeComponent: TdxReportLinkNotifyEvent read FOnChangeComponent write FOnChangeComponent;
    property OnChangeCurrentLink: TNotifyEvent read FOnChangeCurrentLink  write FOnChangeCurrentLink;
    property OnCustomDrawPageHeader: TdxCustomDrawPageHFEvent read FOnCustomDrawPageHeader write FOnCustomDrawPageHeader;
    property OnCustomDrawPageFooter: TdxCustomDrawPageHFEvent read FOnCustomDrawPageFooter write FOnCustomDrawPageFooter;
    property OnCustomDrawReportTitle: TdxCustomDrawReportTitleEvent read FOnCustomDrawReportTitle write FOnCustomDrawReportTitle;
    property OnDesignReport: TdxDesignReportEvent read FOnDesignReport write FOnDesignReport;
    property OnMeasureReportTitle: TdxMeasureReportTitleEvent read FOnMeasureReportTitle write FOnMeasureReportTitle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddComposition: TdxCompositionReportLink;
    function AddEmptyLink(ALinkClass: TdxReportLinkClass): TBasedxReportLink;
    function AddEmptyLinkEx(ALinkClass: TdxReportLinkClass; AOwner: TComponent): TBasedxReportLink;
    function AddLink(AComponent: TComponent): TBasedxReportLink;
    function AddLinkEx(AComponent: TComponent; AOwner: TComponent): TBasedxReportLink;
    procedure AssignReportLinks(Source: TCustomdxComponentPrinter);
    function CreateLinkFromFile(const AFileName: string): TBasedxReportLink;
    function CreateLinkFromStream(AStream: TStream): TBasedxReportLink;
    procedure DeleteAllLinks;
    procedure DeleteLink(AIndex: Integer);
    procedure DestroyReport(AReportLink: TBasedxReportLink = nil);
    function FindLinkByComponent(Value: TComponent; ACanCreate: Boolean = False): TBasedxReportLink;
    procedure GetLinks(AList: TList);
    function IndexOfLink(AReportLink: TBasedxReportLink): Integer; overload;
    function IndexOfLink(const AName: string): Integer; overload;
    function IndexOfLinkByName(const AName: string): Integer;
    function LinkByName(const AName: string): TBasedxReportLink;
    procedure RebuildReport(AReportLink: TBasedxReportLink = nil);

    class function GetNewLinkName(AReportLink: TBasedxReportLink): string;
    class function IsSupportedCompClass(AComponentClass: TClass): Boolean; overload;
    class function IsSupportedCompClass(AComponent: TObject{TComponent}): Boolean; overload;
    
    { composition support }
    function CurrentCompositionByLink(AReportLink: TBasedxReportLink): TdxCompositionReportLink;    
    procedure GetCompositionsByLink(AReportLink: TBasedxReportLink; ACompositions: TList);
    procedure GetItems(AComposition: TdxCompositionReportLink; AStrings: TStrings; AExcludeAssigned: Boolean);
    function IsLinkInComposition(AReportLink: TBasedxReportLink; AComposition: TdxCompositionReportLink): Boolean;
    function IsLinkInCurrentComposition(AReportLink: TBasedxReportLink): Boolean;    
    
    procedure Explore;
    
    function DesignerExists(AReportLink: TBasedxReportLink = nil): Boolean;
    function DesignerExistsByComponent(AComponent: TComponent): Boolean;
    function DesignReport(AReportLink: TBasedxReportLink = nil): Boolean;

    procedure DrawPageFooter(AReportLink: TBasedxReportLink; APageIndex: Integer;
      ARect: TRect; ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
    procedure DrawPageHeader(AReportLink: TBasedxReportLink; APageIndex: Integer;
      ARect: TRect; ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);

    procedure GetPageColRowCount(out ACol, ARow: Integer; AReportLink: TBasedxReportLink = nil);
    function GetPageCount(AReportLink: TBasedxReportLink = nil): Integer;

    function PageSetup(AReportLink: TBasedxReportLink = nil): Boolean;
    function PageSetupEx(AActivePageIndex: Integer; AShowPreviewBtn, AShowPrintBtn: Boolean; 
      out APreviewBtnClicked, APrintBtnClicked: Boolean; AReportLink: TBasedxReportLink = nil): Boolean; overload;
    function PageSetupEx(AActivePageIndex: Integer; APreviewBtnClicked, APrintBtnClicked: PBoolean;
      AReportLink: TBasedxReportLink = nil): Boolean; overload; {$IFDEF DELPHI6} deprecated; {$ENDIF}

    procedure PaintPage(ACanvas: TCanvas; APageIndex: Integer; 
      const APageBounds, AContentBounds: TRect; AReportLink: TBasedxReportLink = nil);

    procedure Preview(AModal: Boolean = True; AReportLink: TBasedxReportLink = nil);
    function PreviewExists: Boolean;

    function Print(AShowDialog: Boolean; APPrintDlgData: PdxPrintDlgData;
      AReportLink: TBasedxReportLink = nil): Boolean; 
    procedure PrintEx(APageNums: TdxPageNumbers; ACopies: Integer; ACollate: Boolean; 
      AReportLink: TBasedxReportLink = nil);
    procedure PrintPages(const APageIndexes: array of Integer; 
      AReportLink: TBasedxReportLink = nil);
    procedure PrintPagesEx(const APageIndexes: array of Integer;
      APageNums: TdxPageNumbers; ACopyCount: Integer; ACollate: Boolean; 
      AReportLink: TBasedxReportLink = nil);
    
    procedure LoadFromFile(const AName: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToFile(const AName: string);
    procedure SaveToStream(AStream: TStream);
   
    property AbortBuilding: Boolean read FAbortBuilding write SetAbortBuilding;
    property AbortPrinting: Boolean read FAbortPrinting write SetAbortPrinting;
    property AutoUpdateDateTime: Boolean read FAutoUpdateDateTime write SetAutoUpdateDateTime default True;
    property BeepAfterLongOperations: Boolean read FBeepAfterLongOperations write FBeepAfterLongOperations default True;
    property CurrentLink: TBasedxReportLink read FCurrentLink write SetCurrentLink;
    property CurrentLinkIndex: Integer read GetCurrentLinkIndex write SetCurrentLinkIndex;
    property DateFormat: Integer read FDateFormat write SetDateFormat default 0;
    property Explorer: TCustomdxPSExplorer read FExplorer write SetExplorer;
    property ExplorerRealStubLink: TBasedxReportLink read GetExplorerRealStubLink;
    property ExplorerStubLink: TBasedxReportLink read FExplorerStubLink write SetExplorerStubLink;
    property IsExplorerMode: Boolean read GetIsExplorerMode;
    property LinkCount: Integer read GetLinkCount;
    property LongOperationTime: Integer read FLongOperationTime write SetLongOperationTime default 5000; {ms}
    property Options: TdxCPOptions read FOptions write FOptions
      default [Low(TdxCPOption)..High(TdxCPOption)]; {dxDefaultCPOptions}
    property PageNumberFormat: TdxPageNumberFormat read FPageNumberFormat write SetPageNumberFormat default pnfNumeral;
    property PreviewOptions: TdxPreviewOptions read FPreviewOptions write SetPreviewOptions;
    property PreviewWindow: TBasedxPreviewWindow read FPreviewWindow;
    property PrintFileList: TStrings read FPrintFileList write SetPrintFileList;
    property PrintTitle: string read FPrintTitle write FPrintTitle;
    property ReportLink[Index: Integer]: TBasedxReportLink read GetReportLink write SetReportLink; default;
    property State: TdxCPStates read FState;  
    property TimeFormat: Integer read FTimeFormat write SetTimeFormat default 0;
    property Version: Integer read FVersion write FVersion;

    property PreviewWindowDesigner: TAbstractdxPreviewWindowDesigner read FPreviewWindowDesigner;
    property ReportLinkDesigner: TAbstractdxReportLinkDesigner read FReportLinkDesigner;

    property OnAddReportLink: TdxReportLinkNotifyEvent read FOnAddReportLink write FOnAddReportLink;
    property OnCustomDrawPage: TdxCustomDrawPageEvent read FOnCustomDrawPage write FOnCustomDrawPage;
    property OnDeleteReportLink: TdxReportLinkNotifyEvent read FOnDeleteReportLink write FOnDeleteReportLink;
    property OnEndGenerateReport: TdxReportLinkNotifyEvent read FOnEndGenerateReport write FOnEndGenerateReport;
    property OnEndPrint: TdxReportLinkNotifyEvent read FOnEndPrint write FOnEndPrint;
    property OnFinalizePrintDlgData: TdxPrintDlgDataEvent read FOnFinalizePrintDlgData write FOnFinalizePrintDlgData;
    property OnGenerateReportProgress: TdxGenerateReportProgressEvent read FOnGenerateReportProgress write FOnGenerateReportProgress;
    property OnGetPrintTitle: TdxGetPrintTitleEvent read FOnGetPrintTitle write FOnGetPrintTitle;
    property OnInitializePrintDlgData: TdxPrintDlgDataEvent read FOnInitializePrintDlgData write FOnInitializePrintDlgData;
    property OnNewPage: TdxNewPageEvent read FOnNewPage write FOnNewPage;
    property OnPageSetup: TdxPageSetupEvent read FOnPageSetup write FOnPageSetup;
    property OnPrintDeviceBusy: TdxPrintDeviceProblemEvent read FOnPrintDeviceBusy write FOnPrintDeviceBusy;
    property OnPrintDeviceError: TdxPrintDeviceProblemEvent read FOnPrintDeviceError write FOnPrintDeviceError;
    property OnStartGenerateReport: TdxReportLinkNotifyEvent read FOnStartGenerateReport write FOnStartGenerateReport;
    property OnStartPrint: TdxStartPrintEvent read FOnStartPrint write FOnStartPrint;
  end;

  TdxEnumPagesAsImagesProc = procedure(AComponentPrinter: TCustomdxComponentPrinter;
    AReportLink: TBasedxReportLink; AIndex, APageIndex: Integer;
    const AGraphic: TGraphic; AData: Pointer; 
    var AContinue: Boolean) of object;

  TdxExportProgressEvent = procedure(Sender: TCustomdxComponentPrinter;
    AReportLink: TBasedxReportLink; APageCount, AIndex, APageIndex: Integer;
    AData: Pointer) of object;

  TdxExportPrepareGraphicEvent = procedure(Sender: TCustomdxComponentPrinter;
    AReportLink: TBasedxReportLink; const AGraphic: TGraphic;
    AData: Pointer) of object;
    
  TdxExportGetPageFileNameEvent = procedure(Sender: TCustomdxComponentPrinter;
    AIndex, APageIndex: Integer; var AFileName: string) of object;
    
  TdxOnFilterComponentEvent = procedure(Sender: TObject; var AComponent: TComponent; 
    var ACaption, ADescription: string; var Accept: Boolean) of object;
    
  TdxOnGetSupportedComponentsEvent = procedure(Sender: TObject; AComponents: TStrings) of object;
    
  TdxCPCustomizeDlgOption = (cdoShowDescription);
  TdxCPCustomizeDlgOptions = set of TdxCPCustomizeDlgOption;
  
  TdxComponentPrinter = class(TCustomdxComponentPrinter)
  private
    FCustomizeDlgOptions: TdxCPCustomizeDlgOptions;
    FOverWriteAll: Boolean;
    FOverWriteExistingFiles: Boolean;
    FOverWriteFile: Boolean;
    FOnExportGetPageFileName: TdxExportGetPageFileNameEvent;
    FOnExportPrepareGraphic: TdxExportPrepareGraphicEvent;
    FOnExportProgress: TdxExportProgressEvent;
    FOnFilterComponent: TdxOnFilterComponentEvent;
    FOnGetSupportedComponents: TdxOnGetSupportedComponentsEvent;  
    procedure WritePageAsImageToDisk(AComponentPrinter: TCustomdxComponentPrinter;
      AReportLink: TBasedxReportLink; AIndex, APageIndex: Integer;
      const AGraphic: TGraphic; AData: Pointer; 
      var AContinue: Boolean);
  protected
    procedure Loaded; override;
    function DoFilterComponent(AComponent: TComponent; var ACaption, ADescription: string): Boolean; dynamic;
    procedure GetDefaultExportPageFileName(AIndex, APageIndex: Integer; var AFileName: string); dynamic;
    procedure GetExportPageFileName(AIndex, APageIndex: Integer; var AFileName: string); dynamic;
    function GetSupportedComponents(AComponents: TStrings): Boolean; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    procedure ShowCustomizeDlg;
        
    procedure LoadFromRegistry(const APath: string);
    procedure SaveToRegistry(const APath: string);

    procedure EnumPagesAsImages(const APageIndexes: array of Integer;
      AGraphicClass: TGraphicClass; ADrawBackground: Boolean;
      ACallBackProc: TdxEnumPagesAsImagesProc; ACallBackData, AProgressData,
      APrepareData: Pointer; 
      AReportLink: TBasedxReportLink = nil);
    procedure SavePagesAsImagesToDisk(const APageIndexes: array of Integer;
      AGraphicClass: TGraphicClass; ADrawBackground: Boolean; const AFileMask: string;
      AProgressData, APrepareData: Pointer; 
      AReportLink: TBasedxReportLink = nil);
  published
    property AutoUpdateDateTime;
    property BeepAfterLongOperations;
    property CurrentLink;
    property CustomizeDlgOptions: TdxCPCustomizeDlgOptions read FCustomizeDlgOptions write FCustomizeDlgOptions
      default [cdoShowDescription];
    property DateFormat;
    property Explorer;
    property ExplorerStubLink;
    property LongOperationTime;
    property Options;
    property OverWriteExistingFiles: Boolean read FOverWriteExistingFiles write FOverWriteExistingFiles default False;
    property PageNumberFormat;
    property PreviewOptions;
    property PrintTitle;
    property TimeFormat;
    property Version;

    property OnAddReportLink;
    property OnAfterPreview;
    property OnBeforeDesignReport;
    property OnBeforePreview;
    property OnChangeComponent;
    property OnChangeCurrentLink;
    property OnCustomDrawPage;
    property OnCustomDrawPageFooter;
    property OnCustomDrawPageHeader;
    property OnCustomDrawReportTitle;
    property OnDeleteReportLink;
    property OnDesignReport;
    property OnEndGenerateReport;
    property OnEndPrint;
    property OnExportGetPageFileName: TdxExportGetPageFileNameEvent read FOnExportGetPageFileName write FOnExportGetPageFileName;
    property OnExportPrepareGraphic: TdxExportPrepareGraphicEvent read FOnExportPrepareGraphic write FOnExportPrepareGraphic;
    property OnExportProgress: TdxExportProgressEvent read FOnExportProgress write FOnExportProgress;
    property OnFilterComponent: TdxOnFilterComponentEvent read FOnFilterComponent write FOnFilterComponent;
    property OnFinalizePrintDlgData;
    property OnGetPrintTitle;
    property OnGenerateReportProgress;
    property OnGetSupportedComponents: TdxOnGetSupportedComponentsEvent read FOnGetSupportedComponents write FOnGetSupportedComponents;
    property OnInitializePrintDlgData;
    property OnMeasureReportTitle;
    property OnNewPage;
    property OnPageSetup;
    property OnPrintDeviceBusy;
    property OnPrintDeviceError;
    property OnStartGenerateReport;
    property OnStartPrint;
  end;

  TAbstractdxPreviewWindowDesigner = class
  private
    FComponentPrinter: TCustomdxComponentPrinter;
  protected
    procedure Activate; virtual; abstract;
    procedure Modified; virtual; abstract;
  public
    constructor Create(AComponentPrinter: TCustomdxComponentPrinter);
    destructor Destroy; override;

    property ComponentPrinter: TCustomdxComponentPrinter read FComponentPrinter;
  end;

  TAbstractdxReportLinkDesigner = class
  private
    FComponentPrinter: TCustomdxComponentPrinter;
  protected
    procedure Modified; virtual; abstract;
    procedure Update(Item: TBasedxReportLink); virtual; abstract;
  public
    constructor Create(AComponentPrinter: TCustomdxComponentPrinter);
    destructor Destroy; override;
    
    procedure BeginUpdate; virtual; abstract;
    procedure CancelUpdate; virtual; abstract;   
    procedure EndUpdate; virtual; abstract;

    property ComponentPrinter: TCustomdxComponentPrinter read FComponentPrinter;
  end;

{ This si a routine for fast PrintPreview and(or) Printing an individual component.
  You MUST add "unit" contained "Link" that supports the "AComponent" into the uses
  clause of the your unit }

function dxPrintComponent(AComponent: TComponent; APrintPreview: Boolean = True; 
  APrintDialog: Boolean = False; const AReportTitle: string = ''; 
  const APrintTitle: string = ''): Boolean;

{ Enum Pages as Images routines }

procedure dxPSEnumReportPages(AComponentPrinter: TdxComponentPrinter;
  AReportLink: TBasedxReportLink; const APageIndexes: array of Integer;
  AGraphicClass: TGraphicClass; AnExportBackground: Boolean;
  ACallBackProc: TdxEnumPagesAsImagesProc; 
  ACallBackData: Pointer; 
  AProgressProc: TdxExportProgressEvent; 
  AProgressData: Pointer; 
  APrepareGraphicProc: TdxExportPrepareGraphicEvent; 
  APrepareData: Pointer);

{ ReportLinks registration routines }

procedure dxPSRegisterReportLink(ALinkClass: TdxReportLinkClass;
  AComponentClass: TComponentClass; ADesignerClass: TdxReportLinkDesignWindowClass);
procedure dxPSUnregisterReportLink(ALinkClass: TdxReportLinkClass;
  AComponentClass: TComponentClass; ADesignerClass: TdxReportLinkDesignWindowClass);
procedure dxPSUnregisterReportLinks(const ALinkClasses: array of TdxReportLinkClass);

function dxPSDesignerClassByCompClass(AComponentClass: TClass): TdxReportLinkDesignWindowClass; overload;
function dxPSDesignerClassByCompClass(AComponent: TObject{TComponent}): TdxReportLinkDesignWindowClass; overload;

function dxPSDesignerClassByLinkClass(ALinkClass: TClass): TdxReportLinkDesignWindowClass; overload;
function dxPSDesignerClassByLinkClass(ALink: TObject{TBasedxReportLink}): TdxReportLinkDesignWindowClass; overload;

function dxPSLinkClassByCompClass(AComponentClass: TClass): TdxReportLinkClass; overload;
function dxPSLinkClassByCompClass(AComponent: TObject{TComponent}): TdxReportLinkClass; overload;

procedure dxPSGetActiveReportLinksList(AClassList: TdxClassList);
procedure dxPSGetReportLinksList(AClassList: TdxClassList);
procedure dxPSGetLinkSupportedComponentsList(AClassList: TdxClassList; ALinkClass: TClass); overload;
procedure dxPSGetLinkSupportedComponentsList(AClassList: TdxClassList; ALink: TObject{TBasedxReportLink}); overload;
procedure dxPSGetSupportedComponentsList(AClassList: TdxClassList);

function dxPSIsSupportedCompClass(AComponentClass: TClass): Boolean; overload;
function dxPSIsSupportedCompClass(AComponent: TObject{TComponent}): Boolean; overload;

{ PreviewWindow registration routines }

function dxPSGetPreviewWindowClassByClassName(const AClassName: string): TdxPreviewWindowClass;
procedure dxPSGetPreviewWindowList(AStrings: TStrings);
procedure dxPSRegisterPreviewWindow(APreviewWindowClass: TdxPreviewWindowClass);
procedure dxPSUnregisterPreviewWindow(APreviewWindowClass: TdxPreviewWindowClass = nil);

{ Units convertation routines }

function OnePixel: Integer;
function PixelsNumerator: Integer;
function PixelsDenominator: Integer;

{ Helpers }

procedure FixupRect(DC: HDC; var R: TRect);
procedure Get3DBorderBrushes(AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean; 
  var AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH);
procedure Get3DBorderColors(AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean; 
  var AOuterTLColor, AOuterBRColor, AInnerTLColor, AInnerBRColor: TColor);

function dxPSExplorerImages: TCustomImageList;

procedure dxPSStartWait;
procedure dxPSStopWait;
  
const
  PSTO_DEFAULT_FORMAT = CXTO_AUTOINDENTS or CXTO_PATTERNEDTEXT;

  cemSingle = cemPattern; // obsolete: declared only for backward compatibility 
  cesNone = cesRaised;    // obsolete: declared only for backward compatibility 
  
  csAll = [csLeft..csBottom];
  csTopLeft = [csLeft, csTop];                   
  csBottomRight = [csRight, csBottom];
  csLeftRight = [csLeft, csRight];
  csTopBottom = [csTop, csBottom];

  tlpAll: TdxPSTreeLineParts = [tlpTop, tlpRight, tlpBottom];
  
  dxAlignment: array[TcxTextAlignX] of TAlignment = (taLeftJustify, taCenter, taRightJustify, taCenter, taCenter);
  dxCalcFormat: array[Boolean] of UINT = 
    (CXTO_CALCRECT or CXTO_AUTOINDENTS {or CXTO_EXPANDTABS} or CXTO_CHARBREAK or CXTO_SINGLELINE,
     CXTO_CALCRECT or CXTO_AUTOINDENTS or CXTO_EXPANDTABS or CXTO_CHARBREAK or CXTO_WORDBREAK);
    
  dxDrawTextTextAlignX: array[TcxTextAlignX] of UINT = (DT_LEFT, DT_CENTER, DT_RIGHT, DT_CENTER, DT_CENTER);
  dxDrawTextTextAlignY: array[TcxTextAlignY] of UINT = (DT_TOP, DT_VCENTER, DT_BOTTOM, DT_TOP);
    
  dxImageLayout: array[TAlignment] of TdxImageLayout = (ilImageCenterLeft, ilImageCenterRight, ilImageCenterCenter);
  dxMultilineTextAlignY: array[Boolean] of TcxTextAlignY = (taCenterY, taTop);
  dxTextAlignX: array[TAlignment] of TcxTextAlignX = (taLeft, taRight, taCenterX);
  dxTextAlignY: array[TTextLayout] of TcxTextAlignY = (taTop, taCenterY, taBottom);

  //TdxCellEdgeStyle = (cesRaised, cesSunken)
  dxCellBorderClassMap: array[TdxCellEdgeStyle, Boolean] of TdxPSCellBorderClass =
   ((TdxPSCellRaisedBorder, TdxPSCellRaisedSoftBorder), 
    (TdxPSCellSunkenBorder, TdxPSCellSunkenSoftBorder));
  dxDefaultCPOptions =
    [cpoAutoRebuildBeforePreview, cpoAutoRebuildBeforePrint, 
     cpoGenerateReportProgressEvent, cpoShowHourGlass, cpoDropStorageModeAfterPreview];
  dxDefaultPreviewEnableOptions =
    [peoCanChangeMargins, peoPageBackground, peoPageSetup, peoPreferences, 
     peoPrint, peoReportDesign];
  dxDefaultPreviewVisibleOptions =
    [pvoPageBackground, pvoPageSetup, pvoPreferences, pvoPrint, pvoReportDesign, 
     pvoPrintStyles, pvoReportFileOperations, pvoPageMargins];

  dxThumbnailsZoomFactors: array[TdxPSThumbnailsSize] of Integer = (5, 10);
  
  dxDefaultBkColor = clWhite;
  dxDefaultBreakByChars = True;
  dxDefaultCellSides = csAll;
  dxDefaultCheckFlatBorder = True;
  dxDefaultCheckPos = ccpCenter;
  dxDefaultColor = clWhite;
  dxDefaultContentColor = dxDefaultColor;
  dxDefaultCrossSignCrossSize = 9; // pixels
  dxDefaultEdgeMode = cemPattern;
  dxDefaultEdge3DSoft = True;
  dxDefaultEdge3DStyle = cesRaised;
  dxDefaultEndEllipsis = False;
  dxDefaultExpandButtonBorderColor = clBlack;
  dxDefaultFixedColor = clBtnFace; //clSilver;
  dxDefaultFixedTransparent = False;
  dxDefaultFont: array[0..LF_FACESIZE - 1] of Char = 'Times New Roman';
  dxDefaultGridLineColor = clBlack;
  dxDefaultGroupBorderColor = clBtnFace;
  dxDefaultGroupCaptionColor = clBtnFace;
  dxDefaultGroupCaptionSeparatorColor = clBtnFace;
  dxDefaultGroupColor = clBtnFace;
  dxDefaultHidePrefix = False;
  dxDefaultMultiline = False;
  dxDefaultShadowColor = clBlack; 
  dxDefaultShadowDepth = 3;
  dxDefaultSortOrder = csoNone;
  dxDefaultPreventLeftTextExceed = True;
  dxDefaultPreventTopTextExceed = True;
  dxDefaultReportGroupCaptionIndent = 5;
  dxDefaultReportGroupLookAndFeel: TdxPSReportGroupLookAndFeelClass = TdxPSReportGroupStandardLookAndFeel;
  dxDefaultTextAlignX = taLeft;
  dxDefaultTextAlignY = taCenterY;
  dxDefaultTransparent = True;
  dxDefaultTreeLineColor = clGray;

  dxPSDefaultFontCharSet = DEFAULT_CHARSET;
  dxPSDefaultFontColor = clBlack;
  dxPSDefaultFontName = 'Times New Roman';
  dxPSDefaultFontSize = 8;
  dxPSDefaultFontStyle = [];

  dxPSDefaultPreviewThumbnailsFontColor = clBlue;
  dxPSDefaultPreviewThumbnailsFontName = 'Tahoma';
  dxPSDefaultPreviewThumbnailsFontSize = 48;
  dxPSDefaultPreviewThumbnailsFontStyle = [];
  
  dxPSDefaultReportTitleFontColor = clBlack;
  dxPSDefaultReportTitleFontName = dxPSDefaultFontName;
  dxPSDefaultReportTitleFontSize = 14;
  dxPSDefaultReportTitleFontStyle = [fsBold];
    
  dxRadioGroupInterColumnsMinSpace = 1;
  dxRadioGroupInterRowsMinSpace = 1;
  dxRadioGroupBoundsIndent = 2;
  
  dxTextSpace = 2;

  dxPSReportFileLongExtension = 'ExpressPrinting System-Report'; //Don't Localize
  dxPSReportFileShortExtension = 'rps';                          //Don't Localize
 
  dxSortMarkRgnSize = 16;
  dxSortMarkWidth = 8;
  dxSortMarkHeight = 7;

  sdxDocumentCaptionSeparator = '-';

var  
  FUnitsPerInch: Integer = 4800;
  FDontPrintTransparentImages: Boolean = False; // affects only on Printout
// you need to disable the option below only if printing a file (such as Metafile, PDF, etc.) produces artifacts
  FUseIsotropicMode: Boolean = True;

  iiExplorerFolderCollapsed: Integer = -1;
  iiExplorerFolderExpanded: Integer = -1;
  iiExplorerItem: Integer = -1;
  iiExplorerItemHasInvalidData: Integer = -1;
  iiDriveTypes: array[TdxDriveType] of Integer = (-1, -1, -1, -1, -1, -1, -1);

implementation

uses
 {$IFDEF DELPHI7}
  Themes, 
  UxTheme, 
 {$ENDIF} 
 {$IFDEF DELPHI6}
  Variants, 
 {$ENDIF} 
 {$IFNDEF CBUILDER6}
  dxPSCPDsg, 
 {$ENDIF}
 {$IFDEF USEJPEGIMAGE}
  Jpeg,
 {$ENDIF}
  TypInfo, Registry, Consts, CommCtrl, Dialogs, ShlObj, ShellAPI, dxPSRes,
  dxPSImgs, dxPSUtl, dxPSEvnt, dxPSEdgePatterns, dxfmDTFmt, dxfmPNFmt, dxPSfmTtl, 
  dxfmChFN, dxPrnDev, dxPSPgsMnuBld, dxPSfmReportProperties, dxPSXplorerTreeView,   
  dxPSCompsProvider, dxPSfmCompositionDsg, dxPSPrVwStd;

function OffsetWindowOrgEx(DC: HDC; X, Y: Integer; Pt: PPoint): BOOL; stdcall; external gdi32 name 'OffsetWindowOrgEx';

const
  FExplorerImages: TCustomImageList = nil;

  // Image Indexes of Drive Types in ExplorerImages
  DriveTypeImageIndexMap: array[TdxDriveType] of Integer = (-1, -1, 7, 8, 9, 11, 12);

  // Page "Update Codes" that force us to Rebuild Report or Recalculate ViewInfos
  SignificantPrinterPageUpdateCodes: TdxPrinterPageUpdateCodes = [ucMarginLeft, ucMarginTop, ucMarginRight, ucMarginBottom, ucScale];

  MaxGlyphCount = 6;  // Max Glyph count used in TdxCustomReportCellCheckImage
  PtPerInch = 72;     // Typographic Point per Inch
  
  // Consts used in TCustomdxReportCellImageContainer to recognize Image kind saved in Stream
  imstImageList = 0; 
  imstShellLargeImageList = 1;
  imstShellSmallImageList = 2;
  imstImage = 3;

  // New ItemLink Name Template
  sdxNewLinkNameTemplate = 'Link%d';                        // Don't Localize
  
  // Const used to store/load various Report Data to/from Windows Registry or Stream(File)
  sdxNil = 'nil';                                           // Don't Localize
  sdxFilePort = 'FILE:';                                    // Don't Localize

  sdxAssignedDateFormat = 'OwnDateFormat';                  // Don't Localize
  sdxAssignedTimeFormat = 'OwnTimeFormat';                  // Don't Localize
  sdxAssignedPageNumberFormat = 'OwnPageNumberFormat';      // Don't Localize
  sdxAutoUpdateDateTime = 'AutoUpdateDateTime';             // Don't Localize
  sdxDateFormat = 'DateFormat';                             // Don't Localize
  sdxPageNumberFormat = 'PageNumberFormat';                 // Don't Localize
  sdxPrintDlgFilesRegistryPath = '\PrintDialogFiles';       // Don't Localize
  sdxStartPageIndex = 'StartPageIndex';                     // Don't Localize
  sdxTimeFormat = 'TimeFormat';                             // Don't Localize
  dxFormatTextAdjustFont = Integer($80000000);

var
  FPixelsDenominator: Integer;
  FPixelsNumerator: Integer;

  FSaveCursor: TCursor;
  FWaitCounter: Integer = 0;

type  
 {$IFDEF DELPHI7}
  TCustomPanelAccess = class(TCustomPanel);
 {$ENDIF}

  TdxLinkList = class;
  
  TdxReportLinkRegItem = class
  private
    FLinkList: TdxLinkList;
  protected
    property LinkList: TdxLinkList read FLinkList;
  public
    ComponentClass: TComponentClass;
    DesignerClass: TdxReportLinkDesignWindowClass;
    LinkClass: TdxReportLinkClass;
    constructor Create(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass; 
      ADesignerClass: TdxReportLinkDesignWindowClass);
    destructor Destroy; override;

    function IsEqual(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass = nil;
      ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean;
    function IsLastLinkClass: Boolean;
  end;

  TdxLinkList = class({$IFDEF DELPHI5}TObjectList{$ELSE}TList{$ENDIF})
  private
    function GetItem(Index: Integer): TdxReportLinkRegItem;
  protected
    function GetLinkClassCount(ALinkClass: TdxReportLinkClass): Integer;
  public
    procedure Add(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass;
      ADesignerClass: TdxReportLinkDesignWindowClass);
   {$IFNDEF DELPHI5}
    procedure Clear; override;
    procedure Delete(Index: Integer);
   {$ENDIF} 
   
    function Find(out AnIndex: Integer; ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass = nil;
      ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean; overload;
    function Find(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass = nil;
      ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean; overload;
      
    function FindDesignerByLink(ALinkClass: TClass): TdxReportLinkDesignWindowClass; overload;
    function FindDesignerByLink(ALink: TObject{TBasedxReportLink}): TdxReportLinkDesignWindowClass; overload;
    
    function FindLinkByComponent(AComponentClass: TClass): TdxReportLinkClass; overload;
    function FindLinkByComponent(AComponent: TObject{TComponent}): TdxReportLinkClass; overload;
    
    procedure GetLinks(AClassList: TdxClassList; AnExcludeInactive: Boolean = True);  
    procedure GetSupportedComponents(AClassList: TdxClassList; ALinkClass: TClass = nil); overload;
    procedure GetSupportedComponents(AClassList: TdxClassList; ALink: TObject{TBasedxReportLink}); overload;

    procedure UnregisterLink(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass = nil; 
      ADesignerClass: TdxReportLinkDesignWindowClass = nil);
    procedure UnregisterLinks(const ALinkClasses: array of TdxReportLinkClass);
    
    property Items[Index: Integer]: TdxReportLinkRegItem read GetItem;
  end;
  
const
  FLinkList: TdxLinkList = nil;
  FPreviewWindowList: TdxClassList = nil;

type
  TdxPSExplorerTreeContainerFactory = class(TdxCustomClassFactory)
  private
    function GetActiveTreeContainerClass: TCustomdxPSExplorerTreeContainerClass;
  public
    class function Instance: TdxPSExplorerTreeContainerFactory; reintroduce; overload;
    property ActiveTreeContainerClass: TCustomdxPSExplorerTreeContainerClass read GetActiveTreeContainerClass;
  end;
  
  TdxPSExplorerTreeBuilderFactory = class(TdxCustomClassFactory)
  private
    // because of CLR :-(
    function GetActiveBuilderClass: TdxPSExplorerTreeBuilderClass;
  public
    class function Instance: TdxPSExplorerTreeBuilderFactory; reintroduce; overload;
    property ActiveBuilderClass: TdxPSExplorerTreeBuilderClass read GetActiveBuilderClass;
  end;

  TdxPSReaderFactory = class(TdxCustomClassFactory)
  private
    function GetActualReaderClass: TdxPSDataReaderClass;
    function GetReaderClass(Version: Integer): TdxPSDataReaderClass;
  public
    class function Instance: TdxPSReaderFactory; reintroduce; overload;
    
    property ActualReaderClass: TdxPSDataReaderClass read GetActualReaderClass;
    property ReaderClasses[Version: Integer]: TdxPSDataReaderClass read GetReaderClass; default;
  end;

  TdxPSWriterFactory = class(TdxCustomClassFactory)
  private
    function GetActualWriterClass: TdxPSDataWriterClass;
    function GetWriterClass(Version: Integer): TdxPSDataWriterClass;
  public
    class function Instance: TdxPSWriterFactory; reintroduce; overload;

    property ActualWriterClass: TdxPSDataWriterClass read GetActualWriterClass;
    property WriterClasses[Version: Integer]: TdxPSDataWriterClass read GetWriterClass; default;
  end;

{ TdxReportLinkRegItem }

constructor TdxReportLinkRegItem.Create(ALinkClass: TdxReportLinkClass;
  AComponentClass: TComponentClass; ADesignerClass: TdxReportLinkDesignWindowClass);
begin
  inherited Create;
  LinkClass := ALinkClass;
  ComponentClass := AComponentClass;
  DesignerClass := ADesignerClass;
  if GetClass(LinkClass.ClassName) = nil then
    RegisterClass(LinkClass);
end;

destructor TdxReportLinkRegItem.Destroy;
begin
  if IsLastLinkClass and (GetClass(LinkClass.ClassName) <> nil) then
    UnregisterClass(LinkClass);
  inherited;
end;

function TdxReportLinkRegItem.IsEqual(ALinkClass: TdxReportLinkClass; 
  AComponentClass: TComponentClass = nil; ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean; 
begin
  Result := (LinkClass = ALinkClass) and 
    ((ComponentClass = nil) or (ComponentClass = AComponentClass)) and 
    ((DesignerClass = nil) or (DesignerClass = ADesignerClass));
end;  

function TdxReportLinkRegItem.IsLastLinkClass: Boolean;
begin
  Result := LinkList.GetLinkClassCount(LinkClass) = 1;
end;

{ TdxLinkList }

procedure TdxLinkList.Add(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass; 
  ADesignerClass: TdxReportLinkDesignWindowClass);
var
  Item: TdxReportLinkRegItem;  
begin
  if not Find(ALinkClass, AComponentClass, ADesignerClass) then
  begin
    Item := TdxReportLinkRegItem.Create(ALinkClass, AComponentClass, ADesignerClass);
    Item.FLinkList := Self;
    Insert(0, Item);
  end;  
end;
  
{$IFNDEF DELPHI5}
procedure TdxLinkList.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do 
    Items[I].Free;
  inherited;
end;

procedure TdxLinkList.Delete(Index: Integer);
begin
  Items[Index].Free;
  inherited;
end;
{$ENDIF}

function TdxLinkList.Find(out AnIndex: Integer; ALinkClass: TdxReportLinkClass; 
  AComponentClass: TComponentClass = nil; ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean;
var
  I: Integer;
begin  
  AnIndex := -1;
  for I := 0 to FLinkList.Count - 1 do
    if Items[I].IsEqual(ALinkClass, AComponentClass, ADesignerClass) then 
    begin
      AnIndex := I;
      Break;
    end;  
  Result := AnIndex <> -1;
end;

function TdxLinkList.Find(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass = nil;
  ADesignerClass: TdxReportLinkDesignWindowClass = nil): Boolean;
var
  Index: Integer;
begin
  Result := Find(Index, ALinkClass, AComponentClass, ADesignerClass);
end;

function TdxLinkList.FindDesignerByLink(ALinkClass: TClass): TdxReportLinkDesignWindowClass;
var
  I: Integer;
  Item: TdxReportLinkRegItem; 
begin 
  if ALinkClass <> nil then 
    for I := 0 to Count - 1 do
    begin
      Item := Items[I];
      if Item.LinkClass = ALinkClass then
      begin
        Result := Item.DesignerClass;
        Exit;
      end;
    end;
  Result := nil;  
end;

function TdxLinkList.FindDesignerByLink(ALink: TObject{TBasedxReportLink}): TdxReportLinkDesignWindowClass;
begin
  if ALink <> nil then
    Result := FindDesignerByLink(ALink.ClassType)
  else
    Result := nil;
end;

function TdxLinkList.FindLinkByComponent(AComponentClass: TClass): TdxReportLinkClass;
var
  I: Integer;
  Item: TdxReportLinkRegItem;
begin    
  Result := nil; 
  if AComponentClass <> nil then
    for I := 0 to Count - 1 do
    begin
      Item := Items[I];
      if AComponentClass.InheritsFrom(Item.ComponentClass) then
      begin
        Result := Item.LinkClass;
        if AComponentClass = Item.ComponentClass then Exit;
      end;
    end;
end;

function TdxLinkList.FindLinkByComponent(AComponent: TObject{TComponent}): TdxReportLinkClass;
begin
  if AComponent <> nil then
    Result := FindLinkByComponent(AComponent.ClassType)
  else
    Result := nil;
end;

procedure TdxLinkList.GetLinks(AClassList: TdxClassList; AnExcludeInactive: Boolean = True);
var
  Buffer: TdxClassList;
  I: Integer;
  Item: TdxReportLinkRegItem;
  ComponentClass: TComponentClass;  
  LinkClass: TdxReportLinkClass;
begin
  Buffer := TdxClassList.Create;
  try
    for I := 0 to Count - 1 do
    begin
      Item := Items[I];
      ComponentClass := Item.ComponentClass;
      if not AnExcludeInactive or (ComponentClass = nil) or (Buffer.IndexOf(ComponentClass) = -1) then
      begin
        LinkClass := Item.LinkClass;
        if AClassList.IndexOf(LinkClass) = -1 then 
          AClassList.Add(LinkClass);
        if AnExcludeInactive and (ComponentClass <> nil) then
          Buffer.Add(ComponentClass);
      end;
    end;
  finally
    Buffer.Free;
  end;
end;
    
procedure TdxLinkList.GetSupportedComponents(AClassList: TdxClassList; ALinkClass: TClass = nil);
var
  I: Integer;
  Item: TdxReportLinkRegItem;
  ComponentClass: TComponentClass;
begin    
  for I := 0 to Count - 1 do
  begin
    Item := Items[I];
    if (ALinkClass = nil) or (Item.LinkClass = ALinkClass) then
    begin
      ComponentClass := Item.ComponentClass;
      if AClassList.IndexOf(ComponentClass) = -1 then
        AClassList.Add(ComponentClass);
    end;
  end;
end;

procedure TdxLinkList.GetSupportedComponents(AClassList: TdxClassList; ALink: TObject{TBasedxReportLink});
var
  LinkClass: TClass;
begin
  if ALink <> nil then
    LinkClass := ALink.ClassType
  else
    LinkClass := nil;
  GetSupportedComponents(AClassList, LinkClass);
end;

procedure TdxLinkList.UnregisterLink(ALinkClass: TdxReportLinkClass; 
  AComponentClass: TComponentClass = nil; ADesignerClass: TdxReportLinkDesignWindowClass = nil);
var
  Index: Integer;
begin
  if Find(Index, ALinkClass, AComponentClass, ADesignerClass) then
    Delete(Index);
end;

procedure TdxLinkList.UnregisterLinks(const ALinkClasses: array of TdxReportLinkClass);
var
  I: Integer;
begin
  for I := Low(ALinkClasses) to High(ALinkClasses) do
    UnregisterLink(ALinkClasses[I]);
end;

function TdxLinkList.GetLinkClassCount(ALinkClass: TdxReportLinkClass): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Items[I].LinkClass = ALinkClass then Inc(Result);
end;

function TdxLinkList.GetItem(Index: Integer): TdxReportLinkRegItem;
begin
  Result := inherited Items[Index] as TdxReportLinkRegItem;
end;

{ TdxPSExplorerTreeContainerFactory }

function dxPSExplorerTreeContainerFactory: TdxPSExplorerTreeContainerFactory;  
begin
  Result := TdxPSExplorerTreeContainerFactory.Instance;
end;

class function TdxPSExplorerTreeContainerFactory.Instance: TdxPSExplorerTreeContainerFactory;
begin
  Result := inherited Instance as TdxPSExplorerTreeContainerFactory;
end;

function TdxPSExplorerTreeContainerFactory.GetActiveTreeContainerClass: TCustomdxPSExplorerTreeContainerClass;
begin  
  Result := TCustomdxPSExplorerTreeContainerClass(Items[0]);
end;
          
{ TdxPSExplorerTreeBuilderFactory }

function dxPSExplorerTreeBuilderFactory: TdxPSExplorerTreeBuilderFactory;
begin
  Result := TdxPSExplorerTreeBuilderFactory.Instance;
end;

function dxPSExplorerTreeBuilderFactory_ActiveBuilderClass: TdxPSExplorerTreeBuilderClass;
begin
  Result := dxPSExplorerTreeBuilderFactory.ActiveBuilderClass;
end;

class function TdxPSExplorerTreeBuilderFactory.Instance: TdxPSExplorerTreeBuilderFactory;
begin
  Result := inherited Instance as TdxPSExplorerTreeBuilderFactory;
end;
  
 // because of CLR :-(  
function TdxPSExplorerTreeBuilderFactory.GetActiveBuilderClass: TdxPSExplorerTreeBuilderClass;
begin
  Result := TdxPSExplorerTreeBuilderClass(Items[Count - 1]);
end;

{ TdxPSReaderFactory }

function dxPSReaderFactory: TdxPSReaderFactory;
begin
  Result := TdxPSReaderFactory.Instance;
end;

class function TdxPSReaderFactory.Instance: TdxPSReaderFactory;
begin
  Result := inherited Instance as TdxPSReaderFactory
end;

function TdxPSReaderFactory.GetActualReaderClass: TdxPSDataReaderClass;
begin
  Result := ReaderClasses[dxPSGlbl.dxPSStorageVersion];
end;

function TdxPSReaderFactory.GetReaderClass(Version: Integer): TdxPSDataReaderClass;
var
  I: Integer;
begin
  for I := Count - 1 to 0 do
  begin
    Result := TdxPSDataReaderClass(Items[I]);
    if Result.SupportsStorageVersion(Version) then Exit;
  end;
  Result := nil;
end;

{ TdxPSWriterFactory }

function dxPSWriterFactory: TdxPSWriterFactory;
begin
  Result := TdxPSWriterFactory.Instance;
end;

class function TdxPSWriterFactory.Instance: TdxPSWriterFactory;
begin
  Result := inherited Instance as TdxPSWriterFactory;
end;

function TdxPSWriterFactory.GetActualWriterClass: TdxPSDataWriterClass;
begin
  Result := WriterClasses[dxPSGlbl.dxPSStorageVersion];
end;

function TdxPSWriterFactory.GetWriterClass(Version: Integer): TdxPSDataWriterClass;
var
  I: Integer;
begin
  for I := Count - 1 to 0 do
  begin
    Result := TdxPSDataWriterClass(Items[I]);
    if Result.SupportsStorageVersion(Version) then Exit;
  end;
  Result := nil;
end;
    
{ units convertation routines }

function OnePixel: Integer;
begin
  Result := FPixelsNumerator div FPixelsDenominator;
  if Result = 0 then Result := 1;
end;

function PixelsNumerator: Integer;
begin
  Result := FPixelsNumerator;
end;

function PixelsDenominator: Integer;
begin
  Result := FPixelsDenominator;
end;

{ Helpers }

procedure FixupRect(DC: HDC; var R: TRect);
begin
  if DC <> 0 then
  begin
    LPtoDP(DC, R, 2);               
    DPtoLP(DC, R, 2);
  end;  
end;

const
  InnerBorderBRColors: array[TdxCellEdgeStyle, Boolean] of Integer = 
    ((COLOR_BTNSHADOW, COLOR_BTNFACE), (COLOR_BTNSHADOW, COLOR_BTNFACE));
  InnerBorderTLColors: array[TdxCellEdgeStyle, Boolean] of Integer = 
    ((COLOR_BTNHIGHLIGHT, COLOR_BTNHIGHLIGHT), (COLOR_BTNSHADOW, COLOR_BTNFACE));
    
  OuterBorderBRColors: array[TdxCellEdgeStyle, Boolean] of Integer = 
    ((COLOR_WINDOWTEXT, COLOR_WINDOWTEXT), (COLOR_BTNHIGHLIGHT, COLOR_BTNHIGHLIGHT));
  OuterBorderTLColors: array[TdxCellEdgeStyle, Boolean] of Integer = 
    ((COLOR_WINDOWTEXT, COLOR_WINDOWTEXT), (COLOR_WINDOWTEXT, COLOR_WINDOWTEXT));

procedure Get3DBorderBrushes(AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean; 
  var AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH);
begin
  AOuterTLBrush := GetSysColorBrush(OuterBorderTLColors[AEdgeStyle, ASoft]);
  AOuterBRBrush := GetSysColorBrush(OuterBorderBRColors[AEdgeStyle, ASoft]);
  AInnerTLBrush := GetSysColorBrush(InnerBorderTLColors[AEdgeStyle, ASoft]);
  AInnerBRBrush := GetSysColorBrush(InnerBorderBRColors[AEdgeStyle, ASoft]);
end;

procedure Get3DBorderColors(AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean; 
  var AOuterTLColor, AOuterBRColor, AInnerTLColor, AInnerBRColor: TColor);
begin
  AOuterTLColor := GetSysColor(OuterBorderTLColors[AEdgeStyle, ASoft]);
  AOuterBRColor := GetSysColor(OuterBorderBRColors[AEdgeStyle, ASoft]);
  AInnerTLColor := GetSysColor(InnerBorderTLColors[AEdgeStyle, ASoft]);
  AInnerBRColor := GetSysColor(InnerBorderBRColors[AEdgeStyle, ASoft]);
end;

function dxPSExplorerImages: TCustomImageList;

  function AddShellIconByIndex(AnIndex: Integer): Integer;
  var
    Icon: TIcon;
  begin
    if AnIndex <> -1 then
    begin
      Icon := TIcon.Create;
      try
        dxPSUtl.ShellSmallImages.GetIcon(AnIndex, Icon);
        Result := FExplorerImages.AddIcon(Icon);    
      finally  
        Icon.Free;
      end
    end
    else
      Result := -1;  
  end;
                              
  function LoadIcon(AnExtraFlags: UINT): Integer;
  const
    Flags = SHGFI_USEFILEATTRIBUTES or SHGFI_ICON or SHGFI_SYSICONINDEX;
  var
    FileInfo: TSHFileInfo;
  begin
    FillChar(FileInfo, SizeOf(FileInfo), 0);
    FileInfo.dwAttributes := SFGAO_FOLDER;                              
    try
      SHGetFileInfo('', FILE_ATTRIBUTE_DIRECTORY, FileInfo, SizeOf(FileInfo), Flags or AnExtraFlags);
    finally
      DestroyIcon(FileInfo.hIcon);
    end;
    Result := AddShellIconByIndex(FileInfo.iIcon);
  end;  

  function LoadBitmap(const AResName: string): Integer;
  var
    Bitmap: TBitmap;
  begin
    Bitmap := TBitmap.Create;
    try
      Bitmap_LoadFromResourceName(Bitmap, AResName);
      FExplorerImages.AddMasked(Bitmap, clFuchsia);
      Result := FExplorerImages.Count - 1;
    finally
      Bitmap.Free;
    end;
  end;

var
  I: TdxDriveType;  
begin
  if FExplorerImages = nil then
  begin
    FExplorerImages := TImageList.Create(nil);
    FExplorerImages.Handle := ImageList_Duplicate(dxPSUtl.ShellSmallImages.Handle);
    FExplorerImages.Clear;

    iiExplorerFolderCollapsed := LoadIcon(0);
    iiExplorerFolderExpanded := LoadIcon(SHGFI_OPENICON);
    iiExplorerItem := LoadBitmap(IDB_DXPSEXPLORERITEM_SMALL);
    iiExplorerItemHasInvalidData := LoadBitmap(IDB_DXPSEXPLORERITEM_INVALID);

    for I := Low(TdxDriveType) to High(TdxDriveType) do
      //iiDriveTypes[I] := AddShellIconByIndex(DriveTypeImageIndexMap[I]);
  end;
  Result := FExplorerImages;
end;

procedure dxPSStartWait;
begin
  if FWaitCounter = 0 then
  begin
    FSaveCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
  end;
  Inc(FWaitCounter);  
end;

procedure dxPSStopWait;
begin
  if FWaitCounter <> 0 then
  begin
    Dec(FWaitCounter);
    if FWaitCounter = 0 then Screen.Cursor := FSaveCursor;
  end;    
end;

{ ReportLinks Registration and Utilities}

function dxPSIndexOfRegItem(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass;
  ADesignerClass: TdxReportLinkDesignWindowClass): Integer;
begin
  if FLinkList <> nil then 
    FLinkList.Find(Result, ALinkClass, AComponentClass, ADesignerClass)
  else
    Result := -1;
end;

procedure dxPSRegisterReportLink(ALinkClass: TdxReportLinkClass; AComponentClass: TComponentClass;
  ADesignerClass: TdxReportLinkDesignWindowClass);
begin
  if (ALinkClass = nil) or 
    ((AComponentClass <> nil) and (dxPSIndexOfRegItem(ALinkClass, AComponentClass, ADesignerClass) <> -1)) then
    Exit;

  if FLinkList = nil then 
    FLinkList := TdxLinkList.Create;
  FLinkList.Add(ALinkClass, AComponentClass, ADesignerClass);
end;

procedure dxPSUnregisterReportLink(ALinkClass: TdxReportLinkClass;
  AComponentClass: TComponentClass; ADesignerClass: TdxReportLinkDesignWindowClass);
begin
  if FLinkList <> nil then
    FLinkList.UnregisterLink(ALinkClass, AComponentClass, ADesignerClass);
end;

procedure dxPSUnregisterReportLinks(const ALinkClasses: array of TdxReportLinkClass);
begin
  if FLinkList <> nil then 
    FLinkList.UnregisterLinks(ALinkClasses);
end;

procedure dxPSUnregisterAllReportLinks;
begin
  if FLinkList <> nil then 
  begin
    FLinkList.Clear;
    FreeAndNil(FLinkList);
  end;  
end;

function dxPSDesignerClassByCompClass(AComponentClass: TClass): TdxReportLinkDesignWindowClass;
var
  LinkClass: TdxReportLinkClass;
begin
  LinkClass := dxPSLinkClassByCompClass(AComponentClass);
  Result := dxPSDesignerClassByLinkClass(LinkClass);
end;

function dxPSDesignerClassByCompClass(AComponent: TObject{TComponent}): TdxReportLinkDesignWindowClass;
begin
  if AComponent <> nil then
    Result := dxPSDesignerClassByCompClass(AComponent.ClassType)
  else
    Result := nil;
end;

function dxPSLinkClassByCompClass(AComponentClass: TClass): TdxReportLinkClass;
begin
  if FLinkList <> nil then
    Result := FLinkList.FindLinkByComponent(AComponentClass)
  else
    Result := nil;
end;

function dxPSLinkClassByCompClass(AComponent: TObject{TComponent}): TdxReportLinkClass;
begin
  if FLinkList <> nil then
    Result := FLinkList.FindLinkByComponent(AComponent)
  else
    Result := nil;
end;

function dxPSDesignerClassByLinkClass(ALinkClass: TClass): TdxReportLinkDesignWindowClass;
begin
  if FLinkList <> nil then
    Result := FLinkList.FindDesignerByLink(ALinkClass)
  else
    Result := nil;
end;
    
function dxPSDesignerClassByLinkClass(ALink: TObject{TBasedxReportLink}): TdxReportLinkDesignWindowClass;
begin
  if ALink <> nil then
    Result := FLinkList.FindDesignerByLink(ALink)
  else
    Result := nil;
end;

procedure dxPSGetActiveReportLinksList(AClassList: TdxClassList);
begin
  if FLinkList <> nil then
    FLinkList.GetLinks(AClassList, True);
end;

procedure dxPSGetReportLinksList(AClassList: TdxClassList);
begin
  if FLinkList <> nil then
    FLinkList.GetLinks(AClassList, False);
end;

procedure dxPSGetLinkSupportedComponentsList(AClassList: TdxClassList; ALinkClass: TClass);
begin
  if FLinkList <> nil then
    FLinkList.GetSupportedComponents(AClassList, ALinkClass);
end;

procedure dxPSGetLinkSupportedComponentsList(AClassList: TdxClassList; ALink: TObject{TBasedxReportLink});
begin
  if FLinkList <> nil then
    FLinkList.GetSupportedComponents(AClassList, ALink);
end;

procedure dxPSGetSupportedComponentsList(AClassList: TdxClassList);
begin
  if FLinkList <> nil then
    FLinkList.GetSupportedComponents(AClassList);
end;

function dxPSIsSupportedCompClass(AComponentClass: TClass): Boolean;
begin
  Result := dxPSLinkClassByCompClass(AComponentClass) <> nil;
end;

function dxPSIsSupportedCompClass(AComponent: TObject{TComponent}): Boolean; 
begin
  Result := dxPSLinkClassByCompClass(AComponent) <> nil;
end;

{ PreviewWindows Registration and Utilities}

function GetPreviewClass: TdxPreviewWindowClass;
begin
  Result := nil;
  if (FPreviewWindowList <> nil) and (FPreviewWindowList.Count <> 0) then
    Result := TdxPreviewWindowClass(FPreviewWindowList.Last);
end;

function dxPSIndexOfPreviewWindowClass(APreviewWindowClass: TdxPreviewWindowClass): Integer;
begin
  if FPreviewWindowList <> nil then
    for Result := 0 to FPreviewWindowList.Count - 1 do
      if TdxPreviewWindowClass(FPreviewWindowList[Result]) = APreviewWindowClass then
        Exit;
  Result := -1;      
end;

function dxPSGetPreviewWindowClassByClassName(const AClassName: string): TdxPreviewWindowClass;
var
  I: Integer;
begin
  if FPreviewWindowList <> nil then
    for I := 0 to FPreviewWindowList.Count - 1 do
    begin
      Result := TdxPreviewWindowClass(FPreviewWindowList[I]);
      if (Result <> nil) and Result.ClassNameIs(AClassName) then Exit;
    end;
  Result := nil;
end;

procedure dxPSGetPreviewWindowList(AStrings: TStrings);
var
  I: Integer;
  PreviewWindowClass: TdxPreviewWindowClass;
begin
  if FPreviewWindowList <> nil then
  begin
    AStrings.BeginUpdate;
    try
      for I := 0 to FPreviewWindowList.Count - 1 do
      begin
        PreviewWindowClass := TdxPreviewWindowClass(FPreviewWindowList[I]);
        if PreviewWindowClass <> nil then 
          AStrings.AddObject(PreviewWindowClass.ClassName, TObject(PreviewWindowClass));
      end;
    finally
      AStrings.EndUpdate;
    end;
  end;  
end;

procedure dxPSRegisterPreviewWindow(APreviewWindowClass: TdxPreviewWindowClass);
begin
  if FPreviewWindowList = nil then
    FPreviewWindowList := TdxClassList.Create;
  FPreviewWindowList.Add(APreviewWindowClass);
end;

procedure dxPSUnregisterPreviewWindow(APreviewWindowClass: TdxPreviewWindowClass = nil);
var
  Index: Integer;
begin
  if FPreviewWindowList <> nil then
  begin
    if APreviewWindowClass = nil then
      Index := FPreviewWindowList.Count - 1
    else
      Index := dxPSIndexOfPreviewWindowClass(APreviewWindowClass);

    if Index <> -1 then
    begin
      FPreviewWindowList.Delete(Index);
      if FPreviewWindowList.Count = 0 then FreeAndNil(FPreviewWindowList);
    end;
  end;     
end;

procedure dxPSUnregisterAllPreviewWindows;
begin
  while FPreviewWindowList <> nil do dxPSUnregisterPreviewWindow(nil);
end;

function dxPrintComponent(AComponent: TComponent;
  APrintPreview: Boolean = True; APrintDialog: Boolean = False;
  const AReportTitle: string = ''; const APrintTitle: string = ''): Boolean;
var
  ComponentPrinter: TdxComponentPrinter;
  ReportLink: TBasedxReportLink;
begin
  try
    ComponentPrinter := TdxComponentPrinter.Create(nil);
    try
      ComponentPrinter.PrintTitle := APrintTitle;
      ReportLink := ComponentPrinter.AddLink(AComponent);
      Result := ReportLink <> nil;
      if Result then
      try
        ReportLink.ReportTitleText := AReportTitle;
        if APrintPreview then
          ReportLink.Preview(True)
        else
        begin
          ReportLink.PrinterPage.InitFromPrintDevice;
          ReportLink.Print(APrintDialog, nil);
        end;
      finally
        ReportLink.Free;
      end
    finally
      ComponentPrinter.Free;
    end;
  except
    Result := False;
  end;
end;

type
  TdxPSRunTimeComponentsProvider = class(TAbstractdxPSComponentsProvider)
  public
    procedure GetComponents(AComponentPrinter: TdxComponentPrinter; AReportLink: TBasedxReportLink; 
      AComponents: TStrings; AnOptions: TdxPSGetComponentOptions); override;
  end;

procedure TdxPSRunTimeComponentsProvider.GetComponents(AComponentPrinter: TdxComponentPrinter;
  AReportLink: TBasedxReportLink; AComponents: TStrings; AnOptions: TdxPSGetComponentOptions);

  procedure ProcessComponent(AComponent: TComponent);
  var
    Caption: string;
    Description: string;
    Item: TdxComponentItem;
  begin
    Caption := AComponent.Name;
    Description := '';
    if (AComponentPrinter.FindLinkByComponent(AComponent) = nil) and 
      (((AReportLink = nil) and dxPSIsSupportedCompClass(AComponent)) or
       ((AReportLink <> nil) and AReportLink.Supports(AComponent))) and 
      AComponentPrinter.DoFilterComponent(AComponent, Caption, Description) then 
    begin
      Item := dxPSCreateComponentItem(AComponent, Caption, Description);
      AComponents.AddObject(Item.Caption, Item);
    end;  
  end;
  
var              
  Owner: TComponent;
  I: Integer;
begin
  if not AComponentPrinter.GetSupportedComponents(AComponents) then 
  begin
    //Item := dxPSCreateComponentItem(nil, 'Composition', '');
    //AComponents.AddObject(Item.Caption, Item);

    Owner := AComponentPrinter.Owner;
    if Owner <> nil then
    begin
      ProcessComponent(Owner);
      for I := 0 to Owner.ComponentCount - 1 do 
        ProcessComponent(Owner.Components[I]);
    end;     
  end;  
end;
  
{ EdxInvalidStorageVersion }

constructor EdxInvalidStorageVersion.Create(AVersion: UINT);
begin
  FVersion := AVersion;
  inherited CreateFmt(cxGetResourceString(@sdxInvalidStorageVersion), [Version]);
end;

{ TdxPSDataReader }

class procedure TdxPSDataReader.Register;
begin
  dxPSReaderFactory.Register(Self);
end;

class procedure TdxPSDataReader.Unregister;
begin
  dxPSReaderFactory.Unregister(Self);
end;

function TdxPSDataReader.ReadClass: TClass;
begin
  Result := GetClass(ReadString);
end;

function TdxPSDataReader.ReadCellBorderClass: TdxPSCellBorderClass;
begin
  Result := TdxPSCellBorderClass(ReadClass);
  if Result = nil then
    Result := TdxPSCellUltraFlatBorder;
end;

function TdxPSDataReader.ReadFillPatternClass: TdxPSFillPatternClass;
begin
  Result := TdxPSFillPatternClass(ReadClass);
  if Result = nil then
    Result := TdxPSSolidFillPattern;
end;  

function TdxPSDataReader.ReadFont(AFont: TFont): TFont;
begin
  Result := AFont;
  if Result = nil then Result := TFont.Create;

  with Result do
  begin
    Charset := TFontCharset(ReadInteger);
    Color := ReadInteger;
    Name := ReadString;
    Pitch := TFontPitch(ReadInteger);
    Size := ReadInteger;
    Style := TFontStyles(Byte(ReadInteger));
  end;
end;

function TdxPSDataReader.ReadGraphicClass: TGraphicClass;
begin
  Result := TGraphicClass(ReadClass);
end;

procedure TdxPSDataReader.ReadImage(AnImage: TGraphic);
var
  MemoryStream: TMemoryStream;
  HasMask: Boolean;
  Mask: TBitmap;
begin  
  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.Size := {$IFDEF DELPHI6} Self.ReadInt64 {$ELSE} Self.ReadInteger {$ENDIF};
    if MemoryStream.Size <> 0 then
    begin
      Self.Read(MemoryStream.Memory^, MemoryStream.Size);
      MemoryStream.Position := 0; 
      AnImage.LoadFromStream(MemoryStream);

      MemoryStream.Read(HasMask , SizeOf(HasMask));
      if HasMask then
      begin
        Mask := TBitmap.Create;
        try
          Mask.LoadFromStream(MemoryStream);
          TBitmap(AnImage).MaskHandle := Mask.ReleaseHandle;
        finally
          Mask.Free;
        end;
      end;
    end;  
  finally
    MemoryStream.Free;
  end;
end;

procedure TdxPSDataReader.ReadImageList(AnImageList: TCustomImageList);
var
  MemoryStream: TMemoryStream;
  Adapter: IStream;
begin  
  MemoryStream := TMemoryStream.Create;
  try
    MemoryStream.Size := {$IFDEF DELPHI6} Self.ReadInt64 {$ELSE} Self.ReadInteger {$ENDIF};
    if MemoryStream.Size <> 0 then
    begin
      Self.Read(MemoryStream.Memory^, MemoryStream.Size);
      MemoryStream.Position := 0;
      Adapter := TStreamAdapter.Create(MemoryStream);
      AnImageList.Handle := CommCtrl.ImageList_Read(Adapter);
    end;  
  finally
    MemoryStream.Free;
  end;  
end;

function TdxPSDataReader.ReadLinkClass: TdxReportLinkClass;
begin
  Result := TdxReportLinkClass(ReadClass);
end;

function TdxPSDataReader.ReadLookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
begin
  Result := TdxPSReportGroupLookAndFeelClass(ReadClass);
  if Result = nil then
    Result := TdxPSReportGroupNullLookAndFeel;
end;

function TdxPSDataReader.ReadPoint: TPoint;
begin
  Read(Result, SizeOf(Result));
end;

function TdxPSDataReader.ReadPSVersion: TdxPSVersion;
begin
  Read(Result, SizeOf(Result));
end;

function TdxPSDataReader.ReadRect: TRect;
begin
  Read(Result, SizeOf(Result));
end;

procedure TdxPSDataReader.SkipBytes(Count: {$IFDEF DELPHI6} Int64 {$ELSE} Integer {$ENDIF});
var
  Buffer: TBytes;
begin
  SetLength(Buffer, Count);
  Read(Buffer, Length(Buffer));
end;

class function TdxPSDataReader.SupportsStorageVersion(AVersion: Integer): Boolean;
begin
  Result := True;
end;

{ TdxPSDataWriter }

class procedure TdxPSDataWriter.Register;
begin
  dxPSWriterFactory.Register(Self);
end;

class procedure TdxPSDataWriter.Unregister;
begin
  dxPSWriterFactory.Unregister(Self);
end;

procedure TdxPSDataWriter.WriteClassName(AClass: TClass);
begin
  if AClass <> nil then
    WriteString(AClass.ClassName)
  else
    WriteString(sdxNil);  
end;

procedure TdxPSDataWriter.WriteClassName(AnObject: TObject);
begin
  if AnObject <> nil then 
    WriteClassName(AnObject.ClassType)
  else
    WriteString(sdxNil);  
end;

procedure TdxPSDataWriter.WriteFont(AFont: TFont);
begin
  with AFont do
  begin
    WriteInteger(Charset);
    WriteInteger(Color);
    WriteString(Name);
    WriteInteger(Integer(Pitch));
    WriteInteger(Size);
    WriteInteger(Integer(Byte(Style)));
  end;    
end;
  
procedure TdxPSDataWriter.WriteImage(AnImage: TGraphic);
var
  MemoryStream: TMemoryStream;
  HasMask: Boolean;
  Mask: TBitmap;
begin  
  MemoryStream:= TMemoryStream.Create;
  try
    AnImage.SaveToStream(MemoryStream);

    HasMask := (AnImage is TBitmap) and (TBitmap(AnImage).MaskHandle <> 0);
    MemoryStream.Write(HasMask, SizeOf(HasMask));
    if HasMask then
    begin
      Mask := TBitmap.Create;
      try
        Mask.Monochrome := True;
        Mask.Handle := TBitmap(AnImage).MaskHandle;
        Mask.SaveToStream(MemoryStream);
      finally
        Mask.Free;
      end;
    end;

    Self.WriteInteger(MemoryStream.Size);  
    Self.Write(MemoryStream.Memory^, MemoryStream.Size);
  finally
    MemoryStream.Free;
  end;
end;

procedure TdxPSDataWriter.WriteImageList(AnImageList: TCustomImageList);
var
  MemoryStream: TMemoryStream;
  Adapter: IStream;
begin  
  MemoryStream := TMemoryStream.Create;
  try
    Adapter := TStreamAdapter.Create(MemoryStream);
    CommCtrl.ImageList_Write(AnImageList.Handle, Adapter);

    Self.WriteInteger(MemoryStream.Size);
    Self.Write(MemoryStream.Memory^, MemoryStream.Size);
  finally
    MemoryStream.Free;
  end;
end;

procedure TdxPSDataWriter.WritePoint(const Pt: TPoint);
begin
  Write(Pt, SizeOf(Pt));
end;

procedure TdxPSDataWriter.WritePSVersion(const AVersion: TdxPSVersion);
begin
  Write(AVersion, SizeOf(AVersion));
end;

procedure TdxPSDataWriter.WriteRect(const R: TRect);
begin
  Write(R, SizeOf(R));
end;

class function TdxPSDataWriter.SupportsStorageVersion(AVersion: Integer): Boolean;
begin
  Result := True;
end;

{ TdxPageOverlayIndexes }

function TdxPageOverlayIndexes.Add(AValue: Integer): Integer;
begin
  Result := inherited Add(TObject(AValue));
end;

function TdxPageOverlayIndexes.GetItem(Index: Integer): Integer;
begin
  Result := Integer(inherited Items[Index]);
end;

procedure TdxPageOverlayIndexes.SetItem(Index, Value: Integer);
begin
  inherited Items[Index] := TObject(Value);
end;

{ TdxPSPageRenderInfo }

constructor TdxPSPageRenderInfo.Create(ARenderInfo: TdxPSReportRenderInfo; 
  APageIndex: Integer);
begin
  inherited Create;
  FPageIndex := APageIndex;
  FRenderInfo := ARenderInfo;
  FIndexPairs := TList.Create;
  FOverlays := TList.Create;
end;

destructor TdxPSPageRenderInfo.Destroy;
begin
  FreeAndNilOverlays;
  FreeAndNilIndexPairs;
  inherited;
end;

procedure TdxPSPageRenderInfo.Calculate;
begin
  CalculateBounds;
  CalculateOffsets;
  FIndexPairs.Count := CalculateIndexPairCount;
  CalculateIndexPairs;
  CalculateOverlayIndexes;
end;

function TdxPSPageRenderInfo.HasDetails: Boolean;
begin
  Result := not IsRectEmpty(DetailBounds);
end;

function TdxPSPageRenderInfo.HasFooter: Boolean;
begin
  Result := not IsRectEmpty(FooterBounds) and (RenderInfo.CanUseHFOnEveryPageMode or IsBottomPage);
end;

function TdxPSPageRenderInfo.HasHeader: Boolean;
begin
  Result := not IsRectEmpty(HeaderBounds) and (RenderInfo.CanUseHFOnEveryPageMode or IsTopPage);
end;

function TdxPSPageRenderInfo.HasTitle: Boolean;
begin
  Result := RenderInfo.IsDrawPageTitleOnPage(PageIndex);
end;

function TdxPSPageRenderInfo.AreRectsIntersected(const R1, R2: TRect): Boolean;
var
  R: TRect;
begin
  if R1.Top = R1.Bottom then
    Result := (R1.Top >= R2.Top) and (R1.Top <= R2.Bottom) // bear in mind that R.Top = R.Bottom
  else
    Result := Windows.IntersectRect(R, R1, R2);
end;

procedure TdxPSPageRenderInfo.CalculateBounds;
var
  H: Integer;
begin
  DetailBounds := RenderInfo.CalculatePageDetailBounds(ColIndex, RowIndex);

  ContentBounds := DetailBounds;
  Inc(ContentBounds.Bottom, HeaderBounds.Bottom - HeaderBounds.Top);
  Inc(ContentBounds.Bottom, FooterBounds.Bottom - FooterBounds.Top);

  H := MulDiv(RenderInfo.PaintSize.Y, 100, RenderInfo.ScaleFactor);
  if HasTitle then
    Dec(H, TitleHeight);

  with ContentBounds do 
    if Bottom - Top > H then
      Bottom := Top + H;
end;
                                   
function TdxPSPageRenderInfo.CalculateIndexPairCount: Integer;
var
  EndIndex, TopSide, StartIndex: Integer;
  R: TRect;
begin
  if (RenderInfo.EmptyPageCount > 0) or ReportLink.NeedCalcEmptyPages then
  begin
    EndIndex := {AStartIndex } -1;
    Result := 0;
    TopSide := DetailBounds.Top;
    while (TopSide < DetailBounds.Bottom) and (EndIndex < ReportCells.Count) do
    begin
      Inc(Result);
      StartIndex := EndIndex + 1;
      repeat
        R := ReportCells.Cells[StartIndex].AbsoluteRect;
        Inc(StartIndex);
      until (StartIndex = ReportCells.Count) or AreRectsIntersected(R, DetailBounds);
      Dec(StartIndex);
      
      EndIndex := StartIndex;
      repeat
        R := ReportCells.Cells[EndIndex].AbsoluteRect;
        Inc(EndIndex);
      until (EndIndex = ReportCells.Count) or not AreRectsIntersected(R, DetailBounds);
      Dec(EndIndex);
      if EndIndex <> ReportCells.Count - 1 then
        Dec(EndIndex);
      if EndIndex < StartIndex then
        EndIndex := StartIndex;

      TopSide := R.Bottom;
    end;
  end
  else
    Result := 1;  
end;

procedure TdxPSPageRenderInfo.CalculateIndexPairs;
var
  EndIndex, I, StartIndex: Integer;
  R: TRect;
  Intersected: Boolean;
begin
  if IndexPairCount <> 0 then
  begin
    EndIndex := {AStartIndex } -1;
    for I := 0 to IndexPairCount - 1 do
    begin
      StartIndex := EndIndex + 1;
      repeat
        R := ReportCells.Cells[StartIndex].AbsoluteRect;
        Inc(StartIndex);
      until (StartIndex = ReportCells.Count) or AreRectsIntersected(R, DetailBounds);
      Dec(StartIndex);
      EndIndex := StartIndex;
      // fix 2.1
      Intersected := True;
      while (EndIndex < ReportCells.Count) and Intersected do
      begin
        R := ReportCells.Cells[EndIndex].AbsoluteRect;        
        Intersected := AreRectsIntersected(R, DetailBounds);
        Inc(EndIndex);
      end;
      //Dec(EndIndex, 1 + Ord(EndIndex <> ReportCells.Count));
      Dec(EndIndex);
      if EndIndex <> ReportCells.Count - 1 then
        Dec(EndIndex);
      if EndIndex < StartIndex then
        EndIndex := StartIndex;

      IndexPairs[I].StartIndex := StartIndex;
      IndexPairs[I].EndIndex := EndIndex;
    end;
  end
  else
    DetailBounds := NullRect; //TODO: TdxPSPageRenderInfo.CalculateIndexPairs
end;

function TdxPSPageRenderInfo.CalculateIsEmptyPage: Boolean;
begin
  Result := not RenderInfo.IsNonEmptyPage(DetailBounds);
end;

procedure TdxPSPageRenderInfo.CalculateOffsets;
var
  FullRect: TRect;
  MarginsOffset: TPoint;
  DataSize, PaintSize: Integer;
begin
  FullRect := ContentBounds;
  OffsetRect(FullRect, -FullRect.Left, -FullRect.Top);
  FullRect := ScaleRect(FullRect, RenderInfo.ScaleFactor, 100, RenderInfo.ScaleFactor, 100);

  MarginsOffset := PrinterPage.MarginsLoMetric.TopLeft;

  // horz.
  DataOffset.X := RenderInfo.LoMetricValueToInternalUnits(MarginsOffset.X);
  if HasTitle then
    TitleOffset.X := DataOffset.X;
  if RenderInfo.PrinterPage.CenterOnPageH then
  begin
    DataSize := FullRect.Right - FullRect.Left;
    PaintSize := RenderInfo.PaintSize.X;
    if DataSize < RenderInfo.PaintSize.X then
      Inc(DataOffset.X, MulDiv((PaintSize - DataSize) div 2, 100, RenderInfo.ScaleFactor));
  end;

  // vert.
  DataOffset.Y := RenderInfo.LoMetricValueToInternalUnits(MarginsOffset.Y);
  if HasTitle then
  begin
    TitleOffset.Y := DataOffset.Y;
    Inc(DataOffset.Y, RenderInfo.TitleHeight);
  end;
  if RenderInfo.PrinterPage.CenterOnPageV then
  begin
    DataSize := FullRect.Bottom - FullRect.Top;
    PaintSize := RenderInfo.PaintSize.Y;
    if HasTitle then
      Dec(PaintSize, RenderInfo.TitleBounds.Bottom - RenderInfo.TitleBounds.Top);
    if DataSize < PaintSize then
      Inc(DataOffset.Y, MulDiv((PaintSize - DataSize) div 2, 100, RenderInfo.ScaleFactor));
  end;
end;

procedure TdxPSPageRenderInfo.CalculateOverlayIndexes;

  function CreateOverlayIndexes(AnOverlay: TdxReportCell): TdxPageOverlayIndexes;
  var
    I: Integer;
    R: TRect;
  begin
    Result := TdxPageOverlayIndexes.Create;
    
    for I := 0 to AnOverlay.CellCount - 1 do
      if IntersectRect(R, AnOverlay[I].AbsoluteRect, DetailBounds) then 
        Result.Add(I);
  end;
  
var
  I: Integer;
begin
  if (ReportCells = nil) or not ReportCells.HasOverlays then Exit;
  
  FOverlays.Count := ReportCells.OverlayCount;
  for I := 0 to ReportCells.OverlayCount - 1 do
    FOverlays[I] := CreateOverlayIndexes(ReportCells.Overlays[I]);
end;

function TdxPSPageRenderInfo.GetColIndex: Integer;
begin
  Result := PageIndex mod RenderInfo.PageColCount;
end;

function TdxPSPageRenderInfo.GetFooterBounds: TRect;
begin
  Result := RenderInfo.FooterBounds;
end;

function TdxPSPageRenderInfo.GetHeaderBounds: TRect;
begin
  Result := RenderInfo.HeaderBounds;
end;

function TdxPSPageRenderInfo.GetIndexPair(Index: Integer): TdxContinuedIndexPair;
begin
  Result := TdxContinuedIndexPair(FIndexPairs[Index]);
  if Result = nil then
  begin
    Result := TdxContinuedIndexPair.Create;
    FIndexPairs[Index] := Result;  
  end;  
end;

function TdxPSPageRenderInfo.GetIndexPairCount: Integer;
begin
  Result := FIndexPairs.Count;
end;

function TdxPSPageRenderInfo.GetIsBottomPage: Boolean;
begin
  Result := PageIndex >= RenderInfo.PageRenderInfoCount - RenderInfo.PageColCount;
end;

function TdxPSPageRenderInfo.GetIsEmptyPage: Boolean;
begin
  if not FIsEmptyPageCalculated then
  begin
    FIsEmptyPageCalculated := True;
    FIsEmptyPage := CalculateIsEmptyPage;
  end;
  Result := FIsEmptyPage;   
end;

function TdxPSPageRenderInfo.GetIsTopPage: Boolean;
begin
  Result := PageIndex < RenderInfo.PageColCount;
end;

function TdxPSPageRenderInfo.GetOverlay(Index: Integer): TdxPageOverlayIndexes;
begin
  Result := TdxPageOverlayIndexes(FOverlays[Index]);
end;

function TdxPSPageRenderInfo.GetOverlayCount: Integer;
begin
  Result := FOverlays.Count;
end;

function TdxPSPageRenderInfo.GetPrinterPage: TdxPrinterPage;
begin
  Result := RenderInfo.PrinterPage;
end;

function TdxPSPageRenderInfo.GetReportCells: TdxReportCells;
begin
  Result := ReportLink.FReportCells;
end;

function TdxPSPageRenderInfo.GetReportLink: TBasedxReportLink;
begin
  Result := RenderInfo.ReportLink;
end;

function TdxPSPageRenderInfo.GetRowIndex: Integer;
begin
  Result := PageIndex div RenderInfo.PageColCount;
end;

function TdxPSPageRenderInfo.GetTitleBounds: TRect;
begin
  Result := RenderInfo.TitleBounds;
end;

function TdxPSPageRenderInfo.GetTitleHeight: Integer;
begin
  with TitleBounds do 
    Result := Bottom - Top;
end;

procedure TdxPSPageRenderInfo.SetIndexPair(Index: Integer; Value: TdxContinuedIndexPair);
begin
  FIndexPairs[Index] := Value;
end;

procedure TdxPSPageRenderInfo.FreeAndNilIndexPairs;
var
  I: Integer;
begin
  for I := 0 to IndexPairCount - 1 do
    IndexPairs[I].Free;
  FreeAndNil(FIndexPairs);
end;

procedure TdxPSPageRenderInfo.FreeAndNilOverlays;
var
  I: Integer;
begin
  for I := 0 to OverlayCount - 1 do
    Overlays[I].Free;
  FreeAndNil(FOverlays);
end;

{ TdxPSReportRenderInfo }

constructor TdxPSReportRenderInfo.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;
  FBaseContentFont := TFont.Create;
  FDelimitersX := TList.Create;
  FDelimitersY := TList.Create;
  FHardDelimitersY := TList.Create;
  FPageDelimitersX := TList.Create;
  FPageDelimitersY := TList.Create;
  FPageRenderInfos := TList.Create;
end;

destructor TdxPSReportRenderInfo.Destroy;
begin
  FreeAndNilPageRenderInfos;
  FreeAndNil(FBaseContentFont);
  FreeAndNil(FPageDelimitersY);
  FreeAndNil(FPageDelimitersX);
  FreeAndNil(FHardDelimitersY);
  FreeAndNil(FDelimitersY);
  FreeAndNil(FDelimitersX);
  inherited;
end;

procedure TdxPSReportRenderInfo.Calculate;
begin
  if not Locked then
  begin
    Lock;
    try
      Refresh;
      DoCalculate;
    finally
      Unlock;
    end;
  end;  
end;

function TdxPSReportRenderInfo.CanRenderPage(AVirtualPageIndex: Integer): Boolean;
begin
  Result := not (ReportLink.ShowEmptyPages and PageRenderInfos[AVirtualPageIndex].IsEmptyPage);
end;

function TdxPSReportRenderInfo.IsDrawPageFootNoteOnPage(APageIndex: Integer): Boolean;
begin
  Result := False;
 {case ReportLink.ReportTitleMode of
    fnmNone:
      Result := False;
    fnmOnLastPage:
      Result := APageIndex = PageCount - 1;
  else
    Result := APageIndex < PageCount - PageColCount;
  end;}
end;

function TdxPSReportRenderInfo.IsDrawPageTitleOnPage(APageIndex: Integer): Boolean;
begin
  case ReportLink.ReportTitleMode of
    tmNone:
      Result := False;
    tmOnFirstPage:
      Result := APageIndex = 0;
  else
    Result := APageIndex < PageColCount;
  end;
end;

procedure TdxPSReportRenderInfo.Lock;
begin
  Inc(FLockCounter);
end;

procedure TdxPSReportRenderInfo.Unlock;
begin
  if FLockCounter <> 0 then Dec(FLockCounter);
end;

function TdxPSReportRenderInfo.CalculateEmptyPageCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to PageRenderInfoCount - 1 do
    if PageRenderInfos[I].IsEmptyPage then Inc(Result);
end;

procedure TdxPSReportRenderInfo.CalculateHeaderAndFooterBounds;
begin
  if ReportCells <> nil then
  begin
    if ReportLink.IsDrawFootersOnEveryPage or (ReportLink.DataSource = rldsExternalStorage) then 
      FooterBounds := ReportCells.FooterBoundsRect;
    if ReportLink.IsDrawHeadersOnEveryPage or (ReportLink.DataSource = rldsExternalStorage) then 
      HeaderBounds := ReportCells.HeaderBoundsRect;
  end;
end;

function TdxPSReportRenderInfo.CalculatePageContentHeight(APageIndex: Integer): Integer;
var
  HeaderH, FooterH, TitleH: Integer;
begin
  Result := PaintSize.Y;
  
  HeaderH := MulDiv(HeaderHeight, ScaleFactor, 100);
  FooterH := MulDiv(FooterHeight, ScaleFactor, 100);
  TitleH := 0;
  if IsDrawPageTitleOnPage(APageIndex) then
    TitleH := MulDiv(TitleHeight, ScaleFactor, 100);
  if APageIndex = 0 then
    CanUseHFOnEveryPageMode := Result > HeaderH + FooterH + TitleH;

  if Result < HeaderH + FooterH + TitleH then
    FooterH := 0;
  if (Result < HeaderH + TitleH) and (APageIndex > FPageDelimitersX.Count - 1) then
    HeaderH := 0;

  Dec(Result, HeaderH + FooterH + TitleH);
//  if Result < 0 then Result := 0;
end;

function TdxPSReportRenderInfo.CalculatePageContentWidth(APageIndex: Integer): Integer;
begin
  Result := PaintSize.X;
end;

procedure TdxPSReportRenderInfo.CalculatePageCount;
begin
  VirtualPageCount := PageColCount * PageRowCount;
  FPageRenderInfos.Capacity := VirtualPageCount;
end;

procedure TdxPSReportRenderInfo.CalculatePageDelimiters;
var
  I, PageIndex, Offset, PageContentWidth, PagePaintHeight, CurDelimiter,
  Delimiter, HardDelimiterIndex: Integer;
begin
  // Horz.
  I := 0;
  PageIndex := 0;
  CurDelimiter := 0;       

  AddPageDelimiterX(0);
  while I < DelimiterXCount do
  begin
    PageContentWidth := CalculatePageContentWidth(PageIndex);
    Offset := PageDelimitersX[PageIndex];
    while (I < DelimiterXCount) and
      (MulDiv(DelimitersX[I] - Offset, ScaleFactor, 100) <= PageContentWidth) do
      Inc(I);
    if I < DelimiterXCount then
    begin
      Dec(I);
      CurDelimiter := DelimitersX[I];
      if Offset - CurDelimiter >= 0 then
        CurDelimiter := Offset + MulDiv(PageContentWidth, 100, ScaleFactor);
      AddPageDelimiterX(CurDelimiter);
      Inc(PageIndex);
    end;
  end;

  I := PageDelimitersX[PageDelimiterXCount - 1];
  if I <> ReportWidth then
  begin
    Inc(I, ReportWidth);
    if PageDelimiterXCount > 1 then Dec(I, CurDelimiter);
    AddPageDelimiterX(I);
  end;
  if PageDelimiterXCount = 1 then PageDelimiterXClear;

  // Vert.
  I := 0;
  PageIndex := 0;
  AddPageDelimiterY(0);
  while I < DelimiterYCount do
  begin
    PagePaintHeight := CalculatePageContentHeight(PageIndex);
    if PagePaintHeight <= 0 then
    begin
      AddPageDelimiterY(0);
      Inc(PageIndex);
      Continue;
    end;
    Offset := PageDelimitersY[PageIndex];
    HardDelimiterIndex := -1;
    while I < DelimiterYCount do
    begin
      Delimiter := DelimitersY[I];
      if MulDiv(Delimiter - Offset, ScaleFactor, 100) > PagePaintHeight then 
        Break;
      if IsHardDelimiter(Delimiter) then 
      begin
        HardDelimiterIndex := I;
        if BreakPagesByHardDelimiters then Break;
      end;    
      Inc(I);
    end;
    
    if I < DelimiterYCount then
    begin
      if HardDelimiterIndex <> -1 then 
        I := HardDelimiterIndex
      else  
        Dec(I);
      CurDelimiter := DelimitersY[I];
      if HardDelimiterIndex <> -1 then 
        Inc(I);
      if Offset - CurDelimiter >= 0 then
        CurDelimiter := Offset + MulDiv(PagePaintHeight, 100, ScaleFactor);
      AddPageDelimiterY(CurDelimiter);
      Inc(PageIndex);
    end;
  end;

  I := PageDelimitersY[PageDelimiterYCount - 1];
  if I <> ReportHeight then
  begin
    Inc(I, ReportHeight);
    if PageDelimiterYCount > 1 then Dec(I, CurDelimiter);
    AddPageDelimiterY(I);
  end;
  if PageDelimiterYCount = 1 then PageDelimiterYClear;
end;

function TdxPSReportRenderInfo.CalculatePageDetailBounds(APageCol, APageRow: Integer): TRect;
begin
  Result := MakeRect(PageDelimitersX[APageCol], PageDelimitersY[APageRow], 
                     PageDelimitersX[APageCol + 1], PageDelimitersY[APageRow + 1]);
end;

procedure TdxPSReportRenderInfo.CalculatePageHeaderAndFooterBounds;
begin
  if ReportLink.ShowPageHeader then
    PageHeaderBounds := LoMetricRectToInternalUnits(PrinterPage.HeaderRectLoMetric);
  if ReportLink.ShowPageFooter then
    PageFooterBounds := LoMetricRectToInternalUnits(PrinterPage.FooterRectLoMetric);
end;

procedure TdxPSReportRenderInfo.CalculatePageRenderInfos;
var
  I: Integer;
  PageRenderInfo: TdxPSPageRenderInfo;
begin
  for I := 0 to VirtualPageCount - 1 do
  begin
    PageRenderInfo := CreatePageRenderInfo(I);
    PageRenderInfo.Calculate;
  end;
end;

procedure TdxPSReportRenderInfo.CalculatePageRealAndVirtualIndexes(APageIndex: Integer;
  out AVirtualPageIndex, ARealPageIndex: Integer);
begin
  AVirtualPageIndex := RealPageIndexToVirtualPageIndex(APageIndex, False);
  ARealPageIndex := VirtualPageIndexToRealPageIndex(APageIndex);
end;

function TdxPSReportRenderInfo.CalculateTitleHeight: Integer;
const
  CalcFormat: UINT = DT_CALCRECT or DT_EDITCONTROL or DT_WORDBREAK;
var
  L, PrevFontHeight: Integer;
  DC: HDC;
  PrevFont: HFONT;
  R: TRect;
begin
  Result := 0;
  PrevFontHeight := TitleFont.Height;
  if TitleAdjustOnReportScale then
    TitleFont.Height := MulDiv(PrevFontHeight, ScaleFactor, 100);
  try
    L := Length(TitleText);
    if L <> 0 then
    begin
        DC := GetDC(0);
        try
          PrevFont := SelectObject(DC, TitleFont.Handle);
          R := PrinterPage.PaintRectPixels;
          OffsetRect(R, -R.Left, -R.Top);
          Result := 4 + Windows.DrawText(DC, PChar(TitleText), L, R, CalcFormat);
          SelectObject(DC, PrevFont);
        finally
          ReleaseDC(0, DC);
        end;
    end;
    ReportLink.DoMeasureReportLinkTitle(Result);
  finally
    if TitleAdjustOnReportScale then
      TitleFont.Height := PrevFontHeight
  end;
  R := PrinterPage.PaintRectPixels;
  L := (R.Bottom - R.Top) div 2;
  if Result > L then Result := L;
  if Result < 0 then Result := 0;
end;

procedure TdxPSReportRenderInfo.CalculateTitleBounds;
begin
  TitleBounds.Right := MulDiv(PaintSize.X, 100, ScaleFactor);
  TitleBounds.Bottom := MulDiv(CalculateTitleHeight,
    100 * PixelsNumerator, ScaleFactor * PixelsDenominator);
end;

procedure TdxPSReportRenderInfo.DoCalculate;
begin
  if ReportCells <> nil then
  begin
    BaseContentFont := ReportCells.Font;
    GridLinesColor := ReportCells.BorderColor;
  end;

  CalculateTitleBounds;
  CalculateHeaderAndFooterBounds;
  CalculatePageDelimiters;
  CalculatePageCount;
  CalculatePageHeaderAndFooterBounds;
  CalculatePageRenderInfos;
end;

function TdxPSReportRenderInfo.GetNonEmptyPageCount: Integer;
begin
  Result := VirtualPageCount - EmptyPageCount;
end;

function TdxPSReportRenderInfo.GetPageColCount: Integer;
begin
  Result := PageDelimiterXCount - 1;
  if Result < 0 then Result := 0;
  if (Result = 0) and (ReportCells <> nil) and (ReportCells.HeaderCellCount <> 0) and (ReportCells.FooterCellCount <> 0) then
    Result := 1;
end;

function TdxPSReportRenderInfo.GetPageRowCount: Integer;
begin
  Result := PageDelimiterYCount - 1;
  if Result < 0 then Result := 0;
  if (Result = 0) and (ReportCells <> nil) and (ReportCells.HeaderCellCount <> 0) and (ReportCells.FooterCellCount <> 0) then
    Result := 1;
end;

function TdxPSReportRenderInfo.GetPageSize: TPoint;
begin
  with PrinterPage.RealPageSizeLoMetric do
  begin
    Result.X := MulDiv(X, UnitsPerInch, 254);
    Result.Y := MulDiv(Y, UnitsPerInch, 254);
  end;
end;

function TdxPSReportRenderInfo.GetPaintSize: TPoint;
begin
  with PrinterPage.PaintRectLoMetric do 
  begin
    Result.X := MulDiv(Right - Left, UnitsPerInch, 254);
    Result.Y := MulDiv(Bottom - Top, UnitsPerInch, 254);
  end;
end;

function TdxPSReportRenderInfo.GetUnitsPerInch: Integer;
begin
  Result := FUnitsPerInch;
end;

function TdxPSReportRenderInfo.GetWindowScalePair: TdxWindowScalePair;
begin
  Result.Numerator := 100;
  Result.Denominator := ScaleFactor;
end;

procedure TdxPSReportRenderInfo.SetUnitsPerInch(Value: Integer);
begin
  FUnitsPerInch := Value;
end;

procedure TdxPSReportRenderInfo.ClearPageRenderInfos;
var
  I: Integer;
begin
  for I := 0 to PageRenderInfoCount - 1 do
    PageRenderInfos[I].Free;
  FPageRenderInfos.Clear;
end;

function TdxPSReportRenderInfo.CreatePageRenderInfo(APageIndex: Integer): TdxPSPageRenderInfo;
begin
  Result := GetPageRenderInfoClass.Create(Self, APageIndex);
  FPageRenderInfos.Add(Result);
end;

procedure TdxPSReportRenderInfo.FreeAndNilPageRenderInfos;
begin
  ClearPageRenderInfos;
  FreeAndNil(FPageRenderInfos);
end;

function TdxPSReportRenderInfo.GetPageRenderInfoClass: TdxPSPageRenderInfoClass;
begin
  Result := TdxPSPageRenderInfo;
end;

procedure TdxPSReportRenderInfo.Refresh;
begin
  ClearPageRenderInfos;
  FPageDelimitersX.Clear;
  FPageDelimitersY.Clear;

  CanUseHFOnEveryPageMode := True;

  //FIsTitleHeightCalculated := False;
  FEmptyPageCount := -1;
  VirtualPageCount := 0;

  FooterBounds := NullRect;
  HeaderBounds := NullRect;
  PageFooterBounds := NullRect;
  PageHeaderBounds := NullRect;
  TitleBounds := NullRect;
  FPixelsNumerator := Self.UnitsPerInch;
end;

function TdxPSReportRenderInfo.HasPageTitle(APageIndex: Integer): Boolean;
begin
  Result := not IsRectEmpty(TitleBounds) and IsDrawPageTitleOnPage(APageIndex);
end;

function TdxPSReportRenderInfo.IsHardDelimiter(AValue: Integer): Boolean;
begin
  Result := FHardDelimitersY.IndexOf(TObject(AValue)) <> -1;
end;

procedure TdxPSReportRenderInfo.ReadData(AReader: TdxPSDataReader);
begin
  ReadDelimiters(AReader);
end;

procedure TdxPSReportRenderInfo.ReadDelimiters(AReader: TdxPSDataReader);

  procedure ReadList(AList: TList);
  begin
    AList.Clear;
    AList.Count := AReader.ReadInteger;
    AReader.Read(AList.List^, AList.Count * SizeOf(Pointer));
  end;
  
begin
  ReadList(FDelimitersX);
  ReadList(FDelimitersY);
end;

procedure TdxPSReportRenderInfo.WriteData(AWriter: TdxPSDataWriter);
begin
  WriteDelimiters(AWriter);
end;

procedure TdxPSReportRenderInfo.WriteDelimiters(AWriter: TdxPSDataWriter);

  procedure WriteList(AList: TList);
  begin
    AWriter.WriteInteger(AList.Count);
    AWriter.Write(AList.List^, AList.Count * SizeOf(Pointer));
  end;
  
begin
  WriteList(FDelimitersX);
  WriteList(FDelimitersY);
end;

procedure TdxPSReportRenderInfo.AddPageDelimiterX(AValue: Integer);
begin
  FPageDelimitersX.Add(TObject(AValue));
end;

procedure TdxPSReportRenderInfo.AddPageDelimiterY(AValue: Integer);
begin
  FPageDelimitersY.Add(TObject(AValue));
end;

procedure TdxPSReportRenderInfo.PageDelimiterXClear;
begin
  FPageDelimitersX.Clear;
end;

procedure TdxPSReportRenderInfo.PageDelimiterYClear;
begin
  FPageDelimitersY.Clear;
end;

procedure TdxPSReportRenderInfo.AddStandardDelimiters;
begin
  DelimiterXList.Add(TObject(Integer(0)));
  DelimiterXList.Add(TObject(Integer(ReportWidth)));
  DelimiterYList.Add(TObject(Integer(0)));
  DelimiterYList.Add(TObject(Integer(ReportHeight)));
end;

function CompareProc(Item1, Item2:  Pointer ): Integer;
begin
  Result := Integer(Item1) - Integer(Item2);
end;

procedure TdxPSReportRenderInfo.EliminateDuplicatesAndSortDelimiters(AList: TList);
var
  Duplicates: TList;
  I: Integer;
  V: Pointer;
begin
  Duplicates := TList.Create;
  try
    for I := 0 to AList.Count - 1 do
    begin
      V := AList[I];
      if Duplicates.IndexOf(V) = -1 then Duplicates.Add(V);
    end;
    Duplicates.Sort(CompareProc);
    AList.Clear;
    AList.Count := Duplicates.Count;
    V := AList.List;
    Move(Duplicates.List^, V^, Duplicates.Count * SizeOf(Pointer));
  finally
    Duplicates.Free;
  end;
end;

procedure TdxPSReportRenderInfo.GetDelimiters;
begin
  DelimiterXList.Clear;
  DelimiterYList.Clear;
  HardDelimiterYList.Clear;
  
  if UseHorzDelimiters or UseVertDelimiters then 
  begin
    MakeDelimiters;
    if UseHardVertDelimiters then 
    begin
      MakeHardDelimiters;
      EliminateDuplicatesAndSortDelimiters(HardDelimiterYList);
      TrancateDelimiters(HardDelimiterYList, ReportLink.ReportHeight);
    end;
  end;

  AddStandardDelimiters;

  EliminateDuplicatesAndSortDelimiters(DelimiterXList);
  TrancateDelimiters(DelimiterXList, ReportLink.ReportWidth);
  EliminateDuplicatesAndSortDelimiters(DelimiterYList);
  TrancateDelimiters(DelimiterYList, ReportLink.ReportHeight);
end;

procedure TdxPSReportRenderInfo.MakeDelimiters;
begin
  ReportLink.MakeDelimiters(ReportCells, DelimiterXList, DelimiterYList);
end;

procedure TdxPSReportRenderInfo.MakeHardDelimiters;
begin
  ReportLink.MakeHardDelimiters(ReportCells, HardDelimiterYList);
end;

procedure TBasedxReportLink.PageParamsChanged(Sender: TdxPrinterPage;
  AStyle: TBasedxPrintStyle; AUpdateCodes: TdxPrinterPageUpdateCodes);
begin
  if (RealPrinterPage = Sender) and IsCurrentLink and 
    (SignificantPrinterPageUpdateCodes * AUpdateCodes <> []) then
  begin                              
    if Active then
      if GetRebuildOnPageParamsChange(AUpdateCodes) then 
        RebuildReport
      else
        CalculateRenderInfos;
    DoPageParamsChanged;
  end;
end;

function TBasedxReportLink.PossibleCustomDraw(AnItem: TAbstractdxReportCellData): Boolean;
begin
  Result := (DataSource = rldsComponent) and IsSupportedCustomDraw(AnItem);
end;

procedure TBasedxReportLink.PrepareReportGroupsLookAndFeels;
var
  DC: HDC;
begin
  if ReportCells <> nil then
  begin
    DC := GetDC(0);
    try
      ReportCells.PrepareReportGroupsLookAndFeels(DC);
    finally
      ReleaseDC(0, DC);
    end;
  end;
end;

procedure TdxPSReportRenderInfo.TrancateDelimiters(AList: TList; AValue: Integer);
var
  I: Integer;
begin
  I := AList.Count - 1;
  while (I > -1) and (Integer(AList[I]) > AValue) do 
  begin
    AList.Delete(I);
    Dec(I);
  end;
end;  

function TdxPSReportRenderInfo.LoMetricRectToInternalUnits(const R: TRect): TRect;
begin
  with Result do
  begin
    Left := LoMetricValueToInternalUnits(R.Left);
    Top := LoMetricValueToInternalUnits(R.Top);
    Right := LoMetricValueToInternalUnits(R.Right);
    Bottom := LoMetricValueToInternalUnits(R.Bottom);
  end;
end;

function TdxPSReportRenderInfo.LoMetricValueToInternalUnits(Value: Integer): Integer;
begin
  Result := MulDiv(Value, 100 * UnitsPerInch, 254 * ScaleFactor);
end;

function TdxPSReportRenderInfo.RealPageIndexToVirtualPageIndex(APageIndex: Integer;
  ATakeIntoAccountEmptyPages: Boolean): Integer;
var
  I: Integer;
begin
  Result := APageIndex;
  if (EmptyPageCount > 0) and (not ReportLink.ShowEmptyPages or ATakeIntoAccountEmptyPages) then
  begin
    I := 0;
    while (I < VirtualPageCount) and (I <> Result) do
    begin
      if PageRenderInfos[I].IsEmptyPage then Inc(Result);
      Inc(I);
    end;
    while (Result < VirtualPageCount) and PageRenderInfos[Result].IsEmptyPage do
      Inc(Result);
    if Result = VirtualPageCount then Dec(Result);
  end;
end;

function TdxPSReportRenderInfo.VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := APageIndex;
  if (EmptyPageCount = 0) or not ReportLink.ShowEmptyPages then 
    Exit;
  for I := 0 to APageIndex do
    if PageRenderInfos[I].IsEmptyPage then Dec(Result);
end;

function TdxPSReportRenderInfo.GetPrinterPage: TdxPrinterPage;
begin
  Result := ReportLink.RealPrinterPage;
end;

function TdxPSReportRenderInfo.GetReportCells: TdxReportCells;
begin
  Result := ReportLink.FReportCells;
end;

function TdxPSReportRenderInfo.GetReportHeight: Integer;
begin
  Result := ReportLink.ReportHeight;
end;

function TdxPSReportRenderInfo.GetReportWidth: Integer;
begin
  Result := ReportLink.ReportWidth;
end;

function TdxPSReportRenderInfo.GetScaleFactor: Integer;
begin
  Result := ReportLink.RealScaleFactor;
end;

function TdxPSReportRenderInfo.GetTitleAdjustOnReportScale: Boolean;
begin
  Result := ReportLink.ReportTitle.AdjustOnReportScale;
end;

function TdxPSReportRenderInfo.GetTitleFont: TFont;
begin
  Result := ReportLink.ReportTitle.Font;
end;

function TdxPSReportRenderInfo.GetTitleText: string;
begin
  Result := ReportLink.ReportTitleText;
end;

function TdxPSReportRenderInfo.GetBreakPagesByHardDelimiters: Boolean;
begin
  Result := UseHardVertDelimiters and ReportLink.BreakPagesByHardDelimiters;
end;

function TdxPSReportRenderInfo.GetDelimiterX(Index: Integer): Integer;
begin
  Result := Integer(FDelimitersX.List^[Index]);
end;

function TdxPSReportRenderInfo.GetDelimiterXCount: Integer;
begin
  Result := FDelimitersX.Count;
end;

function TdxPSReportRenderInfo.GetDelimiterY(Index: Integer): Integer;
begin
  Result := Integer(FDelimitersY.List^[Index]);
end;

function TdxPSReportRenderInfo.GetDelimiterYCount: Integer;
begin
  Result := FDelimitersY.Count;
end;

function TdxPSReportRenderInfo.GetEmptyPageCount: Integer;
begin
  if FEmptyPageCount = -1 then
    if ReportLink.NeedCalcEmptyPages then
      FEmptyPageCount := CalculateEmptyPageCount
    else  
      FEmptyPageCount := 0;
  Result := FEmptyPageCount;
end;

function TdxPSReportRenderInfo.GetFooterHeight: Integer;
begin
  with FooterBounds do 
    Result := Bottom - Top;
end;

function TdxPSReportRenderInfo.GetHeaderHeight: Integer;
begin
  with HeaderBounds do 
    Result := Bottom - Top;
end;

function TdxPSReportRenderInfo.GetLocked: Boolean;
begin
  Result := FLockCounter <> 0;
end;

function TdxPSReportRenderInfo.GetPageDelimiterX(Index: Integer): Integer;
begin
  Result := Integer(FPageDelimitersX.List^[Index]);
end;

function TdxPSReportRenderInfo.GetPageDelimiterXCount: Integer;
begin
  Result := FPageDelimitersX.Count;
end;

function TdxPSReportRenderInfo.GetPageDelimiterY(Index: Integer): Integer;
begin
  Result := Integer(FPageDelimitersY.List^[Index]);
end;

function TdxPSReportRenderInfo.GetPageDelimiterYCount: Integer;
begin
  Result := FPageDelimitersY.Count;
end;

function TdxPSReportRenderInfo.GetPageRenderInfo(Index: Integer): TdxPSPageRenderInfo;
begin
  Result := TdxPSPageRenderInfo(FPageRenderInfos[Index]);
end;

function TdxPSReportRenderInfo.GetPageRenderInfoCount: Integer;
begin
  Result := FPageRenderInfos.Count;
end;

function TdxPSReportRenderInfo.GetUseHardVertDelimiters: Boolean;
begin
  Result := ReportLink.UseHardVertDelimiters;
end;

function TdxPSReportRenderInfo.GetUseHorzDelimiters: Boolean;
begin
  Result := ReportLink.UseHorzDelimiters;
end;

function TdxPSReportRenderInfo.GetUseVertDelimiters: Boolean;
begin
  Result := ReportLink.UseVertDelimiters;
end;

function TdxPSReportRenderInfo.GetTitleHeight: Integer;
begin
  with TitleBounds do
    Result := Bottom - Top;
end;

procedure TdxPSReportRenderInfo.SetBaseContentFont(Value: TFont);
begin
  BaseContentFont.Assign(Value);
end;

function TdxPSReportRenderInfo.IsNonEmptyPage(const ABounds: TRect): Boolean;
var
  I: Integer;
  R: TRect;
begin
  Result := False;
  if ReportCells <> nil then
    for I := 0 to ReportCells.Count - 1 do 
    begin
      R := ReportCells.Cells[I].AbsoluteRect;
      Result := IntersectRect(R, R, ABounds);
      if Result then Exit;
    end;
end;

{ TdxPSCellBorderPainter }

constructor TdxPSCellBorderPainter.Create(ARenderer: TdxPSReportRenderer);
begin
  inherited Create;
  FRenderer := ARenderer;
end;

class procedure TdxPSCellBorderPainter.DrawFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
  ATLBrush, ABRBrush: HBRUSH; ALineThickness: Integer; AThickness: Integer = 1);
var
  I: Integer;
  Side: TdxCellSide;
  BorderBounds: TRect;
begin
  for I := 0 to AThickness - 1  do 
  begin
    for Side := csLeft to csBottom do
      if Side in ASides then
      begin
        BorderBounds := GetBorderBounds(R, Side, ALineThickness);
        if RectVisible(DC, BorderBounds) then         
          if Side in csTopLeft then
            Windows.FillRect(DC, BorderBounds, ATLBrush)
          else  
            Windows.FillRect(DC, BorderBounds, ABRBrush);        
      end;
      InflateRect(R, ASides, ALineThickness);
   end;   
end;

class procedure TdxPSCellBorderPainter.DrawShadow(DC: HDC; const R: TRect; 
  AShadowDepth: Integer; AShadowBrush, ARestSpaceBrush: HBRUSH); 
begin
  Windows.FillRect(DC, GetBottomShadowBounds(R, AShadowDepth), AShadowBrush);
  Windows.FillRect(DC, GetBottomShadowRestSpaceBounds(R, AShadowDepth), ARestSpaceBrush);
  Windows.FillRect(DC, GetRightShadowBounds(R, AShadowDepth), AShadowBrush);
  Windows.FillRect(DC, GetRightShadowRestSpaceBounds(R, AShadowDepth), ARestSpaceBrush);
end;

procedure TdxPSCellBorderPainter.Paint(DC: HDC);
var
  R: TRect;
begin
  with Item do 
  begin
    R := GetBorderOuterBounds(DC);
    DrawFrame(DC, R, CellSides, BorderBrush, BorderBrush, LineThickness, BorderClass.Thickness);
    if ShowShadow and (ShadowDepth <> 0) then
      DrawShadow(DC, R, ShadowDepth, ShadowBrush, ParentBrush);
  end;    
end;

function TdxPSCellBorderPainter.BorderClass: TdxPSCellBorderClass;
begin
  Result := Item.BorderClass;
end;

function TdxPSCellBorderPainter.Item: TdxReportVisualItem;
begin
  Result := FItem;
end;

function TdxPSCellBorderPainter.Renderer: TdxPSReportRenderer;
begin
  Result := FRenderer;
end;

class function TdxPSCellBorderPainter.GetBorderBounds(const R: TRect; 
  ASide: TdxCellSide; ALineThickness: Integer): TRect;
begin
  Result := R;
  with Result do 
    case ASide of
      csLeft: 
        Right := Left + ALineThickness;
      csTop: 
        Bottom := Top + ALineThickness;
      csRight: 
        Left := Right - ALineThickness;
      csBottom:
        Top := Bottom - ALineThickness;
    end;
end;

class function TdxPSCellBorderPainter.GetBottomShadowBounds(const R: TRect; 
  AShadowDepth: Integer): TRect;
begin
  with Result do
  begin
    Left := R.Left + AShadowDepth;
    Top := R.Bottom;
    Right := R.Right + AShadowDepth;
    Bottom := Top + AShadowDepth;
  end;
end;

class function TdxPSCellBorderPainter.GetBottomShadowRestSpaceBounds(const R: TRect; 
  AShadowDepth: Integer): TRect;
begin
  with Result do
  begin
    Left := R.Left;
    Top := R.Bottom;
    Right := Left + AShadowDepth;
    Bottom := Top + AShadowDepth;
  end;
end;

class function TdxPSCellBorderPainter.GetRightShadowBounds(const R: TRect; 
  AShadowDepth: Integer): TRect;
begin
  with Result do
  begin
    Left := R.Right;
    Top := R.Top + AShadowDepth;
    Right := Left + AShadowDepth;
    Bottom := Bottom;
  end;
end;

class function TdxPSCellBorderPainter.GetRightShadowRestSpaceBounds(const R: TRect; 
  AShadowDepth: Integer): TRect;
begin
  with Result do
  begin
    Left := R.Right;
    Top := R.Top;
    Right := Left + AShadowDepth;
    Bottom := Top + AShadowDepth;
  end;
end;

class procedure TdxPSCellBorderPainter.InflateRect(var R: TRect; ASides: TdxCellSides; 
  ALineThickness: Integer);
begin    
  if csLeft in ASides then Inc(R.Left, ALineThickness);
  if csTop in ASides then Inc(R.Top, ALineThickness);
  if csRight in ASides then Dec(R.Right, ALineThickness);
  if csBottom in ASides then Dec(R.Bottom, ALineThickness);
end;

function TdxPSCellBorderPainter.GetLineThickness: Integer;
begin
  Result := Renderer.LineThickness;
end;
       
{ TdxPSCustomCellBorder }

class procedure TdxPSCustomCellBorder.Register;
begin
  if GetClass(ClassName) = nil then RegisterClass(Self);
end;

class procedure TdxPSCustomCellBorder.Unregister;
begin
end;

class function TdxPSCustomCellBorder.Solid: Boolean;
begin
  Result := True;
end;

class function TdxPSCustomCellBorder.Thickness: Integer;
begin
  Result := 0;
end;

class function TdxPSCustomCellBorder.Edge3DSoft: Boolean;
begin
  Result := False;
end;

class function TdxPSCustomCellBorder.Edge3DStyle: TdxCellEdgeStyle;
begin
  Result := cesRaised;
end;

class function TdxPSCustomCellBorder.EdgeMode: TdxCellEdgeMode;
begin
  Result := cemPattern;
end;

class function TdxPSCustomCellBorder.GetBorderEdgeSalient(ASide: TdxCellSide; 
  ASalient: TdxPSCellBorderSalientType): Integer;
begin
  if ASalient = bstOuter then
    if ASide in csTopLeft then 
      Result := 1 + Thickness div 2
    else  
      Result := (Thickness - 1) div 2
  else
    if ASide in csTopLeft then 
      Result := (Thickness - 1) div 2
    else  
      Result := 1 + Thickness div 2
end;

class function TdxPSCustomCellBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := TdxPSCellBorderPainter;
end;

{ TdxPSCellNullBorderPainter }

procedure TdxPSCellNullBorderPainter.Paint(DC: HDC);
begin  
  with Item do 
    if ShowShadow and (ShadowDepth <> 0) then
      DrawShadow(DC, GetBorderOuterBounds(DC), ShadowDepth, ShadowBrush, ParentBrush);
end;

{ TdxPSNullCellEdge }

class function TdxPSCellNullBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := TdxPSCellNullBorderPainter;
end;

class function TdxPSCellNullBorder.Thickness: Integer;
begin 
  Result := 0;
end;
  
{ TdxPSCellFlatBorder }

class function TdxPSCellFlatBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := inherited GetPainterClass;//TdxPSCellFlatBorderPainter; //TODO:
end;
  
{ TdxPSCellBoldFlatBorder }

class function TdxPSCellBoldFlatBorder.Thickness: Integer;
begin
  Result := 2;
end;

{ TdxPSCellUltraFlatBorder }

class function TdxPSCellUltraFlatBorder.Thickness: Integer;
begin
  Result := 1;
end;
                  
{ TdxPSCell3DBorderPainter }

class procedure TdxPSCell3DBorderPainter.Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
  AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH; ALineThickness: Integer);
begin
  DrawFrame(DC, R, ASides, AOuterTLBrush, AOuterBRBrush, ALineThickness);
  InflateRect(R, ASides, ALineThickness);
  DrawFrame(DC, R, ASides, AInnerTLBrush, AInnerBRBrush, ALineThickness);
end;

class procedure TdxPSCell3DBorderPainter.Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
  ACellBorders: TdxPSCell3DBorderClass; ALineThickness: Integer);
begin
  with ACellBorders do 
    Draw3DFrame(DC, R, ASides, TopLeftOuterBrush, BottomRightOuterBrush, 
      TopLeftInnerBrush, BottomRightInnerBrush, ALineThickness);
end;
    
procedure TdxPSCell3DBorderPainter.Paint(DC: HDC);
var
  R: TRect;
begin
  with Item do 
  begin 
    R := GetBorderOuterBounds(DC);
    Draw3DFrame(DC, R, CellSides, Self.BorderClass, LineThickness);
    if ShowShadow and (ShadowDepth <> 0) then
      DrawShadow(DC, R, ShadowDepth, ShadowBrush, ParentBrush);
  end;  
end;

function TdxPSCell3DBorderPainter.BorderClass: TdxPSCell3DBorderClass;
begin
  Result := TdxPSCell3DBorderClass(inherited BorderClass);
end;

{ TdxPSCustomCell3DBorder }

class function TdxPSCustomCell3DBorder.Solid: Boolean;
begin
  Result := False;
end;

class function TdxPSCustomCell3DBorder.Thickness: Integer;
begin
  Result := 2;
end;

class function TdxPSCustomCell3DBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := NULL_BRUSH;
end;

class function TdxPSCustomCell3DBorder.BottomRightInnerColor: TColor;
begin
  Result := clNone;
end;

class function TdxPSCustomCell3DBorder.BottomRightOuterBrush: HBRUSH; 
begin
  Result := NULL_BRUSH;
end;

class function TdxPSCustomCell3DBorder.BottomRightOuterColor: TColor;
begin
  Result := clNone;
end;

class function TdxPSCustomCell3DBorder.TopLeftInnerBrush: HBRUSH; 
begin
  Result := NULL_BRUSH;
end;

class function TdxPSCustomCell3DBorder.TopLeftInnerColor: TColor;
begin
  Result := clNone;
end;

class function TdxPSCustomCell3DBorder.TopLeftOuterBrush: HBRUSH;
begin
  Result := NULL_BRUSH;
end;

class function TdxPSCustomCell3DBorder.TopLeftOuterColor: TColor;
begin
  Result := clNone;
end;

class function TdxPSCustomCell3DBorder.EdgeMode: TdxCellEdgeMode;
begin
  Result := cem3DEffects;
end;

class function TdxPSCustomCell3DBorder.GetBorderEdgeSalient(ASide: TdxCellSide; 
  ASalient: TdxPSCellBorderSalientType): Integer;
begin
  if ASalient = bstOuter then
    if ASide in csTopLeft then 
      Result := Thickness div 2
    else  
      Result := (Thickness - 1) div 2
  else
    if ASide in csTopLeft then 
      Result := (Thickness - 1) div 2
    else  
      Result := Thickness div 2
end;
  
class function TdxPSCustomCell3DBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := TdxPSCell3DBorderPainter;
end;

{ TdxPSCellRaisedBorder }

class function TdxPSCellRaisedBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNSHADOW);
end;

class function TdxPSCellRaisedBorder.BottomRightInnerColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TdxPSCellRaisedBorder.BottomRightOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellRaisedBorder.BottomRightOuterColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellRaisedBorder.TopLeftInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellRaisedBorder.TopLeftInnerColor: TColor;
begin 
  Result := clBtnHighlight;
end;

class function TdxPSCellRaisedBorder.TopLeftOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellRaisedBorder.TopLeftOuterColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellRaisedBorder.Edge3DSoft: Boolean;
begin
  Result := False;
end;

class function TdxPSCellRaisedBorder.Edge3DStyle: TdxCellEdgeStyle;
begin
  Result := cesRaised;
end;

{ TdxPSCellRaisedSoftBorder }

class function TdxPSCellRaisedSoftBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNFACE);
end;

class function TdxPSCellRaisedSoftBorder.BottomRightInnerColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSCellRaisedSoftBorder.Edge3DSoft: Boolean;
begin
  Result := True;
end;

{ TdxPSCellSunkenBorder }  
  
class function TdxPSCellSunkenBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNFACE);
end;

class function TdxPSCellSunkenBorder.BottomRightInnerColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSCellSunkenBorder.BottomRightOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellSunkenBorder.BottomRightOuterColor: TColor;
begin
  Result := clBtnHighlight;
end;

class function TdxPSCellSunkenBorder.TopLeftInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNSHADOW);
end;

class function TdxPSCellSunkenBorder.TopLeftInnerColor: TColor;
begin
  Result := clBtnShadow;
end;

class function TdxPSCellSunkenBorder.TopLeftOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellSunkenBorder.TopLeftOuterColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellSunkenBorder.Edge3DSoft: Boolean;
begin
  Result := False;
end;

class function TdxPSCellSunkenBorder.Edge3DStyle: TdxCellEdgeStyle;
begin
  Result := cesSunken;
end;
  
{ TdxPSCellSunkenSoftBorder }

class function TdxPSCellSunkenSoftBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNFACE);
end;

class function TdxPSCellSunkenSoftBorder.BottomRightInnerColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSCellSunkenSoftBorder.TopLeftInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNFACE);
end;

class function TdxPSCellSunkenSoftBorder.TopLeftInnerColor: TColor;
begin
  Result := clBtnFace;
end;

class function TdxPSCellSunkenSoftBorder.Edge3DSoft: Boolean;
begin
  Result := True;
end;

{ TdxPSCellEtchedBorderPainter }

class procedure TdxPSCellTwistedBorderPainter.Draw3DFrame(DC: HDC; R: TRect;
  ASides: TdxCellSides; ACellBorders: TdxPSCell3DBorderClass; ALineThickness: Integer);
begin
  inherited;
end;

class procedure TdxPSCellTwistedBorderPainter.Draw3DFrame(DC: HDC; R: TRect; ASides: TdxCellSides; 
  AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH; ALineThickness: Integer);
begin
  Inc(R.Left, ALineThickness);
  Inc(R.Top, ALineThickness);
  DrawFrame(DC, R, ASides, AInnerTLBrush, AInnerBRBrush, ALineThickness);
  Windows.OffsetRect(R, -ALineThickness, -ALineThickness);
  DrawFrame(DC, R, ASides, AOuterTLBrush, AOuterBRBrush, ALineThickness);
end;

{ TdxPSCellTwistedBorder }
                              
class function TdxPSCellTwistedBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := TdxPSCellTwistedBorderPainter;
end;

{ TdxPSCellEtchedBorder }

class function TdxPSCellEtchedBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellEtchedBorder.BottomRightInnerColor: TColor;
begin
  Result := clBtnHighLight;
end;

class function TdxPSCellEtchedBorder.BottomRightOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellEtchedBorder.BottomRightOuterColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellEtchedBorder.TopLeftInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellEtchedBorder.TopLeftInnerColor: TColor;
begin
  Result := clBtnHighLight;
end;

class function TdxPSCellEtchedBorder.TopLeftOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellEtchedBorder.TopLeftOuterColor: TColor;
begin
  Result := clWindowText;
end;

{ TdxPSCellBumpedBorder }

class function TdxPSCellBumpedBorder.BottomRightInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellBumpedBorder.BottomRightInnerColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellBumpedBorder.BottomRightOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellBumpedBorder.BottomRightOuterColor: TColor;
begin
  Result := clBtnHighLight;
end;

class function TdxPSCellBumpedBorder.TopLeftInnerBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_WINDOWTEXT);
end;

class function TdxPSCellBumpedBorder.TopLeftInnerColor: TColor;
begin
  Result := clWindowText;
end;

class function TdxPSCellBumpedBorder.TopLeftOuterBrush: HBRUSH;
begin
  Result := GetSysColorBrush(COLOR_BTNHIGHLIGHT);
end;

class function TdxPSCellBumpedBorder.TopLeftOuterColor: TColor;
begin
  Result := clBtnHighLight;
end;

{ TdxPSCellBorderPainter }

procedure TdxPSColorBorderPainter.Paint(DC: HDC);
var
  R: TRect;
  Side: TdxCellSide;
  BorderBounds: TRect;
begin
  with Item do
  begin
    R := GetBorderOuterBounds(DC);
//    SelectClipRgn(DC, 0);
    if RectVisible(DC, R) then
    begin
      for Side := csBottom downto csLeft do
        if Side in CellSides then
        begin
          BorderBounds := Self.GetBorderBounds(R, Side, Renderer.LineThickness);
          Windows.FillRect(DC, BorderBounds,
            Renderer.GetBrushByColor(SideColor[Side]));
        end;
    end;
  end;
end;

function TdxPSColorBorderPainter.GetSideColor(ASide: TdxCellSide): TColor;
begin
  Result := FItem.FCellSideColors[ASide];
end;

{ TdxPSColorBorder }

class function TdxPSColorBorder.GetPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := TdxPSColorBorderPainter;
end;

{ TdxPSBackgroundBitmapPool }

constructor TdxPSBackgroundBitmapPool.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TdxPSBackgroundBitmapPool.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited Destroy;
end;

procedure TdxPSBackgroundBitmapPool.Assign(Source: TdxPSBackgroundBitmapPool);
var
  I: Integer;
begin
  Clear;
  for I := 0 to Source.Count - 1 do
    Add(Source.Items[I]); 
end;

function TdxPSBackgroundBitmapPool.Add(ABitmap: TBitmap): Integer;
begin
  if not Find(ABitmap, Result) then Result := FItems.Add(ABitmap);
end;

procedure TdxPSBackgroundBitmapPool.Clear;
begin
  FItems.Clear;
end;

procedure TdxPSBackgroundBitmapPool.Delete(AnIndex: Integer);
begin
  FItems.Delete(AnIndex);
end;

function TdxPSBackgroundBitmapPool.Find(ABitmap: TBitmap; out AnIndex: Integer): Boolean;
var
  I: Integer;
begin
  AnIndex := -1;
  for I := 0 to Count - 1 do
    if dxPSUtl.dxAreGraphicsEqual(Items[I], ABitmap) then 
    begin
      AnIndex := I;
      Break;
    end;  
  Result := AnIndex <> -1;
end;

procedure TdxPSBackgroundBitmapPool.ReadData(AReader: TdxPSDataReader);
var
  Bitmap: TBitmap;
begin
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do
    begin
      Bitmap := TBitmap.Create;
      try
        AReader.ReadImage(Bitmap);
        Add(Bitmap);
      except
        Bitmap.Free;
        raise;
      end;  
    end;
  finally
    AReader.ReadListEnd;
  end;
end;

procedure TdxPSBackgroundBitmapPool.WriteData(AWriter: TdxPSDataWriter);
var
  I: Integer;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to Count - 1 do
      AWriter.WriteImage(Items[I]);
  finally
    AWriter.WriteListEnd;
  end;    
end;

function TdxPSBackgroundBitmapPool.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxPSBackgroundBitmapPool.GetItem(Index: Integer): TBitmap;
begin
  if Index <> -1 then
    Result := TBitmap(FItems[Index])
  else
    Result := nil;  
end;
    
{ TdxPSBrushPoolItem }

constructor TdxPSBrushPoolItem.Create(AColor: TColor);
begin
  inherited Create;
  FBrush := NULL_BRUSH;
  FColor := ColorToRGB(AColor);
end;

destructor TdxPSBrushPoolItem.Destroy;
begin
  if FBrush <> NULL_BRUSH then
  begin
    DeleteObject(FBrush);
    FBrush := NULL_BRUSH;
  end;  
  inherited;
end;

function TdxPSBrushPoolItem.GetBrush: HBRUSH;
begin
  if FBrush = NULL_BRUSH then
    FBrush := CreateSolidBrush(Color);
  Result := FBrush;  
end;
     
{ TdxPSReportBrushPool }

constructor TdxPSReportBrushPool.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TdxPSReportBrushPool.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

procedure TdxPSReportBrushPool.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Clear;  
end;

function TdxPSReportBrushPool.IndexOf(AColor: TColor): Integer;
begin
  AColor := ColorToRGB(AColor);
  for Result := 0 to Count - 1 do
    if Items[Result].Color = AColor then Exit;
  Result := -1;
end;

function TdxPSReportBrushPool.Add(AColor: TColor): Integer;
begin
  Result := Count;
  FItems.Add(TdxPSBrushPoolItem.Create(AColor));
end;

function TdxPSReportBrushPool.GetBrush(AColor: TColor): HBRUSH;
var
  Index: Integer;
begin
  Index := IndexOf(AColor);
  if Index = -1 then 
    Index := Add(AColor);
  Result := Items[Index].Brush;
end;

function TdxPSReportBrushPool.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxPSReportBrushPool.GetItem(Index: Integer): TdxPSBrushPoolItem;
begin
  Result := TdxPSBrushPoolItem(FItems[Index]);
end;
    
{ TdxPSFontPoolItem }

constructor TdxPSFontPoolItem.Create(AFont: TFont);
begin
  inherited Create;
  FFont := TFont.Create;
  Font := AFont;
  OriginalSize := Font.Size;
end;

destructor TdxPSFontPoolItem.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TdxPSFontPoolItem.SetFont(Value: TFont);
begin
  Font.Assign(Value);
end;

{ TdxPSReportFontPool }

constructor TdxPSReportFontPool.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

destructor TdxPSReportFontPool.Destroy;
begin
  Clear;
  FreeAndNil(FItems);
  inherited;
end;

function TdxPSReportFontPool.Add(AFont: TFont): Integer;
begin
  Result := IndexOf(AFont);
  if Result = -1 then 
    Result := CreateFont(AFont);
end;

procedure TdxPSReportFontPool.Clear;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do 
    Items[I].Free;
  FItems.Clear;
end;

function TdxPSReportFontPool.IndexOf(AFont: TFont): Integer;
begin
  for Result := 0 to Count - 1 do
    if dxAreFontsEqual(Fonts[Result], AFont) then Exit;
  Result := -1;
end;

function TdxPSReportFontPool.CreateFont(AFont: TFont): Integer;
var
  Item: TdxPSFontPoolItem;
begin
  Result := Count;
  Item :=  TdxPSFontPoolItem.Create(AFont);
  FItems.Add(Item);
  Item.Font.OnChange := FontChanged;
end;

procedure TdxPSReportFontPool.FontChanged(Sender: TObject);
begin
  if not FLocked then Add(TFont(Sender));
end;

procedure TdxPSReportFontPool.PrepareFonts(UPI: Integer);
var
  I: Integer;
begin
  FLocked := True;
  try
    for I := 0 to Count - 1 do
      with Items[I] do
        Font.Height := -MulDiv(OriginalSize, UPI, PtPerInch);
  finally
    FLocked := False;
  end;      
end;

procedure TdxPSReportFontPool.ReadData(AReader: TdxPSDataReader);
var
  Font: TFont;
begin
  Clear;
  Font := TFont.Create;
  try
    AReader.ReadListBegin;
    try
      while not AReader.EndOfList do
      begin
        AReader.ReadFont(Font);
        Font.Size := AReader.ReadInteger;
        Add(Font);
      end;  
    finally
      AReader.ReadListEnd;
    end;    
  finally
    Font.Free;
  end;  
end;

procedure TdxPSReportFontPool.WriteData(AWriter: TdxPSDataWriter);
var
  I: Integer;
  Item: TdxPSFontPoolItem;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to Count - 1 do
    begin 
      Item := Items[I];
      AWriter.WriteFont(Item.Font);
      AWriter.WriteInteger(Item.OriginalSize);
    end;  
  finally
    AWriter.WriteListEnd;
  end;    
end;

function TdxPSReportFontPool.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TdxPSReportFontPool.GetFont(Index: Integer): TFont;
begin
  Result := Items[Index].Font;
end;

function TdxPSReportFontPool.GetItem(Index: Integer): TdxPSFontPoolItem;
begin
  Result := TdxPSFontPoolItem(FItems[Index]);
end;

{  TdxPSCachedGraphicInfo }

constructor TdxPSCachedGraphicInfo.Create(ARenderer: TdxPSReportRenderer);
begin
  Renderer := ARenderer;
end;

function TdxPSCachedGraphicInfo.Check(
  ASourceGraphic: TGraphic; ABitmap: TBitmap; var APreparedGraphic: TGraphic): Boolean;
begin
  Result := ASourceGraphic <> nil;
  if Result then
  begin
    Result := (ASourceGraphic = SourceGraphic) and (UnitsPerInch = Renderer.UnitsPerInch) and
      (UnitsPerPixel = Renderer.UnitsPerPixel) and (ZoomFactor = Renderer.ZoomFactor) and
      (ABitmap.Width = ASourceGraphic.Width) and (ABitmap.Height = ASourceGraphic.Height);
    if Result then
      APreparedGraphic := PreparedGraphic
    else
    begin
      PreparedGraphic := APreparedGraphic;
      SourceGraphic := ASourceGraphic;
      SaveModeInfo;
    end;
    APreparedGraphic := ABitmap;
  end;
end;

procedure TdxPSCachedGraphicInfo.Clear;
begin
  SourceGraphic := nil;
  UnitsPerInch := 0;
  UnitsPerPixel := 0;
  ZoomFactor := 0;
end;

procedure TdxPSCachedGraphicInfo.SaveModeInfo;
begin
  UnitsPerInch := Renderer.UnitsPerInch;
  UnitsPerPixel := Renderer.UnitsPerPixel;
  ZoomFactor := Renderer.ZoomFactor;
end;

{ TdxPSReportRenderer }

constructor TdxPSReportRenderer.Create(AReportLink: TBasedxReportLink);

  function CreateBitmap: TBitmap;
  begin
    Result := TBitmap.Create;
    with Result do 
    try
      { Delphi4 bug ? - we have to assign image sizes manually at the first time of creating one }
      Height := 16;
      Width := 16;
      HandleType := bmDIB;
    except
      Result.Free;
      raise;
    end;  
  end;

  function CreateFont(const AName: string; ASize: Integer): TFont;
  begin
    Result := TFont.Create;
    Result.Name := AName;
    Result.Size := ASize;
    Result.Charset := SYMBOL_CHARSET;//DEFAULT_CHARSET;
    dxPSUtl.SetFontAsNonAntialiased(Result);
  end;
                               
begin
  inherited Create;
  FCachedGraphicInfo := TdxPSCachedGraphicInfo.Create(Self);
  FBorderPainters := TList.Create;
  FBrushPool := TdxPSReportBrushPool.Create;
  FReportLink := AReportLink;
  FCheckBitmap := CreateBitmap;
  FDrawBitmap := CreateBitmap;
  FDrawMask := CreateBitmap;
  FGroupLookAndFeelPainters := TList.Create;
  FHFStrings := TStringList.Create;
  FLineThickness := 1;
  FMarlettFont10 := CreateFont('Marlett', 10);
  FMarlettFont8 := CreateFont('Marlett', 8);
  FSymbolFont := CreateFont('Symbol', 7);
  FSaveFont := TFont.Create;
end;

destructor TdxPSReportRenderer.Destroy;
begin
  FreeAndNil(FSaveFont);
  FreeAndNil(FSymbolFont);
  FreeAndNil(FMarlettFont10);
  FreeAndNil(FMarlettFont8);
  FreeAndNil(FHFStrings);
  FreeAndNilReportGroupLookAndFeelPainters;
  FreeAndNil(FDrawMask);
  FreeAndNil(FDrawBitmap);
  FreeAndNil(FCheckBitmap);
  FreeAndNil(FBrushPool);
  FreeAndNil(FCachedGraphicInfo);
  FreeAndNilBorderPainters;
  inherited Destroy;
end;

function TdxPSReportRenderer.CustomDrawReportItem(AnItem: TAbstractdxReportCellData): Boolean;
var
  R: TRect;
  ARgn: HRGN;
begin
  Result := False;
  R := AnItem.GetOuterBounds(DC);
  ARgn := GetClipRgn;
  Windows.IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  ReportLink.CustomDraw(AnItem, Canvas, R, AnItem.BoundsRect, Result);
  RestoreClipRgn(ARgn);
end;

procedure TdxPSReportRenderer.Get3DBorderBrushes(AnItem: TdxReportVisualItem; 
  var AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush: HBRUSH);
begin
  dxPSCore.Get3DBorderBrushes(AnItem.Edge3DStyle, AnItem.Edge3DSoft, 
    AOuterTLBrush, AOuterBRBrush, AInnerTLBrush, AInnerBRBrush);
end;

procedure TdxPSReportRenderer.Get3DBorderColors(AnItem: TdxReportVisualItem;
  var AOuterTLColor, AOuterBRColor, AInnerTLColor, AInnerBRColor: TColor);
begin
  dxPSCore.Get3DBorderColors(AnItem.Edge3DStyle, AnItem.Edge3DSoft,
    AOuterTLColor, AOuterBRColor, AInnerTLColor, AInnerBRColor);
end;

procedure TdxPSReportRenderer.RenderPageTitleContent(const AText: string; ARect: TRect;
  ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY; AColor: TColor; AFont: TFont;
  ATransparent: Boolean);
const
  cFormat: DWORD = CXTO_AUTOINDENTS or CXTO_EXPANDTABS or CXTO_PATTERNEDTEXT or CXTO_CHARBREAK;
var
  PrevFontSize, UPI: Integer;
  Rgn: HRGN;
  Done: Boolean;
  Format: DWORD;
begin
  PrevFontSize := AFont.Size;
  UPI := UnitsPerInch;
  if not ReportLink.ReportTitle.AdjustOnReportScale then
     UPI := MulDiv(UPI, 100, ReportLink.RealScaleFactor);
  AFont.Size := MulDiv(PrevFontSize, UPI, Screen.PixelsPerInch); //PPI);

  Rgn := IntersectClipRect(ARect);
  try
    Done := False;
    if ReportLink.IsTitleCustomDrawn then
    begin
      PrepareCanvasForCustomDraw(AFont, AColor);
      ReportLink.DoCustomDrawPageTitle(Canvas, ARect, ATextAlignX, ATextAlignY, AColor, AFont, Done);
      SetBkMode(DC, Windows.TRANSPARENT);
    end;

    if not Done then
    begin
      if not ATransparent then
        FillRect(DC, ARect, AColor);
      Format := cFormat or MakeTextFormat(ATextAlignX, ATextAlignY, True, False, True, True, True);
      DrawTextEx(DC, ARect, 0, 0, 0, AText, AFont, Format);
    end;

    if ReportLink.IsTitleCustomDrawn then UnprepareCanvasForCustomDraw;
  finally
    RestoreClipRgn(Rgn);
  end;
  AFont.Size := PrevFontSize;
end;

function TdxPSReportRenderer.CalcTextHeight(DC: HDC; const AText: string; 
  AWordBreak: Boolean; AFont: TFont = nil; ABaseWidth: Integer = -1): Integer;
var
  R: TRect;  
begin
  if ABaseWidth = -1 then ABaseWidth := 5;
  R := MakeRect(0, 0, ABaseWidth, 5);
  Result := CalcTextRect(DC, AText, R, AWordBreak, AFont);
end;

function TdxPSReportRenderer.CalcTextLineCount(DC: HDC; const AText: string; 
  AFont: TFont = nil; ABaseWidth: Integer = -1): Integer;
var
  R: TRect;  
begin
  if AText <> '' then
  begin
    if ABaseWidth = -1 then 
      ABaseWidth := 2 * dxTextSpace + 1;
    R := MakeRect(0, 0, ABaseWidth, 5);
    Result := cxTextOut(DC, AText, R, dxCalcFormat[True] or CXTO_CALCROWCOUNT, AFont, 0, 0, 0);
  end
  else
    Result := 0
end;

function TdxPSReportRenderer.CalcTextPatternHeight(DC: HDC; AFont: TFont = nil): Integer;
begin
  Result := CalcTextHeight(DC, 'Wg', False, AFont, -1);
end;

function TdxPSReportRenderer.CalcTextRect(DC: HDC; const AText: string;
  var ARect: TRect; AWordBreak: Boolean; AFont: TFont = nil): Integer;
const
  CalcFormats: array[Boolean] of UINT =
    (CXTO_CALCROWCOUNT or CXTO_AUTOINDENTS or CXTO_CHARBREAK or CXTO_SINGLELINE,
     CXTO_CALCROWCOUNT or CXTO_AUTOINDENTS or CXTO_EXPANDTABS or CXTO_CHARBREAK or CXTO_WORDBREAK);
begin
  Result := CalcTextRect(DC, AText, ARect, CalcFormats[AWordBreak], AFont);
end;

function TdxPSReportRenderer.CalcTextRect(DC: HDC; const AText: string;
  var ARect: TRect; AFormat: DWORD; AFont: TFont = nil): Integer;
var
  ATextParams: TcxTextParams;
  ATextRows: TcxTextRows;
  AFontHandle: HFont;
  ALineCount: Integer;
begin
  if (AText <> '') and (AText[1] <> #0) then
  begin
    if AFont <> nil then
      AFontHandle := SelectObject(DC, AFont.Handle)
    else
      AFontHandle := 0;
    ARect.Bottom := MaxInt;
    InflateRect(ARect, -dxTextSpace * LineThickness, 0);
    ATextParams := cxCalcTextParams(DC, AFormat);
    cxResetTextRows(ATextRows);
    cxMakeTextRows(DC, PChar(AText), Length(AText), ARect, ATextParams, ATextRows, ALineCount);
    ARect.Bottom := ARect.Top + ALineCount * ATextParams.FullRowHeight +
      3 * LineThickness * dxTextSpace;
    cxResetTextRows(ATextRows);
    if AFontHandle <> 0 then
      SelectObject(DC, AFontHandle);
    Result := ARect.Bottom - ARect.Top;
  end
  else
    Result := 0;
end;

(*
// todo: old version
function TdxPSReportRenderer.CalcTextRect(DC: HDC; const AText: string;
  var ARect: TRect; AFormat: DWORD; AFont: TFont = nil): Integer;
begin
  if AText <> '' then
  begin
    cxTextOut(DC, AText, ARect, AFormat or DXTO_CALCRECT, AFont, 0, 0, 0);
    Result := ARect.Bottom - ARect.Top;
  end
  else
    Result := 0;
end;
*)

function TdxPSReportRenderer.CalcTextWidth(DC: HDC; const AText: string; 
  AFont: TFont = nil): Integer;    
var
  R: TRect;  
begin
  R := MakeRect(0, 0, 5 * LineThickness, 5 * LineThickness);
  cxTextOut(DC, AText, R, dxCalcFormat[False], AFont, 0, 0, 0);
  Result := R.Right - R.Left;
end;

procedure TdxPSReportRenderer.DrawCheckBox(DC: HDC; var R: TRect;
  AChecked, AEnabled, AIsRadio: Boolean; AEdgeStyle: TdxCheckButtonEdgeStyle; 
  ABorderColor: TColor = clWindowText);
const
  Enabled: array[Boolean] of UINT = (DFCS_BUTTON3STATE or DFCS_INACTIVE, 0);
  Checked: array[Boolean] of UINT = (0, DFCS_CHECKED);
  //FlatBorder: array[Boolean] of UINT = (0, DFCS_FLAT);
  Radio: array[Boolean] of UINT = (0, DFCS_BUTTONRADIO);
  InteriorIndexes: array[Boolean] of UINT = (CheckInteriorIndex, RadioInteriorIndex);
  MarkIndexes: array[Boolean] of UINT = (CheckMarkIndex, RadioBeanIndex);
  TopLeftArcInnerIndexes: array[Boolean] of UINT = (CheckTopLeftArcInnerIndex, RadioTopLeftArcInnerIndex);
  BottomRightArcInnerIndexes: array[Boolean] of UINT = (CheckBottomRightArcInnerIndex, RadioBottomRightArcInnerIndex);
  TopLeftArcOuterIndexes: array[Boolean] of UINT = (CheckTopLeftArcOuterIndex, RadioTopLeftArcOuterIndex);
  BottomRightArcOuterIndexes: array[Boolean] of UINT = (CheckBottomRightArcOuterIndex, RadioBottomRightArcOuterIndex);
var
  F: HFONT;
  C: TColor;
begin
  if AEdgeStyle <> cbes3D then
  begin
//  todo: commented for AB9777
//  if AIsRadio then OffsetRect(R, 0, LineThickness); 

    F := SelectObject(DC, MarlettFont10.Handle);
    C := GetTextColor(DC);

    if AEnabled then
      SetTextColor(DC, ColorToRGB(clWindow))
    else
      SetTextColor(DC, ColorToRGB(clBtnFace));
    dxPSUtl.DrawGlyph(DC, R, InteriorIndexes[AIsRadio]);
    //actually it's a mask, that means we should paint by halftone brush over here
    
    if AChecked then 
    begin
      SetTextColor(DC, ColorToRGB(clWindowText));
      dxPSUtl.DrawGlyph(DC, R, MarkIndexes[AIsRadio]);
    end;

    if AEdgeStyle <> cbesNone then
    begin 
      case AEdgeStyle of
        cbesSoft3D:
          SetTextColor(DC, ColorToRGB(clBtnFace));
        cbesSingle, 
        cbesBoldFlat:
          SetTextColor(DC, ColorToRGB(ABorderColor));
        cbesUltraFlat: 
          SetTextColor(DC, ColorToRGB(clWindowText));
      end;    

      dxPSUtl.DrawGlyph(DC, R, TopLeftArcInnerIndexes[AIsRadio]);
      dxPSUtl.DrawGlyph(DC, R, BottomRightArcInnerIndexes[AIsRadio]);

      if AEdgeStyle in [cbesSoft3D, cbesBoldFlat] then 
      begin
        if AEdgeStyle = cbesSoft3D then 
          SetTextColor(DC, ColorToRGB(clBtnShadow));
        dxPSUtl.DrawGlyph(DC, R, TopLeftArcOuterIndexes[AIsRadio]);
        if AEdgeStyle = cbesSoft3D then 
          SetTextColor(DC, ColorToRGB(clBtnHighlight));
        dxPSUtl.DrawGlyph(DC, R, BottomRightArcOuterIndexes[AIsRadio]);
      end;
    
      SelectObject(DC, F);
      SetTextColor(DC, C);    
    end;  
  end
  else
    DrawFrameControl(DC, R, DFC_BUTTON, DFCS_TRANSPARENT or Radio[AIsRadio] or Enabled[AEnabled] or Checked[AChecked]);
end;

procedure TdxPSReportRenderer.DrawEdge(DC: HDC; var R: TRect; AEdgeMode: TdxCellEdgeMode;
  AEdge3DEdge: TdxCellEdgeStyle; ASides: TdxCellSides; ASoft: Boolean; ABorderColor: TColor = -1);
var
  Brush: HBRUSH;
  CellBorders: TdxPSCell3DBorderClass;
begin
  case AEdgeMode of
    cemPattern: 
      begin
        if ABorderColor = -1 then ABorderColor := RenderInfo.GridLinesColor;
        Brush := GetBrushByColor(ABorderColor);
        TdxPSCellBorderPainter.DrawFrame(DC, R, ASides, Brush, Brush, LineThickness);
      end;  
    cem3DEffects:
      begin
        CellBorders := TdxPSCell3DBorderClass(TdxReportVisualItem.MapBorderClass(AEdgeMode, AEdge3DEdge, ASoft));
        TdxPSCell3DBorderPainter.Draw3DFrame(DC, R, ASides, CellBorders, LineThickness);
      end;  
  end;    
end;

procedure TdxPSReportRenderer.DrawEllipse(DC: HDC; R: TRect; 
  AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass; 
  ABorderColor: TColor; ABorderThickness: Integer = 1);
begin
  FrameEllipse(DC, R, ABorderColor, ABorderThickness);
  InflateRect(R, -ABorderThickness * LineThickness, -ABorderThickness * LineThickness);    
  FillEllipseEx(DC, R, AForeColor, ABackColor, APattern);  
end;

procedure TdxPSReportRenderer.DrawExpandButton(DC: HDC; var R: TRect; 
  AExpanded, ADrawBorder, AEdge3D, AEdge3DSoft, AShadow, AFillInterior: Boolean; 
  ABorderColor, AInteriorColor: TColor);
                     
  procedure DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
  var
    Ch: Char;
    Size: TSize;
    X, Y: Integer;
  begin
    Ch := Chr(AGlyph);
    GetTextExtentPoint32(DC, @Ch, 1, Size);
    with R do 
    begin
      X := Left + (Right - Left - Size.cX) div 2;
      Y := Top + (Bottom - Top - Size.cY) div 2;
    end;
    ExtTextOut(DC, X, Y, 0, @R, @Ch, 1, nil);
  end;

const
  InnerBottomRight3DColors: array[Boolean] of TColor = (clBtnShadow, clBtnFace);
  OuterFlatColors: array[Boolean] of TColor = (clWindowText, clBtnShadow);
  CrossHireIndexes: array[Boolean] of Byte = (dxPSUtl.PlusSignIndex, dxPSUtl.MinusSignIndex);
var
  F: HFONT;
  C: TColor;
begin
  SetBkMode(DC, TRANSPARENT);
  F := GetCurrentObject(DC, OBJ_FONT);
  C := GetTextColor(DC);

  SelectObject(DC, MarlettFont8.Handle); 
  if ADrawBorder then
  begin
    if AEdge3D then
    begin
      SetTextColor(DC, ColorToRGB(ABorderColor));
      DrawGlyph(DC, R, dxPSUtl.CheckTopLeftArcOuterIndex);
      DrawGlyph(DC, R, dxPSUtl.CheckBottomRightArcOuterIndex);
    end;
  
    if AFillInterior then 
    begin
      SetTextColor(DC, ColorToRGB(AInteriorColor));
      DrawGlyph(DC, R, dxPSUtl.CheckInteriorIndex);
    end;
  
    if not AEdge3D then
    begin
      SetTextColor(DC, ColorToRGB(ABorderColor));//OuterFlatColors[AEdge3DSoft]));
      DrawGlyph(DC, R, dxPSUtl.CheckTopLeftArcInnerIndex);
      DrawGlyph(DC, R, dxPSUtl.CheckBottomRightArcInnerIndex);
      if AShadow then 
      begin
        OffsetRect(R, LineThickness, LineThickness);
        SetTextColor(DC, ColorToRGB(clBtnShadow));
        DrawGlyph(DC, R, dxPSUtl.CheckBottomRightArcInnerIndex); 
        OffsetRect(R, -LineThickness, -LineThickness);
      end;  
    end
    else
    begin
      SetTextColor(DC, ColorToRGB(clBtnHighlight));
      DrawGlyph(DC, R, dxPSUtl.CheckTopLeftArcInnerIndex);
      SetTextColor(DC, ColorToRGB(InnerBottomRight3DColors[AEdge3DSoft]));
      DrawGlyph(DC, R, dxPSUtl.CheckBottomRightArcInnerIndex);
    end;
  end;
  
  // cross-hire
  SelectObject(DC, SymbolFont.Handle);
  SetTextColor(DC, ColorToRGB(clWindowText));
  OffsetRect(R, 0, -LineThickness);
  DrawGlyph(DC, R, CrossHireIndexes[AExpanded]);

  SetTextColor(DC, C);
  SelectObject(DC, F);
end;

procedure TdxPSReportRenderer.DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
begin
  dxPSUtl.DrawGlyph(DC, R, AGlyph);
end;

procedure TdxPSReportRenderer.DrawGraphic(DC: HDC; var R: TRect; const AClipRect: TRect;
  AImageList: TCustomImageList; AImageIndex: Integer; AGraphic: TGraphic; 
  AGraphicTransparent, ATransparent: Boolean; AColor: TColor);
begin
  DrawGraphicEx(DC, R, AClipRect, AImageList, AImageIndex, AGraphic,
    AGraphicTransparent, ATransparent, AColor, clWindow, TdxPSSolidFillPattern, cibAlways);
end;

procedure TdxPSReportRenderer.DrawGraphicEx(DC: HDC; R: TRect; const AClipRect: TRect;
  AImageList: TCustomImageList; AImageIndex: Integer; AGraphic: TGraphic;
  AGraphicTransparent, ATransparent: Boolean; AColor, ABkColor: TColor;
  APattern: TdxPSFillPatternClass; AnActualImageBuffering: TdxCellImageActualBuffering = cibAlways);

  procedure GetImage(ABitmap: TBitmap; AImageList: TCustomImageList;
    AImageIndex: Integer; AType: TImageType);

   {$IFNDEF DELPHI6}
    function GetColor(Value: TColor): DWORD;
    begin
      Result := ColorToRGB(Value);
      case Result of
        clNone: Result := CLR_NONE;
        clDefault: Result := CLR_DEFAULT;
      end;
    end;
   {$ENDIF}

  {$IFNDEF DELPHI6}
  const
    DrawingStyles: array[TDrawingStyle] of Longint =
      (ILD_FOCUS, ILD_SELECTED, ILD_NORMAL, ILD_TRANSPARENT);
    Images: array[TImageType] of Longint = (0, ILD_MASK);
  {$ENDIF}
  begin
    ABitmap.Handle := 0;
    ABitmap.Height := AImageList.Height;
    ABitmap.Width := AImageList.Width;
    ABitmap.Transparent := True;
  {$IFNDEF DELPHI6}
    with AImageList do
      if HandleAllocated then
        ImageList_DrawEx(Handle, AImageIndex, ABitmap.Canvas.Handle, 0, 0, 0, 0,
          GetColor(BkColor), GetColor(BlendColor),
          DrawingStyles[DrawingStyle] or Images[ImageType]);
  {$ELSE}
    AImageList.Draw(ABitmap.Canvas, 0, 0, AImageIndex, dsNormal, AType);
  {$ENDIF}
  end;

var
  Tmp: TBitmap;
  G: TGraphic;
  Rgn, Rgn2, RestRgn: HRGN;
  SaveTransparent: Boolean;
begin
  Rgn := 0;
  if (R.Right - R.Left > AClipRect.Right - AClipRect.Left) or
    (R.Bottom - R.Top > AClipRect.Bottom - AClipRect.Top) then
    Rgn := IntersectClipRect(AClipRect);

  if not ATransparent then
    if not AGraphicTransparent then
    begin
      RestRgn := CreateRectRgnIndirect(AClipRect);
      Rgn2 := CreateRectRgnIndirect(R);
      if CombineRgn(RestRgn, RestRgn, Rgn2, RGN_DIFF) > NULLREGION then
        FillRgnEx(DC, RestRgn, AColor, ABkColor, APattern);
      DeleteObject(Rgn2);
      DeleteObject(RestRgn);
    end
    else
      FillRectEx(DC, AClipRect, AColor, ABkColor, APattern);

    if AnActualImageBuffering = cibAlways then {v3.2}
    //if ReportLink.AlwaysBufferedGraphics then
    begin
      if AImageList <> nil then
      begin
        GetImage(FDrawBitmap, AImageList, AImageIndex, itImage);
  {!!!} FDrawBitmap.HandleType := bmDIB;
        GetImage(FDrawMask, AImageList, AImageIndex, itMask);
  {!!!} FDrawMask.HandleType := bmDIB;
        FDrawBitmap.MaskHandle := FDrawMask.Handle;
      end
      else
      begin
        if not CachedGraphicInfo.Check(AGraphic, FDrawBitmap, G) then
          with FDrawBitmap do
          begin
            Handle := 0;
            Width := AGraphic.Width;
            Height := AGraphic.Height;
            HandleType := bmDIB;
            //if AGraphic is TBitmap then
            //  MaskHandle := TBitmap(AGraphic).MaskHandle;
            Canvas.Draw(0, 0, AGraphic);
          end;
      end;
      G := FDrawBitmap;
    end
    else
      G := AGraphic;
      
  if (G <> nil) and not G.Empty then
  begin
    SaveTransparent := G.Transparent;
    G.Transparent := (not IsPrinting or not FDontPrintTransparentImages) and
      AGraphicTransparent and not (G is TIcon);

    if not IsRectEmpty(R) then
    begin
      if IsPrinting and (AImageList <> nil) then
      begin
        Tmp := TBitmap.Create;
        try
          Tmp.HandleType := bmDIB;	// !!!
          Tmp.Width := FDrawBitmap.Width;
          Tmp.Height := FDrawBitmap.Height;
          StretchBlt(Tmp.Canvas.Handle, 0, 0, Tmp.Width, Tmp.Height, FCanvas.Handle,
            R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, srcCopy);
          AImageList.Draw(Tmp.Canvas, 0, 0, AImageIndex{$IFDEF DELPHI6}, dsTransparent, itImage{$ENDIF});
          FCanvas.StretchDraw(R, Tmp);
        finally
          Tmp.Free;
        end;
      end
      else
      begin
        if G is TBitmap then // save mask handle - delphi bug SC - DB19634
          FDrawMask.Handle := TBitmap(G).MaskHandle;
        FCanvas.StretchDraw(R, G{FDrawBitmap});
      end;
    end;
    if AGraphicTransparent and not (G is TIcon) then
      G.Transparent := SaveTransparent;
  end;

  if Rgn <> 0 then RestoreClipRgn(Rgn);
  FDrawMask.Handle := 0;
  FDrawBitmap.MaskHandle := 0;
end;

procedure TdxPSReportRenderer.DrawRectangle(DC: HDC; R: TRect;
  AForeColor, ABackColor: TColor; AContentPattern: TdxPSFillPatternClass;
  ABorderColor: TColor; ABorderThickness: Integer = 1);
begin
  FrameRect(DC, R, ABorderColor, csAll, ABorderThickness);
  InflateRect(R, -ABorderThickness * LineThickness, -ABorderThickness * LineThickness);
  FillRectEx(DC, R, AForeColor, ABackColor, AContentPattern);
end;

procedure TdxPSReportRenderer.DrawRoundRect(DC: HDC; R: TRect;
  AnEllipseWidth, AnEllipseHeight: Integer; AForeColor, ABackColor: TColor;
  AContentPattern: TdxPSFillPatternClass; ABorderColor: TColor; 
  ABorderThickness: Integer = 1);
begin
  FrameRoundRect(DC, R, AnEllipseWidth, AnEllipseHeight, ABorderColor, ABorderThickness);

  AnEllipseHeight := 
    MulDiv(AnEllipseHeight, R.Bottom - R.Top - 2 * ABorderThickness * LineThickness, R.Bottom - R.Top);
  AnEllipseWidth := 
    MulDiv(AnEllipseWidth, R.Right - R.Left - 2 * ABorderThickness * LineThickness, R.Right - R.Left);
  InflateRect(R, -ABorderThickness * LineThickness, -ABorderThickness * LineThickness);    

  FillRoundRectEx(DC, R, AnEllipseWidth, AnEllipseHeight, AForeColor, ABackColor, AContentPattern);
end;

procedure TdxPSReportRenderer.DrawSortMark(DC: HDC; var R: TRect; 
  ASortOrder: TdxCellSortOrder; AMono: Boolean);
const
  GlyphIndexes: array[TdxCellSortOrder] of Byte = (0, SortUpMarkIndex, SortDownMarkIndex);
var
  F: HFONT;
  C: TColor;
  Ch: Char;
  Size: TSize;
begin
  if ASortOrder <> csoNone then 
  begin
    F := SelectObject(DC, MarlettFont10.Handle);
    C := SetTextColor(DC, ColorTORGB(clWindowText));
    Ch := Chr(GlyphIndexes[ASortOrder]);
    GetTextExtentPoint32(DC, @Ch, 1, Size);
    with R do 
      R := Bounds(Left + (Right - Left - Size.cX) div 2, Top + (Bottom - Top - Size.cY) div 2, Size.cX, Size.cY);
    dxPSUtl.DrawGlyph(DC, R, GlyphIndexes[ASortOrder]);
    SelectObject(DC, F);
    SetTextColor(DC, C);
  end;
end;

procedure TdxPSReportRenderer.DrawText(DC: HDC; var R: TRect; AMaxLineCount: Integer;
  ALeftIndent, ARightIndent: Integer; const AText: string; AFont: TFont; 
  ABkColor: TColor; ATextAlignX: TcxTextAlignX; ATextAlignY: TcxTextAlignY; 
  AFillBackground, AMultiline, AEndEllipsis: Boolean; APreventLeftTextExceed: Boolean = True; 
  APreventTopTextExceed: Boolean = True; AHidePrefix: Boolean = True);
var
  Format: DWORD;
begin
  if AFillBackground then FillRect(DC, R, ABkColor);
  Format := CXTO_AUTOINDENTS or CXTO_EXPANDTABS or CXTO_PATTERNEDTEXT or CXTO_CHARBREAK or
    MakeTextFormat(ATextAlignX, ATextAlignY, AMultiline, AEndEllipsis, 
    APreventLeftTextExceed, APreventTopTextExceed, AHidePrefix);

  DrawTextEx(DC, R, AMaxLineCount, ALeftIndent, ARightIndent, AText, AFont, Format);
end;  

procedure TdxPSReportRenderer.DrawTextEx(DC: HDC; var R: TRect; AMaxLineCount: Integer;
  ALeftIndent, ARightIndent: Integer; const AText: string; AFont: TFont; AFormat: DWORD);
begin
  cxTextOut(DC, AText, R, AFormat, AFont, AMaxLineCount,
    MulDiv(ALeftIndent, PPI, 96), MulDiv(ARightIndent, PPI, 96));
end;

function TdxPSReportRenderer.MakeTextFormat(ATextAlignX: TcxTextAlignX; 
  ATextAlignY: TcxTextAlignY; AMultiline, AEndEllipsis, APreventLeftTextExceed, 
  APreventTopTextExceed, AHidePrefix: Boolean): DWORD;
const
  dxEndEllipsis: array[Boolean] of UINT = (0, CXTO_END_ELLIPSIS);
  dxHidePrefix: array[Boolean] of UINT = (0, CXTO_HIDEPREFIX);
  dxPreventLeftExceed: array[Boolean] of UINT = (0, CXTO_PREVENT_LEFT_EXCEED);
  dxPreventTopExceed: array[Boolean] of UINT = (0, CXTO_PREVENT_TOP_EXCEED);
  dxWordBreak: array[Boolean] of UINT = (CXTO_SINGLELINE, CXTO_WORDBREAK);
begin
  Result := cxMakeFormat(ATextAlignX, ATextAlignY) or 
            dxEndEllipsis[AEndEllipsis] or 
            dxHidePrefix[AHidePrefix] or
            dxPreventLeftExceed[APreventLeftTextExceed] or 
            dxPreventTopExceed[APreventTopTextExceed] or 
            dxWordBreak[AMultiline];
end;

procedure TdxPSReportRenderer.FillEllipse(DC: HDC; const R: TRect; AColor: TColor);
begin
  FillEllipseEx(DC, R, AColor, clWhite, TdxPSSolidFillPattern);
end;

procedure TdxPSReportRenderer.FillEllipseEx(DC: HDC; const R: TRect; 
  AForeColor, ABackColor: TColor; APattern: TdxPSFillPatternClass);
var
  Pen: HPEN;
  Rgn: HRGN;
begin
  Pen := SelectObject(DC, GetStockObject(NULL_PEN));
  Rgn := CreateEllipticRgnIndirect(R);
  FillRgnEx(DC, Rgn, AForeColor, ABackColor, APattern);   
  DeleteObject(Rgn);
  SelectObject(DC, Pen);  
end;

procedure TdxPSReportRenderer.FillRect(DC: HDC; const R: TRect; AColor: TColor);
begin
  FillRectEx(DC, R, AColor, clWhite, TdxPSSolidFillPattern);
end;

procedure TdxPSReportRenderer.FillRectEx(DC: HDC; const R: TRect; AForeColor, ABackColor: TColor; 
  APattern: TdxPSFillPatternClass);
var
  BrushOrg: TPoint;
begin  
  if APattern = nil then Exit;
  
  GetBrushOrgEx(DC, BrushOrg);
  if APattern.RequiredBrushOrigin then 
  begin
    BrushOrg := R.TopLeft;
    Windows.LPToDP(DC, BrushOrg, 1);
    SetBrushOrgEx(DC, BrushOrg.X mod APattern.Dimensions.cX, BrushOrg.Y mod APattern.Dimensions.cY, @BrushOrg);
  end;

  if not APattern.Solid then 
  begin
    ABackColor := SetBkColor(DC, ColorToRGB(ABackColor));
    AForeColor := SetTextColor(DC, ColorToRGB(AForeColor));
  end;  
  
  Windows.FillRect(DC, R, GetPatternBrush(APattern, ColorToRGB(AForeColor)));
  
  if not APattern.Solid then   
  begin
    SetBkColor(DC, ABackColor);
    SetTextColor(DC, AForeColor);
  end;
  
  if APattern.RequiredBrushOrigin then 
    SetBrushOrgEx(DC, BrushOrg.X, BrushOrg.Y, nil);
end;

procedure TdxPSReportRenderer.FillRoundRect(DC: HDC; const R: TRect; 
  AnEllipseWidth, AnEllipseHeight: Integer; AColor: TColor);
begin
  FillRoundRectEx(DC, R, AnEllipseWidth, AnEllipseHeight, AColor, clWhite, TdxPSSolidFillPattern); 
end;

procedure TdxPSReportRenderer.FillRoundRectEx(DC: HDC; const R: TRect; 
  AnEllipseWidth, AnEllipseHeight: Integer; AForeColor, ABackColor: TColor; 
  APattern: TdxPSFillPatternClass);
var
  Pen: HPEN;
  Rgn: HRGN;
begin
  Pen := SelectObject(DC, GetStockObject(NULL_PEN));
  with R do   
    Rgn := CreateRoundRectRgn(Left, Top, Right, Bottom, AnEllipseWidth, AnEllipseHeight);
  FillRgnEx(DC, Rgn, AForeColor, ABackColor, APattern);   
  DeleteObject(Rgn);
  SelectObject(DC, Pen);  
end;

procedure TdxPSReportRenderer.FillRgn(DC: HDC; Rgn: HRGN; AColor: TColor);
begin
  FillRgnEx(DC, Rgn, AColor, clWhite, TdxPSSolidFillPattern);
end;

procedure TdxPSReportRenderer.FillRgnEx(DC: HDC; Rgn: HRGN; AForeColor, ABackColor: TColor; 
  APattern: TdxPSFillPatternClass);
var
  BrushOrg: TPoint;
  R: TRect;
begin
  if APattern = nil then Exit;
  
  GetBrushOrgEx(DC, BrushOrg);
  if APattern.RequiredBrushOrigin and (GetRgnBox(Rgn, R) <> NULLREGION) then 
  begin
    BrushOrg := R.TopLeft;
    Windows.LPToDP(DC, BrushOrg, 1);
    SetBrushOrgEx(DC, BrushOrg.X mod APattern.Dimensions.cX, BrushOrg.Y mod APattern.Dimensions.cY, @BrushOrg);
  end;  
  
  if not APattern.Solid then   
  begin
    AForeColor := SetTextColor(DC, ColorToRGB(AForeColor));
    ABackColor := SetBkColor(DC, ColorToRGB(ABackColor));
  end;
  
  Windows.FillRgn(DC, Rgn, GetPatternBrush(APattern, AForeColor));
    
  if not APattern.Solid then   
  begin
    SetBkColor(DC, ABackColor);
    SetTextColor(DC, AForeColor);
  end;

  if APattern.RequiredBrushOrigin then 
    SetBrushOrgEx(DC, BrushOrg.X, BrushOrg.Y, nil);      
end;

procedure TdxPSReportRenderer.FrameEllipse(DC: HDC; R: TRect; AColor: TColor;
  AThickness: Integer = 1);
var
  OuterRgn, InnerRgn:  HRGN;
begin
  OuterRgn := CreateEllipticRgnIndirect(R);
  InflateRect(R, -AThickness * LineThickness, -AThickness * LineThickness);  
  InnerRgn := CreateEllipticRgnIndirect(R);
  CombineRgn(OuterRgn, OuterRgn, InnerRgn, RGN_DIFF);
  FillRgn(DC, OuterRgn, AColor);
  DeleteObject(InnerRgn);
  DeleteObject(OuterRgn);
end;
  
procedure TdxPSReportRenderer.FrameRect(DC: HDC; R: TRect; AColor: TColor;
  ASides: TdxCellSides = [csLeft..csBottom]; AThickness: Integer = 1);
var
  Brush: HBRUSH;
  I: Integer;  
begin
  Brush := SelectObject(DC, GetPatternBrush(TdxPSSolidFillPattern, AColor));
  AColor := SetTextColor(DC, ColorToRGB(AColor));
  for I := 0 to AThickness - 1 do 
  begin
    with R do
    begin
      if csLeft in ASides then 
        PatBlt(DC, Left, Top, LineThickness, Bottom - Top, PATCOPY);
      if csTop in ASides then
        PatBlt(DC, Left, Top, Right - Left, LineThickness, PATCOPY);
      if csRight in ASides then
        PatBlt(DC, Right - LineThickness, Top, LineThickness, Bottom - Top, PATCOPY);
      if csBottom in ASides then
        PatBlt(DC, Left, Bottom - LineThickness, Right - Left, LineThickness, PATCOPY);

    end;                    
    InflateRect(R, -LineThickness, -LineThickness);
  end;
  SetTextColor(DC, AColor);  
  SelectObject(DC, Brush);
end;

procedure TdxPSReportRenderer.FrameRoundRect(DC: HDC; R: TRect; 
  AnEllipseWidth, AnEllipseHeight: Integer; AColor: TColor; 
  AThickness: Integer = 1);
var
  OuterRgn, InnerRgn:  HRGN;
begin
  with R do 
    OuterRgn := CreateRoundRectRgn(Left, Top, Right, Bottom, AnEllipseWidth, AnEllipseHeight);
  AnEllipseHeight := MulDiv(AnEllipseHeight, R.Bottom - R.Top - 2 * AThickness * LineThickness, R.Bottom - R.Top);
  AnEllipseWidth := MulDiv(AnEllipseWidth, R.Right - R.Left - 2 * AThickness * LineThickness, R.Right - R.Left);
  InflateRect(R, -AThickness * LineThickness, -AThickness * LineThickness);
  with R do 
    InnerRgn := CreateRoundRectRgn(Left, Top, Right, Bottom, AnEllipseWidth, AnEllipseHeight);  
  CombineRgn(OuterRgn, OuterRgn, InnerRgn, RGN_DIFF);
  FillRgn(DC, OuterRgn, AColor);
  DeleteObject(InnerRgn);
  DeleteObject(OuterRgn);
end;

function TdxPSReportRenderer.GetBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
begin
  Result := FindBorderPainter(AClass);
  if Result = nil then 
    Result := CreateBorderPainter(AClass);
end;

function TdxPSReportRenderer.GetBrushByColor(AColor: TColor): HBRUSH;
begin
  {if IsSysColor(AColor) then //TODO: GetSysColorBrush
    Result := GetSysColorBrush(AColor)
  else}
    if (AColor = clNone) or (AColor = clDefault) then
      Result := GetStockObject(NULL_BRUSH)  
    else  
      Result := BrushPool.Brushes[AColor];
end;

function TdxPSReportRenderer.GetPatternBrush(APattern: TdxPSFillPatternClass; AColor: TColor): HBRUSH;
begin
  if APattern.Solid then
    Result := BrushPool.Brushes[AColor]
  else
    Result := dxPSFillPatternFactory.Items[APattern, IsPrinting].Brush.Handle;
end;

function TdxPSReportRenderer.GetReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
begin
  Result := FindReportGroupLookAndFeelPainter(AClass);
  if Result = nil then 
    Result := CreateReportGroupLookAndFeelPainter(AClass);
end;

function TdxPSReportRenderer.ExcludeClipRect(const R: TRect): Integer;
begin
  with R do
    Result := Windows.ExcludeClipRect(DC, Left, Top, Right, Bottom);
end;

function TdxPSReportRenderer.GetClipRgn: HRGN;
begin
  Result := CreateRectRgn(0, 0, 0, 0);  
  if Windows.GetClipRgn(DC, Result) <> 1 then
  begin
    DeleteObject(Result);
    Result := 0;
  end;
end;

function TdxPSReportRenderer.IntersectClipRect(const R: TRect): HRGN;
begin
  Result := dxPSUtl.IntersectClipRect(DC, R);
end;

procedure TdxPSReportRenderer.RestoreClipRgn(var Rgn: HRGN);
begin
  dxPSUtl.RestoreClipRgn(DC, Rgn);
end;

procedure TdxPSReportRenderer.RenderPage(ACanvas: TCanvas; const APageBounds: TRect;
  APageIndex, AContinuousPageIndex, AZoomFactor: Integer);
var
  VirtualPageIndex, RealPageIndex: Integer;
  Composition: TdxCompositionReportLink;
begin
  RenderInfo.CalculatePageRealAndVirtualIndexes(APageIndex, VirtualPageIndex, RealPageIndex);

  if not RenderInfo.CanRenderPage(VirtualPageIndex) then Exit;

  Composition := ReportLink.CurrentComposition;
  if (Composition = nil) or not Composition.ContinuousPageIndexes then
    AContinuousPageIndex := RealPageIndex
  else
    if Composition <> nil then
      AContinuousPageIndex := Composition.VirtualPageIndexToRealPageIndex(AContinuousPageIndex);

  dxHFFormatObject.CurrentPage := PreparedPageIndex(AContinuousPageIndex) + 1;

  FCanvas := ACanvas;
  FDC := FCanvas.Handle;
  FPPI := GetDeviceCaps(DC, LOGPIXELSX);
  FViewPortRect := APageBounds;
  FZoomFactor := AZoomFactor;
  FRenderingPageIndex := VirtualPageIndex;
  PrepareRenderPage;
  try
    RenderPageBackground(RealPageIndex);
    RenderPageHeader(RealPageIndex);
    RenderPageFooter(RealPageIndex);
    if RenderInfo.HasPageTitle(RealPageIndex) then RenderPageTitle;
    if ReportLink.NeedTwoPassRendering then
    begin
      FRenderStage := [rsFirstPass];
      RenderPageContent;
      FRenderStage := [rsSecondPass];      
      RenderPageContent;
    end
    else
    begin
      FRenderStage := [rsFirstPass, rsSecondPass];
      RenderPageContent;
    end;
  finally
    FRenderStage := [];
    UnprepareRenderPage;
  end;
  RenderEntirePage(RealPageIndex);
end;

procedure TdxPSReportRenderer.RenderDelimiters;
var
  I, Delimiter: Integer;
  R: TRect;
begin
  for I := 0 to RenderInfo.DelimiterXCount - 1 do
  begin
    Delimiter := RenderInfo.DelimitersX[I];
    R := MakeBounds(Delimiter, 0, 2 * LineThickness, 20 * LineThickness);
    //OffsetRect(R, 0, -PageRenderInfo.DataOffset.Y);
    FillRect(DC, R, GetSysColorBrush(COLOR_HIGHLIGHT));
  end;
end;

procedure TdxPSReportRenderer.RenderPageBackground(ARealPageIndex: Integer);
var
  R: TRect;
begin                          
  if IsPrinting then 
    with ReportLink.RealPrinterPage.Background do
    begin
      R := RenderInfo.PageHeaderBounds;
      R.Bottom := RenderInfo.PageFooterBounds.Top;
      if (Mode = bmNone) or ((Mode = bmPicture) and (PictureMode in [ppmCenter, ppmProportional])) then
        Windows.FillRect(DC, R, GetStockObject(WHITE_BRUSH));
      PaintEx(Canvas, R, PixelsNumerator * 100, PixelsDenominator * RenderInfo.ScaleFactor);
    end;
end;

procedure TdxPSReportRenderer.RenderPageFooter(ARealPageIndex: Integer);
var
  R: TRect;
begin
  R := RenderInfo.PageFooterBounds;
  if not IsRectEmpty(R) and (IsPrinting or RectVisible(DC, R)) then
    RenderPageHeaderOrFooter(ReportLink.RealPrinterPage.PageFooter, ARealPageIndex, R);
end;

procedure TdxPSReportRenderer.RenderPageHeader(ARealPageIndex: Integer);
var
  R: TRect;
begin
  R := RenderInfo.PageHeaderBounds;
  if not IsRectEmpty(R) and (IsPrinting or RectVisible(DC, R)) then
    RenderPageHeaderOrFooter(ReportLink.RealPrinterPage.PageHeader, ARealPageIndex, R);
end;

procedure TdxPSReportRenderer.RenderPageHeaderOrFooter(HF: TCustomdxPageObject;
  APageIndex: Integer; ARect: TRect);
const
  TitleParts: array[Boolean] of TdxPageTitleParts = ([], [tpLeft..tpRight]);
var
  PrevFontHeight: Integer;
  Rgn: HRGN;
  DefaultDrawText, DefaultDrawBackground: Boolean;
  PrevFont: HFONT;
  PrevFontColor: COLORREF;
begin
  PrevFontHeight := HF.Font.Height;
  HF.Font.Height := -MulDiv(HF.Font.Size, MulDiv(UnitsPerInch, 100, ReportLink.RealScaleFactor), PtPerInch);

  SetBkMode(DC, TRANSPARENT);

  Rgn := IntersectClipRect(ARect);
  try
    DefaultDrawText := True;
    DefaultDrawBackground := True;

    PrevFont := SelectObject(DC, HF.Font.Handle);
    PrevFontColor := SetTextColor(DC, ColorToRGB(HF.Font.Color));

    if ReportLink.IsHeaderOrFooterCustomDrawn(HF) then
    begin
      //PrepareCanvasForCustomDraw(@HF.Font, nil);
      ReportLink.DoCustomDrawPageHeaderOrFooter(HF, Canvas, APageIndex, ARect, DefaultDrawText, DefaultDrawBackground);
      SetBkMode(DC, TRANSPARENT);
    end;

    if DefaultDrawText or DefaultDrawBackground then
      RenderPageHeaderOrFooterContent(HF, APageIndex, ARect, TitleParts[DefaultDrawText], DefaultDrawBackground);

    //if ReportLink.IsHeaderOrFooterCustomDrawn(HF) then UnprepareCanvasForCustomDraw;

    SetTextColor(DC, PrevFontColor);
    SelectObject(DC, PrevFont);
  finally
    RestoreClipRgn(Rgn);
  end;
  HF.Font.Height := PrevFontHeight;
end;

procedure TdxPSReportRenderer.RenderPageHeaderOrFooterContentPart(ATitlePart: TdxPageTitlePart;
  AStrings: TStrings; ATextAlignY: TcxTextAlignY; ALineHeight, ADestWidth, ADestHeight: Integer;
  const ARect: TRect);
const
  uFormat = DT_SINGLELINE or DT_VCENTER or DT_NOCLIP or DT_EDITCONTROL;
var
  FullHeight: Integer;
  R: TRect;
  I: Integer;
  S: string;
  TextSize: TSize;
begin
  if ATextAlignY = taTop then
    FullHeight := ARect.Top
  else
  begin
    FullHeight := AStrings.Count * ALineHeight;
    if ATextAlignY = taCenterY then
      FullHeight := ARect.Top + (ADestHeight - FullHeight) div 2
    else {taBottom}
      FullHeight := ARect.Top + ADestHeight - FullHeight;
  end;
  if FullHeight < ARect.Top then
    FullHeight := ARect.Top;
  R := MakeRect(ARect.Left, FullHeight, ARect.Right, FullHeight + ALineHeight);

  for I := 0 to AStrings.Count - 1 do
  begin
    S := AStrings[I];
    if S <> '' then
    begin
      GetTextExtentPoint32(DC, PChar(S), Length(S), TextSize);
      if ADestWidth > TextSize.cX then
        case ATitlePart of
          tpLeft:
            R.Right := R.Left + TextSize.cX;
          tpCenter:
            begin
              R.Left := ARect.Left + (ADestWidth - TextSize.cX) div 2;
              R.Right := R.Left + TextSize.cX;
            end;
          tpRight:
            R.Left := R.Right - TextSize.cX;
        end;
      if RectVisible(DC, R) then
      begin
        Windows.DrawText(DC, PChar(S), Length(S), R, uFormat or DT_LEFT);
        ExcludeClipRect(R);
      end;
      R.Right := ARect.Right;
    end;
    OffsetRect(R, 0, ALineHeight);
  end;
end;

procedure TdxPSReportRenderer.RenderPageHeaderOrFooterContent(HF: TCustomdxPageObject;
  APageIndex: Integer; ARect: TRect; ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
var
  TextSize: TSize;
  LineHeight, DestWidth, DestHeight: Integer;
  TextAlignY: TcxTextAlignY;
begin
  if ADrawBackground then
    HF.Background.PaintEx(Canvas, ARect, PixelsNumerator * 100, PixelsDenominator * RenderInfo.ScaleFactor);

  if ATitleParts = [] then
    Exit;
    
  GetTextExtentPoint32(DC, 'Hg', 2, TextSize);
  LineHeight := TextSize.cY;
  DestWidth := ARect.Right - ARect.Left;
  DestHeight := ARect.Bottom - ARect.Top;

  if tpLeft in ATitleParts then
  begin
    if ReportLink.RealPrinterPage.ReverseTitlesOnEvenPages and Odd(APageIndex) then
    begin
      FHFStrings.Text := dxProcessHFString(HF.RightTitle.Text);
      TextAlignY := HF.TextAlignY[tpRight];
    end
    else
    begin
      FHFStrings.Text := dxProcessHFString(HF.LeftTitle.Text);
      TextAlignY := HF.TextAlignY[tpLeft];
    end;
    RenderPageHeaderOrFooterContentPart(tpLeft, FHFStrings, TextAlignY,
      LineHeight, DestWidth, DestHeight, ARect);
  end;

  if tpRight in ATitleParts then
  begin
    if ReportLink.RealPrinterPage.ReverseTitlesOnEvenPages and Odd(APageIndex) then
    begin
      FHFStrings.Text := dxProcessHFString(HF.LeftTitle.Text);
      TextAlignY := HF.TextAlignY[tpLeft];
    end
    else
    begin
      FHFStrings.Text := dxProcessHFString(HF.RightTitle.Text);
      TextAlignY := HF.TextAlignY[tpRight];
    end;
    RenderPageHeaderOrFooterContentPart(tpRight, FHFStrings, TextAlignY,
      LineHeight, DestWidth, DestHeight, ARect);
  end;

  if tpCenter in ATitleParts then
  begin
    FHFStrings.Text := dxProcessHFString(HF.CenterTitle.Text);
    TextAlignY := HF.TextAlignY[tpCenter];
    RenderPageHeaderOrFooterContentPart(tpCenter, FHFStrings, TextAlignY,
      LineHeight, DestWidth, DestHeight, ARect);
  end;
end;

procedure TdxPSReportRenderer.RenderPageTitle;
var
  R: TRect;
begin
  R := RenderInfo.TitleBounds;
  OffsetWindowOrgEx(DC, -PageRenderInfo.TitleOffset.X, -PageRenderInfo.TitleOffset.Y, nil);
  if RectVisible(DC, R) then
    with ReportLink.ReportTitle do
      RenderPageTitleContent(Text, R, TextAlignX, TextAlignY, Color, Font, Transparent);
  OffsetWindowOrgEx(DC, PageRenderInfo.TitleOffset.X, PageRenderInfo.TitleOffset.Y, nil);
end;

procedure TdxPSReportRenderer.RenderCell(ACell: TdxReportCell; const OriginRect: TRect);
var
  R: TRect;
begin
  if ACell.Visible then 
  begin
    R := ACell.BoundsRect;
    { Transform R into the coordinate space of page }
    OffsetRect(R, -OriginRect.Left, -OriginRect.Top);
    if (R.Left <> 0) or (R.Top <> 0) then
      OffsetWindowOrgEx(DC, -R.Left, -R.Top, nil);
    ACell.DrawContent(DC, MakeRect(0, 0, R.Right - R.Left, R.Bottom - R.Top), OriginRect, RenderStage);
    if (R.Left <> 0) or   (R.Top <> 0) then
      OffsetWindowOrgEx(DC, R.Left, R.Top, nil);
  end;
end;

procedure TdxPSReportRenderer.RenderEntirePage(ARealPageIndex: Integer);
var
  Rgn: HRGN;
begin
  if ReportLink.IsEntirePageCustomDrawn then 
  begin
    Rgn := IntersectClipRect(ViewPortRect);
    try
      ReportLink.DoCustomDrawEntirePage(Canvas, ViewPortRect, ARealPageIndex);
    finally
      RestoreClipRgn(Rgn);
    end;
  end;  
end;

procedure TdxPSReportRenderer.RenderPageContent;
var
  R: TRect;
  Rgn: HRGN;
  PrevFont: HFONT;
  PrevFontColor: COLORREF;
  I, H, StartIndex, EndIndex: Integer;
  PrevWindowOrg: TPoint;
begin
  OffsetWindowOrgEx(DC, -PageRenderInfo.DataOffset.X - LineThickness,
    -PageRenderInfo.DataOffset.Y - LineThickness, @PrevWindowOrg);
  R := PageRenderInfo.ContentBounds;
  OffsetRect(R, -R.Left, -R.Top);
//  InflateRect(R, LineThickness, LineThickness); // for double
  Dec(R.Left, LineThickness);
  Dec(R.Top, LineThickness);
  
  Rgn := dxPSUtl.IntersectClipRect(DC, R, True);
  SetBkMode(DC, Windows.TRANSPARENT);
  with RenderInfo.BaseContentFont do
  begin
    PrevFont := SelectObject(DC, Handle);
    PrevFontColor := SetTextColor(DC, ColorToRGB(Color));
  end;

  with PageRenderInfo do
  begin
    if HasHeader then
    begin
      R := HeaderBounds;
      OffsetRect(R, DetailBounds.Left, 0);
      with ReportCells do
        RenderPageContentPart(HeaderCells, 0, HeaderCells.CellCount - 1, R);
      ExcludeClipRect(HeaderBounds);
      OffsetWindowOrgEx(DC, 0, -(HeaderBounds.Bottom - HeaderBounds.Top), nil);
    end;

    if HasDetails then
    begin
      EndIndex := 0;
      for I := 0 to IndexPairCount - 1 do
      begin
        StartIndex := IndexPairs[I].StartIndex;
        EndIndex := IndexPairs[I].EndIndex;
        RenderPageContentPart(ReportCells.Cells, StartIndex, EndIndex, DetailBounds);
      end;
      for I := 0 to OverlayCount - 1 do
        RenderPageOverlay(I, Overlays[I], DetailBounds);
      
      H := 0;      
      if not IsBottomPage then
        H := DetailBounds.Bottom
      else
        if ReportCells.Cells.CellCount > EndIndex then
          H := ReportCells.Cells[EndIndex].BoundsRect.Bottom;
      Dec(H, DetailBounds.Top);
      OffsetWindowOrgEx(DC, 0, -H, nil);
    end;

    if HasFooter then
    begin
      R := FooterBounds;
      OffsetRect(R, DetailBounds.Left, 0);
      with ReportCells do
        RenderPageContentPart(FooterCells, 0, FooterCells.CellCount - 1, R);
    end;
  end;
  RestoreClipRgn(Rgn);
  SetBkMode(DC, Windows.OPAQUE);
  SetTextColor(DC, PrevFontColor);
  SelectObject(DC, PrevFont);
  SetWindowOrgEx(DC, PrevWindowOrg.X, PrevWindowOrg.Y, nil);
end;

procedure TdxPSReportRenderer.RenderPageContentPart(ACell: TdxReportCell;
  StartIndex, EndIndex: Integer; const OriginRect: TRect);
var
  I: Integer;
begin
  for I := StartIndex to EndIndex do
    RenderCell(ACell[I], OriginRect);
end;  

procedure TdxPSReportRenderer.RenderPageOverlay(AnOverlayIndex: Integer; 
  AnOverlay: TdxPageOverlayIndexes; const OriginRect: TRect);
var
  OverlayCell: TdxReportCell;
  I: Integer;
begin
  OverlayCell := ReportCells.Overlays[AnOverlayIndex];
  for I := 0 to AnOverlay.Count - 1 do
    RenderCell(OverlayCell.Cells[AnOverlay[I]], OriginRect);
end;    

function TdxPSReportRenderer.GetUnitsPerInch: Integer;
begin
  Result := RenderInfo.UnitsPerInch;
end;

function TdxPSReportRenderer.CreateBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
begin               
  Result := AClass.Create(Self);
  FBorderPainters.Add(Result);
end;

function TdxPSReportRenderer.FindBorderPainter(AClass: TdxPSCellBorderPainterClass): TdxPSCellBorderPainter;
var
  I: Integer;
begin
  for I := 0 to BorderPainterCount - 1 do
  begin
    Result := BorderPainters[I];
    if Result.ClassType = AClass then Exit;
  end;
  Result := nil;
end;

procedure TdxPSReportRenderer.FreeAndNilBorderPainters;
var
  I: Integer;
begin
  for I := 0 to BorderPainterCount - 1 do
    BorderPainters[I].Free;
  FreeAndNil(FBorderPainters);
end;

function TdxPSReportRenderer.CreateReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
begin               
  Result := AClass.Create(Self);
  FGroupLookAndFeelPainters.Add(Result);
end;

function TdxPSReportRenderer.FindReportGroupLookAndFeelPainter(AClass: TdxPSReportGroupLookAndFeelPainterClass): TdxPSReportGroupLookAndFeelPainter;
var
  I: Integer;
begin
  for I := 0 to GroupLookAndFeelPainterCount - 1 do
  begin
    Result := GroupLookAndFeelPainters[I];
    if Result.ClassType = AClass then Exit;
  end;
  Result := nil;
end;

procedure TdxPSReportRenderer.FreeAndNilReportGroupLookAndFeelPainters;
var
  I: Integer;
begin
  for I := 0 to GroupLookAndFeelPainterCount - 1 do
    GroupLookAndFeelPainters[I].Free;
  FreeAndNil(FGroupLookAndFeelPainters);
end;

function TdxPSReportRenderer.GetBorderPainterItem(Index: Integer): TdxPSCellBorderPainter;
begin
  Result := TdxPSCellBorderPainter(FBorderPainters[Index]);
end;

function TdxPSReportRenderer.GetBorderPainterCount: Integer;
begin
  Result := FBorderPainters.Count;
end;

function TdxPSReportRenderer.GetGroupLookAndFeelPainter(Index: Integer): TdxPSReportGroupLookAndFeelPainter;
begin
  Result := TdxPSReportGroupLookAndFeelPainter(FGroupLookAndFeelPainters[Index]);
end;

function TdxPSReportRenderer.GetGroupLookAndFeelPainterCount: Integer;
begin
  Result := FGroupLookAndFeelPainters.Count;
end;

function TdxPSReportRenderer.GetHalfLineThickness: Integer;
begin
  Result := LineThickness div 2;
end;

function TdxPSReportRenderer.GetIsPrinting: Boolean;
begin
  Result := IsPrinterDC(DC);
end;

function TdxPSReportRenderer.GetPageRenderInfo: TdxPSPageRenderInfo;
begin
  Result := RenderInfo.PageRenderInfos[RenderingPageIndex];
end;

function TdxPSReportRenderer.GetRenderInfo: TdxPSReportRenderInfo;
begin
  Result := FReportLink.RenderInfo;
end;

function TdxPSReportRenderer.GetReportCells: TdxReportCells;
begin
  Result := ReportLink.FReportCells;
end;

procedure TdxPSReportRenderer.PrepareCanvasForCustomDraw(AFont: TFont; AColor: TColor);
begin
  FSavePixelsPerInch := Canvas.Font.PixelsPerInch;
  FSaveFont.Assign(Canvas.Font);
  if (AFont <> nil) then
  begin
    Canvas.Font.PixelsPerInch := AFont.PixelsPerInch;
    Canvas.Font := AFont;
  end;  
  FSaveColor := Canvas.Brush.Color;
  Canvas.Brush.Color := AColor;
end;

procedure TdxPSReportRenderer.UnprepareCanvasForCustomDraw;
begin
  Canvas.Brush.Color := FSaveColor;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.PixelsPerInch := FSavePixelsPerInch;  
  Canvas.Font := FSaveFont;
  SetBkMode(DC, Windows.TRANSPARENT); 
end;

procedure TdxPSReportRenderer.PrepareFonts;
var
  UPI: Integer;
begin
  UPI := RenderInfo.UnitsPerInch;
  if not ReportLink.ScaleFonts and (ReportLink.RealScaleFactor <> 100) then
    UPI := MulDiv(UPI, 100, ReportLink.RealScaleFactor);
  ReportLink.PrepareFonts(UPI);
  MarlettFont10.Height := -MulDiv(10, UnitsPerInch, PtPerInch);
  dxPSUtl.SetFontAsNonAntialiased(MarlettFont10);
  MarlettFont8.Height := -MulDiv(8, UnitsPerInch, PtPerInch);
  dxPSUtl.SetFontAsNonAntialiased(MarlettFont8);
  SymbolFont.Height := -MulDiv(7, UnitsPerInch, PtPerInch);
  dxPSUtl.SetFontAsNonAntialiased(SymbolFont);
end;         

procedure TdxPSReportRenderer.PrepareGDIObjects;
begin
  FBorderColor := ColorToRGB(RenderInfo.GridLinesColor);
end;

procedure TdxPSReportRenderer.PrepareLogicalCoordinates;
begin
  if FUseIsotropicMode then
    SetMapMode(DC, MM_ISOTROPIC);
  PrepareWindow;
  PrepareViewPort;
//  MoveToEx(DC, 0, 0, nil);
end;

procedure TdxPSReportRenderer.PrepareLogicalUnits;
var
  R: TRect;
  UnitsPerPt: Integer;
begin
  R := MakeRect(0, 0, 1, 1);
  DPToLP(DC, R, 2);
  UnitsPerPixel := R.Right - R.Left;
  //if Odd(FUnitsPerPixel) then Dec(FUnitsPerPixel);
  if UnitsPerPixel = 0 then UnitsPerPixel := 1;

  UnitsPerPt := MulDiv(UnitsPerPixel, PPI, PtPerInch);

  if not IsPrinting then
  begin
    LineThickness := 1 * UnitsPerPixel;
    if (ZoomFactor > 100) and ReportLink.IsScaleGridLines then
      LineThickness := LineThickness * (ZoomFactor div 100);
  end
  else
    LineThickness := MulDiv(UnitsPerPt, 1, 2); 

  FPixelsNumerator := RenderInfo.UnitsPerInch;
end;

function TdxPSReportRenderer.PreparedPageIndex(APageIndex: Integer): Integer;
var
  RowIndex, ColIndex: Integer;
begin
  if RenderInfo.PrinterPage.PageOrder = poDownThenOver then
  begin
    RowIndex := APageIndex div RenderInfo.PageColCount;
    ColIndex := APageIndex mod RenderInfo.PageColCount;
    Result := RowIndex + ColIndex * RenderInfo.PageRowCount;
  end
  else
    Result := APageIndex;
end;

procedure TdxPSReportRenderer.PrepareRenderPage;
begin
  RenderInfo.Lock;
  SaveMapMode;
  PrepareLogicalCoordinates;
  PrepareLogicalUnits;
  PrepareFonts;
  PrepareGDIObjects;
  FIsRendering := True;
end;

procedure TdxPSReportRenderer.PrepareWindow;
begin
  with RenderInfo do
  begin
    SetWindowExtEx(DC, PageSize.X, PageSize.Y, nil);
    ScaleWindowExtEx(DC, WindowScalePair.Numerator, WindowScalePair.Denominator,
      WindowScalePair.Numerator, WindowScalePair.Denominator, nil);
  end;
end;

procedure TdxPSReportRenderer.PrepareViewPort;
begin
  with ViewPortRect do
  begin
    SetViewPortExtEx(DC, Right - Left, Bottom - Top, nil);
    SetViewPortOrgEx(DC, Left, Top, nil);
  end;
end;

procedure TdxPSReportRenderer.RestoreMapMode;
begin
  SetMapMode(DC, FPrevMode);
  SetWindowExtEx(DC, FPrevWindowExt.cX, FPrevWindowExt.cY, nil);
  SetViewPortOrgEx(DC, FPrevViewPortOrg.X, FPrevViewPortOrg.Y, nil);
  SetViewPortExtEx(DC, FPrevViewPortExt.cX, FPrevViewPortExt.cY, nil);
  SetWindowOrgEx(DC, FPrevWindowOrg.X, FPrevWindowOrg.Y, nil);
end;

procedure TdxPSReportRenderer.SaveMapMode;
begin
  FPrevMode := GetMapMode(DC);
  GetWindowExtEx(DC, FPrevWindowExt);
  GetWindowOrgEx(DC, FPrevWindowOrg);
  GetViewPortExtEx(DC, FPrevViewPortExt);
  GetViewPortOrgEx(DC, FPrevViewPortOrg);
end;

procedure TdxPSReportRenderer.UnprepareLogicalUnits;
begin
  LineThickness := 1;
end;

procedure TdxPSReportRenderer.UnprepareGDIObjects;
begin
end;

procedure TdxPSReportRenderer.UnprepareRenderPage;
begin
  FIsRendering := False;
  UnprepareLogicalUnits;
  UnprepareGDIObjects;
  RestoreMapMode;
  RenderInfo.Unlock;
end;

{ TdxReportItem }

constructor TdxReportItem.Create(AParent: TdxReportCell);
begin
  inherited Create;
  Parent := AParent;
end;

destructor TdxReportItem.Destroy;
begin
  SetParent(nil);
  inherited Destroy;
end;

procedure TdxReportItem.Assign(Source: TPersistent);
begin
  if Source is TdxReportItem then
    Data := TdxReportItem(Source).Data
  else
    inherited;
end;

class function TdxReportItem.ReportItemClass: TdxReportItemClass;
begin
  Result := TdxReportItemClass(GetTypeData(ClassInfo)^.ClassType);
end;

class procedure TdxReportItem.Register;
begin
  if GetClass(ClassName) = nil then RegisterClass(Self);
end;

class procedure TdxReportItem.Unregister;
begin
  UnregisterClass(Self);
end;

function TdxReportItem.Clone(AParent: TdxReportCell): TdxReportItem;
begin
  Result := ReportItemClass.Create(AParent);
  try
    Result.Assign(Self);
  except
    Result.Free;
    raise;
  end;
end;

function TdxReportItem.GetNextSibling: TdxReportItem;
var
  Index: Integer;
begin
  Result := nil;
  if not HasParent then Exit;
  Index := Parent.IndexOf(Self);

  if IsCell then
  begin
    if Index < Parent.CellCount - 1 then
      Result := TdxReportItem(Parent.FCellList[Index + 1]);
  end
  else
    if Index < Parent.DataItemCount - 1 then
      Result := TdxReportItem(Parent.FDataList[Index + 1]);
end;

function TdxReportItem.GetPrevSibling: TdxReportItem;
var
  Index: Integer;
begin
  Result := nil;
  if not HasParent then Exit;
  Index := Parent.IndexOf(Self);
  if Index < 1 then Exit;

  if IsCell then
    Result := TdxReportItem(Parent.FCellList[Index - 1])
  else
    Result := TdxReportItem(Parent.FDataList[Index - 1]);
end;

function TdxReportItem.HasParent: Boolean;
begin
  Result := Parent <> nil;
end;

function TdxReportItem.IsFirstItem: Boolean;
begin
  Result := GetPrevSibling = nil;
end;

function TdxReportItem.IsLastItem: Boolean;
begin
  Result := GetNextSibling = nil;
end;

function TdxReportItem.AsCell: TdxReportCell;
begin
  if IsCell then
    Result := TdxReportCell(Self)
  else
    Result := nil;
end;

function TdxReportItem.GetTopLevelParent: TdxReportCell;
begin
  if ReportCells <> nil then
    Result := ReportCells.GetCellTopLevelParent(Self)
  else
    Result := nil; 
end;

class function TdxReportItem.IsCell: Boolean;
begin
  Result := False;
end;

procedure TdxReportItem.ReadData(AReader: TdxPSDataReader);
begin
  Data := AReader.ReadInteger;
end;

procedure TdxReportItem.WriteData(AWriter: TdxPSDataWriter);
begin
  AWriter.WriteInteger(Data);
end;

class function TdxReportItem.Serializable: Boolean;
begin
  Result := True;
end;

function TdxReportItem.GetIndex: Integer;
begin
  if Parent <> nil then
    Result := Parent.IndexOf(Self)
  else
    Result := -1;
end;

function TdxReportItem.GetReportCells: TdxReportCells;
begin
  if Parent <> nil then
    Result := Parent.ReportCells
  else
    Result := nil;
end;

procedure TdxReportItem.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  if Parent = nil then Exit;
  if Value < 0 then Value := 0;
  
  if IsCell then
  begin
    if Value > Parent.CellCount - 1 then
      Value := Parent.CellCount - 1
  end
  else
    if Value > Parent.DataItemCount - 1 then
      Value := Parent.DataItemCount - 1;
  CurIndex := GetIndex;
  if CurIndex <> Value then
    Parent.MoveItem(Self, CurIndex, Value);
end;

procedure TdxReportItem.SetParent(Value: TdxReportCell);
begin
  if Parent <> Value then
  begin
    if Parent <> nil then Parent.RemoveItem(Self);
    if Value <> nil then Value.InsertItem(Self);
  end;
end;

{ TdxReportVisualItem }

constructor TdxReportVisualItem.Create(AParent: TdxReportCell);
begin
  inherited;
  FBackgroundBitmapIndex := -1;
  if HasBorderColoration then
    FBorderClass := TdxPSColorBorder
  else
    FBorderClass := TdxPSCellUltraFlatBorder;
  FBorderColor := clDefault; 
  CellSides := dxDefaultCellSides;     // csAll
  FColor := dxDefaultContentColor;     // clWhite
  ShowShadow := False;
  Transparent := dxDefaultTransparent; // True
  Visible := True;
end;

procedure TdxReportVisualItem.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxReportVisualItem then
    with TdxReportVisualItem(Source) do
    begin
      Self.BackgroundBitmapIndex := BackgroundBitmapIndex;
      Self.BorderClass := BorderClass;
      Self.BorderColor := BorderColor;
      Self.BoundsRect := BoundsRect;
      Self.Color := Color;
      Self.ContentBkColor := ContentBkColor;
      Self.ContentPattern := ContentPattern;
      Self.FontIndex := FontIndex;
      Self.Format := Format;
      Self.ShadowColor := ShadowColor;
      Self.ShadowDepth := ShadowDepth;
      Self.FCellSideColors := FCellSideColors;
    end;
end;

procedure TdxReportVisualItem.AdjustContent(DC: HDC);
begin
end;

procedure TdxReportVisualItem.DrawBackground(DC: HDC);
begin
  DrawBackgroundRect(DC, GetBackgroundBounds(DC));
end;

procedure TdxReportVisualItem.DrawBackgroundBitmap(DC: HDC);
var
  Rgn: HRGN;
  I, J: Integer;
  R: TRect;
begin
  Rgn := Renderer.IntersectClipRect(GetBackgroundBounds(DC));
  try
    for I := BackgroundBitmapTileStartIndexX to BackgroundBitmapTileStopIndexX do
      for J := BackgroundBitmapTileStartIndexY to BackgroundBitmapTileStopIndexY do
      begin
        R := BackgroundBitmapTileBounds[I, J];
        if RectVisible(DC, R) then DrawBackgroundBitmapTile(DC, R);
      end;  
  finally
    Renderer.RestoreClipRgn(Rgn);
  end;    
end;

procedure TdxReportVisualItem.DrawBackgroundBitmapTile(DC: HDC; const Rect: TRect);
begin
  Renderer.DrawGraphicEx(DC, Rect, GetBackgroundBounds(DC), nil, -1, BackgroundBitmap, 
    False, False, clNone, clNone, nil, cibAlways);
end;

procedure TdxReportVisualItem.DrawBackgroundRect(DC: HDC; const R: TRect);
begin
  if not IsRectEmpty(R) then 
    Renderer.FillRectEx(DC, R, Color, ContentBkColor, ContentPattern);
end;

procedure TdxReportVisualItem.DrawBorders(DC: HDC);
begin
  BorderPainter.Paint(DC);
end;

function TdxReportVisualItem.GetBorderOuterBounds(DC: HDC): TRect;
begin
  Result := GetBorderOuterBoundsRelativeTo(DC, GetOuterBounds(DC));
end;

function TdxReportVisualItem.GetInnerBounds(DC: HDC): TRect;
begin
  Result := GetInnerBoundsRelativeTo(DC, BoundsRect);
end;

function TdxReportVisualItem.GetOuterBounds(DC: HDC): TRect;
begin
  Result := GetOuterBoundsRelativeTo(DC, BoundsRect);
end;

procedure TdxReportVisualItem.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft <> Left) or (ATop <> Top) or (AWidth <> Width) or (AHeight <> Height) then
  begin
    FBoundsRect.Left := ALeft;
    FBoundsRect.Top := ATop;
    FBoundsRect.Right := ALeft + AWidth;
    FBoundsRect.Bottom := ATop + AHeight;
    BoundsChanged;
  end;
end;

function TdxReportVisualItem.CalculateLineCount(DC: HDC): Integer;
begin
  Result := 1;
end;

function TdxReportVisualItem.MeasureBordersHeight(DC: HDC): Integer;
begin
  Result := 0;
  if csTop in CellSides then 
    Inc(Result, GetBorderEdgeThickness(csTop) - 1);
  if csBottom in CellSides then 
    Inc(Result, GetBorderEdgeThickness(csBottom) - 1);
  if ShowShadow then
    Inc(Result, ShadowDepth);
end;

function TdxReportVisualItem.MeasureBordersWidth(DC: HDC): Integer;
begin
  Result := 0;
  if csLeft in CellSides then 
    Inc(Result, GetBorderEdgeThickness(csLeft) - 1);
  if csRight in CellSides then 
    Inc(Result, GetBorderEdgeThickness(csRight) - 1);
  if ShowShadow then
    Inc(Result, ShadowDepth);
end;

function TdxReportVisualItem.MeasureContentHeight(DC: HDC): Integer;
begin
  Result := 0;
end;

function TdxReportVisualItem.MeasureContentWidth(DC: HDC): Integer;
begin
  Result := 0;
end;

function TdxReportVisualItem.MeasureFontHeight(DC: HDC): Integer;
begin
  Result := Height;
end;

function TdxReportVisualItem.MeasureHeight(DC: HDC): Integer;
begin
  Result := MeasureBordersHeight(DC) + MeasureContentHeight(DC);
end;

function TdxReportVisualItem.MeasureWidth(DC: HDC): Integer;
begin
  Result := MeasureBordersWidth(DC) + MeasureContentWidth(DC);
end;

class function TdxReportVisualItem.MapBorderClass(AEdgeMode: TdxCellEdgeMode; 
  AEdgeStyle: TdxCellEdgeStyle; ASoft: Boolean): TdxPSCellBorderClass;
begin
  if AEdgeMode = cem3DEffects then
    Result := dxCellBorderClassMap[AEdgeStyle, ASoft]
  else
    Result := TdxPSCellUltraFlatBorder;  
end;

procedure TdxReportVisualItem.BoundsChanged;
begin
end;

procedure TdxReportVisualItem.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  with FBoundsRect do
  begin
    Left := MulDiv(Left, APixelsNumerator, APixelsDenominator);
    Right := MulDiv(Right, APixelsNumerator, APixelsDenominator);
    Top := MulDiv(Top, APixelsNumerator, APixelsDenominator);
    Bottom := MulDiv(Bottom, APixelsNumerator, APixelsDenominator);
  end;
end;

procedure TdxReportVisualItem.DoExcludeFromClipRgn(DC: HDC; const R: TRect; 
  var AResult: Integer);
var
  R2: TRect;
begin
  if ExcludeFromClipRgn and not Transparent and Visible and IntersectRect(R2, GetAbsoluteRect, R) then
  begin
    R2 := GetOuterBounds(DC);
    if not IsRectEmpty(R2) then
      AResult := Renderer.ExcludeClipRect(R2);
  end;  
end;

function TdxReportVisualItem.GetBackgroundBitmapTileBounds(Col, Row: Integer): TRect;
begin
  Result := MakeBounds(Left + BackgroundBitmapWidth * Col, Top + BackgroundBitmapHeight * Row, 
    BackgroundBitmapWidth, BackgroundBitmapHeight);
  with BackgroundBitmapTileOrigin do
    OffsetRect(Result, X, Y);
end;

function TdxReportVisualItem.GetBackgroundBounds(DC: HDC): TRect;
begin
  Result := GetInnerBounds(DC);
end;

function TdxReportVisualItem.GetBorderClass: TdxPSCellBorderClass;
begin
  Result := FBorderClass;
end;

function TdxReportVisualItem.GetBorderEdgeClass(ASide: TdxCellSide): TdxPSCellBorderClass;
begin
  Result := BorderClass;
end;

function TdxReportVisualItem.GetBorderEdgeBounds(ASide: TdxCellSide; const AOuterRect: TRect): TRect;
begin
  Result := AOuterRect;
  with Result do 
    case ASide of
      csLeft: 
        Right := Left + LineThickness * BorderEdgeThicknesses[csLeft];
      csTop: 
        Bottom := Top + LineThickness * BorderEdgeThicknesses[csTop];
      csRight: 
        Left := Right - LineThickness * BorderEdgeThicknesses[csRight];
      csBottom:
        Top := Bottom - LineThickness * BorderEdgeThicknesses[csBottom];
    end;
end;
             
function TdxReportVisualItem.GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer;
begin
  Result := BorderEdgeClasses[ASide].GetBorderEdgeSalient(ASide, ASalient);
end;

function TdxReportVisualItem.GetBorderEdgeThickness(ASide: TdxCellSide): Integer;
begin  
  Result := BorderEdgeClasses[ASide].Thickness;
end;

function TdxReportVisualItem.GetBorderBounds(DC: HDC): TRect;
begin
  Result := FBoundsRect;  
end;

function TdxReportVisualItem.GetBorderOuterBoundsRelativeTo(DC: HDC; const R: TRect): TRect;
begin
  Result := R;
  if ShowShadow then 
  begin
    Dec(Result.Right, ShadowDepth);
    Dec(Result.Bottom, ShadowDepth);
  end;  
  //FixupRect(DC, Result);
end;

function TdxReportVisualItem.GetInnerBoundsRelativeTo(DC: HDC; const R: TRect): TRect;
var
  LineThickness: Integer;
begin
  Result := GetOuterBoundsRelativeTo(DC, R);
  LineThickness := Self.LineThickness;
  
  with Result do 
  begin
    if csLeft in CellSides then 
      Inc(Left, LineThickness * BorderEdgeThicknesses[csLeft]);
    if csTop in CellSides then 
      Inc(Top, LineThickness * BorderEdgeThicknesses[csTop]);
    if csRight in CellSides then 
      Dec(Right, LineThickness * BorderEdgeThicknesses[csRight]);
    if csBottom in CellSides then 
      Dec(Bottom, LineThickness * BorderEdgeThicknesses[csBottom]);

    if ShowShadow then
    begin 
      Dec(Right, ShadowDepth);
      Dec(Bottom, ShadowDepth);
    end;  
  end;  
  FixupRect(DC, Result);
end;

function TdxReportVisualItem.GetOuterBoundsRelativeTo(DC: HDC; const R: TRect): TRect;
var
  LineThickness: Integer;
begin
  Result := R;
  LineThickness := Self.LineThickness;

  with Result do 
  begin
    if csLeft in CellSides then 
      Dec(Left, LineThickness * BorderEdgeSalients[csLeft, bstOuter]);
    if csTop in CellSides then 
      Dec(Top, LineThickness * BorderEdgeSalients[csTop, bstOuter]);
    if csRight in CellSides then 
      Inc(Right, LineThickness * BorderEdgeSalients[csRight, bstOuter]);
    if csBottom in CellSides then 
      Inc(Bottom, LineThickness * BorderEdgeSalients[csBottom, bstOuter]);
  end;
  FixupRect(DC, Result);
end;  

function TdxReportVisualItem.GetBorderPainter: TdxPSCellBorderPainter;
begin
  Result := Renderer.GetBorderPainter(BorderPainterClass);
  InitBorderPainter(Result);
end;

function TdxReportVisualItem.GetBorderPainterClass: TdxPSCellBorderPainterClass;
begin
  Result := BorderClass.GetPainterClass;
end;

procedure TdxReportVisualItem.InitBorderPainter(ABorderPainter: TdxPSCellBorderPainter);
begin
  ABorderPainter.FItem := Self;
end;

function TdxReportVisualItem.HasBorderColoration: Boolean;
begin
  Result := False; // todo MSN;
end;

function TdxReportVisualItem.GetFormatBit(ABit: DWORD): Boolean;
begin
  Result := Format and ABit = ABit;
end;

procedure TdxReportVisualItem.SetFormatBit(ABit: DWORD; Value: Boolean);
begin
  Format := Format and not ABit;
  if Value then
    Format := Format or ABit;
end;

function TdxReportVisualItem.GetContentBkColor: TColor;
begin
  Result := Color;
end;

function TdxReportVisualItem.GetContentPattern: TdxPSFillPatternClass;
begin
  Result := TdxPSSolidFillPattern;
end;

function TdxReportVisualItem.GetShadowColor: TColor;
begin
  if ReportCells <> nil then 
    Result := ReportCells.ShadowColor
  else  
    Result := dxDefaultShadowColor;
end;

function TdxReportVisualItem.GetShadowDepth: Integer;
begin
  if ReportCells <> nil then 
    Result := ReportCells.ShadowDepth
  else  
    Result := dxDefaultShadowDepth;
end;

procedure TdxReportVisualItem.SetContentBkColor(Value: TColor);
begin
end;

procedure TdxReportVisualItem.SetContentPattern(Value: TdxPSFillPatternClass);
begin
end;

procedure TdxReportVisualItem.SetFontIndex(Value: Integer);
begin
  if Value < -1 then Value := -1;
  FFontIndex := Value;
end;

procedure TdxReportVisualItem.SetShadowColor(Value: TColor);
begin
end;

procedure TdxReportVisualItem.SetShadowDepth(Value: Integer);
begin
end;

function TdxReportVisualItem.IsBackgroundBitmapDrawn: Boolean;
begin
  Result := (BackgroundBitmapIndex <> -1) and not BackgroundBitmap.Empty;
end;

function TdxReportVisualItem.IsBackgroundDrawn: Boolean;
begin
  Result := not Transparent;
end;

function TdxReportVisualItem.IsBordersDrawn: Boolean;
begin
  Result := (CellSides <> []) or ShowShadow;
end;

procedure TdxReportVisualItem.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  with AReader do
  begin
    BackgroundBitmapIndex := ReadInteger;
    BoundsRect := ReadRect;
    BorderClass := ReadCellBorderClass;
    if HasBorderColoration then
      TRect(FCellSideColors) := ReadRect;
    BorderColor := ReadInteger;
    Color := ReadInteger;
    ContentBkColor := ReadInteger;
    ContentPattern := ReadFillPatternClass;
    FontIndex := ReadInteger;
    Read(FFormat, SizeOf(Format));
  end;
end;

procedure TdxReportVisualItem.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  with AWriter do
  begin
    WriteInteger(BackgroundBitmapIndex);
    WriteRect(BoundsRect);
    WriteClassName(BorderClass);
    if HasBorderColoration then
      WriteRect(TRect(FCellSideColors));
    WriteInteger(BorderColor);
    WriteInteger(Color);
    WriteInteger(ContentBkColor);
    WriteClassName(ContentPattern);
    WriteInteger(FontIndex);
    Write(Format, SizeOf(Format));
  end;
end;

function TdxReportVisualItem.GetAbsoluteOrigin: TPoint;
var
  Item: TdxReportVisualItem;
  Origin: TPoint;
begin
  Result := NullPoint;
  Item := Self;
  while Item <> nil do
  begin
    Origin := Item.GetOrigin;
    Inc(Result.X, Origin.X);
    Inc(Result.Y, Origin.Y);
    Item := Item.Parent;
  end;
end;

function TdxReportVisualItem.GetAbsoluteRect: TRect;
begin
  with Result do
  begin
    TopLeft := AbsoluteOrigin;
    Right := Left + Width;
    Bottom := Top + Height;
  end;
end;

function TdxReportVisualItem.GetBackgroundBitmap: TBitmap;
begin
  Result := BackgroundBitmapPool[BackgroundBitmapIndex];
end;  

function TdxReportVisualItem.GetBackgroundBitmapHeight: Integer;
begin
  Result := BackgroundBitmap.Height * Renderer.UnitsPerPixel;
end;

function TdxReportVisualItem.GetBackgroundBitmapPool: TdxPSBackgroundBitmapPool;
begin
  if (ReportCells <> nil) and (ReportCells.ReportLink <> nil) then 
    Result := ReportCells.ReportLink.BackgroundBitmapPool
  else
    Result := nil;  
end;

function TdxReportVisualItem.GetBackgroundBitmapTileOrigin: TPoint;
begin
  Result := AbsoluteOrigin;
  Result.X := -Result.X;
  Result.Y := -Result.Y;
end;

function TdxReportVisualItem.GetBackgroundBitmapTileStartIndexX: Integer;
begin
  Result := Abs(BackgroundBitmapTileOrigin.X) div BackgroundBitmapWidth;
end;

function TdxReportVisualItem.GetBackgroundBitmapTileStartIndexY: Integer;
begin
  Result := Abs(BackgroundBitmapTileOrigin.Y) div BackgroundBitmapHeight;
end;

function TdxReportVisualItem.GetBackgroundBitmapTileStopIndexX: Integer;
begin
  Result := (Width + Abs(BackgroundBitmapTileOrigin.X)) div BackgroundBitmapWidth;
end;

function TdxReportVisualItem.GetBackgroundBitmapTileStopIndexY: Integer;
begin
  Result := (Height + Abs(BackgroundBitmapTileOrigin.Y)) div BackgroundBitmapHeight;
end;

function TdxReportVisualItem.GetBackgroundBitmapWidth: Integer;
begin
  Result := BackgroundBitmap.Width * Renderer.UnitsPerPixel;
end;

function TdxReportVisualItem.GetBorderBrush: HBRUSH;
begin
  Result := Renderer.GetBrushByColor(BorderColor);
end;

function TdxReportVisualItem.GetBorderColor: TColor;
begin
  Result := FBorderColor;
  if Result = clDefault then Result := ReportCells.BorderColor;
end;

function TdxReportVisualItem.GetCellSides: TdxCellSides;
begin
  Result := TdxCellSides(Byte(Format and dxPSGlbl.dxFormatRect));
end;

function TdxReportVisualItem.GetCellSideColors(ASide: TdxCellSide): TColor;
begin
  Result := FCellSideColors[ASide]; 
end;

function TdxReportVisualItem.GetContentBrush: HBRUSH;
begin
  Result := dxPSFillPatternFactory.Items[ContentPattern, IsPrinting].Brush.Handle;
end;

function TdxReportVisualItem.GetEdge3DSoft: Boolean;
begin
  Result := BorderClass.Edge3DSoft;
end;

function TdxReportVisualItem.GetEdge3DStyle: TdxCellEdgeStyle;
begin
  Result := BorderClass.Edge3DStyle;
end;

function TdxReportVisualItem.GetEdgeMode: TdxCellEdgeMode;
begin
  Result := BorderClass.EdgeMode;
end;

function TdxReportVisualItem.GetExcludeFromClipRgn: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExcludeFromClipRgn);
end;

function TdxReportVisualItem.GetFont: TFont;
begin
  if (FontIndex <> -1) and (ReportCells <> nil) then
    Result := ReportCells.GetFontByIndex(FontIndex)
  else
    Result := nil;
end;

function TdxReportVisualItem.GetHeight: Integer;
begin
  with BoundsRect do 
    Result := Bottom - Top;
end;

function TdxReportVisualItem.GetIsPrinting: Boolean;
begin
  Result := Renderer.IsPrinting;
end;

function TdxReportVisualItem.GetLeft: Integer;
begin
  Result := BoundsRect.Left;
end;

function TdxReportVisualItem.GetLineThickness: Integer;
begin
  Result := Renderer.LineThickness;
end;

function TdxReportVisualItem.GetOrigin: TPoint;
begin
  Result := BoundsRect.TopLeft;
end;

function TdxReportVisualItem.GetParentBrush: HBRUSH;
begin
  Result := Renderer.GetBrushByColor(ParentColor);
end;

function TdxReportVisualItem.GetParentColor: TColor;
var
  ItemParent: TdxReportCell;
begin
  ItemParent := Parent;
  while (ItemParent <> nil) and ItemParent.Transparent do 
    ItemParent := ItemParent.Parent;

  if ItemParent <> nil then 
    Result := ItemParent.Color
  else
    Result := clNone;
end;

function TdxReportVisualItem.GetRenderer: TdxPSReportRenderer;
begin
  Result := ReportCells.Renderer;
end;

function TdxReportVisualItem.GetShadowBrush: HBRUSH;
begin
  Result := Renderer.GetBrushByColor(ShadowColor);
end;

function TdxReportVisualItem.GetShowShadow: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatShowShadow); 
end;

function TdxReportVisualItem.GetTop: Integer;
begin
  Result := BoundsRect.Top;
end;

function TdxReportVisualItem.GetTransparent: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatTransparent);
end;

function TdxReportVisualItem.GetWidth: Integer;
begin
  with BoundsRect do 
    Result := Right - Left;
end;

function TdxReportVisualItem.GetVisible: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatVisible);
end;

procedure TdxReportVisualItem.SetBackgroundBitmapIndex(Value: Integer);
begin
  if Value < -1 then Value := -1;
  FBackgroundBitmapIndex := Value;
end;

procedure TdxReportVisualItem.SetBorderClass(Value: TdxPSCellBorderClass);
begin
  if Value = nil then Value := TdxPSCellUltraFlatBorder;
  FBorderClass := Value;
end;

procedure TdxReportVisualItem.SetBoundsRect(const Value: TRect);
begin
  with Value do 
    SetBounds(Left, Top, Right - Left, Bottom - Top);
end;

procedure TdxReportVisualItem.SetCellSides(Value: TdxCellSides);
begin
  if CellSides <> Value then
    Format := Format and not dxPSGlbl.dxFormatRect or Byte(Value);
end;

procedure TdxReportVisualItem.SetCellSideColors(
  ASide: TdxCellSide; AValue: TColor);
begin
  FCellSideColors[ASide] := AValue;
end;

procedure TdxReportVisualItem.SetColor(Value: TColor);
begin
  FColor := ColorToRGB(Value);
end;

procedure TdxReportVisualItem.SetEdge3DSoft(Value: Boolean);
begin
  BorderClass := MapBorderClass(EdgeMode, Edge3DStyle, Value);
end;

procedure TdxReportVisualItem.SetEdge3DStyle(Value: TdxCellEdgeStyle);
begin
  BorderClass := MapBorderClass(EdgeMode, Value, Edge3DSoft);
end;

procedure TdxReportVisualItem.SetEdgeMode(Value: TdxCellEdgeMode);
begin
  BorderClass := MapBorderClass(Value, Edge3DStyle, Edge3DSoft);
end;

procedure TdxReportVisualItem.SetExcludeFromClipRgn(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExcludeFromClipRgn, Value);
end;

procedure TdxReportVisualItem.SetFont(Value: TFont);
begin
  if ReportCells <> nil then
    FontIndex := ReportCells.GetIndexByFont(Value);
end;

procedure TdxReportVisualItem.SetFormat(Value: DWORD);
begin
  FFormat := Value;
end;

procedure TdxReportVisualItem.SetHeight(Value: Integer);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TdxReportVisualItem.SetLeft(Value: Integer);
begin
  SetBounds(Value, Top, Width, Height);
end;

procedure TdxReportVisualItem.SetOrigin(const Value: TPoint);
begin
  SetBounds(Value.X, Value.Y, Width, Height);
end;

procedure TdxReportVisualItem.SetShowShadow(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatShowShadow, Value);
end;

procedure TdxReportVisualItem.SetTop(Value: Integer);
begin
  SetBounds(Left, Value, Width, Height);
end;

procedure TdxReportVisualItem.SetTransparent(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatTransparent, Value);
end;

procedure TdxReportVisualItem.SetWidth(Value: Integer);
begin
  SetBounds(Left, Top, Value, Height);
end;

procedure TdxReportVisualItem.SetVisible(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatVisible, Value);
end;

{  TdxReportCell }

destructor TdxReportCell.Destroy;
begin
  SetParent(nil);
  ClearDataItems;
  ClearCells;
  inherited Destroy;
end;

procedure TdxReportCell.Assign(Source: TPersistent);

  procedure DoAssign(ASource, ADest: TdxReportCell);
  var
    I: Integer;
    DestCell: TdxReportCell;
  begin
    for I := 0 to ASource.CellCount - 1 do
    begin
      DestCell := TdxReportCell.Create(ADest);
      DestCell.Assign(ASource.Cells[I]);
    end;
      
    for I := 0 to ASource.DataItemCount - 1 do
      ASource.DataItems[I].Clone(ADest);
  end;

begin
  if (Source is TdxReportCell) and (Source <> Self) then
  begin
    ClearAll;
    inherited;
    DoAssign(TdxReportCell(Source), Self);
  end
  else
    inherited;
end;

procedure TdxReportCell.DrawContent(DC: HDC; DrawRect: TRect; const OriginRect: TRect; 
  AStage: TdxPSRenderStages);
var
  R: TRect;
  ContentRgn, Rgn: HRGN;
begin
  if ClipChildren then
  begin
    R := DrawRect;
    Dec(R.Left, BorderClass.Thickness * LineThickness);  // BorderClass.Thickness - v3.2
    Dec(R.Top, BorderClass.Thickness * LineThickness);   // BorderClass.Thickness - v3.2
    ContentRgn := Renderer.IntersectClipRect(R);
  end
  else
    ContentRgn := Renderer.GetClipRgn;
    
  try  
    Rgn := Renderer.GetClipRgn;  
    if ExcludeNestedItems(DC, OriginRect) <> NULLREGION then 
    begin
      DrawItself(DC, AStage);
      DrawNestedDataItems(DC, OriginRect, AStage);
    end;
    Renderer.RestoreClipRgn(Rgn);
    
    DrawNestedCells(DC, DrawRect, OriginRect, AStage);
    //DrawNestedDataItems(DC, OriginRect, AStage);
  finally
    Renderer.RestoreClipRgn(ContentRgn);
  end;
end;

procedure TdxReportCell.DrawItself(DC: HDC; AStage: TdxPSRenderStages);
begin
  if rsFirstPass in AStage then 
  begin
    if IsBackgroundBitmapDrawn then 
      DrawBackgroundBitmap(DC)
    else
      if IsBackgroundDrawn then 
        DrawBackground(DC);
        
    if IsBordersDrawn then DrawBorders(DC);
  end;
end;

procedure TdxReportCell.DrawNestedCells(DC: HDC; DrawRect: TRect; const OriginRect: TRect; 
  AStage: TdxPSRenderStages);
var
  I: Integer;
  R: TRect;
begin
  for I := 0 to CellCount - 1 do
    with Cells[I] do
      if Visible then 
      begin
        DrawRect := BoundsRect;
        if {RectVisible(DC, DrawRect) and }IntersectRect(R, GetAbsoluteRect, OriginRect) then
          with BoundsRect do
          begin
            if (Left <> 0) or (Top <> 0) then OffsetWindowOrgEx(DC, -Left, -Top, nil);
            OffsetRect(DrawRect, -Left, -Top);
            DrawContent(DC, DrawRect, OriginRect, AStage);
            if (Left <> 0) or (Top <> 0) then OffsetWindowOrgEx(DC, Left, Top, nil);
          end;
      end;    
end;

procedure TdxReportCell.DrawNestedDataItems(DC: HDC; const OriginRect: TRect; AStage: TdxPSRenderStages);

  function PrepareCustomDraw(AnItem: TAbstractdxReportCellData): TAbstractdxReportCellData;
  begin
    Result := TAbstractdxReportCellData(AnItem.Clone(nil));
    Renderer.PrepareCanvasForCustomDraw(AnItem.Font, AnItem.Color);
  end;

  procedure UnprepareCustomDraw(AnItem: TAbstractdxReportCellData; var ASavedItem: TAbstractdxReportCellData);
  begin
    if AnItem.FontIndex = -1 then
      with ReportCells.GetFontByIndex(ASavedItem.FontIndex) do
      begin
        SelectObject(DC, Handle);
        SetTextColor(DC, ColorToRGB(Color));
      end;
    AnItem.Assign(ASavedItem);
    FreeAndNil(ASavedItem);
    Renderer.UnprepareCanvasForCustomDraw;
  end;

var
  I: Integer;
  Item, SavedItem: TAbstractdxReportCellData;
  IsCustomDrawn: Boolean;
begin
  for I := DataItemCount - 1 downto 0 do
  begin
    Item := DataItems[I];
    if Item.IsDrawingNeeded(DC, AStage, OriginRect) then
    begin
      SavedItem := nil;
      IsCustomDrawn := Item.IsCustomDrawn;
      if IsCustomDrawn then SavedItem := PrepareCustomDraw(Item);
      try
        if not Item.CustomDraw(DC) then Item.DrawContent(DC, AStage);
      finally
        if IsCustomDrawn then UnprepareCustomDraw(Item, SavedItem);
      end;
    end;
  end;
end;

function TdxReportCell.ExcludeNestedItems(DC: HDC; const OriginRect: TRect): Integer;

  procedure ExcludeNestedCells(DC: HDC; const OriginRect: TRect; var AResult: Integer);
  var
    I: Integer;                      
  begin
    for I := 0 to CellCount - 1 do
      with Cells[I] do
      begin
        DoExcludeFromClipRgn(DC, OriginRect, AResult);
        if AResult = NULLREGION then Break;
      end;
  end;

  procedure ExcludeNestedDataItems(DC: HDC; const OriginRect: TRect; var AResult: Integer);
  var
    I: Integer;
  begin
    for I := 0 to DataItemCount - 1 do
      with DataItems[I] do
      begin
        DoExcludeFromClipRgn(DC, OriginRect, AResult);
        if AResult = NULLREGION then Break;
      end;
  end;
  
begin
  Result := SIMPLEREGION;
  ExcludeNestedCells(DC, OriginRect, Result);
  if Result <> NULLREGION then
    ExcludeNestedDataItems(DC, OriginRect, Result);
end;

function TdxReportCell.GetBorderOuterBounds(DC: HDC): TRect;
begin
//  Result := GetOuterBounds(DC);
  Result := BoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  Result := GetBorderOuterBoundsRelativeTo(DC, GetOuterBoundsRelativeTo(DC, Result));
end;

function TdxReportCell.GetInnerBounds(DC: HDC): TRect;
begin
  Result := BoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  Result := GetInnerBoundsRelativeTo(DC, Result);
end;

function TdxReportCell.GetOuterBounds(DC: HDC): TRect;
begin
  Result := BoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  Result := GetOuterBoundsRelativeTo(DC, Result);
end;

function TdxReportCell.MeasureHeight(DC: HDC): Integer;
begin
  Result := Height;
end;
 
function TdxReportCell.MeasureWidth(DC: HDC): Integer;
begin
  Result := Width;
end;

procedure TdxReportCell.InsertCell(AnItem: TdxReportCell);
begin
  CellListNeeded;
  FCellList.Add(AnItem);
  AnItem.FReportCells := FReportCells;
end;

procedure TdxReportCell.InsertDataItem(AnItem: TdxReportItem);
begin
  DataListNeeded;
  FDataList.Add(AnItem);
end;

procedure TdxReportCell.InsertItem(AnItem: TdxReportItem);
begin
  if AnItem.IsCell then              
    InsertCell(AnItem.AsCell)
  else
    InsertDataItem(AnItem);
  AnItem.FParent := Self;
end;

procedure TdxReportCell.MoveCell(ACurIndex, ANewIndex: Integer);
begin
  FCellList.Move(ACurIndex, ANewIndex);
end;

procedure TdxReportCell.MoveDataItem(ACurIndex, ANewIndex: Integer);
begin
  FDataList.Move(ACurIndex, ANewIndex);
end;

procedure TdxReportCell.MoveItem(AnItem: TdxReportItem; ACurIndex, ANewIndex: Integer);
begin
  if AnItem.IsCell then
    MoveCell(ACurIndex, ANewIndex)
  else
    MoveDataItem(ACurIndex, ANewIndex);
end;

procedure TdxReportCell.RemoveCell(AnItem: TdxReportCell);
begin
  if FCellList <> nil then
  begin
    FCellList.Remove(AnItem);
    CellListRelease;
  end
end;

procedure TdxReportCell.RemoveDataItem(AnItem: TdxReportItem);
begin
  if FDataList <> nil then
  begin
    FDataList.Remove(AnItem);
    DataListRelease;
  end;
end;

procedure TdxReportCell.RemoveItem(AnItem: TdxReportItem);
begin
  if AnItem.IsCell then
    RemoveCell(AnItem.AsCell)
  else
    RemoveDataItem(AnItem);
  AnItem.FParent := nil;
end;

procedure TdxReportCell.SetClipChildren(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatClipChildren, Value);
end;

function TdxReportCell.GetAbsoluteIndex: Integer;
var
  Cell: TdxReportCell;
begin
  Cell := Self;
  Result := 0;
  while Cell <> nil do
  begin
    Inc(Result, Cell.Index);
    Cell := Cell.Parent;
  end;
end;

function TdxReportCell.GetLevel: Integer;
var
  Cell: TdxReportCell;
begin
  Result := 0;
  Cell := Parent;
  while Cell <> nil do
  begin
    Inc(Result);
    Cell := Cell.Parent;
  end;
end;

procedure TdxReportCell.AllocateSpaceForCells(ACapacity: Integer);
begin
  CellListNeeded;
  if ACapacity > FCellList.Capacity then FCellList.Capacity := ACapacity;
end;

procedure TdxReportCell.AllocateSpaceForDatas(ACapacity: Integer);
begin
  DataListNeeded;
  if ACapacity > FDataList.Capacity then FDataList.Capacity := ACapacity;
end;

function TdxReportCell.GetReportCells: TdxReportCells;
begin
  Result := FReportCells;
end;

procedure TdxReportCell.CellListNeeded;
begin
  if FCellList = nil then FCellList := TList.Create;
end;

procedure TdxReportCell.CellListRelease;
begin
  if CellCount = 0 then FreeAndNil(FCellList);
end;

procedure TdxReportCell.DataListNeeded;
begin
  if FDataList = nil then FDataList := TList.Create;
end;

procedure TdxReportCell.DataListRelease;
begin
  if DataItemCount = 0 then FreeAndNil(FDataList);
end;

procedure TdxReportCell.ClearAll;
begin
  ClearCells;
  ClearDataItems;
end;

procedure TdxReportCell.ClearCells;
begin
  if FCellList <> nil then
  begin
    while CellCount > 0 do Cells[CellCount - 1].Free;
    CellListRelease;
  end;
end;

procedure TdxReportCell.ClearDataItems;
begin
  if FDataList <> nil then
  begin
    while DataItemCount > 0 do DataItems[DataItemCount - 1].Free;
    DataListRelease;
  end;
end;

function TdxReportCell.GetCell(Index: Integer): TdxReportCell;
begin
  Result := TdxReportCell(FCellList[Index]);
end;

function TdxReportCell.GetClipChildren: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatClipChildren);
end;

function TdxReportCell.GetCellCount: Integer;
begin
  if FCellList <> nil then
    Result := FCellList.Count
  else
    Result := 0;
end;

function TdxReportCell.GetDataItem(Index: Integer): TAbstractdxReportCellData;
begin
  Result := TAbstractdxReportCellData(FDataList[Index]);
end;

function TdxReportCell.GetIsTopLevel: Boolean;
begin
  Result := Level = 1;
end;

function TdxReportCell.GetDataItemCount: Integer;
begin
  if FDataList <> nil then
    Result := FDataList.Count
  else
    Result := 0;
end;

function TdxReportCell.IndexOf(AnItem: TdxReportItem): Integer;
begin
  Result := -1;
  if AnItem.IsCell then
  begin
    if FCellList <> nil then
      Result := FCellList.IndexOf(AnItem)
  end
  else
    if FDataList <> nil then
      Result := FDataList.IndexOf(AnItem);
end;
                    
class function TdxReportCell.IsCell: Boolean;
begin
  Result := True; 
end;

procedure TdxReportCell.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  ReadProperties(AReader);
  ReadCells(AReader);
  ReadDataItems(AReader);
end;

procedure TdxReportCell.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  WriteProperties(AWriter);
  WriteCells(AWriter);
  WriteDataItems(AWriter);
end;

procedure TdxReportCell.ReadCells(AReader: TdxPSDataReader);

  procedure LoadCell;
  var
    CellClassName: string;
    CellClass: TdxReportCellClass;
    Cell: TdxReportCell;
  begin
    CellClassName := AReader.ReadString;
    CellClass := TdxReportCellClass(GetClass(CellClassName));
    if CellClass = nil then
      Assert(CellClass <> nil);
    if CellClass <> nil then 
    begin
      Cell := CellClass.Create(Self);
      Cell.ReadData(AReader);
    end;  
  end;  
  
begin
  ClearCells;
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do LoadCell;
  finally
    AReader.ReadListEnd;
  end;
end;

procedure TdxReportCell.ReadDataItems(AReader: TdxPSDataReader);

  procedure LoadDataItem;
  var
    DataItemClassName: string;
    DataItemClass: TdxReportCellDataClass;
    DataItem: TAbstractdxReportCellData;
  begin
    try
    DataItemClassName := AReader.ReadString;
    DataItemClass := TdxReportCellDataClass(GetClass(DataItemClassName));
    Assert(DataItemClass <> nil);
    except
      ShowMessage(DataItemClassName);
      raise;
    end;
    if DataItemClass <> nil then
    begin
      DataItem := DataItemClass.Create(Self);
      DataItem.ReadData(AReader);
    end;  
  end;
  
begin
  ClearDataItems;
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do 
      LoadDataItem;
  finally
    AReader.ReadListEnd;
  end;  
end;

procedure TdxReportCell.ReadProperties(AReader: TdxPSDataReader);
begin
end;

procedure TdxReportCell.WriteCells(AWriter: TdxPSDataWriter);
var
  I: Integer;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to CellCount - 1 do 
      with Cells[I] do 
        if Serializable then 
        begin 
          AWriter.WriteString(ClassName);
          WriteData(AWriter);
        end;  
  finally
    AWriter.WriteListEnd;
  end;      
end;

procedure TdxReportCell.WriteDataItems(AWriter: TdxPSDataWriter);
var
  I: Integer;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to DataItemCount - 1 do 
      with DataItems[I] do 
        if Serializable then 
        begin
          AWriter.WriteString(ClassName);
          WriteData(AWriter);
        end;  
  finally
    AWriter.WriteListEnd;
  end;  
end;

procedure TdxReportCell.WriteProperties(AWriter: TdxPSDataWriter);
begin
end;

function TdxReportCell.AddCell: TdxReportCell;
begin
  Result := TdxReportCell.Create(Self);
end;

function TdxReportCell.AddDataItem(AClass: TdxReportCellDataClass): TAbstractdxReportCellData;
begin
  Result := AClass.Create(Self);
end;

procedure TdxReportCell.DeleteCell(Index: Integer);
var
  Cell: TdxReportCell;
begin
  Cell := Cells[Index];
  Cell.Parent := nil;
end;

procedure TdxReportCell.DeleteDataItem(Index: Integer);
var
  DataItem: TAbstractdxReportCellData;
begin
  DataItem := DataItems[Index];
  DataItem.Parent := nil;
end;

function TdxReportCell.LastCell: TdxReportCell;
begin
  if CellCount > 0 then
    Result := TdxReportCell(FCellList.Last)
  else
    Result := nil;
end;

function TdxReportCell.FirstCell: TdxReportCell;
begin
  if CellCount > 0 then
    Result := TdxReportCell(FCellList.First)
  else
    Result := nil;
end;

function TdxReportCell.HasChildren: Boolean;
begin
  Result := CellCount > 0;
end;

procedure TdxReportCell.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
var
  I: Integer;
begin
  for I := 0 to DataItemCount - 1 do
    DataItems[I].ConvertCoords(PixelsNumerator, PixelsDenominator);
  for I := 0 to CellCount - 1 do
    Cells[I].ConvertCoords(PixelsNumerator, PixelsDenominator);
  inherited;
end;

function TdxReportCell.GetBackgroundBitmapTileBounds(Col, Row: Integer): TRect;
begin
  Result := inherited GetBackgroundBitmapTileBounds(Col, Row);
  OffsetRect(Result, -Left, -Top);
end;

function TdxReportCell.GetBackgroundBounds(DC: HDC): TRect;
var
  R: TRect;
begin
  R := BoundsRect;
  OffsetRect(R, -R.Left, -R.Top);
  Result := GetInnerBoundsRelativeTo(DC, R);
end;

function TdxReportCell.GetBorderBounds(DC: HDC): TRect;
begin
  Result := inherited GetBorderBounds(DC);
  OffsetRect(Result, -Result.Left, -Result.Top);
end;

{ TdxPSReportGroupLookAndFeelPainter }

constructor TdxPSReportGroupLookAndFeelPainter.Create(ARenderer: TdxPSReportRenderer); 
begin
  inherited Create;
  FRenderer := ARenderer;
end;

procedure TdxPSReportGroupLookAndFeelPainter.Paint(DC: HDC);
begin
end;

procedure TdxPSReportGroupLookAndFeelPainter.DrawBorders(DC: HDC);
begin
end;

procedure TdxPSReportGroupLookAndFeelPainter.DrawCaptionText(DC: HDC);
var
  R: TRect;
begin
  R := LookAndFeel.GetCaptionTextBounds(Group);
  if RectVisible(DC, R) then
    Renderer.DrawText(DC, R, 1, 0, 0, Group.CaptionText, LookAndFeel.CaptionFont, 
      LookAndFeel.GetCaptionColor, Group.CaptionAlignment, taCenterY, not Group.CaptionTransparent, 
      False, False, False, False, True);
end;

procedure TdxPSReportGroupLookAndFeelPainter.Initialize(ALookAndFeel: TdxPSReportGroupLookAndFeel; 
  AGroup: TdxReportGroup); 
begin
  FGroup := AGroup;
  FLookAndFeel := ALookAndFeel;
end;

function TdxPSReportGroupLookAndFeelPainter.Group: TdxReportGroup;
begin
  Result := FGroup;
end;

function TdxPSReportGroupLookAndFeelPainter.LookAndFeel: TdxPSReportGroupLookAndFeel;
begin
  Result := FLookAndFeel;
end;

{ TdxPSReportGroupLookAndFeel }

constructor TdxPSReportGroupLookAndFeel.Create(AReportCells: TdxReportCells);
begin
  inherited Create;
  FReportCells := AReportCells;
  FCaptionFontIndex := -1;
  FCaptionHeight := 0;
  FCaptionIndent := dxDefaultReportGroupCaptionIndent;
  FColor := dxDefaultGroupColor;
  FFontIndex := -1;
end;

procedure TdxPSReportGroupLookAndFeel.Assign(Source: TPersistent);
begin
  if Source is TdxPSReportGroupLookAndFeel then 
    with TdxPSReportGroupLookAndFeel(Source) do 
    begin
      Self.CaptionFontIndex := CaptionFontIndex;
      Self.FCaptionIndent := CaptionIndent;
      Self.Color := Color;
      Self.FontIndex := FontIndex;
    end
  else
    inherited;
end;

class function TdxPSReportGroupLookAndFeel.BorderClass: TdxPSCellBorderClass;
begin
  Result := TdxPSCellEtchedBorder;
end;

class function TdxPSReportGroupLookAndFeel.DefaultBorderSides: TdxCellSides;
begin
  Result := csAll;
end;

class function TdxPSReportGroupLookAndFeel.Name: string;
begin
  Result := '';
end;

class procedure TdxPSReportGroupLookAndFeel.Register;
begin
  if GetClass(ClassName) = nil then RegisterClass(Self);
end;

class procedure TdxPSReportGroupLookAndFeel.Unregister;
begin
end;

procedure TdxPSReportGroupLookAndFeel.Paint(DC: HDC; AGroup: TdxReportGroup);
begin
  with GetPainter do 
  begin
    Initialize(Self, AGroup);
    Paint(DC);
  end;  
end;

procedure TdxPSReportGroupLookAndFeel.Prepare(DC: HDC);
begin
  FCaptionHeight := 2 * Renderer.CalcTextPatternHeight(DC, CaptionFont) div 2;
end;

procedure TdxPSReportGroupLookAndFeel.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  FCaptionHeight := MulDiv(FCaptionHeight, APixelsNumerator, APixelsDenominator);
  FCaptionIndent := MulDiv(FCaptionIndent, APixelsNumerator, APixelsDenominator);
end;

procedure TdxPSReportGroupLookAndFeel.ReadData(AReader: TdxPSDataReader);
begin
  FCaptionHeight := AReader.ReadInteger;
  CaptionFontIndex := AReader.ReadInteger;
  FCaptionIndent := AReader.ReadInteger;
  Color := AReader.ReadInteger;
  Data := Pointer(AReader.ReadInteger);
  FontIndex := AReader.ReadInteger;
end;

procedure TdxPSReportGroupLookAndFeel.WriteData(AWriter: TdxPSDataWriter);
begin
  AWriter.WriteInteger(FCaptionHeight);
  AWriter.WriteInteger(CaptionFontIndex);
  AWriter.WriteInteger(CaptionIndent);
  AWriter.WriteInteger(Color);
  AWriter.WriteInteger(Integer(Data));
  AWriter.WriteInteger(FontIndex);
end;

function TdxPSReportGroupLookAndFeel.GetBorderEdgeThickness(AGroup: TdxReportGroup; 
  ASide: TdxCellSide): Integer;
begin
  if ASide = csTop then
  begin
    Result := BorderThickness;
    if Renderer.IsRendering and (Renderer.LineThickness <> 0) then 
      Result := Result * Renderer.LineThickness;
    if AGroup.ShowCaption then 
      Inc(Result, GetCaptionAreaHeight(AGroup));
    if Renderer.IsRendering and (Renderer.LineThickness <> 0) then 
      Result := Result div Renderer.LineThickness;
  end
  else
    Result := AGroup.InternalGetBorderEdgeThickness(ASide);
end;                                         

function TdxPSReportGroupLookAndFeel.GetBorderThickness: Integer; 
begin
  Result := 0;
end;

function TdxPSReportGroupLookAndFeel.GetColor: TColor;
begin
  Result := FColor;
  if Result = clDefault then Result := ReportCells.GroupColor;
end;

procedure TdxPSReportGroupLookAndFeel.SetBorderThickness(Value: Integer);
begin
end;

function TdxPSReportGroupLookAndFeel.GetCaptionAreaHeight(AGroup: TdxReportGroup): Integer;
begin
  Result := GetCaptionHeight(AGroup);
end;

function TdxPSReportGroupLookAndFeel.GetCaptionBounds(AGroup: TdxReportGroup): TRect;
begin
  Result := AGroup.BoundsRect;
  Result.Bottom := Result.Top + GetCaptionHeight(AGroup);
end;

function TdxPSReportGroupLookAndFeel.GetCaptionColor: TColor;
begin
  Result := Color;
end;

function TdxPSReportGroupLookAndFeel.GetCaptionHeight(AGroup: TdxReportGroup): Integer;
begin
  Result := FCaptionHeight;
end;

function TdxPSReportGroupLookAndFeel.GetCaptionIndent: Integer;
begin
  Result := FCaptionIndent;
end;

function TdxPSReportGroupLookAndFeel.GetCaptionLeftRestSpaceBounds(AGroup: TdxReportGroup): TRect;
begin
  if not AGroup.Transparent then 
  begin
    Result := GetCaptionBounds(AGroup);
    Result.Right := GetCaptionTextBounds(AGroup).Left;
  end
  else
    Result := dxPSGlbl.NullRect;  
end;

function TdxPSReportGroupLookAndFeel.GetCaptionRightRestSpaceBounds(AGroup: TdxReportGroup): TRect;
begin
  if not AGroup.Transparent then 
  begin
    Result := GetCaptionBounds(AGroup);
    Result.Left := GetCaptionTextBounds(AGroup).Right;
  end
  else
    Result := dxPSGlbl.NullRect;  
end;

function TdxPSReportGroupLookAndFeel.GetCaptionTextBounds(AGroup: TdxReportGroup): TRect;
var
  TextWidth: Integer;
begin
  Result := NullRect;
  if AGroup.ShowCaption then
  begin
    TextWidth := AGroup.CaptionTextWidth;
    if TextWidth <> 0 then 
    begin
      Result := AGroup.BoundsRect;
      OffsetRect(Result, -Result.Left, -Result.Top);
      InflateRect(Result, -CaptionIndent, 0);

      if not IsRectEmpty(Result) then 
        with Result do 
        begin
          case AGroup.CaptionAlignment of 
            taLeft:
              Right := Left + TextWidth;
            taCenterX:
              begin
                Inc(Left, (Right - Left - TextWidth) div 2);
                Right := Left + TextWidth;
              end;  
            taRight:
              Left := Right - TextWidth;
          end;
          Bottom := Top + GetCaptionHeight(AGroup);
        end;
    end;    
  end;  
end;    

function TdxPSReportGroupLookAndFeel.GetPainter: TdxPSReportGroupLookAndFeelPainter;    
begin
  Result := Renderer.GetReportGroupLookAndFeelPainter(GetPainterClass);
end;

class function TdxPSReportGroupLookAndFeel.GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass;
begin
  Result := nil; // Actually method must be declared as "abstract" but "C++" syntax does not allow us to use "static virtual abstract" methods
end;

function TdxPSReportGroupLookAndFeel.GetCaptionFont: TFont;
begin
  if CaptionFontIndex <> -1 then 
    Result := ReportCells.GetFontByIndex(CaptionFontIndex)
  else
    Result := nil;  
end;

function TdxPSReportGroupLookAndFeel.GetFont: TFont;
begin
  if FontIndex <> -1 then 
    Result := ReportCells.GetFontByIndex(FontIndex)
  else
    Result := nil;  
end;

function TdxPSReportGroupLookAndFeel.GetRenderer: TdxPSReportRenderer;
begin
  Result := ReportCells.Renderer;
end; 

procedure TdxPSReportGroupLookAndFeel.SetCaptionFont(Value: TFont);
begin
  CaptionFontIndex := ReportCells.GetIndexByFont(Value);
end;

procedure TdxPSReportGroupLookAndFeel.SetCaptionFontIndex(Value: Integer);
begin
  if Value < -1 then Value := -1;
  FCaptionFontIndex := Value;
end;

procedure TdxPSReportGroupLookAndFeel.SetFont(Value: TFont);
begin
  FontIndex := ReportCells.GetIndexByFont(Value);
end;

procedure TdxPSReportGroupLookAndFeel.SetFontIndex(Value: Integer);
begin
  if Value < -1 then Value := -1;
  FFontIndex := Value;
end;

{ TdxPSReportGroupNullLookAndFeelPainter }

procedure TdxPSReportGroupNullLookAndFeelPainter.Paint(DC: HDC);
begin
end;

{ TdxPSReportGroupNullLookAndFeel }

class function TdxPSReportGroupNullLookAndFeel.BorderClass: TdxPSCellBorderClass;
begin
  Result := TdxPSCellUltraFlatBorder;
end;

class function TdxPSReportGroupNullLookAndFeel.DefaultBorderSides: TdxCellSides;
begin
  Result := [];
end;

class function TdxPSReportGroupNullLookAndFeel.Name: string;
begin
  Result := cxGetResourceString(@sdxReportGroupNullLookAndFeel);
end;

function TdxPSReportGroupNullLookAndFeel.GetBorderThickness: Integer;
begin
  Result := 1;
end;

function TdxPSReportGroupNullLookAndFeel.GetCaptionHeight(AGroup: TdxReportGroup): Integer;
begin
  Result := 0;
end;

class function TdxPSReportGroupNullLookAndFeel.GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass;
begin
  Result := TdxPSReportGroupNullLookAndFeelPainter;
end;
  
{ TdxPSReportGroupStandardLookAndFeelPainter }

procedure TdxPSReportGroupStandardLookAndFeelPainter.Paint(DC: HDC);
var
  Rgn: HRGN;
begin
  DrawCaptionRestSpace(DC);
  DrawCaptionText(DC);
  if Group.IsBordersDrawn then
  begin
    Rgn := Renderer.ExcludeClipRect(LookAndFeel.GetCaptionTextBounds(Group));
    DrawBorders(DC);
    Renderer.RestoreClipRgn(Rgn);
  end;  
end;

procedure TdxPSReportGroupStandardLookAndFeelPainter.DrawBorders(DC: HDC);
begin
  Group.InternalDrawBorders(DC);
end;

procedure TdxPSReportGroupStandardLookAndFeelPainter.DrawCaptionRestSpace(DC: HDC);

  procedure DrawCaptionPart(const R: TRect);
  begin
    if RectVisible(DC, R) then 
      Renderer.FillRect(DC, R, LookAndFeel.Color);
  end;
  
begin
  DrawCaptionPart(LookAndFeel.GetCaptionLeftRestSpaceBounds(Group));
  DrawCaptionPart(LookAndFeel.GetCaptionRightRestSpaceBounds(Group));
end;

function TdxPSReportGroupStandardLookAndFeelPainter.LookAndFeel: TdxPSReportGroupStandardLookAndFeel;
begin
  Result := inherited LookAndFeel as TdxPSReportGroupStandardLookAndFeel;
end;

{ TdxPSReportGroupStandardLookAndFeel }

class function TdxPSReportGroupStandardLookAndFeel.BorderClass: TdxPSCellBorderClass;
begin
  Result := TdxPSCellEtchedBorder;
end;

class function TdxPSReportGroupStandardLookAndFeel.Name: string;
begin
  Result := cxGetResourceString(@sdxReportGroupStandardLookAndFeel);
end;

class function TdxPSReportGroupStandardLookAndFeel.GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass;
begin
  Result := TdxPSReportGroupStandardLookAndFeelPainter;
end;

{ TdxPSReportGroupOfficeLookAndFeel }

class function TdxPSReportGroupOfficeLookAndFeel.DefaultBorderSides: TdxCellSides;
begin
  Result := [csTop];
end;

class function TdxPSReportGroupOfficeLookAndFeel.Name: string;
begin
  Result := cxGetResourceString(@sdxReportGroupOfficeLookAndFeel);
end;

function TdxPSReportGroupOfficeLookAndFeel.GetCaptionIndent: Integer;
begin
  Result := 0;
end;

{ TdxPSReportGroupWebLookAndFeelPainter }

procedure TdxPSReportGroupWebLookAndFeelPainter.Paint(DC: HDC);
begin
  DrawBorders(DC);
  DrawCaptionText(DC);
  DrawCaptionSeparator(DC);
end;

procedure TdxPSReportGroupWebLookAndFeelPainter.DrawBorders(DC: HDC);
var
  R: TRect;
begin
  R := Group.BoundsRect;
  OffsetRect(R, -R.Left, -R.Top);
  Renderer.FrameRect(DC, R, LookAndFeel.BorderColor, Group.CellSides, LookAndFeel.BorderThickness);
end;

procedure TdxPSReportGroupWebLookAndFeelPainter.DrawCaptionSeparator(DC: HDC);
var
  R: TRect;
begin
  R := LookAndFeel.GetCaptionSeparatorBounds(Group);
  if RectVisible(DC, R) then
    Renderer.FillRect(DC, R, LookAndFeel.CaptionSeparatorColor);
end;

function TdxPSReportGroupWebLookAndFeelPainter.LookAndFeel: TdxPSReportGroupWebLookAndFeel; 
begin
  Result := inherited LookAndFeel as TdxPSReportGroupWebLookAndFeel;
end;

{ TdxPSReportGroupWebLookAndFeel }

constructor TdxPSReportGroupWebLookAndFeel.Create(AReportCells: TdxReportCells);
begin
  inherited Create(AReportCells);
  BorderColor := clDefault;
  BorderThickness := 1;
  CaptionColor := clDefault;
  CaptionSeparatorColor := clDefault;
  CaptionSeparatorThickness := 0;
end;

procedure TdxPSReportGroupWebLookAndFeel.Assign(Source: TPersistent);
begin
  if Source is TdxPSReportGroupWebLookAndFeel then
    with TdxPSReportGroupWebLookAndFeel(Source) do 
    begin
      Self.BorderColor := BorderColor;
      Self.BorderThickness := BorderThickness;
      Self.CaptionColor := CaptionColor;
      Self.CaptionSeparatorColor := CaptionSeparatorColor;
      Self.CaptionSeparatorThickness := CaptionSeparatorThickness;
    end;
  inherited;
end;

class function TdxPSReportGroupWebLookAndFeel.BorderClass: TdxPSCellBorderClass;
begin
  Result := TdxPSCellUltraFlatBorder;
end;
    
class function TdxPSReportGroupWebLookAndFeel.Name: string;
begin
  Result := cxGetResourceString(@sdxReportGroupWebLookAndFeel);
end;

procedure TdxPSReportGroupWebLookAndFeel.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited;
  CaptionSeparatorThickness := MulDiv(CaptionSeparatorThickness, APixelsNumerator, APixelsDenominator);
end;

procedure TdxPSReportGroupWebLookAndFeel.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  BorderColor := AReader.ReadInteger;
  BorderThickness := AReader.ReadInteger;
  CaptionColor := AReader.ReadInteger;
  CaptionSeparatorColor := AReader.ReadInteger;
  CaptionSeparatorThickness := AReader.ReadInteger;
end;

procedure TdxPSReportGroupWebLookAndFeel.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteInteger(BorderColor);
  AWriter.WriteInteger(BorderThickness);
  AWriter.WriteInteger(CaptionColor);
  AWriter.WriteInteger(CaptionSeparatorColor);
  AWriter.WriteInteger(CaptionSeparatorThickness);
end;

function TdxPSReportGroupWebLookAndFeel.GetBorderEdgeThickness(AGroup: TdxReportGroup; 
  ASide: TdxCellSide): Integer;
begin
  if ASide = csTop then 
    Result := inherited GetBorderEdgeThickness(AGroup, ASide)
  else
    Result := BorderThickness;
end;

function TdxPSReportGroupWebLookAndFeel.GetBorderThickness: Integer;
begin
  Result := FBorderThickness;
end;

procedure TdxPSReportGroupWebLookAndFeel.SetBorderThickness(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FBorderThickness := Value;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionAreaHeight(AGroup: TdxReportGroup): Integer;
begin
  Result := inherited GetCaptionAreaHeight(AGroup) + CaptionSeparatorThickness;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionBounds(AGroup: TdxReportGroup): TRect;
begin
  if AGroup.ShowCaption then 
  begin
    Result := AGroup.BoundsRect;
    OffsetRect(Result, -Result.Left, -Result.Top);
    InflateRect(Result, -BorderThickness * Renderer.LineThickness, -BorderThickness * Renderer.LineThickness);
    Result.Bottom := Result.Top + GetCaptionHeight(AGroup);
  end
  else
    Result := NullRect;  
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionLeftRestSpaceBounds(AGroup: TdxReportGroup): TRect;
begin
  Result := NullRect;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionRightRestSpaceBounds(AGroup: TdxReportGroup): TRect;
begin
  Result := NullRect;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionSeparatorBounds(AGroup: TdxReportGroup): TRect;
begin
  Result := GetCaptionBounds(AGroup);
  if AGroup.ShowCaption then 
  begin
    Result.Top := Result.Bottom;
    Result.Bottom := Result.Top + CaptionSeparatorThickness;
  end;  
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionTextBounds(AGroup: TdxReportGroup): TRect; 
begin
  Result := GetCaptionBounds(AGroup);
end;

class function TdxPSReportGroupWebLookAndFeel.GetPainterClass: TdxPSReportGroupLookAndFeelPainterClass;
begin
  Result := TdxPSReportGroupWebLookAndFeelPainter;
end;

function TdxPSReportGroupWebLookAndFeel.GetBorderColor: TColor;
begin
  Result := FBorderColor;
  if Result = clDefault then Result := ReportCells.GroupBorderColor;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionColor: TColor;
begin
  Result := FCaptionColor;
  if Result = clDefault then Result := ReportCells.GroupCaptionColor;
end;

function TdxPSReportGroupWebLookAndFeel.GetCaptionSeparatorColor: TColor;
begin
  Result := FCaptionSeparatorColor;
  if Result = clDefault then Result := ReportCells.GroupCaptionSeparatorColor;
end;

procedure TdxPSReportGroupWebLookAndFeel.SetCaptionSeparatorThickness(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FCaptionSeparatorThickness := Value;
end;

{ TdxReportGroup }

constructor TdxReportGroup.Create(AParent: TdxReportCell); 
begin
  inherited Create(AParent);
  CaptionAlignment := taLeft;
  ClipChildren := True;
  ShowCaption := True;
end;

procedure TdxReportGroup.Assign(Source: TPersistent);
begin
  if Source is TdxReportGroup then 
  begin
    inherited;
    with TdxReportGroup(Source) do 
    begin
      Self.CaptionText := CaptionText;
      Self.LookAndFeel := LookAndFeel;
    end;  
  end
  else
    inherited;
end; 

procedure TdxReportGroup.DrawBorders(DC: HDC);
begin
  if LookAndFeel <> nil then
    LookAndFeel.Paint(DC, Self)
  else
    inherited DrawBorders(DC);  
end;

procedure TdxReportGroup.CalculateCaptionTextWidth(DC: HDC); 
var
  F: TFont;
begin
  FCaptionTextWidth := 0;
  if CaptionText <> '' then 
  begin
    if LookAndFeel <> nil then
      F := LookAndFeel.CaptionFont
    else
      F := Font;
      
    FCaptionTextWidth := Renderer.CalcTextWidth(DC, CaptionText, F);
    if FCaptionTextWidth > 0 then 
      Inc(FCaptionTextWidth, 2 + 2);
  end;  
end;

function TdxReportGroup.GetBorderOuterBounds(DC: HDC): TRect;
begin
  Result := inherited GetBorderOuterBounds(DC);
  if ShowCaption and (LookAndFeel <> nil) then 
    Inc(Result.Top, LookAndFeel.GetCaptionHeight(Self) div 2);
end;

procedure TdxReportGroup.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer); 
begin
  inherited;
  FCaptionTextWidth := MulDiv(FCaptionTextWidth, APixelsNumerator, APixelsDenominator);
end;

procedure TdxReportGroup.InternalDrawBorders(DC: HDC);
begin
  inherited DrawBorders(DC);
end;

function TdxReportGroup.GetBorderClass: TdxPSCellBorderClass;
begin
  if UseOwnBorderClass or (LookAndFeel = nil) then
    Result := inherited GetBorderClass
  else
    Result := LookAndFeel.BorderClass;
end;

function TdxReportGroup.GetBorderEdgeSalient(ASide: TdxCellSide; ASalient: TdxPSCellBorderSalientType): Integer; 
begin
  if LookAndFeel <> nil then
    if ASalient = bstOuter then
      Result := 0
    else
      Result := GetBorderEdgeThickness(ASide)
  else
    Result := inherited GetBorderEdgeSalient(ASide, ASalient);
end;

function TdxReportGroup.GetBorderEdgeThickness(ASide: TdxCellSide): Integer;
begin
  if LookAndFeel <> nil then
    Result := LookAndFeel.GetBorderEdgeThickness(Self, ASide)
  else
    Result := inherited GetBorderEdgeThickness(ASide);
end;

function TdxReportGroup.InternalGetBorderEdgeThickness(ASide: TdxCellSide): Integer;
begin
  Result := inherited GetBorderEdgeThickness(ASide);
end;

function TdxReportGroup.IsBordersDrawn: Boolean;
begin
  Result := inherited IsBordersDrawn or (CaptionText <> '');
end;

procedure TdxReportGroup.ReadData(AReader: TdxPSDataReader);
var
  Index: Integer;
begin
  inherited ReadData(AReader);
  CaptionText := AReader.ReadString;
  FCaptionTextWidth := AReader.ReadInteger;
  
  Index := AReader.ReadInteger;
  if Index <> -1 then 
    LookAndFeel := ReportCells.LookAndFeels[Index];
end;

procedure TdxReportGroup.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteString(CaptionText);
  AWriter.WriteInteger(CaptionTextWidth);
  AWriter.WriteInteger(LookAndFeelIndex);
end;

function TdxReportGroup.GetCaptionAlignment: TcxTextAlignX;
begin
  Result := TcxTextAlignX((Format and dxPSGlbl.dxFormatTextAlignXMask) shr dxPSGlbl.dxFormatTextAlignXOffset);
end;

function TdxReportGroup.GetCaptionTextWidth: Integer;
begin
  Result := FCaptionTextWidth;
end;

function TdxReportGroup.GetCaptionTransparent: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatGroupCaptionTransparent);
end;

function TdxReportGroup.GetLookAndFeel: TdxPSReportGroupLookAndFeel;
begin
  Result := FLookAndFeel;
  if Result = nil then 
    if Parent is TdxReportGroup then 
      Result := TdxReportGroup(Parent).LookAndFeel
    else
      Result := ReportCells.LookAndFeel;
end;

function TdxReportGroup.GetLookAndFeelIndex: Integer;
begin
  if FLookAndFeel <> nil then 
    Result := ReportCells.IndexOfReportGroupLookAndFeel(LookAndFeel)
  else
    Result := -1;
end;

function TdxReportGroup.GetShowCaption: Boolean;
begin                                            
  Result := GetFormatBit(dxPSGlbl.dxFormatGroupShowCaption);
end;

function TdxReportGroup.GetUseOwnBorderClass: Boolean;
begin                                            
  Result := GetFormatBit(dxPSGlbl.dxFormatOwnBorderClass);
end;

procedure TdxReportGroup.SetCaptionAlignment(Value: TcxTextAlignX);
begin
  Format := Format and not dxPSGlbl.dxFormatTextAlignXMask or (Byte(Value) shl dxPSGlbl.dxFormatTextAlignXOffset);
end;

procedure TdxReportGroup.SetCaptionTransparent(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatGroupCaptionTransparent, Value);
end;

procedure TdxReportGroup.SetLookAndFeel(Value: TdxPSReportGroupLookAndFeel);
begin
  FLookAndFeel := Value;
end;

procedure TdxReportGroup.SetShowCaption(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatGroupShowCaption, Value);
end;

procedure TdxReportGroup.SetUseOwnBorderClass(Value: Boolean);
begin                                            
  SetFormatBit(dxPSGlbl.dxFormatOwnBorderClass, Value);
end;

{ TdxReportCells }

constructor TdxReportCells.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;  
    
  BorderColor := dxDefaultGridLineColor;
  BorderWidth := 1;
  ExpandButtonBorderColor := dxDefaultExpandButtonBorderColor;
  GroupBorderColor := dxDefaultGroupBorderColor;
  GroupCaptionColor := dxDefaultGroupCaptionColor;
  GroupCaptionSeparatorColor := dxDefaultGroupCaptionSeparatorColor;
  GroupColor := dxDefaultGroupColor;
  ShadowColor := dxDefaultShadowColor;
  ShadowDepth := dxDefaultShadowDepth;
  TreeLineColor := dxDefaultTreeLineColor;
  TreeLineStyle := tlsDot;

  FLookAndFeels := TList.Create;
  FLookAndFeel := CreateGroupLookAndFeel(dxDefaultReportGroupLookAndFeel);
  CreateGroupLookAndFeel(TdxPSReportGroupNullLookAndFeel);

  FImageLists := TList.Create;
  
  FCells := TdxReportCell.Create(nil);
  FCells.FReportCells := Self;
  FCells.Color := dxDefaultContentColor;
end;

destructor TdxReportCells.Destroy;
begin
  FreeAndNil(FCells);
  FreeAndNilReportGroupLookAndFeels;
  FreeAndNil(FFooterCells);
  FreeAndNil(FHeaderCells);
  FreeAndNilOverlays;
  FreeAndNilImageLists;
  inherited;
end;

procedure TdxReportCells.Assign(Source: TPersistent);
begin
  if Source is TdxReportCells then
    with TdxReportCells(Source) do
    begin
      Self.BorderColor := BorderColor;
      Self.BorderWidth := BorderWidth;
      Self.ExpandButtonBorderColor := ExpandButtonBorderColor;
      Self.GroupBorderColor := GroupBorderColor;
      Self.GroupCaptionColor := GroupCaptionColor;
      Self.GroupCaptionSeparatorColor := GroupCaptionSeparatorColor;
      Self.GroupColor := GroupColor;
      Self.ShadowColor := ShadowColor;
      Self.ShadowDepth := ShadowDepth;
      Self.TreeLineColor := TreeLineColor;
      Self.TreeLineStyle := TreeLineStyle;

      Self.Cells.Assign(Cells);
      if AreHeaderCellsAllocated then Self.HeaderCells.Assign(HeaderCells);
      if AreFooterCellsAllocated then Self.FooterCells.Assign(FooterCells);
      if HasOverlays then Self.AssignOverlays(TdxReportCells(Source));
    end
  else
    inherited;
end;

procedure TdxReportCells.ClearItems;
begin
  FCells.ClearCells;
  FCells.ClearDataItems;
end;

procedure TdxReportCells.ClearLookAndFeels;
var
  I: Integer;
begin
  for I := 0 to LookAndFeelCount - 1 do 
    LookAndFeels[I].Free;
  FLookAndFeels.Clear;  
end;

function TdxReportCells.CreateGroupLookAndFeel(AClass: TdxPSReportGroupLookAndFeelClass; 
  ACheckExisting: Boolean = True): TdxPSReportGroupLookAndFeel;
begin
  if ACheckExisting then
    Result := FindGroupLookAndFeelByClass(AClass)
  else
    Result := nil;
    
  if Result = nil then
  begin
    Result := AClass.Create(Self);
    FLookAndFeels.Add(Result);
  end;  
end;

function TdxReportCells.FindGroupLookAndFeelByClass(AClass: TdxPSReportGroupLookAndFeelClass): TdxPSReportGroupLookAndFeel;
var
  I: Integer;
begin
  for I := 0 to LookAndFeelCount - 1 do 
  begin
    Result := LookAndFeels[I];
    if Result.ClassType = AClass then Exit;
  end;  
  Result := nil;
end;

function TdxReportCells.FindGroupLookAndFeelByData(AData: Pointer): TdxPSReportGroupLookAndFeel;
var
  I: Integer;
begin
  for I := 0 to LookAndFeelCount - 1 do 
  begin
    Result := LookAndFeels[I];
    if Result.Data = AData then Exit;
  end;  
  Result := nil;
end;

function TdxReportCells.IndexOfReportGroupLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel): Integer;
begin
  Result := FLookAndFeels.IndexOf(ALookAndFeel);
end;

procedure TdxReportCells.DoProgress(const APercentDone: Double);
begin
  if ReportLink <> nil then ReportLink.DoProgress(APercentDone);
end;

function TdxReportCells.AddOverlay: TdxReportCell;
begin
  Result := TdxReportCell.Create(nil);
  Result.FReportCells := Self;
  if FOverlays = nil then FOverlays := TList.Create;
  FOverlays.Add(Result);
end;

procedure TdxReportCells.AppendOverlays(Source: TdxReportCells; 
  AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
  
  procedure OffsetOverlayCells(AnOverlay: TdxReportCell; AnOffsetX, AnOffsetY: Integer);
  var
    I: Integer;
  begin
    if (AnOffsetX <> 0) or (AnOffsetY <> 0) then 
      for I := 0 to AnOverlay.CellCount - 1 do 
        with AnOverlay.Cells[I] do
        begin
          Left := Left + AnOffsetX;
          Top := Top + AnOffsetY;
        end;  
  end;
  
  procedure OffsetOverlayDataItems(AnOverlay: TdxReportCell; AnOffsetX, AnOffsetY: Integer);
  var
    I: Integer;
  begin
    if (AnOffsetX <> 0) or (AnOffsetY <> 0) then 
      for I := 0 to AnOverlay.DataItemCount - 1 do 
        with AnOverlay.DataItems[I] do
        begin
          Left := Left + AnOffsetX;
          Top := Top + AnOffsetY;
        end;  
  end;

var
  I: Integer;
  Overlay: TdxReportCell;
begin
  for I := 0 to Source.OverlayCount - 1 do
  begin
    Overlay := AddOverlay;
    Overlay.Assign(Source.Overlays[I]);
    OffsetOverlayCells(Overlay, AnOffsetX, AnOffsetY);
    OffsetOverlayDataItems(Overlay, AnOffsetX, AnOffsetY);
  end;  
end;

procedure TdxReportCells.AssignOverlays(Source: TdxReportCells; 
  AnOffsetX: Integer = 0; AnOffsetY: Integer = 0);
begin
  ClearOverlays;
  AppendOverlays(Source, AnOffsetX, AnOffsetY);
end;

procedure TdxReportCells.ClearOverlays;
var
  I: Integer;
begin
  for I := 0 to OverlayCount - 1 do
    Overlays[I].Free;
  if FOverlays <> nil then
    FOverlays.Clear;  
end;

procedure TdxReportCells.DeleteOverlay(AnOverlay: TdxReportCell);
var
  Index: Integer;
begin
  Index := IndexOfOverlay(AnOverlay);
  if Index <> -1 then 
  begin
    Overlays[Index].Free;
    if OverlayCount = 0 then FreeAndNil(FOverlays);
  end;  
end;

procedure TdxReportCells.FreeAndNilOverlays;
begin
  ClearOverlays;
  FreeAndNil(FOverlays);  
end;

function TdxReportCells.HasOverlays: Boolean;
begin
  Result := FOverlays <> nil;
end;

function TdxReportCells.IndexOfOverlay(AnOverlay: TdxReportCell): Integer;
begin                                      
  if HasOverlays then 
    Result := FOverlays.IndexOf(AnOverlay)
  else
    Result := -1;
end;

function TdxReportCells.GetFontByIndex(AnIndex: Integer): TFont;
begin
  Result := ReportLink.FontPool[AnIndex];
end;

function TdxReportCells.GetIndexByFont(AFont: TFont): Integer;
begin
  Result := ReportLink.FontPool.Add(AFont);
end;

procedure TdxReportCells.ReadData(AReader: TdxPSDataReader);
begin
  BeforeReadData(AReader);
  try
    ClearItems;
    try
      ReadLookAndFeels(AReader);
      ReadCells(AReader);
      ReadFooterCells(AReader);
      ReadHeaderCells(AReader);
      ReadOverlayCells(AReader);
      ReadProperties(AReader);
    except
      ClearItems;
      raise;
    end;  
  finally
    AfterReadData(AReader);
  end;  
end;

procedure TdxReportCells.WriteData(AWriter: TdxPSDataWriter);
begin
  BeforeWriteData(AWriter);
  try
    WriteLookAndFeels(AWriter);
    WriteCells(AWriter);
    WriteFooterCells(AWriter);
    WriteHeaderCells(AWriter);
    WriteOverlayCells(AWriter);
    WriteProperties(AWriter);
  finally
    AfterWriteData(AWriter);
  end;  
end;
    
procedure TdxReportCells.AfterReadData(AReader: TdxPSDataReader);
begin
end;

procedure TdxReportCells.AfterWriteData(AWriter: TdxPSDataWriter);
begin
  ClearImageLists;
end;

procedure TdxReportCells.BeforeReadData(AReader: TdxPSDataReader);
begin
  ClearImageLists;
  OwnImageLists := True;
  ReadImageLists(AReader);
end;

procedure TdxReportCells.BeforeWriteData(AWriter: TdxPSDataWriter);
begin        
  ClearImageLists;
  OwnImageLists := False;
  GetImageLists;
  WriteImageLists(AWriter);
end;

procedure TdxReportCells.ReadCells(AReader: TdxPSDataReader);
begin
  Cells.ReadData(AReader);     
end;

procedure TdxReportCells.ReadFooterCells(AReader: TdxPSDataReader);
begin
  if AReader.ReadBoolean then FooterCells.ReadData(AReader);
end;

procedure TdxReportCells.ReadHeaderCells(AReader: TdxPSDataReader);
begin
  if AReader.ReadBoolean then HeaderCells.ReadData(AReader);
end;

procedure TdxReportCells.ReadImageLists(AReader: TdxPSDataReader);
var
  ImageList: TImageList;
begin
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do 
    begin
      ImageList := TImageList.Create(nil);
      AReader.ReadImageList(ImageList);
      FImageLists.Add(Imagelist);
    end;   
  finally
    AReader.ReadListEnd;
  end;
end;

procedure TdxReportCells.ReadLookAndFeels(AReader: TdxPSDataReader);
var
  LookAndFeelClass: TdxPSReportGroupLookAndFeelClass;
  Index: Integer;
begin
  ClearLookAndFeels;
  
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do
    begin
      LookAndFeelClass := AReader.ReadLookAndFeelClass;
      CreateGroupLookAndFeel(LookAndFeelClass, False).ReadData(AReader);
    end;  
  finally
    AReader.ReadListEnd;
  end;
  Index := AReader.ReadInteger;
  if Index <> -1 then
    LookAndFeel := LookAndFeels[Index]
  else
    LookAndFeel := nil;  
    
  {if LookAndFeelCount = 0 then
  begin
    FLookAndFeel := CreateGroupLookAndFeel(dxDefaultReportGroupLookAndFeel);
    CreateGroupLookAndFeel(TdxPSReportGroupNullLookAndFeel);
  end
  else
    FLookAndFeel := LookAndFeels[0];}
end;

procedure TdxReportCells.ReadOverlayCells(AReader: TdxPSDataReader);
begin
  ClearOverlays;
  AReader.ReadListBegin;
  try
    while not AReader.EndOfList do
      AddOverlay.ReadData(AReader);
  finally
    AReader.ReadListEnd;
  end;
end;
                            
procedure TdxReportCells.ReadProperties(AReader: TdxPSDataReader);
begin
  with AReader do 
  begin
    BorderColor := ReadInteger;
    BorderWidth := ReadInteger;
    ExpandButtonBorderColor := ReadInteger;
    GroupBorderColor := ReadInteger;
    GroupCaptionColor := ReadInteger;
    GroupCaptionSeparatorColor := ReadInteger;
    GroupColor := ReadInteger;
    ShadowColor := ReadInteger;
    ShadowDepth := ReadInteger;
    TreeLineColor := ReadInteger;
    TreeLineStyle := TdxPSTreeLineStyle(ReadInteger);
  end;  
end;

procedure TdxReportCells.WriteCells(AWriter: TdxPSDataWriter);
begin
  Cells.WriteData(AWriter);
end;
  
procedure TdxReportCells.WriteFooterCells(AWriter: TdxPSDataWriter);
begin
  AWriter.WriteBoolean(AreFooterCellsAllocated);
  if AreFooterCellsAllocated then FooterCells.WriteData(AWriter);
end;
  
procedure TdxReportCells.WriteHeaderCells(AWriter: TdxPSDataWriter);
begin
  AWriter.WriteBoolean(AreHeaderCellsAllocated);
  if AreHeaderCellsAllocated then HeaderCells.WriteData(AWriter);
end;  

procedure TdxReportCells.WriteImageLists(AWriter: TdxPSDataWriter);
var
  I: Integer;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to FImageLists.Count - 1 do
      AWriter.WriteImageList(TCustomImageList(FImageLists[I]));
  finally    
    AWriter.WriteListEnd;
  end;    
end;

procedure TdxReportCells.WriteLookAndFeels(AWriter: TdxPSDataWriter);
var
  I: Integer;
  LookAndFeel: TdxPSReportGroupLookAndFeel;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to LookAndFeelCount - 1 do
    begin
      LookAndFeel := LookAndFeels[I];
      AWriter.WriteClassName(LookAndFeel);
      LookAndFeel.WriteData(AWriter);
    end;  
  finally
    AWriter.WriteListEnd;
  end;
  
  AWriter.WriteInteger(IndexOfReportGroupLookAndFeel(Self.LookAndFeel));
end;

procedure TdxReportCells.WriteOverlayCells(AWriter: TdxPSDataWriter);
var
  I: Integer;
begin
  AWriter.WriteListBegin;
  try
    for I := 0 to OverlayCount - 1 do
      Overlays[I].WriteData(AWriter);
  finally
    AWriter.WriteListEnd;
  end;
end;
         
procedure TdxReportCells.WriteProperties(AWriter: TdxPSDataWriter);
begin
  with AWriter do 
  begin
    WriteInteger(BorderColor);
    WriteInteger(BorderWidth);
    WriteInteger(ExpandButtonBorderColor);
    WriteInteger(GroupBorderColor);
    WriteInteger(GroupCaptionColor);
    WriteInteger(GroupCaptionSeparatorColor);
    WriteInteger(GroupColor);
    WriteInteger(ShadowColor);
    WriteInteger(ShadowDepth);
    WriteInteger(TreeLineColor);
    WriteInteger(Integer(TreeLineStyle));
  end;  
end;

function TdxReportCells.CalculateOverlaysHeight: Integer;
var
  I, V: Integer;
begin
  Result := 0;
  for I := 0 to OverlayCount - 1 do
  begin
    V := Overlays[I].GetAbsoluteRect.Bottom;
    if Result < V then Result := V;
  end;  
end;

function TdxReportCells.CalculateOverlaysWidth: Integer;
var
  I, V: Integer;
begin
  Result := 0;
  for I := 0 to OverlayCount - 1 do
  begin
    V := Overlays[I].GetAbsoluteRect.Right;
    if Result < V then Result := V;
  end;  
end;

function TdxReportCells.CalculateTotalHeight: Integer;
var
  V: Integer;
begin
  Result := Cells.Height;
  V := CalculateOverlaysHeight;
  if Result < V then Result := V;
end;

function TdxReportCells.CalculateTotalWidth: Integer;
var
  V: Integer;
begin
  Result := Cells.Width;
  V := CalculateOverlaysWidth;
  if Result < V then Result := V;
end;

procedure TdxReportCells.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
var
  I: Integer;
begin
  Cells.ConvertCoords(APixelsNumerator, APixelsDenominator);
  ShadowDepth := MulDiv(ShadowDepth, APixelsNumerator, APixelsDenominator);

  for I := 0 to LookAndFeelCount - 1 do
    LookAndFeels[I].ConvertCoords(APixelsNumerator, APixelsDenominator);
    
  if AreFooterCellsAllocated then
    FFooterCells.ConvertCoords(APixelsNumerator, APixelsDenominator);
  if AreHeaderCellsAllocated then 
    HeaderCells.ConvertCoords(APixelsNumerator, APixelsDenominator);

  if HasOverlays then
    for I := 0 to OverlayCount - 1 do 
      Overlays[I].ConvertCoords(APixelsNumerator, APixelsDenominator);  
end;

function TdxReportCells.GetCellTopLevelParent(AnItem: TdxReportItem): TdxReportCell;

  function IsParentInTopLevels(AnItem: TdxReportItem): Boolean;
  var 
    I: Integer;
  begin
    Result := (AnItem = Cells) or 
      (AreHeaderCellsAllocated and (AnItem = HeaderCells)) or 
      (AreFooterCellsAllocated and (AnItem = FooterCells));

    if not Result then
      for I := 0 to OverlayCount - 1 do
      begin
        Result := AnItem = Overlays[I];
        if Result then Exit;
      end;   
  end;

begin
  Result := AnItem.Parent;
  if Result <> nil then 
    while (Result.Parent <> nil) and not IsParentInTopLevels(Result.Parent) do
      Result := Result.Parent;
end;
procedure TdxReportCells.FreeAndNilReportGroupLookAndFeels;
begin
  ClearLookAndFeels;
  FreeAndNil(FLookAndFeels); 
end;

procedure TdxReportCells.PrepareReportGroupsLookAndFeels(DC: HDC);
var
  I: Integer;
begin
  for I := 0 to LookAndFeelCount - 1 do
    LookAndFeels[I].Prepare(DC);
end;

procedure TdxReportCells.AddImageList(AnImageList: TCustomImageList);
begin
  if (AnImageList <> nil) and (FImageLists.IndexOf(AnImageList) = -1) then 
    FImageLists.Add(AnImageList);
end;

procedure TdxReportCells.ClearImageLists;
var
  I: Integer;
begin
  if OwnImageLists then 
    for I := 0 to ImageListCount - 1 do
      ImageLists[I].Free; 
  FImageLists.Clear;
end;

procedure TdxReportCells.FreeAndNilImageLists;
begin
  ClearImageLists;
  FreeAndNil(FImageLists);  
end;

procedure TdxReportCells.GetImageLists;
begin
  ReportLink.GetImageLists(AddImageList);
end;

function TdxReportCells.IndexOfImageList(AnImageList: TCustomImageList): Integer;
begin
  Result := FImageLists.IndexOf(AnImageList);
end;

function TdxReportCells.GetAreFooterCellsAllocated: Boolean;
begin
  Result := FFooterCells <> nil;
end;

function TdxReportCells.GetAreHeaderCellsAllocated: Boolean;
begin
  Result := FHeaderCells <> nil;
end;

function TdxReportCells.GetBoundsRect: TRect;
begin
  Result := Cells.BoundsRect;
end;

function TdxReportCells.GetCount: Integer;
begin
  Result := Cells.CellCount;
end;

function TdxReportCells.GetFooterCells: TdxReportCell;
begin
  if not AreFooterCellsAllocated then CreateFooterCells;
  Result := FFooterCells;
end;

function TdxReportCells.GetHeaderCells: TdxReportCell;
begin
  if not AreHeaderCellsAllocated then CreateHeaderCells;
  Result := FHeaderCells;
end;

function TdxReportCells.GetImageList(Index: Integer): TCustomImageList;
begin
  if Index = -1 then 
    Result := nil
  else
    Result := TCustomImageList(FImageLists[Index]);
end;

function TdxReportCells.GetImageListCount: Integer;
begin
  if FImageLists <> nil then 
    Result := FImageLists.Count
  else
    Result := 0;  
end;

function TdxReportCells.GetLookAndFeel(Index: Integer): TdxPSReportGroupLookAndFeel;
begin
  Result := TdxPSReportGroupLookAndFeel(FLookAndFeels[Index]);
end;

function TdxReportCells.GetLookAndFeelCount: Integer;
begin
  Result := FLookAndFeels.Count;
end;

function TdxReportCells.GetOverlay(Index: Integer): TdxReportCell;
begin
  if HasOverlays then 
    Result := TdxReportCell(FOverlays[Index])
  else
    Result := nil;
end;

function TdxReportCells.GetOverlayCount: Integer;
begin
  if HasOverlays then
    Result := FOverlays.Count
  else
    Result := 0;
end;

function TdxReportCells.GetRenderer: TdxPSReportRenderer;
begin
  Result := ReportLink.Renderer;
end;

procedure TdxReportCells.SetBorderColor(Value: TColor);
begin
  if Value = clDefault then 
    FBorderColor := dxDefaultGridLineColor
  else
    FBorderColor := ColorToRGB(Value);
end;

procedure TdxReportCells.SetShadowColor(Value: TColor);
begin
  if Value = clDefault then 
    FShadowColor := dxDefaultShadowColor
  else
    FShadowColor := ColorToRGB(Value);
end;

procedure TdxReportCells.SetShadowDepth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FShadowDepth := Value;
end;

procedure TdxReportCells.SetTreeLineColor(Value: TColor);
begin
  if Value = clDefault then 
    FTreeLineColor := dxDefaultTreeLineColor
  else
    FTreeLineColor := ColorToRGB(Value);
end;

procedure TdxReportCells.CreateFooterCells;
begin
  FFooterCells := TdxReportCell.Create(nil);
  FFooterCells.FReportCells := Self;
  FFooterCells.Color := dxDefaultFixedColor;
end;

procedure TdxReportCells.CreateHeaderCells;
begin
  FHeaderCells := TdxReportCell.Create(nil);
  FHeaderCells.FReportCells := Self;
  FHeaderCells.Color := dxDefaultFixedColor;
end;

function TdxReportCells.GetFont: TFont;
begin
  Result := Cells.Font;
end;

function TdxReportCells.GetFooterBoundsRect: TRect;
begin
  if AreFooterCellsAllocated then
    Result := FFooterCells.BoundsRect
  else
    Result := NullRect;
end;

function TdxReportCells.GetHeaderBoundsRect: TRect;
begin
  if AreHeaderCellsAllocated then
    Result := FHeaderCells.BoundsRect
  else
    Result := NullRect;
end;

function TdxReportCells.GetFooterCellCount: Integer;
begin
  if AreFooterCellsAllocated then
    Result := FFooterCells.CellCount
  else
    Result := 0;
end;

function TdxReportCells.GetHeaderCellCount: Integer;
begin
  if AreHeaderCellsAllocated then
    Result := FHeaderCells.CellCount
  else
    Result := 0;
end;

{ TAbstractdxReportCellData }

constructor TAbstractdxReportCellData.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  BreakByChars := dxDefaultBreakByChars;                   // True
  EndEllipsis := dxDefaultEndEllipsis;                     // False
  HidePrefix := dxDefaultHidePrefix;                       // False
  Multiline := dxDefaultMultiline;                         // False
  PreventLeftTextExceed := dxDefaultPreventLeftTextExceed; // True 
  PreventTopTextExceed := dxDefaultPreventTopTextExceed;   // True
  SortOrder := dxDefaultSortOrder;                         // csoNone
  TextAlignX := dxDefaultTextAlignX;                       // taLeft
  TextAlignY := dxDefaultTextAlignY;                       // taCenterY
end;

procedure TAbstractdxReportCellData.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin
  if IsBackgroundBitmapDrawn then
    DrawBackgroundBitmap(DC)
  else
    if IsBackgroundDrawn then
      DrawBackground(DC);

  if IsBordersDrawn then DrawBorders(DC);
end;

function TAbstractdxReportCellData.GetCustomDrawID: Integer;
begin
  Result := Data;
end;

function TAbstractdxReportCellData.MeasureContentHeight(DC: HDC): Integer;
begin
  Result := Height;
end;

function TAbstractdxReportCellData.MeasureContentWidth(DC: HDC): Integer;
begin
  Result := Width;
end;

function TAbstractdxReportCellData.CustomDraw(DC: HDC): Boolean;
begin
  Result := IsCustomDrawn and Renderer.CustomDrawReportItem(Self);
end;

function TAbstractdxReportCellData.GetAbsoluteEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect;
begin
  Result := GetEffectiveBounds(DC, AStage);
  if Parent <> nil then     
    with Parent.AbsoluteOrigin do
      OffsetRect(Result, X, Y);
end;

function TAbstractdxReportCellData.GetDefaultDTFormat: DWORD;
begin
  Result := CXTO_AUTOINDENTS or CXTO_EXPANDTABS or CXTO_PATTERNEDTEXT or CXTO_CHARBREAK or CXTO_EDITCONTROL;
end;

function TAbstractdxReportCellData.GetEffectiveBounds(DC: HDC; AStage: TdxPSRenderStages): TRect;
begin
  Result := GetOuterBounds(DC);
end;

function TAbstractdxReportCellData.GetDTFormat: DWORD;
const
  dxEndEllipsis: array[Boolean] of UINT = (0, CXTO_END_ELLIPSIS);
  dxHidePrefix: array[Boolean] of UINT = (0, CXTO_HIDEPREFIX);
  dxPreventLeftExceed: array[Boolean] of UINT = (0, CXTO_PREVENT_LEFT_EXCEED);
  dxPreventTopExceed: array[Boolean] of UINT = (0, CXTO_PREVENT_TOP_EXCEED);
  dxWordBreak: array[Boolean] of UINT = (CXTO_SINGLELINE, CXTO_WORDBREAK);
begin
  Result := DefaultDTFormat or 
    cxMakeFormat(TextAlignX, TextAlignY) or 
    dxEndEllipsis[EndEllipsis] or
    dxHidePrefix[HidePrefix] or
    dxPreventLeftExceed[PreventLeftTextExceed] or 
    dxPreventTopExceed[PreventTopTextExceed] or 
    dxWordBreak[Multiline];
end;

function TAbstractdxReportCellData.IsCustomDrawn: Boolean;
begin
  with GetReportCells do
    Result := (ReportLink <> nil) and ReportLink.PossibleCustomDraw(Self);
end;

function TAbstractdxReportCellData.IsDrawingNeeded(DC: HDC; AStage: TdxPSRenderStages; 
  const ARect: TRect): Boolean;
begin
  Result := Visible and RectVisible(DC, GetEffectiveBounds(DC, AStage)) and IsDrawn(DC, AStage, ARect);
end;  

function TAbstractdxReportCellData.IsDrawn(DC: HDC; AStage: TdxPSRenderStages; 
  const ARect: TRect): Boolean;
var
  R: TRect;
begin
  Result := IntersectRect(R, GetAbsoluteEffectiveBounds(DC, AStage), ARect);
end;

function TAbstractdxReportCellData.GetSortOrder: TdxCellSortOrder;
begin
  Result := TdxCellSortOrder((Format and dxPSGlbl.dxFormatSortOrderMask) shr dxPSGlbl.dxFormatSortOrderOffset);
end;

function TAbstractdxReportCellData.GetBreakByChars: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatBreakByChars); 
end;

function TAbstractdxReportCellData.GetEndEllipsis: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatEndEllipsis);
end;

function TAbstractdxReportCellData.GetHidePrefix: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatHidePrefix);
end;

function TAbstractdxReportCellData.GetMultiline: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatMultiline);
end;

function TAbstractdxReportCellData.GetPreventLeftTextExceed: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatPreventLeftTextExceed);
end;

function TAbstractdxReportCellData.GetPreventTopTextExceed: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatPreventTopTextExceed);
end;

function TAbstractdxReportCellData.GetTextAlignX: TcxTextAlignX;
begin
  Result := TcxTextAlignX((Format and dxPSGlbl.dxFormatTextAlignXMask) shr dxPSGlbl.dxFormatTextAlignXOffset);
end;

function TAbstractdxReportCellData.GetTextAlignY: TcxTextAlignY;
begin
  Result := TcxTextAlignY((Format and dxPSGlbl.dxFormatTextAlignYMask) shr dxPSGlbl.dxFormatTextAlignYOffset);
end;

procedure TAbstractdxReportCellData.SetBreakByChars(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatBreakByChars, Value); 
end;

procedure TAbstractdxReportCellData.SetEndEllipsis(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatEndEllipsis, Value); 
end;

procedure TAbstractdxReportCellData.SetHidePrefix(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatHidePrefix, Value); 
end;

procedure TAbstractdxReportCellData.SetMultiline(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatMultiline, Value); 
end;

procedure TAbstractdxReportCellData.SetPreventLeftTextExceed(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatPreventLeftTextExceed, Value); 
end;

procedure TAbstractdxReportCellData.SetPreventTopTextExceed(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatPreventTopTextExceed, Value); 
end;

procedure TAbstractdxReportCellData.SetSortOrder(Value: TdxCellSortOrder);
begin
  Format := Format and not dxPSGlbl.dxFormatSortOrderMask or (Byte(Value) shl dxPSGlbl.dxFormatSortOrderOffset);
end;

procedure TAbstractdxReportCellData.SetTextAlignX(Value: TcxTextAlignX);
begin
  Format := Format and not dxPSGlbl.dxFormatTextAlignXMask or (Byte(Value) shl dxPSGlbl.dxFormatTextAlignXOffset);
end;

procedure TAbstractdxReportCellData.SetTextAlignY(Value: TcxTextAlignY);
begin
  Format := Format and not dxPSGlbl.dxFormatTextAlignYMask or (Byte(Value) shl dxPSGlbl.dxFormatTextAlignYOffset);
end;

{ TdxReportCellText }

constructor TdxReportCellText.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  FSortMarkRegionSize := dxSortMarkRgnSize;
end;

procedure TdxReportCellText.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxReportCellText then
  begin
    SetText(TdxReportCellText(Source).GetText);
    Indent := TdxReportCellText(Source).Indent;
  end;
end;

procedure TdxReportCellText.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin

  if IsBackgroundBitmapDrawn then 
    DrawBackgroundBitmap(DC)
  else
    if IsBackgroundDrawn then 
      DrawBackground(DC);

  if IsTextDrawn then DrawText(DC);
  if IsSortMarkDrawn then DrawSortMark(DC);
  if IsBordersDrawn then DrawBorders(DC);
end;

procedure TdxReportCellText.DrawSortMark(DC: HDC);
var
  R: TRect;
begin
  R := GetSortMarkBounds(DC);
  if not IsRectEmpty(R) then 
    Renderer.DrawSortMark(DC, R, SortOrder, EdgeMode = cemPattern);
end;

procedure TdxReportCellText.DrawText(DC: HDC);
var
  R: TRect;
  F: TFont;
  S: string;

  ASaveFont: HFONT;
  ALimit: Integer;
  ATextParams: TcxTextParams;
  AFont: TFont;

  function ExceedBounds: Boolean;
  var
    TextBounds: TRect;
  begin
    TextBounds := R;
    SelectObject(DC, F.Handle);
    Windows.DrawText(DC, PChar(S), -1, TextBounds, DT_CALCRECT);
    Result := (R.Right - R.Left) < (TextBounds.Right - TextBounds.Left);
  end;

begin
  R := GetTextBounds(DC);
  if not IsRectEmpty(R) then
  begin
    S := GetText;
    AFont := GetFont;
    ASaveFont := GetCurrentObject(DC, OBJ_FONT);
    if Multiline or not AdjustFont then
      Renderer.DrawTextEx(DC, R, 0, Indent, 0, S, AFont, DTFormat)
    else
    begin
      SelectObject(DC, AFont.Handle);
      ATextParams := cxCalcTextParams(DC, DTFormat);
      if ATextParams.PatternedText then
        Renderer.DrawTextEx(DC, R, 0, Indent, 0, S, AFont, DTFormat)
      else
      begin
        F := TFont.Create;
        try
          F.Assign(AFont);
          ALimit := MulDiv(F.Size, 2, 3);
          while ExceedBounds and (F.Size > ALimit) do
            F.Size := F.Size - 1;
          SetTextColor(DC, ColorToRgb(AFont.Color));
          Windows.DrawText(DC, PChar(S), -1, R, 0);
        finally
          F.Free;
        end;
      end;
    end;
    SelectObject(DC, ASaveFont);
  end;
end;

function TdxReportCellText.CalculateLineCount(DC: HDC): Integer;
begin
  Result := Renderer.CalcTextLineCount(DC, Text, Font, Width - Indent);
end;

function TdxReportCellText.MeasureContentHeight(DC: HDC): Integer;
var
  R: TRect;
begin
  R := GetTextBounds(DC);
  R := Rect(0, 0, R.Right - R.Left - Indent, 5);
  Result := Renderer.CalcTextRect(DC, Text, R, GetDTFormat or CXTO_CALCROWCOUNT or CXTO_AUTOINDENTS, Font);
  if (SortOrder <> csoNone) and (Result < dxSortMarkRgnSize) then
    Result := dxSortMarkRgnSize;
  if csTop in CellSides then
    Inc(Result, Renderer.LineThickness * BorderEdgeThicknesses[csTop]);
  if csBottom in CellSides then
    Inc(Result, Renderer.LineThickness * BorderEdgeThicknesses[csBottom]);
end;

function TdxReportCellText.MeasureContentWidth(DC: HDC): Integer;
begin
  if Multiline then
    Result := inherited MeasureContentWidth(DC)
  else
    Result := Renderer.CalcTextWidth(DC, Text, Font);
  if SortOrder <> csoNone then
    Inc(Result, dxSortMarkRgnSize);
  if csLeft in CellSides then
    Inc(Result, Renderer.LineThickness * BorderEdgeThicknesses[csLeft]);
  if csRight in CellSides then
    Inc(Result, Renderer.LineThickness * BorderEdgeThicknesses[csRight]);
end;

function TdxReportCellText.MeasureFontHeight(DC: HDC): Integer;
begin
  Result := Renderer.CalcTextPatternHeight(DC, Font);
  if (SortOrder <> csoNone) and (Result < dxSortMarkRgnSize) then
    Result := dxSortMarkRgnSize;
  if Result <> 0 then   
    Inc(Result, MeasureBordersHeight(DC));  
end;

procedure TdxReportCellText.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited ConvertCoords(APixelsNumerator, APixelsDenominator);
  FSortMarkRegionSize := MulDiv(FSortMarkRegionSize, APixelsNumerator, APixelsDenominator);
end;

function TdxReportCellText.GetSortMarkBounds(DC: HDC): TRect;
begin
  Result := GetInnerBounds(DC);
  Result.Left := Result.Right - SortMarkRegionSize;
end;

function TdxReportCellText.GetTextBounds(DC: HDC): TRect;
begin
  Result := GetInnerBounds(DC);
  if IsSortMarkDrawn then
    Result.Right := GetSortMarkBounds(DC).Left;
end;

function TdxReportCellText.IsSortMarkDrawn: Boolean;
begin
  Result := SortOrder <> csoNone;
end;

function TdxReportCellText.IsTextDrawn: Boolean;
begin
  Result := GetText <> '';
end;

procedure TdxReportCellText.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  FIndent := AReader.ReadInteger;
  Text := AReader.ReadString;
end;

procedure TdxReportCellText.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteInteger(Integer(FIndent));
  AWriter.WriteString(Text)
end;

function TdxReportCellText.GetSortMarkRegionSize: Integer;
begin
  if IsSortMarkDrawn then
    Result := FSortMarkRegionSize
  else
    Result := 0;
end;

function TdxReportCellText.GetAdjustFont: Boolean;
begin
  Result := FIndent and dxFormatTextAdjustFont <> 0;
end;

function TdxReportCellText.GetIndent: Integer;
begin
  Result := FIndent and not dxFormatTextAdjustFont;
end;

procedure TdxReportCellText.SetAdjustFont(Value: Boolean);
begin
  Integer(FIndent) := Integer(FIndent) and not dxFormatTextAdjustFont;
  if Value then
    Integer(FIndent) := Integer(FIndent) or dxFormatTextAdjustFont;
end;

procedure TdxReportCellText.SetIndent(Value: Integer);
begin
  FIndent := (FIndent and dxFormatTextAdjustFont) or
    (Cardinal(Value) and not dxFormatTextAdjustFont);
end;

{ TdxReportCellString }

function TdxReportCellString.GetText: string;
begin
  Result := FText;
end;

procedure TdxReportCellString.SetText(const Value: string);
begin
  FText := Value;
end;

{ TdxReportCellImageContainer }
                          
constructor TdxReportCellImageContainer.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  ImageTransparent := True;
end;

procedure TdxReportCellImageContainer.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxReportCellImageContainer then 
    ImageTransparent := TdxReportCellImageContainer(Source).ImageTransparent;
end;

procedure TdxReportCellImageContainer.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin
  if IsBackgroundBitmapDrawn then DrawBackgroundBitmap(DC);
  if IsTextBackgroundDrawn then DrawTextBackground(DC);
  if IsTextDrawn then DrawText(DC);  
  if IsImageBackgroundDrawn then DrawImageBackground(DC);
  if IsImageDrawn then DrawImage(DC);
  if IsSortMarkDrawn then DrawSortMark(DC);
  if IsBordersDrawn then DrawBorders(DC);
end;

procedure TdxReportCellImageContainer.DrawImage(DC: HDC);
begin
end;

procedure TdxReportCellImageContainer.DrawImageBackground(DC: HDC);
begin
  DrawBackgroundRect(DC, GetImageAreaBounds(DC));
end;

procedure TdxReportCellImageContainer.DrawTextBackground(DC: HDC);
var
  R: TRect;
begin
  R := GetTextBounds(DC);
  if IsSortMarkDrawn then
    R.Right := GetSortMarkBounds(DC).Right;
  DrawBackgroundRect(DC, R);
end;

function TdxReportCellImageContainer.GetImageAreaBounds(DC: HDC): TRect;
begin
  Result := GetInnerBounds(DC);
  if IsSortMarkDrawn then 
    Result.Right := GetSortMarkBounds(DC).Left;
end;

function TdxReportCellImageContainer.GetImageBounds(DC: HDC): TRect; 
begin
  Result := dxPSGlbl.NullRect;
end;

procedure TdxReportCellImageContainer.GetImageSizes(var AImageWidth, AImageHeight: Integer);
begin
  AImageWidth := 0;
  AImageHeight := 0;
end;

function TdxReportCellImageContainer.HasImage: Boolean;
begin
  Result := False;
end;

function TdxReportCellImageContainer.IsImageBackgroundDrawn: Boolean;
begin
  Result := inherited IsBackgroundDrawn and not IsImageDrawn and not IsBackgroundBitmapDrawn;
end;

function TdxReportCellImageContainer.IsImageDrawn: Boolean;
begin
  Result := HasImage;
end;

function TdxReportCellImageContainer.IsTextBackgroundDrawn: Boolean;
begin
  Result := not Transparent and not IsBackgroundBitmapDrawn;
end; 

function TdxReportCellImageContainer.GetImageTransparent: Boolean;
begin
  Result := (Format and dxPSGlbl.dxFormatImageTransparent) = dxPSGlbl.dxFormatImageTransparent;
end;

procedure TdxReportCellImageContainer.SetImageTransparent(Value: Boolean);
const
  dxImageTransparent: array[Boolean] of DWORD = (0, dxPSGlbl.dxFormatImageTransparent);
begin
  Format := Format and not dxPSGlbl.dxFormatImageTransparent or dxImageTransparent[Value];
end;

{ TdxReportCellCheck }

constructor TdxCustomReportCellCheck.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  Checked := False;
  //BorderColor := clWindowText;
  ButtonEdgeStyle := cbesUltraFlat;
  CheckPos := dxDefaultCheckPos;
  Enabled := True;
end;

procedure TdxCustomReportCellCheck.DrawCheck(DC: HDC);
var
  R: TRect;
begin
  R := GetCheckBounds(DC);
  if RectVisible(DC, R) then                         
    Renderer.DrawCheckBox(DC, R, Checked, Enabled, IsRadio, ButtonEdgeStyle, BorderColor);
end;

procedure TdxCustomReportCellCheck.DrawImage(DC: HDC);
begin
  DrawCheck(DC);
end;

function TdxCustomReportCellCheck.MeasureContentHeight(DC: HDC): Integer;
var
  TextHeight: Integer;
begin
  Result := 1 + CheckHeight + 1;
  TextHeight := inherited MeasureContentHeight(DC);
  if Result < TextHeight then Result := TextHeight;
end;
  
function TdxCustomReportCellCheck.MeasureContentWidth(DC: HDC): Integer;
begin
  Result := 1 + CheckWidth + 1;
  if CheckPos <> ccpCenter then 
    Inc(Result, inherited MeasureContentWidth(DC));
end;

function TdxCustomReportCellCheck.GetCheckBounds(DC: HDC): TRect;
var
  W, H: Integer;
begin
  Result := GetImageAreaBounds(DC);
  if not IsRectEmpty(Result) then 
  begin
    GetImageSizes(W, H);
    with Result do
    begin
      Inc(Left, (Right - Left - W) div 2);
      Inc(Top, (Bottom - Top - H) div 2);
      Right := Left + W;
      Bottom := Top + H;
    end;  
    FixupRect(DC, Result);
  end;  
end;

function TdxCustomReportCellCheck.GetImageAreaBounds(DC: HDC): TRect;
var
  W, H: Integer;
begin
  GetImageSizes(W, H);
  if (W <> 0) and (H <> 0) then 
  begin
    Result := inherited GetImageAreaBounds(DC);
    with Result do
      case CheckPos of
        ccpLeft:
          Right := Left + W + 2 * Renderer.UnitsPerPixel;
        ccpRight:
          Left := Right - (W + 2 * Renderer.UnitsPerPixel);
      end;    
  end
  else
    Result := dxPSGlbl.NullRect;
end;

function TdxCustomReportCellCheck.GetImageBounds(DC: HDC): TRect; 
begin
  Result := GetCheckBounds(DC);
end;

procedure TdxCustomReportCellCheck.GetImageSizes(var AImageWidth, AImageHeight: Integer);
begin
  AImageWidth := MulDiv(dxPSGlbl.CheckWidth, PixelsNumerator, PixelsDenominator);
  AImageHeight := MulDiv(dxPSGlbl.CheckHeight, PixelsNumerator, PixelsDenominator);
end;

function TdxCustomReportCellCheck.GetTextBounds(DC: HDC): TRect;
begin
  if CheckPos <> ccpCenter then
  begin
    Result := inherited GetTextBounds(DC);
    case CheckPos of
      ccpLeft:
        Result.Left := GetImageAreaBounds(DC).Right;
      ccpRight:
        Result.Right := GetImageAreaBounds(DC).Left;
    end;
  end
  else
    Result := dxPSGlbl.NullRect;
end;

function TdxCustomReportCellCheck.HasImage: Boolean;
begin
  Result := True;
end;

function TdxCustomReportCellCheck.IsImageBackgroundDrawn: Boolean;
begin
  Result := not Transparent and not IsBackgroundBitmapDrawn;
end;

class function TdxCustomReportCellCheck.IsRadio: Boolean;
begin
  Result := False;
end;

procedure TdxCustomReportCellCheck.SetChecked(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatCheckChecked, Value);
end;

function TdxCustomReportCellCheck.GetState: TCheckBoxState;
begin
  if Enabled then
    if Checked then 
      Result := cbChecked
    else
      Result := cbUnchecked
  else
    Result := cbGrayed;
end;

function TdxCustomReportCellCheck.GetBoldBorder: Boolean;
begin
  Result := ButtonEdgeStyle = cbesBoldFlat;
end;
    
function TdxCustomReportCellCheck.GetButtonEdgeStyle: TdxCheckButtonEdgeStyle;
begin
  Result := TdxCheckButtonEdgeStyle((Format and dxPSGlbl.dxFormatCheckButtonEdgeStyleMask) shr dxPSGlbl.dxFormatCheckButtonEdgeStyleOffset);
end;

function TdxCustomReportCellCheck.GetChecked: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatCheckChecked); 
end;

function TdxCustomReportCellCheck.GetCheckPos: TdxCellCheckPos;
begin
  Result := TdxCellCheckPos((Format and dxPSGlbl.dxFormatCheckPosMask) shr dxPSGlbl.dxFormatCheckPosOffset);
end;                                            

function TdxCustomReportCellCheck.GetEnabled: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatCheckEnabled);
end;

function TdxCustomReportCellCheck.GetFlatBorder: Boolean;
begin
  Result := ButtonEdgeStyle = cbesUltraFlat;
end;

procedure TdxCustomReportCellCheck.SetBoldBorder(Value: Boolean);
begin
  if Value then 
    ButtonEdgeStyle := cbesBoldFlat;
end;

procedure TdxCustomReportCellCheck.SetButtonEdgeStyle(Value: TdxCheckButtonEdgeStyle);
begin
  Format := Format and not dxPSGlbl.dxFormatCheckButtonEdgeStyleMask or (Byte(Value) shl dxPSGlbl.dxFormatCheckButtonEdgeStyleOffset);
end; 

procedure TdxCustomReportCellCheck.SetCheckPos(Value: TdxCellCheckPos);
begin
  if Value = ccpCenter then           
    SetText('');
  Format := Format and not dxPSGlbl.dxFormatCheckPosMask or (Byte(Value) shl dxPSGlbl.dxFormatCheckPosOffset);
end;

procedure TdxCustomReportCellCheck.SetEnabled(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatCheckEnabled, Value);
end;

procedure TdxCustomReportCellCheck.SetFlatBorder(Value: Boolean);
begin
  if Value then 
    ButtonEdgeStyle := cbesUltraFlat
  else
    ButtonEdgeStyle := cbes3D;  
end;

{ TdxCustomReportCellRadio }

class function TdxCustomReportCellRadio.IsRadio: Boolean;
begin
  Result := True;
end;

{ TdxCustomReportCellCheckImage }

constructor TdxCustomReportCellCheckImage.Create(AParent: TdxReportCell);
begin
  inherited;
  GlyphCount := 1;
end;

destructor TdxCustomReportCellCheckImage.Destroy;
begin
  ReleaseGlyph;
  inherited;
end;

procedure TdxCustomReportCellCheckImage.Assign(Source: TPersistent);
begin
  if Source is TdxCustomReportCellCheckImage then
    with TdxCustomReportCellCheckImage(Source) do 
    begin
      Self.GlyphCount := GlyphCount;
      if HasGlyph then
        Self.SetGlyph(Glyph)
      else
        Self.ReleaseGlyph;
    end;    
  inherited;
end;

procedure TdxCustomReportCellCheckImage.DrawCheck(DC: HDC);
begin
  if HasGlyph and not Glyph.Empty and (GlyphCount <> 0) then
    DrawCheckGlyph(DC)
  else  
    inherited;
end;

procedure TdxCustomReportCellCheckImage.DrawCheckGlyph(DC: HDC);
var
  R: TRect;
begin
  if HasGlyph and (GlyphCount <> 0) then
  begin
    R := GlyphPartialBounds;
    OffsetRect(R, -R.Left, -R.Top);
    //R := Rect(0, 0, Glyph.Height, Glyph.Height); {3.1}
    with Renderer.FCheckBitmap do
    begin
      Height := R.Bottom - R.Top;
      Width := R.Right - R.Left;
      Canvas.Brush.Color := clWhite;
      Canvas.FillRect(R);
      Canvas.CopyRect(R, Glyph.Canvas, GlyphPartialBounds);
    end;
    Renderer.CachedGraphicInfo.Clear;
    Renderer.DrawGraphicEx(DC, GetCheckBounds(DC), GetImageAreaBounds(DC), nil, 0,
      Renderer.FCheckBitmap, True, True, Color, ContentBkColor, ContentPattern, cibAlways);
  end;    
end;

procedure TdxCustomReportCellCheckImage.GetImageSizes(var AImageWidth, AImageHeight: Integer);
begin
  if HasGlyph and not Glyph.Empty and (GlyphCount <> 0) then 
  begin
    AImageWidth := MulDiv(Glyph.Width div GlyphCount, PixelsNumerator, PixelsDenominator);
    AImageHeight := MulDiv(Glyph.Height, PixelsNumerator, PixelsDenominator);
  end  
  else
    inherited;
end;

function TdxCustomReportCellCheckImage.GetGlyph: TBitmap;
begin
  Result := nil;
end;

function TdxCustomReportCellCheckImage.GetGlyphCount: Integer;
begin
  Result := 1;
end;

function TdxCustomReportCellCheckImage.GetGlyphIndex: Integer;
//cbUnchecked, cbChecked, cbGrayed
const
  GlyphIndexes: array[TCheckBoxState] of Integer = (0, 1, 2);
begin
  Result := GlyphIndexes[State];
  if (State = cbGrayed) and (GlyphCount < 3) then
    Result := 0;
  if Result > GlyphCount - 1 then
    Result := GlyphCount - 1; 
end;

procedure TdxCustomReportCellCheckImage.SetGlyph(Value: TBitmap);
begin
end;

procedure TdxCustomReportCellCheckImage.SetGlyphCount(Value: Integer);
begin
end;

function TdxCustomReportCellCheckImage.HasGlyph: Boolean;
begin
  Result := False;
end;

procedure TdxCustomReportCellCheckImage.ReleaseGlyph;
begin
end;

procedure TdxCustomReportCellCheckImage.ReadData(AReader: TdxPSDataReader);
begin
  inherited;
  if AReader.ReadBoolean then AReader.ReadImage(Glyph);
end;

procedure TdxCustomReportCellCheckImage.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited;
  AWriter.WriteBoolean(HasGlyph);
  if HasGlyph then AWriter.WriteImage(Glyph);
end;

function TdxCustomReportCellCheckImage.GetGlyphPartialBounds: TRect;
var
  AWidth: Integer;
begin
  if HasGlyph and (GlyphCount <> 0) then
    if GlyphCount = 1 then
      Result := MakeBounds(0, 0, Glyph.Width, Glyph.Height)
    else
    begin
      AWidth := Glyph.Width div GlyphCount;
      Result := MakeBounds(AWidth * GlyphIndex, 0, AWidth, Glyph.Height);
    end
  else
    Result := dxPSGlbl.NullRect;
end;

{ TdxReportCellCheckImage }

function TdxReportCellCheckImage.GetGlyph: TBitmap;
begin
  if FGlyph = nil then 
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

function TdxReportCellCheckImage.GetGlyphCount: Integer;
begin
  Result := (Format and dxPSGlbl.dxFormatCheckGlyphCountMask) shr dxPSGlbl.dxFormatCheckGlyphCountOffset;
end;

procedure TdxReportCellCheckImage.SetGlyph(Value: TBitmap);
begin
  if Value = nil then 
    ReleaseGlyph
  else  
    Glyph.Assign(Value);
end;

procedure TdxReportCellCheckImage.SetGlyphCount(Value: Integer);
begin
//  if Value < 1 then {3.1}
//    Value := 1;
  if Value < 0 then Value := 0;
  if Value > MaxGlyphCount then 
    Value := MaxGlyphCount;

  Format := Format and not dxPSGlbl.dxFormatCheckGlyphCountMask or (DWORD(Value) shl dxPSGlbl.dxFormatCheckGlyphCountOffset);
end;

function TdxReportCellCheckImage.HasGlyph: Boolean;
begin
  Result := FGlyph <> nil;
end;

procedure TdxReportCellCheckImage.ReleaseGlyph;
begin
  FreeAndNil(FGlyph);
end;

{ TdxCustomReportButtonGroup }

constructor TdxCustomReportButtonGroup.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  FColumnCount := 1;
  FInterColumnsMinSpace := dxRadioGroupInterColumnsMinSpace;
  FInterRowsMinSpace := dxRadioGroupInterRowsMinSpace;
  FIndents := MakeRect(dxRadioGroupBoundsIndent, dxRadioGroupBoundsIndent, dxRadioGroupBoundsIndent, dxRadioGroupBoundsIndent);
  ShowCaption := False;
end;

procedure TdxCustomReportButtonGroup.Assign(Source: TPersistent);
begin
  if Source is TdxCustomReportButtonGroup then 
    with TdxCustomReportButtonGroup(Source) do
    begin
      Self.ColumnCount := ColumnCount;
      Self.InterColumnsMinSpace := InterColumnsMinSpace;
      Self.InterRowsMinSpace := InterRowsMinSpace;
      Self.Indents := Indents;
    end;
  inherited;
end;

procedure TdxCustomReportButtonGroup.AdjustContent(DC: HDC);
type
  TViewInfo = record
    ColumnWidth: Integer;
    ItemsArea: TRect;
    RowHeight: Integer;
  end;

var  
  ViewInfo: TViewInfo;
  
  procedure CalcItemSizes;
  var
    I, Value: Integer;
  begin
    FItemSize.cX := 0;
    for I := 0 to ItemCount - 1 do
    begin
      Value := Items[I].MeasureContentWidth(DC);
      if FItemSize.cX < Value then FItemSize.cX := Value;
    end;
    // todo: 4 - difference between PS and cxRadioGroup AB9777
    FItemSize.cY := Items[0].MeasureContentHeight(DC) - 4;
  end;

  procedure CalcViewInfo;
  begin
    FillChar(ViewInfo, SizeOf(TViewInfo), 0);
    with ViewInfo do
    begin
      ItemsArea := BoundsRect;
      OffsetRect(ItemsArea, -ItemsArea.Left, -ItemsArea.Top);
      if ShowCaption then                    
        ItemsArea := GetInnerBoundsRelativeTo(DC, ItemsArea);

      Inc(ItemsArea.Left, Indents.Left);
      if ShowCaption then
        Dec(ItemsArea.Top, Indents.Top)
      else
        Inc(ItemsArea.Top, Indents.Top);
      Dec(ItemsArea.Right, Indents.Right);
      Dec(ItemsArea.Bottom, Indents.Bottom);

      if not IsRectEmpty(ItemsArea) then
      begin
        ColumnWidth := (ItemsArea.Right - ItemsArea.Left) div ColumnCount;
        if ColumnWidth < ItemSize.cX + InterColumnsMinSpace then
          ColumnWidth := ItemSize.cX + InterColumnsMinSpace;

        RowHeight := (ItemsArea.Bottom - ItemsArea.Top) div RowCount;
        if RowHeight < ItemSize.cY then
          RowHeight := ItemSize.cY;
{        if (RowCount > 1) and (RowHeight < ItemSize.cY + (1 * RowCount) + InterRowsMinSpace) then
          RowHeight := ItemSize.cY - (1 * RowCount) + InterRowsMinSpace;}
      end;
    end;
  end;

  function GetColumnRect(AnIndex: Integer): TRect;
  begin
    with ViewInfo do
    begin
      Result := ItemsArea;
      Result.Right := Result.Left + ColumnWidth;
      OffsetRect(Result, AnIndex * ColumnWidth, 0);
    end;  
  end;
  
  function GetRowRect(AnIndex: Integer): TRect;
  begin
    with ViewInfo do 
    begin
      Result := ItemsArea;
      Result.Bottom := Result.Top + RowHeight;
      OffsetRect(Result, 0, AnIndex * RowHeight);
    end;  
  end;

  function GetItemBounds(AnIndex: Integer): TRect;
  var
    Delta: Integer;
  begin
    with GetColumnRect(ItemColumns[AnIndex]) do 
    begin
      Result.Left := Left;
      Result.Right := Right;
    end;  
    with GetRowRect(ItemRows[AnIndex]) do 
    begin
      Result.Top := Top;
      Result.Bottom := Bottom;
    end;

    Delta := (Result.Bottom - Result.Top - ItemSize.cY) div 2;
    InflateRect(Result, 0, -Delta);
  end;

  procedure CheckItemVisibility(AnItem: TdxReportVisualItem);
  var
    R: TRect;
  begin
    AnItem.Visible := IntersectRect(R, AnItem.BoundsRect, ViewInfo.ItemsArea);
  end;
  
var
  I, J, Index: Integer;
  Item: TdxCustomReportCellCheck;
begin
  if ItemCount <> 0 then 
  begin
    CalcItemSizes;
    CalcViewInfo;
    if not IsRectEmpty(ViewInfo.ItemsArea) then
      for I := 0 to ColumnCount - 1 do 
        for J := 0 to RowCount - 1 do 
        begin
          Index := I * RowCount + J;
          if Index > ItemCount - 1 then Break;
          
          Item := Items[Index];
          Item.BoundsRect := GetItemBounds(Index);
          CheckItemVisibility(Item);
        end;  
  end;   
end;

function TdxCustomReportButtonGroup.MeasureContentHeight(DC: HDC): Integer;
begin
  Result := RowCount * (ItemSize.cY + InterRowsMinSpace) - InterRowsMinSpace;
  Inc(Result, Indents.Top + Indents.Bottom);
  if RowCount <> 0 then
    Inc(Result, 2 * cxDrawTextUtils.cxTextSpace);
end;

function TdxCustomReportButtonGroup.MeasureContentWidth(DC: HDC): Integer;
begin
  Result := ColumnCount * (ItemSize.cX + InterColumnsMinSpace) - InterColumnsMinSpace;
  Inc(Result, Indents.Left + Indents.Right);
end;

function TdxCustomReportButtonGroup.Add(const AText: string = ''): TdxCustomReportCellCheck;
begin
  Result := GetItemClass.Create(Self);
  Result.Text := AText;
  Result.BoundsRect := MakeRect(0, 0, -1, 0);
  InitializeItem(Result);
end;

procedure TdxCustomReportButtonGroup.Clear;
begin
  ClearDataItems;
end;

procedure TdxCustomReportButtonGroup.Delete(Index: Integer);
begin
  DeleteDataItem(Index);
end;

function TdxCustomReportButtonGroup.FindItem(const ACaption: string): Integer;
begin
  for Result := 0 to ItemCount - 1 do
    if Items[Result].Text = ACaption then Exit;
  Result := -1;  
end;

procedure TdxCustomReportButtonGroup.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
var
  R: TRect;
begin
  inherited;
  R := Indents;
  with R do
  begin
    Left := MulDiv(Left, APixelsNumerator, APixelsDenominator);
    Right := MulDiv(Right, APixelsNumerator, APixelsDenominator);
    Top := MulDiv(Top, APixelsNumerator, APixelsDenominator);
    Bottom := MulDiv(Bottom, APixelsNumerator, APixelsDenominator);
  end;
  Indents := R;
  
  InterColumnsMinSpace := MulDiv(InterColumnsMinSpace, APixelsNumerator, APixelsDenominator);
  InterRowsMinSpace := MulDiv(InterRowsMinSpace, APixelsNumerator, APixelsDenominator);
end;

procedure TdxCustomReportButtonGroup.SetFontIndex(Value: Integer);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ItemCount - 1 do
    Items[I].FontIndex := Value;
end;

procedure TdxCustomReportButtonGroup.ReadDataItems(AReader: TdxPSDataReader);
begin
  FLocked := True;
  try
    inherited;
  finally
    FLocked := False;
  end;  
end;

procedure TdxCustomReportButtonGroup.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  ColumnCount := AReader.ReadInteger;
  InterColumnsMinSpace := AReader.ReadInteger;
  InterRowsMinSpace := AReader.ReadInteger;
  Indents := AReader.ReadRect;
end;

procedure TdxCustomReportButtonGroup.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteInteger(ColumnCount);
  AWriter.WriteInteger(InterColumnsMinSpace);
  AWriter.WriteInteger(InterRowsMinSpace);
  AWriter.WriteRect(Indents);
end;

class function TdxCustomReportButtonGroup.GetItemClass: TdxCustomReportCellCheckClass;
begin
  Result := TdxCustomReportCellCheck;
end;

procedure TdxCustomReportButtonGroup.InitializeItem(AnItem: TdxCustomReportCellCheck);
begin
  AnItem.ButtonEdgeStyle := ButtonEdgeStyle;
  AnItem.CellSides := [];
  AnItem.CheckPos := CheckPos;
  AnItem.Color := Color;
  AnItem.FontIndex := FontIndex;
  AnItem.TextAlignY := taCenterY;
  AnItem.Transparent := True;
end;

function TdxCustomReportButtonGroup.GetButtonEdgeStyle: TdxCheckButtonEdgeStyle;
begin
  Result := TdxCheckButtonEdgeStyle((Format and dxPSGlbl.dxFormatCheckButtonEdgeStyleMask) shr dxPSGlbl.dxFormatCheckButtonEdgeStyleOffset);
end;

function TdxCustomReportButtonGroup.GetCheckPos: TdxCellCheckPos;
begin
  Result := TdxCellCheckPos((Format and dxPSGlbl.dxFormatCheckPosMask) shr dxPSGlbl.dxFormatCheckPosOffset);
end;                                            

function TdxCustomReportButtonGroup.GetItem(Index: Integer): TdxCustomReportCellCheck;
begin
  Result := DataItems[Index] as TdxCustomReportCellCheck;
end;

function TdxCustomReportButtonGroup.GetItemColumn(Index: Integer): Integer;
begin
  Result := Index div RowCount;
end;

function TdxCustomReportButtonGroup.GetItemCount: Integer;
begin
  Result := DataItemCount;
end;

function TdxCustomReportButtonGroup.GetItemRow(Index: Integer): Integer;
begin
  Result := Index mod RowCount;
end;

function TdxCustomReportButtonGroup.GetRowCount: Integer;
begin
  Result := ItemCount div ColumnCount;
  if (ItemCount <> 0) and (ItemCount mod ColumnCount <> 0) then 
    Inc(Result);
end;

procedure TdxCustomReportButtonGroup.SetButtonEdgeStyle(Value: TdxCheckButtonEdgeStyle);
var
  I: Integer;
begin
  Format := Format and not dxPSGlbl.dxFormatCheckButtonEdgeStyleMask or (Byte(Value) shl dxPSGlbl.dxFormatCheckButtonEdgeStyleOffset);

  for I := 0 to ItemCount - 1 do
    Items[I].ButtonEdgeStyle := Value;
end; 

procedure TdxCustomReportButtonGroup.SetCheckPos(Value: TdxCellCheckPos);
var
  I: Integer;
begin
  Format := Format and not dxPSGlbl.dxFormatCheckPosMask or (Byte(Value) shl dxPSGlbl.dxFormatCheckPosOffset);

  if Value = ccpCenter then           
    for I := 0 to ItemCount - 1 do
      Items[I].Text := ''
end;

procedure TdxCustomReportButtonGroup.SetColumnCount(Value: Integer);
begin
  if Value < 1 then Value := 1;
  FColumnCount := Value;
end;

procedure TdxCustomReportButtonGroup.SetInterColumnsMinSpace(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FInterColumnsMinSpace := Value;
end;

procedure TdxCustomReportButtonGroup.SetInterRowsMinSpace(Value: Integer);
begin
  if Value < 0 then Value := 0;
  FInterRowsMinSpace := Value;
end;

procedure TdxCustomReportButtonGroup.SetIndents(Value: TRect);
begin
  with Value do 
  begin
    if Left < 0 then Left := 0;
    if Top < 0 then Top := 0;
    if Right < 0 then Right := 0;
    if Bottom < 0 then Bottom := 0;
  end;  
  FIndents := Value;
end;

{ TdxReportCellRadioGroupButton }

type
  TdxReportCellRadioGroupButton = class(TdxCustomReportCellRadio)
  private
    function GetParent: TdxReportRadioGroup;
  protected
    procedure SetChecked(Value: Boolean); override;
  public
    property Checked write SetChecked;
    property Enabled;
    property Parent: TdxReportRadioGroup read GetParent;
  end;
  
  // for backward compatibility with saved reports
  TdxReportCellGroupButton = class(TdxReportCellRadioGroupButton);
  
function TdxReportCellRadioGroupButton.GetParent: TdxReportRadioGroup;
begin
  Result := inherited Parent as TdxReportRadioGroup;
end;

procedure TdxReportCellRadioGroupButton.SetChecked(Value: Boolean);
begin
  inherited SetChecked(Value);
  if Value then
    Parent.ItemIndex := Index
  else
    Parent.ItemIndex := -1;
end;

{ TdxReportRadioGroup }

function TdxReportRadioGroup.Add(const AText: string = ''): TdxCustomReportCellRadio;
begin
  Result := inherited Add(AText) as TdxCustomReportCellRadio;
end;

class function TdxReportRadioGroup.GetItemClass: TdxCustomReportCellCheckClass;
begin
  Result := TdxReportCellRadioGroupButton;
end;

function TdxReportRadioGroup.GetItem(Index: Integer): TdxCustomReportCellRadio;
begin
  Result := inherited Items[Index] as TdxCustomReportCellRadio;
end;

function TdxReportRadioGroup.GetItemIndex: Integer;
begin
  for Result := 0 to ItemCount - 1 do
    if Items[Result].Checked then Exit;
  Result := -1;
end;

procedure TdxReportRadioGroup.SetItemIndex(Value: Integer);
var
  AnItemIndex: Integer;
begin
  if Locked then Exit;
  
  if Value < -1 then 
    Value := -1;
  if Value > ItemCount - 1 then 
    Value := ItemCount - 1;
  
  AnItemIndex := ItemIndex;
  if AnItemIndex <> Value then 
  begin
    Locked := True;
    try
      if AnItemIndex <> -1 then 
        Items[AnItemIndex].Checked := False;
      if Value <> -1 then 
        Items[Value].Checked := True;
    finally
      Locked := False;
    end;  
  end;
end;

{ TdxReportCellCheckGroupButton }

type
  TdxReportCellCheckGroupButton = class(TdxCustomReportCellCheckImage)
  private
    function GetParent: TdxReportCheckGroup;
  protected
    function GetGlyph: TBitmap; override;
    function GetGlyphCount: Integer; override;
    function HasGlyph: Boolean; override;
  public
    property Parent: TdxReportCheckGroup read GetParent; 
  end;

{ TdxReportCellCheckGroupButton }

function TdxReportCellCheckGroupButton.GetGlyph: TBitmap;
begin
  if Parent <> nil then
    Result := Parent.Glyph
  else
    Result := inherited GetGlyph;
end;

function TdxReportCellCheckGroupButton.GetGlyphCount: Integer;
begin
  if Parent <> nil then
    Result := Parent.GlyphCount
  else
    Result := inherited GetGlyphCount;
end;

function TdxReportCellCheckGroupButton.HasGlyph: Boolean;
begin
  Result := (Parent <> nil) and Parent.HasGlyph;
end;

function TdxReportCellCheckGroupButton.GetParent: TdxReportCheckGroup;
begin
  Result := inherited Parent as TdxReportCheckGroup;
end;
  
{ TdxReportCheckGroup }

constructor TdxReportCheckGroup.Create(AParent: TdxReportCell);
begin
  inherited;
  GlyphCount := 1;
end;

destructor TdxReportCheckGroup.Destroy; 
begin
  ReleaseGlyph;
  inherited;
end;

procedure TdxReportCheckGroup.Assign(Source: TPersistent);
begin
  if Source is TdxReportCheckGroup then
    with TdxReportCheckGroup(Source) do 
    begin
      if HasGlyph then
        Self.Glyph := Glyph
      else
        Self.ReleaseGlyph;
      Self.GlyphCount := GlyphCount;
    end;
end;
    
function TdxReportCheckGroup.Add(const AText: string = ''): TdxCustomReportCellCheckImage;
begin
  Result := inherited Add(AText) as TdxCustomReportCellCheckImage;
end;

function TdxReportCheckGroup.HasGlyph: Boolean; 
begin
  Result := FGlyph <> nil;//) and not FGlyph.Empty;
end;

procedure TdxReportCheckGroup.ReleaseGlyph;
begin
  FreeAndNil(FGlyph);
end;

procedure TdxReportCheckGroup.ReadData(AReader: TdxPSDataReader);
begin
  inherited;
  GlyphCount := AReader.ReadInteger;
  if AReader.ReadBoolean then AReader.ReadImage(Glyph);
end;

procedure TdxReportCheckGroup.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited;
  AWriter.WriteInteger(GlyphCount);
  AWriter.WriteBoolean(HasGlyph);
  if HasGlyph then AWriter.WriteImage(Glyph);
end;

class function TdxReportCheckGroup.GetItemClass: TdxCustomReportCellCheckClass;
begin
  Result := TdxReportCellCheckGroupButton;
end;

procedure TdxReportCheckGroup.InitializeItem(AnItem: TdxCustomReportCellCheck);
begin
  inherited;
end;

function TdxReportCheckGroup.GetGlyph: TBitmap;
begin
  if FGlyph = nil then
    FGlyph := TBitmap.Create;
  Result := FGlyph;
end;

function TdxReportCheckGroup.GetItem(Index: Integer): TdxCustomReportCellCheckImage;
begin
  Result := inherited Items[Index] as TdxCustomReportCellCheckImage;
end;

function TdxReportCheckGroup.GetItemChecked(Index: Integer): Boolean;
begin
  Result := Items[Index].Checked;
end;

function TdxReportCheckGroup.GetItemEnabled(Index: Integer): Boolean;
begin
  Result := Items[Index].Enabled;
end;

function TdxReportCheckGroup.GetItemState(Index: Integer): TCheckBoxState;
begin
  Result := Items[Index].State;
end;

procedure TdxReportCheckGroup.SetGlyph(Value: TBitmap);
begin
  Glyph.Assign(Value);
end;

procedure TdxReportCheckGroup.SetGlyphCount(Value: Integer);
begin
  if Value < 0 then Value := 0; {3.1  1 -> 0}
  if Value > MaxGlyphCount then Value := MaxGlyphCount;
  FGlyphCount := Value;
end;

procedure TdxReportCheckGroup.SetItemChecked(Index: Integer; Value: Boolean);
begin
  Items[Index].Checked := Value;
end;

procedure TdxReportCheckGroup.SetItemEnabled(Index: Integer; Value: Boolean);
begin
  Items[Index].Enabled := Value;
end;

{ TCustomdxReportCellImageContainer }

constructor TCustomdxReportCellImageContainer.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  ImageIndex := -1;
  ImageTransparent := True;
  OverlayImageIndex := -1;
end;
    
destructor TCustomdxReportCellImageContainer.Destroy;
begin
  FreeAndNil(FImage);
  inherited Destroy;
end;

procedure TCustomdxReportCellImageContainer.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TCustomdxReportCellImageContainer then
    with TCustomdxReportCellImageContainer(Source) do 
    begin
      Self.SetImage(FImage);
      Self.ImageTransparent := ImageTransparent;
      Self.ImageIndex := ImageIndex;
      Self.ImageList := ImageList;
    end;  
end;

function TCustomdxReportCellImageContainer.CreateImage(AGraphicClass: TGraphicClass): TGraphic;
begin
  if (FImage = nil) or (FImage.ClassType <> AGraphicClass) then
  begin
    FreeAndNil(FImage);
    FImage := dxPSUtl.CreateGraphic(AGraphicClass);
  end;
  Result := FImage;
end;

procedure TCustomdxReportCellImageContainer.DrawImage(DC: HDC);
begin
  Renderer.CachedGraphicInfo.Clear;
  if FImage = nil then
    PrepareImage; 
  Renderer.DrawGraphicEx(DC, GetImageBounds(DC), GetImageAreaBounds(DC), ImageList,
    ImageIndex, FImage, ImageTransparent, IsBackgroundBitmapDrawn or Transparent,
    Color, ContentBkColor, ContentPattern, ActualImageBuffering);
  if (ImageList <> nil) and (OverlayImageIndex <> -1) then
    Renderer.DrawGraphicEx(DC, GetImageBounds(DC), GetImageAreaBounds(DC), ImageList,
      OverlayImageIndex, nil, True, True, clNone, clNone, ContentPattern, ActualImageBuffering);
end;  

function TCustomdxReportCellImageContainer.GetActualImageBuffering: TdxCellImageActualBuffering;
begin
  Result := ImageBuffering;
  if Result = cibDefault then 
    if (ReportCells <> nil) and (ReportCells.ReportLink <> nil) then 
      if ReportCells.ReportLink.AlwaysBufferedGraphics then
        Result := cibAlways
      else
        Result := cibNone
    else
      Result := cibAlways;
end;

function TCustomdxReportCellImageContainer.GetImageBuffering: TdxCellImageBuffering;
begin
  Result := cibDefault;
end;

procedure TCustomdxReportCellImageContainer.GetImageSizes(var AImageWidth, AImageHeight: Integer);
begin
  if ImageList <> nil then
  begin
    AImageWidth := MulDiv(ImageList.Width, PixelsNumerator, PixelsDenominator);
    AImageHeight := MulDiv(ImageList.Height, PixelsNumerator, PixelsDenominator);
  end
  else  
    if FImage <> nil then
    begin
      AImageWidth := MulDiv(Image.Width, PixelsNumerator, PixelsDenominator);
      AImageHeight := MulDiv(Image.Height, PixelsNumerator, PixelsDenominator);
    end
    else
      inherited;
end;

function TCustomdxReportCellImageContainer.HasImage: Boolean;
begin
  Result := ((FImage <> nil) and not Image.Empty) or 
    ((ImageList <> nil) and (ImageIndex > -1) and (ImageIndex < ImageList.Count));
end;    

procedure TCustomdxReportCellImageContainer.PrepareImage;
var
  ABitmap: TBitmap;
begin
  if (ImageList = nil) or (ImageIndex < 0) or (TcxImageList.GetPixelFormat(ImageList.Handle) < 32) or
    not (IsTextBackgroundDrawn or IsImageBackgroundDrawn or FDontPrintTransparentImages) then Exit;
  ABitmap := cxCreateBitmap(ImageList.Width, ImageList.Height, pf24Bit);
  Renderer.FillRectEx(ABitmap.Canvas.Handle, Rect(0, 0, ABitmap.Width,
    ABitmap.Height), Color, ContentBkColor, ContentPattern);
  ImageList.Draw(ABitmap.Canvas, 0, 0, ImageIndex);
  ImageList.Draw(ABitmap.Canvas, 0, 0, OverlayImageIndex);
  FImage := ABitmap;
  ImageList := nil;
  ImageIndex := -1;
end;

procedure TCustomdxReportCellImageContainer.SetImageBuffering(Value: TdxCellImageBuffering);
begin
end;

function TCustomdxReportCellImageContainer.GetImageListIndex: Integer;
begin
  Result := ReportCells.IndexOfImageList(ImageList);
end;

procedure TCustomdxReportCellImageContainer.ReadData(AReader: TdxPSDataReader);
var
  SourceType, BytesToSkip: Integer;
  GraphicClass: TGraphicClass;
begin
  inherited ReadData(AReader);
  
  if AReader.ReadBoolean then // HasImage
  begin
    SourceType := AReader.ReadInteger;
    case SourceType of 
      imstImageList:
        begin
          ImageList := ReportCells.ImageLists[AReader.ReadInteger];
          ImageIndex := AReader.ReadInteger;
        end;

      {imstShellLargeImageList:
        begin
          ImageList := dxPSUtl.ShellLargeImages;
          ImageIndex := AReader.ReadInteger;
        end;  

      imstShellSmallImageList:
        begin
          ImageList := dxPSUtl.ShellSmallImages;
          ImageIndex := AReader.ReadInteger;
        end;}  
      imstShellLargeImageList,
      imstShellSmallImageList,
      imstImage:
        begin
          GraphicClass := AReader.ReadGraphicClass;
          if GraphicClass = nil then 
          begin
            Image := nil;
            BytesToSkip := {$IFDEF DELPHI6} AReader.ReadInt64 {$ELSE} AReader.ReadInteger {$ENDIF};
            AReader.SkipBytes(BytesToSkip);
          end
          else
            AReader.ReadImage(CreateImage(GraphicClass));
        end; 
    end;
  end;    
end;

procedure TCustomdxReportCellImageContainer.WriteData(AWriter: TdxPSDataWriter);

  function RetrieveSourceType: Integer;
  begin
    if ImageList <> nil then
      if (ImageList = dxPSUtl.ShellLargeImages) or 
        (ImageList.HandleAllocated and (ImageList.Handle = dxPSUtl.ShellLargeImages.Handle)) then
        Result := imstShellLargeImageList
      else 
        if (ImageList = dxPSUtl.ShellSmallImages) or 
          (ImageList.HandleAllocated and (ImageList.Handle = dxPSUtl.ShellSmallImages.Handle)) then
          Result := imstShellSmallImageList
        else
          Result := imstImageList
    else
      Result := imstImage;
  end;    

  function RetrieveImage(ASourceType: Integer; AnImageIndex: Integer): TGraphic;
  begin
    case ASourceType of 
      imstShellLargeImageList:
        begin
          Result := TBitmap.Create;
          dxPSUtl.ShellLargeImages.GetBitmap(AnImageIndex, TBitmap(Result));
        end;
      
      imstShellSmallImageList:  
        begin
          Result := TBitmap.Create;
          dxPSUtl.ShellSmallImages.GetBitmap(AnImageIndex, TBitmap(Result));
        end;
    else
      Result := Self.Image; 
    end;
  end;
  
var
  SourceType: Integer;
  Buffer: TGraphic;
begin
  inherited WriteData(AWriter);

  AWriter.WriteBoolean(HasImage);
  if HasImage then
  begin
    SourceType := RetrieveSourceType;
    AWriter.WriteInteger(SourceType); 
    case SourceType of 
      imstImageList:
        begin
          AWriter.WriteInteger(GetImageListIndex);
          AWriter.WriteInteger(ImageIndex);
        end;
        
    else
      begin  
        Buffer := RetrieveImage(SourceType, ImageIndex);
        try
          AWriter.WriteString(Buffer.ClassName);
          AWriter.WriteImage(Buffer);
        finally
          if Buffer <> Self.Image then Buffer.Free;
        end;
      end;
      {  imstShellLargeImageList,
        imstShellSmallImageList:  
        AWriter.WriteInteger(ImageIndex);
      imstImage:
        begin
          AWriter.WriteString(Image.ClassName);
          AWriter.WriteImage(Image);
        end;}
    end;  
  end;  
end;

procedure TCustomdxReportCellImageContainer.SetImage(Value: TGraphic);
begin
  if Value <> nil then
  begin
    CreateImage(TGraphicClass(Value.ClassType));
    Image.Assign(Value);

    if Width = 0 then Width := Image.Width;
    if Height = 0 then Height := Image.Height;
  end
  else
    FreeAndNil(FImage);
end;

{ TdxReportCellImage }

constructor TdxReportCellImage.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  ImageLayout := ilImageCenterLeft;
  IsTextDrawnForCenteredImage := False;
  IsTextShiftedForHorizontallyCenteredImage := True;
  MakeSpaceForEmptyImage := True;
end;

procedure TdxReportCellImage.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxReportCellImage then
  begin
    ImageLayout := TdxReportCellImage(Source).ImageLayout;
    MakeSpaceForEmptyImage := TdxReportCellImage(Source).MakeSpaceForEmptyImage;
  end;  
end;

function TdxReportCellImage.MeasureContentHeight(DC: HDC): Integer;
var
  TextHeight: Integer;
begin
  if ImageList <> nil then
    Result := ImageList.Height
  else  
    if FImage <> nil then
      Result := Image.Height
    else
      Result := 0;
      
  if Result <> 0 then Inc(Result, 2);    
    
  if ImageLayout in [ilImageTopLeft, ilImageCenterLeft, ilImageBottomLeft, ilImageTopRight, ilImageCenterRight, ilImageBottomRight] then
  begin
    TextHeight := inherited MeasureContentHeight(DC);
    if Result < TextHeight then Result := TextHeight;
  end
  else
    if ImageLayout in [ilImageTopCenter, ilImageBottomCenter] then
      if not IsTextShiftedForHorizontallyCenteredImage then 
      begin
        TextHeight := inherited MeasureContentHeight(DC);
        if TextHeight > Result then Result := TextHeight;
      end
      else
        Inc(Result, inherited MeasureContentHeight(DC))
     else
       if IsTextDrawnForCenteredImage then    
       begin
         TextHeight := inherited MeasureContentHeight(DC);
         if TextHeight > Result then Result := TextHeight;
       end;
end;
  
function TdxReportCellImage.MeasureContentWidth(DC: HDC): Integer;
var
  TextWidth: Integer;
begin
  if ImageList <> nil then
    Result := ImageList.Width
  else  
    if FImage <> nil then
      Result := Image.Width
    else
      Result := 0;

  if Result <> 0 then Inc(Result, 2);    
  
  if ImageLayout in [ilImageTopLeft, ilImageCenterLeft, ilImageBottomLeft, ilImageTopRight, ilImageCenterRight, ilImageBottomRight] then
    Inc(Result, inherited MeasureContentHeight(DC))
  else  
    if (ImageLayout in [ilImageTopCenter, ilImageBottomCenter]) or ((ImageLayout = ilImageCenterCenter) and IsTextDrawnForCenteredImage) then
    begin
      TextWidth := inherited MeasureContentWidth(DC);      
      if Result < TextWidth then Result := TextWidth;
    end;
end;

function TdxReportCellImage.GetHalfContentWidth(DC: HDC): Integer;
var
  W, H: Integer; 
begin
  GetImageSizes(W, H);
  if IsTextDrawnForCenteredImage and not IsTextShiftedForHorizontallyCenteredImage and
    (ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]) then
     Result := (Renderer.CalcTextWidth(DC, Text, Font) + W) div 2 + Renderer.LineThickness  
  else
    Result := 0;
end;

function TdxReportCellImage.GetImageAreaBounds(DC: HDC): TRect;
var
  W, H: Integer;
  R: TRect;
begin
  GetImageSizes(W, H);
  if (W <> 0) and (H <> 0) then
  begin
    Result := inherited GetImageAreaBounds(DC);
    with Result do 
    begin
      case ImageLayout of
        ilImageTopLeft:
          Right := Left + W + 2 * Renderer.UnitsPerPixel;
        ilImageTopCenter:
          begin
            if not IsTextShiftedForHorizontallyCenteredImage then 
            begin
              Inc(Left, (Right - Left - W) div 2 + Renderer.UnitsPerPixel);
              Right := Left + W + Renderer.UnitsPerPixel;
            end;
            Bottom := Top + H + 2 * Renderer.UnitsPerPixel;
          end; 
        ilImageTopRight:
          Left := Right - W - 2 * Renderer.UnitsPerPixel;
        ilImageCenterLeft:
          Right := Left + W + 2 * Renderer.UnitsPerPixel;
        ilImageCenterCenter:
          if not IsTextShiftedForHorizontallyCenteredImage then 
          begin
            Inc(Left, (Right - Left - W) div 2 + Renderer.UnitsPerPixel);
            Right := Left + W + Renderer.UnitsPerPixel;
            Inc(Top, (Bottom - Top - H) div 2 + Renderer.UnitsPerPixel);
            Bottom := Top + H + Renderer.UnitsPerPixel;
          end;
        ilImageCenterRight:
          Left := Right - W - 2 * Renderer.UnitsPerPixel;
        ilImageBottomLeft:
          Right := Left + W + 2 * Renderer.UnitsPerPixel;
        ilImageBottomCenter:
          begin
            if not IsTextShiftedForHorizontallyCenteredImage then 
            begin
              Inc(Left, (Right - Left - W) div 2 + Renderer.UnitsPerPixel);
              Right := Left + W + Renderer.UnitsPerPixel;
            end;
            Top := Bottom - H - 2 * Renderer.UnitsPerPixel;
          end;
        ilImageBottomRight:
          Left := Right - W - 2 * Renderer.UnitsPerPixel;
      end;
      R := GetInnerBounds(DC);
      OffsetRect(Result, -GetHalfContentWidth(DC), 0);
      if Left < R.Left then Left := R.Left;
      if Top < R.Top then Top := R.Top;
      if Right > R.Right then Right := R.Right;
      if Bottom > R.Bottom then Bottom := R.Bottom;
    end;
  end
  else
    Result := NullRect;
end;

function TdxReportCellImage.GetImageBounds(DC: HDC): TRect;
var
  W, H: Integer;
begin
  Result := GetImageAreaBounds(DC);
  if not IsRectEmpty(Result) then
  begin
    GetImageSizes(W, H);
    with Result do
    begin
      case ImageLayout of
        ilImageTopLeft,
        ilImageTopCenter,
        ilImageTopRight:
          Inc(Top, LineThickness);

        ilImageCenterLeft,
        ilImageCenterCenter,
        ilImageCenterRight:
          Inc(Top, (Bottom - Top - H) div 2);

        ilImageBottomLeft,
        ilImageBottomCenter,
        ilImageBottomRight:
          Top := Bottom - H - LineThickness;
      end;
      Inc(Left, (Right - Left - W) div 2);
      Right := Left + W;
      Bottom := Top + H;
//      CorrectBounds(Result, DC);
    end;
  end;
end;

function TdxReportCellImage.GetTextBounds(DC: HDC): TRect;
var
  R: TRect;
begin
  Result := inherited GetTextBounds(DC);
  if IsImageDrawn or MakeSpaceForEmptyImage then
  begin
    if not ((ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]) and
      not IsTextShiftedForHorizontallyCenteredImage) then
    begin
      R := GetImageBounds(DC);
      if not IsRectEmpty(R) then
        with Result do
          case ImageLayout of
            ilImageTopLeft, ilImageCenterLeft, ilImageBottomLeft:
              Left := R.Right;
            ilImageTopRight, ilImageCenterRight, ilImageBottomRight:
              Right := R.Left;
            ilImageTopCenter:
              if IsTextShiftedForHorizontallyCenteredImage then
                Top := R.Bottom;
            ilImageCenterCenter:
              if not IsTextDrawn then  //TODO: TdxReportCellImage.GetTextBounds(
                Result := NullRect;
            ilImageBottomCenter:
              if IsTextShiftedForHorizontallyCenteredImage then
                Bottom := R.Top;
          end;
    end;
  end;  
end;

function TdxReportCellImage.IsImageBackgroundDrawn: Boolean;
begin
  Result := inherited IsImageBackgroundDrawn and MakeSpaceForEmptyImage and
    not ((ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]) and 
          not IsTextShiftedForHorizontallyCenteredImage);
end;

function TdxReportCellImage.IsTextDrawn: Boolean;
begin
  Result := inherited IsTextDrawn and ((ImageLayout <> ilImageCenterCenter) or IsTextDrawnForCenteredImage);
end;

function TdxReportCellImage.IsTextBackgroundDrawn: Boolean;
begin
  Result := inherited IsTextBackgroundDrawn and
    (not (ImageLayout in [ilImageTopCenter, ilImageCenterCenter, ilImageBottomCenter]) or
    IsTextDrawnForCenteredImage or not HasImage);
end;

function TdxReportCellImage.GetImageLayout: TdxImageLayout;
begin
  Result := TdxImageLayout((Format and dxPSGlbl.dxFormatImageLayoutMask) shr dxPSGlbl.dxFormatImageLayoutOffset);
end;

function TdxReportCellImage.GetIsTextDrawnForCenteredImage: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatIsTextDrawnForCenteredImage);
end;

function TdxReportCellImage.GetIsTextShiftedForHorizontallyCenteredImage: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatIsTextShiftedForHorizontallyCenteredImage);
end;

function TdxReportCellImage.GetMakeSpaceForEmptyImage: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatMakeSpaceForEmptyImage);
end;

procedure TdxReportCellImage.SetImageLayout(Value: TdxImageLayout);
begin
  Format := Format and not dxPSGlbl.dxFormatImageLayoutMask or (Byte(Value) shl dxPSGlbl.dxFormatImageLayoutOffset);
end;

procedure TdxReportCellImage.SetIsTextDrawnForCenteredImage(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatIsTextDrawnForCenteredImage, Value);
end;

procedure TdxReportCellImage.SetIsTextShiftedForHorizontallyCenteredImage(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatIsTextShiftedForHorizontallyCenteredImage, Value);
end;

procedure TdxReportCellImage.SetMakeSpaceForEmptyImage(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatMakeSpaceForEmptyImage, Value);
end;

{ TdxReportCellGraphic }

constructor TdxReportCellGraphic.Create(AParent: TdxReportCell);
begin
  inherited;
  ImageBuffering := cibAlways;
  CalculateDrawMode;
end;

{procedure TdxReportCellGraphic.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TdxReportCellGraphic then
    DrawMode := TdxReportCellGraphic(Source).DrawMode;    
end;}

function TdxReportCellGraphic.MeasureFontHeight(DC: HDC): Integer;
begin
  Result := Renderer.CalcTextPatternHeight(DC, Renderer.RenderInfo.BaseContentFont);
end;

function TdxReportCellGraphic.MeasureContentHeight(DC: HDC): Integer;
begin
  if ImageList <> nil then
    Result := ImageList.Height
  else
    if FImage <> nil then
    begin
      Result := Image.Height;
      if RealStretch and (Result > 0) and (Image.Width > 0) then
        Result := Round(Result * Width / Image.Width);
    end
    else
      Result := 0;
end;
  
function TdxReportCellGraphic.MeasureContentWidth(DC: HDC): Integer;
begin
  if ImageList <> nil then
    Result := ImageList.Width
  else  
    if FImage <> nil then
      Result := Image.Width
    else
      Result := 0;
end;

function TdxReportCellGraphic.GetImageBounds(DC: HDC): TRect;
var
  W, H, cW, cH: Integer;
  R: TRect;
begin
  GetImageSizes(W, H);
  if (W <> 0) and (H <> 0) then
  begin
    R := GetImageAreaBounds(DC);
    with Result do
    begin
      case DrawMode of
        gdmNone:
          begin
            Result.TopLeft := R.TopLeft;
            Right := Left + W;
            Bottom := Top + H;
          end;
        gdmCenter:  
          begin
            Left := R.Left + (R.Right - R.Left - W) div 2;
            Top := R.Top + (R.Bottom - R.Top - H) div 2;
            Right := Left + W;
            Bottom := Top + H;
          end;  
        gdmStretch:
          Result := R;       
        gdmStretchProportional, 
        gdmCenterAndStretchProportional:
          begin
            TopLeft := R.TopLeft;
            cW := R.Right - R.Left;
            cH := R.Bottom - R.Top;
            if W / H > cW / cH then
            begin
              Right := Left + cW;
              Bottom := Top + MulDiv(cW, H, W);
            end
            else
            begin
              Bottom := Top + cH;
              Right := Left + MulDiv(cH, W, H);
            end;
          end;
      end;
      if DrawMode = gdmCenterAndStretchProportional then 
      begin
        W := Right - Left;
        H := Bottom - Top;
        Left := R.Left + (R.Right - R.Left - W) div 2;
        Top := R.Top + (R.Bottom - R.Top - H) div 2;
        Right := Left + W;
        Bottom := Top + H;
      end;  
    end;  
  end
  else
    Result := dxPSGlbl.NullRect;
end;

function TdxReportCellGraphic.GetImageBuffering: TdxCellImageBuffering;
begin
  Result := TdxCellImageBuffering((Format and dxPSGlbl.dxFormatGraphicBufferingMask) shr dxPSGlbl.dxFormatGraphicBufferingOffset);
end;

function TdxReportCellGraphic.GetTextBounds(DC: HDC): TRect;
begin
  Result := dxPSGlbl.NullRect;
end;

procedure TdxReportCellGraphic.SetImageBuffering(Value: TdxCellImageBuffering);
begin
  Format := Format and not dxPSGlbl.dxFormatGraphicBufferingMask or (Byte(Value) shl dxPSGlbl.dxFormatGraphicBufferingOffset);
end;

procedure TdxReportCellGraphic.CalculateDrawMode;
const
  dxDrawMode: array [Boolean, Boolean, Boolean] of TdxGraphicDrawMode =
  (((gdmNone, gdmCenter), (gdmCenter, gdmCenter)),
  ((gdmStretch, gdmStretch), (gdmStretchProportional, gdmCenterAndStretchProportional)));
begin
  DrawMode := dxDrawMode[RealStretch, Proportional, Center];
end;

function TdxReportCellGraphic.GetImage: TGraphic;
begin
  Result := inherited Image;
end;

function TdxReportCellGraphic.GetDrawMode: TdxGraphicDrawMode;
begin
  Result := TdxGraphicDrawMode((Format and dxPSGlbl.dxFormatGraphicDrawModeMask) shr dxPSGlbl.dxFormatGraphicDrawModeOffset);
end;

function TdxReportCellGraphic.GetRealStretch: Boolean;
begin
  Result := Stretch or (Proportional and (FImage <> nil) and
    (Width < Image.Width));
end;

procedure TdxReportCellGraphic.SetImage(Value: TGraphic);
begin
  inherited Image := Value;
  CalculateDrawMode;
end;

procedure TdxReportCellGraphic.SetCenter(Value: Boolean);
begin
  if Value <> FCenter then
  begin
    FCenter := Value;
    CalculateDrawMode;
  end;
end;

procedure TdxReportCellGraphic.SetDrawMode(Value: TdxGraphicDrawMode);
begin
  Format := Format and not dxPSGlbl.dxFormatGraphicDrawModeMask or (Byte(Value) shl dxPSGlbl.dxFormatGraphicDrawModeOffset);
end;

procedure TdxReportCellGraphic.SetProportional(Value: Boolean);
begin
  if Value <> FProportional then
  begin
    FProportional := Value;
    CalculateDrawMode;
  end;
end;

procedure TdxReportCellGraphic.SetStretch(Value: Boolean);
begin
  if Value <> FStretch then
  begin
    FStretch := Value;
    CalculateDrawMode;
  end;
end;

{ TdxReportCellExpandButton }

constructor TdxReportCellExpandButton.Create(AParent: TdxReportCell);
begin
  inherited Create(AParent);
  ButtonAlignHorz := bahCenter;
  ButtonAlignVert := bavCenter;
  ButtonBorder3D := False;
  ButtonBorder3DSoft := False;
  ButtonBorderShadow := False;
  ButtonExpanded := False;
  ButtonInteriorColor := clNone;
  ButtonSize := dxDefaultCrossSignCrossSize;       // 9      
  ButtonTransparent := True;
  KeepOddSize := True;
  ShowButton := False;
  ShowButtonBorder := True;
  TreeLineMode := tlmNone;
end;

procedure TdxReportCellExpandButton.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TdxReportCellExpandButton then 
  begin
    ButtonBorder3D := TdxReportCellExpandButton(Source).ButtonBorder3D;
    ButtonBorder3DSoft := TdxReportCellExpandButton(Source).ButtonBorder3DSoft;
    ButtonBorderShadow := TdxReportCellExpandButton(Source).ButtonBorderShadow;
    ButtonExpanded := TdxReportCellExpandButton(Source).ButtonExpanded;
    ButtonInteriorColor := TdxReportCellExpandButton(Source).ButtonInteriorColor;
    ButtonSize := TdxReportCellExpandButton(Source).ButtonSize;
    ButtonTransparent := TdxReportCellExpandButton(Source).ButtonTransparent;
    KeepOddSize := TdxReportCellExpandButton(Source).KeepOddSize;
    ShowButton := TdxReportCellExpandButton(Source).ShowButton;
    ShowButtonBorder := TdxReportCellExpandButton(Source).ShowButtonBorder;
    TreeLineMode := TdxReportCellExpandButton(Source).TreeLineMode;
  end;
end;

procedure TdxReportCellExpandButton.DrawContent(DC: HDC; AStage: TdxPSRenderStages);
begin
  if IsBackgroundBitmapDrawn then 
    DrawBackgroundBitmap(DC)
  else
    if IsBackgroundDrawn then 
      DrawBackground(DC);
  if ShowButton then DrawExpandButton(DC);
  if AreTreeLinesDrawn then DrawTreeLines(DC);
  if IsBordersDrawn then DrawBorders(DC);
end;

procedure TdxReportCellExpandButton.DrawExpandButton(DC: HDC);
var
  R: TRect;
begin
  R := GetButtonBounds(DC);
  if RectVisible(DC, R) then             
    Renderer.DrawExpandButton(DC, R, ButtonExpanded, ShowButtonBorder, 
      ButtonBorder3D, ButtonBorder3DSoft, ButtonBorderShadow, not ButtonTransparent, 
      ReportCells.ExpandButtonBorderColor, ButtonInteriorColor);
end;

procedure TdxReportCellExpandButton.DrawTreeLines(DC: HDC);
type
  TdxTreeLinesDrawInfo = record
    TopRect: TRect;
    RightRect: TRect;
    BottomRect: TRect;
  end;

  function GetTreeLineParts: TdxPSTreeLineParts;
  const
    Parts: array[TdxPSTreeLineMode] of TdxPSTreeLineParts = 
      ([], [tlpTop, tlpBottom], [tlpTop, tlpRight, tlpBottom], 
       [tlpBottom, tlpRight], [tlpTop, tlpRight]);
  begin
    Result := Parts[TreeLineMode];
  end;
  
  procedure DrawTreeLine(const R: TRect; APattern: TdxPSFillPatternClass);
  var
    BkColor: TColor;  
  begin
    if RectVisible(DC, R) then
    begin
      if Transparent then
        BkColor := clWindow  
      else  
        BkColor := Color;
      Renderer.FillRectEx(DC, R, ReportCells.TreeLineColor, BkColor, APattern);
    end;  
  end;

  procedure CalculateDrawInfo(const AButtonRect: TRect; var ADrawInfo: TdxTreeLinesDrawInfo);
  begin
    with ADrawInfo do 
    begin
      TopRect := BoundsRect;
      with TopRect do 
      begin
        Inc(Left, (Right - Left) div 2 - Renderer.LineThickness div 2);
        Right := Left + Renderer.UnitsPerPixel;
        Dec(Bottom, (Bottom - Top) div 2);
      end;
      if csTop in CellSides then 
        Dec(TopRect.Top, Renderer.LineThickness);

      RightRect := BoundsRect;
      with RightRect do 
      begin
        Inc(Left, (Right - Left) div 2);
        Inc(Top, (Bottom - Top) div 2 - Renderer.LineThickness div 2);
        Bottom := Top + Renderer.UnitsPerPixel;      
      end;
      if csRight in CellSides then 
        Dec(RightRect.Right, Renderer.LineThickness);

      BottomRect := BoundsRect;
      with BottomRect do 
      begin
        Inc(Left, (Right - Left) div 2 - Renderer.LineThickness div 2);
        Right := Left + Renderer.UnitsPerPixel;
        Inc(Top, (Bottom - Top) div 2);
      end;
      if csBottom in CellSides then 
        Dec(BottomRect.Bottom, Renderer.LineThickness);
      
      if not IsRectEmpty(AButtonRect) then 
      begin
        TopRect.Bottom := AButtonRect.Top - Renderer.LineThickness;
        RightRect.Left := AButtonRect.Right + Renderer.LineThickness;
        BottomRect.Top := AButtonRect.Bottom + Renderer.LineThickness;
      end;  
    end;    
  end;
  
const
  Patterns: array[TdxPSTreeLineStyle] of TdxPSFillPatternClass = (TdxPSSolidFillPattern, TdxPSGray50FillPattern);
var
  Parts: TdxPSTreeLineParts;
  Pattern: TdxPSFillPatternClass;
  DrawInfo: TdxTreeLinesDrawInfo;
begin
  Parts := GetTreeLineParts;
  Pattern := Patterns[ReportCells.TreeLineStyle];  
  
  CalculateDrawInfo(GetButtonBounds(DC), DrawInfo);
  with DrawInfo do
  begin
    if tlpTop in Parts then DrawTreeLine(TopRect, Pattern);
    if tlpBottom in Parts then DrawTreeLine(BottomRect, Pattern);
    if tlpRight in Parts then DrawTreeLine(RightRect, Pattern);
  end;  
end;

function TdxReportCellExpandButton.GetButtonBounds(DC: HDC): TRect;
begin
  if ShowButton then 
  begin
    Result := CalculateButtonBounds;
    FixupRect(DC, Result);
  end
  else
    Result := dxPSGlbl.NullRect;
end;

procedure TdxReportCellExpandButton.ConvertCoords(APixelsNumerator, APixelsDenominator: Integer);
begin
  inherited;
  ButtonSize := MulDiv(ButtonSize, APixelsNumerator, APixelsDenominator);
end;

function TdxReportCellExpandButton.AreTreeLinesDrawn: Boolean;  
begin
  Result := TreeLineMode <> tlmNone;
end;

function TdxReportCellExpandButton.CalculateButtonBounds: TRect;
var
  ButtonSize: Integer;
begin
  Result := BoundsRect;
  with Result do 
  begin
    ButtonSize := ActualButtonSize;
    case ButtonAlignHorz of 
      bahLeft:
        begin
          Inc(Left, ButtonIndents.Left);
          Right := Left + ButtonSize;
        end;
      bahCenter:
        begin
          Inc(Left, (Right - Left - ButtonSize) div 2);
          Right := Left + ButtonSize;
        end;  
      bahRight:
        begin
          Dec(Right, ButtonIndents.Right);
          Left := Right - ButtonSize;
        end;  
    end;

    case ButtonAlignVert of 
      bavTop:
        begin
          Inc(Top, ButtonIndents.Top);
          Bottom := Top + ButtonSize;
        end;
      bavCenter:
        begin
          Inc(Top, (Bottom - Top - ButtonSize) div 2);
          Bottom := Top + ButtonSize;
        end;  
      bavBottom:
        begin
          Dec(Bottom, ButtonIndents.Bottom);
          Top := Bottom - ButtonSize;
        end;  
    end;

    if Right < Left then Right := Left;
    if Bottom < Top then Bottom := Top;
  end;
end;

function TdxReportCellExpandButton.GetButtonAlignHorz: TdxReportCellExpandButtonAlignHorz;
begin
  Result := bahCenter;
end;

function TdxReportCellExpandButton.GetButtonAlignVert: TdxReportCellExpandButtonAlignVert;
begin
  Result := bavCenter;
end;

function TdxReportCellExpandButton.GetButtonIndents: TRect;
begin
  if Renderer <> nil then
    Result := MakeRect(LineThickness, LineThickness, LineThickness, LineThickness)
  else
    Result := NullRect;  
end;

procedure TdxReportCellExpandButton.SetButtonAlignHorz(Value: TdxReportCellExpandButtonAlignHorz);
begin
end;

procedure TdxReportCellExpandButton.SetButtonAlignVert(Value: TdxReportCellExpandButtonAlignVert);
begin
end;

procedure TdxReportCellExpandButton.ReadData(AReader: TdxPSDataReader);
begin
  inherited ReadData(AReader);
  ButtonInteriorColor := AReader.ReadInteger;
  ButtonSize := AReader.ReadInteger;
end;

procedure TdxReportCellExpandButton.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited WriteData(AWriter);
  AWriter.WriteInteger(ButtonInteriorColor);
  AWriter.WriteInteger(ButtonSize);
end;

function TdxReportCellExpandButton.GetActualButtonSize: Integer;
var
  LineThickness: Integer;
begin
  Result := ButtonSize;
  
  LineThickness := Renderer.LineThickness;
  if (Result mod LineThickness) > (LineThickness div 2) then 
    Inc(Result, LineThickness - (Result mod LineThickness))
  else
    Dec(Result, Result mod LineThickness);
end;

function TdxReportCellExpandButton.GetButtonBorder3D: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonBorder3D);
end;

function TdxReportCellExpandButton.GetButtonBorder3DSoft: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonBorder3DSoft);
end;

function TdxReportCellExpandButton.GetButtonBorderShadow: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonBorderShadow);
end;

function TdxReportCellExpandButton.GetButtonExpanded: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonExpanded);
end;

function TdxReportCellExpandButton.GetButtonTransparent: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonTransparent);
end;

function TdxReportCellExpandButton.GetShowButtonBorder: Boolean;
begin                                                   
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonShowBorder);
end;

function TdxReportCellExpandButton.GetKeepOddSize: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonKeepOddSize);
end;

function TdxReportCellExpandButton.GetShowButton: Boolean;
begin
  Result := GetFormatBit(dxPSGlbl.dxFormatExpandButtonVisible);
end;

function TdxReportCellExpandButton.GetTreeLineMode: TdxPSTreeLineMode;
begin
  Result := TdxPSTreeLineMode((Format and dxPSGlbl.dxFormatTreeLineModeMask) shr dxPSGlbl.dxFormatTreeLineModeOffset);
end;

procedure TdxReportCellExpandButton.SetButtonBorder3D(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonBorder3D, Value);
end;

procedure TdxReportCellExpandButton.SetButtonBorder3DSoft(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonBorder3DSoft, Value);
end;

procedure TdxReportCellExpandButton.SetButtonBorderShadow(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonBorderShadow, Value);
end;

procedure TdxReportCellExpandButton.SetButtonExpanded(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonExpanded, Value);
end;

procedure TdxReportCellExpandButton.SetButtonTransparent(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonTransparent, Value);  
end;

procedure TdxReportCellExpandButton.SetKeepOddSize(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonKeepOddSize, Value);
end;

procedure TdxReportCellExpandButton.SetShowButton(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonVisible, Value);
end;

procedure TdxReportCellExpandButton.SetShowButtonBorder(Value: Boolean);
begin
  SetFormatBit(dxPSGlbl.dxFormatExpandButtonShowBorder, Value);
end;
    
procedure TdxReportCellExpandButton.SetTreeLineMode(Value: TdxPSTreeLineMode);
begin
  Format := Format and not dxPSGlbl.dxFormatTreeLineModeMask or (Byte(Value) shl dxPSGlbl.dxFormatTreeLineModeOffset);
end;

{ TdxReportCellExpandButtonEx }

function TdxReportCellExpandButtonEx.GetButtonAlignHorz: TdxReportCellExpandButtonAlignHorz;
begin
  Result := TdxReportCellExpandButtonAlignHorz((FormatEx and dxPSGlbl.dxFormatExButtonAlignHorzMask) shr dxPSGlbl.dxFormatExButtonAlignHorzOffset);
end;

function TdxReportCellExpandButtonEx.GetButtonAlignVert: TdxReportCellExpandButtonAlignVert;
begin
  Result := TdxReportCellExpandButtonAlignVert((FormatEx and dxPSGlbl.dxFormatExButtonAlignVertMask) shr dxPSGlbl.dxFormatExButtonAlignVertOffset);
end;

function TdxReportCellExpandButtonEx.GetButtonIndents: TRect;
begin
  Result := inherited GetButtonIndents;
  if Renderer <> nil then
    with Result do 
    begin
      Inc(Top, 5 * LineThickness);
      Inc(Bottom, 5 * LineThickness);
    end;  
end;

procedure TdxReportCellExpandButtonEx.SetButtonAlignHorz(Value: TdxReportCellExpandButtonAlignHorz);
begin
  FormatEx := FormatEx and not dxPSGlbl.dxFormatExButtonAlignHorzMask or (Byte(Value) shl dxPSGlbl.dxFormatExButtonAlignHorzOffset);
end;

procedure TdxReportCellExpandButtonEx.SetButtonAlignVert(Value: TdxReportCellExpandButtonAlignVert); 
begin
  FormatEx := FormatEx and not dxPSGlbl.dxFormatExButtonAlignVertMask or (Byte(Value) shl dxPSGlbl.dxFormatExButtonAlignVertOffset);
end;

procedure TdxReportCellExpandButtonEx.ReadData(AReader: TdxPSDataReader);
begin
  inherited;
  FormatEx := AReader.ReadInteger;
end;

procedure TdxReportCellExpandButtonEx.WriteData(AWriter: TdxPSDataWriter);
begin
  inherited;
  AWriter.WriteInteger(FormatEx);
end;

{ TdxPSExplorerChangeNotifier }

constructor TdxPSExplorerChangeNotifier.Create(AnExplorer: TCustomdxPSExplorer);
begin
  inherited Create;
  Explorer := AnExplorer;
end;

destructor TdxPSExplorerChangeNotifier.Destroy;
begin
  Explorer := nil;
  inherited Destroy;
end;

procedure TdxPSExplorerChangeNotifier.SetExplorer(Value: TCustomdxPSExplorer);
begin
  if FExplorer <> Value then 
  begin
    if FExplorer <> nil then 
      FExplorer.UnregisterNotifier(Self);
    if Value <> nil then 
      Value.RegisterNotifier(Self);
  end;
end;

{ TdxPSExplorerChangeNotifierAdapter }

procedure TdxPSExplorerChangeNotifierAdapter.ExplorerRefresh(AStage: TdxPSExplorerRefreshStage);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.FolderPopulated(AFolder: TdxPSExplorerFolder);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemAdded(AnItem: TCustomdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemDataLoaded(AnItem: TdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemDataUnloaded(AnItem: TdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemDeleted(AnItem: TCustomdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemParentChanged(AnItem: TCustomdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem);
begin
end;

procedure TdxPSExplorerChangeNotifierAdapter.ItemRenamed(AnItem: TCustomdxPSExplorerItem);
begin
end;

{ TdxPSExplorerTreeChangeNotifier }

constructor TdxPSExplorerTreeChangeNotifier.Create(ATreeContainer: TCustomdxPSExplorerTreeContainer; 
  ARegister: Boolean = True);
begin
  Assert(ATreeContainer <> nil);
  FTreeContainer := ATreeContainer;
  inherited Create(TreeContainer.Explorer);
end;

procedure TdxPSExplorerTreeChangeNotifier.ExplorerRefresh(AStage: TdxPSExplorerRefreshStage);
begin
  case AStage of
    ersBefore:
      begin
        TreeContainer.EndEdit(True);
        TreeContainer.BeginUpdate;
        TreeContainer.SaveState;
      end;  
    ersAfter: 
      begin
        if Explorer <> nil then Explorer.BuildTree(TreeContainer);
        TreeContainer.RestoreState;
        TreeContainer.RefreshSorting(nil);
        TreeContainer.EndUpdate;
      end;  
  end;    
end;

procedure TdxPSExplorerTreeChangeNotifier.FolderPopulated(AFolder: TdxPSExplorerFolder);
begin
  if Explorer <> nil then Explorer.PopulateTreeFolder(TreeContainer, AFolder);
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemAdded(AnItem: TCustomdxPSExplorerItem);
begin
  with TreeContainer do 
  begin
    AddItem(CreationParent, AnItem);
    SelectedItem := AnItem;
    if Control.Focused then BeginEdit(True);
  end;  
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemDataLoaded(AnItem: TdxPSExplorerItem);
begin
  TreeContainer.MakeItemVisible(AnItem);
  TreeContainer.InvalidateItem(AnItem);
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemDataUnloaded(AnItem: TdxPSExplorerItem);
begin
  TreeContainer.InvalidateItem(AnItem);
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemDeleted(AnItem: TCustomdxPSExplorerItem);
begin
  TreeContainer.DeleteItem(AnItem);
end;
                                        
procedure TdxPSExplorerTreeChangeNotifier.ItemParentChanged(AnItem: TCustomdxPSExplorerItem);
begin
  TreeContainer.MoveItem(AnItem);
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem);
begin
  if TreeContainer.SelectedItem = AnItem then 
    TreeContainer.SelectedItemText := AnItem.DisplayName;
end;

procedure TdxPSExplorerTreeChangeNotifier.ItemRenamed(AnItem: TCustomdxPSExplorerItem);
begin
  TreeContainer.RenameItem(AnItem);
end;

{ TCustomdxPSExplorerTreeContainer }

constructor TCustomdxPSExplorerTreeContainer.Create(AnExplorer: TCustomdxPSExplorer;
  AHost: IdxPSExplorerTreeContainerHost);
begin
  Assert(AnExplorer <> nil);
  Assert(AHost <> nil);

  inherited Create;
  FExplorer := AnExplorer;
  FHost := AHost;
  
  CreateTreeContainer;
  FChangeNotifier := TdxPSExplorerTreeChangeNotifier.Create(Self, True);
end;

destructor TCustomdxPSExplorerTreeContainer.Destroy;
begin
  FreeAndNil(FControl);
  FreeAndNil(FChangeNotifier);
  inherited Destroy;
end;

class function TCustomdxPSExplorerTreeContainer.ControlClass: TWinControlClass;
begin
  Result := nil;
end;

class procedure TCustomdxPSExplorerTreeContainer.Register;
begin
  dxPSExplorerTreeContainerFactory.Register(Self);
end;

class procedure TCustomdxPSExplorerTreeContainer.Unregister;
begin
  dxPSExplorerTreeContainerFactory.Unregister(Self);
end;

procedure TCustomdxPSExplorerTreeContainer.BeginUpdate;
begin
end;

procedure TCustomdxPSExplorerTreeContainer.EndUpdate;
begin
end;

function TCustomdxPSExplorerTreeContainer.CanCreateFolder: Boolean;
begin 
  Result := Explorer.CanCreateFolder and not IsEditing and IsFolderSelected;
end;

function TCustomdxPSExplorerTreeContainer.CanCreateItem: Boolean;
begin
  Result := Explorer.CanCreateItem and not IsEditing;
end;

function TCustomdxPSExplorerTreeContainer.CanDeleteSelection: Boolean;
begin
  Result := not IsEditing and Explorer.CanDelete(SelectedItem);
end;

function TCustomdxPSExplorerTreeContainer.CanLoadSelectedItemData: Boolean;    
begin
  Result := (Control <> nil) and Control.Focused and not IsEditing and 
    IsItemSelected and TdxPSExplorerItem(SelectedItem).CanLoadData;
end;

function TCustomdxPSExplorerTreeContainer.CanRefresh: Boolean;
begin
  Result := not IsEditing;
end;

function TCustomdxPSExplorerTreeContainer.CanRenameSelectedItem: Boolean;
begin
  Result := not IsEditing and Explorer.CanRename(SelectedItem);
end;

function TCustomdxPSExplorerTreeContainer.CanShowPropertySheetsForSelectedItem: Boolean;
begin
  Result := not IsEditing and (SelectedItem <> nil) and SelectedItem.HasPropertySheets;
end;
                 
function TCustomdxPSExplorerTreeContainer.CanUnloadItemData: Boolean;
begin
  Result := not IsEditing and (Host.ReportLink <> nil) and 
    Host.ReportLink.CanUnloadData and (Explorer.LoadedItem <> nil);
end;

function TCustomdxPSExplorerTreeContainer.CreateItem: TdxPSExplorerItem;
begin
  if CanCreateItem then 
    Result := Explorer.CreateNewItem(CreationParent, Host.ReportLink)
  else
    Result := nil;  
end;

procedure TCustomdxPSExplorerTreeContainer.DeleteSelection(AShowMessage: Boolean = True);
begin
  if CanDeleteSelection and (not AShowMessage or dxPSUtl.MessageQuestion(SelectedItem.DeleteMessageText)) then
    SelectedItem.Delete;
end;

function TCustomdxPSExplorerTreeContainer.IsSelectedItemCurrentlyLoaded: Boolean;
var
  Item: TCustomdxPSExplorerItem;
begin
  Item := SelectedItem;
  Result := (Item is TdxPSExplorerItem) and TdxPSExplorerItem(Item).IsCurrentlyLoaded;
end;

procedure TCustomdxPSExplorerTreeContainer.LoadSelectedItemData;
begin
  if CanLoadSelectedItemData then 
    Explorer.LoadItemData(TdxPSExplorerItem(SelectedItem), Host.ReportLink);
end;

procedure TCustomdxPSExplorerTreeContainer.RenameSelectedItem;
begin
  if CanRenameSelectedItem then BeginEdit(True);
end;

function TCustomdxPSExplorerTreeContainer.ShowSelectedItemPropertySheets: Boolean;
begin
  Result := CanShowPropertySheetsForSelectedItem and TdxPSExplorerItem(SelectedItem).ShowPropertySheets;
end;

procedure TCustomdxPSExplorerTreeContainer.UnloadItemData;
begin
  if CanUnloadItemData then
    Explorer.UnloadItemData(Explorer.LoadedItem);
end;

function TCustomdxPSExplorerTreeContainer.CanFocus: Boolean;
begin
  Result := (Control <> nil) and Control.CanFocus;
end;
          
procedure TCustomdxPSExplorerTreeContainer.SetFocus;
begin
  if (Control <> nil) and Control.CanFocus and not IsRectEmpty(Control.ClientRect) then 
    Control.SetFocus;
end;

procedure TCustomdxPSExplorerTreeContainer.RefreshSorting(ANode: TObject);
begin
end;

procedure TCustomdxPSExplorerTreeContainer.RefreshSorting(AFolder: TdxPSExplorerFolder);
begin
  
end;

procedure TCustomdxPSExplorerTreeContainer.DeleteItem(AnItem: TCustomdxPSExplorerItem);
begin
  EndEdit(False);
end;

procedure TCustomdxPSExplorerTreeContainer.InvalidateItem(AnItem: TCustomdxPSExplorerItem);
begin
end;

procedure TCustomdxPSExplorerTreeContainer.RestoreState;
begin
end;

procedure TCustomdxPSExplorerTreeContainer.SaveState;
begin
end;

procedure TCustomdxPSExplorerTreeContainer.CreateTreeContainer;
begin
  if FControl = nil then 
  begin 
    FControl := ControlClass.Create(nil);
    FControl.Parent := Host.TreeContainerParent;
    InitializeTreeContainer;
  end;  
end;

procedure TCustomdxPSExplorerTreeContainer.InitializeTreeContainer;
begin
end;
           
procedure TCustomdxPSExplorerTreeContainer.ProcessKeyDown(var Key: Word; Shift: TShiftState);
var
  PopupMenu: TPopupMenu;
  MenuItem: TMenuItem;
begin
  PopupMenu := dxPSUtl.Control_GetPopupMenu(Control);
  if PopupMenu <> nil then
  begin
    MenuItem := PopupMenu.FindItem(Key, fkShortCut);
    if (MenuItem <> nil) and MenuItem.Enabled and MenuItem.Visible then
    begin
      MenuItem.Click;
      Key := 0;
      Exit;
    end
  end;  

  if not IsEditing then 
    case Key of
      VK_F2:
        if cxShiftStateMoveOnly(Shift) then BeginEdit(True);
      VK_F5:
        if cxShiftStateMoveOnly(Shift) then Explorer.Refresh;
      VK_DELETE: 
        if cxShiftStateMoveOnly(Shift) then DeleteSelection(True);
      VK_ESCAPE:
        Host.UpdateState;
      VK_RETURN: 
        if ssCtrl in Shift then LoadSelectedItemData;
    end;
end;
   
procedure TCustomdxPSExplorerTreeContainer.ProcessKeyPress(var Key: Char);
begin
  if IsEditing and not Explorer.AcceptItemNameChar(SelectedItem, Key) then 
    Key := #0;
end;

{ TdxPSExplorerTreeBuilder }

class procedure TdxPSExplorerTreeBuilder.Register;
begin
  dxPSExplorerTreeBuilderFactory.Register(Self);
end;

class procedure TdxPSExplorerTreeBuilder.Unregister;
begin
  dxPSExplorerTreeBuilderFactory.Unregister(Self);
end;

class procedure TdxPSExplorerTreeBuilder.BuildTree(AnExplorer: TCustomdxPSExplorer; 
  ATreeContainer: TCustomdxPSExplorerTreeContainer);
begin
  with ATreeContainer do 
  begin
    BeginUpdate;
    try
      Clear;                   
      CreateFolderNode(ATreeContainer, nil, AnExplorer.Root);
      ExpandItem(AnExplorer.Root);
      SelectedItem := AnExplorer.Root;
    finally
      EndUpdate;
    end;
  end;  
end;                       

class procedure TdxPSExplorerTreeBuilder.CreateFolderNode(ATreeContainer: TCustomdxPSExplorerTreeContainer;
  AParent, AFolder: TdxPSExplorerFolder);
begin
  CreateItemNode(ATreeContainer, AParent, AFolder);
  PopulateTreeFolder(ATreeContainer, AFolder);
end;

class procedure TdxPSExplorerTreeBuilder.CreateItemNode(ATreeContainer: TCustomdxPSExplorerTreeContainer;
  AParent: TdxPSExplorerFolder; AnItem: TCustomdxPSExplorerItem);
begin
  ATreeContainer.AddItem(AParent, AnItem);
end;
  
class procedure TdxPSExplorerTreeBuilder.PopulateTreeFolder(ATreeContainer: TCustomdxPSExplorerTreeContainer; 
  AFolder: TdxPSExplorerFolder);
var
  I: Integer;
begin
  with ATreeContainer do 
  begin
    BeginUpdate;
    try
      for I := 0 to AFolder.FolderCount - 1 do
        CreateFolderNode(ATreeContainer, AFolder, AFolder.Folders[I]);
      for I := 0 to AFolder.ItemCount - 1 do
        CreateItemNode(ATreeContainer, AFolder, AFolder.Items[I]);
    finally
      EndUpdate;
    end;
    //RefreshSorting(AFolder); {3.1}
  end;  
end;

{ TdxPSExplorerItemPropertySheets }

constructor TCustomdxPSExplorerItemPropertySheets.CreateEx(AnExplorerItem: TCustomdxPSExplorerItem); 
begin
  Create(nil);
  FExplorerItem := AnExplorerItem;
end;

class function TCustomdxPSExplorerItemPropertySheets.Execute(AnExplorerItem: TCustomdxPSExplorerItem): Boolean;
begin
  with FormClass.CreateEx(AnExplorerItem) do
  try
    Initialize;
    try
      Result := ShowModal = mrOK;
    finally
      Done;
    end;  
  finally
    Free;
  end;
end;

function TCustomdxPSExplorerItemPropertySheets.ExplorerItem: TCustomdxPSExplorerItem;
begin
  Result := FExplorerItem;
end;

procedure TCustomdxPSExplorerItemPropertySheets.Done;
begin
end;

procedure TCustomdxPSExplorerItemPropertySheets.Initialize;
begin
end;

class function TCustomdxPSExplorerItemPropertySheets.FormClass: TCustomdxPSExplorerItemPropertySheetsClass;
begin
  Result := TCustomdxPSExplorerItemPropertySheetsClass(Self);
end;

{ TCustomdxPSExplorerItemComparator }

class function TCustomdxPSExplorerItemComparator.CompareItems(
  AnItem1, AnItem2: Pointer): Integer;
begin
  Result := TCustomdxPSExplorerItem(AnItem1).CompareTo(TCustomdxPSExplorerItem(AnItem2));
end;

{ TCustomdxPSExplorerItemHelper }

class function TCustomdxPSExplorerItemHelper.GetHasChildren(AFolder: TdxPSExplorerFolder): Boolean;
begin
  Result := False;
end;

class function TCustomdxPSExplorerItemHelper.GetImageIndex(AnItem: TCustomdxPSExplorerItem): Integer;
begin
  Result := AnItem.GetImageIndex;
end;

class function TCustomdxPSExplorerItemHelper.GetSelectedIndex(AnItem: TCustomdxPSExplorerItem): Integer;
begin
  Result := AnItem.GetSelectedIndex;
end;

class procedure TCustomdxPSExplorerItemHelper.SetHasChildren(AFolder: TdxPSExplorerFolder; Value: Boolean);
begin
end;

{ TCustomdxPSExplorerItem }
    
constructor TCustomdxPSExplorerItem.Create(AnExplorer: TCustomdxPSExplorer; 
  AParent: TdxPSExplorerFolder);
begin
  inherited Create;
  Assert(AnExplorer <> nil);
  FExplorer := AnExplorer;
  Parent := AParent;
  FName := GetNewName(nil);
  FWindowHandle := dxPSUtl.dxAllocatehWnd(WndProc);
end;

destructor TCustomdxPSExplorerItem.Destroy;
begin
  dxPSUtl.dxDeallocatehWnd(FWindowHandle);
  if Parent <> nil then Parent.Remove(Self);
  inherited;
end;

function TCustomdxPSExplorerItem.Explorer: TCustomdxPSExplorer;
begin
  Result := FExplorer;
end;

function TCustomdxPSExplorerItem.CanAccept(AnItem: TCustomdxPSExplorerItem): Boolean;
begin
  Result := False;
end;

function TCustomdxPSExplorerItem.CanDelete: Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorerItem.CanMove: Boolean;
begin
  Result := (Explorer = nil) or Explorer.CanMove(Self);
end;

function TCustomdxPSExplorerItem.CanMoveTo(AParent: TCustomdxPSExplorerItem): Boolean;
begin
  Result := ((Explorer = nil) or Explorer.CanMoveTo(Self, AParent)) and 
    (AParent <> nil) and AParent.CanAccept(Self);
end;

function TCustomdxPSExplorerItem.CanRename: Boolean;
begin
  Result := (Explorer = nil) or Explorer.CanRename(Self);
end;

function TCustomdxPSExplorerItem.CanRenameTo(const AName: string): Boolean;
begin
  Result := (Explorer = nil) or Explorer.CanRenameTo(Self, AName);
end;

procedure TCustomdxPSExplorerItem.Delete;
begin
  if CanDelete and (Explorer <> nil) then 
    Explorer.Delete(Self);
end;

function TCustomdxPSExplorerItem.GetUniqueID(out AnUniqueID: TBytes): Integer;
begin
  SetLength(AnUniqueID, 0);
  Result := 0;
end;

function TCustomdxPSExplorerItem.HasAsParent(AnItem: TCustomdxPSExplorerItem): Boolean;
var
  ItemParent: TCustomdxPSExplorerItem;
begin
  Result := not ((AnItem = nil) or (Parent = Self));
  if Result then
  begin
    ItemParent := Parent;
    while (ItemParent <> nil) and (ItemParent <> AnItem) do 
      ItemParent := ItemParent.Parent;
    Result := ItemParent <> nil;
  end;  
end;

function TCustomdxPSExplorerItem.IsNameChanged(const ANewName: string): Boolean;
begin
  Result := not dxSameStr(ANewName, Name);
end;

class function TCustomdxPSExplorerItem.HasPropertySheets: Boolean;
begin
  Result := PropertySheetsClass <> nil;
end;

class function TCustomdxPSExplorerItem.PropertySheetsClass: TCustomdxPSExplorerItemPropertySheetsClass;
begin
  Result := nil;
end;

function TCustomdxPSExplorerItem.ShowPropertySheets: Boolean; 
begin
  Result := HasPropertySheets and PropertySheetsClass.Execute(Self);
end;

function TCustomdxPSExplorerItem.CannotRenameMessageText(const AOldName, ANewName: string): string;
begin
  Result := '';
end;

function TCustomdxPSExplorerItem.DeleteMessageText: string;
begin
  Result := '';
end;

function TCustomdxPSExplorerItem.OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string;
begin
  Result := '';
end;

function TCustomdxPSExplorerItem.GetDisplayName: string;
begin
  Result := Name;
end;

function TCustomdxPSExplorerItem.CompareTo(AnItem: TCustomdxPSExplorerItem): Integer;
begin
  Result := 0;
end;

function TCustomdxPSExplorerItem.DoDelete: Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorerItem.DoMove(AParent: TdxPSExplorerFolder): Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorerItem.DoRename(var ANewName: string): Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorerItem.GetImageIndex: Integer;
begin
  Result := -1;
end;

function TCustomdxPSExplorerItem.GetInfoTip: string;
begin
  Result := '';
end;

function TCustomdxPSExplorerItem.GetNewName(AReportLink: TBasedxReportLink): string;
begin
  Result := '';
end;

function TCustomdxPSExplorerItem.GetSelectedIndex: Integer;
begin
  Result := -1;
end;

procedure TCustomdxPSExplorerItem.InternalDelete;
begin
  if IsWindow(FWindowHandle) then 
    PostMessage(FWindowHandle, DXM_PS_FREEEXPLORERITEM, 0, 0);
end;

procedure TCustomdxPSExplorerItem.InternalMove(AParent: TdxPSExplorerFolder);
begin
  if Parent <> nil then Parent.Remove(Self);
  if AParent <> nil then AParent.Add(Self);
end;

procedure TCustomdxPSExplorerItem.InternalRename(const AName: string);
begin
  FName := AName;
end;

procedure TCustomdxPSExplorerItem.SetName(const Value: string);
begin
  if (FName <> Value) and CanRenameTo(Value) then
    Explorer.RenameTo(Self, Value);
end;

function GetItemStateInfoSize: Integer;
begin
  Result := SizeOf(TCustomdxPSExplorerItemStateInfo);
end;

function TCustomdxPSExplorerItem.GetItemStateInfo: TCustomdxPSExplorerItemStateInfo;
var
  Bytes: TBytes;
begin
  FillChar(Result, GetItemStateInfoSize, 0);
  Result.Count := 0;
  Result.UniqueIDSize := GetUniqueID(Bytes);
end;
    
procedure TCustomdxPSExplorerItem.WriteState(AStream: TStream);
var
  ItemInfo: TCustomdxPSExplorerItemStateInfo;
  Bytes: TBytes;
begin
  ItemInfo := GetItemStateInfo;
  AStream.WriteBuffer(ItemInfo, GetItemStateInfoSize);
  if ItemInfo.UniqueIDSize <> 0 then
  begin
    GetUniqueID(Bytes);
    AStream.WriteBuffer(Pointer(Bytes)^, ItemInfo.UniqueIDSize);
  end;
end;

procedure TCustomdxPSExplorerItem.WndProc(var Message: TMessage);
begin
  with Message do
    if Msg = DXM_PS_FREEEXPLORERITEM then 
      Free
    else  
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TCustomdxPSExplorerItem.SetParent(Value: TdxPSExplorerFolder);
begin
  if (FParent <> Value) and CanMoveTo(Value) then
    Explorer.MoveTo(Self, Value);
end;
    
{ TdxPSExplorerFolderHelper }

class function TdxPSExplorerFolderHelper.GetHasChildren(AFolder: TdxPSExplorerFolder): Boolean;
begin
  Result := AFolder.HasChildren;
end;

class procedure TdxPSExplorerFolderHelper.SetHasChildren(AFolder: TdxPSExplorerFolder; 
  Value: Boolean);
begin
  AFolder.HasChildren := Value;
end;
    
{ TdxPSExplorerFolder }

constructor TdxPSExplorerFolder.Create(AnExplorer: TCustomdxPSExplorer; 
  AParent: TdxPSExplorerFolder);
begin
  inherited Create(AnExplorer, AParent);
  FFolders := TList.Create;
  FItems := TList.Create;
end;

destructor TdxPSExplorerFolder.Destroy;
begin
  FreeAndNilFolders;
  FreeAndNilItems;
  inherited Destroy;
end;

function TdxPSExplorerFolder.CanAccept(AnItem: TCustomdxPSExplorerItem): Boolean;
begin
  Result := (AnItem <> Self) and (AnItem.Parent <> Self) and not HasAsParent(AnItem);
end;

function TdxPSExplorerFolder.CanRenameTo(const AName: string): Boolean;
begin
  Result := inherited CanRenameTo(AName) and ((Parent = nil) or (Parent.FolderByName(AName) = nil));
end;

function TdxPSExplorerFolder.CreateFolder: TdxPSExplorerFolder;
begin
  Result := Explorer.CreateNewFolder(Self);
end;

function TdxPSExplorerFolder.CreateItem(AReportLink: TBasedxReportLink): TdxPSExplorerItem;
begin
  Result := Explorer.CreateNewItem(Self, AReportLink);
end;

procedure TdxPSExplorerFolder.Populate;
begin
  Explorer.PopulateFolder(Self);
end;

procedure TdxPSExplorerFolder.Delete;
begin
  if CanDelete then
  begin
    DeleteFolders;
    DeleteItems;
  end;  
  inherited Delete;
end;

procedure TdxPSExplorerFolder.DeleteFolders;
var
  I: Integer;
begin
  for I := FolderCount - 1 downto 0 do
    Folders[I].Delete;
end;

procedure TdxPSExplorerFolder.DeleteItems;
var
  I: Integer;
begin
  for I := ItemCount - 1 downto 0 do
    Items[I].Delete;
end;

function TdxPSExplorerFolder.HasFolders: Boolean;
begin
  Result := FolderCount <> 0;
end;

function TdxPSExplorerFolder.HasItems: Boolean;
begin
  Result := ItemCount <> 0;
end;

function TdxPSExplorerFolder.HasLoadedItem: Boolean;
var
  I: Integer;
begin
  if Explorer.LoadedItem <> nil then
  begin
    Result := True;
    for I := 0 to ItemCount - 1 do
      if Items[I] = Explorer.LoadedItem then Exit;
    for I := 0 to FolderCount - 1 do
      if Folders[I].HasLoadedItem then Exit;
    Result := False;
  end
  else
    Result := False;
end;

function TdxPSExplorerFolder.FolderByName(const AName: string): TdxPSExplorerFolder;
var
  I: Integer;
begin
  Populate;
  for I := 0 to FolderCount - 1 do
  begin
    Result := Folders[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

function TdxPSExplorerFolder.ItemByName(const AName: string): TdxPSExplorerItem;
var
  I: Integer;
begin
  for I := 0 to ItemCount - 1 do
  begin
    Result := Items[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

function TdxPSExplorerFolder.CannotRenameMessageText(const AOldName, ANewName: string): string;
begin
  Result := Format(cxGetResourceString(@sdxCannotRenameFolderText), [AOldName, ANewName]);
end;

function TdxPSExplorerFolder.DeleteMessageText: string;
begin
  if HasFolders or HasItems then
    Result := Format(cxGetResourceString(@sdxDeleteNonEmptyFolderMessageText), [DisplayName])
  else
    Result := Format(cxGetResourceString(@sdxDeleteFolderMessageText), [DisplayName]);
end;

function TdxPSExplorerFolder.OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string;
begin
  Result := Format(cxGetResourceString(@sdxOverwriteFolderMessageText), [Dest.DisplayName, DisplayName]);
end;

function TdxPSExplorerFolder.CompareTo(AnItem: TCustomdxPSExplorerItem): Integer;
begin
  if AnItem is TdxPSExplorerFolder then 
    Result := CompareText(DisplayName, AnItem.DisplayName)
  else
    Result := -1;
end;

function TdxPSExplorerFolder.GetItemStateInfo: TCustomdxPSExplorerItemStateInfo;
begin
  Result := inherited GetItemStateInfo;
  Result.Count := FolderCount + ItemCount;
end;

procedure TdxPSExplorerFolder.WriteState(AStream: TStream);
var
  I: Integer;
begin
  inherited;
  for I := 0 to FolderCount - 1 do 
    Folders[I].WriteState(AStream);
  for I := 0 to ItemCount - 1 do 
    Items[I].WriteState(AStream);
end;

procedure TdxPSExplorerFolder.LoadData;
begin
  Explorer.LoadData(Self);
end;

function TdxPSExplorerFolder.GetImageIndex: Integer;
begin
  Result := iiExplorerFolderCollapsed;
end;

function TdxPSExplorerFolder.GetNewName(AReportLink: TBasedxReportLink): string;
var
  Index: Integer;
  Template: string;
begin
  Result := cxGetResourceString(@sdxNewExplorerFolderItem);
  if (Parent <> nil) and (Parent.FolderByName(Result) <> nil) then
  begin
    Index := 1;
    Template := Result;
    repeat
      Inc(Index);
      Result := Template + ' (' + IntToStr(Index) + ')';
    until Parent.FolderByName(Result) = nil;
  end;
end;

function TdxPSExplorerFolder.GetSelectedIndex: Integer;
begin
  Result := iiExplorerFolderExpanded;
end;

procedure TdxPSExplorerFolder.Add(AnItem: TCustomdxPSExplorerItem);
begin
  GetItemList(AnItem).Add(AnItem);
  AnItem.FParent := Self;
  HasChildren := True;
end;

procedure TdxPSExplorerFolder.Remove(AnItem: TCustomdxPSExplorerItem);
begin
  AnItem.FParent := nil;
  GetItemList(AnItem).Remove(AnItem);
  if FolderCount + ItemCount = 0 then
    HasChildren := False;
end;

procedure TdxPSExplorerFolder.FreeAndNilFolders;
var
  I: Integer;
begin
  for I := FolderCount - 1 downto 0 do
    Folders[I].Free;
  FreeAndNil(FFolders);  
end;  
  
procedure TdxPSExplorerFolder.FreeAndNilItems;
var
  I: Integer;
begin
  for I := ItemCount - 1 downto 0 do
    Items[I].Free;
  FreeAndNil(FItems);  
end;  

function TdxPSExplorerFolder.GetFolder(Index: Integer): TdxPSExplorerFolder;
begin
  Result := TdxPSExplorerFolder(FFolders[Index]);
end;

function TdxPSExplorerFolder.GetFolderCount: Integer;
begin
  if FFolders <> nil then 
    Result := FFolders.Count
  else
    Result := 0;  
end;

function TdxPSExplorerFolder.GetHasChildren: Boolean;
begin
  Result := FHasChildren or (FolderCount + ItemCount <> 0);
end;

function TdxPSExplorerFolder.GetIsRoot: Boolean;
begin
  Result := Self = Explorer.Root;
end;

function TdxPSExplorerFolder.GetItem(Index: Integer): TdxPSExplorerItem;
begin
  Result := TdxPSExplorerItem(FItems[Index]);
end;

function TdxPSExplorerFolder.GetItemCount: Integer;
begin
  if FItems <> nil then 
    Result := FItems.Count
  else
    Result := 0;  
end;

function TdxPSExplorerFolder.GetItemList(AnItem: TCustomdxPSExplorerItem): TList;
begin
  Result := GetItemList(TCustomdxPSExplorerItemClass(AnItem.ClassType));
end;

function TdxPSExplorerFolder.GetItemList(AnItemClass: TCustomdxPSExplorerItemClass): TList;
begin
  if AnItemClass.InheritsFrom(TdxPSExplorerItem) then 
    Result := FItems
  else  
    if AnItemClass.InheritsFrom(TdxPSExplorerFolder) then
      Result := FFolders
    else  
      Result := nil;
end;

procedure TdxPSExplorerFolder.SetHasChildren(Value: Boolean);
begin
  FHasChildren := Value or (FolderCount + ItemCount <> 0);
end;

{ TdxPSExplorerItem }

constructor TdxPSExplorerItem.Create(AnExplorer: TCustomdxPSExplorer; AParent: TdxPSExplorerFolder);
begin
  inherited;
  FReportDocument := TdxPSReportDocument.Create(nil);
  FReportDocument.OnChanged := DocumentChanged;
end;

destructor TdxPSExplorerItem.Destroy;
begin
  FreeAndNil(FReportDocument);
  inherited;
end;

function TdxPSExplorerItem.CanLoadData: Boolean;
begin
  Result := not HasInvalidData and not IsCurrentlyLoaded;
end;

function TdxPSExplorerItem.CanRenameTo(const AName: string): Boolean;
begin
  Result := inherited CanRenameTo(AName) and ((Parent = nil) or (Parent.ItemByName(AName) = nil));
end;

function TdxPSExplorerItem.CannotRenameMessageText(const AOldName, ANewName: string): string;
begin
  Result := Format(cxGetResourceString(@sdxCannotRenameItemText), [AOldName, ANewName]);
end;

function TdxPSExplorerItem.DataLoadErrorText: string;
begin
  Result := cxGetResourceString(@sdxDataLoadErrorText);
end;

function TdxPSExplorerItem.DeleteMessageText: string;
begin
  Result := Format(cxGetResourceString(@sdxDeleteItemMessageText), [DisplayName]);
end;

function TdxPSExplorerItem.OverwriteMessageText(Dest: TCustomdxPSExplorerItem): string;
begin
  Result := Format(cxGetResourceString(@sdxOverwriteItemMessageText), [Dest.DisplayName, DisplayName]);
end;

function TdxPSExplorerItem.CreateDataStream(AMode: TdxPSStreamMode): TStream;
begin
  Result := Explorer.CreateItemDataStream(Self, AMode);
end;

procedure TdxPSExplorerItem.RetrieveReportData(AReportLink: TBasedxReportLink);
var
  Stream: TStream;
begin
  if AReportLink <> nil then
  begin
    Stream := CreateDataStream(smWrite);
    if Stream <> nil then
    try  
      AReportLink.SaveDataToStream(Stream);
    finally
      Stream.Free;
    end; 
  end;  
end;

function TdxPSExplorerItem.IsLoading: Boolean;
begin
  Result := (Explorer <> nil) and Explorer.IsLoading;
end;

procedure TdxPSExplorerItem.Load(AReportLink: TBasedxReportLink);
begin
  if Explorer <> nil then
    Explorer.LoadItemData(Self, AReportLink);
end;

procedure TdxPSExplorerItem.Unload;
begin
  Explorer.UnloadItemData(Self);
end;

class function TdxPSExplorerItem.PropertySheetsClass: TCustomdxPSExplorerItemPropertySheetsClass;
begin
  Result := TdxfmPSReportProperties;
end;

function TdxPSExplorerItem.CompareTo(AnItem: TCustomdxPSExplorerItem): Integer;
begin
  if AnItem is TdxPSExplorerItem then 
    Result := CompareText(DisplayName, AnItem.DisplayName)
  else
    Result := 1;
end;

function TdxPSExplorerItem.DoDelete: Boolean;
begin
  if IsCurrentlyLoaded then Unload;
  Result := inherited DoDelete;
end;

function TdxPSExplorerItem.GetFormCaption: string;
begin
  Result := Name;
end;

function TdxPSExplorerItem.GetImageIndex: Integer;
begin
  if HasInvalidData then 
    Result := iiExplorerItemHasInvalidData
  else   
    Result := iiExplorerItem;
end;

function TdxPSExplorerItem.GetInfoTip: string;
begin
  Result := ReportDocument.InfoTip;
end;

function TdxPSExplorerItem.GetNewName(AReportLink: TBasedxReportLink): string;
var
  Index: Integer;
  Template: string;
begin
  Result := cxGetResourceString(@sdxNewReport);
  if AReportLink <> nil then
    Result := AReportLink.GetNewReportStorageName;
  if (Parent <> nil) and (Parent.ItemByName(Result) <> nil) then
  begin
    Index := 1;
    Template := ChangeFileExt(Result, '');
    repeat
      Inc(Index);
      Result := Template + ' (' + IntToStr(Index) + ')';
    until Parent.ItemByName(Result) = nil;
  end;
end;

function TdxPSExplorerItem.GetSelectedIndex: Integer;
begin
  if HasInvalidData then 
    Result := iiExplorerItemHasInvalidData
  else   
    Result := iiExplorerItem;
end;

procedure TdxPSExplorerItem.InternalDelete;
begin
  SaveDocument;
  inherited;
end;

procedure TdxPSExplorerItem.DocumentChanged(Sender: TObject);
begin
  if not IsLoading then 
  begin
    Name := ReportDocument.Caption;
    Explorer.NotifyItemPropertiesChanged(Self);
  end;  
end;

procedure TdxPSExplorerItem.SaveDocument;
var
  Stream: TStream;
  OffsetTable: TdxPSDataStorageOffsetTable;
  P: Integer;
  Writer: TdxPSDataWriter;
begin
  Stream := CreateDataStream(smWrite);
  if Stream <> nil then
  try
    OffsetTable := TBasedxReportLink.ExtractOffsetTable(Stream, True);
    try
      P := Stream.Position;
      try
        Stream.Position := OffsetTable.Document;
        Writer := TBasedxReportLink.CreateDataWriter(Stream);
        try
          ReportDocument.WriteData(Writer);
        finally
          Writer.Free;
        end;
      finally  
        Stream.Position := P;
      end;
    finally
      OffsetTable.Free;
    end;  
  finally
    Stream.Free;
  end;
end;

procedure TdxPSExplorerItem.SetReportData(AReportLink: TBasedxReportLink);
var
  Stream: TStream;
begin
  if AReportLink <> nil then
  begin
    Stream := CreateDataStream(smRead);
    if Stream <> nil then
    try
      try
        AReportLink.LoadDataFromStream(Stream);
      except
        AReportLink.FinalizeDataStream;
        HasInvalidData := True;
        raise;
      end;  
    finally
      Stream.Free;
    end;  
  end;  
end;

function TdxPSExplorerItem.GetIsCurrentlyLoaded: Boolean;
begin
  Result := Explorer.LoadedItem = Self;
end;

procedure TdxPSExplorerItem.SetHasInvalidData(Value: Boolean);
begin
  if FHasInvalidData <> Value then
  begin
    FHasInvalidData := Value;
  end;
end;

{ TCustomdxPSExplorerContextCommand }
  
constructor TCustomdxPSExplorerContextCommand.Create(AnExplorer: TCustomdxPSExplorer);
begin
  inherited Create;
  FBitmap := TBitmap.Create;
  FExplorer := AnExplorer;
end;

destructor TCustomdxPSExplorerContextCommand.Destroy;
begin
  FBitmap.Free;
  inherited;
end;
    
function TCustomdxPSExplorerContextCommand.Enabled: Boolean;
begin
  Result := True;
end;

procedure TCustomdxPSExplorerContextCommand.Execute;
begin
end;
    
function TCustomdxPSExplorerContextCommand.Explorer: TCustomdxPSExplorer;
begin
  Result := FExplorer;
end;

procedure TCustomdxPSExplorerContextCommand.SetBitmap(Value: TBitmap);
begin
  Bitmap.Assign(Value);
end;
 
{ TdxPSExplorerContextCommandSeparator }

constructor TdxPSExplorerContextCommandSeparator.Create(AnExplorer: TCustomdxPSExplorer);
begin
  inherited;
  Caption := dxPSGlbl.cMenuSeparator;
end;

function TdxPSExplorerContextCommandSeparator.Enabled: Boolean;
begin
  Result := False;
end;
    
{ TdxPSExplorerRefreshContextCommand }

constructor TdxPSExplorerRefreshContextCommand.Create(AnExplorer: TCustomdxPSExplorer);
begin
  inherited;
  Caption := cxGetResourceString(@sdxMenuExplorerRefresh);
  Hint := cxGetResourceString(@sdxHintExplorerRefresh);
  ShortCut := Menus.TextToShortCut('F5');
  Bitmap_LoadFromResourceName(Bitmap, IDB_DXPSREFRESH);
  Bitmap.Transparent := True;
end;

procedure TdxPSExplorerRefreshContextCommand.Execute;
begin
  Explorer.Refresh;
end;
    
{ TCustomdxPSExplorer }

constructor TCustomdxPSExplorer.Create(AOwner: TComponent);
begin
  inherited;
  FNotifiers := TList.Create;
  FCommands := TList.Create;
end;

destructor TCustomdxPSExplorer.Destroy;
begin
  FreeAndNilCommands;
  ReleaseAndNilNotifiers;
  FreeAndNil(FRoot);
  inherited;
end;

function TCustomdxPSExplorer.LoadedItem: TdxPSExplorerItem;
begin
  Result := FLoadedItem;
end;

function TCustomdxPSExplorer.CanCreateFolder: Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorer.CanCreateItem: Boolean;
begin
  Result := True;
end;

function TCustomdxPSExplorer.CreateNewFolder(AParent: TdxPSExplorerFolder): TdxPSExplorerFolder;
begin               
  Include(FState, esFolderCreating);
  try
    Result := GetFolderClass.Create(Self, AParent);
    //DoCreateNewFolder(Result);
    NotifyItemAdded(Result);
  finally
    Exclude(FState, esFolderCreating);
  end;
end;
                                                                
function TCustomdxPSExplorer.CreateNewItem(AParent: TdxPSExplorerFolder; 
  AReportLink: TBasedxReportLink): TdxPSExplorerItem;
begin
  Include(FState, esItemCreating);
  try
    Result := GetItemClass.Create(Self, AParent);
    Result.FName := Result.GetNewName(AReportLink);
    AReportLink.ReportDocument.RetrievePreview;
    with Result.ReportDocument do
    begin
      BeginUpdate;
      try
        Assign(AReportLink.ReportDocument);
      finally
        CancelUpdate;
      end;
    end;
    
    //DoCreateNewItem(Result);
    NotifyItemAdded(Result);
  finally
    Exclude(FState, esItemCreating);
  end;  
end;

procedure TCustomdxPSExplorer.BuildTree(ATreeContainer: TCustomdxPSExplorerTreeContainer);
begin
  dxPSExplorerTreeBuilderFactory_ActiveBuilderClass.BuildTree(Self, ATreeContainer);
  //dxPSExplorerTreeBuilderFactory.ActiveBuilderClass.BuildTree(Self, ATreeContainer);
  if LoadedItem <> nil then
    ATreeContainer.MakeItemVisible(LoadedItem);
end;

function TCustomdxPSExplorer.CreateTree(const AHost: IdxPSExplorerTreeContainerHost): TCustomdxPSExplorerTreeContainer;
begin
  Result := dxPSExplorerTreeContainerFactory.ActiveTreeContainerClass.Create(Self, AHost);
end;

function TCustomdxPSExplorer.FindCustomItemByUniqueID(const AnUniqueID: TBytes): TCustomdxPSExplorerItem;
begin
  Result := nil;
end;

procedure TCustomdxPSExplorer.LoadItemData(AnItem: TdxPSExplorerItem; 
  AReportLink: TBasedxReportLink);
begin
  if LoadedItem <> nil then 
    NotifyItemDataUnloaded(LoadedItem);
    
  try
    AnItem.SetReportData(AReportLink);
    FLoadedItem := AnItem;
    NotifyItemDataLoaded(AnItem);
  except
    FLoadedItem := nil;
    DoItemDataLoadError(AnItem);
  end;  
end;

procedure TCustomdxPSExplorer.UnloadItemData(AnItem: TdxPSExplorerItem);
begin
  FLoadedItem := nil;
  NotifyItemDataUnloaded(AnItem);
end;
  
procedure TCustomdxPSExplorer.Refresh;
begin
  BeforeRefresh;
  try
    DoRefresh;
  finally  
    AfterRefresh;
  end;  
end;

procedure TCustomdxPSExplorer.RegisterNotifier(ANotifier: TdxPSExplorerChangeNotifier);
begin
  if IndexOfNotifier(ANotifier) = -1 then 
  begin
    FNotifiers.Add(ANotifier);
    ANotifier.FExplorer := Self;
  end;  
end;

procedure TCustomdxPSExplorer.UnregisterNotifier(ANotifier: TdxPSExplorerChangeNotifier);
begin
  FNotifiers.Remove(ANotifier);
  ANotifier.FExplorer := nil;
end;

{$IFNDEF DELPHI6}

{ IUnknown }

function TCustomdxPSExplorer.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then                      
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TCustomdxPSExplorer._Addref: Integer;
begin
  Result := -1;
end;

function TCustomdxPSExplorer._Release: Integer;
begin
  Result := -1;
end;

{$ENDIF}    

{ IdxPSExplorerContextCommands }

procedure TCustomdxPSExplorer.BuildCommandSet(ABuilder: IdxPSExplorerContextCommandBuilder);
begin
  Assert(ABuilder <> nil);
  ABuilder.AddExplorerContextCommand(AddCommandSeparator);  
  ABuilder.AddExplorerContextCommand(AddCommand(TdxPSExplorerRefreshContextCommand));  
end;

procedure TCustomdxPSExplorer.FinalizeCommand(ACommand: TCustomdxPSExplorerContextCommand);
begin
end;

procedure TCustomdxPSExplorer.InitializeCommand(ACommand: TCustomdxPSExplorerContextCommand);
begin
end;

function TCustomdxPSExplorer.AddCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
begin
  Result := FindCommand(ACommandClass);
  if Result = nil then 
    Result := CreateCommand(ACommandClass);
end;

function TCustomdxPSExplorer.AddCommandSeparator: TdxPSExplorerContextCommandSeparator;
begin
  Result := AddCommand(TdxPSExplorerContextCommandSeparator) as TdxPSExplorerContextCommandSeparator;
end;

procedure TCustomdxPSExplorer.ClearCommands;
var
  I: Integer;
begin
  for I := 0 to CommandCount - 1 do 
    Commands[I].Free;
  FCommands.Clear;
end;

function TCustomdxPSExplorer.CreateCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
begin
  Result := ACommandClass.Create(Self);
  FCommands.Add(Result);
end;

function TCustomdxPSExplorer.CreateCommandSeparator: TdxPSExplorerContextCommandSeparator;
begin
  Result := TdxPSExplorerContextCommandSeparator.Create(Self);
end;

function TCustomdxPSExplorer.FindCommand(ACommandClass: TCustomdxPSExplorerContextCommandClass): TCustomdxPSExplorerContextCommand;
var
  I: Integer;
begin
  for I := 0 to CommandCount - 1 do 
  begin
    Result := Commands[I];
    if Result.ClassType = ACommandClass then Exit;
  end;
  Result := nil;
end;

procedure TCustomdxPSExplorer.FreeAndNilCommands;
begin
  ClearCommands;
  FreeAndNil(FCommands);
end;

class function TCustomdxPSExplorer.AcceptItemNameChar(AnItem: TCustomdxPSExplorerItem;
  Ch: Char): Boolean;
begin
  Result := True;
end;

class function TCustomdxPSExplorer.GetFolderClass: TdxPSExplorerFolderClass;
begin
  Result := TdxPSExplorerFolder;
end;

class function TCustomdxPSExplorer.GetItemClass: TdxPSExplorerItemClass;
begin
  Result := TdxPSExplorerItem;
end;

class function TCustomdxPSExplorer.GetRootFolderClass: TdxPSExplorerFolderClass;
begin
  Result := TdxPSExplorerFolder;
end;

function TCustomdxPSExplorer.GetRootDisplayName: string;
begin
  Result := cxGetResourceString(@sdxExplorerRootFolderCaption);
end;

procedure TCustomdxPSExplorer.LoadData(AFolder: TdxPSExplorerFolder);
begin
  BeginLoading;
  try
    LockNotifications;
    try
      dxPSStartWait;
      try
        DoLoadData(AFolder);
      finally
        dxPSStopWait;
      end;  
    finally
      UnlockNotifications
    end;
  finally
    EndLoading;
  end;
end;

function TCustomdxPSExplorer.CanDelete(AnItem: TCustomdxPSExplorerItem): Boolean;
begin
  Result := (AnItem <> nil) and (AnItem <> Root);
end;

function TCustomdxPSExplorer.CanMove(AnItem: TCustomdxPSExplorerItem): Boolean;
begin
  Result := (AnItem <> nil) and (AnItem <> Root) and (AnItem <> LoadedItem);
end;

function TCustomdxPSExplorer.CanMoveTo(AnItem: TCustomdxPSExplorerItem; 
  AParent: TCustomdxPSExplorerItem): Boolean;
begin
  Result := CanMove(AnItem);
end;

function TCustomdxPSExplorer.CanRename(AnItem: TCustomdxPSExplorerItem): Boolean;
begin
  Result := (AnItem <> nil) and (AnItem <> Root) and (AnItem <> LoadedItem);
end;

function TCustomdxPSExplorer.CanRenameTo(AnItem: TCustomdxPSExplorerItem; 
  const AName: string): Boolean;
begin
  Result := CanRename(AnItem);
end;

procedure TCustomdxPSExplorer.Delete(AnItem: TCustomdxPSExplorerItem);
begin
  if not (esLoading in State) then 
    if AnItem.DoDelete then
    begin
      NotifyItemDeleted(AnItem);
      AnItem.InternalDelete; 
    end;  
end;

procedure TCustomdxPSExplorer.MoveTo(AnItem: TCustomdxPSExplorerItem; 
  AParent: TdxPSExplorerFolder);
begin
  if AnItem.DoMove(AParent) then 
  begin
    AnItem.InternalMove(AParent);
    NotifyItemParentChanged(AnItem);
  end;  
end;

procedure TCustomdxPSExplorer.PopulateFolder(AFolder: TdxPSExplorerFolder);
begin
  if AFolder.HasChildren and (AFolder.FolderCount + AFolder.ItemCount = 0) then 
  begin
    LoadData(AFolder);
    NotifyFolderPopulated(AFolder);
  end;  
end;

procedure TCustomdxPSExplorer.RenameTo(AnItem: TCustomdxPSExplorerItem; AName: string);
begin
  if AnItem.DoRename(AName) then 
  begin
    AnItem.InternalRename(AName);
    NotifyItemRenamed(AnItem);
  end;  
end;

procedure TCustomdxPSExplorer.AfterRefresh;
begin
  Dec(FRefreshCounter);
  if FRefreshCounter = 0 then 
  begin
    UnlockNotifications;
    LoadState;
    NotifyRefresh(ersAfter);
    Exclude(FState, esRefreshing);
  end;  
end;

procedure TCustomdxPSExplorer.BeforeRefresh;
begin
  if FRefreshCounter = 0 then 
  begin
    Include(FState, esRefreshing);
    SaveState;
    NotifyRefresh(ersBefore);
    LockNotifications;
  end;  
  Inc(FRefreshCounter); 
end;

procedure TCustomdxPSExplorer.DoRefresh;
begin
  if LoadedItem <> nil then LoadedItem.Unload;
  FreeAndNil(FRoot);
end;

procedure TCustomdxPSExplorer.RootNeeded;
begin
  Root;
end;

procedure TCustomdxPSExplorer.DoItemDataLoadError(AnItem: TdxPSExplorerItem); 
var
  S: string;
  ShowError: Boolean;
begin
  S := AnItem.DataLoadErrorText;
  ShowError := True;
  if Assigned(FOnItemDataLoadError) then 
    FOnItemDataLoadError(Self, AnItem, ShowError, S);
  if ShowError then 
    MessageError(S);
end;

procedure TCustomdxPSExplorer.InternalSetLoadedItem(Value: TdxPSExplorerItem);
begin
  if Value <> nil then  //?
    FLoadedItem := Value;
end;

procedure TCustomdxPSExplorer.PopulateTreeFolder(ATreeContainer: TCustomdxPSExplorerTreeContainer; 
  AFolder: TdxPSExplorerFolder);
begin
  dxPSExplorerTreeBuilderFactory_ActiveBuilderClass.PopulateTreeFolder(ATreeContainer, AFolder);
  //dxPSExplorerTreeBuilderFactory.ActiveBuilderClass.PopulateTreeFolder(ATreeContainer, AFolder);
end;

procedure TCustomdxPSExplorer.LoadState;

  function ReadItem: TCustomdxPSExplorerItem;
  var
    ItemInfo: TCustomdxPSExplorerItemStateInfo;
    Bytes: TBytes;
    I: Integer;
  begin
    FStateStream.ReadBuffer(ItemInfo, GetItemStateInfoSize);
    if ItemInfo.UniqueIDSize <> 0 then
    begin
      SetLength(Bytes, ItemInfo.UniqueIDSize);
      FStateStream.ReadBuffer(Pointer(Bytes)^, ItemInfo.UniqueIDSize);
      Result := FindCustomItemByUniqueID(Bytes);
    end
    else
      Result := nil;
    for I := 0 to ItemInfo.Count - 1 do 
      ReadItem;
  end;

  procedure ReadLoadedItem;
  var
    Buffer: Integer;
  begin
    FStateStream.ReadBuffer(Buffer , SizeOf(Buffer));
    if Buffer <> 0 then
      InternalSetLoadedItem(TdxPSExplorerItem(ReadItem));   
  end;
  
begin
  if FStateStream <> nil then 
  try
    FStateStream.Position := 0;
    ReadItem;
    ReadLoadedItem;
  finally
    FreeAndNil(FStateStream);
  end;  
end;

procedure TCustomdxPSExplorer.SaveState;

  procedure WriteLoadedItem;
  var
    Flag: Integer;
  begin
    Flag := Ord(LoadedItem <> nil);
    FStateStream.WriteBuffer(Flag, SizeOf(Flag));
    if LoadedItem <> nil then 
      LoadedItem.WriteState(FStateStream);
  end;
  
begin
  if FRoot <> nil then 
  begin
    FStateStream := TMemoryStream.Create;
    try
      Root.WriteState(FStateStream);
      WriteLoadedItem;
    except
      FreeAndNil(FStateStream);
      raise;
    end;  
  end;  
end;

procedure TCustomdxPSExplorer.NotifyFolderPopulated(AFolder: TdxPSExplorerFolder);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].FolderPopulated(AFolder);
end;

procedure TCustomdxPSExplorer.NotifyItemAdded(AnItem: TCustomdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemAdded(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemDataLoaded(AnItem: TdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemDataLoaded(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemDataUnloaded(AnItem: TdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemDataUnloaded(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemDeleted(AnItem: TCustomdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemDeleted(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemParentChanged(AnItem: TCustomdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemParentChanged(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemPropertiesChanged(AnItem: TCustomdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemPropertiesChanged(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyItemRenamed(AnItem: TCustomdxPSExplorerItem);
var
  I: Integer;
begin
  if not AreNotificationsLocked then
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ItemRenamed(AnItem);
end;

procedure TCustomdxPSExplorer.NotifyRefresh(AStage: TdxPSExplorerRefreshStage);
var
  I: Integer;
begin
  if not AreNotificationsLocked then 
    for I := 0 to NotifierCount - 1 do
      Notifiers[I].ExplorerRefresh(AStage);
end;

function TCustomdxPSExplorer.AreNotificationsLocked: Boolean;
begin
  Result := FLockCounter <> 0;
end;

function TCustomdxPSExplorer.IndexOfNotifier(ANotifier: TdxPSExplorerChangeNotifier): Integer;
begin
  Result := FNotifiers.IndexOf(ANotifier);
end;

procedure TCustomdxPSExplorer.LockNotifications;
begin
  Inc(FLockCounter);
end;

procedure TCustomdxPSExplorer.ReleaseAndNilNotifiers;
var
  I: Integer;
begin
  for I := 0 to NotifierCount - 1 do 
    Notifiers[I].Explorer := nil;
  FreeAndNil(FNotifiers);
end;

procedure TCustomdxPSExplorer.UnlockNotifications;
begin
  Dec(FLockCounter);
end;

procedure TCustomdxPSExplorer.BeginLoading;
begin
  if FLoadingCounter = 0 then Include(FState, esLoading);
  Inc(FLoadingCounter);
end;

procedure TCustomdxPSExplorer.EndLoading;
begin
  Dec(FLoadingCounter);
  if FLoadingCounter = 0 then Exclude(FState, esLoading);
end;

function TCustomdxPSExplorer.IsLoading: Boolean;
begin
  Result := FLoadingCounter <> 0;
end;

function TCustomdxPSExplorer.GetCommand(Index: Integer): TCustomdxPSExplorerContextCommand;
begin
  Result := TCustomdxPSExplorerContextCommand(FCommands[Index]);
end;

function TCustomdxPSExplorer.GetCommandCount: Integer;
begin
  Result := FCommands.Count;
end;

function TCustomdxPSExplorer.GetFilterLink: string;
begin
  if FilterLinkClass <> nil then
    Result := FilterLinkClass.ClassName
  else
    Result := '';
end;

function TCustomdxPSExplorer.GetNotifier(Index: Integer): TdxPSExplorerChangeNotifier;
begin
  Result := TdxPSExplorerChangeNotifier(FNotifiers[Index]);
end;

function TCustomdxPSExplorer.GetNotifierCount: Integer;
begin
  Result := FNotifiers.Count;
end;

function TCustomdxPSExplorer.GetRoot: TdxPSExplorerFolder;
begin
  if FRoot = nil then 
  begin
    BeginLoading;
    try
      LockNotifications;
      try
        FRoot := GetRootFolderClass.Create(Self, nil);
        FRoot.FName := GetRootDisplayName;
        LoadData(FRoot);
      finally
        UnlockNotifications;
      end;  
    finally
      EndLoading;
    end;  
  end;
  Result := FRoot;
end;

procedure TCustomdxPSExplorer.SetFilterLink(const Value: string);
var
  ComponentClass: TComponentClass;
begin
  if Value <> '' then 
  begin
    ComponentClass := TComponentClass(GetClass(Value));
    if dxPSIsSupportedCompClass(ComponentClass) then 
      FilterLinkClass := ComponentClass;
  end
  else
    FilterLinkClass := nil;
end;

{ TdxReportTitle }

constructor TdxReportTitle.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;
  FFont := TFont.Create;
  DoRestoreDefaults;
  FFont.OnChange := FontChanged;
end;

destructor TdxReportTitle.Destroy;
begin
  FreeAndNil(FDefaultFont);
  FreeAndNil(FFont);
  inherited;
end;

procedure TdxReportTitle.Assign(Source: TPersistent);
begin
  if Source is TdxReportTitle then
  begin
    BeginUpdate;
    try
      with TdxReportTitle(Source) do 
      begin
        Self.AdjustOnReportScale := AdjustOnReportScale;
        Self.Color := Color;
        Self.Font := Font;
        Self.Mode := Mode;
        Self.Text := Text;
        Self.TextAlignX := TextAlignX;
        Self.TextAlignY := TextAlignY;
        Self.Transparent := Transparent;
      end;  
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TdxReportTitle.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxReportTitle.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TdxReportTitle.EndUpdate;
begin
  if FUpdateCount <> 0 then
  begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then CalculateRenderInfos;
  end;
end;

function TdxReportTitle.DefaultFont: TFont;
begin
  if FDefaultFont = nil then
  begin
    FDefaultFont := TFont.Create;
    InitializeDefaultFont(FDefaultFont);
  end;
  Result := FDefaultFont;
end;

procedure TdxReportTitle.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxReportTitle.DoRestoreDefaults;
begin
  FAdjustOnReportScale := False;
  FColor := clWhite;
  FLockCalcViewInfos := True;
  try
    Font := DefaultFont;
  finally
    FLockCalcViewInfos := False;
  end;
  FMode := tmOnEveryTopPage;
  FTextAlignX := taCenterX;
  FTextAlignY := taCenterY;
  FTransparent := True;
end;

procedure TdxReportTitle.InitializeDefaultFont(AFont: TFont); 
begin
  AFont.Color := dxPSDefaultReportTitleFontColor;
  AFont.Name := dxPSDefaultReportTitleFontName;
  AFont.Size := dxPSDefaultReportTitleFontSize;
  AFont.Style := dxPSDefaultReportTitleFontStyle;
end;

procedure TdxReportTitle.ReadData(AReader: TdxPSDataReader);
begin
  BeginUpdate;
  try
    with AReader do
    begin
      AdjustOnReportScale := ReadBoolean;
      Color := ReadInteger;
      ReadFont(Font);
      Mode := TdxReportTitleMode(ReadInteger);
      Text := ReadString;
      TextAlignX := TcxTextAlignX(ReadInteger);
      TextAlignY := TcxTextAlignY(ReadInteger);
      Transparent := ReadBoolean;
    end;  
  finally
    CancelUpdate;
  end;  
end;

procedure TdxReportTitle.WriteData(AWriter: TdxPSDataWriter);
begin
  with AWriter do 
  begin
    WriteBoolean(AdjustOnReportScale);
    WriteInteger(Color);
    WriteFont(Font);
    WriteInteger(Integer(Mode));
    WriteString(Text);
    WriteInteger(Integer(TextAlignX));
    WriteInteger(Integer(TextAlignY));
    WriteBoolean(Transparent);
  end;  
end;  

function TdxReportTitle.IsFontStored: Boolean;
begin
  Result := not dxPSUtl.dxAreFontsEqual(Font, DefaultFont);
end;

procedure TdxReportTitle.SetAdjustOnReportScale(Value: Boolean);
begin
  if FAdjustOnReportScale <> Value then
  begin
    FAdjustOnReportScale := Value;
    CalculateRenderInfos;
  end;
end;

procedure TdxReportTitle.SetColor(Value: TColor);
begin
  FColor := Value;
end;

procedure TdxReportTitle.SetFont(Value: TFont);
begin
  Font.Assign(Value);
end;

procedure TdxReportTitle.SetMode(Value: TdxReportTitleMode);
begin
  if FMode <> Value then
  begin
    FMode := Value;
    CalculateRenderInfos;
  end;
end;

procedure TdxReportTitle.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    CalculateRenderInfos;
  end;
end;

procedure TdxReportTitle.SetTextAlignX(Value: TcxTextAlignX);
begin
  if Value in [taLeft, taCenterX, taRight] then  // backward compatibility
    FTextAlignX := Value;
end;

procedure TdxReportTitle.SetTextAlignY(Value: TcxTextAlignY);
begin
  if Value in [taTop, taCenterY, taBottom] then  // backward compatibility 
    FTextAlignY := Value;
end;

procedure TdxReportTitle.SetTransparent(Value: Boolean);
begin
  FTransparent := Value;
end;

procedure TdxReportTitle.CalculateRenderInfos;
begin
  if (FUpdateCount = 0) and (ReportLink <> nil) then //and (FReportLink.CurrentComposition = nil) then
    ReportLink.CalculateRenderInfos;
end;

procedure TdxReportTitle.FontChanged(Sender: TObject);
begin
  if not LockCalcViewInfos then CalculateRenderInfos;
end;

{ TdxReportLinkPrinterPage }

type
  TdxReportLinkPrinterPage = class(TdxPrinterPage)
  private
    FReportLink: TBasedxReportLink;
  protected
    function GetOwner: TPersistent; override;
    function GetSupportsScaling: Boolean; override;
    procedure PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes); override;
  public
    property ReportLink: TBasedxReportLink read FReportLink;
  end;

  
function TdxReportLinkPrinterPage.GetOwner: TPersistent;
begin
  Result := ReportLink;
end;

function TdxReportLinkPrinterPage.GetSupportsScaling: Boolean;
begin
  Result := ReportLink.SupportsScaling;
end;

procedure TdxReportLinkPrinterPage.PageParamsChanged(AUpdateCodes: TdxPrinterPageUpdateCodes);
begin
  inherited;
  if UpdateCount = 0 then
    ReportLink.PageParamsChanged(Self, nil, AUpdateCodes);
end;

{ TdxPSReportDocument }

constructor TdxPSReportDocument.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create;
  FReportLink := AReportLink;
  FPreview := TMetafile.Create;
end;

destructor TdxPSReportDocument.Destroy;
begin
  FreeAndNil(FPreview);
  inherited;
end;

procedure TdxPSReportDocument.Assign(Source: TPersistent);
begin
  if Source is TdxPSReportDocument then
  begin
    BeginUpdate;
    try
      DoAssign(TdxPSReportDocument(Source));
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;
      
procedure TdxPSReportDocument.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TdxPSReportDocument.CancelUpdate;
begin
  if FUpdateCount <> 0 then Dec(FUpdateCount);
end;

procedure TdxPSReportDocument.EndUpdate;
begin
  if FUpdateCount <> 0 then 
  begin
    Dec(FUpdateCount);
    if UpdateCount = 0 then Changed;
  end;  
end;

function TdxPSReportDocument.IsUpdateLocked: Boolean;
begin
  Result := UpdateCount <> 0;
end;

function TdxPSReportDocument.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxNewReport);
end;

function TdxPSReportDocument.DefaultCreator: string;
begin
  Result := dxPSUtl.GetUserName;
end;

function TdxPSReportDocument.DefaultDescription: string;
begin
  Result := '';
end;
  
procedure TdxPSReportDocument.RestoreDefaults;
begin
  BeginUpdate;
  try
    DoRestoreDefaults;
  finally
    EndUpdate;
  end;
end;

procedure TdxPSReportDocument.RetrievePreview;
begin
  Preview.Clear;
  if ReportLink <> nil then
    ReportLink.RetrievePageAsImage(0, TMetafile, Preview);
end;

procedure TdxPSReportDocument.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('IsCaptionAssigned', ReadIsCaptionAssigned, WriteIsCaptionAssigned,
    FIsCaptionAssigned and (Caption = ''));
  Filer.DefineProperty('IsCreatorAssigned', ReadIsCreatorAssigned, WriteIsCreatorAssigned,
    FIsCreatorAssigned and (Creator = ''));
  Filer.DefineProperty('IsDescriptionAssigned', ReadIsDescriptionAssigned, WriteIsDescriptionAssigned,
    FIsDescriptionAssigned and (Description = ''));
end;

procedure TdxPSReportDocument.Changed;
begin
  if not IsUpdateLocked then
    if Assigned(FOnChanged) then FOnChanged(Self);
end;

procedure TdxPSReportDocument.DoAssign(Source: TdxPSReportDocument);
begin
  Caption := Source.Caption;
  CreationDate := Source.CreationDate;
  Creator := Source.Creator;
  Description := Source.Description;
  Preview.Assign(Source.Preview);
  FIsCaptionAssigned := Source.FIsCaptionAssigned;
  FIsCreatorAssigned := Source.FIsCreatorAssigned;
  FIsDescriptionAssigned := Source.FIsDescriptionAssigned;
end;      

procedure TdxPSReportDocument.DoRestoreDefaults; 
begin
  FIsCaptionAssigned := False;
  FisCreatorAssigned := False;
  FIsDescriptionAssigned := False;
end;

function TdxPSReportDocument.GetInfoTip: string;
const
  CRLF = #13#10;
begin
  Result := '';

  if Caption <> '' then
  begin
    if Result <> '' then Result := Result + CRLF;
    Result := Result + DropAmpersand(cxGetResourceString(@sdxCaption)) + ' ' + Caption;
  end;

  if Creator <> '' then
  begin
    if Result <> '' then Result := Result + CRLF;
    Result := Result + DropAmpersand(cxGetResourceString(@sdxCreator)) + ' ' + Creator;
  end;

  if Result <> '' then Result := Result + CRLF;
  Result := Result + DropAmpersand(cxGetResourceString(@sdxCreationDate)) + ' ' + DateToStr(CreationDate);

  if Description <> '' then
  begin
    if Result <> '' then Result := Result + CRLF;
    Result := Result + DropAmpersand(cxGetResourceString(@sdxDescription)) + ' ' + Description;
  end;
end;

procedure TdxPSReportDocument.ReadData(AReader: TdxPSDataReader); 
begin
  BeginUpdate;
  try
    with AReader do 
    begin
      Caption := ReadString;
      CreationDate := ReadDate;
      Creator := ReadString;
      Description := ReadString;
      ReadImage(Preview);
    end;  
  finally
    EndUpdate;
  end;  
end;

procedure TdxPSReportDocument.WriteData(AWriter: TdxPSDataWriter);
begin
  RetrievePreview;
  with AWriter do
  begin
    WriteString(Caption);
    WriteDate(CreationDate);
    WriteString(Creator);
    WriteString(Description);
    WriteImage(Preview);
  end;  
end;

function TdxPSReportDocument.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := DefaultCaption;  
end;

function TdxPSReportDocument.GetCreator: string;
begin
  if FIsCreatorAssigned then
    Result := FCreator
  else
    Result := DefaultCreator;
end;

function TdxPSReportDocument.GetDescription: string;
begin
  if FIsDescriptionAssigned then
    Result := FDescription
  else
    Result := DefaultDescription;
end;

function TdxPSReportDocument.IsCaptionStored: Boolean;
begin
  Result := FIsCaptionAssigned and (FCaption <> DefaultCaption);
end;

function TdxPSReportDocument.IsCreatorStored: Boolean;
begin
  Result := FIsCreatorAssigned and (FCreator <> DefaultCreator);
end;

function TdxPSReportDocument.IsDesciptionStored: Boolean;
begin
  Result := FIsDescriptionAssigned and (FDescription <> DefaultDescription);
end;

procedure TdxPSReportDocument.SetCaption(const Value: string);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    FIsCaptionAssigned := True;
    Changed;
  end;
end;

procedure TdxPSReportDocument.SetCreationDate(const Value: TDateTime);
begin
  if FCreationDate <> Value then
  begin
    FCreationDate := Value;
    Changed;
  end;
end;

procedure TdxPSReportDocument.SetCreator(const Value: string);
begin
  if FCreator <> Value then
  begin
    FIsCreatorAssigned := True;
    FCreator := Value;
    Changed;
  end;
end;

procedure TdxPSReportDocument.SetDescription(const Value: string);
begin
  if FDescription <> Value then
  begin
    FIsDescriptionAssigned := True;
    FDescription := Value;
    Changed;
  end;
end;

procedure TdxPSReportDocument.ReadIsCaptionAssigned(Reader: TReader);
begin
  FIsCaptionAssigned := Reader.ReadBoolean;
end;

procedure TdxPSReportDocument.ReadIsCreatorAssigned(Reader: TReader);
begin
  FIsCreatorAssigned := Reader.ReadBoolean;
end;

procedure TdxPSReportDocument.ReadIsDescriptionAssigned(Reader: TReader);
begin
  FIsDescriptionAssigned := Reader.ReadBoolean;
end;

procedure TdxPSReportDocument.WriteIsCaptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsCaptionAssigned);
end;

procedure TdxPSReportDocument.WriteIsCreatorAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsCreatorAssigned);
end;

procedure TdxPSReportDocument.WriteIsDescriptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsDescriptionAssigned);
end;

{ TdxPSDataStorageOffsetTable }

constructor TdxPSDataStorageOffsetTable.Create(ATemplate: TdxPSDataStorageOffsetTable = nil);
begin
  inherited Create;
  Assign(ATemplate);
end;

procedure TdxPSDataStorageOffsetTable.Assign(Source: TdxPSDataStorageOffsetTable);
begin
  Clear;
  if Source <> nil then DoAssign(Source);
end;

procedure TdxPSDataStorageOffsetTable.Clear;
begin
  Information := 0;
  Document := 0;
  Title := 0;
  Data := 0;
  Reserved1 := 0;
  Reserved2 := 0;
  Reserved3 := 0;
  Reserved4 := 0;
end;

type
  TdxPSDataStorageOffsetTableInfo = record
    Information: Longint;
    Document: Longint;
    Title: Longint;
    Data: Longint;
    Reserved1: Longint;
    Reserved2: Longint;
    Reserved3: Longint;
    Reserved4: Longint;
  end;
  
procedure TdxPSDataStorageOffsetTable.ReadData(AReader: TdxPSDataReader);
var
  MemSize: Integer;
  Info: TdxPSDataStorageOffsetTableInfo;
begin
  AReader.Read(MemSize, SizeOf(MemSize));
  AReader.Read(Info, MemSize);

  Information := Info.Information;
  Document := Info.Document;
  Title := Info.Title;
  Data := Info.Data;
  Reserved1 := Info.Reserved1;
  Reserved2 := Info.Reserved2;
  Reserved3 := Info.Reserved3;
  Reserved4 := Info.Reserved4;
end;

procedure TdxPSDataStorageOffsetTable.WriteData(AWriter: TdxPSDataWriter);
var
  MemSize: Integer;
  Info: TdxPSDataStorageOffsetTableInfo;
begin
  MemSize := SizeOf(Info);
  Info.Information := Information;
  Info.Document := Document;
  Info.Title := Title;
  Info.Data := Data;
  Info.Reserved1 := Reserved1;
  Info.Reserved2 := Reserved2;
  Info.Reserved3 := Reserved3;
  Info.Reserved4 := Reserved4;

  AWriter.Write(MemSize, SizeOf(MemSize));
  AWriter.Write(Info, MemSize);
end;

procedure TdxPSDataStorageOffsetTable.DoAssign(Source: TdxPSDataStorageOffsetTable);
begin
  Information := Source.Information;
  Document := Source.Document;
  Title := Source.Title;
  Data := Source.Data;
  Reserved1 := Source.Reserved1;
  Reserved2 := Source.Reserved2;
  Reserved3 := Source.Reserved3;
  Reserved4 := Source.Reserved4;
end;

{ TdxPSDataStorageInfo }

constructor TdxPSDataStorageInfo.Create(AReportLink: TBasedxReportLink);
begin
  inherited Create;
  StorageVersion := dxPSGlbl.dxPSStorageVersion;
  PrintingSystemVersion := dxPSGlbl.dxPSVersion;
  if AReportLink <> nil then
  begin
    LinkClassName := dxStringToShortString(AReportLink.ClassName);
    LinkClass := TdxReportLinkClass(Classes.GetClass(dxShortStringToString(LinkClassName)));
    if AReportLink.Component <> nil then
    begin
      ComponentClassName := dxStringToShortString(AReportLink.Component.ClassName);
      ComponentClass := TComponentClass(Classes.GetClass(dxShortStringToString(ComponentClassName)));
    end;
  end;  
end;

procedure TdxPSDataStorageInfo.ReadData(AReader: TdxPSDataReader);
begin
  with AReader do 
  begin
    StorageVersion := ReadInteger;
    PrintingSystemVersion := ReadPSVersion;
    LinkClassName := dxStringToShortString(ReadString);
    ComponentClassName := dxStringToShortString(ReadString);
    LinkClass := TdxReportLinkClass(Classes.GetClass(dxShortStringToString(LinkClassName)));
    ComponentClass := TComponentClass(Classes.GetClass(dxShortStringToString(ComponentClassName)));
  end;
end;

procedure TdxPSDataStorageInfo.WriteData(AWriter: TdxPSDataWriter);
begin
  with AWriter do
  begin
    WriteInteger(StorageVersion);
    WritePSVersion(PrintingSystemVersion);
    WriteClassName(LinkClass);
    WriteClassName(ComponentClass);
  end;  
end;

{ TBasedxReportLink }

constructor TBasedxReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FBackgroundBitmapPool := TdxPSBackgroundBitmapPool.Create;
  FBuiltIn := IsDesigning;
  FColor := dxDefaultContentColor; {clWhite}
  FCurrentPage := 1;
  FFont := TFont.Create;
  FFont.Assign(DefaultFont);
  FFont.OnChange := FontChanged;
  FDataSource := rldsComponent;
  FPageNumberFormat := pnfNumeral;
  FPrinterPage := TdxReportLinkPrinterPage.Create;
  TdxReportLinkPrinterPage(FPrinterPage).FReportLink := Self;
  FReportDocument := CreateReportDocument;
  FReportDocument.OnChanged := DocumentChanged;
  FReportTitle := TdxReportTitle.Create(Self);
  FSavedReportTitle := TdxReportTitle.Create(nil);
  FSavedReportDocument := CreateReportDocument;
  FScaleFonts := True;
  FShowPageFooter := True;
  FShowPageHeader := True;
  FSubscriber := TdxPageParamsChangedSubscriber.Create([TdxSMPageParamsChangedEvent]);
  TdxPageParamsChangedSubscriber(FSubscriber).OnPageParamsChanged := PageParamsChanged;
  FStartPageIndex := 1;
  FTransparent := True;
  FUseHorzDelimiters := True;
  FUseVertDelimiters := True;  
end;

destructor TBasedxReportLink.Destroy;
begin
 {$IFNDEF DELPHI5}
  Destroying;
 {$ENDIF}
  ComponentPrinter := nil;
  Component := nil;
  DoDestroyReport; {v2.0}
  FreeAndNil(FRenderer);
  FreeAndNil(FRenderInfo);
  FreeAndNil(FSubscriber);
  FreeAndNil(FSavedReportDocument);
  FreeAndNil(FSavedReportTitle);
  FreeAndNil(FReportTitle);
  FreeAndNil(FReportDocument);
  FreeAndNil(FPrinterPage);
  FreeAndNil(FFontPool);
  FreeAndNil(FFont);
  FreeAndNil(FDefaultFont);
  FinalizeDataStream;
  FreeAndNil(FBackgroundBitmapPool);
  inherited;
end;

procedure TBasedxReportLink.BeforeDestruction;
begin
  inherited;
  DoDestroy;
end;

procedure TBasedxReportLink.Assign(Source: TPersistent);
begin
  if Source is TBasedxReportLink then
    with TBasedxReportLink(Source) do
    begin
      Self.Color := Color;
      Self.DesignerCaption := DesignerCaption;
      Self.Font := Font;
      Self.FootersOnEveryPage := FootersOnEveryPage;
      Self.HeadersOnEveryPage := HeadersOnEveryPage;
      Self.PageNumberFormat := PageNumberFormat;
      Self.RealPrinterPage.BeginUpdate;
      try
        Self.RealPrinterPage := RealPrinterPage;
      finally
        Self.RealPrinterPage.CancelUpdate; 
      end;  
      Self.ReportDocument := ReportDocument;
      Self.ReportTitle := ReportTitle;
      Self.ScaleFonts := ScaleFonts;
      Self.ShowEmptyPages := ShowEmptyPages;
      Self.ShowPageFooter := ShowPageFooter;
      Self.ShowPageHeader := ShowPageHeader;
      Self.ShrinkToPageWidth := ShrinkToPageWidth;
      Self.TimeFormat := TimeFormat;
      Self.Transparent := Transparent;
    
      Self.FIsDesignerCaptionAssigned := FIsDesignerCaptionAssigned;
    end
  else
    if Source is TBasedxPrintStyle then
      PrinterPage := TBasedxPrintStyle(Source).PrinterPage
    else
      inherited;
end;

function TBasedxReportLink.GetParentComponent: TComponent;
begin
  Result := ComponentPrinter;
end;

function TBasedxReportLink.HasParent: Boolean;
begin
  Result := ComponentPrinter <> nil;
end;

procedure TBasedxReportLink.LoadFromRegistry(const APath: string);
var
  AssignedFormat: Boolean;
  Registry: TRegistry;
begin
  if APath = '' then Exit;
  Registry := TRegistry.Create;
  with Registry do
  try
    if OpenKey(APath, False) then
    try
      AssignedFormat := ValueExists(sdxAssignedDateFormat) and ReadBool(sdxAssignedDateFormat);
      if AssignedFormat and ValueExists(sdxDateFormat) then
        DateFormat := ReadInteger(sdxDateFormat);

      AssignedFormat := ValueExists(sdxAssignedTimeFormat) and ReadBool(sdxAssignedTimeFormat);
      if AssignedFormat and ValueExists(sdxTimeFormat) then
        TimeFormat := ReadInteger(sdxTimeFormat);

      AssignedFormat := ValueExists(sdxAssignedPageNumberFormat) and ReadBool(sdxAssignedPageNumberFormat);
      if AssignedFormat and ValueExists(sdxPageNumberFormat) then
        PageNumberFormat := TdxPageNumberFormat(ReadInteger(sdxPageNumberFormat));

      if ValueExists(sdxStartPageIndex) then
        StartPageIndex := ReadInteger(sdxStartPageIndex);
    except
      on ERegistryException do
      else
        raise;
    end;
  finally
    Free;
  end;
end;

procedure TBasedxReportLink.SaveToRegistry(const APath: string);
var
  Registry: TRegistry;
begin
  if APath = '' then Exit;
  Registry := TRegistry.Create;
  with Registry do
  try
    if OpenKey(APath, True) then
    try
      WriteBool(sdxAssignedDateFormat, fvDate in AssignedFormatValues);
      if fvDate in AssignedFormatValues then
        WriteInteger(sdxDateFormat, DateFormat);

      WriteBool(sdxAssignedTimeFormat, fvTime in AssignedFormatValues);
      if fvTime in AssignedFormatValues then
        WriteInteger(sdxTimeFormat, TimeFormat);

      WriteBool(sdxAssignedPageNumberFormat, fvPageNumber in AssignedFormatValues);
      if fvPageNumber in AssignedFormatValues then
        WriteInteger(sdxPageNumberFormat, Integer(PageNumberFormat));

      WriteInteger(sdxStartPageIndex, StartPageIndex);
    except
      on ERegistryException do
      else
        raise;
    end;
  finally
    Free;
  end;
end;

class function TBasedxReportLink.Aggregable: Boolean;
begin
  Result := True;
end;

class function TBasedxReportLink.CanBeUsedAsStub: Boolean;
begin
  Result := True;
end;

class function TBasedxReportLink.Serializable: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.DefaultDateFormat: Integer;
begin
  if not (fvDate in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.DateFormat
  else
    Result := 0;                                     
end;

function TBasedxReportLink.DefaultDesignerCaption: string;
begin
  Result := cxGetResourceString(@sdxReportDesignerCaption);
end;

function TBasedxReportLink.DefaultFont: TFont;
begin
  if FDefaultFont = nil then
  begin
    FDefaultFont := TFont.Create;
    InitializeDefaultFont(FDefaultFont);
  end;
  Result := FDefaultFont;
end;

function TBasedxReportLink.DefaultPageNumberFormat: TdxPageNumberFormat;
begin
  if not (fvPageNumber in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.PageNumberFormat
  else
    Result := pnfNumeral;
end;

function TBasedxReportLink.DefaultTimeFormat: Integer;
begin
  if not (fvTime in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.TimeFormat
  else
    Result := 0;
end;

procedure TBasedxReportLink.RestoreDefaults;
begin
  InternalRestoreDefaults;
end;

procedure TBasedxReportLink.RestoreFromOriginal;
begin
  if Component <> nil then InternalRestoreFromOriginal;
end;

function TBasedxReportLink.CheckToDesign: Boolean;
begin
  Result := (DataSource = rldsComponent) and (GetDesignerClass <> nil);
end;

function TBasedxReportLink.DataProviderPresent: Boolean;
begin
  if DataSource = rldsComponent then
    Result := Component <> nil
  else
    Result := PossibleDataStorage(DataStream, False);
end;

function TBasedxReportLink.DesignerExists(AComponentClass: TComponentClass): Boolean;
begin
  Result := GetDesignerClass <> nil;
end;

function TBasedxReportLink.DesignReport: Boolean;
var
  DesignWindowClass: TdxReportLinkDesignWindowClass;
  SaveLink: TBasedxReportLink;
begin
  Result := False;
  DesignWindowClass := GetDesignerClass;
  if DesignWindowClass <> nil then 
  begin
    FDesignWindow := DesignWindowClass.Create(nil);
    try
      DesignWindow.ReportLink := Self;
      SaveLink := LinkClass.Create(nil);
      try
        SaveLink.Assign(Self);
        BeforeDesignReport;
        try
          Result := DesignWindow.Execute;
        finally  
          AfterDesignReport(Result);
        end;  
        if not Result and not DesignWindow.Applyed then
          Assign(SaveLink);
      finally
        SaveLink.Free;
      end;
    finally
      FreeAndNil(FDesignWindow);
    end;
  end;
end;

procedure TBasedxReportLink.DestroyReport;
begin
  Active := False;
end;
      
procedure TBasedxReportLink.GetPageColRowCount(out APageColCount, APageRowCount: Integer);
begin
  APageColCount := RenderInfo.PageColCount;
  APageRowCount := RenderInfo.PageRowCount;
end;

procedure TBasedxReportLink.Initialize;
begin
end;

function TBasedxReportLink.IsEmptyPage(AVirtualPageIndex: Integer): Boolean;
begin
  if (AVirtualPageIndex > -1) and (AVirtualPageIndex < RenderInfo.VirtualPageCount) then
    Result := RenderInfo.PageRenderInfos[AVirtualPageIndex].IsEmptyPage
  else
    Result := True;
end;

function TBasedxReportLink.IsEmptyReport: Boolean;
begin
  Result := (FRenderInfo = nil) or (RenderInfo.NonEmptyPageCount = 0);
end;
      
procedure TBasedxReportLink.RebuildReport;
begin
  if HasDesignWindow then DesignWindow.BeforeRebuildReport;
  try
    Active := False;
    Active := True;
  finally
    if HasDesignWindow then DesignWindow.AfterRebuildReport;
  end;  
end;

procedure TBasedxReportLink.SetComponentUnconditionally(Value: TComponent);
begin
  FComponent := Value;
  if Active or FStreamedActive then
  try
    if FStreamedActive then FStreamedActive := False;
    RebuildReport;
    if not IsLoading and (ComponentPrinter <> nil) and not ComponentPrinter.AutoUpdateDateTime then
    begin
      DateTime := Now;
      DesignerModified;
    end;  
    LinkModified(False);
  except
    on E: Exception do
    begin
      FComponent := nil;
      if IsDesigning then
        ShowException(E, ExceptAddr)
      else
        raise;
    end;
  end;
  if Value <> nil then
    Value.FreeNotification(Self);
end;
                                                      
class procedure TBasedxReportLink.GetSupportedComponentList(AList: TdxClassList);
begin
  dxPSGetLinkSupportedComponentsList(AList, LinkClass);
end;

class function TBasedxReportLink.IsSupportedCompClass(AComponentClass: TClass): Boolean;
begin
  Result := dxPSIsSupportedCompClass(AComponentClass) and (dxPSLinkClassByCompClass(AComponentClass) = LinkClass);
end;
      
class function TBasedxReportLink.LinkClass: TdxReportLinkClass;
begin
  Result := TdxReportLinkClass(GetTypeData(ClassInfo)^.ClassType);
end;

class function TBasedxReportLink.Supports(AnObject: TObject): Boolean;
begin
  Result := (AnObject <> nil) and Supports(AnObject.ClassType);
end;

class function TBasedxReportLink.Supports(AClass: TClass): Boolean;
begin                                                              
  Result := (AClass <> nil) and AClass.InheritsFrom(TComponent) and IsSupportedCompClass(AClass);
end;

function TBasedxReportLink.Print(AShowDialog: Boolean; 
  APPrintDlgData: PdxPrintDlgData): Boolean;
begin
  if ComponentPrinter <> nil then
  begin
    ComponentPrinter.CurrentLink := Self;
    Result := ComponentPrinter.Print(AShowDialog, APPrintDlgData, Self);
  end
  else
    Result := False;
end;

procedure TBasedxReportLink.PrintEx(APageNums: TdxPageNumbers;
  ACopies: Integer; ACollate: Boolean);
begin
  if ComponentPrinter <> nil then
  begin
    ComponentPrinter.CurrentLink := Self;
    ComponentPrinter.PrintEx(APageNums, ACopies, ACollate, Self);
  end;
end;

procedure TBasedxReportLink.PrintPages(const APageIndexes: array of Integer);
begin
  if ComponentPrinter <> nil then
  begin
    ComponentPrinter.CurrentLink := Self;
    ComponentPrinter.PrintPages(APageIndexes, Self);
  end;
end;

procedure TBasedxReportLink.PrintPagesEx(const APageIndexes: array of Integer;
  APageNums: TdxPageNumbers; ACopyCount: Integer; ACollate: Boolean);
begin
  if ComponentPrinter <> nil then
  begin
    ComponentPrinter.CurrentLink := Self;
    ComponentPrinter.PrintPagesEx(APageIndexes, APageNums, ACopyCount, ACollate, Self);
  end;
end;
      
procedure TBasedxReportLink.BuildPageSetupMenu(ARootItem: TComponent;
  AData: Pointer; AIncludeDefineItem: Boolean = True);
var
  MenuBuilder: TAbstractdxPSPageSetupMenuBuilder;
  Styles: TStringList;
begin
  if StyleManager = nil then Exit;
  MenuBuilder := dxPSPageSetupMenuBuilderFactory.ActiveBuilder.Create;
  try
    try
      Styles := TStringList.Create;
      try
        GetFilteredStyles(Styles);
        MenuBuilder.BuildPageSetupMenu(ARootItem, AData, AIncludeDefineItem,
          Styles, CurrentPrintStyle, StyleClick, DefineStylesClick);
      finally
        Styles.Free;
      end;
    except
      Application.HandleException(Self);
    end;
  finally
    MenuBuilder.Free;
  end;
end;

procedure TBasedxReportLink.DefinePrintStylesDlg;
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin  
  if StyleManager <> nil then 
  begin
    if ComponentPrinter <> nil then 
      Include(ComponentPrinter.FState, cpsDefineStylesDialog);

    try
      StyleManager.DefinePrintStylesDlg(PreviewBtnClicked, PrintBtnClicked);
    finally
      if ComponentPrinter <> nil then 
        Exclude(ComponentPrinter.FState, cpsDefineStylesDialog);  
    end;
    
    if PrintBtnClicked then
      Print(True, nil)
    else
      if PreviewBtnClicked then Preview(True);
  end;
end;

procedure TBasedxReportLink.GetFilteredStyles(AStrings: TStrings);
var
  I: Integer;
  Style: TBasedxPrintStyle;
begin
  if StyleManager <> nil then
    for I := 0 to StyleManager.Count - 1 do
    begin
      Style := StyleManager.Styles[I];
      if IsSupportedStyle(Style) then
        AStrings.AddObject(Style.StyleCaption, Style);
    end;
end;

function TBasedxReportLink.PageSetup: Boolean;
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  Result := PageSetupEx(0, True, True, PreviewBtnClicked, PrintBtnClicked);
  if PreviewBtnClicked then
    Preview(True)
  else
    if PrintBtnClicked then
      Result := Print(True, nil);
end;

function TBasedxReportLink.PageSetupEx(AActivePageIndex: Integer; 
  AShowPreviewBtn, AShowPrintBtn: Boolean; 
  out APreviewBtnClicked, APrintBtnClicked: Boolean): Boolean;
var
  PrintStyle: TBasedxPrintStyle;
  PrintStyleExists: Boolean;
begin
  PrintStyle := CurrentPrintStyle;
  PrintStyleExists := PrintStyle <> nil;
  if not PrintStyleExists then
    PrintStyle := TdxPSPrintStyle.Create(nil);
  try
    if (ComponentPrinter <> nil) and (dxPrintDevice <> nil) and (dxPrintDevice.DeviceMode <> nil) then
      PrinterPage.InitFromPrintDevice;
    if not PrintStyleExists then PrintStyle.Assign(Self);
    if ComponentPrinter <> nil then ComponentPrinter.PreparePageSetup;
    try
      if not DataProviderPresent then
      begin
        AShowPreviewBtn := False;
        AShowPrintBtn := False;
      end;
      Result := PrintStyle.PageSetup(AActivePageIndex, AShowPreviewBtn, AShowPrintBtn,
        APreviewBtnClicked, APrintBtnClicked);
    finally
      if ComponentPrinter <> nil then ComponentPrinter.UnpreparePageSetup;
    end;
    if Result and not PrintStyleExists then
    begin
      Self.Assign(PrintStyle);
      if ComponentPrinter <> nil then
        ComponentPrinter.InitDevModeFromPrinterPageSettings(PrinterPage);
    end;
    if ComponentPrinter <> nil then ComponentPrinter.DoPageSetup(Self, Result);
  finally
    if not PrintStyleExists then PrintStyle.Free;
  end;
end;

function TBasedxReportLink.PageSetupEx(AActivePageIndex: Integer;
  APreviewBtnClicked, APrintBtnClicked: PBoolean): Boolean;
var
  ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  ShowPreviewBtn := APreviewBtnClicked <> nil;
  ShowPrintBtn := APrintBtnClicked <> nil;
  Result := PageSetupEx(AActivePageIndex, ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked);

  if ShowPreviewBtn then 
    APreviewBtnClicked^ := PreviewBtnClicked;

  if ShowPrintBtn then 
    APrintBtnClicked^ := PrintBtnClicked;
end;
      
procedure TBasedxReportLink.Preview(Modal: Boolean = True);
begin
  if ComponentPrinter <> nil then
  begin
    ComponentPrinter.CurrentLink := Self;
    ComponentPrinter.Preview(Modal, Self);
  end;
end;

function TBasedxReportLink.PreviewExists: Boolean;
begin
  Result := IsCurrentLink and ComponentPrinter.PreviewExists;
end;

function TBasedxReportLink.ShowDateTimeFormatsDlg: Boolean;
var
  Data: TdxDateTimeFormatDlgData;
begin
  FillChar(Data, SizeOf(TdxDateTimeFormatDlgData), 0);
  with Data do
  begin
    DateFormats := dxPgsDlg.DateFormats;
    TimeFormats := dxPgsDlg.TimeFormats;
    DateFormatIndex := DateFormat;
    TimeFormatIndex := TimeFormat;
    if ComponentPrinter <> nil then
      AutoUpdateDateTime := ComponentPrinter.AutoUpdateDateTime;
    ShowAsDefaultButton := True;
  end;
  Result := dxShowDateTimeFormatDlg(Data);
  if Result then
  begin
    if ComponentPrinter <> nil then
    begin
      ComponentPrinter.AutoUpdateDateTime := Data.AutoUpdateDateTime;
      if Data.SetDateTimeFormatAsDefault then
      begin
        ComponentPrinter.DateFormat := Data.DateFormatIndex;
        ComponentPrinter.TimeFormat := Data.TimeFormatIndex;
      end;
    end;
    DateFormat := Data.DateFormatIndex;
    TimeFormat := Data.TimeFormatIndex;
  end;
end;

function TBasedxReportLink.ShowPageNumberFormatsDlg: Boolean;
var
  Data: TdxPageNumberFormatDlgData;
begin
  FillChar(Data, SizeOf(TdxPageNumberFormatDlgData), 0);
  with Data do
  begin
    PageNumberFormats := dxPgsDlg.PageNumberFormats;
    PageNumberFormat := Self.PageNumberFormat;
    AllowContinueFromPrevSection := AllowContinuousPageIndexes;
    if AllowContinueFromPrevSection then 
      ContinueFromPrevSection := ContinuousPageIndexes;
    StartPageIndex := Self.StartPageIndex;
    ShowAsDefaultButton := True;
  end;
  Result := dxShowPageNumberFormatDlg(Data);
  if Result then
  begin
    if (ComponentPrinter <> nil) and Data.SetPageNumberFormatAsDefault then
      ComponentPrinter.PageNumberFormat := Data.PageNumberFormat;
    PageNumberFormat := Data.PageNumberFormat;
    StartPageIndex := Data.StartPageIndex;    
    if AllowContinuousPageIndexes then 
      ContinuousPageIndexes := Data.ContinueFromPrevSection;
  end;
end;

function TBasedxReportLink.ShowTitlePropertiesDlg: Boolean;
begin
  Result := False;
  if CanChangeTitle then 
  begin
    Result := dxShowReportTitlePropertiesDlg(ReportTitle);
    if Result and PreviewExists and DataProviderPresent then 
      RebuildReport;
  end;    
end;

function TBasedxReportLink.SupportsScaling: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.CanChangeTitle: Boolean;
begin
  Result := SupportsTitle and not IsAggregated and (DataSource = rldsComponent) and 
    ((ComponentPrinter = nil) or not ComponentPrinter.IsExplorerMode);
end;

function TBasedxReportLink.SupportsTitle: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.CanLoadData: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.CanSaveData: Boolean;
begin
  Result := Serializable and not IsEmptyReport and (DataSource = rldsComponent);
end;

function TBasedxReportLink.CanUnloadData: Boolean;
begin
  Result := DataSource = rldsExternalStorage;
end;

function TBasedxReportLink.GetNewReportStorageName: string;
const
  CRLF = #13#10;
var
  P, I: Integer;
begin
  Result := ReportTitle.Text;
  if Result = '' then
    Result := ReportDocument.Caption;
  if Result <> '' then
  begin
    P := Pos(CRLF, Result);
    if P <> 0 then
      Result := Copy(Result, 1, P - 1);
  end;
  if Result = '' then
    Result := cxGetResourceString(@sdxNewReport);

  for I := 1 to Length(dxPSUtl.InvalidFileNameChars) do
    Result := StringReplace(Result, dxPSUtl.InvalidFileNameChars[I], '_', [rfReplaceAll, rfIgnoreCase]);
end;
  
procedure TBasedxReportLink.LoadDataFromFile(const AName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(AName, fmOpenRead or fmShareDenyWrite);
  try
    FStorageName := AName;
    LoadDataFromStream(Stream);
  finally
    Stream.Free;
  end;
end;
                                
procedure TBasedxReportLink.LoadDataFromStream(AStream: TStream);
begin
  if PossibleDataStorage(AStream, True) then 
  begin
    CopyDataStreamFrom(AStream);
    if DataSource <> rldsExternalStorage then 
      DataSource := rldsExternalStorage
    else
      if IsRebuildNeededAndAllowed(True) then 
        RebuildReport;
  end;  
end;  

procedure TBasedxReportLink.SaveDataToFile(const AName: string);
var
  Stream: TStream;
begin
  try
    Stream := TFileStream.Create(AName, fmCreate);// or fmOpenWrite);
    try
      SaveDataToStream(Stream);
    finally
      Stream.Free;
    end;
  except
    // TODO: File is locked
  end;  
end;

procedure TBasedxReportLink.SaveDataToStream(AStream: TStream);
var
  Writer: TdxPSDataWriter;
begin
  if DataProviderPresent and (FReportCells = nil) then RebuildReport;
  
  if ReportCells <> nil then //HasData
  begin
    PrepareLongOperation;
    try
      Include(FState, rlsDataSaving);
      try
        Writer := CreateDataWriter(AStream);
        try
          InternalWriteData(Writer);
        finally
          Writer.Free;
        end;  
      finally
        Exclude(FState, rlsDataSaving);
      end;  
    finally
      UnprepareLongOperation;
    end;  
  end;  
end;

class function TBasedxReportLink.ExtractComponentClass(AStream: TStream; 
  ARaiseException: Boolean = False): TComponentClass;
var
  StorageInfo: TdxPSDataStorageInfo; 
begin
  try
    StorageInfo := ExtractStorageInfo(AStream, ARaiseException);
    try
      Result := StorageInfo.ComponentClass;
    finally
      FinalizeStorageInfo(StorageInfo);
    end;  
  except
    Result := nil;
    if ARaiseException then raise;
  end;  
end;

class function TBasedxReportLink.ExtractLinkClass(AStream: TStream; 
  ARaiseException: Boolean = False): TdxReportLinkClass;
var
  StorageInfo: TdxPSDataStorageInfo; 
begin
  try
    StorageInfo := ExtractStorageInfo(AStream, ARaiseException);
    try
      Result := StorageInfo.LinkClass;
    finally
      FinalizeStorageInfo(StorageInfo);
    end;  
  except
    Result := nil;
    if ARaiseException then raise;
  end;
end;

class function TBasedxReportLink.ExtractOffsetTable(AStream: TStream; 
  ARaiseException: Boolean = False): TdxPSDataStorageOffsetTable;
var
  P: {$IFDEF DELPHI6} Int64 {$ELSE} Integer {$ENDIF};
  Reader: TdxPSDataReader;
begin
  Result := nil;
  try
    P := AStream.Position;
    try
      AStream.Position := 0;
      Reader := CreateDataReader(AStream);
      try
        Result := ReadOffsetTable(Reader);
      finally
        Reader.Free;
      end;  
    finally
      AStream.Position := P;
    end;
  except 
    FreeAndNil(Result);
    if ARaiseException then raise;
  end;  
end;

class function TBasedxReportLink.ExtractReportDocument(AStream: TStream; 
  ARaiseException: Boolean = False): TdxPSReportDocument;
var
  OffsetTable: TdxPSDataStorageOffsetTable;
  P: {$IFDEF DELPHI6} Int64 {$ELSE} Integer {$ENDIF};
  Reader: TdxPSDataReader;
begin
  Result := nil;
  try
    OffsetTable := ExtractOffsetTable(AStream, ARaiseException);
    if OffsetTable <> nil then
    try
      P := AStream.Position;
      AStream.Position := OffsetTable.Document;
      try
        Reader := CreateDataReader(AStream);
        try
          Result := GetReportDocumentClass.Create(nil);
          ReadReportDocument(Reader, Result);
        finally
          Reader.Free;
        end;  
      finally
        AStream.Position := P;
      end;
    finally
      OffsetTable.Free;
    end;  
  except 
    FreeAndNil(Result);
    if ARaiseException then raise;
  end;  
end;

class function TBasedxReportLink.ExtractStorageInfo(AStream: TStream;
  ARaiseException: Boolean = False): TdxPSDataStorageInfo;
var
  OffsetTable: TdxPSDataStorageOffsetTable;
  P: {$IFDEF DELPHI6} Int64 {$ELSE} Integer {$ENDIF};
  Reader: TdxPSDataReader;
begin
  try
    OffsetTable := ExtractOffsetTable(AStream, ARaiseException);
    if OffsetTable <> nil then
    try
      P := AStream.Position;
      AStream.Position := OffsetTable.Information;
      try
        Reader := CreateDataReader(AStream);
        try
          Result := ReadStorageInfo(Reader);
        finally
          Reader.Free;
        end;  
      finally
        AStream.Position := P;
      end;
    finally
      OffsetTable.Free;
    end;  
  except 
    FreeAndNil(Result);
    if ARaiseException then raise;
  end;  
end;

class function TBasedxReportLink.ExtractStorageVersion(AStream: TStream;
  ARaiseException: Boolean = False): Integer;
var
  StorageInfo: TdxPSDataStorageInfo; 
begin
  try
    StorageInfo := ExtractStorageInfo(AStream, ARaiseException);
    try
      Result := StorageInfo.StorageVersion;
    finally
      FinalizeStorageInfo(StorageInfo);
    end;  
  except
    Result := dxPSGlbl.dxPSInvalidStorageVersion;
    if ARaiseException then raise;
  end;  
end;

class procedure TBasedxReportLink.FinalizeStorageInfo(var AStorageInfo: TdxPSDataStorageInfo);
begin
  FreeAndNil(AStorageInfo);
end;

class function TBasedxReportLink.PossibleDataStorage(AStream: TStream; 
  ARaiseException: Boolean = False): Boolean;
begin
  Result := AStream <> nil;
  if Result then 
  try
    Result := ExtractStorageVersion(AStream, ARaiseException) = dxPSGlbl.dxPSStorageVersion;
  except
    Result := False;
    if ARaiseException then raise;
  end;
end;
                                                
class function TBasedxReportLink.PossibleDataStorage(const AFileName: string; 
  ARaiseException: Boolean = False): Boolean;
var
  Stream: TFileStream;
begin
  Result := FileExists(AFileName);
  if Result then 
  try
    Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
    try
      Result := PossibleDataStorage(Stream, ARaiseException);
    finally
      Stream.Free;
    end;
  except  
    Result := False;
    if ARaiseException then raise;
  end;
end;

function TBasedxReportLink.AddBackgroundBitmapToPool(ABitmap: TBitmap): Integer;
begin
  Result := BackgroundBitmapPool.Add(ABitmap);
end;

function TBasedxReportLink.AddFontToPool(AFont: TFont): Integer;
begin
  Result := FontPool.Add(AFont);
end;

function TBasedxReportLink.CreateGroupLookAndFeel(AClass: TdxPSReportGroupLookAndFeelClass;
  ACheckExisting: Boolean = True): TdxPSReportGroupLookAndFeel;
begin
  if ReportCells <> nil then 
    Result := ReportCells.CreateGroupLookAndFeel(AClass, ACheckExisting)
  else
    Result := nil;  
end;

function TBasedxReportLink.FindGroupLookAndFeelByClass(AClass: TdxPSReportGroupLookAndFeelClass): TdxPSReportGroupLookAndFeel;
begin
  if ReportCells <> nil then 
    Result := ReportCells.FindGroupLookAndFeelByClass(AClass)
  else
    Result := nil;  
end;

function TBasedxReportLink.IndexOfReportGroupLookAndFeel(ALookAndFeel: TdxPSReportGroupLookAndFeel): Integer;
begin
  if ReportCells <> nil then 
    Result := ReportCells.IndexOfReportGroupLookAndFeel(ALookAndFeel)
  else
    Result := -1;
end;

procedure TBasedxReportLink.DrawPageHeader(APageIndex: Integer; ARect: TRect;
  ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
begin
  if FPainting then
    Renderer.RenderPageHeaderOrFooterContent(RealPrinterPage.PageHeader,
      APageIndex, ARect, ATitleParts, ADrawBackground);
end;

procedure TBasedxReportLink.DrawPageFooter(APageIndex: Integer; ARect: TRect;
  ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
begin
  if FPainting then
    Renderer.RenderPageHeaderOrFooterContent(RealPrinterPage.PageFooter,
      APageIndex, ARect, ATitleParts, ADrawBackground);
end;

procedure TBasedxReportLink.DrawCheckBox(Canvas: TCanvas; var R: TRect; 
  Checked, Enabled, FlatBorder: Boolean; BoldBorder: Boolean = False);
var
  EdgeStyle: TdxCheckButtonEdgeStyle;  
begin
  if FPainting then
  begin
    EdgeStyle := cbes3D;
    if FlatBorder then
      EdgeStyle := cbesUltraFlat
    else
      if BoldBorder then
        EdgeStyle := cbesBoldFlat;
    Renderer.DrawCheckBox(Canvas.Handle, R, Checked, Enabled, False, EdgeStyle);
  end; 
end;

procedure TBasedxReportLink.DrawCheckBox(Canvas: TCanvas; var R: TRect; 
  Checked, Enabled, IsRadio: Boolean; EdgeStyle: TdxCheckButtonEdgeStyle; 
  BorderColor: TColor = clWindowText);
begin
  if FPainting then
    Renderer.DrawCheckBox(Canvas.Handle, R, Checked, Enabled, IsRadio, EdgeStyle, BorderColor);
end;

procedure TBasedxReportLink.DrawEdge(Canvas: TCanvas; var R: TRect;
  EdgeMode: TdxCellEdgeMode; InnerEdge, OuterEdge: TdxCellEdgeStyle;
  Sides: TdxCellSides = [csLeft..csBottom]; Soft: Boolean = True);
begin
  if FPainting then
    Renderer.DrawEdge(Canvas.Handle, R, EdgeMode, {InnerEdge, } OuterEdge, Sides, Soft, -1);
end;

procedure TBasedxReportLink.DrawEllipse(Canvas: TCanvas; R: TRect; ForeColor, BkColor: TColor; 
  Pattern: TdxPSFillPatternClass; BorderColor: TColor; BorderThickness: Integer = 1);
begin
  if FPainting then
    Renderer.DrawEllipse(Canvas.Handle, R, ForeColor, BkColor, Pattern, BorderColor, BorderThickness);
end;
  
procedure TBasedxReportLink.DrawExpandButton(Canvas: TCanvas; var R: TRect; 
  Expanded, DrawBorder, Edge3D, Edge3DSoft, Shadow, FillInterior: Boolean; 
  BorderColor, InteriorColor: TColor);
begin
  if FPainting then
    Renderer.DrawExpandButton(Canvas.Handle, R, Expanded, DrawBorder, Edge3D, 
      Edge3DSoft, Shadow, FillInterior, BorderColor, InteriorColor);
end;

procedure TBasedxReportLink.DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
begin
  if FPainting then
    Renderer.DrawGlyph(DC, R, AGlyph);
end;
    
procedure TBasedxReportLink.DrawGraphic(Canvas: TCanvas; var R: TRect;
  const ClipRect: TRect; ImageList: TCustomImageList; ImageIndex: Integer; 
  Graphic: TGraphic; GraphicTransparent, Transparent: Boolean; BkColor: TColor);
begin
  if FPainting then
    Renderer.DrawGraphic(Canvas.Handle, R, ClipRect, ImageList, ImageIndex,
      Graphic, GraphicTransparent, Transparent, BkColor);
end;

procedure TBasedxReportLink.DrawGraphicEx(Canvas: TCanvas; var R: TRect; 
  const ClipRect: TRect; ImageList: TCustomImageList; ImageIndex: Integer; 
  Graphic: TGraphic; GraphicTransparent, Transparent: Boolean;
  BkColor, ForeColor: TColor; Pattern: TdxPSFillPatternClass; 
  AnActualImageBuffering: TdxCellImageActualBuffering = cibAlways);
begin
  if FPainting then
    Renderer.DrawGraphicEx(Canvas.Handle, R, ClipRect, ImageList, ImageIndex,
      Graphic, GraphicTransparent, Transparent, BkColor, ForeColor, Pattern, 
      AnActualImageBuffering);
end;

procedure TBasedxReportLink.DrawRectangle(Canvas: TCanvas; R: TRect; 
  ForeColor, BkColor: TColor; ContentPattern: TdxPSFillPatternClass; BorderColor: TColor; 
  BorderThickness: Integer = 1);
begin
  if FPainting then
    Renderer.DrawRectangle(Canvas.Handle, R, ForeColor, BkColor, ContentPattern, 
      BorderColor, BorderThickness);
end;

procedure TBasedxReportLink.DrawRoundRect(Canvas: TCanvas; R: TRect; 
  CornerWidth, CornerHeight: Integer; ForeColor, BkColor: TColor; 
  ContentPattern: TdxPSFillPatternClass; BorderColor: TColor; 
  BorderThickness: Integer = 1);
begin
  if FPainting then
    Renderer.DrawRoundRect(Canvas.Handle, R, CornerWidth, CornerHeight,
      ForeColor, BkColor, ContentPattern, BorderColor, BorderThickness);
end;

procedure TBasedxReportLink.DrawSortMark(Canvas: TCanvas; var R: TRect;
  SortOrder: TdxCellSortOrder; Mono: Boolean);
begin
  if FPainting and (SortOrder <> csoNone) then
    Renderer.DrawSortMark(Canvas.Handle, R, SortOrder, Mono);
end;

procedure TBasedxReportLink.DrawText(Canvas: TCanvas; var R: TRect; AIndent: Integer;
  const Text: string; Font: TFont; BkColor: TColor; TextAlignX: TcxTextAlignX;
  TextAlignY: TcxTextAlignY; FillBackground, Multiline, EndEllipsis: Boolean);
begin
  if FPainting then
    Renderer.DrawText(Canvas.Handle, R, 0, AIndent, 0, Text, Font, BkColor,
      TextAlignX, TextAlignY, FillBackground, Multiline, EndEllipsis, True, True);
end;

procedure TBasedxReportLink.DrawTextEx(Canvas: TCanvas; var R: TRect; 
  MaxLineCount: Integer; LeftIndent, RightIndent: Integer; const Text: string; 
  Font: TFont; BkColor: TColor; TextAlignX: TcxTextAlignX; TextAlignY: TcxTextAlignY; 
  FillBackground, Multiline, EndEllipsis, PreventLeftTextExceed, 
  PreventTopTextExceed: Boolean);
begin
  if FPainting then
    Renderer.DrawText(Canvas.Handle, R, MaxLineCount, LeftIndent, RightIndent, 
      Text, Font, BkColor, TextAlignX, TextAlignY, FillBackground, Multiline, 
      EndEllipsis, PreventLeftTextExceed, PreventTopTextExceed);
end;

procedure TBasedxReportLink.FillEllipse(Canvas: TCanvas; const R: TRect; Color: TColor);
begin
  if FPainting then
    Renderer.FillEllipse(Canvas.Handle, R, Color);
end;

procedure TBasedxReportLink.FillEllipseEx(Canvas: TCanvas; const R: TRect; 
  ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass);
begin
  if FPainting then
    Renderer.FillEllipseEx(Canvas.Handle, R, ForeColor, BkColor, Pattern);
end;

procedure TBasedxReportLink.FillRectEx(Canvas: TCanvas; const R: TRect; 
  ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass);
begin
  if FPainting then
    Renderer.FillRectEx(Canvas.Handle, R, ForeColor, BkColor, Pattern);
end;

procedure TBasedxReportLink.FillRoundRect(Canvas: TCanvas; const R: TRect; 
  CornerWidth, CornerHeight: Integer; Color: TColor);
begin
  if FPainting then
    Renderer.FillRoundRect(Canvas.Handle, R, CornerWidth, CornerHeight, Color);
end;

procedure TBasedxReportLink.FillRoundRectEx(Canvas: TCanvas; const R: TRect; 
  CornerWidth, CornerHeight: Integer; ForeColor, BkColor: TColor; 
  Pattern: TdxPSFillPatternClass);
begin
  if FPainting then
    Renderer.FillRoundRectEx(Canvas.Handle, R, CornerWidth, CornerHeight, 
      ForeColor, BkColor, Pattern);
end;
  
procedure TBasedxReportLink.FillRgnEx(Canvas: TCanvas; Rgn: HRGN; 
  ForeColor, BkColor: TColor; Pattern: TdxPSFillPatternClass);
begin
  if FPainting then
    Renderer.FillRgnEx(Canvas.Handle, Rgn, ForeColor, BkColor, Pattern);
end;

procedure TBasedxReportLink.FrameEllipse(Canvas: TCanvas; R: TRect; Color: TColor; 
  Thickness: Integer = 1);
begin
  if FPainting then
    Renderer.FrameEllipse(Canvas.Handle, R, Color, Thickness);
end;  

procedure TBasedxReportLink.FrameRect(Canvas: TCanvas; R: TRect; Color: TColor; 
  Sides: TdxCellSides = [csLeft..csBottom]; Thickness: Integer = 1);
begin
  if FPainting then
    Renderer.FrameRect(Canvas.Handle, R, Color, Sides, Thickness);
end;  

procedure TBasedxReportLink.FrameRoundRect(Canvas: TCanvas; R: TRect; 
  CornerWidth, CornerHeight: Integer; Color: TColor; Thickness: Integer = 1);
begin
  if FPainting then
    Renderer.FrameRoundRect(Canvas.Handle, R, CornerWidth, CornerHeight, Color, Thickness);
end;  

function TBasedxReportLink.RealPageIndexToVirtualPageIndex(APageIndex: Integer;
  ATakeIntoAccountEmptyPages: Boolean): Integer;
begin
  Result := RenderInfo.RealPageIndexToVirtualPageIndex(APageIndex, ATakeIntoAccountEmptyPages);
end;

function TBasedxReportLink.VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer;
begin
  Result := RenderInfo.VirtualPageIndexToRealPageIndex(APageIndex);
end;

{$IFNDEF DELPHI6}

{ IUnknown }

function TBasedxReportLink.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then                      
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TBasedxReportLink._Addref: Integer;
begin
  Result := -1;
end;

function TBasedxReportLink._Release: Integer;
begin
  Result := -1;
end;

{$ENDIF}    

procedure TBasedxReportLink.AssignTo(Dest: TPersistent);
begin
  if Dest is TBasedxPrintStyle then
    TBasedxPrintStyle(Dest).PrinterPage := PrinterPage
  else
    inherited;
end;

procedure TBasedxReportLink.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('BuiltInReportLink', ReadBuiltIn, WriteBuiltIn, True);
  Filer.DefineProperty('IsDesignerCaptionAssigned', ReadIsDesignerCaptionAssigned, WriteIsDesignerCaptionAssigned,
    FIsDesignerCaptionAssigned and (DesignerCaption = ''));
  Filer.DefineProperty('LinkedComponentName',
    ReadComponentName, WriteComponentName, InternalStreaming and (Component <> nil));
  Filer.DefineProperty('StyleManagerName',
    ReadStyleManagerName, WriteStyleManagerName, InternalStreaming and (StyleManager <> nil));
end;

procedure TBasedxReportLink.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Component then Component := nil;
    if AComponent = StyleManager then StyleManager := nil;
  end;
end;

procedure TBasedxReportLink.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TCustomdxComponentPrinter then
    ComponentPrinter := Reader.Parent as TCustomdxComponentPrinter;
end;

procedure TBasedxReportLink.SetName(const NewName: TComponentName);
begin
  inherited SetName(NewName);
  if Caption = '' then Caption := NewName;
  DesignerUpdate(False);
end;

procedure TBasedxReportLink.SetParentComponent(AParent: TComponent);
begin
  inherited;
  if not IsLoading then
    ComponentPrinter := AParent as TCustomdxComponentPrinter;
end;

procedure TBasedxReportLink.FontChanged(Sender: TObject);
begin
  LinkModified(True);
end;

procedure TBasedxReportLink.LinkModified(Value: Boolean);
var
  Compositions: TList;
  I: Integer;
begin
  FRebuildNeeded := Value;
  if ComponentPrinter <> nil then 
  begin
    Compositions := TList.Create;
    try
      ComponentPrinter.GetCompositionsByLink(Self, Compositions);
      for I := 0 to Compositions.Count - 1 do 
        TdxCompositionReportLink(Compositions[I]).LinkModified(Value);
    finally
      Compositions.Free;
    end;
  end;  
end;

function TBasedxReportLink.IsFontStored: Boolean;
begin
  Result := not dxPSUtl.dxAreFontsEqual(Font, DefaultFont);
end;

procedure TBasedxReportLink.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    LinkModified(True);
  end;
end;

procedure TBasedxReportLink.SetContinuousPageIndexes(Value: Boolean);
begin
end;

procedure TBasedxReportLink.SetFont(Value: TFont);
begin
  Font.Assign(Value);
end;

procedure TBasedxReportLink.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    LinkModified(True);
  end;
end;

procedure TBasedxReportLink.AfterDesignReport(ADone: Boolean);
begin
  if ComponentPrinter <> nil then 
    ComponentPrinter.DoDesignReport(Self, ADone);
end;

procedure TBasedxReportLink.BeforeDesignReport;
begin
  if ComponentPrinter <> nil then 
    ComponentPrinter.DoBeforeDesignReport(Self);
end;

procedure TBasedxReportLink.AfterPrinting;
begin
  if CurrentPrintStyle <> nil then CurrentPrintStyle.AfterPrinting;
end;

procedure TBasedxReportLink.BeforePrinting;
begin
  if CurrentPrintStyle <> nil then CurrentPrintStyle.BeforePrinting;
end;

function TBasedxReportLink.GetBreakPagesByHardDelimiters: Boolean;
begin
  Result := False;
end;

function TBasedxReportLink.CalculateActualScaleFactor: Integer;
begin
  with RealPrinterPage do
  begin                           
    // Get Result in internal units -> convert from LoMetric to Inches and then from Inches to internal units (units used inside PS)
    Result := MulDiv(PaintRectLoMetric.Right - PaintRectLoMetric.Left, FUnitsPerInch, 254);
    // Take into account ScaleFactor
    Result := MulDiv(Result, 100, ReportWidth) - 1;
  end;  
end;

function TBasedxReportLink.CannotActivateReportErrorString: string;
begin
  if DataSource = rldsComponent then
    Result := cxGetResourceString(@sdxMissingComponent)
  else    
    Result := cxGetResourceString(@sdxInvalidExternalStorage);
end;

function TBasedxReportLink.CurrentComposition: TdxCompositionReportLink;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.CurrentCompositionByLink(Self)
  else
    Result := nil;
end;

procedure TBasedxReportLink.SetRealPrinterPage(Value: TdxPrinterPage);
begin
  RealPrinterPage.Assign(Value);
end;

function TBasedxReportLink.GetAllowContinuousPageIndexes: Boolean;
begin 
  Result := False;
end;  

function TBasedxReportLink.GetAlwaysBufferedGraphics: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.GetContinuousPageIndexes: Boolean;
begin
  Result := False;
end;

function TBasedxReportLink.GetEmptyPagesCanExist: Boolean;
begin
  Result := False;
end;

procedure TBasedxReportLink.SetFootersOnEveryPage(Value: Boolean);
begin
  if not IsAggregated then FFootersOnEveryPage := Value
end;

procedure TBasedxReportLink.SetHeadersOnEveryPage(Value: Boolean);
begin
  if not IsAggregated then FHeadersOnEveryPage := Value
end;

function TBasedxReportLink.GetRealScaleFactor: Integer;
begin
  with RealPrinterPage do
    if ScaleMode = smAdjust then
      Result := ScaleFactor
    else
      Result := CalculateActualScaleFactor;
end;

function TBasedxReportLink.GetReportHeight: Integer;
begin
  if ReportCells <> nil then
    Result := ReportCells.CalculateTotalHeight
  else
    Result := 0;
end;

function TBasedxReportLink.GetReportWidth: Integer;
begin
  if ReportCells <> nil then
    Result := ReportCells.CalculateTotalWidth
  else
    Result := 0;
end;

procedure TBasedxReportLink.DefineStylesClick(Sender: TObject);
begin
  DefinePrintStylesDlg;
end;

procedure TBasedxReportLink.StyleClick(Sender: TObject);
var
  PreviewBtnClicked, PrintBtnClicked: Boolean;
  PrevCurrentStyle, Style: TBasedxPrintStyle;
begin
  if StyleManager = nil then Exit;
  
  try                            
    Style := dxPSPageSetupMenuBuilderFactory.ActiveBuilder.ExtractPrintStyleFromObj(Sender);
  except
    Style := nil;
    Application.HandleException(Self);
  end;
  if Style = nil then Exit;

  PrevCurrentStyle := StyleManager.CurrentStyle;
  StyleManager.CurrentStyle := Style;

  if (ComponentPrinter <> nil) and not ComponentPrinter.IsForegroundPreviewWindow then 
  begin
    if not PageSetupEx(0, True, True, PreviewBtnClicked, PrintBtnClicked) then
      StyleManager.CurrentStyle := PrevCurrentStyle;

    if PrintBtnClicked then
      Print(True, nil)
    else
      if PreviewBtnClicked then Preview(True);
  end;
end;

procedure TBasedxReportLink.SetCurrentPage(Value: Integer);
begin
  if Value < 1 then 
    Value := 1;
  if Value > PageCount then 
    Value := PageCount;
  FCurrentPage := Value;
end;

procedure TBasedxReportLink.DoCustomDrawEntirePage(ACanvas: TCanvas; R: TRect;
  ARealPageIndex: Integer);
var
  Nom: Integer;
begin
  with ComponentPrinter do
  begin
    Nom := 100;
    if PreviewExists then 
      Nom := PreviewWindow.ZoomFactor;
    DoCustomDrawEntirePage(Self, ACanvas, ARealPageIndex, R, Nom, 100);
  end;
end;

procedure TBasedxReportLink.DoCustomDrawPageHeaderOrFooter(AHFObject: TCustomdxPageObject;
  ACanvas: TCanvas; APageIndex: Integer; R: TRect;
  var ADefaultDrawText, ADefaultDrawBackground: Boolean);
begin
  DoParentCustomDrawPageHeaderOrFooter(AHFObject, ACanvas, APageIndex, R,
    ADefaultDrawText, ADefaultDrawBackground, PixelsNumerator);
  if ADefaultDrawText or ADefaultDrawBackground then
    if AHFObject is TdxPageHeader then
    begin
      if Assigned(FOnCustomDrawPageHeader) then
        FOnCustomDrawPageHeader(Self, ACanvas, APageIndex, R,
          PixelsNumerator, PixelsDenominator, ADefaultDrawText, ADefaultDrawBackground)
    end
    else
      if Assigned(FOnCustomDrawPageFooter) then
        FOnCustomDrawPageFooter(Self, ACanvas, APageIndex, R,
          PixelsNumerator, PixelsDenominator, ADefaultDrawText, ADefaultDrawBackground);
end;

procedure TBasedxReportLink.DoCustomDrawPageTitle(ACanvas: TCanvas; R: TRect;
  var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
  var AColor: TColor; AFont: TFont; var ADone: Boolean);
begin
  DoParentCustomDrawReportTitle(ACanvas, R, ATextAlignX, ATextAlignY,
    AColor, AFont, ADone, PixelsNumerator);
  if not ADone and Assigned(FOnCustomDrawReportLinkTitle) then
    FOnCustomDrawReportLinkTitle(Self, ACanvas, R, PixelsNumerator,
      PixelsDenominator, ATextAlignX, ATextAlignY, AColor, AFont, ADone);
end;

procedure TBasedxReportLink.DoParentCustomDrawPageHeaderOrFooter(
  AHFObject: TCustomdxPageObject; ACanvas: TCanvas; APageIndex: Integer;
  R: TRect; var ADefaultDrawText, ADefaultDrawBackground: Boolean;
  APixelsNumerator: Integer);
begin
  ComponentPrinter.DoCustomDrawPageHeaderOrFooter(Self, AHFObject, ACanvas,
    APageIndex, R, ADefaultDrawText, ADefaultDrawBackground, APixelsNumerator);
end;

procedure TBasedxReportLink.DoParentCustomDrawReportTitle(ACanvas: TCanvas; R: TRect;
  var ATextAlignX: TcxTextAlignX; var ATextAlignY: TcxTextAlignY;
  var AColor: TColor; AFont: TFont; var ADone: Boolean; APixelsNumerator: Integer);
begin
  ComponentPrinter.DoCustomDrawReportTitle(Self, ACanvas, R, ATextAlignX, ATextAlignY,
    AColor, AFont, ADone, APixelsNumerator);
end;

procedure TBasedxReportLink.PaintPage(ACanvas: TCanvas; const APageBounds: TRect;
  APageIndex, AContinuousPageIndex, AZoomFactor: Integer); //; ARenderer: TdxPSReportRenderer);
begin
  FPainting := True;
  try
    Renderer.RenderPage(ACanvas, APageBounds, APageIndex, AContinuousPageIndex, AZoomFactor);
  finally
    FPainting := False;
  end;
end;

function TBasedxReportLink.IsEntirePageCustomDrawn: Boolean;
begin
  Result := Assigned(ComponentPrinter.FOnCustomDrawPage);
end;

function TBasedxReportLink.IsHeaderOrFooterCustomDrawn(AHFObject: TCustomdxPageObject): Boolean;
begin
  if AHFObject is TdxPageHeader then
    Result := Assigned(ComponentPrinter.FOnCustomDrawPageHeader) or Assigned(FOnCustomDrawPageHeader)
  else
    Result := Assigned(ComponentPrinter.FOnCustomDrawPageFooter) or Assigned(FOnCustomDrawPageFooter);
end;

function TBasedxReportLink.IsTitleCustomDrawn: Boolean;
begin
  Result :=
    Assigned(ComponentPrinter.FOnCustomDrawReportTitle) or
    Assigned(FOnCustomDrawReportLinkTitle);
end;

function TBasedxReportLink.IsComposable(AComposition: TdxCompositionReportLink): Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.IsSupportedStyle(APrintStyle: TBasedxPrintStyle): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterStyle) then
  begin
    FOnFilterStyle(Self, APrintStyle, Result);
    if not Result and (APrintStyle = CurrentPrintStyle) then
      Result := True;
  end;
end;

function TBasedxReportLink.NeedTwoPassRendering: Boolean;
begin
  Result := False;
end;

procedure TBasedxReportLink.DesignerModified;
begin
  if ComponentPrinter <> nil then ComponentPrinter.DesignerModified;
end;

procedure TBasedxReportLink.DesignerUpdate(TheAll: Boolean);
begin
  if ComponentPrinter <> nil then
    if TheAll then
      ComponentPrinter.DesignerUpdate(nil)
    else
      ComponentPrinter.DesignerUpdate(Self);
end;

function TBasedxReportLink.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TBasedxReportLink.IsDestroying: Boolean;    
begin
  Result := csDestroying in ComponentState;
end;

function TBasedxReportLink.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TBasedxReportLink.DoMeasureReportLinkTitle(var AHeight: Integer);
begin
  if ComponentPrinter <> nil then
    ComponentPrinter.DoMeasureReportTitle(Self, AHeight);
  if Assigned(FOnMeasureReportLinkTitle) then
    FOnMeasureReportLinkTitle(Self, AHeight);
end;

function TBasedxReportLink.GetCriticalSize(AReportCells: TdxReportCells): Integer;
begin
  with AReportCells.BoundsRect do
    Result := Right - Left;
end;

procedure TBasedxReportLink.GetImageLists(AProc: TdxPSGetImageListProc);
begin
end;

function TBasedxReportLink.NeedCalcEmptyPages: Boolean;
begin
  Result := EmptyPagesCanExist and not ShrinkToPageWidth;
end;

function TBasedxReportLink.PageReady(APageIndex: Integer): Boolean;
begin
  Result := True;
end;

procedure TBasedxReportLink.PrepareFonts(UPI: Integer);
begin
  if FFontPool <> nil then FontPool.PrepareFonts(UPI);
end;

procedure TBasedxReportLink.PrepareLongOperation;
begin
  if ComponentPrinter <> nil then ComponentPrinter.PrepareLongOperation;
end;

procedure TBasedxReportLink.UnprepareLongOperation;
begin
  if ComponentPrinter <> nil then ComponentPrinter.UnprepareLongOperation;
end;

function TBasedxReportLink.CreateReportDocument: TdxPSReportDocument;
begin
  Result := GetReportDocumentClass.Create(Self);
end;

procedure TBasedxReportLink.DocumentChanged(Sender: TObject);
begin
  if IsCurrentLink then
    dxHFFormatObject.DateTime := DateTime;
end;

class function TBasedxReportLink.GetReportDocumentClass: TdxPSReportDocumentClass;
begin
  Result := TdxPSReportDocument;
end;
 
function TBasedxReportLink.CreateReportCells: TdxReportCells;
begin
  Result := GetReportCellsClass.Create(Self);
end;

function TBasedxReportLink.GetReportCellsClass: TdxReportCellsClass;
begin
  Result := TdxReportCells;
end; 

class function TBasedxReportLink.CreateDataReader(AStream: TStream): TdxPSDataReader;
begin
  Result := TdxPSDataReader.Create(AStream, 4096);
end;

class function TBasedxReportLink.CreateDataWriter(AStream: TStream): TdxPSDataWriter;
begin
  Result := TdxPSDataWriter.Create(AStream, 4096);
end;

class function TBasedxReportLink.GetDataReaderClass: TdxPSDataReaderClass;
begin
  Result := dxPSReaderFactory.ActualReaderClass;
end;

class function TBasedxReportLink.GetDataWriterClass: TdxPSDataWriterClass;
begin
  Result := dxPSWriterFactory.ActualWriterClass;
end;

procedure TBasedxReportLink.InternalLoadDataFromStream(AStream: TStream);
var
  Reader: TdxPSDataReader;
begin
  Include(FState, rlsDataLoading);
  try                  
    Reader := CreateDataReader(AStream);
    try
      try
        InternalReadData(Reader);
      except
        ClearGDIPools;
        AddFontToPool(Font);
        ReportTitle.Assign(FSavedReportTitle);
        ReportDocument.Assign(FSavedReportDocument);
        raise;
      end;  
    finally
      Reader.Free;
    end;  
  finally
    Exclude(FState, rlsDataLoading);
  end;  
end;

procedure TBasedxReportLink.InternalReadData(AReader: TdxPSDataReader);
var
  OffsetTable: TdxPSDataStorageOffsetTable;
begin
  OffsetTable := ReadOffsetTable(AReader);
  try
    AReader.Position := OffsetTable.Information;
    SkipStorageInfo(AReader);

    AReader.Position := OffsetTable.Document;
    ReadReportDocument(AReader, ReportDocument);

    AReader.Position := OffsetTable.Title;
    ReadTitle(AReader);

    AReader.Position := OffsetTable.Data;
    ReadData(AReader);
  finally
    OffsetTable.Free;
  end;  
end;

procedure TBasedxReportLink.InternalWriteData(AWriter: TdxPSDataWriter);
var
  OffsetTable: TdxPSDataStorageOffsetTable;
  P: Longint;
begin
  WriteOffsetTable(AWriter, nil);

  OffsetTable := TdxPSDataStorageOffsetTable.Create(nil);
  try
    OffsetTable.Information := AWriter.Position;
    WriteStorageInfo(AWriter, RetrieveStorageInfo);

    OffsetTable.Document := AWriter.Position;
    WriteReportDocument(AWriter, ReportDocument);

    OffsetTable.Title := AWriter.Position;
    WriteTitle(AWriter);

    OffsetTable.Data := AWriter.Position;
    WriteData(AWriter);

    P := AWriter.Position;
    AWriter.Position := 0;

    WriteOffsetTable(AWriter, OffsetTable);
  finally
    OffsetTable.Free;
  end;
  AWriter.Position := P;
end;

function TBasedxReportLink.IsRebuildNeededAndAllowed(ACheckPreviewMode: Boolean): Boolean;
begin
  Result := IsCurrentLink and DataProviderPresent and not IsAggregated and 
    (not ACheckPreviewMode or PreviewExists);
end;

function TBasedxReportLink.RetrieveStorageInfo: TdxPSDataStorageInfo;
begin
  Result := TdxPSDataStorageInfo.Create(Self);
end;

procedure TBasedxReportLink.ReadData(AReader: TdxPSDataReader);
begin
  ReadReportData(AReader);
  ReadRenderInfo(AReader);
  ReadBackgroundBitmapPool(AReader);
  ReadFontPool(AReader);
end;

class function TBasedxReportLink.ReadOffsetTable(AReader: TdxPSDataReader): TdxPSDataStorageOffsetTable;
begin
  Result := TdxPSDataStorageOffsetTable.Create(nil);
  Result.ReadData(AReader);
end;

class procedure TBasedxReportLink.ReadReportDocument(AReader: TdxPSDataReader; 
  AReportDocument: TdxPSReportDocument);
begin
  AReportDocument.ReadData(AReader);
end;

class function TBasedxReportLink.ReadStorageInfo(AReader: TdxPSDataReader): TdxPSDataStorageInfo;
begin
  Result := TdxPSDataStorageInfo.Create(nil);
  Result.ReadData(AReader);
end;

class procedure TBasedxReportLink.SkipStorageInfo(AReader: TdxPSDataReader);
var
  StorageInfo: TdxPSDataStorageInfo;
begin
  StorageInfo := nil;
  try
    StorageInfo := ReadStorageInfo(AReader);
  except
    FreeAndNil(StorageInfo);
    raise;
  end;
end;

procedure TBasedxReportLink.ReadTitle(AReader: TdxPSDataReader);
begin       
  ReportTitle.ReadData(AReader);
end;

procedure TBasedxReportLink.WriteData(AWriter: TdxPSDataWriter);
begin
  WriteReportData(AWriter);
  WriteRenderInfo(AWriter);
  WriteBackgroundBitmapPool(AWriter);
  WriteFontPool(AWriter);
end;

class procedure TBasedxReportLink.WriteOffsetTable(AWriter: TdxPSDataWriter; 
  AnOffsetTable: TdxPSDataStorageOffsetTable);
var
  OffsetTable: TdxPSDataStorageOffsetTable;
begin
  OffsetTable := TdxPSDataStorageOffsetTable.Create(AnOffsetTable);
  try
    OffsetTable.WriteData(AWriter);
  finally
    OffsetTable.Free;
  end;  
end;

class procedure TBasedxReportLink.WriteStorageInfo(AWriter: TdxPSDataWriter; 
  AStorageInfo: TdxPSDataStorageInfo);
begin
  AStorageInfo.WriteData(AWriter);
end;

class procedure TBasedxReportLink.WriteReportDocument(AWriter: TdxPSDataWriter; 
  AReportDocument: TdxPSReportDocument);
begin
  AReportDocument.WriteData(AWriter);
end;

procedure TBasedxReportLink.WriteTitle(AWriter: TdxPSDataWriter);
begin
  ReportTitle.WriteData(AWriter);
end;

procedure TBasedxReportLink.ReadBackgroundBitmapPool(AReader: TdxPSDataReader);
begin
  BackgroundBitmapPool.ReadData(AReader);
end;

procedure TBasedxReportLink.ReadReportData(AReader: TdxPSDataReader);
begin
  if FReportCells = nil then FReportCells := TdxReportCells.Create(Self);
  ReportCells.ReadData(AReader);
end;

procedure TBasedxReportLink.ReadFontPool(AReader: TdxPSDataReader);
begin
  FontPool.ReadData(AReader);
end;

procedure TBasedxReportLink.ReadRenderInfo(AReader: TdxPSDataReader);
begin
  RenderInfo.ReadData(AReader);
end;

procedure TBasedxReportLink.WriteBackgroundBitmapPool(AWriter: TdxPSDataWriter);
begin
  BackgroundBitmapPool.WriteData(AWriter);
end;

procedure TBasedxReportLink.WriteFontPool(AWriter: TdxPSDataWriter);
begin
  FontPool.WriteData(AWriter);
end;

procedure TBasedxReportLink.WriteReportData(AWriter: TdxPSDataWriter);
begin
  ReportCells.WriteData(AWriter);
end;  

procedure TBasedxReportLink.WriteRenderInfo(AWriter: TdxPSDataWriter);
begin
  RenderInfo.WriteData(AWriter);
end;

procedure TBasedxReportLink.SetActive(Value: Boolean);
begin
  if (csReading in ComponentState) and Value then
    FStreamedActive := Value
  else
    if (FActive <> Value) and (ComponentPrinter <> nil) then
      if Value then 
        ComponentPrinter.ActivateLink(Self)
      else   
        ComponentPrinter.DeactivateLink(Self);
end;
           
procedure TBasedxReportLink.SetComponent(Value: TComponent);
begin
  if not (csReading in ComponentState) then
  begin
    if FComponent <> Value then
    begin
      if PreviewExists then 
        ComponentPrinter.DestroyPreviewWindow;

      if Value = nil then
      begin
        Active := False;
        FComponent := nil;
      end
      else
        if IsSupportedCompClass(TComponentClass(Value.ClassType)) then
          SetComponentUnconditionally(Value)
        else
          ComponentUnsupportedError(Value);
      
      if not IsDestroying and not IsLoading then
      begin
        DoChangeComponent;
        if ComponentPrinter <> nil then ComponentPrinter.DoChangeComponent(Self);
        DesignerUpdate(False);
      end;
    end;
  end
  else
    FComponent := Value;
end;

procedure TBasedxReportLink.SetShowPageFooter(Value: Boolean);
begin
  if FShowPageFooter <> Value then
  begin
    FShowPageFooter := Value;
    ShowPageFooterChanged;
  end;
end;

procedure TBasedxReportLink.SetShowPageHeader(Value: Boolean);
begin
  if FShowPageHeader <> Value then
  begin
    FShowPageHeader := Value;
    ShowPageHeaderChanged;
  end;
end;

{procedure TBasedxReportLink.SetShrinkToPageHeight(Value: Boolean);
begin
  
end;}

procedure TBasedxReportLink.SetShrinkToPageWidth(Value: Boolean);
const
  ScaleModeMap: array[Boolean] of TdxScaleMode = (smAdjust, smFit);
begin
  if ShrinkToPageWidth <> Value then
  begin
    PrepareLongOperation;
    try
      with RealPrinterPage do
      begin
        BeginUpdate;
        try
          if Value then
          begin
            FitToPagesByTall := 1;
            FitToPagesByWide := 1;
          end;
          ScaleMode := ScaleModeMap[Value];
        finally
          EndUpdate;
        end;
      end;
    finally
      UnprepareLongOperation;
    end;
  end;
end;

procedure TBasedxReportLink.SetShowEmptyPages(Value: Boolean);
begin
  if FShowEmptyPages <> Value then
  begin
    FShowEmptyPages := Value;
    ShowEmptyPagesChanged;
  end;
end;

procedure TBasedxReportLink.SetDateTime(const Value: TDateTime);
begin
  ReportDocument.CreationDate := Value;
end;

procedure TBasedxReportLink.SetDesignerCaption(const Value: string);
begin
  if DesignerCaption <> Value then
  begin
    FDesignerCaption := Value;
    FIsDesignerCaptionAssigned := True;
  end;
end;

procedure TBasedxReportLink.SetDescription(const Value: string);
begin
  ReportDocument.Description := Value;
end;

function TBasedxReportLink.GetDateFormat: Integer;
begin
  if not (fvDate in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.DateFormat
  else
    Result := FDateFormat;
end;

function TBasedxReportLink.GetDateTime: TDateTime;
begin
  Result := ReportDocument.CreationDate;
end;

function TBasedxReportLink.GetDescription: string;
begin
  Result := ReportDocument.Description;
end;

function TBasedxReportLink.GetDesignerCaption: string;
begin
  if FIsDesignerCaptionAssigned then
    Result := FDesignerCaption
  else
    Result := DefaultDesignerCaption; 
end;

function TBasedxReportLink.GetIndex: Integer;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.IndexOfLink(Self)
  else
    Result := -1;
end;

function TBasedxReportLink.GetIsAggregated: Boolean;
begin
  Result := Controller <> nil;
end;

function TBasedxReportLink.GetIsBuilding: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (cpsBuilding in ComponentPrinter.State);
end;
    
function TBasedxReportLink.GetIsCurrentLink: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (ComponentPrinter.CurrentLink = Self);
end;

function TBasedxReportLink.GetPageHeight: Integer;
begin
  with RealPrinterPage.PaintRectPixels do
    Result := Bottom - Top - 1;
end;

function TBasedxReportLink.GetPageNumberFormat: TdxPageNumberFormat;
begin
  if not (fvPageNumber in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.PageNumberFormat
  else
    Result := FPageNumberFormat;
end;

function TBasedxReportLink.GetPageWidth: Integer;
begin
  with RealPrinterPage.PaintRectPixels do
    Result := Right - Left - 1;
end;

function TBasedxReportLink.GetPreviewWindow: TBasedxPreviewWindow;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.PreviewWindow
  else
    Result := nil;  
end;

function TBasedxReportLink.GetRealPrinterPage: TdxPrinterPage;
var
  Style: TBasedxPrintStyle;
  Composition: TdxCompositionReportLink;
begin
  Result := nil;
  if ComponentPrinter <> nil then 
  begin
    Composition := ComponentPrinter.CurrentCompositionByLink(Self);
    if Composition <> nil then Result := Composition.RealPrinterPage;
  end;
  if Result = nil then
  begin
    Style := CurrentPrintStyle;
    if Style <> nil then
      Result := Style.PrinterPage
    else
      Result := FPrinterPage;
  end;    
end;

function TBasedxReportLink.GetReportTitleMode: TdxReportTitleMode;
begin
  Result := ReportTitle.Mode;
end;

function TBasedxReportLink.GetReportTitleText: string;
begin
  Result := ReportTitle.Text;
end;

function TBasedxReportLink.GetRenderer: TdxPSReportRenderer;
begin
  if FRenderer = nil then FRenderer := CreateRenderer;
  Result := FRenderer;
end;

function TBasedxReportLink.GetRenderInfo: TdxPSReportRenderInfo;
begin
  if FRenderInfo = nil then FRenderInfo := CreateRenderInfo;
  Result := FRenderInfo;
end;

function TBasedxReportLink.GetRenderStage: TdxPSRenderStages;
begin
  if FPainting and (FRenderer <> nil) then 
    Result := Renderer.RenderStage  
  else
    Result := [];
end;

function TBasedxReportLink.GetShowEmptyPages: Boolean;
var
  Composition: TdxCompositionReportLink;
begin
  Result := FShowEmptyPages;
  if ComponentPrinter <> nil then 
  begin
    Composition := ComponentPrinter.CurrentCompositionByLink(Self);
    if Composition <> nil then Result := Composition.ShowEmptyPages;
  end;  
end;

function TBasedxReportLink.GetShowPageFooter: Boolean;
var
  Composition: TdxCompositionReportLink;
begin
  Result := FShowPageFooter;
  if ComponentPrinter <> nil then 
  begin
    Composition := ComponentPrinter.CurrentCompositionByLink(Self);
    if Composition <> nil then Result := Composition.ShowPageFooter;
  end;  
end;

function TBasedxReportLink.GetShowPageHeader: Boolean;    
var
  Composition: TdxCompositionReportLink;
begin
  Result := FShowPageHeader;
  if ComponentPrinter <> nil then 
  begin
    Composition := ComponentPrinter.CurrentCompositionByLink(Self);
    if Composition <> nil then Result := Composition.ShowPageHeader;
  end;  
end;

{function TBasedxReportLink.GetShrinkToPageHeight: Boolean;
begin
  with RealPrinterPage do
    Result := (ScaleMode = smFit) and (FitToPagesByTall = 1);
end;}

function TBasedxReportLink.GetShrinkToPageWidth: Boolean;
begin
  with RealPrinterPage do
    Result := (ScaleMode = smFit);// and (FitToPagesByWide = 1);
end;

function TBasedxReportLink.GetStartPageIndex: Integer;
begin
  Result := FStartPageIndex;
end;

function TBasedxReportLink.GetTimeFormat: Integer;
begin
  if not (fvTime in AssignedFormatValues) and (ComponentPrinter <> nil) then
    Result := ComponentPrinter.TimeFormat
  else
    Result := FTimeFormat;
end;

function TBasedxReportLink.GetVirtualPageCount: Integer;
begin
  Result := RenderInfo.VirtualPageCount;
end;

function TBasedxReportLink.IsDateFormatStored: Boolean;
begin
  Result := fvDate in AssignedFormatValues;
end;

function TBasedxReportLink.IsDesignerCaptionStored: Boolean;
begin
  Result := FIsDesignerCaptionAssigned and (DesignerCaption <> DefaultDesignerCaption);
end;

function TBasedxReportLink.IsTimeFormatStored: Boolean;
begin
  Result := fvTime in AssignedFormatValues;
end;

function TBasedxReportLink.IsPageNumberFormatStored: Boolean;
begin
  Result := fvPageNumber in AssignedFormatValues;
end;

procedure TBasedxReportLink.SetDateFormat(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > dxPgsDlg.DateFormats.Count - 1 then
    Value := dxPgsDlg.DateFormats.Count - 1;
  //if FDateFormat <> Value then
  begin
    FDateFormat := Value;
    AssignFormats(fvDate, FDateFormat <> DefaultDateFormat);
    if IsCurrentLink then
      dxHFFormatObject.DateFormat := dxPgsDlg.DateFormats[FDateFormat];
  end;
end;

procedure TBasedxReportLink.SetTimeFormat(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > dxPgsDlg.TimeFormats.Count - 1 then
    Value := dxPgsDlg.TimeFormats.Count - 1;
  //if FTimeFormat <> Value then
  begin
    FTimeFormat := Value;
    AssignFormats(fvTime, FTimeFormat <> DefaultTimeFormat);
    if IsCurrentLink then
      dxHFFormatObject.TimeFormat := dxPgsDlg.TimeFormats[FTimeFormat];
  end;
end;

procedure TBasedxReportLink.SetPageNumberFormat(Value: TdxPageNumberFormat);
begin
  //if FPageNumberFormat <> Value then
  begin
    FPageNumberFormat := Value;
    AssignFormats(fvPageNumber, FPageNumberFormat <> DefaultPageNumberFormat);
    if IsCurrentLink then
      dxHFFormatObject.PageNumberFormat := FPageNumberFormat;
  end;
end;

procedure TBasedxReportLink.SetAbortBuilding(Value: Boolean);
begin
  if ComponentPrinter <> nil then
    ComponentPrinter.AbortBuilding := Value;
end;

procedure TBasedxReportLink.SetAssignedFormatValues(Value: TdxAssignedFormatValues);
begin
  if DateFormat = DefaultDateFormat then
    Exclude(Value, fvDate);
  if TimeFormat = DefaultTimeFormat then
    Exclude(Value, fvTime);
  if PageNumberFormat = DefaultPageNumberFormat then
    Exclude(Value, fvPageNumber);
  if FAssignedFormatValues <> Value then
  begin
    FAssignedFormatValues := Value;
    DesignerModified;
  end;
end;

procedure TBasedxReportLink.SetCaption(const Value: string);
begin
  ReportDocument.Caption := Value;
end;

function TBasedxReportLink.GetAbortBuilding: Boolean;
begin
  Result := (ComponentPrinter <> nil) and ComponentPrinter.AbortBuilding;
end;

function TBasedxReportLink.GetCaption: string;
begin
  Result := ReportDocument.Caption;
end;

function TBasedxReportLink.GetCurrentPrintStyle: TBasedxPrintStyle;
begin
  if StyleManager <> nil then
    Result := StyleManager.CurrentStyle
  else
    Result := nil;
end;

function TBasedxReportLink.GetFontPool: TdxPSReportFontPool;
begin
  if not IsAggregated then 
  begin
    if FFontPool = nil then FFontPool := TdxPSReportFontPool.Create;
    Result := FFontPool;
  end
  else
    Result := Controller.FontPool;
end;

function TBasedxReportLink.GetHasDesignWindow: Boolean;
begin
  Result := DesignWindow <> nil;
end;

function TBasedxReportLink.GetHasPreviewWindow: Boolean;
begin
  Result := (ComponentPrinter <> nil) and (ComponentPrinter.PreviewWindow <> nil);
end;

procedure TBasedxReportLink.RetrievePageAsImage(APageIndex: Integer; AGraphicClass: TGraphicClass; 
  AGraphic: TGraphic);
begin 
  if ComponentPrinter <> nil then 
    TdxComponentPrinter(ComponentPrinter).EnumPagesAsImages([APageIndex], 
      AGraphicClass, False, RetrievePageAsImageCallBack, AGraphic, nil, nil, Self);
end;

procedure TBasedxReportLink.RetrievePageAsImageCallBack(AComponentPrinter: TCustomdxComponentPrinter;
  AReportLink: TBasedxReportLink; AIndex, APageIndex: Integer; const AGraphic: TGraphic; 
  AData: Pointer; var AContinue: Boolean);
begin
  TGraphic(AData).Assign(AGraphic);
end;

procedure TBasedxReportLink.ShowEmptyPagesChanged;
begin
  if EmptyPagesCanExist and (CurrentComposition = nil) then 
    CalculateRenderInfos;
end;

procedure TBasedxReportLink.ShowPageFooterChanged;
begin
  if CurrentComposition = nil then CalculateRenderInfos;
end;

procedure TBasedxReportLink.ShowPageHeaderChanged;
begin
  if CurrentComposition = nil then CalculateRenderInfos;
end;

procedure TBasedxReportLink.StdProcessDataSourceDontPresent;
begin
  raise EdxReportLink.Create(CannotActivateReportErrorString);
end;

procedure TBasedxReportLink.TunePixelsNumerator(AReportCells: TdxReportCells);
const 
  MaxReportWidth = $7FFF;
  MinFactor = 2;
var
  Wo, W: Integer;
begin
  Wo := GetCriticalSize(AReportCells);
  W := MulDiv(Wo, RenderInfo.UnitsPerInch, PixelsDenominator);
  if W > MaxReportWidth then 
    with RenderInfo do 
    begin
      UnitsPerInch := MulDiv(PixelsDenominator, MaxReportWidth, Wo);
      UnitsPerInch := UnitsPerInch - UnitsPerInch mod Screen.PixelsPerInch;
      if UnitsPerInch < MinFactor * Screen.PixelsPerInch then 
        UnitsPerInch := MinFactor * Screen.PixelsPerInch;
    end;
end;

procedure TBasedxReportLink.CalculateRenderInfos;
begin
  if DataProviderPresent then
  begin
    PrepareLongOperation;
    try
      RenderInfo.Calculate;
    finally
      UnprepareLongOperation;
    end;
  end;
end;

procedure TBasedxReportLink.ClearGDIPools;
begin
  BackgroundBitmapPool.Clear;
  Renderer.BrushPool.Clear;
  if (FFontPool <> nil) and not IsAggregated then 
    FontPool.Clear;
end;

function TBasedxReportLink.CreateRenderInfo: TdxPSReportRenderInfo;
begin
  Result := GetRenderInfoClass.Create(Self);
end;

procedure TBasedxReportLink.FreeRenderInfos;
begin
  FreeAndNil(FRenderInfo);
end;

function TBasedxReportLink.GetRenderInfoClass: TdxPSReportRenderInfoClass;
begin
  Result := TdxPSReportRenderInfo;
end;

function TBasedxReportLink.CreateRenderer: TdxPSReportRenderer;
begin
  Result := GetRendererClass.Create(Self);
end;

procedure TBasedxReportLink.FreeRenderer;
begin
  FreeAndNil(FRenderer);
end;

function TBasedxReportLink.GetRendererClass: TdxPSReportRendererClass;
begin
  Result := TdxPSReportRenderer;
end;

procedure TBasedxReportLink.InitializeDefaultFont(AFont: TFont);
begin
  AFont.CharSet := dxPSDefaultFontCharSet;
  AFont.Color := dxPSDefaultFontColor;
  AFont.Name := dxPSDefaultFontName;
  AFont.Size := dxPSDefaultFontSize;
  AFont.Style := dxPSDefaultFontStyle;
end;

procedure TBasedxReportLink.InternalGetDelimiters(ADelimitersHorz, ADelimitersVert: TList);
begin
  dxPSUtl.dxAppendList(RenderInfo.DelimiterXList, ADelimitersHorz);
  dxPSUtl.dxAppendList(RenderInfo.DelimiterYList, ADelimitersVert);
end;

function TBasedxReportLink.GetPageCount: Integer;
begin
  Result := RenderInfo.NonEmptyPageCount;
  if IsCurrentLink then
    dxHFFormatObject.TotalPages := Result;
end;

function TBasedxReportLink.GetUseHardVertDelimiters: Boolean;
begin
  Result := False;
end;

function TBasedxReportLink.GetVisiblePageCount: Integer;
begin
  if ShowEmptyPages then
    Result := VirtualPageCount
  else
    Result := PageCount;
end;

function TBasedxReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
begin
  Result := False;
end;

procedure TBasedxReportLink.SetStorageName(const Value: string);
begin
  if FStorageName <> Value then 
  begin
    FStorageName := Value;
    if FileExists(FStorageName) and (DataSource = rldsExternalStorage) then 
      LoadDataFromFile(FStorageName);
  end;
end;

procedure TBasedxReportLink.SetStyleManager(Value: TdxPrintStyleManager);
begin
  if FStyleManager <> Value then
  begin
    FStyleManager := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
    if not IsDestroying then  
      PageParamsChanged(RealPrinterPage, CurrentPrintStyle, ucAll);
  end;
end;

procedure TBasedxReportLink.SetPrinterPage(Value: TdxPrinterPage);
begin
  PrinterPage.Assign(Value);
end;

procedure TBasedxReportLink.SetReportDocument(Value: TdxPSReportDocument);
begin
  ReportDocument.Assign(Value);
end;

procedure TBasedxReportLink.SetReportTitleMode(Value: TdxReportTitleMode);
begin
  ReportTitle.Mode := Value;
end;

procedure TBasedxReportLink.SetReportTitleText(const Value: string);
begin
  ReportTitle.Text := Value;
end;

procedure TBasedxReportLink.SetReportTitle(Value: TdxReportTitle);
begin
  ReportTitle.Assign(Value);
end;

procedure TBasedxReportLink.SetComponentPrinter(Value: TCustomdxComponentPrinter);
begin
  if FComponentPrinter <> Value then
  begin
    if FComponentPrinter <> nil then FComponentPrinter.RemoveLink(Self);
    if Value <> nil then Value.InsertLink(Self);
  end;
end;

procedure TBasedxReportLink.SetIsCurrentLink(Value: Boolean);
begin
  if Value then
    if not (csReading in ComponentState) and (ComponentPrinter <> nil) then
      ComponentPrinter.CurrentLink := Self;
end;

procedure TBasedxReportLink.SetDataSource(Value: TdxReportLinkDataSource);
begin
  if FDataSource <> Value then
  begin
    FDataSource := Value;
    DoDataSourceChanged;
  end;
end;

procedure TBasedxReportLink.SetIndex(Value: Integer);
var
  CurIndex: Integer;
begin
  if ComponentPrinter = nil then Exit;
  if Value < 0 then Value := 0;
  if Value > ComponentPrinter.LinkCount - 1 then
    Value := ComponentPrinter.LinkCount - 1;
  CurIndex := GetIndex;
  if CurIndex <> Value then
    ComponentPrinter.MoveLink(CurIndex, Value);
end;

procedure TBasedxReportLink.ReadBuiltIn(Reader: TReader);
begin
  FBuiltIn := Reader.ReadBoolean;
end;

function GetComponentByName(const AName: string): TComponent;

   procedure CheckOwner(AOwner: TComponent);
   var
     I: Integer;
     AComponent: TComponent;
   begin
     if Result <> nil then Exit;
     for I := 0 to AOwner.ComponentCount - 1 do
     begin
       AComponent := AOwner.Components[I];
       if SameText(cxGetFullComponentName(AComponent), AName) then
       begin
         Result := AComponent;
         break;
       end
       else
         CheckOwner(AComponent);
     end;
   end;

var
  AOwner: TComponent;
begin
  Result := nil;
  AOwner := Application;
  while AOwner.Owner <> nil do
    AOwner := AOwner.Owner;
  CheckOwner(AOwner);
end;

procedure TBasedxReportLink.ReadComponentName(AReader: TReader);
begin
  Component := GetComponentByName(AReader.ReadString);
end;

procedure TBasedxReportLink.ReadIsDesignerCaptionAssigned(Reader: TReader);
begin
  FIsDesignerCaptionAssigned := Reader.ReadBoolean;
end;

procedure TBasedxReportLink.ReadStyleManagerName(AReader: TReader);
begin
  StyleManager := GetComponentByName(AReader.ReadString) as TdxPrintStyleManager;
end;

procedure TBasedxReportLink.WriteBuiltIn(Writer: TWriter);
begin
  Writer.WriteBoolean(FBuiltIn);
end;

procedure TBasedxReportLink.WriteComponentName(AWriter: TWriter);
begin
  AWriter.WriteString(cxGetFullComponentName(Component));
end;

procedure TBasedxReportLink.WriteIsDesignerCaptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsDesignerCaptionAssigned);
end;

procedure TBasedxReportLink.WriteStyleManagerName(AWriter: TWriter);
begin
  AWriter.WriteString(cxGetFullComponentName(StyleManager));
end;

procedure TBasedxReportLink.InternalActivate;
begin
  if DataProviderPresent then
  try
    AbortBuilding := False;
    try
      DoCreateReport;
    finally
      FRebuildNeeded := False;
      FActive := True;
      if AbortBuilding then
      begin
        FRebuildNeeded := True;
        DoDestroyReport;
      end;
    end;  
  except
    on E: Exception do
    begin
      DoDestroyReport;
      if IsDesigning then
        ShowException(E, ExceptAddr)
      else
        raise;
    end;    
  end
  else
    DoDataProviderDontPresent;
end;

procedure TBasedxReportLink.InternalRestoreDefaults;
begin
  Transparent := True;
  Color := dxDefaultContentColor; {clWhite}
  Font := DefaultFont;
  FootersOnEveryPage := False;
  HeadersOnEveryPage := False;
  
  PageNumberFormat := DefaultPageNumberFormat;
  DateFormat := DefaultDateFormat;
  TimeFormat := DefaultTimeFormat;

  FIsDesignerCaptionAssigned := False;
end;

procedure TBasedxReportLink.InternalRestoreFromOriginal;
begin
  if Component is TControl then
  begin
    Color := dxPSUtl.Control_GetColor(TControl(Component));
    Font := dxPSUtl.Control_GetFont(TControl(Component));
  end;
end;

procedure TBasedxReportLink.SetUseHorzDelimiters(Value: Boolean);
begin
  if FUseHorzDelimiters <> Value then
  begin
    FUseHorzDelimiters := Value;
    LinkModified(True);
  end;
end;

procedure TBasedxReportLink.SetUseVertDelimiters(Value: Boolean);
begin
  if FUseVertDelimiters <> Value then
  begin
    FUseVertDelimiters := Value;
    LinkModified(True);
  end;
end;

procedure TBasedxReportLink.AssignFormats(AnItem: TdxAssignedFormatValue; AValue: Boolean);
begin
  if AValue then
    Include(FAssignedFormatValues, AnItem)
  else
    Exclude(FAssignedFormatValues, AnItem);
end;

function TBasedxReportLink.ValidateMargins: Boolean;
begin
  Result := RealPrinterPage.ValidateMargins;
  if not Result then
  begin
    Result := MessageQuestion(cxGetResourceString(@sdxOutsideMarginsMessage));
    if Result then
      RealPrinterPage.FixMarginsOutSide;
  end;  
end;

procedure TBasedxReportLink.SetStartPageIndex(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if FStartPageIndex <> Value then 
  begin
    FStartPageIndex := Value;
    dxHFFormatObject.StartPageIndex := Value;
  end;    
end;

procedure TBasedxReportLink.DoDestroy;
begin
  if Assigned(FOnDestroy) then FOnDestroy(Self);
end;

procedure TBasedxReportLink.ComponentUnsupportedError(AComponent: TComponent);
begin
  if not IsDesigning then
    raise EdxReportLink.CreateFmt(cxGetResourceString(@sdxComponentNotSupportedByLink), [AComponent.ClassName]);
end;

procedure TBasedxReportLink.DoChangeComponent;
begin
  if Assigned(FOnChangeComponent) then FOnChangeComponent(Self);
end;

procedure TBasedxReportLink.DoProgress(const APercentDone: Double);
begin
  if (ComponentPrinter <> nil) and not IsAggregated then
    ComponentPrinter.DoProgress(Self, APercentDone);
end;

function TBasedxReportLink.GetDesignerClass: TdxReportLinkDesignWindowClass;
begin
  if Component <> nil then
    Result := dxPSDesignerClassByCompClass(TComponentClass(Component.ClassType))
  else
    Result := dxPSDesignerClassByLinkClass(LinkClass);
end;

procedure TBasedxReportLink.DoApplyInDesigner;
begin
  RebuildReport;
end;

procedure TBasedxReportLink.DoCreateReport;
begin
  if FReportCells = nil then 
    FReportCells := CreateReportCells;
  DoCreateReportData;
  
  if not AbortBuilding and not IsInvalidReport then
    if not IsAggregated then
    begin
      if IsWin9X then 
        TunePixelsNumerator(FReportCells);
      FPixelsNumerator := RenderInfo.UnitsPerInch;
      if DataSource = rldsComponent then 
      begin
        PrepareReportGroupsLookAndFeels;
        ConvertCoords;
        RenderInfo.GetDelimiters;
      end;  
      CalculateRenderInfos;
    end
    else
      if DataSource = rldsComponent then RenderInfo.GetDelimiters;
end;

procedure TBasedxReportLink.DoCreateReportData;
var
  ReraiseException: Boolean;
begin
  case DataSource of
    rldsComponent: 
      ConstructReport(FReportCells);
      
    rldsExternalStorage: 
      try
        InternalLoadDataFromStream(DataStream);
        DataStream.Position := 0;
      except
        ReraiseException := (ComponentPrinter <> nil) and (ComponentPrinter.Explorer <> nil);
        if not ReraiseException then 
          MessageError(Format(cxGetResourceString(@sdxReportFileLoadError), [StorageName]));

        FIsInvalidReport := True;
        try
          DataSource := rldsComponent;
        finally
          FIsInvalidReport := False;
        end;
        if ReraiseException then raise;
      end;  
  end;
end;

procedure TBasedxReportLink.DoDataProviderDontPresent;
begin
  if (ComponentPrinter = nil) or (ComponentPrinter.CurrentCompositionByLink(Self) = nil) then
    StdProcessDataSourceDontPresent;
end;  

procedure TBasedxReportLink.DoDestroyReport;
begin
  FActive := False;
  
  PrepareLongOperation;
  try
    FreeAndNil(FReportCells);
    if FRenderInfo <> nil then RenderInfo.Refresh;
    if ComponentPrinter <> nil then ComponentPrinter.DoBeforeDestroyReport(Self);
  finally
    UnprepareLongOperation;
  end;
end;

procedure TBasedxReportLink.DoPageParamsChanged;
begin
  if ComponentPrinter <> nil then 
    ComponentPrinter.DoPageParamsChanged(Self);
end;

procedure TBasedxReportLink.CopyDataStreamFrom(AStream: TStream);
begin
  AStream.Position := 0;
  FinalizeDataStream;
  FDataStream := TMemoryStream.Create;
  FDataStream.CopyFrom(AStream, AStream.Size);
  FDataStream.Position := 0;
end;

procedure TBasedxReportLink.FinalizeDataStream;
begin
  FreeAndNil(FDataStream);
end;

function TBasedxReportLink.IsDrawFootersOnEveryPage: Boolean;
begin
  Result := FootersOnEveryPage;
end;

function TBasedxReportLink.IsDrawHeadersOnEveryPage: Boolean;
begin
  Result := HeadersOnEveryPage;
end;

procedure TBasedxReportLink.ConstructReport(AReportCells: TdxReportCells);
begin
  ClearGDIPools;
  AddFontToPool(Font);
end;

procedure TBasedxReportLink.ConvertCoords;
begin
  FReportCells.ConvertCoords(PixelsNumerator, PixelsDenominator);
end;

procedure TBasedxReportLink.MakeDelimiters(AReportCells: TdxReportCells;
  AHorzDelimiters, AVertDelimiters: TList);
begin
end;

procedure TBasedxReportLink.MakeHardDelimiters(AReportCells: TdxReportCells; 
  AVertDelimiters: TList);
begin
end;

procedure TBasedxReportLink.DoDataSourceChanged;
begin
  if Assigned(FOnDataSourceChanged) then FOnDataSourceChanged(Self);
  if IsRebuildNeededAndAllowed(True) then 
  begin
    if DataSource = rldsComponent then
    begin   
      ReportDocument.Assign(FSavedReportDocument);
      ReportTitle.BeginUpdate;
      try
        ReportTitle.Assign(FSavedReportTitle);
      finally
        ReportTitle.CancelUpdate;
      end;
    end
    else  
    begin  
      FSavedReportDocument.Assign(ReportDocument);
      FSavedReportTitle.Assign(ReportTitle);
    end;
    RebuildReport;
  end
  else
    if DataSource = rldsComponent then 
      DestroyReport;  
end;
                                
procedure TBasedxReportLink.CustomDraw(AnItem: TAbstractdxReportCellData; ACanvas: TCanvas;
  ABoundsRect, AClientRect: TRect; var ADone: Boolean);
begin
end;

function TBasedxReportLink.IsScaleGridLines: Boolean;
begin
  Result := True;
end;

function TBasedxReportLink.IsSupportedCustomDraw(Item: TAbstractdxReportCellData): Boolean;
begin
  Result := False;
end;

{ TdxCompositionLinkItem }

constructor TdxCompositionLinkItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FBuiltIn := (Composition <> nil) and Composition.IsDesigning;    
end;

procedure TdxCompositionLinkItem.Assign(Source: TPersistent);

  function IsInheritedForm: Boolean;
  begin
    with Composition do 
      Result := (csUpdating in ComponentState) or (csUpdating in ComponentPrinter.ComponentState) or
        ((ComponentPrinter.Owner <> nil) and (csUpdating in ComponentPrinter.Owner.ComponentState));
  end;

begin
  if Source is TdxCompositionLinkItem then 
    with TdxCompositionLinkItem(Source) do 
      if (ReportLink <> nil) and (Self.Composition <> nil) and (Self.Composition.ComponentPrinter <> nil) and IsInheritedForm then
        Self.ReportLink := Self.Composition.ComponentPrinter.LinkByName(ReportLink.Name)
      else
        Self.ReportLink := ReportLink
  else 
    inherited;
end;

procedure TdxCompositionLinkItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('BuiltInCompositionItem', ReadData, WriteData, True);
  Filer.DefineProperty('LinkName', ReadLinkName, WriteLinkName,
    Composition.InternalStreaming and (ReportLink <> nil));
end;

procedure TdxCompositionLinkItem.SetIndex(Value: Integer);
begin
  if Collection <> nil then 
    TdxCompositionLinkItems(Collection).FDontNeedRebuild := True;
  inherited;
end;

function TdxCompositionLinkItem.Composition: TdxCompositionReportLink;
begin
  if Collection <> nil then
    Result := TdxCompositionLinkItems(Collection).Composition
  else
    Result := nil;
end;

procedure TdxCompositionLinkItem.SetReportLink(Value: TBasedxReportLink);
begin
  if (FReportLink <> Value) and (Collection <> nil) and 
   ((Value = nil) or TdxCompositionLinkItems(Collection).IsLinkComposable(Value)) then
  begin
    if (FReportLink <> nil) and (Composition <> nil) and Composition.IsCurrentLink and 
      Composition.PreviewExists and not TdxCompositionLinkItems(Collection).LinkExists(Value) then 
      Composition.ComponentPrinter.DestroyPreviewWindow;
    FReportLink := Value;
    if Collection <> nil then 
      TdxCompositionLinkItems(Collection).FDontNeedRebuild := False;
    Changed(True);
  end;
end;

procedure TdxCompositionLinkItem.ReadData(Reader: TReader);
begin
  FBuiltIn := Reader.ReadBoolean;
end;

procedure TdxCompositionLinkItem.ReadLinkName(Reader: TReader);
begin
  FLoadingReportLinkName := Reader.ReadString;
end;

procedure TdxCompositionLinkItem.WriteData(Writer: TWriter);
begin
  Writer.WriteBoolean(FBuiltIn);
end;

procedure TdxCompositionLinkItem.WriteLinkName(Writer: TWriter);
begin
  Writer.WriteString(cxGetFullComponentName(ReportLink));
end;

{ TdxCompositionLinkItems }

constructor TdxCompositionLinkItems.Create(AComposition: TdxCompositionReportLink);
begin
  inherited Create(TdxCompositionLinkItem);
  FComposition := AComposition;
end;

function TdxCompositionLinkItems.Add: TdxCompositionLinkItem;
begin
  Result := TdxCompositionLinkItem(inherited Add);
end;

function TdxCompositionLinkItems.AddLink(AReportLink: TBasedxReportLink): TdxCompositionLinkItem;
begin
  if IsLinkComposable(AReportLink) then 
  begin
    Result := Add;
    Result.ReportLink := AReportLink;
  end
  else
    Result := nil;
end;

procedure TdxCompositionLinkItems.DeleteItemsByLink(AReportLink: TBasedxReportLink);
var
  List: TList;
  I: Integer;
begin
  List := TList.Create;
  try
    GetLinkEntries(AReportLink, List);
    if List.Count <> 0 then 
    begin
      BeginUpdate;
      try
        for I := 0 to List.Count - 1 do 
          TObject(List[I]).Free;
      finally
        EndUpdate;
      end;    
    end;  
  finally
    List.Free;
  end;  
end;                            

procedure TdxCompositionLinkItems.DeleteNonBuiltIns;
var
  I: Integer;
  Item: TdxCompositionLinkItem;
begin
  BeginUpdate;
  try
    for I := Count - 1 downto 0 do
    begin
      Item := Items[I];
      if not Item.BuiltIn then Item.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxCompositionLinkItems.GetLinkEntries(AReportLink: TBasedxReportLink; AList: TList);
var
  I: Integer;
  Item: TdxCompositionLinkItem;
begin
  for I := 0 to Count - 1 do 
  begin
    Item := Items[I];
    if Item.ReportLink = AReportLink then AList.Add(Item);
  end;
end;

function TdxCompositionLinkItems.IndexOfLink(AReportLink: TBasedxReportLink): Integer;
begin
  for Result := 0 to Count - 1 do 
    if AReportLink = Items[Result].ReportLink then 
      Exit;
  Result := -1;
end;

function TdxCompositionLinkItems.IsLinkComposable(AReportLink: TBasedxReportLink): Boolean;
begin
  Result := (AReportLink <> nil) and (Composition <> nil) and AReportLink.IsComposable(Composition) and 
    (AReportLink.ComponentPrinter = Composition.ComponentPrinter) and 
    not (AReportLink is TdxCompositionReportLink);
end;

function TdxCompositionLinkItems.LinkExists(AReportLink: TBasedxReportLink): Boolean;
var
  List: TList;
begin
  List := TList.Create;
  try
    GetLinkEntries(AReportLink, List);
    Result := List.Count <> 0;
  finally
    List.Free;
  end;
end;

function TdxCompositionLinkItems.NextAssignedItem(AnItem: TdxCompositionLinkItem): TdxCompositionLinkItem;
var
  Index: Integer;
begin
  if AnItem <> nil then 
    Index := AnItem.Index + 1
  else
    Index := Count;  
  while (Index < Count) and (Items[Index].ReportLink = nil) do 
    Inc(Index);
  if Index < Count then 
    Result := Items[Index]
  else
    Result := nil;
end;

function TdxCompositionLinkItems.NonBuiltInsExists: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to Count - 1 do
    if not Items[I].BuiltIn then Exit;
  Result := False;
end;

function TdxCompositionLinkItems.PrevAssignedItem(AnItem: TdxCompositionLinkItem): TdxCompositionLinkItem;
var
  Index: Integer;
begin
  if AnItem <> nil then 
    Index := AnItem.Index - 1
  else
    Index := -1;
  while (Index > -1) and (Items[Index].ReportLink = nil) do 
    Dec(Index);
  if Index > -1 then 
    Result := Items[Index]
  else
    Result := nil;
end;

procedure TdxCompositionLinkItems.CorrectLinksAfterLoadings;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].FReportLink := GetComponentByName(Items[I].FLoadingReportLinkName) as TBasedxReportLink;
end;

function TdxCompositionLinkItems.GetOwner: TPersistent;
begin
  Result := Composition;
end;

procedure TdxCompositionLinkItems.Update(Item: TCollectionItem);
begin
  if (Composition <> nil) and not Composition.IsDestroying and not Composition.IsLoading then 
    if FDontNeedRebuild or not Composition.DataProviderPresent then
    begin 
      Composition.UpdateComposition(ucAll);
      FDontNeedRebuild := False;
    end
    else
     if Composition.DataProviderPresent then // TODO: Check non PreviewState
       Composition.RebuildReport;
end;

function TdxCompositionLinkItems.GetItem(Index: Integer): TdxCompositionLinkItem;
begin
  Result := TdxCompositionLinkItem(inherited Items[Index]);
end;

procedure TdxCompositionLinkItems.SetItem(Index: Integer; Value: TdxCompositionLinkItem);
begin
  inherited SetItem(Index, Value);
end;

{ TdxPSCompositionReportRenderInfo }

constructor TdxPSCompositionReportRenderInfo.Create(AReportLink: TBasedxReportLink);
begin
  inherited;
  FStartIndexes := TList.Create;
end;

destructor TdxPSCompositionReportRenderInfo.Destroy;
begin
  FreeAndNil(FStartIndexes);
  inherited;
end;

function TdxPSCompositionReportRenderInfo.CalculateNonEmptyPageCount: Integer;
var
  Items: TStrings;
  I: Integer;
  RenderInfo: TdxPSReportRenderInfo;
begin
  Result := 0;
  Items := TStringList.Create;
  try
    ReportLink.GetItems(Items, True);
    for I := 0 to Items.Count - 1 do
    begin
      RenderInfo := TdxCompositionLinkItem(Items.Objects[I]).ReportLink.RenderInfo;
      Inc(Result, RenderInfo.NonEmptyPageCount);
    end;
  finally
    Items.Free;
  end;
end;

function TdxPSCompositionReportRenderInfo.CalculatePageColCount: Integer;
var
  Items: TStrings;
  I: Integer;
  RenderInfo: TdxPSReportRenderInfo;
begin
  Result := 0;
  Items := TStringList.Create;
  try
    ReportLink.GetItems(Items, True);
    for I := 0 to Items.Count - 1 do
    begin
      RenderInfo := TdxCompositionLinkItem(Items.Objects[I]).ReportLink.RenderInfo;
      if Result < RenderInfo.PageColCount then
        Result := RenderInfo.PageColCount;
    end;
  finally
    Items.Free;
  end;
end;

function TdxPSCompositionReportRenderInfo.CalculatePageRowCount: Integer;
var
  Items: TStrings;
  I: Integer;
  RenderInfo: TdxPSReportRenderInfo;
begin
  Result := 0;
  Items := TStringList.Create;
  try
    ReportLink.GetItems(Items, True);
    for I := 0 to Items.Count - 1 do
    begin
      RenderInfo := TdxCompositionLinkItem(Items.Objects[I]).ReportLink.RenderInfo;
      if Result < RenderInfo.PageRowCount then
        Result := RenderInfo.PageRowCount;
    end;
  finally
    Items.Free;
  end;
end;

procedure TdxPSCompositionReportRenderInfo.DoCalculate;
var
  Items: TStrings;
  PrevPageCount, I: Integer;
  Link: TBasedxReportLink;
begin
  Items := TStringList.Create;
  try
    ReportLink.GetItems(Items, True);
    FStartIndexes.Count := Items.Count;
  
    PrevPageCount := 0;
    for I := 0 to Items.Count - 1 do 
    begin
      Link := TdxCompositionLinkItem(Items.Objects[I]).ReportLink;
      Link.CalculateRenderInfos;
      if I = 0 then 
        StartIndexes[I] := 0
      else
        StartIndexes[I] := StartIndexes[I - 1] + PrevPageCount;

      if ReportLink.ShowEmptyPages then 
        PrevPageCount := Link.RenderInfo.VirtualPageCount
      else
        PrevPageCount := Link.RenderInfo.NonEmptyPageCount;
        
      Inc(VirtualPageCount, Link.VirtualPageCount);
    end;  
  finally
    Items.Free;
  end;  
end;

procedure TdxPSCompositionReportRenderInfo.Refresh;
begin
  FNonEmptyPageCount := -1;
  FPageColCount := -1;
  FPageRowCount := -1;
  FStartIndexes.Clear;
  inherited;
end;

function TdxPSCompositionReportRenderInfo.GetNonEmptyPageCount: Integer;
begin
  if FNonEmptyPageCount = -1 then
    FNonEmptyPageCount := CalculateNonEmptyPageCount;
  Result := FNonEmptyPageCount;  
end;

function TdxPSCompositionReportRenderInfo.GetPageColCount: Integer;
begin
  if FPageColCount = -1 then
    FPageColCount := CalculatePageColCount;
  Result := FPageColCount;
end;

function TdxPSCompositionReportRenderInfo.GetPageRowCount: Integer;
begin
  if FPageRowCount = -1 then
    FPageRowCount := CalculatePageRowCount;
  Result := FPageColCount;
end;

function TdxPSCompositionReportRenderInfo.RealPageIndexToVirtualPageIndex(APageIndex: Integer; 
  ATakeIntoAccountEmptyPages: Boolean): Integer;
var
  Item: TdxCompositionLinkItem;
begin 
  GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex, APageIndex, Item);
  if Item <> nil then 
    Result := Item.ReportLink.RealPageIndexToVirtualPageIndex(APageIndex, ATakeIntoAccountEmptyPages)
  else
    Result := APageIndex;
end;    
  
function TdxPSCompositionReportRenderInfo.VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer;
var
  Item: TdxCompositionLinkItem;
begin
  GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex, APageIndex, Item);
  if Item <> nil then 
    Result := Item.ReportLink.VirtualPageIndexToRealPageIndex(APageIndex)
  else
    Result := APageIndex;
end;    

procedure TdxPSCompositionReportRenderInfo.GetCompositionLinkItemByPageIndexAndFixIndex(
  APageIndex: Integer; var APageIndexRelativeToLink: Integer; var AnItem: TdxCompositionLinkItem);

  function GetPageCount(ARenderInfo: TdxPSReportRenderInfo): Integer;
  begin
    if ReportLink.ShowEmptyPages then 
      Result := ARenderInfo.VirtualPageCount
    else
      Result := ARenderInfo.NonEmptyPageCount;
  end;

var
  Items: TStrings;
  I: Integer;
begin
  APageIndexRelativeToLink := APageIndex;
  if (APageIndex = -1) or (FStartIndexes = nil) then
  begin
    AnItem := nil;
    Exit;
  end;
  
  Items := TStringList.Create;
  try
    ReportLink.GetItems(Items, True);
    for I := 0 to Items.Count - 1 do 
    begin
      AnItem := TdxCompositionLinkItem(Items.Objects[I]);
      if (StartIndexes[I] <= APageIndex) and (APageIndex < StartIndexes[I] + GetPageCount(AnItem.ReportLink.RenderInfo)) then 
      begin
        Dec(APageIndexRelativeToLink, StartIndexes[I]);
        Exit;
      end;
    end;  
    AnItem := nil;
  finally
    Items.Free;
  end;  
end;

function TdxPSCompositionReportRenderInfo.GetReportLink: TdxCompositionReportLink;
begin
  Result := inherited ReportLink as TdxCompositionReportLink;
end;

function TdxPSCompositionReportRenderInfo.GetStartIndex(Index: Integer): Integer;
begin
  Result := Integer(FStartIndexes[Index]);
end;

function TdxPSCompositionReportRenderInfo.GetStartIndexCount: Integer;
begin
  Result := FStartIndexes.Count;
end;

procedure TdxPSCompositionReportRenderInfo.SetStartIndex(Index: Integer; Value: Integer);
begin
  FStartIndexes[Index] := TObject(Value);
end;

{ TdxPSCompositionReportRenderer }

procedure TdxPSCompositionReportRenderer.RenderPage(ACanvas: TCanvas; 
  const APageBounds: TRect; APageIndex, AContinuousPageIndex, AZoomFactor: Integer);
var
  LinkPageIndex: Integer;
  Item: TdxCompositionLinkItem;
begin
  RenderInfo.GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex, LinkPageIndex, Item);
  if (Item <> nil) and (Item.ReportLink <> nil) then 
  begin            
    if not ReportLink.ContinuousPageIndexes then
      dxHFFormatObject.TotalPages := Item.ReportLink.PageCount;
    Item.ReportLink.PaintPage(ACanvas, APageBounds, LinkPageIndex, AContinuousPageIndex, AZoomFactor);
  end;  
end;

function TdxPSCompositionReportRenderer.GetRenderInfo: TdxPSCompositionReportRenderInfo;
begin
  Result := inherited RenderInfo as TdxPSCompositionReportRenderInfo;
end;

function TdxPSCompositionReportRenderer.GetReportLink: TdxCompositionReportLink;
begin
  Result := inherited ReportLink as TdxCompositionReportLink;
end;

{ TdxPSReportCompositionDocument }

function TdxPSReportCompositionDocument.DefaultDescription: string;
begin
  Result := cxGetResourceString(@sdxComposition);
end;

function TdxPSReportCompositionDocument.GetReportLink: TdxCompositionReportLink;
begin
  Result := inherited ReportLink as TdxCompositionReportLink;
end;

{ TdxCompositionReportLink }

constructor TdxCompositionReportLink.Create(AOwner: TComponent);
begin
  inherited;
  FContinuousPageIndexes := True;
  ReportDocument.Description := cxGetResourceString(@sdxComposition);
  FDesignerOptions := [coCanEdit, coShowDescription];
  FItems := TdxCompositionLinkItems.Create(Self);
end;

destructor TdxCompositionReportLink.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

procedure TdxCompositionReportLink.Assign(Source: TPersistent);
begin
  if Source is TdxCompositionReportLink then 
    with TdxCompositionReportLink(Source) do 
    begin
      Self.ContinuousPageIndexes := ContinuousPageIndexes;
      Self.DesignerOptions := DesignerOptions;
    end;  
  inherited;  
end;

function TdxCompositionReportLink.DefaultDesignerCaption: string;
begin
  Result := cxGetResourceString(@sdxCompositionDesignerCaption);
end;

function TdxCompositionReportLink.RealPageIndexToVirtualPageIndex(APageIndex: Integer;
  ATakeIntoAccountEmptyPages: Boolean): Integer;
var
  PageIndexRelativeToLink: Integer;
  CurrentItem, Item: TdxCompositionLinkItem;
begin
  Result := 0;
  RenderInfo.GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex, PageIndexRelativeToLink, CurrentItem);
  Item := Items.PrevAssignedItem(CurrentItem);
  while Item <> nil do 
  begin
    Inc(Result, Item.ReportLink.VirtualPageCount);
    Item := Items.PrevAssignedItem(Item);  
  end;
  if CurrentItem <> nil then 
    Inc(Result, CurrentItem.ReportLink.RealPageIndexToVirtualPageIndex(PageIndexRelativeToLink, ATakeIntoAccountEmptyPages));
end;  

function TdxCompositionReportLink.VirtualPageIndexToRealPageIndex(APageIndex: Integer): Integer;
var
  PageIndexRelativeToLink: Integer;
  CurrentItem, Item: TdxCompositionLinkItem;
begin
  Result := 0;
  RenderInfo.GetCompositionLinkItemByPageIndexAndFixIndex(APageIndex, PageIndexRelativeToLink, CurrentItem);
  Item := Items.PrevAssignedItem(CurrentItem);
  while Item <> nil do 
  begin
    Inc(Result, 1 + Item.ReportLink.VirtualPageIndexToRealPageIndex(Item.ReportLink.VirtualPageCount - 1));
    Item := Items.PrevAssignedItem(Item);  
  end;
  if CurrentItem <> nil then 
    Inc(Result, CurrentItem.ReportLink.VirtualPageIndexToRealPageIndex(PageIndexRelativeToLink));
end;

class function TdxCompositionReportLink.CanBeUsedAsStub: Boolean;
begin
  Result := False;
end;

function TdxCompositionReportLink.DataProviderPresent: Boolean;
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  Result := True;
  for I := 0 to Items.Count - 1 do
  begin
    ReportLink := Items[I].ReportLink;
    if (ReportLink <> nil) and ReportLink.DataProviderPresent then
      Exit;
  end;
  Result := False;
end;

function TdxCompositionReportLink.IsEmptyPage(AVirtualPageIndex: Integer): Boolean;
var
  PageIndexRelativeToLink: Integer;
  CurrentItem: TdxCompositionLinkItem;
begin
  RenderInfo.GetCompositionLinkItemByPageIndexAndFixIndex(AVirtualPageIndex, PageIndexRelativeToLink, CurrentItem);
  Result := (CurrentItem <> nil) and
    CurrentItem.ReportLink.IsEmptyPage(PageIndexRelativeToLink);
end;

function TdxCompositionReportLink.SupportsTitle: Boolean;
begin
  Result := False;
end;

procedure TdxCompositionReportLink.GetItems(AStrings: TStrings; AExcludeUnassigned: Boolean);
var  
  I: Integer;
  Item: TdxCompositionLinkItem;
  S: string;
begin
  AStrings.BeginUpdate;
  try
    for I := 0 to Items.Count - 1 do 
    begin
      Item := Items[I];
      if (Item.ReportLink = nil) and AExcludeUnassigned then
        Continue;
      if Item.ReportLink = nil then 
        S := ''
      else
        S := Item.ReportLink.Caption;
      AStrings.AddObject(S, Item);
    end;   
  finally
    AStrings.EndUpdate;
  end;  
end;

procedure TdxCompositionReportLink.Notification(AComponent: TComponent; AOperation: TOperation);
var
  List: TList;
  I: Integer;
begin
  inherited;
  if (AOperation = opRemove) and (AComponent is TBasedxReportLink) and (AComponent <> Self) then
  begin                              
    List := TList.Create;
    try
      Items.GetLinkEntries(TBasedxReportLink(AComponent), List);
      for I := 0 to List.Count - 1 do 
        TdxCompositionLinkItem(List[I]).ReportLink := nil;
    finally
      List.Free;
    end;
  end;
end;

function TdxCompositionReportLink.GetContinuousPageIndexes: Boolean;
begin
  Result := FContinuousPageIndexes;
end;

procedure TdxCompositionReportLink.SetContinuousPageIndexes(Value: Boolean);
begin
  if ContinuousPageIndexes <> Value then 
  begin
    FContinuousPageIndexes := Value;
    // TODO: Refresh preview
    //if PreviewExists then PreviewWindow.InvalidateAllPages;
  end;
end;

function TdxCompositionReportLink.GetAllowContinuousPageIndexes: Boolean;
begin 
  Result := True;
end;  

function TdxCompositionReportLink.GetEmptyPagesCanExist: Boolean;
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  Result := True;
  for I := 0 to Items.Count - 1 do
  begin
    ReportLink := Items[I].ReportLink;
    if (ReportLink <> nil) and ReportLink.GetEmptyPagesCanExist then 
      Exit;
  end;  
  Result := False;
end;

function TdxCompositionReportLink.GetRebuildOnPageParamsChange(AUpdateCodes: TdxPrinterPageUpdateCodes): Boolean;
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  Result := True;
  for I := 0 to Items.Count - 1 do 
  begin
    ReportLink := Items[I].ReportLink;
    if (ReportLink <> nil) and ReportLink.GetRebuildOnPageParamsChange(AUpdateCodes) then
      Exit;
  end;
  Result := False;
end;

procedure TdxCompositionReportLink.ConstructReport(AReportCells: TdxReportCells);
begin
end;

procedure TdxCompositionReportLink.DoCreateReport;
var
  I: Integer;
  Item: TdxCompositionLinkItem;
  ReportLink: TBasedxReportLink;
begin
  Include(FCompositionState, csRebuildReportLink);
  try
    for I := 0 to Items.Count - 1 do 
    begin
      Item := Items[I];
      ReportLink := Item.ReportLink;
      if (ReportLink <> nil) and ReportLink.DataProviderPresent and 
        ((FInvalidatedLinks = nil) or (FInvalidatedLinks.IndexOf(ReportLink) <> -1)) then 
      begin
        DoBeforeBuildReport(Item);
        try
          ReportLink.RebuildReport;
        finally
          DoAfterBuildReport(Item);
        end;
      end;  
      DoProgress(100 * (I + 1) / Items.Count);
      if AbortBuilding then Break;
    end;  
  finally
    Exclude(FCompositionState, csRebuildReportLink);
  end;  
  
  if not AbortBuilding then CalculateRenderInfos;
end;

function TdxCompositionReportLink.GetRendererClass: TdxPSReportRendererClass;
begin
  Result := TdxPSCompositionReportRenderer;
end;

function TdxCompositionReportLink.GetRenderInfoClass: TdxPSReportRenderInfoClass;
begin
  Result := TdxPSCompositionReportRenderInfo;
end;

function TdxCompositionReportLink.GetReportHeight: Integer;
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do 
  begin 
    ReportLink := Items[I].ReportLink;
    if ReportLink <> nil then 
      Inc(Result, ReportLink.ReportHeight);
  end;
end;

function TdxCompositionReportLink.GetReportWidth: Integer;
var
  I, V: Integer;
  ReportLink: TBasedxReportLink;
begin
  Result := 0;
  for I := 0 to Items.Count - 1 do 
  begin 
    ReportLink := Items[I].ReportLink;
    if ReportLink <> nil then 
    begin
      V := ReportLink.ReportWidth;
      if Result < V then Result := V;
    end;
  end;  
end;

procedure TdxCompositionReportLink.InternalRestoreDefaults;
var
  I: Integer;
  ReportLink: TBasedxReportLink;  
begin
  FContinuousPageIndexes := True;
  ReportDocument.Description := cxGetResourceString(@sdxComposition);
  FDesignerCaption := cxGetResourceString(@sdxCompositionDesignerCaption);
  FDesignerOptions := [coCanEdit, coShowDescription];
  for I := 0 to Items.Count - 1 do 
  begin
    ReportLink := Items[I].ReportLink;
    if ReportLink <> nil then 
      ReportLink.RestoreDefaults;
  end;                      
end;

procedure TdxCompositionReportLink.InternalRestoreFromOriginal;
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  for I := 0 to Items.Count - 1 do 
  begin
    ReportLink := Items[I].ReportLink;
    if ReportLink <> nil then 
      ReportLink.RestoreFromOriginal;
  end;  
end;

procedure TdxCompositionReportLink.ShowEmptyPagesChanged;
begin
  if EmptyPagesCanExist then CalculateRenderInfos;
end;

procedure TdxCompositionReportLink.ShowPageFooterChanged;
begin
  CalculateRenderInfos;
end;

procedure TdxCompositionReportLink.ShowPageHeaderChanged;
begin
  CalculateRenderInfos;
end;

procedure TdxCompositionReportLink.StdProcessDataSourceDontPresent;
begin
//  raise EdxReportLink.Create(cxGetResourceString(@sdxDataSourceDontPresent));
end;

procedure TdxCompositionReportLink.DoAfterBuildReport(AItem: TdxCompositionLinkItem);
begin
  if Assigned(FOnAfterBuildReport) then FOnAfterBuildReport(Self, AItem);
end;

procedure TdxCompositionReportLink.DoBeforeBuildReport(AItem: TdxCompositionLinkItem);
begin
  if Assigned(FOnBeforeBuildReport) then FOnBeforeBuildReport(Self, AItem);
end;

class function TdxCompositionReportLink.GetReportDocumentClass: TdxPSReportDocumentClass;
begin
  Result := TdxPSReportCompositionDocument;
end;

class function TdxCompositionReportLink.Serializable: Boolean;
begin
  Result := False; 
end;

function TdxCompositionReportLink.GetRenderer: TdxPSCompositionReportRenderer;
begin
  Result := inherited Renderer as TdxPSCompositionReportRenderer;
end;
  
function TdxCompositionReportLink.GetRenderInfo: TdxPSCompositionReportRenderInfo;
begin
  Result := inherited RenderInfo as TdxPSCompositionReportRenderInfo;
end;

function TdxCompositionReportLink.GetReportDocument: TdxPSReportCompositionDocument;
begin
  Result := inherited ReportDocument as TdxPSReportCompositionDocument;
end;

procedure TdxCompositionReportLink.SetItems(Value: TdxCompositionLinkItems);
begin
  FItems.Assign(Value);
end;

procedure TdxCompositionReportLink.SetReportDocument(Value: TdxPSReportCompositionDocument);
begin
  inherited ReportDocument := Value;
end;

procedure TdxCompositionReportLink.ActivateLink(AReportLink: TBasedxReportLink);
begin
  Include(FCompositionState, csRebuildReportLink);
  try
    FInvalidatedLinks := TList.Create;
    try
      FInvalidatedLinks.Add(AReportLink);
      RebuildReport;
    finally
      FreeAndNil(FInvalidatedLinks);
    end;
  finally
    Exclude(FCompositionState, csRebuildReportLink);
  end;  
end;

procedure TdxCompositionReportLink.UpdateComposition(AUpdateCodes: TdxPrinterPageUpdateCodes);
begin
  PageParamsChanged(RealPrinterPage, CurrentPrintStyle, AUpdateCodes);  
end;

{ TAbstractdxReportLinkDesignWindow }

constructor TAbstractdxReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := cxGetResourceString(@sdxReportDesignerCaption);
end;

function TAbstractdxReportLinkDesignWindow.Execute: Boolean;
begin
  Include(FState, dwsInitialize);
  try
    Initialize;
  finally
    Exclude(FState, dwsInitialize);
  end;  
  Result := (ReportLink <> nil) and (ShowModal = mrOK);// and Modified and not Applyed; 
end;

procedure TAbstractdxReportLinkDesignWindow.CreateWnd;
begin
  inherited;
  if Icon.Handle = 0 then
    Icon_LoadFromResourceName(Icon, IDB_DXPSREPORTDESIGNER);
  SendMessage(Handle, WM_SETICON, 1, Icon.Handle);
end;

procedure TAbstractdxReportLinkDesignWindow.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (ReportLink <> nil) and ReportLink.PreviewExists and ReportLink.IsBuilding and (Key = VK_ESCAPE) then
    ReportLink.AbortBuilding := True
  else
    inherited;  
end;

procedure TAbstractdxReportLinkDesignWindow.AfterRebuildReport;
begin
  KeyPreview := FPrevKeyPreview;
end;

procedure TAbstractdxReportLinkDesignWindow.BeforeRebuildReport;
begin
  FPrevKeyPreview := KeyPreview;
  KeyPreview := True;
end;

procedure TAbstractdxReportLinkDesignWindow.Initialize;
begin
  LoadStrings;
  Caption := ReportLink.DesignerCaption;
  if ReportLink.IsDesigning and (Component <> nil) then
    Caption := Caption + ' : ' + Component.Name;
  if ReportLink.DesignerHelpContext <> 0 then
    HelpContext := ReportLink.DesignerHelpContext;
end;

procedure TAbstractdxReportLinkDesignWindow.LoadStrings;
begin
end;

procedure TAbstractdxReportLinkDesignWindow.UpdateControlsState;
begin
end;

function TAbstractdxReportLinkDesignWindow.GetComponent: TComponent;
begin
  if ReportLink <> nil then
    Result := ReportLink.Component
  else
    Result := nil;
end;

function TAbstractdxReportLinkDesignWindow.GetIsDesigning: Boolean;
begin
  Result := (ReportLink <> nil) and Reportlink.IsDesigning;
end;

function TAbstractdxReportLinkDesignWindow.IsCaptionStored: Boolean;
begin //TODO: TAbstractdxReportLinkDesignWindow.IsCaptionStored
  Result := Caption <> cxGetResourceString(@sdxReportDesignerCaption);
end;

procedure TAbstractdxReportLinkDesignWindow.SetModified(Value: Boolean);
begin
  FModified := Value;
  if Modified and Applyed then Applyed := False;
  UpdateControlsState;
end;

procedure TAbstractdxReportLinkDesignWindow.WMHelp(var Message: TWMHelp);
var
  Control: TWinControl;
  ContextID: Integer;
begin
  if csDesigning in ComponentState then
    inherited
  else
  begin
    ContextID := 0;
    with Message.HelpInfo^ do
      if iContextType = HELPINFO_WINDOW then
      begin
        Control := FindControl(hItemHandle);
        if Control = nil then Exit;
        Control := GetParentForm(Control);
        if Control = nil then Exit;
        ContextID := Control.HelpContext;
      end;
    if ContextID <> 0 then Application.HelpContext(ContextID);
  end;
end;

{ TStandarddxReportLinkDesignWindow }

constructor TStandarddxReportLinkDesignWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CreateStdButtons;
 {$IFDEF DELPHI7} 
  if PreviewHost <> nil then 
  begin
    if ThemeServices.ThemesEnabled then
    begin
      TCustomPanelAccess(PreviewHost).BevelInner := bvNone;
      TCustomPanelAccess(PreviewHost).BevelOuter := bvNone;
    end; 
    FPrevPreviewHostWindowProc := PreviewHost.WindowProc;
    PreviewHost.WindowProc := PreviewHostWindowProc;
  end;
 {$ENDIF} 
end;

{$IFDEF DELPHI7}
destructor TStandarddxReportLinkDesignWindow.Destroy;
begin
  if PreviewHost <> nil then 
    PreviewHost.WindowProc := FPrevPreviewHostWindowProc;
  inherited;
end;
{$ENDIF}

procedure TStandarddxReportLinkDesignWindow.PlaceStdButtons;
const
  btnWidth = 75;
  btnLargeWidth = 115;
  btnHeight = 23;
  btnFirstOffsetX: array[Boolean] of Integer = (4, 10);
  btnOffsetX = 4;
  btnOffsetY = 6;
var
  AWidth, ALargeWidth, AHeight, AOffsetX, AFirstOffsetX, AOffsetY: Integer;
begin
  AWidth := MulDiv(btnWidth, Screen.PixelsPerInch, 96);
  ALargeWidth := MulDiv(btnLargeWidth, Screen.PixelsPerInch, 96);
  AHeight := MulDiv(btnHeight, Screen.PixelsPerInch, 96);
  AFirstOffsetX := MulDiv(btnFirstOffsetX[foSizeableDialog in Options], Screen.PixelsPerInch, 96);
  AOffsetX := MulDiv(btnOffsetX, Screen.PixelsPerInch, 96);
  AOffsetY := MulDiv(btnOffsetY, Screen.PixelsPerInch, 96);
  
  if btnHelp.Visible then
  begin
    btnHelp.BoundsRect := 
      MakeBounds(ClientWidth - AFirstOffsetX - AWidth, ClientHeight - AOffsetY - AHeight, AWidth, AHeight);
    btnApply.BoundsRect := 
      MakeBounds(btnHelp.Left - AOffsetX - AWidth, ClientHeight - AOffsetY - AHeight, AWidth, AHeight);
  end    
  else
    btnApply.BoundsRect := 
      MakeBounds(ClientWidth - AFirstOffsetX - AWidth, ClientHeight - AOffsetY - AHeight, AWidth, AHeight);

  btnCancel.BoundsRect := 
    MakeBounds(btnApply.Left - AOffsetX - AWidth, ClientHeight - AOffsetY - AHeight, AWidth, AHeight);
  btnOK.BoundsRect := 
    MakeBounds(btnCancel.Left - AOffsetX - AWidth, ClientHeight - AOffsetY - AHeight, AWidth, AHeight);
  btnRestoreOriginal.BoundsRect := 
    MakeBounds(AOffsetX, ClientHeight - AOffsetY - AHeight, ALargeWidth, AHeight);
  btnRestoreDefaults.BoundsRect := 
    MakeBounds(btnRestoreOriginal.BoundsRect.Right + AOffsetX, ClientHeight - AOffsetY - AHeight, ALargeWidth, AHeight);
  btnTitleProperties.BoundsRect := 
    MakeBounds(AOffsetX, ClientHeight - AOffsetY - AHeight, ALargeWidth, AHeight);
end;

procedure TStandarddxReportLinkDesignWindow.CreateStdButtons;
begin
  btnHelp := TButton.Create(Self);
  try
    btnHelp.Name := sdxHelpButtonName;
  except
  end;
  btnHelp.Parent := Self;

  btnApply := TButton.Create(Self);
  btnApply.Parent := Self;
  btnApply.TabOrder := btnHelp.TabOrder - 1;
  btnApply.OnClick := ApplyClick;

  btnCancel := TButton.Create(Self);
  btnCancel.Parent := Self;
  btnCancel.Cancel := True;
  btnCancel.ModalResult := mrCancel;
  btnCancel.TabOrder := btnApply.TabOrder - 1;

  btnOK := TButton.Create(Self);
  btnOK.Parent := Self;
  btnOK.Default := True;
  btnOK.ModalResult := mrOK;
  btnOK.TabOrder := btnCancel.TabOrder - 1;

  btnRestoreOriginal := TButton.Create(Self);
  btnRestoreOriginal.Parent := Self;
  btnRestoreOriginal.TabOrder := btnOK.TabOrder - 1;
  btnRestoreOriginal.OnClick := RestoreOriginalClick;

  btnRestoreDefaults := TButton.Create(Self);
  btnRestoreDefaults.Parent := Self;
  btnRestoreDefaults.TabOrder := btnRestoreOriginal.TabOrder - 1;
  btnRestoreDefaults.OnClick := RestoreDefaultsClick;

  btnTitleProperties := TButton.Create(Self);
  btnTitleProperties.Parent := Self;
  btnTitleProperties.OnClick := TitlePropertiesClick;
end;

procedure TStandarddxReportLinkDesignWindow.RestoreOriginalClick(Sender: TObject);
begin 
  BeginUpdateControls;
  try
    if ReportLink <> nil then ReportLink.RestoreFromOriginal;
    DoInitialize;
  finally
    EndUpdateControls;
  end;
  Modified := True;
end;

procedure TStandarddxReportLinkDesignWindow.RestoreDefaultsClick(Sender: TObject);
begin
  BeginUpdateControls;
  try
    if ReportLink <> nil then ReportLink.RestoreDefaults;
    DoInitialize;
  finally
    EndUpdateControls;
  end;
  Modified := True;
end;

procedure TStandarddxReportLinkDesignWindow.TitlePropertiesClick(Sender: TObject);
begin
  if (ReportLink <> nil) and ReportLink.ShowTitlePropertiesDlg then 
  begin
    if not ReportLink.AbortBuilding then
    begin
      AtLeastOneTimeApplied := True;
      Applyed := True;
    end;  
    UpdateControlsState;  
  end;
end;

procedure TStandarddxReportLinkDesignWindow.ApplyClick(Sender: TObject);
begin
  DoApply;
end;

procedure TStandarddxReportLinkDesignWindow.RegroupStdButtons;
var
  StartTabOrder: Integer;
begin
  Resize;
  if HelpContext = 0 then
  begin
    btnOK.BoundsRect := btnCancel.BoundsRect;
    btnCancel.BoundsRect := btnApply.BoundsRect;
    btnApply.BoundsRect := btnHelp.BoundsRect;
    btnHelp.Visible := False;
  end
  else
    BorderIcons := BorderIcons + [biHelp];
    
  btnRestoreOriginal.Visible := ReportLink.IsDesigning;
  btnRestoreDefaults.Visible := ReportLink.IsDesigning;
  if btnTitleProperties.Visible then
    btnTitleProperties.Visible := ReportLink.CanChangeTitle and not ReportLink.IsDesigning;
  if ReportLink.IsDesigning then
  begin
    btnRestoreOriginal.TabOrder := 0;
    btnRestoreDefaults.TabOrder := 1;
  end
  else
    if ReportLink.CanChangeTitle then 
      btnTitleProperties.TabOrder := 0;
      
  StartTabOrder := 1 + Byte(ReportLink.IsDesigning);
  btnOk.TabOrder := StartTabOrder;
  btnCancel.TabOrder := StartTabOrder + 1;
  btnApply.TabOrder := StartTabOrder + 2;
  btnHelp.TabOrder := StartTabOrder + 3;
end;

procedure TStandarddxReportLinkDesignWindow.Resize;
begin
  PlaceStdButtons;
  inherited;
end;  

function TStandarddxReportLinkDesignWindow.CanApply: Boolean;
begin
  Result := (ReportLink <> nil) and ReportLink.DataProviderPresent and 
    ReportLink.PreviewExists and Modified and not Applyed and not ReportLink.IsAggregated;
end;

procedure TStandarddxReportLinkDesignWindow.DoApply;
begin
  try
    ReportLink.DoApplyInDesigner;
  except
    Application.HandleException(Self);
    ModalResult := mrCancel;
    raise;
  end;
  if not ReportLink.AbortBuilding then
  begin
    AtLeastOneTimeApplied := True;
    Applyed := True;
  end;
  UpdateControlsState;
end;

procedure TStandarddxReportLinkDesignWindow.Initialize;
begin
  BeginUpdateControls;
  try
    inherited;
    RegroupStdButtons;
    DoInitialize;
  finally
    UpdateControlsState;
    EndUpdateControls;
  end;
end;

procedure TStandarddxReportLinkDesignWindow.LoadStrings;
begin
  inherited;
  btnOK.Caption := cxGetResourceString(@sdxBtnOK);
  btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  btnApply.Caption := cxGetResourceString(@sdxBtnApply);
  btnHelp.Caption := cxGetResourceString(@sdxBtnHelp);
  btnRestoreDefaults.Caption := cxGetResourceString(@sdxBtnRestoreDefaults);
  btnRestoreOriginal.Caption := cxGetResourceString(@sdxBtnRestoreOriginal);
  btnTitleProperties.Caption := cxGetResourceString(@sdxBtnTitleProperties);
end;

procedure TStandarddxReportLinkDesignWindow.UpdateControlsState;
begin
  if btnTitleProperties <> nil then
    btnTitleProperties.Enabled := not ReportLink.IsAggregated;
  if btnApply <> nil then 
    btnApply.Enabled := CanApply;
  if btnRestoreOriginal <> nil then 
    btnRestoreOriginal.Enabled := (ReportLink <> nil) and ReportLink.DataProviderPresent;
end;

procedure TStandarddxReportLinkDesignWindow.DoInitialize;
begin
end;

{$IFDEF DELPHI7}

function TStandarddxReportLinkDesignWindow.GetPreviewHost: TCustomPanel;
begin
  Result := nil;
end;

procedure TStandarddxReportLinkDesignWindow.PreviewHostWindowProc(var Message: TMessage);
var
  Control: TWinControl;
  R: TRect;
  Details: TThemedElementDetails;
  DC: HDC;
  PS: TPaintStruct;
begin
  if ThemeServices.ThemesEnabled and (Message.Msg = WM_PAINT) then
  begin
    Control := PreviewHost;
    DC := BeginPaint(Control.Handle, PS);
    try
      R := Control.ClientRect;
      Details := ThemeServices.GetElementDetails(ttBody); 
      ThemeServices.DrawElement(DC, Details, Control.Parent.ClientRect);

      Details := ThemeServices.GetElementDetails(teEditTextNormal);
      ThemeServices.DrawEdge(DC, Details, R, BDR_SUNKENOUTER, BF_RECT or BF_FLAT);              
      InflateRect(R, -1, -1);
      ThemeServices.DrawEdge(DC, Details, R, BDR_RAISEDINNER, BF_RECT or BF_FLAT);
    finally
      EndPaint(Control.Handle, PS);
    end;  
  end
  else
    FPrevPreviewHostWindowProc(Message);      
end;

{$ENDIF}

procedure TStandarddxReportLinkDesignWindow.PaintPreview(ACanvas: TCanvas; R: TRect);
{$IFDEF DELPHI7}
var
  Details: TThemedElementDetails;
{$ENDIF}
begin
 {$IFDEF DELPHI7}
  if (PreviewHost <> nil) and ThemeServices.ThemesEnabled then
  begin
    Details := ThemeServices.GetElementDetails(ttBody); 
    ThemeServices.DrawElement(ACanvas.Handle, Details, PreviewHost.Parent.ClientRect);
    Exit;
  end;
 {$ENDIF} 
  ACanvas.Brush.Color := clWindow;
  ACanvas.FillRect(R);
end;

procedure TStandarddxReportLinkDesignWindow.UpdatePreview;
begin
end;

procedure TStandarddxReportLinkDesignWindow.BeginUpdateControls;
begin
  Inc(FUpdateControlsCount);
end;

procedure TStandarddxReportLinkDesignWindow.EndUpdateControls;
begin
  if FUpdateControlsCount > 0 then
  begin
    Dec(FUpdateControlsCount);
    if FUpdateControlsCount = 0 then UpdatePreview;
  end;
end;

function TStandarddxReportLinkDesignWindow.LockControlsUpdate: Boolean;
begin
  Result := FUpdateControlsCount <> 0;
end;

procedure TStandarddxReportLinkDesignWindow.SetAtLeastOneTimeApplied(Value: Boolean);
begin
  if FAtLeastOneTimeApplied <> Value then
  begin
    FAtLeastOneTimeApplied := Value;
    if FAtLeastOneTimeApplied then
      btnCancel.Caption := cxGetResourceString(@sdxBtnClose)
    else
      btnCancel.Caption := cxGetResourceString(@sdxBtnCancel);
  end;
end;

{ TdxPSPrintStyle }

constructor TdxPSPrintStyle.Create(AOwner: TComponent);
begin
  inherited;
  AddStdHFFunctions;
end;

function TdxPSPrintStyle.DefaultPageFooterText(APart: TdxPageTitlePart): string;
const
  CRLF = #13#10;
var
  Index: Integer;
begin
  Index := -1;
  if dxHFFunctionLibrary <> nil then
    case APart of
      tpCenter:
        Index := dxHFFunctionLibrary.IndexOfByClass(TdxHFPageNumberFunction);
      tpRight:
        Index := dxHFFunctionLibrary.IndexOfByClass(TdxHFDateFunction);
    end;

  if Index <> -1 then
    Result := dxHFFunctionLibrary[Index].TemplateString + CRLF
  else
    Result := inherited DefaultPageFooterText(APart);
end;

function TdxPSPrintStyle.DefaultStyleCaption: string;
begin
  Result := cxGetResourceString(@sdxStandardStyle);
end;

procedure TdxPSPrintStyle.AddStdHFFunctions;
var
  Index: Integer;
begin
  if dxHFFunctionLibrary = nil then Exit;
  with PrinterPage.PageFooter do
  begin
    Index := dxHFFunctionLibrary.IndexOfByClass(TdxHFPageNumberFunction);
    if Index <> -1 then
      CenterTitle.Text := dxHFFunctionLibrary[Index].TemplateString;
    Index := dxHFFunctionLibrary.IndexOfByClass(TdxHFDateFunction);
    if Index <> -1 then
      RightTitle.Text := dxHFFunctionLibrary[Index].TemplateString;
  end;
end;

procedure TdxPSPrintStyle.AfterGenerating;
begin
  DoAfterGenerating;
end;

procedure TdxPSPrintStyle.BeforeGenerating;
begin
  DoBeforeGenerating;
end;

procedure TdxPSPrintStyle.DoAfterGenerating;
begin
  if Assigned(FOnAfterGenerating) then FOnAfterGenerating(Self);
end;

procedure TdxPSPrintStyle.DoAfterPrinting;
begin
  if Assigned(FOnAfterPrinting) then FOnAfterPrinting(Self);
end;

procedure TdxPSPrintStyle.DoBeforeGenerating;
begin
  if Assigned(FOnBeforeGenerating) then FOnBeforeGenerating(Self);
end;

procedure TdxPSPrintStyle.DoBeforePrinting;
begin
  if Assigned(FOnBeforePrinting) then FOnBeforePrinting(Self);
end;

procedure TdxPSPrintStyle.InitializeDefaultStyleGlyph(ABitmap: TBitmap);
begin
  inherited;
  Bitmap_LoadFromResourceName(ABitmap, IDB_DXPSPRINTSTYLE_STANDARD);
end;

{ TBasedxPreviewWindow }

destructor TBasedxPreviewWindow.Destroy;
begin
  if ComponentPrinter <> nil then
  begin
    Exclude(ComponentPrinter.FState, cpsPreviewing);
    if not ComponentPrinter.FModalPreview then
      ComponentPrinter.DoAfterPreview(ReportLink);
    ComponentPrinter.FPreviewWindow := nil;
  end;
  inherited;
end;

procedure TBasedxPreviewWindow.InitContent;
begin
end;

procedure TBasedxPreviewWindow.InvalidateContent;
begin
end;

procedure TBasedxPreviewWindow.InvalidatePage(APageIndex: Integer);
begin
end;

procedure TBasedxPreviewWindow.InvalidateAllPages;
begin
end;

procedure TBasedxPreviewWindow.InvalidatePagesContent;
begin
end;

procedure TBasedxPreviewWindow.InvalidatePagesHeaderContent;
begin
end;

procedure TBasedxPreviewWindow.InvalidatePagesFooterContent;
begin
end;

procedure TBasedxPreviewWindow.CreationComplete;
begin
end;

procedure TBasedxPreviewWindow.RebuildReport;
begin
  if ReportLink <> nil then ReportLink.RebuildReport;
end;

procedure TBasedxPreviewWindow.UpdateCaption;
begin
  if ComponentPrinter <> nil then
    Caption := ComponentPrinter.PreviewCaption;
end;

procedure TBasedxPreviewWindow.UpdateControls;
begin
  UpdateCaption;
  UpdateExplorerContextCommands;
  if (ComponentPrinter <> nil) and (ComponentPrinter.PreviewWindowDesigner <> nil) then
    ComponentPrinter.PreviewWindowDesigner.Modified;
end;

{$IFNDEF DELPHI6}

{ IUnknown }

function TBasedxPreviewWindow.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then                      
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TBasedxPreviewWindow._Addref: Integer;
begin
  Result := -1;
end;

function TBasedxPreviewWindow._Release: Integer;
begin
  Result := -1;
end;

{$ENDIF}    

{$IFDEF OLEDRAGANDDROP}

const
  DropEffects: array[Boolean] of Longint = (DROPEFFECT_NONE, DROPEFFECT_COPY);

function TBasedxPreviewWindow.IDropTarget_DragEnter(const DataObj: IDataObject; 
  grfKeyState: Longint; Pt: TPoint; var dwEffect: Longint): HRESULT;
var
  Format: TFormatETC;
  Medium: TSTGMedium;
  BufferSize: DWORD;
  Buffer:  PChar ;
begin
  FillChar(Format, SizeOf(Format), 0);
  with Format do 
  begin
    cfFormat := CF_HDROP;
    dwAspect := DVASPECT_CONTENT;
    lindex := -1;
    tymed := TYMED_HGLOBAL; 
  end;
  DataObj._AddRef;
  try
    FDraggedFileName := '';
    if (DataObj.GetData(Format, Medium) = S_OK) and (DragQueryFile(Medium.hGlobal, $FFFFFFFF, nil, 0) <> 0) then
    try
      BufferSize := DragQueryFile(Medium.hGlobal, 0, nil, 0);
      Buffer := StrAlloc(BufferSize + 1);
      try
        if BufferSize = DragQueryFile(Medium.hGlobal, 0, Buffer, BufferSize) then
          FDraggedFileName := StrPas(Buffer);
      finally
       StrDispose(Buffer);
      end;
    finally
      if Medium.unkForRelease = nil then ReleaseSTGMedium(Medium);
    end;
  finally
    DataObj._Release;
  end;
  
  dwEffect := DropEffects[CanDrop and DoCanAccept];
  if dwEffect = DROPEFFECT_NONE then FDraggedFileName := '';
    
  Result := S_OK;
end;
  
function TBasedxPreviewWindow.IDropTarget_DragOver(grfKeyState: Longint; Pt: TPoint; 
  var dwEffect: Longint): HRESULT;
begin
  dwEffect := DropEffects[CanDrop];
  Result := S_OK;
end;

function TBasedxPreviewWindow.IDropTarget_DragLeave: HRESULT;
begin
  Result := S_OK;
end;

function TBasedxPreviewWindow.IDropTarget_Drop(const DataObj: IDataObject; 
  grfKeyState: Longint; Pt: TPoint; var dwEffect: Longint): HRESULT;
begin
  dwEffect := DropEffects[CanDrop];
  if dwEffect = DROPEFFECT_COPY then DoDrop;
  Result := S_OK;
end;

{$ENDIF}

procedure TBasedxPreviewWindow.AddExplorerContextCommand(ACommand: TCustomdxPSExplorerContextCommand);
begin
end;

procedure TBasedxPreviewWindow.UpdateExplorerContextCommands;
begin
end;

function TBasedxPreviewWindow.GetExplorerTree: TCustomdxPSExplorerTreeContainer;
begin
  Result := nil;
end;

function TBasedxPreviewWindow.GetHFEditPart: TdxPageTitlePart;
begin
  Result := tpLeft;
end;

function TBasedxPreviewWindow.GetShowExplorer: Boolean;
begin
  Result := False;
end;

function TBasedxPreviewWindow.GetShowThumbnails: Boolean;
begin
  Result := False;
end;

function TBasedxPreviewWindow.GetState: TdxPSPreviewState;
begin
  Result := prsNone;
end;

procedure TBasedxPreviewWindow.SetShowExplorer(Value: Boolean);
begin
end;

procedure TBasedxPreviewWindow.SetShowThumbnails(Value: Boolean);
begin
end;

procedure TBasedxPreviewWindow.BeginUpdate;
begin
end;

procedure TBasedxPreviewWindow.CancelUpdate;
begin
end;

procedure TBasedxPreviewWindow.EndUpdate;
begin
end;

function TBasedxPreviewWindow.Locked: Boolean;
begin
  Result := False;
end;

procedure TBasedxPreviewWindow.PaintPage(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; APageIndex: Integer);
begin  
  ComponentPrinter.PaintPage(ACanvas, APageIndex, ARect, ARect, nil);
end;

procedure TBasedxPreviewWindow.PaintThumbnailPage(Sender: TObject; ACanvas: TCanvas; 
  ARect: TRect; APageIndex: Integer);
begin  
  ComponentPrinter.PaintThumbnailPage(ACanvas, APageIndex, ARect, ARect, nil);
end;

{$IFDEF OLEDRAGANDDROP}

function TBasedxPreviewWindow.CanDrop: Boolean;
begin
  Result := DraggedFileName <> '';
end;

function TBasedxPreviewWindow.DoCanAccept: Boolean;
begin
  Result := (ReportLink <> nil) and ReportLink.CanLoadData and 
    ReportLink.PossibleDataStorage(DraggedFileName, False);
end;

procedure TBasedxPreviewWindow.DoDrop;
begin
  if ReportLink <> nil then
  begin
    ReportLink.DataSource := rldsExternalStorage;
    ReportLink.StorageName := DraggedFileName;
    RebuildReport;
    UpdateControls;
    Application.BringToFront;
  end;  
end;

{$ENDIF}

function TBasedxPreviewWindow.GetReportLink: TBasedxReportLink;
begin
  if ComponentPrinter <> nil then
    Result := ComponentPrinter.CurrentLink
  else
    Result := nil;
end;

{ TdxComponentPrinterThumbnailsOptions }

constructor TdxComponentPrinterThumbnailsOptions.Create(APreviewOptions: TdxPreviewOptions);
begin
  inherited Create;
  FPreviewOptions := APreviewOptions;
  FFont := TFont.Create;
  RestoreDefaults;
end;

destructor TdxComponentPrinterThumbnailsOptions.Destroy;
begin
  FreeAndNil(FDefaultFont);
  FreeAndNil(FFont);
  inherited;
end;

procedure TdxComponentPrinterThumbnailsOptions.Assign(Source: TPersistent);
begin
  if Source is TdxComponentPrinterThumbnailsOptions then
    with TdxComponentPrinterThumbnailsOptions(Source) do 
    begin
      Self.Font := Font;
      Self.ShowPageNumbers := ShowPageNumbers;
    end
  else
    inherited;
end;

function TdxComponentPrinterThumbnailsOptions.DefaultFont: TFont;
begin
  if FDefaultFont = nil then
  begin
    FDefaultFont := TFont.Create;
    InitializeDefaultFont(FDefaultFont);
  end;
  Result := FDefaultFont;
end;

procedure TdxComponentPrinterThumbnailsOptions.RestoreDefaults;
begin
  inherited;
  Font := DefaultFont;
  ShowPageNumbers := True;
end;

procedure TdxComponentPrinterThumbnailsOptions.InitializeDefaultFont(AFont: TFont);
begin
  AFont.Color := dxPSDefaultPreviewThumbnailsFontColor;
  AFont.Name := dxPSDefaultPreviewThumbnailsFontName;
  AFont.Size := dxPSDefaultPreviewThumbnailsFontSize;
  AFont.Style := dxPSDefaultPreviewThumbnailsFontStyle
end;

function TdxComponentPrinterThumbnailsOptions.IsFontStored: Boolean;
begin
  Result := not dxPSUtl.dxAreFontsEqual(Font, DefaultFont);
end;

procedure TdxComponentPrinterThumbnailsOptions.SetFont(Value: TFont);
begin
  Font.Assign(Value);
end;

procedure TdxComponentPrinterThumbnailsOptions.SetShowPageNumbers(Value: Boolean);
begin
  if FShowPageNumbers <> Value then
  begin
    FShowPageNumbers := Value;
    //TODO: TdxComponentPrinterThumbnailsOptions.SetShowPageNumbers
    // if HasPreviewThumbnails then invalidate Preview.Thumbnails
  end;
end;

{ TdxPreviewOptions }

constructor TdxPreviewOptions.Create;
begin
  inherited;
  FEnableOptions := dxDefaultPreviewEnableOptions;
  FIcon := TIcon.Create;
  FIcon.OnChange := IconChanged;
  FSavePosition := True;
  FSaveZoomPosition := True;
  FThumbnailsOptions := TdxComponentPrinterThumbnailsOptions.Create(Self);
  FWindowState := wsNormal;
  FVisibleOptions := dxDefaultPreviewVisibleOptions;
end;
                              
destructor TdxPreviewOptions.Destroy;
begin
  FreeAndNil(FDefaultIcon);
  FreeAndNil(FThumbnailsOptions);
  FreeAndNil(FIcon);
  inherited;
end;

function TdxPreviewOptions.DefaultCaption: string;
begin
  Result := cxGetResourceString(@sdxPrintPreview);
end;

function TdxPreviewOptions.DefaultIcon: TIcon;
begin
  if FDefaultIcon = nil then
  begin
    FDefaultIcon := TIcon.Create;
    InitializeDefaultIcon(FDefaultIcon);
  end;
  Result := FDefaultIcon;
end;

function TdxPreviewOptions.DefaultRect: TRect;
begin
  Result := dxPSUtl.GetDesktopWorkArea;
end;

procedure TdxPreviewOptions.RestoreOriginalIcon;
begin
  //FIcon.Handle := 0;
  FIsIconAssigned := False;
  if ComponentPrinter <> nil then ComponentPrinter.DesignerModified;
end;

procedure TdxPreviewOptions.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  Rect := MakeBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TdxPreviewOptions.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('PreviewBoundsRect', ReadBoundsRect, WriteBoundsRect, 
    IsBoundsStored);
  Filer.DefineProperty('IsCaptionAssigned', ReadIsCaptionAssigned, WriteIsCaptionAssigned,
    FIsCaptionAssigned and (Caption = ''));
  Filer.DefineProperty('IsIconAssigned', ReadIsIconAssigned, WriteIsIconAssigned,
    FIsIconAssigned and Icon.Empty); 
end;

procedure TdxPreviewOptions.DoAssign(Source: TdxBaseObject);
begin
  inherited;
  with TdxPreviewOptions(Source) do 
  begin
    Self.Caption := Caption;
    Self.EnableOptions := EnableOptions;
    Self.HelpContext := HelpContext;
    Self.HelpFile := HelpFile;
    Self.Icon := Icon;
    Self.Rect := Rect;
    Self.SavePosition := SavePosition;
    Self.SaveZoomPosition := SaveZoomPosition;
    Self.ThumbnailsOptions := ThumbnailsOptions;
    Self.WindowState := WindowState;
    Self.VisibleOptions := VisibleOptions;

    Self.FIsBoundsAssigned := FIsBoundsAssigned;
    Self.FIsCaptionAssigned := FIsCaptionAssigned;
    Self.FIsIconAssigned := FIsIconAssigned;
  end;  
end;

procedure TdxPreviewOptions.DoRestoreDefaults;
begin
  inherited;
  FEnableOptions := dxDefaultPreviewEnableOptions;

  FSavePosition := True;
  FSaveZoomPosition := True;
  ThumbnailsOptions.RestoreDefaults;
  FWindowState := wsNormal;
  FVisibleOptions := dxDefaultPreviewVisibleOptions;

  FIsBoundsAssigned := False;
  FIsCaptionAssigned := False;
  FIsIconAssigned := False;
end;

function TdxPreviewOptions.GetIsIconAssigned: Boolean;
begin
  Result := not dxPSUtl.dxAreGraphicsEqual(FIcon, DefaultIcon);
end;

procedure TdxPreviewOptions.IconChanged(Sender: TObject);
begin
  FIsIconAssigned := True;
end;

procedure TdxPreviewOptions.InitializeDefaultIcon(AnIcon: TIcon);
begin
  Icon_LoadFromResourcename(AnIcon, IDB_DXPSPREVIEW);
end;

procedure TdxPreviewOptions.RefreshIsIconAssigned;
begin
 // FIsIconAssigned := dxPSUtl.dxAreGraphicsEqual(FIcon, DefaultIcon);
end;

function TdxPreviewOptions.GetCaption: string;
begin
  if FIsCaptionAssigned then
    Result := FCaption
  else
    Result := DefaultCaption;
end;

function TdxPreviewOptions.GetHelpFile: string;
begin
  Result := dxPSEngine.HelpFile;
end;

function TdxPreviewOptions.GetIcon: TIcon;
begin
  if FIsIconAssigned or ((ComponentPrinter <> nil) and (csLoading in ComponentPrinter.ComponentState)) then
    Result := FIcon
  else
    Result := DefaultIcon;
end;
                            
function TdxPreviewOptions.GetPosition(Index: Integer): Integer;
begin
  with Rect do 
    case Index of
      0: Result := Bottom - Top;
      1: Result := Left;
      2: Result := Top;
    else
      Result := Right - Left;
    end;
end;

function TdxPreviewOptions.GetRect: TRect;
begin
  if FIsBoundsAssigned then
    Result := FRect
  else
    Result := DefaultRect;
end;

function TdxPreviewOptions.GetRegistryPath: string;
begin
  Result := dxPSEngine.RealRegistryPath;
end;

function TdxPreviewOptions.IsBoundsStored: Boolean;
begin
  Result := FIsBoundsAssigned and not EqualRect(FRect, DefaultRect);
end;

function TdxPreviewOptions.IsCaptionStored: Boolean;
begin
  Result := FIsCaptionAssigned and (FCaption <> DefaultCaption);
end;

function TdxPreviewOptions.IsIconStored: Boolean;
begin
  Result := FIsIconAssigned and not dxPSUtl.dxAreGraphicsEqual(FIcon, DefaultIcon);
end;
                
procedure TdxPreviewOptions.SetEnableOptions(Value: TdxPreviewEnableOptions);
begin
  if FEnableOptions <> Value then
  begin
    FEnableOptions := Value;
    if HasPreviewWindow then
      PreviewWindow.SetPreviewEnableOptions(FEnableOptions);
  end;
end;

procedure TdxPreviewOptions.SetCaption(const Value: string);
begin
  if Caption <> Value then
  begin
    FCaption := Value;
    FIsCaptionAssigned := True;
    if HasPreviewWindow then PreviewWindow.Caption := Caption;
  end;    
end;

procedure TdxPreviewOptions.SetHelpContext(Value: THelpContext);
begin
  FHelpContext := Value;
  if HasPreviewWindow then PreviewWindow.HelpContext := FHelpContext;
end;

procedure TdxPreviewOptions.SetHelpFile(const Value: string);
begin
  dxPSEngine.HelpFile := Value;
  if HasPreviewWindow then PreviewWindow.HelpFile := Value;
end;

procedure TdxPreviewOptions.SetIcon(Value: TIcon);
begin
  FIcon.Assign(Value);
end;

procedure TdxPreviewOptions.SetPosition(Index: Integer; Value: Integer);
var
  R: TRect;
begin
  R := Self.Rect;
  case Index of
    0: R.Bottom := R.Top + Value;
    1: R.Left := Value;
    2: R.Top := Value;
    3: R.Right := R.Left + Value;
  end;
  Self.Rect := R;
end;
          
procedure TdxPreviewOptions.SetRect(Value: TRect);
begin
  with Value do
  begin
    if Right < Left then Right := Left;
    if Bottom < Top then Bottom := Top;
  end;
  
  if not EqualRect(FRect, Value) then
  begin
    FRect := Value;
    FIsBoundsAssigned := True;
  end;
end;

procedure TdxPreviewOptions.SetRegistryPath(const Value: string);
begin
  dxPSEngine.RegistryPath := Value;
end;

procedure TdxPreviewOptions.SetShowExplorer(Value: Boolean);
begin
  if FShowExplorer <> Value then 
  begin
    FShowExplorer := Value;
    if HasPreviewWindow then PreviewWindow.ShowExplorer := ShowExplorer;
  end;
end;

procedure TdxPreviewOptions.SetThumbnailsOptions(Value: TdxComponentPrinterThumbnailsOptions);
begin
  ThumbnailsOptions.Assign(Value);
end;

procedure TdxPreviewOptions.SetWindowState(Value: TWindowState);
begin
  FWindowState := Value;
  if HasPreviewWindow then PreviewWindow.WindowState := FWindowState;
end;

procedure TdxPreviewOptions.SetVisibleOptions(Value: TdxPreviewVisibleOptions);
begin
  if FVisibleOptions <> Value then
  begin
    FVisibleOptions := Value;
    if HasPreviewWindow then
      PreviewWindow.SetPreviewVisibleOptions(FVisibleOptions);
  end;
end;

function TdxPreviewOptions.HasPreviewWindow: Boolean;
begin
  Result := (ComponentPrinter <> nil) and not ComponentPrinter.IsDesigning and
    ComponentPrinter.PreviewExists;
end;

function TdxPreviewOptions.PreviewWindow: TBasedxPreviewWindow;
begin
  Result := ComponentPrinter.PreviewWindow;
end;

procedure TdxPreviewOptions.ReadBoundsRect(Stream: TStream);
var 
  R: TRect;
begin
  Stream.ReadBuffer(R, SizeOf(R));
  Rect := R;
end;

procedure TdxPreviewOptions.ReadIsCaptionAssigned(Reader: TReader);
begin
  FIsCaptionAssigned := Reader.ReadBoolean;
end;

procedure TdxPreviewOptions.ReadIsIconAssigned(Reader: TReader);
begin
  FIsIconAssigned := Reader.ReadBoolean;
end;

procedure TdxPreviewOptions.WriteBoundsRect(Stream: TStream);
begin
  Stream.WriteBuffer(FRect, SizeOf(TRect));
end;

procedure TdxPreviewOptions.WriteIsCaptionAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsCaptionAssigned);
end;

procedure TdxPreviewOptions.WriteIsIconAssigned(Writer: TWriter);
begin
  Writer.WriteBoolean(FIsIconAssigned);
end;

{ TdxPSComponentPrinterExplorerChangeNotifier }

constructor TdxPSComponentPrinterExplorerChangeNotifier.Create(AComponentPrinter: TCustomdxComponentPrinter);
begin
  Assert(AComponentPrinter <> nil);
  FComponentPrinter := AComponentPrinter;
  inherited Create(nil);
end;

procedure TdxPSComponentPrinterExplorerChangeNotifier.ItemDataUnloaded(AnItem: TdxPSExplorerItem);
begin
  if (AnItem.Explorer = Explorer) and (ComponentPrinter.CurrentLink <> nil) and not ComponentPrinter.IsDestroying then
  begin
    ComponentPrinter.CurrentLink.DataSource := rldsComponent;
    ComponentPrinter.CurrentLink.FinalizeDataStream;
  end;  
end;

{ TCustomdxComponentPrinter }

constructor TCustomdxComponentPrinter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner <> nil then AOwner.FreeNotification(Self);
  FAutoUpdateDateTime := True;
  FBeepAfterLongOperations := True;
  FCurrentLink := nil;
  FDateFormat := 0;
  FExplorerChangeNotifier := TdxPSComponentPrinterExplorerChangeNotifier.Create(Self);
  FInternalStreaming := False;
  FLongOperationTime := 5000;
  FPageNumberFormat := pnfNumeral;
  FReportLinkDesigner := nil;
  FPreviewWindowDesigner := nil;
  FPrintTitle := '';
  FState := [];
  FPreviewOptions := TdxPreviewOptions.Create;
  FPreviewOptions.FComponentPrinter := Self;
  FPrintFileList := TStringList.Create;
  FOptions := dxDefaultCPOptions;
  FReportLinks := TList.Create;
  FSaveCopies := 1;
  FSaveCollate := False;
  FTimeFormat := 0;
  FHFTextEntryChooseSubscriber := TdxHFTextEntryChooseSubscriber.Create([TdxHFTextEntryChooseEvent]);
  TdxHFTextEntryChooseSubscriber(FHFTextEntryChooseSubscriber).OnHFTextEntryChoose := OnHFTextEntryChosen;
  FWindowHandle := dxPSUtl.dxAllocatehWnd(WndProc);
  FVersion := 0;
end;

destructor TCustomdxComponentPrinter.Destroy;
begin
 {$IFNDEF DELPHI5}
  Destroying;
 {$ENDIF}
  dxPSUtl.dxDeallocatehWnd(FWindowHandle);
  FreeAndNil(FHFTextEntryChooseSubscriber);
  FreeAndNil(FPrintFileList);
  FreeAndNil(FPreviewWindowDesigner);
  FreeAndNil(FReportLinkDesigner);
  if not IsDesigning then DestroyPreviewWindow;
  FreeAndNil(FPreviewOptions);
  FreeAndNil(FExplorerChangeNotifier);                                 
  DeleteAllLinks;
  FreeAndNil(FReportLinks);
  inherited;
end;

procedure TCustomdxComponentPrinter.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
  ReportLink: TBasedxReportLink;
begin
  if not FInternalStreaming then 
    for I := 0 to LinkCount - 1 do
    begin
      ReportLink := Self.ReportLink[I];
      if Root = ReportLink.Owner then Proc(ReportLink);
    end;
end;

procedure TCustomdxComponentPrinter.Loaded;
begin
  inherited;
  PreviewOptions.RefreshIsIconAssigned;
end;

procedure TCustomdxComponentPrinter.Notification(AComponent: TComponent; Operation: TOperation); 
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = Explorer then Explorer := nil;
    if AComponent = ExplorerStubLink then ExplorerStubLink := nil;
  end;  
end;
  
procedure TCustomdxComponentPrinter.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if FReportLinks.IndexOf(Child) > -1 then
    (Child as TBasedxReportLink).Index := Order;
end;

procedure TCustomdxComponentPrinter.SetName(const NewName: TComponentName);
var
  AName: string;
  OldName: string;
  P, I: Integer;
  Link: TBasedxReportLink;
begin
  OldName := Name;
  inherited SetName(NewName);
  if IsDesigning and (LinkCount > 0) then
  try
    if ReportLinkDesigner <> nil then
      ReportLinkDesigner.BeginUpdate;
    try
      for I := 0 to LinkCount - 1 do
      begin
        Link := ReportLink[I];
        P := Pos(OldName, Link.Name);
        if P = 0 then
          AName := Name + Link.Name
        else
          AName := Copy(Link.Name, 1, P - 1) + Name +
            Copy(Link.Name, P + Length(OldName), Length(Link.Name) - P - Length(OldName) + 1);
        Link.Name := AName;
      end;
    finally
      if ReportLinkDesigner <> nil then
        ReportLinkDesigner.EndUpdate;
    end;
  except
    on EComponentError do ; {Ignore rename errors }
  end;
end;

procedure TCustomdxComponentPrinter.SetExplorer(Value: TCustomdxPSExplorer);
begin
  if FExplorer <> Value then 
  begin
    FExplorer := Value;
    if Explorer <> nil then
      Explorer.FreeNotification(Self);
    ExplorerChangeNotifier.Explorer := Explorer;
  end;  
end;

procedure TCustomdxComponentPrinter.SetExplorerStubLink(Value: TBasedxReportLink);
begin
  if FExplorerStubLink <> Value then
    if (Value = nil) or Value.CanBeUsedAsStub then
    begin
      FExplorerStubLink := Value;
      if Value <> nil then
        Value.FreeNotification(Self);
    end;  
end;

procedure TCustomdxComponentPrinter.SetLongOperationTime(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FLongOperationTime <> Value then 
    FLongOperationTime := Value;
end;

procedure TCustomdxComponentPrinter.SetPreviewOptions(Value: TdxPreviewOptions);
begin
  PreviewOptions.Assign(Value);
end;

function TCustomdxComponentPrinter.IsCustomPrintDlgData: Boolean;
begin
  Result := Assigned(FOnInitializePrintDlgData);
end;

function TCustomdxComponentPrinter.IsForegroundPreviewWindow: Boolean;
begin
  Result := (cpsPreviewing in State) and (PreviewWindow <> nil) and 
    (GetForegroundWindow = PreviewWindow.Handle);
end;

function TCustomdxComponentPrinter.IsGenerateReportProgressEvent: Boolean;
begin
  Result := not IsDesigning and not IsLoading and (cpoGenerateReportProgressEvent in Options);
end;

function TCustomdxComponentPrinter.IsRebuildBeforeOutput(AForceRebuild: Boolean): Boolean;
begin
  Result := AForceRebuild or IsDesigning;
  if CurrentLink <> nil then
    Result := Result or CurrentLink.RebuildNeeded or (CurrentLink.DataSource = rldsExternalStorage);
end;

function TCustomdxComponentPrinter.IsRebuildBeforePreview: Boolean;
begin
  Result := IsRebuildBeforeOutput(cpoAutoRebuildBeforePreview in Options);
end;

function TCustomdxComponentPrinter.IsRebuildBeforePrint: Boolean;
begin
  Result := IsRebuildBeforeOutput(cpoAutoRebuildBeforePrint in Options);
end;

function TCustomdxComponentPrinter.IsShowHourGlass: Boolean;
begin
  Result := cpoShowHourGlass in Options;
end;

procedure TCustomdxComponentPrinter.PaintThumbnailPage(ACanvas: TCanvas;
  APageIndex: Integer; const APageBounds, AContentBounds: TRect;
  AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;

  AReportLink.PaintPage(ACanvas, APageBounds, APageIndex, APageIndex,
    dxThumbnailsZoomFactors[PreviewWindow.ThumbnailsSize]);

  if PreviewOptions.ThumbnailsOptions.ShowPageNumbers then
    PaintThumbnailPageIndex(ACanvas, APageBounds, AReportLink.Renderer.PreparedPageIndex(APageIndex));
end;

procedure TCustomdxComponentPrinter.PaintThumbnailPageIndex(ACanvas: TCanvas;
  const R: TRect; APageIndex: Integer);
var
  FontSize: Integer;
begin
  with PreviewOptions.ThumbnailsOptions do
  begin
    FontSize := Font.Size;
    if PreviewWindow.ThumbnailsSize = tsSmall then 
      Font.Size := Font.Size div 2; 
    dxPSUtl.DrawBlendedText(ACanvas, R, IntToStr(APageIndex + 1), Font);
    Font.Size := FontSize;
  end;  
end;  

function TCustomdxComponentPrinter.GetCurrentLinkIndex: Integer;
begin
  if CurrentLink <> nil then
    Result := CurrentLink.Index
  else
    Result := -1;
end;

function TCustomdxComponentPrinter.GetExplorerRealStubLink: TBasedxReportLink;
begin
  Result := FExplorerStubLink;
  if Result = nil then
    Result := AddEmptyLink(TBasedxReportLink);
end;

function TCustomdxComponentPrinter.GetIsExplorerMode: Boolean;
begin
  Result := cpsExplore in State;
end;

function TCustomdxComponentPrinter.GetLinkCount: Integer;
begin
  Result := FReportLinks.Count;
end;

function TCustomdxComponentPrinter.GetPreviewCaption: string;
begin
  if cpsExplore in State then
    Result := cxGetResourceString(@sdxReportExplorer)
  else
    Result := PreviewOptions.Caption;

  if (Explorer <> nil) and (Explorer.LoadedItem <> nil) then
    Result := Result + ' ' + sdxDocumentCaptionSeparator + ' ' + Explorer.LoadedItem.FormCaption
  else
    if (CurrentLink <> nil) and (CurrentLink.DataSource = rldsExternalStorage) and (CurrentLink.StorageName <> '') then 
      Result := Result + ' ' + sdxDocumentCaptionSeparator + ' ' + CurrentLink.StorageName;
end;

function TCustomdxComponentPrinter.GetReportLink(Index: Integer): TBasedxReportLink;
begin
  Result := TBasedxReportLink(FReportLinks[Index]);
end;

procedure TCustomdxComponentPrinter.SetAbortBuilding(Value: Boolean);
begin
  FAbortBuilding := Value;
end;

procedure TCustomdxComponentPrinter.SetAbortPrinting(Value: Boolean);
begin
  FAbortPrinting := Value;
end;

procedure TCustomdxComponentPrinter.SetAutoUpdateDateTime(Value: Boolean);
begin
  if FAutoUpdateDateTime <> Value then
    FAutoUpdateDateTime := Value;
end;

procedure TCustomdxComponentPrinter.SetDateFormat(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > dxPgsDlg.DateFormats.Count - 1 then
    Value := dxPgsDlg.DateFormats.Count - 1;
  if FDateFormat <> Value then
    FDateFormat := Value;
end;

procedure TCustomdxComponentPrinter.SetCurrentLink(Value: TBasedxReportLink);
begin
  if (CurrentLink <> Value) and (IndexOfLink(Value) > -1) then
  begin
    if PreviewExists then DestroyPreviewWindow;
    FCurrentLink := Value;
    DoChangeCurrentLink;
    FormatChanged(FCurrentLink);
    if FCurrentLink <> nil then
      FCurrentLink.PrinterPage.ApplyToPrintDevice; 
    DesignerUpdate(Value);//nil);
  end;
end;

procedure TCustomdxComponentPrinter.SetCurrentLinkIndex(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > LinkCount - 1 then 
    Value := LinkCount - 1;
  if Value > -1 then 
    CurrentLink := ReportLink[Value];
end;

procedure TCustomdxComponentPrinter.SetPageNumberFormat(Value: TdxPageNumberFormat);
begin
  if FPageNumberFormat <> Value then
    FPageNumberFormat := Value;
end;

procedure TCustomdxComponentPrinter.SetPrintFileList(Value: TStrings);
begin
  FPrintFileList.Assign(Value);
end;

procedure TCustomdxComponentPrinter.SetReportLink(Index: Integer; Value: TBasedxReportLink);
begin
  ReportLink[Index].Assign(Value);
end;

procedure TCustomdxComponentPrinter.SetTimeFormat(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if Value > dxPgsDlg.TimeFormats.Count - 1 then
    Value := dxPgsDlg.TimeFormats.Count - 1;
  if FTimeFormat <> Value then
    FTimeFormat := Value;
end;

function TCustomdxComponentPrinter.BeginPrintPages(const Source: string;
  out APageIndexes: TIntegers): Boolean;
begin
  Result := MakePageIndexes(Source, APageIndexes);
end;

procedure TCustomdxComponentPrinter.EndPrintPages(var APageIndexes: TIntegers);
begin
  SetLength(APageIndexes, 0);
end;

function TCustomdxComponentPrinter.CreatePreviewWindow(AReportLink: TBasedxReportLink): TBasedxPreviewWindow;
var
  PreviewClass: TdxPreviewWindowClass;
begin
  Result := nil;
  PreviewClass := GetPreviewClass;
  if PreviewClass <> nil then
  try
    Result := PreviewClass.Create(nil);
    Result.BeginUpdate;
    try
      Result.SetComponentPrinter(Self);
      SetupPreviewProperties(Result);
      Result.CreationComplete;
    finally
      Result.EndUpdate;
    end;
  except
    FreeAndNil(Result);
    raise;
  end
  else
    raise EdxComponentPrinter.Create(cxGetResourceString(@sdxPreviewNotRegistered));
end;

procedure TCustomdxComponentPrinter.DestroyPreviewWindow;
begin
  if cpsPrinting in State then
    AbortPrinting := True;
  FreeAndNil(FPreviewWindow);
end;

procedure TCustomdxComponentPrinter.FinalizeDefaultPrintDlgData(AReportLink: TBasedxReportLink;
  var APrintDlgData: TdxPrintDlgData);
begin
  FreeAndNil(APrintDlgData.DialogData.FileList);
  DoFinalizePrintDlgData(AReportLink, APrintDlgData);
end;

procedure TCustomdxComponentPrinter.InitializeDefaultPrintDlgData(AReportLink: TBasedxReportLink;
  out APrintDlgData: TdxPrintDlgData);
const
  BtnEnabledOn: TdxPrintDlgButtons = [pdbPreview, pdbPageSetup, pdbHelp];
  BtnVisibleOn: TdxPrintDlgButtons = [pdbPreview, pdbPageSetup, pdbHelp];
  OptEnabledOn: TdxPrintDlgOptions = [pdoCurrentPage];
  OptVisibleOn: TdxPrintDlgOptions = [pdoCurrentPage];
begin
  FillChar(APrintDlgData, SizeOf(TdxPrintDlgData), 0);
  with APrintDlgData do
  begin
    DialogData.Collate := False;
    DialogData.Copies := 1;
    DialogData.FileList := TStringList.Create;
    DialogData.FileList.Assign(PrintFileList);
    DialogData.MaxRange := CurrentLink.PageCount; // (v2.2)
    if DialogData.MaxRange = 0 then DialogData.MaxRange := -1;
    DialogData.MinRange := 1;
    if CurrentLink.PageCount = 0 then DialogData.MinRange := 0;               
    DialogData.PageCount := CurrentLink.PageCount;
    DialogData.PageNums := pnAll;
    DialogData.PageRanges := prAll;
    if DialogData.PageCount > 0 then {v3.2}
      DialogData.Pages := '1-' + IntToStr(DialogData.PageCount);
    DialogData.PrintToFile := FSavePrintToFile;
    if not IsDesigning and (not (cpsPreviewing in State) or (pvoPrintStyles in PreviewOptions.VisibleOptions)) then
      DialogData.StyleManager := CurrentLink.StyleManager;
    DialogData.PageCount := CurrentLink.PageCount;  

    Title := cxGetResourceString(@sdxPrintDialogCaption);

    OptionsEnabled := pdoDefaultOptionsEnabled + OptEnabledOn;
    OptionsVisible := pdoDefaultOptionsVisible + OptVisibleOn;
    ButtonsEnabled := pdbDefault + BtnEnabledOn;
    ButtonsVisible := pdbDefault + BtnVisibleOn;
    if cpsPreviewing in State then
      ButtonsVisible := ButtonsVisible - [pdbPreview];
      
    Events.OnPageSetup := PrnDlgPageSetup;
    IsCheckUserInput := True;  
  end;
  DoInitializePrintDlgData(AReportLink, APrintDlgData);
end;

procedure TCustomdxComponentPrinter.InitDevModeFromPrinterPageSettings(
  APrinterPage: TdxPrinterPage);
begin
  if (dxPrintDevice = nil) or (dxPrintDevice.DeviceMode = nil) then Exit;
  dxPrintDevice.DeviceMode^.dmOrientation := Byte(APrinterPage.Orientation) + 1;
  dxPrintDevice.DeviceMode^.dmColor := Byte(not APrinterPage.GrayShading) + 1;
end;

function TCustomdxComponentPrinter.PrintDialog(AReportLink: TBasedxReportLink;
  var APrintDlgData: TdxPrintDlgData): Boolean;
var
  PreviewBtnClicked: Boolean;
begin
  Include(FState, cpsPrintDialog);
  try
    Result := dxPrnDlg.dxPrintDialog(APrintDlgData);
    PreviewBtnClicked := APrintDlgData.PreviewBtnClicked;
    if Result then
    begin
      FSavePrintToFile := APrintDlgData.DialogData.PrintToFile;
      PrintFileList := APrintDlgData.DialogData.FileList;
      if AReportLink <> nil then
        AReportLink.PrinterPage.InitFromPrintDevice;
      if not PreviewBtnClicked then
        with APrintDlgData.DialogData do
        begin
          if PrintToFile then
            dxPrintDevice.FileName := FileName
          else
            dxPrintDevice.FileName := ''; 
          FPrintAll := PageRanges = prAll;
          if PageRanges in [prCurrent, prRange] then
          begin
            if PageRanges = prCurrent then 
              Pages := IntToStr(AReportLink.CurrentPage);
            Result := PrintPagesAsStringEx(Pages, PageNums, Copies, Collate, AReportLink);
          end
          else // prAll
            PrintEx(PageNums, Copies, Collate, AReportLink);
        end;
    end;
  finally
    FPrintAll := False;
    Exclude(FState, cpsPrintDialog);
  end;

  if PreviewBtnClicked then Preview(True, AReportLink);
end;

function TCustomdxComponentPrinter.PrintPagesAsStringEx(const APages: string;
  APageNums: TdxPageNumbers; ACopyCount: Integer; ACollate: Boolean;
  AReportLink: TBasedxReportLink = nil): Boolean;
var
  PageIndexes: TIntegers;
begin
  if BeginPrintPages(APages, PageIndexes) then
    try
      PrintPagesEx(PageIndexes, APageNums, ACopyCount, ACollate, AReportLink);
      Result := True;
    finally
      EndPrintPages(PageIndexes);
    end
  else
    Result := False;
end;

procedure TCustomdxComponentPrinter.PrnDlgPageSetup(Sender: TObject;
  var ADone: Boolean; APreviewBtnClicked, APrintBtnClicked: PBoolean);
var
  ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked: Boolean;
begin
  ShowPreviewBtn := APreviewBtnClicked <> nil; 
  ShowPrintBtn := APrintBtnClicked <> nil;
  ADone := (CurrentLink <> nil) and
    PageSetupEx(0, ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked, CurrentLink);
  if (ADone or PreviewBtnClicked) and PreviewExists then
  begin
    CurrentLink.CalculateRenderInfos;
    with PreviewWindow do
    begin
      InitContent;
      InvalidateContent;
      UpdateControls;
    end;
  end;
    
  if ShowPreviewBtn then 
    APreviewBtnClicked^ := PreviewBtnClicked;

  if ShowPrintBtn then 
    APrintBtnClicked^ := PrintBtnClicked;
end;

procedure TCustomdxComponentPrinter.RaiseBuildingEvent(AReportLink: TBasedxReportLink;
  const APercentCompleted: Double; AStage: TdxPSBuildStage);
var
  Event: TdxEvent;
begin
  if CurrentCompositionByLink(AReportLink) <> nil then Exit;
  Event := TdxPSBuildEvent.Create(Self, AReportLink, APercentCompleted, AStage);
  dxPSProcessEvent(Event)
end;

procedure TCustomdxComponentPrinter.RaisePrintingEvent(AReportLink: TBasedxReportLink;
  APageIndex, APageCount: Integer; AStage: TdxPSPrintStage);
var
  Event: TdxEvent;
begin
  Event := TdxPSPrintEvent.Create(Self, AReportLink, APageIndex, APageCount, AStage);
  dxPSProcessEvent(Event);
end;

procedure TCustomdxComponentPrinter.ActivateLink(AReportLink: TBasedxReportLink);

  function IsCompositionActivatation(AComposition: TdxCompositionReportLink): Boolean;
  begin
    Result := (AComposition <> nil) and not (csRebuildReportLink in AComposition.CompositionState);
  end;
  
var
  Composition: TdxCompositionReportLink;
begin
  Composition := CurrentCompositionByLink(AReportLink);
  if (AReportLink is TdxCompositionReportLink) or (Composition = nil) or IsCompositionActivatation(Composition) then 
  begin
    PrepareBuildReport(AReportLink);
    PrepareLongOperation;
    if AReportLink.CurrentPrintStyle is TdxPSPrintStyle then 
      TdxPSPrintStyle(AReportLink.CurrentPrintStyle).BeforeGenerating;
  end;  
  try
    if IsCompositionActivatation(Composition) then 
      Composition.ActivateLink(AReportLink)
    else  
      AReportLink.InternalActivate;
        
    if AutoUpdateDateTime then
      if IsCompositionActivatation(Composition) and (Composition.DataSource = rldsComponent) then
        Composition.DateTime := Now
      else
        if AReportLink.DataSource = rldsComponent then
          AReportLink.DateTime := Now;
  finally
    if (AReportLink is TdxCompositionReportLink) or (Composition = nil) or IsCompositionActivatation(Composition) then
    begin
      if AReportLink.CurrentPrintStyle is TdxPSPrintStyle then 
        TdxPSPrintStyle(AReportLink.CurrentPrintStyle).AfterGenerating;
      UnprepareLongOperation;
      UnprepareBuildReport(AReportLink);
    end;  
  end;
end;

function TCustomdxComponentPrinter.CheckLink(Value: TBasedxReportLink): TBasedxReportLink;
begin
  if Value <> nil then CurrentLink := Value;
  Result := CurrentLink;
end;

function TCustomdxComponentPrinter.CreateLink(ALinkClass: TdxReportLinkClass;
  AComponent: TComponent; AOwner: TComponent): TBasedxReportLink;
var
  LinkClass: TdxReportLinkClass;
begin
  Result := nil;
  LinkClass := ALinkClass;
  if AComponent <> nil then
    if IsSupportedCompClass(AComponent) then
      LinkClass := dxPSLinkClassByCompClass(TComponentClass(AComponent.ClassType))
    else
      if IsDesigning then
        raise EdxComponentPrinter.Create(cxGetResourceString(@sdxComponentNotSupported));
  if LinkClass = nil then Exit;
  Result := LinkClass.Create(AOwner);
  if AComponent <> nil then
    Result.Component := AComponent;
  Result.SetComponentPrinter(Self);
  DoAddReportLink(Result);
  DesignerModified;
end;

procedure TCustomdxComponentPrinter.DeactivateLink(AReportLink: TBasedxReportLink);
begin
  AReportLink.DoDestroyReport;    
end;

procedure TCustomdxComponentPrinter.InsertLink(Value: TBasedxReportLink);
begin
  FReportLinks.Add(Value);
  Value.FComponentPrinter := Self;
  if LinkCount = 1 then Value.IsCurrentLink := True;
end;

procedure TCustomdxComponentPrinter.MoveLink(ACurIndex, ANewIndex: Integer);
begin
  FReportLinks.Move(ACurIndex, ANewIndex);
  DesignerUpdate(nil);
end;

procedure TCustomdxComponentPrinter.RemoveLink(Value: TBasedxReportLink);
var
  Index: Integer;
begin
  if not IsDestroying and (FCurrentLink = Value) then
  begin
    if PreviewExists then DestroyPreviewWindow;
    Index := Value.Index;
  end
  else
    Index := -1;
  FReportLinks.Remove(Value);
  Value.FComponentPrinter := nil;
  if Index <> -1 then 
    ResyncCurrentLink(Index);
  DoDeleteReportLink(Value);
end;

procedure TCustomdxComponentPrinter.ResyncCurrentLink(AIndex: Integer);
begin
  if AIndex > LinkCount - 1 then
    AIndex := LinkCount - 1;
  if AIndex < 0 then
  begin
    FCurrentLink := nil;
    DoChangeCurrentLink;
  end
  else
    CurrentLink := ReportLink[AIndex];
end;

procedure TCustomdxComponentPrinter.OnHFTextEntryChosen(Sender: TObject; const AEntry: string);
var
  PagePart: TCustomdxPageObject;
  Part1, Part2, Part3: string;
begin
  if (CurrentLink <> nil) and (TdxPrintStyleManager(Sender) = CurrentLink.StyleManager) then 
  begin
    if PreviewExists then 
      case PreviewWindow.State of 
        prsEditHeaders: 
          PagePart := CurrentLink.RealPrinterPage.PageHeader;
        prsEditFooters:
          PagePart := CurrentLink.RealPrinterPage.PageFooter;
      else //prsNone
        Exit;
      end
    else
      PagePart := CurrentLink.RealPrinterPage.PageHeader;
      
    if PagePart <> nil then 
    begin
      dxPSSplitAutoHFTextEntry(AEntry, Part1, Part2, Part3);
      if (Part2 = '') and (Part3 = '') then 
        PagePart.Titles[PreviewWindow.HFEditPart].Add(Part1)
      else  
        with PagePart do 
        begin
          if Part1 <> '' then LeftTitle.Add(Part1);
          if Part2 <> '' then CenterTitle.Add(Part2);
          if Part3 <> '' then RightTitle.Add(Part3);
        end;
      
      if PreviewExists then 
        case PreviewWindow.State of 
          prsEditHeaders:
            PreviewWindow.InvalidatePagesHeaderContent;
          prsEditFooters:
            PreviewWindow.InvalidatePagesFooterContent;
        end;    
    end;
  end;
end;

procedure TCustomdxComponentPrinter.DesignerModified;
begin
  if ReportLinkDesigner <> nil then ReportLinkDesigner.Modified;
end;

procedure TCustomdxComponentPrinter.DesignerUpdate(AnItem: TBasedxReportLink);
begin
  if ReportLinkDesigner <> nil then ReportLinkDesigner.Update(AnItem);
end;

function TCustomdxComponentPrinter.IsDesigning: Boolean;
begin
  Result := csDesigning in ComponentState;
end;

function TCustomdxComponentPrinter.IsDestroying: Boolean;
begin
  Result := csDestroying in ComponentState;
end;

function TCustomdxComponentPrinter.IsLoading: Boolean;
begin
  Result := csLoading in ComponentState;
end;

procedure TCustomdxComponentPrinter.ShowExistingPreviewWindow;
const
  Flags: array[Boolean] of UINT = (SW_SHOW, SW_RESTORE or SW_SHOWNORMAL);
var
  WindowPlacement: TWindowPlacement;
  Wnd: THandle;
begin
  WindowPlacement.Length := SizeOf(WindowPlacement);
  Wnd := PreviewWindow.Handle;
  GetWindowPlacement(Wnd, @WindowPlacement);
  ShowWindow(Wnd, Flags[WindowPlacement.ShowCmd = SW_SHOWMINIMIZED]);
  SetForegroundWindow(Wnd);
end;

procedure TCustomdxComponentPrinter.WndProc(var Message: TMessage);
var
  I: Integer;
begin
  with Message do
  begin
    case Msg of
      WM_SETTINGCHANGE:
//        if (PChar(message.lParam) = 'devices') then
        begin
          RereadDefaultPrinterPage;
          for I := 0 to LinkCount - 1 do
            TdxReportLinkPrinterPage(ReportLink[I].PrinterPage).SynchronizeMeasurementUnits;
          DesignerModified;
        end;
    end;
    Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
  end;
end;
             
procedure TCustomdxComponentPrinter.FormatChanged(AReportLink: TBasedxReportLink);
begin
  dxHFFormatObject.DateFormat := dxPgsDlg.DateFormats[AReportLink.DateFormat];
  dxHFFormatObject.DateTime := AReportLink.DateTime;
  dxHFFormatObject.PageNumberFormat := AReportLink.PageNumberFormat;
  dxHFFormatObject.StartPageIndex := AReportLink.StartPageIndex;
  dxHFFormatObject.TimeFormat := dxPgsDlg.TimeFormats[AReportLink.TimeFormat];
end;

procedure TCustomdxComponentPrinter.AssignReportLinks(Source: TCustomdxComponentPrinter);
var
  SaveOwner: TComponent;
  I: Integer;
  Link: TBasedxReportLink;
begin
  if LinkCount > 0 then
    SaveOwner := ReportLink[0].Owner
  else
    SaveOwner := Owner;
  DeleteAllLinks;
  if Source <> nil then
    for I := 0 to Source.LinkCount - 1 do
    begin
      Link := Source.ReportLink[I];
      with AddEmptyLinkEx(Link.LinkClass, SaveOwner) do
      begin
        Component := Link.Component;
        Assign(Link);
      end;
    end;
end;

function TCustomdxComponentPrinter.CreateLinkFromFile(const AFileName: string): TBasedxReportLink;
var
  Stream: TFileStream;
begin
  try
    Stream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyWrite);
    try
      Result := CreateLinkFromStream(Stream);
    finally
      Stream.Free;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TCustomdxComponentPrinter.CreateLinkFromStream(AStream: TStream): TBasedxReportLink;
var
  StorageInfo: TdxPSDataStorageInfo;
begin
  try
    StorageInfo := TBasedxReportLink.ExtractStorageInfo(AStream, False);
    if StorageInfo.StorageVersion = dxPSStorageVersion then
      if StorageInfo.LinkClass <> nil then
      begin
        Result := StorageInfo.LinkClass.Create(Self.Owner);
        Result.InternalLoadDataFromStream(AStream);
      end
      else
        raise EdxReportLink.CreateFmt(cxGetResourceString(@sdxLinkIsNotIncludedInUsesClause), [StorageInfo.LinkClassName])
    else
      raise EdxInvalidStorageVersion.Create(StorageInfo.StorageVersion);
  except                                        
    FreeAndNil(Result);
    raise;
  end;  
end;

function TCustomdxComponentPrinter.AddComposition: TdxCompositionReportLink;
begin
  Result := AddEmptyLinkEx(TdxCompositionReportLink, Self.Owner) as TdxCompositionReportLink;
end;

function TCustomdxComponentPrinter.AddEmptyLink(ALinkClass: TdxReportLinkClass): TBasedxReportLink;
begin
  Result := AddEmptyLinkEx(ALinkClass, Self.Owner);
end;

function TCustomdxComponentPrinter.AddEmptyLinkEx(ALinkClass: TdxReportLinkClass;
  AOwner: TComponent): TBasedxReportLink;
begin
  Result := CreateLink(ALinkClass, nil, AOwner);
end;

function TCustomdxComponentPrinter.AddLink(AComponent: TComponent): TBasedxReportLink;
begin
  Result := AddLinkEx(AComponent, Self.Owner);
end;

function TCustomdxComponentPrinter.AddLinkEx(AComponent: TComponent;
  AOwner: TComponent): TBasedxReportLink;
begin
  Result := CreateLink(nil, AComponent, AOwner);
end;

procedure TCustomdxComponentPrinter.DeleteAllLinks;
begin
  while LinkCount > 0 do DeleteLink(LinkCount - 1);
end;

procedure TCustomdxComponentPrinter.DeleteLink(AIndex: Integer);
var
  Link: TBasedxReportLink;
begin
  if (AIndex > -1) and (AIndex < LinkCount) then
  begin
    Link := ReportLink[AIndex];
    Link.Free;
  end;
end;

procedure TCustomdxComponentPrinter.DestroyReport(AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then AReportLink.DestroyReport;
end;

function TCustomdxComponentPrinter.FindLinkByComponent(Value: TComponent;
  ACanCreate: Boolean = False): TBasedxReportLink;
var
  I: Integer;
begin
  if Value <> nil then
    for I := 0 to LinkCount - 1 do
    begin
      Result := ReportLink[I];
      if Result.Component = Value then Exit;
    end;

  if ACanCreate then
    Result := AddLink(Value)
  else
    Result := nil;
end;

procedure TCustomdxComponentPrinter.GetLinks(AList: TList);
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
    AList.Add(ReportLink[I]);
end;  

function TCustomdxComponentPrinter.IndexOfLink(AReportLink: TBasedxReportLink): Integer;
begin
  Result := FReportLinks.IndexOf(AReportLink);
end;

function TCustomdxComponentPrinter.IndexOfLink(const AName: string): Integer;
begin
  Result := IndexOfLinkByName(AName);
end;

function TCustomdxComponentPrinter.IndexOfLinkByName(const AName: string): Integer;
begin
  Result := IndexOfLink(LinkByName(AName));
end;

function TCustomdxComponentPrinter.LinkByName(const AName: string): TBasedxReportLink;
var
  I: Integer;
begin
  for I := 0 to LinkCount - 1 do
  begin
    Result := ReportLink[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

procedure TCustomdxComponentPrinter.RebuildReport(AReportLink: TBasedxReportLink = nil);
begin
  if AReportLink = nil then AReportLink := CurrentLink;
  if AReportLink <> nil then AReportLink.RebuildReport;
end;

function TCustomdxComponentPrinter.CurrentCompositionByLink(AReportLink: TBasedxReportLink): TdxCompositionReportLink;
var
  I: Integer;
  Link: TBasedxReportLink;
begin
  for I := 0 to LinkCount - 1 do 
  begin
    Link := ReportLink[I];
    if (Link is TdxCompositionReportLink) and 
      TdxCompositionReportLink(Link).IsCurrentLink and
      TdxCompositionReportLink(Link).Items.LinkExists(AReportLink) then 
    begin
      Result := TdxCompositionReportLink(Link);
      Exit;
    end;
  end;
  Result := nil;
end;

procedure TCustomdxComponentPrinter.GetCompositionsByLink(AReportLink: TBasedxReportLink; 
  ACompositions: TList);
var 
  I: Integer;  
  Link: TBasedxReportLink;
begin
  for I := 0 to LinkCount - 1 do 
  begin
    Link := ReportLink[I];
    if (Link is TdxCompositionReportLink) and 
      TdxCompositionReportLink(Link).Items.LinkExists(AReportLink) then
      ACompositions.Add(Link);
  end;
end;

procedure TCustomdxComponentPrinter.GetItems(AComposition: TdxCompositionReportLink; 
  AStrings: TStrings; AExcludeAssigned: Boolean);
var
  I: Integer;  
  Item: TBasedxReportLink;
begin
  if AComposition.ComponentPrinter = Self then
  begin
    AStrings.BeginUpdate;
    try
      for I := 0 to LinkCount - 1 do 
      begin
        Item := ReportLink[I];
        if not (Item is TdxCompositionReportLink) and 
          (not AExcludeAssigned or not IsLinkInComposition(Item, AComposition)) then 
          AStrings.AddObject(Item.Caption, Item);
      end;  
    finally
      AStrings.EndUpdate;
    end;
  end;  
end;  

function TCustomdxComponentPrinter.IsLinkInComposition(AReportLink: TBasedxReportLink; 
  AComposition: TdxCompositionReportLink): Boolean;
var
  List: TList;  
begin
  List := TList.Create;
  try
    GetCompositionsByLink(AReportLink, List);
    Result := List.IndexOf(AComposition) <> -1;
  finally
    List.Free;
  end;
end;

function TCustomdxComponentPrinter.IsLinkInCurrentComposition(AReportLink: TBasedxReportLink): Boolean;
begin
  Result := (CurrentLink is TdxCompositionReportLink) and
    IsLinkInComposition(AReportLink, TdxCompositionReportLink(CurrentLink));
end;
  
class function TCustomdxComponentPrinter.GetNewLinkName(AReportLink: TBasedxReportLink): string;
begin
  Result := sdxNewLinkNameTemplate;
end;
  
class function TCustomdxComponentPrinter.IsSupportedCompClass(AComponentClass: TClass): Boolean;
begin
  Result := dxPSIsSupportedCompClass(AComponentClass);
end;

class function TCustomdxComponentPrinter.IsSupportedCompClass(AComponent: TObject{TComponent}): Boolean;
begin
  Result := dxPSIsSupportedCompClass(AComponent);
end;

procedure TCustomdxComponentPrinter.PreparePageSetup;
begin
  Include(FState, cpsPageSetupDialog);
end;
                                              
procedure TCustomdxComponentPrinter.UnpreparePageSetup;
begin
  Exclude(FState, cpsPageSetupDialog);
end;

procedure TCustomdxComponentPrinter.PrepareBuildReport(AReportLink: TBasedxReportLink);
begin
  Include(FState, cpsBuilding);
  DoStartUpdateReport(AReportLink);
end;

procedure TCustomdxComponentPrinter.UnprepareBuildReport(AReportLink: TBasedxReportLink);
begin
  Exclude(FState, cpsBuilding);  
  DoEndUpdateReport(AReportLink);
  if PreviewExists then
    with PreviewWindow do 
      if PageCount <> AReportLink.PageCount then
      begin
        PageCount := AReportLink.PageCount;
        ActivePageIndex := FSavePageIndex;
        if (PageCount <> 0) and (ActivePageIndex = -1) then 
          ActivePageIndex := 0;
      end
      else
        InvalidateContent;
end;

procedure TCustomdxComponentPrinter.PrepareLongOperation;
begin
  if IsDestroying then Exit;
  if FLongOperationCounter = 0 then
  begin
    FStartTime := GetTickCount;
    if IsShowHourGlass then dxPSStartWait;
  end;
  Inc(FLongOperationCounter);
end;

procedure TCustomdxComponentPrinter.UnprepareLongOperation;
begin
  if IsDestroying then Exit;
  if FLongOperationCounter <> 0 then
  begin
    Dec(FLongOperationCounter);
    if FLongOperationCounter = 0 then
    begin
      if IsShowHourGlass then 
        dxPSStopWait;
      if BeepAfterLongOperations then
      begin
        FEndTime := GetTickCount;
        if FEndTime - FStartTime > DWORD(LongOperationTime) then Beep;
      end;
    end;
  end;
end;

procedure TCustomdxComponentPrinter.LoadFromFile(const AName: string);
var
  Stream: TFileStream;
begin
  if (AName <> '') and FileExists(AName) then
  begin
    Stream := TFileStream.Create(AName, fmOpenRead or fmShareDenyWrite);
    try
      LoadFromStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TCustomdxComponentPrinter.LoadFromStream(AStream: TStream);
var
  Version: Integer;
begin
  LoadVersionFromStream(AStream, Version);
  if Version <> Self.Version then Exit;
  
  PrepareLoadFromStream(AStream);
  try
    BeforeLoadFromStream(AStream);
    try
      try
        LoadLinksFromStream(AStream);
        LoadItselfFromStream(AStream);
      except
        ErrorLoadFromStream(AStream);
      end;  
    finally
      AfterLoadFromStream(AStream);
    end;
  finally
    UnprepareLoadFromStream(AStream);
  end;  
end;

procedure TCustomdxComponentPrinter.AfterLoadFromStream(AStream: TStream);
begin
  FMemoryStream.Free;
end;

procedure TCustomdxComponentPrinter.SaveToFile(const AName: string);
var
  Stream: TFileStream;
begin
  if ValidateFileName(AName) then
  begin
    Stream := TFileStream.Create(AName, fmCreate);
    try
      SaveToStream(Stream);
    finally
      Stream.Free;
    end;
  end;
end;

procedure TCustomdxComponentPrinter.SaveToStream(AStream: TStream);
begin
  PrepareSaveToStream(AStream);
  try
    SaveVersionToStream(AStream);
    SaveLinksToStream(AStream);
    SaveItselfToStream(AStream);
  finally
    UnprepareSaveToStream(AStream);
  end;
end;

procedure TCustomdxComponentPrinter.DoCustomDrawEntirePage(AReportLink: TBasedxReportLink;
  ACanvas: TCanvas; APageIndex: Integer; ARect: TRect; ANom, ADenom: Integer);
begin
  if Assigned(FOnCustomDrawPage) then
    FOnCustomDrawPage(Self, AReportLink, ACanvas, APageIndex, ARect, ANom, ADenom);
end;

procedure TCustomdxComponentPrinter.DoNewPage(AReportLink: TBasedxReportLink;
  APageIndex: Integer);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    if Assigned(FOnNewPage) then FOnNewPage(Self, AReportLink, APageIndex);
    RaisePrintingEvent(AReportLink, APageIndex, 0, psProgress);
  end;
end;

procedure TCustomdxComponentPrinter.DoEndPrint(AReportLink: TBasedxReportLink);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    if Assigned(FOnEndPrint) then FOnEndPrint(Self, AReportLink);
    RaisePrintingEvent(AReportLink, 0, 0, psEnd);
  end;
  AbortPrinting := False;
end;

procedure TCustomdxComponentPrinter.DoStartPrint(AReportLink: TBasedxReportLink;
  FullPageCount: Integer);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    if Assigned(FOnStartPrint) then FOnStartPrint(Self, AReportLink, FullPageCount);
    RaisePrintingEvent(AReportLink, 0, FullPageCount, psStart);
  end;
end;

procedure TCustomdxComponentPrinter.DoAddReportLink(AReportLink: TBasedxReportLink);
begin
  if not IsLoading and not FInternalStreaming then
    if Assigned(FOnAddReportLink) then FOnAddReportLink(Self, AReportLink);
end;

procedure TCustomdxComponentPrinter.DoAfterPreview(AReportLink: TBasedxReportLink);
begin
  if cpoDropStorageModeAfterPreview in Options then 
    AReportLink.DataSource := rldsComponent;
  if Assigned(FOnAfterPreview) then FOnAfterPreview(Self, AReportLink);
end;

procedure TCustomdxComponentPrinter.DoBeforeDesignReport(AReportLink: TBasedxReportLink);
begin
  if Assigned(FOnBeforeDesignReport) then 
    FOnBeforeDesignReport(Self, AReportLink, AReportLink.DesignWindow);
end;

procedure TCustomdxComponentPrinter.DoBeforeDestroyReport(AReportLink: TBasedxReportLink);
begin    
  if PreviewExists then 
  begin
    FSavePageIndex := PreviewWindow.ActivePageIndex;
    PreviewWindow.PageCount := 0;
  end
  else
    FSavePageIndex := -1;  
end;

procedure TCustomdxComponentPrinter.DoBeforePreview(AReportLink: TBasedxReportLink);
begin
  if (PreviewWindow <> nil) and Assigned(FOnBeforePreview) then 
    FOnBeforePreview(Self, AReportLink);
end;

procedure TCustomdxComponentPrinter.DoChangeComponent(AReportLink: TBasedxReportLink);
begin
  if not IsLoading and Assigned(FOnChangeComponent) then
    FOnChangeComponent(Self, AReportLink);
end;

procedure TCustomdxComponentPrinter.DoChangeCurrentLink;
begin
  if not IsLoading and not IsDestroying and Assigned(FOnChangeCurrentLink) then 
    FOnChangeCurrentLink(Self);
end;

procedure TCustomdxComponentPrinter.DoDeleteReportLink(AReportLink: TBasedxReportLink);
begin
  if not IsLoading then
    if Assigned(FOnDeleteReportLink) then FOnDeleteReportLink(Self, AReportLink);
end;

procedure TCustomdxComponentPrinter.DoFinalizePrintDlgData(AReportLink: TBasedxReportLink; 
  var APrintDlgData: TdxPrintDlgData);
begin
  if Assigned(FOnFinalizePrintDlgData) then 
    FOnFinalizePrintDlgData(Self, AReportLink, APrintDlgData);
end;

procedure TCustomdxComponentPrinter.DoInitializePrintDlgData(AReportLink: TBasedxReportLink; 
  var APrintDlgData: TdxPrintDlgData);
begin
  if Assigned(FOnInitializePrintDlgData) then 
    FOnInitializePrintDlgData(Self, AReportLink, APrintDlgData);
end;

procedure TCustomdxComponentPrinter.DoMeasureReportTitle(AReportLink: TBasedxReportLink;
  var AHeight: Integer);
begin
  if Assigned(FOnMeasureReportTitle) then
    FOnMeasureReportTitle(Self, AReportLink, AHeight);
end;

procedure TCustomdxComponentPrinter.DoDesignReport(AReportLink: TBasedxReportLink;
  ADone: Boolean);
begin
  if Assigned(FOnDesignReport) then 
    FOnDesignReport(Self, AReportLink, ADone);
    
  if ADone then
    with AReportLink do 
      if DesignWindow.Modified and not DesignWindow.Applyed and IsRebuildNeededAndAllowed(False) then
        RebuildReport;
end;

procedure TCustomdxComponentPrinter.DoPrintDeviceBusy;
var
  Done: Boolean;
begin
  Done := False;
  if Assigned(FOnPrintDeviceBusy) then FOnPrintDeviceBusy(Self, Done);
  if not Done then StdProcessPrintDeviceBusy;
end;

procedure TCustomdxComponentPrinter.StdProcessPrintDeviceBusy;
begin
  MessageError(cxGetResourceString(@sdxPrintDeviceIsBusy));
end;

procedure TCustomdxComponentPrinter.DoPrintDeviceError;
var
  Done: Boolean;
begin
  Done := False;
  if Assigned(FOnPrintDeviceError) then FOnPrintDeviceError(Self, Done);
  if not Done then StdProcessPrintDeviceError;
end;

procedure TCustomdxComponentPrinter.StdProcessPrintDeviceError;
begin
  MessageError(cxGetResourceString(@sdxPrintDeviceError));
end;

procedure TCustomdxComponentPrinter.DoPageParamsChanged(AReportLink: TBasedxReportLink);
begin  
  if cpsPreviewing in State then
  begin  
    PreviewWindow.InitContent;
    PreviewWindow.UpdateControls;
  end;  
end;

procedure TCustomdxComponentPrinter.DoPageSetup(AReportLink: TBasedxReportLink;
  ADone: Boolean);
begin
  if Assigned(FOnPageSetup) then FOnPageSetup(Self, AReportLink, ADone);
end;

procedure TCustomdxComponentPrinter.DoProgress(AReportLink: TBasedxReportLink;
  const PercentDone: Double);

  procedure ProcessKeyboardMessages;
  var
    Msg: TMsg;
  begin                         
    while PeekMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST, PM_NOREMOVE) do
    begin
      case Integer(GetMessage(Msg, 0, WM_KEYFIRST, WM_KEYLAST)) of
        -1: Break;
         0: begin
             PostQuitMessage(Msg.wParam);
             Break;
           end;
      end;
      DispatchMessage(Msg);
    end; 
  end;

begin
  if IsGenerateReportProgressEvent then
    if Assigned(FOnGenerateReportProgress) then FOnGenerateReportProgress(Self, AReportLink, PercentDone);
  ProcessKeyboardMessages;
  //Delay(20);
  RaiseBuildingEvent(AReportLink, PercentDone, bsProgress);
end;

procedure TCustomdxComponentPrinter.DoStartUpdateReport(AReportLink: TBasedxReportLink);
begin
  if IsGenerateReportProgressEvent then
    if Assigned(FOnStartGenerateReport) then FOnStartGenerateReport(Self, AReportLink);
  RaiseBuildingEvent(AReportLink, 0, bsStart);
end;

procedure TCustomdxComponentPrinter.DoEndUpdateReport(AReportLink: TBasedxReportLink);
begin
  if IsGenerateReportProgressEvent then
    if Assigned(FOnEndGenerateReport) then FOnEndGenerateReport(Self, AReportLink);
  RaiseBuildingEvent(AReportLink, 0, bsEnd);
end;

function TCustomdxComponentPrinter.GetPrintTitle(AReportLink: TBasedxReportLink): string;
begin
  Result := FPrintTitle;
  if Assigned(FOnGetPrintTitle) then
  begin
    AReportLink := CheckLink(AReportLink);
    if AReportLink <> nil then FOnGetPrintTitle(Self, AReportLink, Result);
  end;
end;

function TCustomdxComponentPrinter.PreviewExists: Boolean;
begin
  Result := (PreviewWindow <> nil) and (cpsPreviewing in State);
end;

procedure TCustomdxComponentPrinter.SetupPreviewProperties(APreviewWindow: TBasedxPreviewWindow);

  function GetCaption: string;
  begin
    if IsExplorerMode then
      Result := cxGetResourceString(@sdxReportExplorer)
    else
      Result := PreviewOptions.Caption;
  end;

begin
  if not IsDesigning then
  begin
  {$IFDEF DELPHI9}
    APreviewWindow.PopupMode := pmAuto;
  {$ENDIF}
    if not APreviewWindow.AreBoundsAssigned then
      APreviewWindow.BoundsRect := PreviewOptions.Rect;
    APreviewWindow.EnableOptions := PreviewOptions.EnableOptions;
    APreviewWindow.HelpContext := PreviewOptions.HelpContext;
    APreviewWindow.HelpFile := PreviewOptions.HelpFile;
    APreviewWindow.VisibleOptions := PreviewOptions.VisibleOptions;
    if not APreviewWindow.AreBoundsAssigned then
      APreviewWindow.WindowState := PreviewOptions.WindowState;
  end;
  APreviewWindow.Caption := GetCaption;
  APreviewWindow.Icon := PreviewOptions.Icon;
  APreviewWindow.SaveZoomPosition := PreviewOptions.SaveZoomPosition;
  APreviewWindow.ShowExplorer := PreviewOptions.ShowExplorer;
end;

procedure TCustomdxComponentPrinter.Preview(AModal: Boolean = True;
  AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;
  if not PreviewExists then
  begin
    if AReportLink.DataProviderPresent and (IsDesigning or IsRebuildBeforePreview) then
    begin
      AReportLink.PrinterPage.InitFromPrintDevice;
      try
        RebuildReport(AReportLink);
        if AbortBuilding then Exit;
      except
        if Explorer <> nil then 
        begin
          with Explorer do 
          begin
            if LoadedItem <> nil then
              DoItemDataLoadError(LoadedItem);
            FLoadedItem := nil; //!!!
          end;
          if not (cpsExplore in State) then Exit;
        end;  
      end;  
      DesignerModified;
    end
    else
      if AutoUpdateDateTime then AReportLink.DateTime := Now;

    if Explorer <> nil then Explorer.Refresh;
    InitDevModeFromPrinterPageSettings(AReportLink.PrinterPage);
    FPreviewWindow := CreatePreviewWindow(AReportLink);
    if IsExplorerMode and (PreviewWindow <> nil) then 
      PreviewWindow.ExplorerTree.MakeItemVisible(Explorer.LoadedItem);
    Include(FState, cpsPreviewing);
    DoBeforePreview(AReportLink);
    FModalPreview := AModal;
    if AModal then
    try                            
      FPreviewWindow.ShowModal;
    finally
      DoAfterPreview(AReportLink);
      FreeAndNil(FPreviewWindow);
    end
    else
      FPreviewWindow.Show;
  end
  else
    ShowExistingPreviewWindow;
end;
         
procedure TCustomdxComponentPrinter.PaintPage(ACanvas: TCanvas;
  APageIndex: Integer; const APageBounds, AContentBounds: TRect;
  AReportLink: TBasedxReportLink = nil);
var
  ZoomFactor: Integer;
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;

  ZoomFactor := 100;
  if (PreviewWindow <> nil) and IsDisplayDC(ACanvas.Handle) then
    ZoomFactor := PreviewWindow.ZoomFactor;

  AReportLink.PaintPage(ACanvas, APageBounds, APageIndex, APageIndex, ZoomFactor);
end;

procedure TCustomdxComponentPrinter.DoCustomDrawReportTitle(AReportLink: TBasedxReportLink;
  ACanvas: TCanvas; ARect: TRect; var ATextAlignX: TcxTextAlignX;
  var ATextAlignY: TcxTextAlignY; var AColor: TColor; AFont: TFont;
  var ADone: Boolean; APixelsNumerator: Integer = 0);
begin
  if Assigned(FOnCustomDrawReportTitle) then
  begin
    if APixelsNumerator = 0 then
      APixelsNumerator := PixelsNumerator;
    FOnCustomDrawReportTitle(Self, AReportLink, ACanvas, ARect, APixelsNumerator,
      PixelsDenominator, ATextAlignX, ATextAlignY, AColor, AFont, ADone);
  end;
end;

procedure TCustomdxComponentPrinter.DoCustomDrawPageHeaderOrFooter(
  AReportLink: TBasedxReportLink; AHFObject: TCustomdxPageObject;
  ACanvas: TCanvas; APageIndex: Integer; R: TRect;
  var ADefaultDrawText, ADefaultDrawBackground: Boolean;
  APixelsNumerator: Integer = 0);
begin
  if APixelsNumerator = 0 then
    APixelsNumerator := PixelsNumerator;
  if AHFObject is TdxPageHeader then
  begin
    if Assigned(FOnCustomDrawPageHeader) then
      FOnCustomDrawPageHeader(Self, AReportLink, ACanvas, APageIndex, R,
        APixelsNumerator, PixelsDenominator, ADefaultDrawText, ADefaultDrawBackground)
  end
  else
    if Assigned(FOnCustomDrawPageFooter) then
      FOnCustomDrawPageFooter(Self, AReportLink, ACanvas, APageIndex, R,
        APixelsNumerator, PixelsDenominator, ADefaultDrawText, ADefaultDrawBackground);
end;

procedure TCustomdxComponentPrinter.PrintPage(AReportLink: TBasedxReportLink;
  APageIndex: Integer);
var
  R: TRect;
begin
  if AbortPrinting then Exit;
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;

  with dxPrintDevice do
  begin
    R := MakeBounds(0, 0, PageWidth, PageHeight);
    InflateRect(R, PhysOffsetX, PhysOffsetY);
  end;  
  PaintPage(dxPrintDevice.Canvas, APageIndex, R, R, AReportLink);
end;

procedure TCustomdxComponentPrinter.PrintPages(const APageIndexes: array of Integer;
  AReportLink: TBasedxReportLink = nil);
begin
  PrintPagesEx(APageIndexes, pnAll, 1, False, AReportLink);
end;

procedure TCustomdxComponentPrinter.PrintPagesEx(const APageIndexes: array of Integer;
  APageNums: TdxPageNumbers; ACopyCount: Integer; ACollate: Boolean; 
  AReportLink: TBasedxReportLink = nil);

  function GetTotalPageCount: Integer;
  begin
    Result := ACopyCount * Length(APageIndexes);
    if APageNums <> pnAll then
    begin
      if (APageNums = pnOdd) and Odd(Result) then 
        Inc(Result);
      Result := Result div 2;
    end;
  end;
  
  procedure GetActualPageIndexes(out AnActualPageIndexes: TIntegers);

    function AreAllPagesInRange: Boolean;
    var
      I: Integer;
    begin
      if FPrintAll then
        Result := True
      else  
      begin
        Result := Length(APageIndexes) = AReportLink.PageCount;
        if Result then
          for I := 1 to AReportLink.PageCount do 
          begin
            Result := APageIndexes[I - 1] = I;
            if not Result then Exit;
          end;
      end;    
    end;
    
  var
    IsRecombineNeeded: Boolean; 
    ColCount, RowCount, I, J, K: Integer;
  begin
    SetLength(AnActualPageIndexes, Length(APageIndexes));
    IsRecombineNeeded := AReportLink.RealPrinterPage.PageOrder = poDownThenOver;
    if IsRecombineNeeded then
    begin
      AReportLink.GetPageColRowCount(ColCount, RowCount);
      IsRecombineNeeded := (ColCount <> 1) and (RowCount <> 1) and AreAllPagesInRange;
    end;

    if IsRecombineNeeded then
    begin
      K := 0;
      for I := 0 to ColCount - 1 do
        for J := 0 to RowCount - 1 do
        begin
          AnActualPageIndexes[K] := APageIndexes[I + J * ColCount];
          Inc(K);
        end;
    end
    else
      for I := 0 to Length(APageIndexes) - 1 do
        AnActualPageIndexes[I] := APageIndexes[I];
  end;

  function CanPrintPage(AIndex, APageIndex: Integer): Boolean;
  begin
    Result := not ((APageIndex < 0) or
      (APageIndex > AReportLink.PageCount - 1) or
      ((APageNums = pnEven) and not Odd(AIndex)) or
      ((APageNums = pnOdd) and Odd(AIndex)));
  end;

  procedure DoPrintPage(var ACurrentPage: Integer; APageIndex: Integer);
  begin
    if ACurrentPage > 0 then
    begin
      DoNewPage(AReportLink, ACurrentPage);
      dxPrintDevice.NewPage;
    end;
    if Application.Terminated then AbortPrinting := True;
    if not AbortPrinting then PrintPage(AReportLink, APageIndex);
    Inc(ACurrentPage);
  end;

var
  CurrentPage, Index, PageIndex, CopyIndex: Integer;
  ActualPageIndexes: TIntegers;
begin
  AReportLink := CheckLink(AReportLink);
  
  if (AReportLink = nil) or not AReportLink.DataProviderPresent then Exit;
  
  PrepareReport(AReportLink);
  try
    if AbortBuilding or (AReportLink.PageCount = 0) then Exit;
    
    dxInitPrintDevice(True);
    if dxPrintDevice.Printing then
    begin
      DoPrintDeviceBusy;
      Exit;
    end;

    if not AReportLink.ValidateMargins then Exit;

    if ACopyCount < 1 then ACopyCount := 1;
    GetActualPageIndexes(ActualPageIndexes);

    AReportLink.BeforePrinting;
    try
      try
        Include(FState, cpsPrinting);
        try
          PreparePrintDevice;
          try
            dxPrintDevice.Title := GetPrintTitle(AReportLink);
            if dxPrintDevice.BeginDoc > 0 then
            try
              DoStartPrint(AReportLink, GetTotalPageCount);

              CurrentPage := 0;
              if not ACollate and (ACopyCount > 1) then
                for Index := 0 to Length(ActualPageIndexes) - 1 do
                begin                    
                  PageIndex := ActualPageIndexes[Index] - 1;
                  if not CanPrintPage(Index, PageIndex) then Continue;
                  for CopyIndex := 1 to ACopyCount do
                  begin
                    DoPrintPage(CurrentPage, PageIndex);
                    if AbortPrinting then Break;
                  end;
                  if AbortPrinting then Break;
                end
              else
                for CopyIndex := 1 to ACopyCount do
                begin
                  for Index := 0 to Length(ActualPageIndexes) - 1 do
                  begin
                    PageIndex := ActualPageIndexes[Index] - 1;
                    if not CanPrintPage(Index, PageIndex) then Continue;
                    DoPrintPage(CurrentPage, PageIndex);
                    if AbortPrinting then Break;
                  end;
                  if AbortPrinting then Break;
                end;
            finally
              if dxPrintDevice.Printing then
                if AbortPrinting then
                  dxPrintDevice.Abort
                else
                  dxPrintDevice.EndDoc;
              DoEndPrint(AReportLink);
            end
            else
              if (dxPrintDevice.CurrentPort = nil) or
                (StrIComp(dxPrintDevice.CurrentPort, sdxFilePort) <> 0) then
                DoPrintDeviceError;
          finally
            UnpreparePrintDevice;
          end;
        finally
          Exclude(FState, cpsPrinting);
        end;
      except
        if dxPrintDevice.Printing then
        try
          dxPrintDevice.Abort;
        except
          Application.HandleException(Self);
        end;
        DoPrintDeviceError;
      end;
    finally
      AReportLink.AfterPrinting;
    end;
  finally
    UnprepareReport(AReportLink);
  end;  
end;

function TCustomdxComponentPrinter.Print(AShowDialog: Boolean;
  APPrintDlgData: PdxPrintDlgData;
  AReportLink: TBasedxReportLink = nil): Boolean;

  function GetPrintDlgData(AReportLink: TBasedxReportLink): TdxPrintDlgData;
  begin
    if APPrintDlgData <> nil then
      Result := APPrintDlgData^
    else
      InitializeDefaultPrintDlgData(AReportLink, Result);
  end;

  procedure DonePrintDlgData(AReportLink: TBasedxReportLink; var APrintDlgData: TdxPrintDlgData);
  begin
    if APPrintDlgData = nil then
      FinalizeDefaultPrintDlgData(AReportLink, APrintDlgData);
  end;

var
  PrintDlgData: TdxPrintDlgData;
begin
  Result := False;
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;
  InitDevModeFromPrinterPageSettings(AReportLink.PrinterPage);
  try
    if not AShowDialog then
    begin
      PrepareReport(AReportLink);
      PrintDlgData := GetPrintDlgData(AReportLink);
      try
        if not AbortBuilding and (AReportLink.PageCount > 0) then
          with PrintDlgData.DialogData do
            Result := PrintPagesAsStringEx(Pages, PageNums, Copies, Collate, AReportLink)
        else
          Result := False;
      finally
        UnprepareReport(AReportLink);
      end;
    end
    else
    begin
      PrintDlgData := GetPrintDlgData(AReportLink);
      Result := PrintDialog(AReportLink, PrintDlgData);
    end;
  finally
    DonePrintDlgData(AReportLink, PrintDlgData);
  end;
end;

procedure TCustomdxComponentPrinter.PrepareReport(AReportLink: TBasedxReportLink);
begin
  if not AReportLink.FPrepared then
    if AReportLink.DataProviderPresent then
    begin
      if not PreviewExists and (IsDesigning or IsRebuildBeforePrint) then
      begin
        RebuildReport(AReportLink);
        DesignerModified;
      end
      else
        if AutoUpdateDateTime then AReportLink.DateTime := Now;
        
      AReportLink.FPrepared := True;
    end
    else
      AReportLink.FPrepared := False;
end;

procedure TCustomdxComponentPrinter.UnprepareReport(AReportLink: TBasedxReportLink);
begin
  AReportLink.FPrepared := False;
end;

procedure TCustomdxComponentPrinter.BeforeLoadFromStream(AStream: TStream);
begin
  FMemoryStream := TMemoryStream.Create;
  SaveToStream(FMemoryStream);
  DeleteAllLinks;
end;

procedure TCustomdxComponentPrinter.ErrorLoadFromStream(AStream: TStream);
begin
  DeleteAllLinks;
  FMemoryStream.Position := 0;
  LoadFromStream(FMemoryStream);
  Application.HandleException(Self);
end;

procedure TCustomdxComponentPrinter.PrepareLoadFromStream(AStream: TStream);    
begin
  FInternalStreaming := True;
  Include(FState, cpsLoading);  
end;

procedure TCustomdxComponentPrinter.UnprepareLoadFromStream(AStream: TStream);    
begin
  Exclude(FState, cpsLoading);
  FInternalStreaming := False;
end;

procedure TCustomdxComponentPrinter.LoadItselfFromStream(AStream: TStream);    
var
  I: Integer;
begin
  AStream.ReadComponent(Self);
  Loaded;
  for I := 0 to LinkCount - 1 do 
    ReportLink[I].Loaded;
end;

procedure TCustomdxComponentPrinter.LoadLinksFromStream(AStream: TStream);    
var
  Count, I: Integer;
  Links: TList;
begin
  AStream.ReadBuffer(Count, SizeOf(Count));
  
  Links := TList.Create;
  try
    Links.Count := Count;
    
    for I := 0 to Count - 1 do
    begin                         
      Links[I] := AStream.ReadComponent(nil);
      Owner.InsertComponent(TComponent(Links[I]));
    end;

    for I := 0 to Count - 1 do
    begin
      TBasedxReportLink(Links[I]).ComponentPrinter := Self;
      if TObject(Links[I]) is TdxCompositionReportLink then
        TdxCompositionReportLink(Links[I]).Items.CorrectLinksAfterLoadings;
    end;
  finally
    Links.Free;
  end;    
end;

procedure TCustomdxComponentPrinter.LoadVersionFromStream(AStream: TStream; var AVersion: Integer);
begin
  AStream.ReadBuffer(AVersion , SizeOf(AVersion));
end;

procedure TCustomdxComponentPrinter.PrepareSaveToStream(AStream: TStream);    
begin
  FInternalStreaming := True;
  Include(FState, cpsSaving);
end;

procedure TCustomdxComponentPrinter.UnprepareSaveToStream(AStream: TStream);    
begin
  Exclude(FState, cpsSaving);
  FInternalStreaming := False;
end;

procedure TCustomdxComponentPrinter.SaveItselfToStream(AStream: TStream);    
begin
  AStream.WriteComponent(Self);
end;

procedure TCustomdxComponentPrinter.SaveLinksToStream(AStream: TStream);
var
  I: Integer;
begin
  I := LinkCount;
  AStream.WriteBuffer(I , SizeOf(I));
  for I := 0 to LinkCount - 1 do
  begin
    ReportLink[I].InternalStreaming := True;
    AStream.WriteComponent(ReportLink[I]);
  end;
end;

procedure TCustomdxComponentPrinter.SaveVersionToStream(AStream: TStream);
begin
  AStream.WriteBuffer(Version , SizeOf(Version));
end;

procedure TCustomdxComponentPrinter.PrintEx(APageNums: TdxPageNumbers;
  ACopies: Integer; ACollate: Boolean; AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    PrepareReport(AReportLink);
    try
      if not AbortBuilding and (AReportLink.PageCount > 0) then
      begin
        FPrintAll := True;
        try
          PrintPagesAsStringEx('1-' + Trim(IntToStr(AReportLink.PageCount)), APageNums, ACopies, ACollate, AReportLink);
        finally
          FPrintAll := False;
        end;  
      end;
    finally
      UnprepareReport(AReportLink);
    end;      
  end;
end;

procedure TCustomdxComponentPrinter.PreparePrintDevice;
begin
  if dxPrintDevice.Copies > 1 then
  begin
    FSaveCopies := dxPrintDevice.Copies;
    dxPrintDevice.Copies := 1;
  end;
  if dxPrintDevice.Collate then
  begin
    FSaveCollate := dxPrintDevice.Collate;
    dxPrintDevice.Collate := False;
  end;
  CurrentLink.RealPrinterPage.ApplyToPrintDevice;
  
  dxPSEdgePatternFactory.ResetPrintItems;
  dxPSFillPatternFactory.ResetPrintItems;
end;

procedure TCustomdxComponentPrinter.UnpreparePrintDevice;
begin
  if FSaveCopies > 1 then
    dxPrintDevice.Copies := FSaveCopies;
  FSaveCopies := 1;
  if FSaveCollate then
    dxPrintDevice.Collate := FSaveCollate;
  FSaveCollate := False;
end;

procedure TCustomdxComponentPrinter.GetPageColRowCount(out ACol, ARow: Integer;
  AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then
  begin
    ACol := 0;
    ARow := 0;
  end
  else
    AReportLink.GetPageColRowCount(ACol, ARow);
end;

function TCustomdxComponentPrinter.GetPageCount(AReportLink: TBasedxReportLink = nil): Integer;
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
    Result := AReportLink.PageCount
  else
    Result := 0;
end;

function TCustomdxComponentPrinter.PageSetup(AReportLink: TBasedxReportLink): Boolean;
begin
  AReportLink := CheckLink(AReportLink);
  Result := (AReportLink <> nil) and AReportLink.PageSetup;
end;

function TCustomdxComponentPrinter.PageSetupEx(AActivePageIndex: Integer; 
  AShowPreviewBtn, AShowPrintBtn: Boolean; out APreviewBtnClicked, APrintBtnClicked: Boolean; 
  AReportLink: TBasedxReportLink = nil): Boolean;
begin
  AReportLink := CheckLink(AReportLink);
  Result := (AReportLink <> nil) and
    AReportLink.PageSetupEx(AActivePageIndex, AShowPreviewBtn, AShowPrintBtn, APreviewBtnClicked, APrintBtnClicked);
end;

function TCustomdxComponentPrinter.PageSetupEx(AActivePageIndex: Integer;
  APreviewBtnClicked, APrintBtnClicked: PBoolean; 
  AReportLink: TBasedxReportLink = nil): Boolean;
var
  ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked: Boolean;  
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    ShowPreviewBtn := APreviewBtnClicked <> nil;
    ShowPrintBtn := APrintBtnClicked <> nil;
    Result := AReportLink.PageSetupEx(AActivePageIndex, ShowPreviewBtn, ShowPrintBtn, PreviewBtnClicked, PrintBtnClicked);

    if ShowPreviewBtn then
      APreviewBtnClicked^ := PreviewBtnClicked; 

    if ShowPrintBtn then
      APrintBtnClicked^ := PrintBtnClicked;
  end
  else
    Result := False;
end;

procedure TCustomdxComponentPrinter.Explore;
var
  PrevCurrentLink: TBasedxReportLink;
begin
  if Explorer <> nil then 
  begin 
    Include(FState, cpsExplore);
    try
      PrevCurrentLink := CurrentLink;
      CurrentLink := ExplorerRealStubLink;
      try
        CurrentLink.DataSource := rldsExternalStorage;
        Preview(True);
      finally
        if ExplorerStubLink = nil then { Link had been created manually before }
          CurrentLink.Free;
        CurrentLink := PrevCurrentLink;
      end;
    finally
      Exclude(FState, cpsExplore);
    end;  
  end;  
end;
    
function TCustomdxComponentPrinter.DesignerExists(AReportLink: TBasedxReportLink = nil): Boolean;
begin
  AReportLink := CheckLink(AReportLink);
  Result := (AReportLink <> nil) and (AReportLink.GetDesignerClass <> nil);
end;

function TCustomdxComponentPrinter.DesignerExistsByComponent(AComponent: TComponent): Boolean;
begin
  Result := (AComponent <> nil) and (dxPSDesignerClassByCompClass(TComponentClass(AComponent.ClassType)) <> nil);
end;

function TCustomdxComponentPrinter.DesignReport(AReportLink: TBasedxReportLink): Boolean;
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink <> nil then
  begin
    Include(FState, cpsDesigning);
    try
      Result := AReportLink.DesignReport;
    finally
      Exclude(FState, cpsDesigning);
    end;
  end
  else
    Result := False;
end;

procedure TCustomdxComponentPrinter.DrawPageHeader(AReportLink: TBasedxReportLink;
  APageIndex: Integer; ARect: TRect;
  ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
begin
  AReportLink.DrawPageHeader(APageIndex, ARect, ATitleParts, ADrawBackground);
end;

procedure TCustomdxComponentPrinter.DrawPageFooter(AReportLink: TBasedxReportLink;
  APageIndex: Integer; ARect: TRect;
  ATitleParts: TdxPageTitleParts; ADrawBackground: Boolean);
begin
  AReportLink.DrawPageFooter(APageIndex, ARect, ATitleParts, ADrawBackground);
end;

{ TdxComponentPrinter }

constructor TdxComponentPrinter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCustomizeDlgOptions := [cdoShowDescription];
  FOverWriteExistingFiles := False;
end;                             

destructor TdxComponentPrinter.Destroy;
begin
  if not IsDesigning and (dxPSEngine.RealRegistryPath <> '') then
    SaveToRegistry(dxPSEngine.RealRegistryPath);
  inherited Destroy;
end;

procedure TdxComponentPrinter.ShowCustomizeDlg;
{$IFNDEF CBUILDER6}
var
  Data: TdxCPDesignerDlgData;
{$ENDIF}  
begin
{$IFNDEF CBUILDER6}
  FillChar(Data, SizeOf(TdxCPDesignerDlgData), 0);
  Data.ComponentPrinter := Self;
  if cdoShowDescription in CustomizeDlgOptions then 
    Include(Data.Options, doShowDescription);
  Include(FState, cpsCustomizing);
  try
    dxShowCPDesignerDlg(Data);
  finally
    Exclude(FState, cpsCustomizing);
  end; 
{$ENDIF} 
end;

procedure TdxComponentPrinter.Loaded;
begin
  inherited Loaded;
  if (LinkCount > 0) and (CurrentLink = nil) then
    CurrentLink := ReportLink[0];
  if not IsDesigning then
    LoadFromRegistry(dxPSEngine.RealRegistryPath);
end;

procedure TdxComponentPrinter.SaveToRegistry(const APath: string);

  procedure SaveFormats(const APath: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(APath, True) then
      try
        try
          WriteBool(sdxAutoUpdateDateTime, AutoUpdateDateTime);
          WriteInteger(sdxDateFormat, DateFormat);
          WriteInteger(sdxTimeFormat, TimeFormat);
          WriteInteger(sdxPageNumberFormat, Integer(PageNumberFormat));
        except
          on ERegistryException do
            { ignore }
          else
            raise;
        end;
      finally
        CloseKey;
      end;
    finally
      Free;
    end;  
  end;

begin
  if APath = '' then Exit;
  SaveFormats(APath);
  dxSaveStringsToRegistry(APath + sdxPrintDlgFilesRegistryPath + '\' + Name, FPrintFileList);  
end;

procedure TdxComponentPrinter.LoadFromRegistry(const APath: string);

  procedure LoadFormats(const APath: string);
  begin
    with TRegistry.Create do
    try
      if OpenKey(APath, False) then
      try
        try
          if ValueExists(sdxAutoUpdateDateTime) then
            AutoUpdateDateTime := ReadBool(sdxAutoUpdateDateTime);
          if ValueExists(sdxDateFormat) then
            DateFormat := ReadInteger(sdxDateFormat);
          if ValueExists(sdxTimeFormat) then
            TimeFormat := ReadInteger(sdxTimeFormat);
          if ValueExists(sdxPageNumberFormat) then
            PageNumberFormat := TdxPageNumberFormat(ReadInteger(sdxPageNumberFormat));
        except
          on ERegistryException do
            { ignore }
          else
            raise;
        end;
      finally
        CloseKey;
      end;
    finally
      Free;
    end;
  end;

begin
  if APath = '' then Exit;
  LoadFormats(APath);
  dxLoadStringsFromRegistry(APath + sdxPrintDlgFilesRegistryPath + '\' + Name, FPrintFileList);  
end;

function TdxComponentPrinter.DoFilterComponent(AComponent: TComponent; 
  var ACaption, ADescription: string): Boolean;
begin
  Result := True;
  if Assigned(FOnFilterComponent) then 
    FOnFilterComponent(Self, AComponent, ACaption, ADescription, Result);
end;

procedure TdxComponentPrinter.GetDefaultExportPageFileName(AIndex,
  APageIndex: Integer; var AFileName: string);
begin
  AFileName := Format(AFileName, [APageIndex]);
end;

procedure TdxComponentPrinter.GetExportPageFileName(AIndex, APageIndex: Integer;
  var AFileName: string);
begin
  if Assigned(FOnExportGetPageFileName) then
    FOnExportGetPageFileName(Self, AIndex, APageIndex, AFileName)
  else
    GetDefaultExportPageFileName(AIndex, APageIndex, AFileName);
end;

function TdxComponentPrinter.GetSupportedComponents(AComponents: TStrings): Boolean;
begin
  Result := Assigned(FOnGetSupportedComponents);
  if Result then 
    FOnGetSupportedComponents(Self, AComponents);
end;

procedure TdxComponentPrinter.EnumPagesAsImages(const APageIndexes: array of Integer;
  AGraphicClass: TGraphicClass; ADrawBackground: Boolean; ACallBackProc: TdxEnumPagesAsImagesProc; 
  ACallBackData, AProgressData, APrepareData: Pointer;  
  AReportLink: TBasedxReportLink = nil);
begin
  AReportLink := CheckLink(AReportLink);
  if AReportLink = nil then Exit;
  dxPSEnumReportPages(Self, AReportLink, APageIndexes, AGraphicClass, ADrawBackground,
    ACallBackProc, ACallBackData, OnExportProgress, AProgressData,
    OnExportPrepareGraphic, APrepareData);
end;

procedure TdxComponentPrinter.WritePageAsImageToDisk(AComponentPrinter: TCustomdxComponentPrinter;
  AReportLink: TBasedxReportLink; AIndex, APageIndex: Integer; const AGraphic: TGraphic;
  AData: Pointer; var AContinue: Boolean);
const
  Buttons: TMsgDlgButtons = [mbYes, mbYesToAll, mbNo, mbCancel {, mbHelp}];
var
  FileName: string;
  MessageResult: Word;
  MessageText: string;
begin
  if AData = nil then Exit;
  FileName := string(AData);
  GetExportPageFileName(AIndex, APageIndex, FileName);
  if not ValidateFileName(FileName) then Exit;

  FOverWriteFile := True;
  if FileExists(FileName) and not OverWriteExistingFiles and not FOverWriteAll then
  begin
    FOverWriteFile := False;
    Beep;
    MessageText := Format(cxGetResourceString(@sdxConfirmOverWrite), [FileName]);
    MessageResult := MessageDlg(MessageText, mtWarning, Buttons, 0);
    case MessageResult of
      mrYes:
        FOverWriteFile := True;
      mrYesToAll:
        begin
          FOverWriteFile := True;
          FOverWriteAll := True;
        end;
      mrNo:
        begin
          AContinue := dxShowChooseFileNameDlg(FileName);
          if AContinue then FOverWriteFile := True;
        end;
      mrCancel:
        AContinue := False;
    end;
  end;
  if FOverWriteFile then 
  begin
    if AGraphic is TBitmap then
      TBitmap(AGraphic).HandleType := bmDIB;
    AGraphic.SaveToFile(FileName);
  end;
end;

procedure TdxComponentPrinter.SavePagesAsImagesToDisk(const APageIndexes: array of Integer;
  AGraphicClass: TGraphicClass; ADrawBackground: Boolean; const AFileMask: string;
  AProgressData, APrepareData: Pointer;
  AReportLink: TBasedxReportLink = nil);
var
  PFileMask: PChar;
begin
  FOverWriteAll := False;
  PrepareLongOperation;
  try
      PFileMask := PChar(AFileMask);
      EnumPagesAsImages(APageIndexes, AGraphicClass, ADrawBackground,
        WritePageAsImageToDisk, PFileMask, AProgressData, APrepareData,
        AReportLink);
  finally
    FOverWriteAll := False;
    UnprepareLongOperation;
  end;
end;

{ TAbstractdxPreviewWindowDesigner }

constructor TAbstractdxPreviewWindowDesigner.Create(AComponentPrinter: TCustomdxComponentPrinter);
begin
  inherited Create;
  FComponentPrinter := AComponentPrinter;
  if FComponentPrinter <> nil then
    FComponentPrinter.FPreviewWindowDesigner := Self;
end;

destructor TAbstractdxPreviewWindowDesigner.Destroy;
begin
  if FComponentPrinter <> nil then
    FComponentPrinter.FPreviewWindowDesigner := nil;
  inherited Destroy;
end;

{ TAbstractdxReportLinkDesigner }

constructor TAbstractdxReportLinkDesigner.Create(AComponentPrinter: TCustomdxComponentPrinter);
begin
  inherited Create;
  FComponentPrinter := AComponentPrinter;
  if FComponentPrinter <> nil then
    FComponentPrinter.FReportLinkDesigner := Self;
end;

destructor TAbstractdxReportLinkDesigner.Destroy;
begin
  if FComponentPrinter <> nil then
    FComponentPrinter.FReportLinkDesigner := nil;
  inherited Destroy;
end;

{ export }

procedure dxPSEnumReportPages(AComponentPrinter: TdxComponentPrinter;
  AReportLink: TBasedxReportLink; const APageIndexes: array of Integer;
  AGraphicClass: TGraphicClass; AnExportBackground: Boolean;
  ACallBackProc: TdxEnumPagesAsImagesProc; 
  ACallBackData: Pointer;
  AProgressProc: TdxExportProgressEvent; 
  AProgressData: Pointer;
  APrepareGraphicProc: TdxExportPrepareGraphicEvent; 
  APrepareData: Pointer);

  procedure GetPPI(out APPI: TPoint);
  var
    DC: HDC;
  begin
    DC := GetDC(0);
    try
      APPI.X := GetDeviceCaps(DC, LOGPIXELSX);
      APPI.Y := GetDeviceCaps(DC, LOGPIXELSY);      
    finally
      ReleaseDC(0, DC);
    end;
  end;

  function AreAllPagesEnumerated: Boolean;
  begin
    Result := (Low(APageIndexes) = High(APageIndexes)) and (APageIndexes[0] = -1);
  end;
  
  procedure GetPageBounds(out R: TRect);
  begin
    with AReportLink.RealPrinterPage.PageSizePixels do 
      R := MakeRect(0, 0, X, Y);
  end;
  
  procedure PreparePageIndexes(out AnActualPageIndexes: TIntegers);
  var
    I: Integer;
  begin
    if AreAllPagesEnumerated then
    begin
      SetLength(AnActualPageIndexes, AReportLink.PageCount);
      for I := 0 to AReportLink.PageCount - 1 do 
        AnActualPageIndexes[I] := I;
    end  
    else
    begin
      SetLength(AnActualPageIndexes, Length(APageIndexes));
      for I := 0 to Length(APageIndexes) - 1 do 
        AnActualPageIndexes[I] := APageIndexes[I];
    end;
  end;

  function CreatePageAsMetafile(const ABounds: TRect; const APPI: TPoint; APageIndex: Integer): TMetafile;
  var
    MetaCanvas: TCanvas;
    APrevUnitsPerInch: Integer; 
  begin
    Result := TMetafile.Create;
    try
      APrevUnitsPerInch := FUnitsPerInch;
      with ABounds do
      begin
        Result.Width := Right - Left;
        Result.Height := Bottom - Top;
      end;

      MetaCanvas := TMetafileCanvas.Create(Result, 0);
      try
        if not FUseIsotropicMode then
        begin
          FUnitsPerInch := 96;
          AReportLink.RebuildReport;
        end;
        if AGraphicClass.InheritsFrom(TMetafile) and Assigned(APrepareGraphicProc) then
          APrepareGraphicProc(AComponentPrinter, AReportLink, Result, APrepareData);

        if not AnExportBackground or AReportLink.RealPrinterPage.Background.IsEmpty then
        begin
          MetaCanvas.Brush.Color := clWhite;
          MetaCanvas.FillRect(ABounds);
        end
        else
          AReportLink.RealPrinterPage.Background.Paint(MetaCanvas, ABounds);

        if (-1 < APageIndex) and (APageIndex < AReportLink.PageCount) then
          AComponentPrinter.PaintPage(MetaCanvas, APageIndex, ABounds, ABounds, AReportLink);
      finally
        if not FUseIsotropicMode then
        begin
          FUnitsPerInch := APrevUnitsPerInch;
          AReportLink.RebuildReport;
        end;
        MetaCanvas.Free;
      end;
    except
      Result.Free;
      raise;
    end;
  end;

  function CreatePageAsGraphic(const ABounds: TRect; const APPI: TPoint; APageIndex: Integer): TGraphic;
  var
    Metafile: TMetafile;
    Bitmap: TBitmap;
  begin
    Metafile := CreatePageAsMetafile(ABounds, APPI, APageIndex);
    try
      if not AGraphicClass.InheritsFrom(TMetafile) then
      begin
        Bitmap := TBitmap.Create;
        try
          Bitmap.Height := Metafile.Height;
          Bitmap.Width := Metafile.Width;
          if AGraphicClass.InheritsFrom(TBitmap) and Assigned(APrepareGraphicProc) then
            APrepareGraphicProc(AComponentPrinter, AReportLink, Bitmap, APrepareData);
          Bitmap.Canvas.Draw(0, 0, Metafile);
          
          if not AGraphicClass.InheritsFrom(TBitmap) then
          begin
            Result := dxPSUtl.CreateGraphic(AGraphicClass);
            try
              if Assigned(APrepareGraphicProc) then
                APrepareGraphicProc(AComponentPrinter, AReportLink, Result, APrepareData);
              Result.Assign(Bitmap);
            except
              Result.Free;
              raise;
            end;
          end
          else
            Result := Bitmap;
        finally
          if not AGraphicClass.InheritsFrom(TBitmap) then Bitmap.Free;
        end;
      end
      else
        Result := Metafile;
    finally
      if not AGraphicClass.InheritsFrom(TMetafile) then Metafile.Free;
    end;
  end;

var
  PPI: TPoint;
  PageCount, I, PageIndex: Integer;
  ActualPageIndexes: TIntegers;
  ContinueExport: Boolean;
  R: TRect;
  Graphic: TGraphic;
begin
  if (AComponentPrinter = nil) or (AReportLink = nil) or not Assigned(ACallBackProc) then 
    Exit;

  if AGraphicClass = nil then AGraphicClass := TMetafile;

  GetPPI(PPI);
  PreparePageIndexes(ActualPageIndexes);
  try
    GetPageBounds(R); 
    ContinueExport := True;
    PageCount := Length(ActualPageIndexes);
    for I := 0 to PageCount - 1 do
    begin
      PageIndex := ActualPageIndexes[I];
      Graphic := CreatePageAsGraphic(R, PPI, PageIndex);
      try
        ACallBackProc(AComponentPrinter, AReportLink, I, PageIndex, Graphic, ACallBackData, ContinueExport);
      finally
        Graphic.Free;
      end;
      if not ContinueExport then Break;
      if Assigned(AProgressProc) then
        AProgressProc(AComponentPrinter, AReportLink, PageCount, I, PageIndex, AProgressData);
    end;  
  finally
     SetLength(ActualPageIndexes, 0);
  end;  
end;  

procedure InitializeUnits;
begin
  if IsWin9X then FUnitsPerInch := 960;
  FPixelsNumerator := FUnitsPerInch;
  FPixelsDenominator := Screen.PixelsPerInch;
end;

procedure RegisterAssistants;
begin
  TdxPSExplorerTreeBuilder.Register;
  TdxPSRunTimeComponentsProvider.Register;
  
  TdxPSDataReader.Register;
  TdxPSDataWriter.Register;
  
  TdxPSCustomCellBorder.Register;
  TdxPSCellNullBorder.Register;
  TdxPSCellFlatBorder.Register;
  TdxPSCellBoldFlatBorder.Register;
  TdxPSCellUltraFlatBorder.Register;
  TdxPSCustomCell3DBorder.Register;
  TdxPSCellRaisedBorder.Register;
  TdxPSCellRaisedSoftBorder.Register;
  TdxPSCellSunkenBorder.Register;
  TdxPSCellSunkenSoftBorder.Register;
  TdxPSCellTwistedBorder.Register;
  TdxPSCellEtchedBorder.Register;
  TdxPSCellBumpedBorder.Register;
  TdxPSColorBorder.Register;
  
  TdxPSReportGroupNullLookAndFeel.Register;
  TdxPSReportGroupStandardLookAndFeel.Register;
  TdxPSReportGroupOfficeLookAndFeel.Register;
  TdxPSReportGroupWebLookAndFeel.Register;
end;

procedure RegisterGraphicClasses;
const
  GraphicClassCount = 3 {$IFDEF USEJPEGIMAGE} + 1 {$ENDIF};
  GraphicClasses: array[0..GraphicClassCount - 1] of TGraphicClass = 
    (TBitmap, TMetafile, TIcon{$IFDEF USEJPEGIMAGE}, TJPEGImage{$ENDIF});
var
  I: Integer;
  GraphicClass: TGraphicClass;
begin
  for I := Low(GraphicClasses) to High(GraphicClasses) do 
  begin
    GraphicClass := GraphicClasses[I];
    if GetClass(GraphicClass.ClassName) = nil then 
      RegisterClass(GraphicClass);
  end;  
end;

procedure RegisterItems;
begin
  TdxReportCell.Register;
  TdxReportGroup.Register;
  TdxReportRadioGroup.Register;
  TdxReportCheckGroup.Register;

  TdxReportCellBox.Register;
  TdxReportCellString.Register;
  TdxReportCellCheck.Register;
  TdxReportCellRadio.Register;
  TdxReportCellCheckImage.Register;
  TdxReportCellRadioGroupButton.Register;
  TdxReportCellGroupButton.Register;
  TdxReportCellCheckGroupButton.Register;
  TdxReportCellImage.Register;
  TdxReportCellGraphic.Register;
  TdxReportCellExpandButton.Register;
  TdxReportCellExpandButtonEx.Register;
end;

procedure UnregisterAssistants;
begin
  TdxPSDataWriter.Unregister;
  TdxPSDataReader.Unregister;

  TdxPSRunTimeComponentsProvider.Unregister;
  TdxPSExplorerTreeBuilder.Unregister;
end;

procedure UnregisterItems;
begin
  TdxReportCellExpandButtonEx.Unregister;
  TdxReportCellExpandButton.Unregister;
  TdxReportCellGraphic.Unregister;
  TdxReportCellImage.Unregister;
  TdxReportCellCheckGroupButton.Unregister;
  TdxReportCellGroupButton.Unregister;
  TdxReportCellRadioGroupButton.Unregister;
  TdxReportCellCheckImage.Unregister;
  TdxReportCellRadio.Unregister;
  TdxReportCellCheck.Unregister;
  TdxReportCellString.Unregister;
  TdxReportCellBox.Unregister;

  TdxReportCheckGroup.Unregister;
  TdxReportRadioGroup.Unregister;
  TdxReportGroup.Unregister;
  TdxReportCell.Unregister;
end;

initialization
  OleInitialize(nil);

  dxPgsDlg.dxPSRegisterPrintStyle(TdxPSPrintStyle, True);
  dxPSRegisterReportLink(TdxCompositionReportLink, nil, TdxfmCompositionDesignWindow);

  InitializeUnits;

  RegisterAssistants;
  RegisterGraphicClasses;
  RegisterItems;

finalization
  UnregisterItems;
  UnregisterAssistants;

  dxPSUnregisterAllReportLinks;
  dxPgsDlg.dxPSUnregisterPrintStyle(TdxPSPrintStyle);
  dxPSUnregisterAllPreviewWindows;

  FreeAndNil(FExplorerImages);

  OleUninitialize;

end.
