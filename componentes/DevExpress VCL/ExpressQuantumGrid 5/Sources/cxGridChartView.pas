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

unit cxGridChartView;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows, Classes, Graphics, Controls, Menus,
  cxClasses, cxGraphics, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxData, cxDataStorage, cxGridCustomView;

const
  htChartBase = 50;
  htChartTitle = htChartBase + 1;
  htLegend = htChartBase + 2;
  htLegendItem = htChartBase + 3;
  htChartValue = htChartBase + 4;
  // column diagram
  htPlot = htChartBase + 5;
  htCategoryAxisTitle = htChartBase + 6;
  htValueAxisTitle = htChartBase + 7;

  dsDiagramFirst = 0;
  dsLegend = dsDiagramFirst;
  dsValueCaptions = dsDiagramFirst + 1;
  dsValues = dsDiagramFirst + 2;
  dsAxis = dsDiagramFirst + 3;
  dsCategoryAxis = dsDiagramFirst + 4;
  dsValueAxis = dsDiagramFirst + 5;
  dsAxisTitle = dsDiagramFirst + 6;
  dsCategoryAxisTitle = dsDiagramFirst + 7;
  dsValueAxisTitle = dsDiagramFirst + 8;
  dsGridLines = dsDiagramFirst + 9;
  dsCategoryGridLines = dsDiagramFirst + 10;
  dsValueGridLines = dsDiagramFirst + 11;
  dsPlot = dsDiagramFirst + 12;
  dsDiagramLast = dsPlot;

  ssSeriesFirst = 0;
  ssValues = ssSeriesFirst;
  ssSeriesLast = ssValues;

  vsChartFirst = vsCustomLast + 1;
  vsTitle = vsChartFirst;
  vsLegend = vsChartFirst + 1;
  vsChartLast = vsLegend;

  cxGridChartColumnDiagramDefaultBorderWidth = 1;

type
  TcxCustomGridChartTitleViewInfo = class;
  TcxGridChartLegendItemViewInfo = class;
  TcxGridChartLegendViewInfo = class;
  TcxGridChartDiagramValueViewInfo = class;
  TcxGridChartDiagramViewInfo = class;
  TcxGridChartColumnDiagramLegendViewInfo = class;
  TcxGridChartColumnDiagramTickMarkLabelsViewInfo = class;
  TcxGridChartColumnDiagramViewInfo = class;
  TcxGridChartViewInfo = class;
  TcxCustomGridChartTitle = class;
  TcxGridChartDiagram = class;
  TcxGridChartColumnDiagramAxisTitle = class;
  TcxGridChartColumnDiagramAxis = class;
  TcxGridChartColumnDiagramAxisValue = class;
  TcxGridChartColumnDiagram = class;
  TcxGridChartSeries = class;
  TcxGridChartView = class;

  TcxGridChartPartAlignment = (cpaDefault, cpaStart, cpaCenter, cpaEnd);
  TcxGridChartPartOrientation = (cpoDefault, cpoHorizontal, cpoVertical);
  TcxGridChartPartPosition = (cppDefault, cppNone, cppLeft, cppTop, cppRight, cppBottom);

  TcxGridChartColumnDiagramValueCaptionPosition = (cdvcpNone, cdvcpInsideBase,
    cdvcpCenter, cdvcpInsideEnd, cdvcpOutsideEnd);

  { hit tests }

  TcxGridChartTitleHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridChartLegendHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridChartLegendItemHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    Index: Integer;
    Series: TcxGridChartSeries;
    ValueIndex: Integer;
  end;

  TcxGridChartValueHitTest = class(TcxCustomGridViewHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  public
    Series: TcxGridChartSeries;
    ValueIndex: Integer;
  end;

  TcxCustomGridChartDiagramHitTest = class(TcxCustomGridViewHitTest)
  public
    Diagram: TcxGridChartDiagram;
  end;

  // column diagram

  TcxGridChartHistogramPlotHitTest = class(TcxCustomGridChartDiagramHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxCustomGridChartHistogramAxisHitTest = class(TcxCustomGridChartDiagramHitTest);

  TcxGridChartHistogramCategoryAxisTitleHitTest = class(TcxCustomGridChartHistogramAxisHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  TcxGridChartHistogramValueAxisTitleHitTest = class(TcxCustomGridChartHistogramAxisHitTest)
  protected
    class function GetHitTestCode: Integer; override;
  end;

  { controller }

  TcxGridChartController = class(TcxCustomGridController)
  private
    function GetGridView: TcxGridChartView;
  protected
    function GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean; override;
    function GetPatternObject(AObject: TPersistent): TPersistent; override;
  public
    function GetValueHintText(ASeries: TcxGridChartSeries; AValueIndex: Integer): string; virtual;
    property GridView: TcxGridChartView read GetGridView;
  end;

  { datacontroller }

  IcxGridChartViewItemsProvider = interface
    ['{852B466D-5068-4600-BBC6-0061BF69A0B0}']
    function GetSeries(AIndex: Integer): TcxGridChartSeries;
    procedure GetSeriesCaptions(ACaptions: TStringList);
    procedure InitSeries(ASeries: TcxGridChartSeries; AIndex: Integer);
  end;

  TcxGridChartDataController = class(TcxDataController, IcxCustomGridDataController)
  private
    function GetGridViewValue: TcxGridChartView;
  protected
    { IcxCustomGridDataController }
    procedure AssignData(ADataController: TcxCustomDataController);
    procedure CreateAllItems;
    procedure DeleteAllItems;
    procedure GetFakeComponentLinks(AList: TList);
    function GetGridView: TcxCustomGridView;
    function IsDataChangeable: Boolean;
    function IsDataLinked: Boolean;
    function SupportsCreateAllItems: Boolean;

    function GetItemID(AItem: TObject): Integer; override;
  public
    procedure BeginFullUpdate; override;
    procedure EndFullUpdate; override;
    function GetItem(Index: Integer): TObject; override;
    property GridView: TcxGridChartView read GetGridViewValue;
  published
    property Options;
    property OnCompare;
    property OnDataChanged;
    property OnFilterRecord;
    property OnRecordChanged;
  end;

  { painter }

  // title

  TcxGridChartTitlePainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxCustomGridChartTitleViewInfo;
  protected
    procedure PrepareCanvasForDrawText; override;
    procedure UnprepareCanvasForDrawText; override;
  public
    property ViewInfo: TcxCustomGridChartTitleViewInfo read GetViewInfo;
  end;

  // legend

  TcxGridChartLegendItemPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridChartLegendItemViewInfo;
  protected
    procedure DrawContent; override;
    procedure DrawLegendKey; virtual;
    property ViewInfo: TcxGridChartLegendItemViewInfo read GetViewInfo;
  end;

  TcxGridChartLegendPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridChartLegendViewInfo;
  protected
    procedure DrawContent; override;
    function ExcludeFromClipRect: Boolean; override;
    property ViewInfo: TcxGridChartLegendViewInfo read GetViewInfo;
  end;

  // custom diagram

  TcxGridChartDiagramPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridChartDiagramViewInfo;
  protected
    procedure DrawValueCaptions; virtual;
    procedure DrawValues; virtual;
    procedure FillAndExcludeRect(const R: TRect);
    procedure Paint; override;
    property ViewInfo: TcxGridChartDiagramViewInfo read GetViewInfo;
  end;

  // column diagram

  TcxGridChartColumnDiagramTickMarkLabelsPainter = class(TcxCustomGridCellPainter)
  private
    function GetViewInfo: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
  protected
    procedure DrawCaptions; virtual;
    procedure DrawContent; override;
  public
    property ViewInfo: TcxGridChartColumnDiagramTickMarkLabelsViewInfo read GetViewInfo;
  end;

  TcxGridChartColumnDiagramValuePainter = class(TcxCustomGridCellPainter)
  protected
    function ExcludeFromClipRect: Boolean; override;
  end;

  TcxGridChartColumnDiagramPainter = class(TcxGridChartDiagramPainter)
  private
    function GetViewInfo: TcxGridChartColumnDiagramViewInfo;
  protected
    procedure DrawCategoryAxis; virtual;
    procedure DrawCategoryGridLines; virtual;
    procedure DrawContent; override;
    procedure DrawPlotBackground; virtual;
    procedure DrawValueAxis; virtual;
    procedure DrawValueGridLines; virtual;

    property ViewInfo: TcxGridChartColumnDiagramViewInfo read GetViewInfo;
  end;

  // view

  TcxGridChartPainter = class(TcxCustomGridPainter)
  private
    function GetViewInfo: TcxGridChartViewInfo;
  protected
    procedure PaintAfter; override;
    procedure PaintContent; override;
  public
    property ViewInfo: TcxGridChartViewInfo read GetViewInfo;
  end;

  { view data }

  TcxGridChartViewData = class(TcxCustomGridViewData)
  private
    function GetCategory(AIndex: Integer): Variant;
    function GetGridView: TcxGridChartView;
    function GetValue(ASeriesIndex, AIndex: Integer): Variant;
    function GetValueCount: Integer;
    procedure SetCategory(AIndex: Integer; const Value: Variant);
    procedure SetValue(ASeriesIndex, AIndex: Integer; const Value: Variant);
    procedure SetValueCount(Value: Integer);
  public
    function GetRecordIndexByValueIndex(AValueIndex: Integer): Integer;
    property Categories[AIndex: Integer]: Variant read GetCategory write SetCategory;
    property GridView: TcxGridChartView read GetGridView;
    property ValueCount: Integer read GetValueCount write SetValueCount;
    property Values[ASeriesIndex, AIndex: Integer]: Variant read GetValue write SetValue;
  end;

  { view info }

  // part

  TcxCustomGridChartPartViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    function GetGridView: TcxGridChartView;
  protected
    function GetAlignment: TcxGridChartPartAlignment; virtual; abstract;
    function GetHeight: Integer; override;
    function GetOrientation: TcxGridChartPartOrientation; virtual; abstract;
    function GetPosition: TcxGridChartPartPosition; virtual; abstract;
    function GetVisible: Boolean; override;
    function GetWidth: Integer; override;
  public
    property Alignment: TcxGridChartPartAlignment read GetAlignment;
    property GridView: TcxGridChartView read GetGridView;
    property Orientation: TcxGridChartPartOrientation read GetOrientation;
    property Position: TcxGridChartPartPosition read GetPosition;
  end;

  // custom title

  TcxCustomGridChartTitleViewInfo = class(TcxCustomGridChartPartViewInfo)
  private
    FTitle: TcxCustomGridChartTitle;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetAlignment: TcxGridChartPartAlignment; override;
    function GetOrientation: TcxGridChartPartOrientation; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetPosition: TcxGridChartPartPosition; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    function HasBackground: Boolean; override;
  public
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo; ATitle: TcxCustomGridChartTitle); reintroduce; virtual;
    property Title: TcxCustomGridChartTitle read FTitle;
  end;

  // custom legend

  TcxGridChartLegendItemViewInfoClass = class of TcxGridChartLegendItemViewInfo;

  TcxGridChartLegendItemViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FContainer: TcxGridChartLegendViewInfo;
    FIndex: Integer;
    FLegendKeySize: Integer;
    function GetDiagram: TcxGridChartDiagram;
    function GetGridView: TcxGridChartView;
    function GetLegendKeySize: Integer;
    function GetSeries: TcxGridChartSeries;
  protected
    function CalculateContentBounds: TRect; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CalculateLegendKeySize: Integer; virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    procedure DoCalculateParams; override;
    function GetDesignSelectionBounds: TRect; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDesignSelected: Boolean; override;
    function GetLegendKeyBorders: TcxBorders; virtual;
    function GetLegendKeyBounds: TRect; virtual;
    function GetLegendKeyOffset: Integer; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetText: string; override;
    function GetTextAreaBounds: TRect; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasBackground: Boolean; override;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    property LegendKeyOffset: Integer read GetLegendKeyOffset;
    property LegendKeySize: Integer read GetLegendKeySize;
  public
    LegendKeyParams: TcxViewParams;
    constructor Create(AContainer: TcxGridChartLegendViewInfo; AIndex: Integer); reintroduce; virtual;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property Container: TcxGridChartLegendViewInfo read FContainer;
    property Diagram: TcxGridChartDiagram read GetDiagram;
    property GridView: TcxGridChartView read GetGridView;
    property Index: Integer read FIndex;
    property LegendKeyBorders: TcxBorders read GetLegendKeyBorders;
    property LegendKeyBounds: TRect read GetLegendKeyBounds;
    property Series: TcxGridChartSeries read GetSeries;
  end;

  TcxGridChartLegendKind = (lkSeries, lkCategories);

  TcxGridChartLegendViewInfoClass = class of TcxGridChartLegendViewInfo;

  TcxGridChartLegendViewInfo = class(TcxCustomGridChartPartViewInfo)
  private
    FDiagram: TcxGridChartDiagram;
    FItems: TList;
    FLegendItemOffset: Integer;
    function GetCount: Integer;
    function GetItem(Index: Integer): TcxGridChartLegendItemViewInfo;
    function GetLegendItemOffset: Integer;
  protected
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function CalculateLegendItemOffset: Integer; virtual;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetAlignment: TcxGridChartPartAlignment; override;
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetOrientation: TcxGridChartPartOrientation; override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetPosition: TcxGridChartPartPosition; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasCustomDraw: Boolean; override;

    function AddItem: TcxGridChartLegendItemViewInfo;
    procedure CalculateItems; virtual;
    function GetItemCaption(AIndex: Integer): string; virtual;
    function GetItemClass: TcxGridChartLegendItemViewInfoClass; virtual;
    function GetItemCount: Integer; virtual;
    function GetItemObjectIndex(AIndex: Integer): Integer; virtual; abstract;
    function GetKind: TcxGridChartLegendKind; virtual; abstract;

    property LegendItemOffset: Integer read GetLegendItemOffset;
  public
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo; ADiagram: TcxGridChartDiagram); reintroduce; virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    procedure GetItemLegendKeyParams(AIndex: Integer; out AParams: TcxViewParams); virtual;
    property Diagram: TcxGridChartDiagram read FDiagram;
    property Count: Integer read GetCount;
    property Items[Index: Integer]: TcxGridChartLegendItemViewInfo read GetItem;
    property Kind: TcxGridChartLegendKind read GetKind;
  end;

  // custom diagram

  TcxGridChartDiagramValueCaptionViewInfoClass = class of TcxGridChartDiagramValueCaptionViewInfo;

  TcxGridChartDiagramValueCaptionViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FValueViewInfo: TcxGridChartDiagramValueViewInfo;
  protected
    function GetAlignmentHorz: TAlignment; override;
    function GetAlignmentVert: TcxAlignmentVert; override;
    function CalculateHeight: Integer; override;
    function CalculateWidth: Integer; override;
    function GetText: string; override;
    function GetTextAttributes(AForPainting: Boolean): Integer; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function GetVisible: Boolean; override;
    function HasBackground: Boolean; override;
  public
    constructor Create(AValueViewInfo: TcxGridChartDiagramValueViewInfo); reintroduce; virtual;
    property ValueViewInfo: TcxGridChartDiagramValueViewInfo read FValueViewInfo;
  end;

  TcxGridChartDiagramValueViewInfoClass = class of TcxGridChartDiagramValueViewInfo;

  TcxGridChartDiagramValueViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FCaptionViewInfo: TcxGridChartDiagramValueCaptionViewInfo;
    FDiagramViewInfo: TcxGridChartDiagramViewInfo;
    FSeriesIndex: Integer;
    FValueIndex: Integer;
    function GetDiagram: TcxGridChartDiagram;
    function GetGridView: TcxGridChartView;
    function GetSeries: TcxGridChartSeries;
  protected
    function CalculateCaptionBounds: TRect; virtual; abstract;
    function CanShowHint: Boolean; override;
    function CustomDraw(ACanvas: TcxCanvas): Boolean; override;
    function GetCaptionViewInfoClass: TcxGridChartDiagramValueCaptionViewInfoClass; virtual;
    function GetCaptionText: string; virtual;
    procedure GetCaptionViewParams(var AParams: TcxViewParams); virtual; abstract;
    function GetCellBoundsForHint: TRect; override;
    function GetHintText: string; override;
    function GetHintTextRect(const AMousePos: TPoint): TRect; override;
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    function GetIsDesignSelected: Boolean; override;
    function HasCaption: Boolean; virtual;
    function HasCustomDraw: Boolean; override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
    function IsHintForText: Boolean; override;
    function IsHintMultiLine: Boolean; override;

    property Diagram: TcxGridChartDiagram read GetDiagram;
  public
    constructor Create(ADiagramViewInfo: TcxGridChartDiagramViewInfo;
      ASeriesIndex, AValueIndex: Integer); reintroduce; virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    function MouseDown(AHitTest: TcxCustomGridHitTest; AButton: TMouseButton;
      AShift: TShiftState): Boolean; override;
    property CaptionViewInfo: TcxGridChartDiagramValueCaptionViewInfo read FCaptionViewInfo;
    property DiagramViewInfo: TcxGridChartDiagramViewInfo read FDiagramViewInfo;
    property GridView: TcxGridChartView read GetGridView;
    property Series: TcxGridChartSeries read GetSeries;
    property SeriesIndex: Integer read FSeriesIndex;
    property ValueIndex: Integer read FValueIndex;
  end;

  TcxGridChartDiagramViewInfoClass = class of TcxGridChartDiagramViewInfo;

  TcxGridChartDiagramViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FDiagram: TcxGridChartDiagram;
    FValueViewInfos: TList;
    function GetCategory(AIndex: Integer): Variant;
    function GetGridView: TcxGridChartView;
    function GetSeries(AIndex: Integer): TcxGridChartSeries;
    function GetSeriesCount: Integer;
    function GetValue(ASeriesIndex, AIndex: Integer): Variant;
    function GetValueCount: Integer;
    function GetValueViewInfo(Index: Integer): TcxGridChartDiagramValueViewInfo;
    function GetValueViewInfoCount: Integer;
    function GetViewData: TcxGridChartViewData;
  protected
    procedure GetViewParams(var AParams: TcxViewParams); override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;

    function CreateValueViewInfo(ASeriesIndex, AValueIndex: Integer): TcxGridChartDiagramValueViewInfo;
    function GetValueCaption(ASeriesIndex, AValueIndex: Integer): string; virtual;
    function GetValueViewInfoClass: TcxGridChartDiagramValueViewInfoClass; virtual; abstract;

    property Categories[AIndex: Integer]: Variant read GetCategory;
    property Values[ASeriesIndex, AIndex: Integer]: Variant read GetValue;
    property Series[AIndex: Integer]: TcxGridChartSeries read GetSeries;
  public
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo; ADiagram: TcxGridChartDiagram); reintroduce; virtual;
    destructor Destroy; override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
    property Diagram: TcxGridChartDiagram read FDiagram;
    property GridView: TcxGridChartView read GetGridView;
    property SeriesCount: Integer read GetSeriesCount;
    property ValueCount: Integer read GetValueCount;
    property ValueViewInfoCount: Integer read GetValueViewInfoCount;
    property ValueViewInfos[Index: Integer]: TcxGridChartDiagramValueViewInfo read GetValueViewInfo;
    property ViewData: TcxGridChartViewData read GetViewData;
  end;

  // column diagram legend

  TcxGridChartColumnDiagramLegendViewInfo = class(TcxGridChartLegendViewInfo)
  private
    function GetDiagram: TcxGridChartColumnDiagram;
  protected
    function GetItemObjectIndex(AIndex: Integer): Integer; override;
    function GetKind: TcxGridChartLegendKind; override;
  public
    property Diagram: TcxGridChartColumnDiagram read GetDiagram;
  end;

  // column diagram

  TcxGridChartColumnDiagramAxisTitleViewInfoClass = class of TcxGridChartColumnDiagramAxisTitleViewInfo;

  TcxGridChartColumnDiagramAxisTitleViewInfo = class(TcxCustomGridChartTitleViewInfo)
  private
    FContainer: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
    function GetTitle: TcxGridChartColumnDiagramAxisTitle;
  protected
    procedure GetViewParams(var AParams: TcxViewParams); override;
    procedure InitHitTest(AHitTest: TcxCustomGridHitTest); override;
  public
    constructor Create(AContainer: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
      ATitle: TcxCustomGridChartTitle); reintroduce; virtual;
    property Container: TcxGridChartColumnDiagramTickMarkLabelsViewInfo read FContainer;
    property Title: TcxGridChartColumnDiagramAxisTitle read GetTitle;
  end;

  TcxGridChartAxisPosition = cppLeft..cppBottom;

  TcxGridChartColumnDiagramTickMarkLabelsViewInfo = class(TcxCustomGridViewCellViewInfo)
  private
    FCaptionBounds: array of TRect;
    FCaptionHeight: Integer;
    FCaptionWidths: array of Integer;
    FDiagramViewInfo: TcxGridChartColumnDiagramViewInfo;
    FIsTwoRowLayout: Boolean;
    FTitleViewInfo: TcxGridChartColumnDiagramAxisTitleViewInfo;
    function GetCaptionBounds(Index: Integer): TRect;
    function GetCaptionHeight: Integer;
    function GetCaptionWidth(Index: Integer): Integer;
    function GetDiagram: TcxGridChartColumnDiagram;
    function GetIsVertical: Boolean;
    procedure SetCaptionBounds(Index: Integer; const Value: TRect);
  protected
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass; virtual;

    function GetCaption(Index: Integer): string; virtual;
    function GetCount: Integer; virtual; abstract;
    function GetIsReverseOrder: Boolean; virtual; abstract;
    function GetValue(Index: Integer): Variant; virtual; abstract;

    function CalculateCaptionBounds(AIndex: Integer): TRect; virtual;
    procedure CalculateCaptionsBounds; virtual;
    function CalculateHeight(AWidth, ALeftReduction, ARightReduction: Integer): Integer; {overload;}reintroduce; virtual;
    function CalculateWidth: Integer; override;
    function CalculateIsTwoRowLayout(AWidth, ALeftReduction, ARightReduction: Integer): Boolean; virtual;
    procedure CalculateTitleBounds(out ATitleBounds, AContentBounds: TRect); virtual;
    function GetAlignmentHorz: TAlignment; override;
    function GetAxis: TcxGridChartColumnDiagramAxis; virtual; abstract;
    function GetCaptionPosition(Index: Integer): Integer; virtual; abstract;
    function GetCaptionsVisible: Boolean; virtual;
    procedure GetEdgeCaptionsReductions(var ALeftReduction, ARightReduction: Integer); virtual;
    function GetIsEdgeCaptions: Boolean; virtual; abstract;
    function GetPosition: TcxGridChartAxisPosition; virtual; abstract;
    function GetTextAttributes(AForPainting: Boolean): Integer; override;
    procedure GetTitleViewParams(var AParams: TcxViewParams); virtual; abstract;
    function GetVisible: Boolean; override;

    property Axis: TcxGridChartColumnDiagramAxis read GetAxis;
    property CaptionHeight: Integer read GetCaptionHeight;
    property CaptionWidths[Index: Integer]: Integer read GetCaptionWidth;
    property Diagram: TcxGridChartColumnDiagram read GetDiagram;
    property IsEdgeCaptions: Boolean read GetIsEdgeCaptions;
    property IsReverseOrder: Boolean read GetIsReverseOrder;
    property IsTwoRowLayout: Boolean read FIsTwoRowLayout write FIsTwoRowLayout;
    property IsVertical: Boolean read GetIsVertical;
  public
    constructor Create(ADiagramViewInfo: TcxGridChartColumnDiagramViewInfo); reintroduce; virtual;
    destructor Destroy; override;
    procedure Calculate(ALeftBound, ATopBound: Integer; AWidth: Integer = -1;
      AHeight: Integer = -1); override;
    procedure FitCaptionsHorz(AWidth: Integer; var ALeftReduction, ARightReduction: Integer); virtual;
    procedure FitCaptionsVert(var ATopReduction, ABottomReduction: Integer); virtual;
    function GetCaptionSpace(AWidth, ALeftReduction, ARightReduction: Integer): Integer; virtual;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property CaptionBounds[Index: Integer]: TRect read GetCaptionBounds write SetCaptionBounds;
    property Captions[Index: Integer]: string read GetCaption;
    property CaptionsVisible: Boolean read GetCaptionsVisible;
    property Count: Integer read GetCount;
    property DiagramViewInfo: TcxGridChartColumnDiagramViewInfo read FDiagramViewInfo;
    property Position: TcxGridChartAxisPosition read GetPosition;
    property TitleViewInfo: TcxGridChartColumnDiagramAxisTitleViewInfo read FTitleViewInfo;
    property Values[Index: Integer]: Variant read GetValue;
  end;

  TcxGridChartColumnDiagramCategoryAxisTitleViewInfo = class(TcxGridChartColumnDiagramAxisTitleViewInfo)
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
  end;

  TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfoClass = class of TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo;

  TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo = class(TcxGridChartColumnDiagramTickMarkLabelsViewInfo)
  protected
    function GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass; override;

    function GetCount: Integer; override;
    function GetIsReverseOrder: Boolean; override;
    function GetValue(Index: Integer): Variant; override;

    function GetAxis: TcxGridChartColumnDiagramAxis; override;
    function GetCaptionPosition(Index: Integer): Integer; override;
    function GetIsEdgeCaptions: Boolean; override;
    function GetPosition: TcxGridChartAxisPosition; override;
    procedure GetTitleViewParams(var AParams: TcxViewParams); override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridChartColumnDiagramValueAxisTitleViewInfo = class(TcxGridChartColumnDiagramAxisTitleViewInfo)
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
  end;

  TcxGridChartColumnDiagramValueTickMarkLabelsViewInfoClass = class of TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo;

  TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo = class(TcxGridChartColumnDiagramTickMarkLabelsViewInfo)
  private
    function GetAxisValue: TcxGridChartColumnDiagramAxisValue;
  protected
    function GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass; override;

    function GetCaption(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetIsReverseOrder: Boolean; override;
    function GetValue(Index: Integer): Variant; override;

    function GetAxis: TcxGridChartColumnDiagramAxis; override;
    function GetCaptionPosition(Index: Integer): Integer; override;
    function GetIsEdgeCaptions: Boolean; override;
    function GetPosition: TcxGridChartAxisPosition; override;
    procedure GetTitleViewParams(var AParams: TcxViewParams); override;
    procedure GetViewParams(var AParams: TcxViewParams); override;

    property Axis: TcxGridChartColumnDiagramAxisValue read GetAxisValue;
  end;

  TcxGridChartColumnDiagramValueViewInfo = class(TcxGridChartDiagramValueViewInfo)
  private
    function GetCaptionPosition: TcxGridChartColumnDiagramValueCaptionPosition;
    function GetDiagramViewInfo: TcxGridChartColumnDiagramViewInfo;
  protected
    function CalculateCaptionBounds: TRect; override;
    function GetBorderColor(AIndex: TcxBorder): TColor; override;
    function GetBorders: TcxBorders; override;
    function GetBorderWidth(AIndex: TcxBorder): Integer; override;
    procedure GetCaptionViewParams(var AParams: TcxViewParams); override;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
    function HasCaption: Boolean; override;
  public
    property CaptionPosition: TcxGridChartColumnDiagramValueCaptionPosition read GetCaptionPosition;
    property DiagramViewInfo: TcxGridChartColumnDiagramViewInfo read GetDiagramViewInfo;
  end;

  TcxGridChartColumnDiagramMark = record
    Value: Variant;
    Position: Integer;
  end;
  TcxGridChartColumnDiagramMarks = array of TcxGridChartColumnDiagramMark;

  TcxGridChartColumnDiagramViewInfo = class(TcxGridChartDiagramViewInfo)
  private
    FCategoryTickMarkLabelsViewInfo: TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo;
    FCategoryMarkHeight: Integer;
    FCategoryMarks: TcxGridChartColumnDiagramMarks;
    FIsPlotBoundsCalculated: Boolean;
    FMinValue: Extended;
    FMaxValue: Extended;
    FMinVisualValue: Extended;
    FMaxVisualValue: Extended;
    FPlotBounds: TRect;
    FValueTickMarkLabelsViewInfo: TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo;
    FValueMarkHeight: Integer;
    FValueMarks: TcxGridChartColumnDiagramMarks;
    FValueStep: Extended;
    function GetCategoryAxisColor: TColor;
    function GetCategoryGridLineColor: TColor;
    function GetCategoryMarkCount: Integer;
    function GetCategoryMarkPosition(Index: Integer): Integer;
    function GetCategoryMarkValue(Index: Integer): Integer;
    function GetDiagram: TcxGridChartColumnDiagram;
    function GetHasCategoryAxis: Boolean;
    function GetHasCategoryGridLines: Boolean;
    function GetHasValueAxis: Boolean;
    function GetHasValueGridLines: Boolean;
    function GetIsCategoriesInReverseOrder: Boolean;
    function GetIsCategoryAxisHorz: Boolean;
    function GetIsValueAxisVert: Boolean;
    function GetPlotBounds: TRect;
    function GetValueAxisColor: TColor;
    function GetValueGridLineColor: TColor;
    function GetValueMarkCount: Integer;
    function GetValueMarkPosition(Index: Integer): Integer;
    function GetValueMarkValue(Index: Integer): Extended;
    function GetZeroValueOffset: Integer;
    procedure SetCategoryMarkPosition(Index: Integer; Value: Integer);
    procedure SetValueMarkPosition(Index: Integer; Value: Integer);
  protected
    function GetCategoryTickMarkLabelsViewInfoClass: TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfoClass; virtual;
    function GetPainterClass: TcxCustomGridCellPainterClass; override;
    function GetValueTickMarkLabelsViewInfoClass: TcxGridChartColumnDiagramValueTickMarkLabelsViewInfoClass; virtual;

    function GetValueViewInfoClass: TcxGridChartDiagramValueViewInfoClass; override;

    procedure DoCalculateParams; override;
    procedure GetPlotBackgroundParams(out AParams: TcxViewParams); virtual;

    function GetUnitCount: Integer; virtual;
    function GetUnitOffset(AIndex: Integer): Integer; virtual;
    function GetValueGroupAreaSizeUnits: Integer; virtual;
    function GetValueOffsetUnits(AValueIndex, ASeriesIndex: Integer): Integer; virtual;

    procedure CalculateMinMaxValues(out AMinValue, AMaxValue: Extended); virtual;
    procedure CalculateMinMaxVisualValues(out AMinVisualValue, AMaxVisualValue: Extended); virtual;
    function CalculateValueStep: Extended; virtual;
    function GetValueOffset(const AValue: Variant): Integer; virtual;
    function IsDataInteger: Boolean;
    function IsValuePositive(AValueIndex, ASeriesIndex: Integer): Boolean; virtual;

    procedure AddMark(var AMarks: TcxGridChartColumnDiagramMarks; const AValue: Variant);

    procedure AddCategoryMark(AValue: Integer);
    procedure CalculateCategoryMarkPositions;
    function CalculateCategoryMarkValue(AIndex: Integer; AValueAxisBetweenCategories: Boolean): Integer; virtual;
    procedure CalculateCategoryMarkValues; virtual;

    procedure AddValueMark(const AValue: Extended);
    procedure CalculateValueMarkPositions;
    procedure CalculateValueMarkValues; virtual;

    function CalculateCategoryMarkHeight: Integer; virtual;
    function CalculateValueMarkHeight: Integer; virtual;
    function CalculatePlotBounds: TRect; virtual;
    function GetCategoryAxisBounds: TRect; virtual;
    function GetCategoryAxisPosition: TcxGridChartAxisPosition; virtual;
    function GetCategoryGridLineBounds(AIndex: Integer): TRect; virtual;
    function GetCategoryMarkBounds(Index: Integer): TRect; virtual;
    function GetCategoryTickMarkLabelsBounds: TRect; virtual;
    function GetTickMarkLabelsBounds(APosition: TcxGridChartAxisPosition): TRect; virtual;
    function GetValueAxisBounds: TRect; virtual;
    function GetValueAxisPosition: TcxGridChartAxisPosition; virtual;
    function GetValueBounds(AValueIndex, ASeriesIndex: Integer): TRect; virtual;
    function GetValueGridLineBounds(AIndex: Integer): TRect; virtual;
    function GetValueMarkBounds(Index: Integer): TRect; virtual;
    function GetValueTickMarkLabelsBounds: TRect; virtual;

    function CustomDrawPlot(ACanvas: TcxCanvas): Boolean; virtual;
    function DoCustomDrawPlot(ACanvas: TcxCanvas): Boolean; virtual;
    function HasCustomDrawPlot: Boolean; virtual;

    property CategoryMarkHeight: Integer read FCategoryMarkHeight;
    property CategoryMarkValues[Index: Integer]: Integer read GetCategoryMarkValue;
    property IsCategoriesInReverseOrder: Boolean read GetIsCategoriesInReverseOrder;
    property IsCategoryAxisHorz: Boolean read GetIsCategoryAxisHorz;
    property IsValueAxisVert: Boolean read GetIsValueAxisVert;
    property MinValue: Extended read FMinValue;
    property MaxValue: Extended read FMaxValue;
    property MinVisualValue: Extended read FMinVisualValue;
    property MaxVisualValue: Extended read FMaxVisualValue;
    property UnitCount: Integer read GetUnitCount;
    property ValueMarkHeight: Integer read FValueMarkHeight;
    property ValueMarkValues[Index: Integer]: Extended read GetValueMarkValue;
    property ValueStep: Extended read FValueStep;
    property ZeroValueOffset: Integer read GetZeroValueOffset;
  public
    PlotParams: TcxViewParams;
    constructor Create(AGridViewInfo: TcxCustomGridViewInfo; ADiagram: TcxGridChartDiagram); override;
    destructor Destroy; override;
    procedure Calculate(const ABounds: TRect); override;
    function GetHitTest(const P: TPoint): TcxCustomGridHitTest; override;

    property CategoryAxisColor: TColor read GetCategoryAxisColor;
    property CategoryAxisBounds: TRect read GetCategoryAxisBounds;
    property CategoryAxisPosition: TcxGridChartAxisPosition read GetCategoryAxisPosition;
    property CategoryGridLineBounds[AIndex: Integer]: TRect read GetCategoryGridLineBounds;
    property CategoryGridLineColor: TColor read GetCategoryGridLineColor;
    property CategoryMarkBounds[Index: Integer]: TRect read GetCategoryMarkBounds;
    property CategoryTickMarkLabelsViewInfo: TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo read FCategoryTickMarkLabelsViewInfo;
    property CategoryMarkCount: Integer read GetCategoryMarkCount;
    property CategoryMarkPositions[Index: Integer]: Integer read GetCategoryMarkPosition write SetCategoryMarkPosition;
    property Diagram: TcxGridChartColumnDiagram read GetDiagram;
    property HasCategoryAxis: Boolean read GetHasCategoryAxis;
    property HasCategoryGridLines: Boolean read GetHasCategoryGridLines;
    property HasValueAxis: Boolean read GetHasValueAxis;
    property HasValueGridLines: Boolean read GetHasValueGridLines;
    property PlotBounds: TRect read GetPlotBounds;
    property ValueAxisBounds: TRect read GetValueAxisBounds;
    property ValueAxisColor: TColor read GetValueAxisColor;
    property ValueAxisPosition: TcxGridChartAxisPosition read GetValueAxisPosition;
    property ValueGridLineBounds[AIndex: Integer]: TRect read GetValueGridLineBounds;
    property ValueGridLineColor: TColor read GetValueGridLineColor;
    property ValueMarkBounds[Index: Integer]: TRect read GetValueMarkBounds;
    property ValueTickMarkLabelsViewInfo: TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo read FValueTickMarkLabelsViewInfo;
    property ValueMarkCount: Integer read GetValueMarkCount;
    property ValueMarkPositions[Index: Integer]: Integer read GetValueMarkPosition write SetValueMarkPosition;
  end;

  // view

  TcxGridChartTitleViewInfoClass = class of TcxGridChartTitleViewInfo;

  TcxGridChartTitleViewInfo = class(TcxCustomGridChartTitleViewInfo)
  protected
    function GetHitTestClass: TcxCustomGridHitTestClass; override;
    procedure GetViewParams(var AParams: TcxViewParams); override;
  end;

  TcxGridChartViewInfo = class(TcxCustomGridViewInfo)
  private
    FDiagramViewInfo: TcxGridChartDiagramViewInfo;
    FLegendViewInfo: TcxGridChartLegendViewInfo;
    FTitleViewInfo: TcxGridChartTitleViewInfo;
    function GetGridView: TcxGridChartView;
  protected
    procedure CreateViewInfos; override;
    procedure DestroyViewInfos(AIsRecreating: Boolean); override;

    function GetTitleViewInfoClass: TcxGridChartTitleViewInfoClass; virtual;

    procedure Calculate; override;
    function CalculateClientBounds: TRect; override;
    procedure CalculateHeight(const AMaxSize: TPoint; var AHeight: Integer;
      var AFullyVisible: Boolean); override;
    procedure CalculatePartBounds(APart: TcxCustomGridChartPartViewInfo;
      var ABounds, APartBounds: TRect); virtual;
    procedure CalculatePartsBounds(out ADiagramBounds, ALegendBounds, ATitleBounds: TRect); virtual;
    function DoGetHitTest(const P: TPoint): TcxCustomGridHitTest; override;
  public
    property DiagramViewInfo: TcxGridChartDiagramViewInfo read FDiagramViewInfo;
    property GridView: TcxGridChartView read GetGridView;
    property LegendViewInfo: TcxGridChartLegendViewInfo read FLegendViewInfo;
    property TitleViewInfo: TcxGridChartTitleViewInfo read FTitleViewInfo;
  end;

  { view }

  // custom title

  TcxCustomGridChartTitle = class(TcxCustomGridOptions)
  private
    FAlignment: TcxGridChartPartAlignment;
    FPosition: TcxGridChartPartPosition;
    FText: string;
    procedure SetAlignment(Value: TcxGridChartPartAlignment);
    procedure SetPosition(Value: TcxGridChartPartPosition);
    procedure SetText(Value: string);
  protected
    function GetDefaultAlignment: TcxGridChartPartAlignment; virtual;
    function GetDefaultOrientation: TcxGridChartPartOrientation; virtual;
    function GetDefaultPosition: TcxGridChartPartPosition; virtual; abstract;

    property Position: TcxGridChartPartPosition read FPosition write SetPosition default cppDefault;
  public
    procedure Assign(Source: TPersistent); override;
    function GetAlignment: TcxGridChartPartAlignment;
    function GetOrientation: TcxGridChartPartOrientation;
    function GetPosition: TcxGridChartPartPosition;
  published
    property Alignment: TcxGridChartPartAlignment read FAlignment write SetAlignment default cpaDefault;
    property Text: string read FText write SetText;
  end;

  // legend

  TcxGridChartLegendBorder = (lbDefault, lbNone, lbSingle);

  TcxGridChartLegendClass = class of TcxGridChartLegend;

  TcxGridChartLegend = class(TcxCustomGridOptions)
  private
    FAlignment: TcxGridChartPartAlignment;
    FBorder: TcxGridChartLegendBorder;
    FKeyBorder: TcxGridChartLegendBorder;
    FOrientation: TcxGridChartPartOrientation;
    FParent: TcxGridChartLegend;
    FPosition: TcxGridChartPartPosition;
    procedure SetAlignment(Value: TcxGridChartPartAlignment);
    procedure SetBorder(Value: TcxGridChartLegendBorder);
    procedure SetKeyBorder(Value: TcxGridChartLegendBorder);
    procedure SetOrientation(Value: TcxGridChartPartOrientation);
    procedure SetPosition(Value: TcxGridChartPartPosition);
  protected
    function GetDefaultAlignment: TcxGridChartPartAlignment; virtual;
    function GetDefaultBorder: TcxGridChartLegendBorder; virtual;
    function GetDefaultKeyBorder: TcxGridChartLegendBorder; virtual;
    function GetDefaultOrientation(APosition: TcxGridChartPartPosition): TcxGridChartPartOrientation; virtual;
    function GetDefaultPosition: TcxGridChartPartPosition; virtual;
    property Parent: TcxGridChartLegend read FParent write FParent;
  public
    procedure Assign(Source: TPersistent); override;
    function GetAlignment: TcxGridChartPartAlignment;
    function GetBorder: TcxGridChartLegendBorder;
    function GetKeyBorder: TcxGridChartLegendBorder;
    function GetOrientation(APosition: TcxGridChartPartPosition = cppDefault): TcxGridChartPartOrientation;
    function GetPosition: TcxGridChartPartPosition;
  published
    property Alignment: TcxGridChartPartAlignment read FAlignment write SetAlignment default cpaDefault;
    property Border: TcxGridChartLegendBorder read FBorder write SetBorder default lbDefault;
    property KeyBorder: TcxGridChartLegendBorder read FKeyBorder write SetKeyBorder default lbDefault;
    property Orientation: TcxGridChartPartOrientation read FOrientation
      write SetOrientation default cpoDefault;
    property Position: TcxGridChartPartPosition read FPosition write SetPosition default cppDefault;
  end;

  // diagram

  TcxGridDiagramChange = (dcProperty, dcLayout, dcSize);

  TcxCustomGridChartDiagramOptions = class(TPersistent)
  private
    FDiagram: TcxGridChartDiagram;
    function GetGridView: TcxGridChartView;
    function GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
  protected
    procedure Changed(AChange: TcxGridDiagramChange = dcLayout); virtual;
    property LookAndFeelPainter: TcxCustomLookAndFeelPainterClass read GetLookAndFeelPainter;
  public
    constructor Create(ADiagram: TcxGridChartDiagram); virtual;
    procedure Assign(Source: TPersistent); override;
    property Diagram: TcxGridChartDiagram read FDiagram;
    property GridView: TcxGridChartView read GetGridView;
  end;

  TcxGridChartDiagramStylesClass = class of TcxGridChartDiagramStyles;

  TcxGridChartDiagramStyles = class(TcxCustomGridStyles)
  private
    function GetDiagram: TcxGridChartDiagram;
    function GetGridViewValue: TcxGridChartView;
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
    function GetVaryColorsByCategory: Boolean; virtual; abstract;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure GetBackgroundParams(out AParams: TcxViewParams); virtual;
    procedure GetValueParams(AVisibleSeriesIndex, AValueIndex: Integer;
      out AParams: TcxViewParams); virtual;
    procedure Assign(Source: TPersistent); override;
    property Diagram: TcxGridChartDiagram read GetDiagram;
    property GridView: TcxGridChartView read GetGridViewValue;
  published
    property Legend: TcxStyle index dsLegend read GetValue write SetValue;
    property ValueCaptions: TcxStyle index dsValueCaptions read GetValue write SetValue;
    property Values: TcxStyle index dsValues read GetValue write SetValue;
  end;

  TcxGridChartDiagramLegendCustomDrawEvent = procedure(Sender: TcxGridChartDiagram;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendViewInfo; var ADone: Boolean) of object;
  TcxGridChartDiagramLegendItemCustomDrawEvent = procedure(Sender: TcxGridChartDiagram;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean) of object;
  TcxGridChartDiagramValueCustomDrawEvent = procedure(Sender: TcxGridChartDiagram;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean) of object;

  TcxGridChartDiagramClass = class of TcxGridChartDiagram;

  TcxGridChartDiagram = class(TPersistent)
  private
    FEnabled: Boolean;
    FGridView: TcxGridChartView;
    FLegend: TcxGridChartLegend;
    FStyles: TcxGridChartDiagramStyles;
    FOnCustomDrawLegend: TcxGridChartDiagramLegendCustomDrawEvent;
    FOnCustomDrawLegendItem: TcxGridChartDiagramLegendItemCustomDrawEvent;
    FOnCustomDrawValue: TcxGridChartDiagramValueCustomDrawEvent;
    function GetActive: Boolean;
    procedure SetActive(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetLegend(Value: TcxGridChartLegend);
    procedure SetStyles(Value: TcxGridChartDiagramStyles);
    procedure SetOnCustomDrawLegend(Value: TcxGridChartDiagramLegendCustomDrawEvent);
    procedure SetOnCustomDrawLegendItem(Value: TcxGridChartDiagramLegendItemCustomDrawEvent);
    procedure SetOnCustomDrawValue(Value: TcxGridChartDiagramValueCustomDrawEvent);
  protected
    function GetOwner: TPersistent; override;

    procedure CreateSubObjects(AGridView: TcxGridChartView); virtual;
    procedure DestroySubObjects; virtual;
    procedure SetGridView(Value: TcxGridChartView);

    function GetStylesClass: TcxGridChartDiagramStylesClass; virtual;

    function GetLegendViewInfoClass: TcxGridChartLegendViewInfoClass; virtual; abstract;
    function GetViewInfoClass: TcxGridChartDiagramViewInfoClass; virtual; abstract;

    procedure Changed(AChange: TcxGridDiagramChange = dcLayout); virtual;
    function GetDisplayText: string; virtual;

    procedure DoCustomDrawLegend(ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawLegendItem(ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawValue(ACanvas: TcxCanvas; AViewInfo: TcxGridChartDiagramValueViewInfo;
      var ADone: Boolean); virtual;
    function HasCustomDrawLegend: Boolean; virtual;
    function HasCustomDrawLegendItem: Boolean; virtual;
    function HasCustomDrawValue: Boolean; virtual;

    property Styles: TcxGridChartDiagramStyles read FStyles write SetStyles;
  public
    constructor Create(AGridView: TcxGridChartView); virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetNamePath: string; override;
    function GetValueCaption(ASeries: TcxGridChartSeries; AValueIndex: Integer): string; virtual;
    property DisplayText: string read GetDisplayText;
    property GridView: TcxGridChartView read FGridView;
  published
    property Active: Boolean read GetActive write SetActive default False;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Legend: TcxGridChartLegend read FLegend write SetLegend;
    property OnCustomDrawLegend: TcxGridChartDiagramLegendCustomDrawEvent read FOnCustomDrawLegend
      write SetOnCustomDrawLegend;
    property OnCustomDrawLegendItem: TcxGridChartDiagramLegendItemCustomDrawEvent
      read FOnCustomDrawLegendItem write SetOnCustomDrawLegendItem;
    property OnCustomDrawValue: TcxGridChartDiagramValueCustomDrawEvent read FOnCustomDrawValue
      write SetOnCustomDrawValue;
  end;

  // column diagram

  TcxGridChartColumnDiagramAxisTitleClass = class of TcxGridChartColumnDiagramAxisTitle;

  TcxGridChartColumnDiagramAxisTitle = class(TcxCustomGridChartTitle)
  private
    FAxis: TcxGridChartColumnDiagramAxis;
  protected
    function GetDefaultPosition: TcxGridChartPartPosition; override;
    function GetGridViewValue: TcxCustomGridView; override;
  public
    constructor Create(AAxis: TcxGridChartColumnDiagramAxis); reintroduce; virtual;
    property Axis: TcxGridChartColumnDiagramAxis read FAxis;
  end;

  TcxGridChartHistogramTickMarkKind = (tmkNone, tmkCross, tmkInside, tmkOutside);

  TcxGridChartColumnDiagramAxis = class(TcxCustomGridChartDiagramOptions)
  private
    FGridLines: Boolean;
    FTickMarkKind: TcxGridChartHistogramTickMarkKind;
    FTickMarkLabels: Boolean;
    FTitle: TcxGridChartColumnDiagramAxisTitle;
    FVisible: Boolean;
    function GetDiagram: TcxGridChartColumnDiagram;
    procedure SetGridLines(Value: Boolean);
    procedure SetTickMarkKind(Value: TcxGridChartHistogramTickMarkKind);
    procedure SetTickMarkLabels(Value: Boolean);
    procedure SetTitle(Value: TcxGridChartColumnDiagramAxisTitle);
    procedure SetVisible(Value: Boolean);
  protected
    function GetTitleClass: TcxGridChartColumnDiagramAxisTitleClass; virtual;
  public
    constructor Create(ADiagram: TcxGridChartDiagram); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetPosition: TcxGridChartAxisPosition; virtual; abstract;
    property Diagram: TcxGridChartColumnDiagram read GetDiagram;
  published
    property GridLines: Boolean read FGridLines write SetGridLines default True;
    property TickMarkKind: TcxGridChartHistogramTickMarkKind read FTickMarkKind
      write SetTickMarkKind default tmkOutside;
    property TickMarkLabels: Boolean read FTickMarkLabels write SetTickMarkLabels default True;
    property Title: TcxGridChartColumnDiagramAxisTitle read FTitle write SetTitle;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  TcxGridChartColumnDiagramAxisCategoryClass = class of TcxGridChartColumnDiagramAxisCategory;

  TcxGridChartColumnDiagramAxisCategory = class(TcxGridChartColumnDiagramAxis)
  private
    FCategoriesInReverseOrder: Boolean;
    FValueAxisAtMaxCategory: Boolean;
    FValueAxisBetweenCategories: Boolean;
    procedure SetCategoriesInReverseOrder(Value: Boolean);
    procedure SetValueAxisAtMaxCategory(Value: Boolean);
    procedure SetValueAxisBetweenCategories(Value: Boolean);
  public
    constructor Create(ADiagram: TcxGridChartDiagram); override;
    procedure Assign(Source: TPersistent); override;
    function GetPosition: TcxGridChartAxisPosition; override;
  published
    property CategoriesInReverseOrder: Boolean read FCategoriesInReverseOrder
      write SetCategoriesInReverseOrder default False;
    property ValueAxisAtMaxCategory: Boolean read FValueAxisAtMaxCategory
      write SetValueAxisAtMaxCategory default False;
    property ValueAxisBetweenCategories: Boolean read FValueAxisBetweenCategories
      write SetValueAxisBetweenCategories default True;
  end;

  TcxGridChartColumnDiagramAxisValueClass = class of TcxGridChartColumnDiagramAxisValue;

  TcxGridChartColumnDiagramAxisValue = class(TcxGridChartColumnDiagramAxis)
  private
    FTickMarkLabelFormat: string;
    procedure SetTickMarkLabelFormat(const Value: string);
  public
    procedure Assign(Source: TPersistent); override;
    function GetPosition: TcxGridChartAxisPosition; override;
    function GetTickMarkLabel(const ATickMarkValue: Variant): string; virtual;
    function GetTickMarkLabelFormat: string; virtual;
  published
    property TickMarkLabelFormat: string read FTickMarkLabelFormat write SetTickMarkLabelFormat;
  end;

  TcxGridChartColumnDiagramStyles = class(TcxGridChartDiagramStyles)
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetVaryColorsByCategory: Boolean; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Axis: TcxStyle index dsAxis read GetValue write SetValue;
    property AxisTitle: TcxStyle index dsAxisTitle read GetValue write SetValue;
    property CategoryAxis: TcxStyle index dsCategoryAxis read GetValue write SetValue;
    property CategoryAxisTitle: TcxStyle index dsCategoryAxisTitle read GetValue write SetValue;
    property CategoryGridLines: TcxStyle index dsCategoryGridLines read GetValue write SetValue;
    property GridLines: TcxStyle index dsGridLines read GetValue write SetValue;
    property Plot: TcxStyle index dsPlot read GetValue write SetValue;
    property ValueAxis: TcxStyle index dsValueAxis read GetValue write SetValue;
    property ValueAxisTitle: TcxStyle index dsValueAxisTitle read GetValue write SetValue;
    property ValueGridLines: TcxStyle index dsValueGridLines read GetValue write SetValue;
  end;

  TcxGridChartColumnDiagramValuesClass = class of TcxGridChartColumnDiagramValues;

  TcxGridChartColumnDiagramValues = class(TcxCustomGridChartDiagramOptions)
  private
    FBorderWidth: Integer;
    FCaptionPosition: TcxGridChartColumnDiagramValueCaptionPosition;
    FVaryColorsByCategory: Boolean;
    procedure SetBorderWidth(Value: Integer);
    procedure SetCaptionPosition(Value: TcxGridChartColumnDiagramValueCaptionPosition);
    procedure SetVaryColorsByCategory(Value: Boolean);
  public
    constructor Create(ADiagram: TcxGridChartDiagram); override;
    procedure Assign(Source: TPersistent); override;
    function GetVaryColorsByCategory: Boolean; virtual;
  published
    property CaptionPosition: TcxGridChartColumnDiagramValueCaptionPosition read FCaptionPosition
      write SetCaptionPosition default cdvcpNone;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth default cxGridChartColumnDiagramDefaultBorderWidth;
    property VaryColorsByCategory: Boolean read FVaryColorsByCategory write SetVaryColorsByCategory default False;
  end;

  TcxGridChartColumnDiagramPlotCustomDrawEvent = procedure(Sender: TcxGridChartColumnDiagram;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartColumnDiagramViewInfo;
    const ABounds: TRect; var ADone: Boolean) of object;

  TcxGridChartColumnDiagramClass = class of TcxGridChartColumnDiagram;

  TcxGridChartColumnDiagram = class(TcxGridChartDiagram)
  private
    FAxisCategory: TcxGridChartColumnDiagramAxisCategory;
    FAxisValue: TcxGridChartColumnDiagramAxisValue;
    FValues: TcxGridChartColumnDiagramValues;
    FOnCustomDrawPlot: TcxGridChartColumnDiagramPlotCustomDrawEvent;
    function GetStyles: TcxGridChartColumnDiagramStyles;
    procedure SetAxisCategory(Value: TcxGridChartColumnDiagramAxisCategory);
    procedure SetAxisValue(Value: TcxGridChartColumnDiagramAxisValue);
    procedure SetStyles(Value: TcxGridChartColumnDiagramStyles);
    procedure SetValues(Value: TcxGridChartColumnDiagramValues);
    procedure SetOnCustomDrawPlot(Value: TcxGridChartColumnDiagramPlotCustomDrawEvent);
  protected
    procedure CreateSubObjects(AGridView: TcxGridChartView); override;
    procedure DestroySubObjects; override;

    function GetAxisCategoryClass: TcxGridChartColumnDiagramAxisCategoryClass; virtual;
    function GetAxisValueClass: TcxGridChartColumnDiagramAxisValueClass; virtual;
    function GetStylesClass: TcxGridChartDiagramStylesClass; override;
    function GetValuesClass: TcxGridChartColumnDiagramValuesClass; virtual;

    function GetLegendViewInfoClass: TcxGridChartLegendViewInfoClass; override;
    function GetViewInfoClass: TcxGridChartDiagramViewInfoClass; override;

    procedure DoCustomDrawPlot(ACanvas: TcxCanvas; AViewInfo: TcxGridChartColumnDiagramViewInfo;
      const ABounds: TRect; var ADone: Boolean); virtual;
    function HasCustomDrawPlot: Boolean; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    function GetCategoryAxisPosition: TcxGridChartAxisPosition; virtual;
    function GetValueAxisPosition: TcxGridChartAxisPosition; virtual;
  published
    property AxisCategory: TcxGridChartColumnDiagramAxisCategory read FAxisCategory write SetAxisCategory;
    property AxisValue: TcxGridChartColumnDiagramAxisValue read FAxisValue write SetAxisValue;
    property Styles: TcxGridChartColumnDiagramStyles read GetStyles write SetStyles;
    property Values: TcxGridChartColumnDiagramValues read FValues write SetValues;
    property OnCustomDrawPlot: TcxGridChartColumnDiagramPlotCustomDrawEvent read FOnCustomDrawPlot  
      write SetOnCustomDrawPlot;
  end;

  // bar diagram

  TcxGridChartBarDiagramClass = class of TcxGridChartBarDiagram;

  TcxGridChartBarDiagram = class(TcxGridChartColumnDiagram)
  public
    function GetCategoryAxisPosition: TcxGridChartAxisPosition; override;
    function GetValueAxisPosition: TcxGridChartAxisPosition; override;
  end;

  // chart item data binding

  TcxGridChartItemDataBindingClass = class of TcxGridChartItemDataBinding;

  TcxGridChartItemDataBinding = class(TPersistent)
  private
    FData: TObject;
    FDataField: TcxCustomDataField;
    FDefaultValueTypeClass: TcxValueTypeClass;
    FGridView: TcxGridChartView;
    FID: Integer;
    FIsValue: Boolean;
    function GetDataController: TcxCustomDataController;
    function GetDataIndex: Integer;
    function GetSortOrder: TcxDataSortOrder;
    function GetValueType: string;
    function GetValueTypeClass: TcxValueTypeClass;
    procedure SetData(Value: TObject);
    procedure SetDataField(Value: TcxCustomDataField);
    procedure SetSortOrder(Value: TcxDataSortOrder);
    procedure SetValueType(const Value: string);
    procedure SetValueTypeClass(Value: TcxValueTypeClass);
  protected
    function GetDefaultValueTypeClass: TcxValueTypeClass; virtual;
    function IsValueTypeInteger: Boolean;
    function IsValueTypeStored: Boolean; virtual;

    property DataField: TcxCustomDataField read FDataField write SetDataField;
    property ID: Integer read FID write FID;
    property IsValue: Boolean read FIsValue;
    property SortOrder: TcxDataSortOrder read GetSortOrder write SetSortOrder;
  public
    constructor Create(AGridView: TcxGridChartView; AIsValue: Boolean;
      ADefaultValueTypeClass: TcxValueTypeClass); virtual;
    procedure Assign(Source: TPersistent); override;
    function IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean; virtual;
    property Data: TObject read FData write SetData;
    property DataIndex: Integer read GetDataIndex;
    property DataController: TcxCustomDataController read GetDataController;
    property GridView: TcxGridChartView read FGridView;
    property ValueTypeClass: TcxValueTypeClass read GetValueTypeClass write SetValueTypeClass;
  published
    property ValueType: string read GetValueType write SetValueType stored IsValueTypeStored;
  end;

  // categories

  TcxGridChartCategoriesClass = class of TcxGridChartCategories;

  TcxGridChartCategories = class(TcxCustomGridOptions)
  private
    FDataBinding: TcxGridChartItemDataBinding;
    function GetGridView: TcxGridChartView;
    function GetID: Integer;
    function GetSortOrder: TcxDataSortOrder;
    function GetValue(Index: Integer): Variant;
    function GetValueCount: Integer;
    procedure SetDataBinding(Value: TcxGridChartItemDataBinding);
    procedure SetSortOrder(Value: TcxDataSortOrder);
    procedure SetValue(Index: Integer; const Value: Variant);
    procedure SetValueCount(Value: Integer);
  protected
    function GetDefaultValueTypeClass: TcxValueTypeClass; virtual;
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property GridView: TcxGridChartView read GetGridView;
    property ID: Integer read GetID;
    property ValueCount: Integer read GetValueCount write SetValueCount;
    property Values[Index: Integer]: Variant read GetValue write SetValue; default;
  published
    property DataBinding: TcxGridChartItemDataBinding read FDataBinding
      write SetDataBinding;
    property SortOrder: TcxDataSortOrder read GetSortOrder write SetSortOrder default soNone;
  end;

  // series

  TcxGridChartSeriesGetValueStyleEvent = procedure(Sender: TcxGridChartSeries;
    AValueIndex: Integer; var AStyle: TcxStyle) of object;

  TcxGridChartSeriesStylesClass = class of TcxGridChartSeriesStyles;

  TcxGridChartSeriesStyles = class(TcxCustomGridStyles)
  private
    FOnGetValueStyle: TcxGridChartSeriesGetValueStyleEvent;
    function GetSeries: TcxGridChartSeries;
    procedure SetOnGetValueStyle(Value: TcxGridChartSeriesGetValueStyleEvent);
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
    function GetGridView: TcxCustomGridView; override;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
    procedure GetValueParams(AValueIndex: Integer; AVaryColorsByCategory: Boolean;
      out AParams: TcxViewParams); virtual;
    property Series: TcxGridChartSeries read GetSeries;
  published
    property Values: TcxStyle index ssValues read GetValue write SetValue;
    property OnGetValueStyle: TcxGridChartSeriesGetValueStyleEvent read FOnGetValueStyle
      write SetOnGetValueStyle;
  end;

  TcxGridChartSeriesValueCustomDrawEvent = procedure(Sender: TcxGridChartSeries;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean) of object;

  TcxGridChartSeriesClass = class of TcxGridChartSeries;

  TcxGridChartSeries = class(TcxComponent)
  private
    FDataBinding: TcxGridChartItemDataBinding;
    FDisplayText: string;
    FGridView: TcxGridChartView;
    FStyles: TcxGridChartSeriesStyles;
    FValueCaptionFormat: string;
    FVisible: Boolean;
    FVisibleIndex: Integer;
    FOnCustomDrawValue: TcxGridChartSeriesValueCustomDrawEvent;
    function GetID: Integer;
    function GetIndex: Integer;
    function GetSortOrder: TcxDataSortOrder;
    function GetTag: TcxTag;
    function GetValue(AIndex: Integer): Variant;
    function GetValueCount: Integer;
    procedure SetDataBinding(Value: TcxGridChartItemDataBinding);
    procedure SetDisplayText(const Value: string);
    procedure SetIndex(Value: Integer);
    procedure SetSortOrder(Value: TcxDataSortOrder);
    procedure SetStyles(Value: TcxGridChartSeriesStyles);
    procedure SetTag(Value: TcxTag);
    procedure SetValue(AIndex: Integer; const Value: Variant);
    procedure SetValueCaptionFormat(const Value: string);
    procedure SetValueCount(Value: Integer);
    procedure SetVisible(Value: Boolean);
    procedure SetOnCustomDrawValue(Value: TcxGridChartSeriesValueCustomDrawEvent);
    function IsTagStored: Boolean;
  protected
    FSubObjectEvents: TNotifyEvent;
    procedure SetParentComponent(AParent: TComponent); override;

    procedure Changed(AChange: TcxGridViewChangeKind = vcLayout); virtual;
    function GetDefaultDisplayText: string; virtual;
    function GetDefaultValueTypeClass: TcxValueTypeClass; virtual;
    function GetStylesClass: TcxGridChartSeriesStylesClass; virtual;
    procedure SetGridView(Value: TcxGridChartView);
    procedure SetName(const NewName: TComponentName); override;

    procedure DoCustomDrawValue(ACanvas: TcxCanvas; AViewInfo: TcxGridChartDiagramValueViewInfo;
      var ADone: Boolean); virtual;
    function HasCustomDrawValue: Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetParentComponent: TComponent; override;
    function HasParent: Boolean; override;

    function AddValue(const AValue: Variant): Integer;
    function GetDisplayText: string; virtual;
    function GetValueCaption(AIndex: Integer): string; virtual;

    property GridView: TcxGridChartView read FGridView;
    property ID: Integer read GetID;
    property Index: Integer read GetIndex write SetIndex;
    property ValueCount: Integer read GetValueCount write SetValueCount;
    property Values[AIndex: Integer]: Variant read GetValue write SetValue; default;
    property VisibleIndex: Integer read FVisibleIndex;
  published
    property DataBinding: TcxGridChartItemDataBinding read FDataBinding
      write SetDataBinding;
    property DisplayText: string read FDisplayText write SetDisplayText;
    property SortOrder: TcxDataSortOrder read GetSortOrder write SetSortOrder default soNone;
    property Styles: TcxGridChartSeriesStyles read FStyles write SetStyles;
    property Tag: TcxTag read GetTag write SetTag stored IsTagStored;
    property ValueCaptionFormat: string read FValueCaptionFormat write SetValueCaptionFormat;
    property Visible: Boolean read FVisible write SetVisible default True;

    property StylesEvents: TNotifyEvent read FSubObjectEvents write FSubObjectEvents; 

    property OnCustomDrawValue: TcxGridChartSeriesValueCustomDrawEvent read FOnCustomDrawValue
      write SetOnCustomDrawValue;
  end;

  // view title

  TcxGridChartTitleClass = class of TcxGridChartTitle;

  TcxGridChartTitle = class(TcxCustomGridChartTitle)
  protected
    function GetDefaultPosition: TcxGridChartPartPosition; override;
  published
    property Position;
  end;

  // view

  TcxGridChartOptionsBehavior = class(TcxCustomGridOptionsBehavior)
  private
    FValueHints: Boolean;
    procedure SetValueHints(Value: Boolean);
  public
    constructor Create(AGridView: TcxCustomGridView); override;
    procedure Assign(Source: TPersistent); override;
  published
    property ValueHints: Boolean read FValueHints write SetValueHints default True;
  end;

  TcxGridChartViewStyles = class(TcxCustomGridViewStyles)
  protected
    procedure GetDefaultViewParams(Index: Integer; AData: TObject; out AParams: TcxViewParams); override;
  public
    constructor Create(AOwner: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Legend: TcxStyle index vsLegend read GetValue write SetValue;
    property Title: TcxStyle index vsTitle read GetValue write SetValue;
  end;

  TcxGridChartDiagramEvent = procedure(Sender: TcxGridChartView; ADiagram: TcxGridChartDiagram) of object;
  TcxGridChartGetValueHintEvent = procedure(Sender: TcxGridChartView;
    ASeries: TcxGridChartSeries; AValueIndex: Integer; var AHint: string) of object;
  TcxGridChartLegendCustomDrawEvent = procedure(Sender: TcxGridChartView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendViewInfo; var ADone: Boolean) of object;
  TcxGridChartLegendItemCustomDrawEvent = procedure(Sender: TcxGridChartView;
    ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean) of object;

  TcxGridChartView = class(TcxCustomGridView)
  private
    FActiveDiagram: TcxGridChartDiagram;
    FCategories: TcxGridChartCategories;
    FDiagramBar: TcxGridChartBarDiagram;
    FDiagramColumn: TcxGridChartColumnDiagram;
    FDiagrams: TList;
    FLegend: TcxGridChartLegend;
    FNextID: Integer;
    FSeries: TList;
    FTitle: TcxGridChartTitle;
    FVisibleSeries: TList;
    FOnActiveDiagramChanged: TcxGridChartDiagramEvent;
    FOnCustomDrawLegend: TcxGridChartLegendCustomDrawEvent;
    FOnCustomDrawLegendItem: TcxGridChartLegendItemCustomDrawEvent;
    FOnGetValueHint: TcxGridChartGetValueHintEvent;

    function GetController: TcxGridChartController;
    function GetDataController: TcxGridChartDataController;
    function GetDiagram(Index: Integer): TcxGridChartDiagram;
    function GetDiagramCount: Integer;
    function GetOptionsBehavior: TcxGridChartOptionsBehavior;
    function GetSeries(Index: Integer): TcxGridChartSeries;
    function GetSeriesCount: Integer;
    function GetStyles: TcxGridChartViewStyles;
    function GetViewData: TcxGridChartViewData;
    function GetViewInfo: TcxGridChartViewInfo;
    function GetVisibleSeries(Index: Integer): TcxGridChartSeries;
    function GetVisibleSeriesCount: Integer;
    procedure SetActiveDiagram(Value: TcxGridChartDiagram);
    procedure SetCategories(Value: TcxGridChartCategories);
    procedure SetDataController(Value: TcxGridChartDataController);
    procedure SetDiagramBar(Value: TcxGridChartBarDiagram);
    procedure SetDiagramColumn(Value: TcxGridChartColumnDiagram);
    procedure SetLegend(Value: TcxGridChartLegend);
    procedure SetOptionsBehavior(Value: TcxGridChartOptionsBehavior);
    procedure SetSeries(Index: Integer; Value: TcxGridChartSeries);
    procedure SetStyles(Value: TcxGridChartViewStyles);
    procedure SetTitle(Value: TcxGridChartTitle);
    procedure SetOnActiveDiagramChanged(Value: TcxGridChartDiagramEvent);
    procedure SetOnCustomDrawLegend(Value: TcxGridChartLegendCustomDrawEvent);
    procedure SetOnCustomDrawLegendItem(Value: TcxGridChartLegendItemCustomDrawEvent);
    procedure SetOnGetValueHint(Value: TcxGridChartGetValueHintEvent);

    procedure RefreshVisibleSeriesList;
  protected
    // IcxGridViewLayoutEditorSupport - for design-time layout editor
    function IsLayoutChangeable: Boolean; override;
    // IcxGridViewDesignerMenu
    procedure DoMenuItemAction(AIndex: Integer; var AModified: Boolean); override;
    function GetMenuItemAction(AIndex: Integer): TcxGridViewDesignerMenuItemAction; override;
    function GetMenuItemCount: Integer; override;
    function GetMenuItemObject(AIndex: Integer): TObject; override;
    procedure PrepareMenuItem(AIndex: Integer; AMenuItem: TMenuItem); override;

    procedure DoAssign(ASource: TcxCustomGridView); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure GetFakeComponentLinks(AList: TList); override;
    procedure SetChildOrder(Child: TComponent; Order: Integer); override;
    procedure SetName(const NewName: TComponentName); override;
    procedure UpdateControl(AInfo: TcxUpdateControlInfo); override;

    function GetControllerClass: TcxCustomGridControllerClass; override;
    function GetDataControllerClass: TcxCustomDataControllerClass; override;
    function GetItemDataBindingClass: TcxGridChartItemDataBindingClass; virtual;
    function GetPainterClass: TcxCustomGridPainterClass; override;
    function GetViewDataClass: TcxCustomGridViewDataClass; override;
    function GetViewInfoClass: TcxCustomGridViewInfoClass; override;

    function GetLegendClass: TcxGridChartLegendClass; virtual;
    function GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass; override;
    function GetStylesClass: TcxCustomGridViewStylesClass; override;
    function GetTitleClass: TcxGridChartTitleClass; virtual;

    function GetBarDiagramClass: TcxGridChartBarDiagramClass; virtual;
    function GetCategoriesClass: TcxGridChartCategoriesClass; virtual;
    function GetColumnDiagramClass: TcxGridChartColumnDiagramClass; virtual;

    procedure AddDiagram(ADiagram: TcxGridChartDiagram);
    procedure RemoveDiagram(ADiagram: TcxGridChartDiagram);
    procedure ClearDiagrams;
    function CreateDiagram(ADiagramClass: TcxGridChartDiagramClass): TcxGridChartDiagram;
    procedure CreateDiagrams; virtual;
    procedure DiagramRemoved(ADiagram: TcxGridChartDiagram); virtual;
    function GetDiagramNamePath(ADiagram: TcxGridChartDiagram): string; virtual;
    function GetFirstAvailableDiagram: TcxGridChartDiagram;

    function GetNextID: Integer;
    procedure ReleaseID(AID: Integer);
    property NextID: Integer read FNextID;

    procedure AddSeries(ASeries: TcxGridChartSeries);
    procedure RemoveSeries(ASeries: TcxGridChartSeries);
    function GetSeriesClass: TcxGridChartSeriesClass; virtual;
    function IndexOfSeries(ASeries: TcxGridChartSeries): Integer;
    procedure SetSeriesIndex(ASeries: TcxGridChartSeries; AIndex: Integer);

    procedure UpdateDataController(AItem: TObject; ADataBinding: TcxGridChartItemDataBinding;
      AAdd: Boolean);

    procedure CreateHandlers; override;
    procedure DestroyHandlers; override;
    procedure CreateOptions; override;
    procedure DestroyOptions; override;

    procedure CalculateImageWidth(var AWidth: Integer); virtual;
    procedure CalculateImageHeight(var AHeight: Integer); virtual;

    procedure DoActiveDiagramChanged(ADiagram: TcxGridChartDiagram); virtual;
    procedure DoCustomDrawLegend(ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendViewInfo;
      var ADone: Boolean); virtual;
    procedure DoCustomDrawLegendItem(ACanvas: TcxCanvas; AViewInfo: TcxGridChartLegendItemViewInfo;
      var ADone: Boolean); virtual;
    procedure DoGetValueHint(ASeries: TcxGridChartSeries; AValueIndex: Integer;
      var AHint: string); virtual;
    function HasCustomDrawLegend: Boolean; virtual;
    function HasCustomDrawLegendItem: Boolean; virtual;
  public
    procedure ClearSeries;
    function CreateSeries: TcxGridChartSeries;
    function FindSeriesByID(AID: Integer): TcxGridChartSeries;
    function FindSeriesByName(const AName: string): TcxGridChartSeries;
    function FindSeriesByTag(ATag: TcxTag): TcxGridChartSeries;

    function CreateImage(AGraphicClass: TGraphicClass; AWidth: Integer = 0; AHeight: Integer = 0): TGraphic;

    property Controller: TcxGridChartController read GetController;
    property DiagramCount: Integer read GetDiagramCount;
    property Diagrams[Index: Integer]: TcxGridChartDiagram read GetDiagram;
    property Series[Index: Integer]: TcxGridChartSeries read GetSeries write SetSeries;
    property SeriesCount: Integer read GetSeriesCount;
    property ViewData: TcxGridChartViewData read GetViewData;
    property ViewInfo: TcxGridChartViewInfo read GetViewInfo;
    property VisibleSeries[Index: Integer]: TcxGridChartSeries read GetVisibleSeries;
    property VisibleSeriesCount: Integer read GetVisibleSeriesCount;
  published
    property ActiveDiagram: TcxGridChartDiagram read FActiveDiagram write SetActiveDiagram stored False;
    property Categories: TcxGridChartCategories read FCategories write SetCategories
      ;
    property DataController: TcxGridChartDataController read GetDataController write SetDataController;
    property DiagramBar: TcxGridChartBarDiagram read FDiagramBar write SetDiagramBar;
    property DiagramColumn: TcxGridChartColumnDiagram read FDiagramColumn write SetDiagramColumn;
    property Legend: TcxGridChartLegend read FLegend write SetLegend;
    property OptionsBehavior: TcxGridChartOptionsBehavior read GetOptionsBehavior
      write SetOptionsBehavior;
    property Styles: TcxGridChartViewStyles read GetStyles write SetStyles;
    property Title: TcxGridChartTitle read FTitle write SetTitle;

    property DiagramBarEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;
    property DiagramColumnEvents: TNotifyEvent read FSubClassEvents write FSubClassEvents;

    property OnActiveDiagramChanged: TcxGridChartDiagramEvent read FOnActiveDiagramChanged
      write SetOnActiveDiagramChanged;
    property OnCustomDrawLegend: TcxGridChartLegendCustomDrawEvent read FOnCustomDrawLegend
      write SetOnCustomDrawLegend;
    property OnCustomDrawLegendItem: TcxGridChartLegendItemCustomDrawEvent
      read FOnCustomDrawLegendItem write SetOnCustomDrawLegendItem;
    property OnGetValueHint: TcxGridChartGetValueHintEvent read FOnGetValueHint write SetOnGetValueHint;
  end;

function IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean;

implementation

uses
{$IFDEF DELPHI6}
  Types, StrUtils,
{$ENDIF}
  SysUtils, Math, cxGridLevel, cxGridStrs, cxControls, TypInfo;

const
  ChartPartOffset = 10;

  ValueOffsetUnits = 3;
  ValueSizeUnits = 4;

  MarkWidth = 1;
  CategoryGridLineWidth = 1;
  ValueGridLineWidth = 1;
  ValueAxisWidth = CategoryGridLineWidth;
  CategoryAxisWidth = ValueGridLineWidth;

  TickMarkLabelsOffset = 10;

  DefaultSeriesDisplayText = '<no display text>';

  ValueHintOffset = 27;

function GetDefaultValueColor(AIndex: Integer): TColor;
const
  ColorCount = 24;
  Colors: array[0..ColorCount - 1] of TColor =
    ($60C1FF, $B4835C, $7C58A5, $657C6C, $6379E6, $9AA05B, $605DCF, $6A8846,
     $61A3F5, $58999E, $5A8CFF, $AD977A, $808E54, $95C9B9, $6763A5, $AC8C4D,
     $80E4FB, $956349, $4D50C0, $67B48B, $D6A584, $73D8DD, $89674D, $9CB5A5);
begin
  Result := Colors[AIndex mod ColorCount];
end;

procedure PositionRect(out R: TRect; var AClientR: TRect; AWidth, AHeight, AOffset: Integer;
  APosition: TcxGridChartPartPosition);
begin
  R := AClientR;
  case APosition of
    cppLeft:
      begin
        R.Right := R.Left + AWidth;
        AClientR.Left := R.Right + AOffset;
      end;
    cppTop:
      begin
        R.Bottom := R.Top + AHeight;
        AClientR.Top := R.Bottom + AOffset;
      end;
    cppRight:
      begin
        R.Left := R.Right - AWidth;
        AClientR.Right := R.Left - AOffset;
      end;
    cppBottom:
      begin
        R.Top := R.Bottom - AHeight;
        AClientR.Bottom := R.Top - AOffset;
      end;
  end;
end;

procedure AlignRect(var R: TRect; AWidth, AHeight: Integer; AIsHorizontal: Boolean;
  AAlignment: TcxGridChartPartAlignment);
var
  AOriginalR: TRect;
begin
  AOriginalR := R;
  case AAlignment of
    cpaStart:
      if AIsHorizontal then
        R.Right := R.Left + AWidth
      else
        R.Bottom := R.Top + AHeight;
    cpaCenter:
      if AIsHorizontal then
      begin
        R.Left := (R.Left + R.Right - AWidth) div 2;
        R.Right := R.Left + AWidth;
      end
      else
      begin
        R.Top := (R.Top + R.Bottom - AHeight) div 2;
        R.Bottom := R.Top + AHeight;
      end;
    cpaEnd:
      if AIsHorizontal then
        R.Left := R.Right - AWidth
      else
        R.Top := R.Bottom - AHeight;
  end;
//  IntersectRect(R, R, AOriginalR);
end;

procedure CheckRectBounds(var R: TRect);
begin
  with R do
  begin
    if Left > Right then
      SwapIntegers(Left, Right);
    if Top > Bottom then
      SwapIntegers(Top, Bottom);
  end;
end;

{$IFNDEF DELPHI6}

type
  TValueSign = -1..1;

const
  NegativeValue = Low(TValueSign);
  ZeroValue = 0;
  PositiveValue = High(TValueSign);

function Sign(const AValue: Double): TValueSign;
begin
  if (PInt64(@AValue)^ and $7FFFFFFFFFFFFFFF) = $0000000000000000 then
    Result := ZeroValue
  else
    if (PInt64(@AValue)^ and $8000000000000000) = $8000000000000000 then
      Result := NegativeValue
    else
      Result := PositiveValue;
end;

{$ENDIF}

function Fraction(const Value: Extended): Extended;
const
  ErrorValue = 1e-15;
begin
  Result := Frac(Value);
  if Result <> 0 then  // to fix the bug in standard implementation
  begin
    Result := Frac(Value + Sign(Value) * ErrorValue);
    if Abs(Result) < ErrorValue then
      Result := 0;
  end;
end;

function IsValueTypeValid(AValueType: {$IFDEF DELPHI6}TVarType{$ELSE}Integer{$ENDIF};
  AOnlyIntegerTypes: Boolean): Boolean;
const
  ValidIntegerValueTypes = [varSmallint, varInteger, varByte
    {$IFDEF DELPHI6}, varShortInt, varWord, varLongWord, varInt64{$ENDIF}];
  ValidFloatValueTypes = [varSingle, varDouble, varCurrency];
begin
  Result := (AValueType in ValidIntegerValueTypes) or
    not AOnlyIntegerTypes and (AValueType in ValidFloatValueTypes);
end;

function IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean;
begin
  Result := IsValueTypeValid(AValueTypeClass.GetVarType, False);
end;

function IsValueValid(const AValue: Variant): Boolean;
begin
  Result := IsValueTypeValid(VarType(AValue), False);
end;

{ TcxGridChartTitleHitTest }

class function TcxGridChartTitleHitTest.GetHitTestCode: Integer;
begin
  Result := htChartTitle;
end;

{ TcxGridChartLegendHitTest }

class function TcxGridChartLegendHitTest.GetHitTestCode: Integer;
begin
  Result := htLegend;
end;

{ TcxGridChartLegendItemHitTest }

class function TcxGridChartLegendItemHitTest.GetHitTestCode: Integer;
begin
  Result := htLegendItem;
end;

{ TcxGridChartValueHitTest }

class function TcxGridChartValueHitTest.GetHitTestCode: Integer;
begin
  Result := htChartValue;
end;

{ TcxGridChartHistogramPlotHitTest }

class function TcxGridChartHistogramPlotHitTest.GetHitTestCode: Integer;
begin
  Result := htPlot;
end;

{ TcxGridChartHistogramCategoryAxisTitleHitTest }

class function TcxGridChartHistogramCategoryAxisTitleHitTest.GetHitTestCode: Integer;
begin
  Result := htCategoryAxisTitle;
end;

{ TcxGridChartHistogramValueAxisTitleHitTest }

class function TcxGridChartHistogramValueAxisTitleHitTest.GetHitTestCode: Integer;
begin
  Result := htValueAxisTitle;
end;

{ TcxGridChartController }

function TcxGridChartController.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartController.GetDesignHitTest(AHitTest: TcxCustomGridHitTest): Boolean;
begin
  Result := inherited GetDesignHitTest(AHitTest);
  if not Result then
    Result := AHitTest.HitTestCode in [htChartValue, htLegendItem];
end;

function TcxGridChartController.GetPatternObject(AObject: TPersistent): TPersistent;
begin
  if AObject is TcxGridChartSeries then
    Result := TcxGridChartView(GridView.PatternGridView).FindSeriesByID(TcxGridChartSeries(AObject).ID)
  else
    Result := inherited GetPatternObject(AObject);
end;

function TcxGridChartController.GetValueHintText(ASeries: TcxGridChartSeries; AValueIndex: Integer): string;
begin
  Result := Format(cxGetResourceString(@scxGridChartValueHintFormat),
    [ASeries.GetDisplayText, GridView.ViewData.Categories[AValueIndex],
     ASeries.GetValueCaption(AValueIndex)]);
  GridView.DoGetValueHint(ASeries, AValueIndex, Result);   
end;

{ TcxGridChartDataController }

function TcxGridChartDataController.GetGridViewValue: TcxGridChartView;
begin
  Result := TcxGridChartView(GetOwner);
end;

procedure TcxGridChartDataController.AssignData(ADataController: TcxCustomDataController);
begin
end;

procedure TcxGridChartDataController.CreateAllItems;
begin
end;

procedure TcxGridChartDataController.DeleteAllItems;
begin
end;

procedure TcxGridChartDataController.GetFakeComponentLinks(AList: TList);
begin
end;

function TcxGridChartDataController.GetGridView: TcxCustomGridView;
begin
  Result := GridView;
end;

function TcxGridChartDataController.IsDataChangeable: Boolean;
begin
  Result := False;
end;

function TcxGridChartDataController.IsDataLinked: Boolean;
begin
  Result := True;
end;

function TcxGridChartDataController.SupportsCreateAllItems: Boolean;
begin
  Result := False;
end;

function TcxGridChartDataController.GetItemID(AItem: TObject): Integer;
begin
  if AItem is TcxGridChartCategories then
    Result := TcxGridChartCategories(AItem).ID
  else
    if AItem is TcxGridChartSeries then
      Result := TcxGridChartSeries(AItem).ID
    else
      Result := -1;
end;

procedure TcxGridChartDataController.BeginFullUpdate;
begin
  GridView.BeginUpdate;
  inherited;
end;

procedure TcxGridChartDataController.EndFullUpdate;
begin
  inherited;
  GridView.EndUpdate;
end;

function TcxGridChartDataController.GetItem(Index: Integer): TObject;
begin
  if Index = 0 then
    Result := GridView.Categories
  else
    Result := GridView.Series[Index - 1];
end;

{ TcxGridChartTitlePainter }

function TcxGridChartTitlePainter.GetViewInfo: TcxCustomGridChartTitleViewInfo;
begin
  Result := TcxCustomGridChartTitleViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartTitlePainter.PrepareCanvasForDrawText;
begin
  inherited;
  if ViewInfo.Orientation = cpoVertical then
    Canvas.SetFontAngle(90);
end;

procedure TcxGridChartTitlePainter.UnprepareCanvasForDrawText;
begin
  if ViewInfo.Orientation = cpoVertical then
    Canvas.SetFontAngle(0);
  inherited;
end;

{ TcxGridChartLegendItemPainter }

function TcxGridChartLegendItemPainter.GetViewInfo: TcxGridChartLegendItemViewInfo;
begin
  Result := TcxGridChartLegendItemViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartLegendItemPainter.DrawContent;
begin
  inherited;
  DrawLegendKey;
end;

procedure TcxGridChartLegendItemPainter.DrawLegendKey;
begin
  Canvas.FillRect(ViewInfo.LegendKeyBounds, ViewInfo.LegendKeyParams,
    ViewInfo.LegendKeyBorders, ViewInfo.LegendKeyParams.TextColor);
end;

{ TcxGridChartLegendPainter }

function TcxGridChartLegendPainter.GetViewInfo: TcxGridChartLegendViewInfo;
begin
  Result := TcxGridChartLegendViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartLegendPainter.DrawContent;
var
  I: Integer;
begin
  inherited;
  for I := 0 to ViewInfo.Count - 1 do
    ViewInfo.Items[I].Paint(Canvas);
end;

function TcxGridChartLegendPainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridChartDiagramPainter }

function TcxGridChartDiagramPainter.GetViewInfo: TcxGridChartDiagramViewInfo;
begin
  Result := TcxGridChartDiagramViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartDiagramPainter.DrawValueCaptions;
var
  I: Integer;
  ABounds: TRect;
begin
  for I := 0 to ViewInfo.ValueViewInfoCount - 1 do
  begin
    ABounds := ViewInfo.ValueViewInfos[I].CaptionViewInfo.Bounds;
    if Canvas.RectFullyVisible(ABounds) then
    begin
      ViewInfo.ValueViewInfos[I].CaptionViewInfo.Paint(Canvas);
      Canvas.ExcludeClipRect(ABounds);
    end;
  end;
end;

procedure TcxGridChartDiagramPainter.DrawValues;
var
  I: Integer;
begin
  for I := 0 to ViewInfo.ValueViewInfoCount - 1 do
    ViewInfo.ValueViewInfos[I].Paint(Canvas);
end;

procedure TcxGridChartDiagramPainter.FillAndExcludeRect(const R: TRect);
begin
  Canvas.FillRect(R);
  Canvas.ExcludeClipRect(R);
end;

procedure TcxGridChartDiagramPainter.Paint;
begin
  inherited;
  DrawValueCaptions;
end;

{ TcxGridChartColumnDiagramTickMarkLabelsPainter }

function TcxGridChartColumnDiagramTickMarkLabelsPainter.GetViewInfo: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
begin
  Result := TcxGridChartColumnDiagramTickMarkLabelsViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsPainter.DrawCaptions;
var
  I: Integer;
  ABounds: TRect;
begin
  Canvas.SetParams(ViewInfo.Params);
  Canvas.Brush.Style := bsClear;
  for I := 0 to ViewInfo.Count - 1 do
  begin
    ABounds := ViewInfo.CaptionBounds[I];
    if not ViewInfo.IsVertical or Canvas.RectFullyVisible(ABounds) then
    begin
      Canvas.DrawText(ViewInfo.Captions[I], ABounds, ViewInfo.GetTextAttributes(True));
      if ViewInfo.IsVertical then
        Canvas.ExcludeClipRect(ABounds);
    end;
  end;
  Canvas.Brush.Style := bsSolid;
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsPainter.DrawContent;
begin
  if ViewInfo.CaptionsVisible then
    DrawCaptions;
  ViewInfo.TitleViewInfo.Paint(Canvas);
end;

{ TcxGridChartColumnDiagramValuePainter }

function TcxGridChartColumnDiagramValuePainter.ExcludeFromClipRect: Boolean;
begin
  Result := True;
end;

{ TcxGridChartColumnDiagramPainter }

function TcxGridChartColumnDiagramPainter.GetViewInfo: TcxGridChartColumnDiagramViewInfo;
begin
  Result := TcxGridChartColumnDiagramViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartColumnDiagramPainter.DrawCategoryAxis;
var
  R: TRect;
  I: Integer;
begin
  Canvas.Brush.Color := ViewInfo.CategoryAxisColor;

  R := ViewInfo.CategoryAxisBounds;
  FillAndExcludeRect(R);

  for I := 0 to ViewInfo.CategoryMarkCount - 1 do
  begin
    R := ViewInfo.CategoryMarkBounds[I];
    FillAndExcludeRect(R);
  end;
end;

procedure TcxGridChartColumnDiagramPainter.DrawCategoryGridLines;
var
  I: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := ViewInfo.CategoryGridLineColor;
  for I := 0 to ViewInfo.CategoryMarkCount - 1 do
  begin
    R := ViewInfo.CategoryGridLineBounds[I];
    FillAndExcludeRect(R);
  end;
end;

procedure TcxGridChartColumnDiagramPainter.DrawContent;
var
  AClipRegion: TcxRegion;
begin
  AClipRegion := Canvas.GetClipRegion;
  try
    if ViewInfo.HasCategoryAxis then DrawCategoryAxis;
    if ViewInfo.HasValueAxis then DrawValueAxis;
    DrawValues;
    if ViewInfo.HasCategoryGridLines then DrawCategoryGridLines;
    if ViewInfo.HasValueGridLines then DrawValueGridLines;
    if not ViewInfo.DoCustomDrawPlot(Canvas) then
      DrawPlotBackground;
    inherited;
  finally
    Canvas.SetClipRegion(AClipRegion, roSet);
  end;
  ViewInfo.CategoryTickMarkLabelsViewInfo.Paint(Canvas);
  ViewInfo.ValueTickMarkLabelsViewInfo.Paint(Canvas);
end;

procedure TcxGridChartColumnDiagramPainter.DrawPlotBackground;
begin
  Canvas.FillRect(ViewInfo.PlotBounds, ViewInfo.PlotParams);
  Canvas.ExcludeClipRect(ViewInfo.PlotBounds);
end;

procedure TcxGridChartColumnDiagramPainter.DrawValueAxis;
var
  R: TRect;
  I: Integer;
begin
  Canvas.Brush.Color := ViewInfo.ValueAxisColor;

  R := ViewInfo.ValueAxisBounds;
  FillAndExcludeRect(R);

  for I := 0 to ViewInfo.ValueMarkCount - 1 do
  begin
    R := ViewInfo.ValueMarkBounds[I];
    FillAndExcludeRect(R);
  end;
end;

procedure TcxGridChartColumnDiagramPainter.DrawValueGridLines;
var
  I: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := ViewInfo.ValueGridLineColor;
  for I := 0 to ViewInfo.ValueMarkCount - 1 do
  begin
    R := ViewInfo.ValueGridLineBounds[I];
    FillAndExcludeRect(R);
  end;
end;

{ TcxGridChartPainter }

function TcxGridChartPainter.GetViewInfo: TcxGridChartViewInfo;
begin
  Result := TcxGridChartViewInfo(inherited ViewInfo);
end;

procedure TcxGridChartPainter.PaintAfter;
begin
  inherited;
  ViewInfo.TitleViewInfo.Paint(Canvas);
  if ViewInfo.DiagramViewInfo <> nil then
    ViewInfo.DiagramViewInfo.Paint(Canvas);
end;

procedure TcxGridChartPainter.PaintContent;
begin
  inherited;
  if ViewInfo.DiagramViewInfo <> nil then
    ExcludeFromBackground(ViewInfo.DiagramViewInfo.Bounds);
  if ViewInfo.LegendViewInfo <> nil then
    ViewInfo.LegendViewInfo.Paint(Canvas);
end;

{ TcxGridChartViewData }

function TcxGridChartViewData.GetCategory(AIndex: Integer): Variant;
begin
  Result := DataController.Values[GetRecordIndexByValueIndex(AIndex),
    GridView.Categories.DataBinding.DataIndex];
  if VarIsNull(Result) then Result := '';
end;

function TcxGridChartViewData.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartViewData.GetValue(ASeriesIndex, AIndex: Integer): Variant;
begin
  Result := DataController.Values[GetRecordIndexByValueIndex(AIndex),
    GridView.Series[ASeriesIndex].DataBinding.DataIndex];
  if not IsValueValid(Result) then Result := 0;
end;

function TcxGridChartViewData.GetValueCount: Integer;
begin
  Result := DataController.RecordCount;
end;

procedure TcxGridChartViewData.SetCategory(AIndex: Integer; const Value: Variant);
begin
  DataController.Values[GetRecordIndexByValueIndex(AIndex),
    GridView.Categories.DataBinding.DataIndex] := Value;
end;

procedure TcxGridChartViewData.SetValue(ASeriesIndex, AIndex: Integer;
  const Value: Variant);
begin
  DataController.Values[GetRecordIndexByValueIndex(AIndex),
    GridView.Series[ASeriesIndex].DataBinding.DataIndex] := Value;
end;

procedure TcxGridChartViewData.SetValueCount(Value: Integer);
begin
  DataController.RecordCount := Value;
end;

function TcxGridChartViewData.GetRecordIndexByValueIndex(AValueIndex: Integer): Integer;
begin
  Result := DataController.GetRowInfo(AValueIndex).RecordIndex;
end;

{ TcxCustomGridChartPartViewInfo }

function TcxCustomGridChartPartViewInfo.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxCustomGridChartPartViewInfo.GetHeight: Integer;
begin
  if inherited GetHeight = 0 then
    Height := CalculateHeight;
  Result := inherited GetHeight;
end;

function TcxCustomGridChartPartViewInfo.GetVisible: Boolean;
begin
  Result := Position <> cppNone;
end;

function TcxCustomGridChartPartViewInfo.GetWidth: Integer;
begin
  if inherited GetWidth = 0 then
    Width := CalculateWidth;
  Result := inherited GetWidth;
end;

{ TcxCustomGridChartTitleViewInfo }

constructor TcxCustomGridChartTitleViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo;
  ATitle: TcxCustomGridChartTitle);
begin
  inherited Create(AGridViewInfo);
  FTitle := ATitle;
end;

function TcxCustomGridChartTitleViewInfo.CalculateHeight: Integer;
begin
  if Orientation = cpoHorizontal then
    Result := TextHeight
  else
    Result := CalculateTextWidth(90);
end;

function TcxCustomGridChartTitleViewInfo.CalculateWidth: Integer;
begin
  if Orientation = cpoHorizontal then
    Result := TextWidth
  else
    Result := CalculateTextHeight(False, 90);
end;

function TcxCustomGridChartTitleViewInfo.GetAlignment: TcxGridChartPartAlignment;
begin
  Result := FTitle.GetAlignment;
end;

function TcxCustomGridChartTitleViewInfo.GetOrientation: TcxGridChartPartOrientation;
begin
  Result := FTitle.GetOrientation;
end;

function TcxCustomGridChartTitleViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartTitlePainter;
end;

function TcxCustomGridChartTitleViewInfo.GetPosition: TcxGridChartPartPosition;
begin
  Result := FTitle.GetPosition;
end;

function TcxCustomGridChartTitleViewInfo.GetText: string;
begin
  Result := FTitle.Text;
end;

function TcxCustomGridChartTitleViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  if Orientation = cpoVertical then
    SwapIntegers(Result.Top, Result.Bottom);
end;

function TcxCustomGridChartTitleViewInfo.HasBackground: Boolean;
begin
  Result := False;
end;

{ TcxGridChartLegendItemViewInfo }

constructor TcxGridChartLegendItemViewInfo.Create(AContainer: TcxGridChartLegendViewInfo;
  AIndex: Integer);
begin
  inherited Create(AContainer.GridViewInfo);
  FContainer := AContainer;
  FIndex := AIndex;
end;

function TcxGridChartLegendItemViewInfo.GetDiagram: TcxGridChartDiagram;
begin
  Result := FContainer.Diagram;
end;

function TcxGridChartLegendItemViewInfo.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartLegendItemViewInfo.GetLegendKeySize: Integer;
begin
  if FLegendKeySize = 0 then
    FLegendKeySize := CalculateLegendKeySize;
  Result := FLegendKeySize;
end;

function TcxGridChartLegendItemViewInfo.GetSeries: TcxGridChartSeries;
begin
  if Container.Kind = lkSeries then
    Result := GridView.VisibleSeries[Container.GetItemObjectIndex(Index)]
  else
    if GridView.VisibleSeriesCount = 1 then
      Result := GridView.VisibleSeries[0]
    else
      Result := nil;
end;

function TcxGridChartLegendItemViewInfo.CalculateContentBounds: TRect;
begin
  Result := inherited CalculateContentBounds;
  InflateRect(Result, -LegendKeyOffset div 2, 0);
end;

function TcxGridChartLegendItemViewInfo.CalculateHeight: Integer;
begin
  Result := TextHeight;
end;

function TcxGridChartLegendItemViewInfo.CalculateWidth: Integer;
begin
  Result := TextWidth;
  Inc(Result, LegendKeyOffset div 2 * 2 + LegendKeySize + LegendKeyOffset);
end;

function TcxGridChartLegendItemViewInfo.CalculateLegendKeySize: Integer;
begin
  CalculateParams;
  Result := MulDiv(Canvas.FontHeight(Params.Font), 3, 4);
end;

function TcxGridChartLegendItemViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    Diagram.DoCustomDrawLegendItem(ACanvas, Self, Result);
    if not Result then
      GridView.DoCustomDrawLegendItem(ACanvas, Self, Result);
  end;
end;

procedure TcxGridChartLegendItemViewInfo.DoCalculateParams;
begin
  inherited;
  Container.GetItemLegendKeyParams(Index, LegendKeyParams);
  LegendKeyParams.TextColor := Params.TextColor;
end;

function TcxGridChartLegendItemViewInfo.GetDesignSelectionBounds: TRect;
begin
  Result := Bounds;
  InflateRect(Result, DesignSelectionWidth, DesignSelectionWidth);
end;

function TcxGridChartLegendItemViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartLegendItemHitTest;
end;

function TcxGridChartLegendItemViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := (Container.Kind = lkSeries) and GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(Series);
end;

function TcxGridChartLegendItemViewInfo.GetLegendKeyBorders: TcxBorders;
begin
  if Diagram.Legend.GetKeyBorder = lbSingle then
    Result := cxBordersAll
  else
    Result := [];
end;

function TcxGridChartLegendItemViewInfo.GetLegendKeyBounds: TRect;
begin
  CalculateParams;
  Result := ContentBounds;
  with Result do
  begin
    Right := Left + LegendKeySize;
    Top := MulDiv(Top + Bottom - LegendKeySize, 1, 2);
    Bottom := Top + LegendKeySize;
  end;
end;

function TcxGridChartLegendItemViewInfo.GetLegendKeyOffset: Integer;
begin
  Result := LegendKeySize div 2;
end;

function TcxGridChartLegendItemViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartLegendItemPainter;
end;

function TcxGridChartLegendItemViewInfo.GetText: string;
begin
  Result := FContainer.GetItemCaption(FIndex);
end;

function TcxGridChartLegendItemViewInfo.GetTextAreaBounds: TRect;
begin
  Result := ContentBounds;
  Inc(Result.Left, LegendKeySize + LegendKeyOffset);
end;

procedure TcxGridChartLegendItemViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FContainer.GetViewParams(AParams);
end;

function TcxGridChartLegendItemViewInfo.HasBackground: Boolean;
begin
  Result := False;
end;

function TcxGridChartLegendItemViewInfo.HasCustomDraw: Boolean;
begin
  Result := Diagram.HasCustomDrawLegendItem or GridView.HasCustomDrawLegendItem;
end;

procedure TcxGridChartLegendItemViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  with AHitTest as TcxGridChartLegendItemHitTest do
  begin
    Index := Self.Index;
    Series := Self.Series;
    if Container.Kind = lkSeries then
      ValueIndex := -1
    else
      ValueIndex := Container.GetItemObjectIndex(Self.Index);
  end;
end;

function TcxGridChartLegendItemViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (Container.Kind = lkSeries) and
    (AButton = mbLeft) and not (ssDouble in AShift) and GridView.IsDesigning then
  begin
    GridView.Controller.DesignController.SelectObject(Series, not (ssShift in AShift));
    Result := True;
  end;
end;

{ TcxGridChartLegendViewInfo }

constructor TcxGridChartLegendViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo;
  ADiagram: TcxGridChartDiagram);
var
  I: Integer;
begin
  inherited Create(AGridViewInfo);
  FDiagram := ADiagram;
  FItems := TList.Create;
  for I := 0 to GetItemCount - 1 do
    AddItem;
end;

destructor TcxGridChartLegendViewInfo.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Items[I].Free;
  FItems.Free;
  inherited;
end;

function TcxGridChartLegendViewInfo.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TcxGridChartLegendViewInfo.GetItem(Index: Integer): TcxGridChartLegendItemViewInfo;
begin
  Result := TcxGridChartLegendItemViewInfo(FItems[Index]);
end;

function TcxGridChartLegendViewInfo.GetLegendItemOffset: Integer;
begin
  if FLegendItemOffset = 0 then
    FLegendItemOffset := CalculateLegendItemOffset;
  Result := FLegendItemOffset;
end;

function TcxGridChartLegendViewInfo.CalculateHeight: Integer;
var
  I: Integer;
begin
  CalculateParams;
  if Orientation = cpoHorizontal then
  begin
    Result := 0;
    for I := 0 to Count - 1 do
      Result := Max(Result, Items[I].CalculateHeight);
  end
  else
  begin
    Result := LegendItemOffset * (Count - 1);
    for I := 0 to Count - 1 do
      Inc(Result, Items[I].CalculateHeight);
  end;
  Inc(Result, BorderSize[bTop] + BorderSize[bBottom] + 2 * LegendItemOffset);
end;

function TcxGridChartLegendViewInfo.CalculateWidth: Integer;
var
  I: Integer;
begin
  CalculateParams;
  if Orientation = cpoHorizontal then
  begin
    Result := LegendItemOffset * (Count - 1);
    for I := 0 to Count - 1 do
      Inc(Result, Items[I].CalculateWidth);
  end
  else
  begin
    Result := 0;
    for I := 0 to Count - 1 do
      Result := Max(Result, Items[I].CalculateWidth);
  end;
  Inc(Result, BorderSize[bLeft] + BorderSize[bRight] + 2 * LegendItemOffset);
end;

function TcxGridChartLegendViewInfo.CalculateLegendItemOffset: Integer;
begin
  CalculateParams;
  Result := MulDiv(Canvas.FontHeight(Params.Font), 1, 4);
end;

function TcxGridChartLegendViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    Diagram.DoCustomDrawLegend(ACanvas, Self, Result);
    if not Result then
      GridView.DoCustomDrawLegend(ACanvas, Self, Result);
  end;
end;

function TcxGridChartLegendViewInfo.GetAlignment: TcxGridChartPartAlignment;
begin
  Result := Diagram.Legend.GetAlignment;
end;

function TcxGridChartLegendViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := Params.TextColor;
end;

function TcxGridChartLegendViewInfo.GetBorders: TcxBorders;
begin
  if Diagram.Legend.GetBorder = lbSingle then
    Result := cxBordersAll
  else
    Result := [];
end;

function TcxGridChartLegendViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := 1;
end;

function TcxGridChartLegendViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartLegendHitTest;
end;

function TcxGridChartLegendViewInfo.GetOrientation: TcxGridChartPartOrientation;
begin
  Result := Diagram.Legend.GetOrientation;
end;

function TcxGridChartLegendViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartLegendPainter;
end;

function TcxGridChartLegendViewInfo.GetPosition: TcxGridChartPartPosition;
begin
  Result := Diagram.Legend.GetPosition;
end;

procedure TcxGridChartLegendViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsLegend, nil, nil, AParams);
end;

function TcxGridChartLegendViewInfo.GetVisible: Boolean;
begin
  Result := inherited GetVisible and (Count <> 0);
end;

function TcxGridChartLegendViewInfo.HasCustomDraw: Boolean;
begin
  Result := Diagram.HasCustomDrawLegend or GridView.HasCustomDrawLegend;
end;

function TcxGridChartLegendViewInfo.AddItem: TcxGridChartLegendItemViewInfo;
begin
  Result := GetItemClass.Create(Self, Count);
  FItems.Add(Result);
end;

procedure TcxGridChartLegendViewInfo.CalculateItems;
var
  AItemLeftOffset, AItemTopOffset, I: Integer;
begin
  AItemLeftOffset := ContentBounds.Left + LegendItemOffset;
  AItemTopOffset := ContentBounds.Top + LegendItemOffset;
  for I := 0 to Count - 1 do
  begin
    Items[I].Calculate(AItemLeftOffset, AItemTopOffset);
    if Orientation = cpoHorizontal then
      AItemLeftOffset := Items[I].Bounds.Right + LegendItemOffset
    else
      AItemTopOffset := Items[I].Bounds.Bottom + LegendItemOffset;
  end;
end;

function TcxGridChartLegendViewInfo.GetItemCaption(AIndex: Integer): string;
begin
  if Kind = lkSeries then
    Result := GridView.VisibleSeries[GetItemObjectIndex(AIndex)].GetDisplayText
  else
    Result := GridView.Categories[GetItemObjectIndex(AIndex)];
end;

function TcxGridChartLegendViewInfo.GetItemClass: TcxGridChartLegendItemViewInfoClass;
begin
  Result := TcxGridChartLegendItemViewInfo;
end;

function TcxGridChartLegendViewInfo.GetItemCount: Integer;
begin
  if Kind = lkSeries then
    Result := GridView.VisibleSeriesCount
  else
    Result := GridView.Categories.ValueCount;
end;

procedure TcxGridChartLegendViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  CalculateItems;
end;

function TcxGridChartLegendViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
  AHitTest: TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if Result <> nil then
    for I := 0 to Count - 1 do
    begin
      AHitTest := Items[I].GetHitTest(P);
      if AHitTest <> nil then
      begin
        Result := AHitTest;
        Break;
      end;
    end;
end;

procedure TcxGridChartLegendViewInfo.GetItemLegendKeyParams(AIndex: Integer;
  out AParams: TcxViewParams);
var
  ASeriesIndex: Integer;
begin
  if Kind = lkSeries then
    Diagram.Styles.GetValueParams(GetItemObjectIndex(AIndex), -1, AParams)
  else
  begin
    if Items[AIndex].Series = nil then
      ASeriesIndex := -1
    else
      ASeriesIndex := Items[AIndex].Series.VisibleIndex;
    Diagram.Styles.GetValueParams(ASeriesIndex, GetItemObjectIndex(AIndex), AParams);
  end;
end;

{ TcxGridChartDiagramValueCaptionViewInfo }

constructor TcxGridChartDiagramValueCaptionViewInfo.Create(AValueViewInfo: TcxGridChartDiagramValueViewInfo);
begin
  inherited Create(AValueViewInfo.GridViewInfo);
  FValueViewInfo := AValueViewInfo;
end;

function TcxGridChartDiagramValueCaptionViewInfo.GetAlignmentHorz: TAlignment;
begin
  Result := taCenter;
end;

function TcxGridChartDiagramValueCaptionViewInfo.GetAlignmentVert: TcxAlignmentVert;
begin
  Result := vaCenter;
end;

function TcxGridChartDiagramValueCaptionViewInfo.CalculateHeight: Integer;
begin
  Result := TextHeightWithOffset;
end;

function TcxGridChartDiagramValueCaptionViewInfo.CalculateWidth: Integer;
begin
  Result := TextWidthWithOffset + 2 * cxTextOffset;  // visual compensation
end;

function TcxGridChartDiagramValueCaptionViewInfo.GetText: string;
begin
  Result := FValueViewInfo.GetCaptionText;
end;

function TcxGridChartDiagramValueCaptionViewInfo.GetTextAttributes(AForPainting: Boolean): Integer;
begin
  Result := inherited GetTextAttributes(AForPainting) or cxDontClip;
end;

procedure TcxGridChartDiagramValueCaptionViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FValueViewInfo.GetCaptionViewParams(AParams);
end;

function TcxGridChartDiagramValueCaptionViewInfo.GetVisible: Boolean;
begin
  Result := FValueViewInfo.HasCaption;
end;

function TcxGridChartDiagramValueCaptionViewInfo.HasBackground: Boolean;
begin
  Result := False;
end;

{ TcxGridChartDiagramValueViewInfo }

constructor TcxGridChartDiagramValueViewInfo.Create(ADiagramViewInfo: TcxGridChartDiagramViewInfo;
  ASeriesIndex, AValueIndex: Integer);
begin
  inherited Create(ADiagramViewInfo.GridViewInfo);
  FDiagramViewInfo := ADiagramViewInfo;
  FSeriesIndex := ASeriesIndex;
  FValueIndex := AValueIndex;
  FCaptionViewInfo := GetCaptionViewInfoClass.Create(Self);
end;

destructor TcxGridChartDiagramValueViewInfo.Destroy;
begin
  FCaptionViewInfo.Free;
  inherited;
end;

function TcxGridChartDiagramValueViewInfo.GetDiagram: TcxGridChartDiagram;
begin
  Result := FDiagramViewInfo.Diagram;
end;

function TcxGridChartDiagramValueViewInfo.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartDiagramValueViewInfo.GetSeries: TcxGridChartSeries;
begin
  Result := GridView.VisibleSeries[FSeriesIndex];
end;

function TcxGridChartDiagramValueViewInfo.CanShowHint: Boolean;
begin
  Result := GridView.OptionsBehavior.ValueHints;
end;

function TcxGridChartDiagramValueViewInfo.CustomDraw(ACanvas: TcxCanvas): Boolean;
begin
  Result := inherited CustomDraw(ACanvas);
  if not Result then
  begin
    Series.DoCustomDrawValue(ACanvas, Self, Result);
    if not Result then
      Diagram.DoCustomDrawValue(ACanvas, Self, Result);
  end;
end;

function TcxGridChartDiagramValueViewInfo.GetCaptionViewInfoClass: TcxGridChartDiagramValueCaptionViewInfoClass;
begin
  Result := TcxGridChartDiagramValueCaptionViewInfo;
end;

function TcxGridChartDiagramValueViewInfo.GetCaptionText: string;
begin
  Result := DiagramViewInfo.GetValueCaption(SeriesIndex, ValueIndex);
end;

function TcxGridChartDiagramValueViewInfo.GetCellBoundsForHint: TRect;
begin
  Result := Bounds;
end;

function TcxGridChartDiagramValueViewInfo.GetHintText: string;
begin
  Result := GridView.Controller.GetValueHintText(Series, ValueIndex);
end;

function TcxGridChartDiagramValueViewInfo.GetHintTextRect(const AMousePos: TPoint): TRect;
begin
  Result.TopLeft := AMousePos;
  Inc(Result.Top, ValueHintOffset);
  Result.BottomRight := Result.TopLeft;
end;

function TcxGridChartDiagramValueViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartValueHitTest;
end;

function TcxGridChartDiagramValueViewInfo.GetIsDesignSelected: Boolean;
begin
  Result := GridView.IsDesigning and
    GridView.Controller.DesignController.IsObjectSelected(Series);
end;

function TcxGridChartDiagramValueViewInfo.HasCaption: Boolean;
begin
  Result := False;
end;

function TcxGridChartDiagramValueViewInfo.HasCustomDraw: Boolean;
begin
  Result := Series.HasCustomDrawValue or Diagram.HasCustomDrawValue;
end;

procedure TcxGridChartDiagramValueViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  TcxGridChartValueHitTest(AHitTest).Series := Series;
  TcxGridChartValueHitTest(AHitTest).ValueIndex := ValueIndex;
end;

function TcxGridChartDiagramValueViewInfo.IsHintForText: Boolean;
begin
  Result := False;
end;

function TcxGridChartDiagramValueViewInfo.IsHintMultiLine: Boolean;
begin
  Result := False;
end;

procedure TcxGridChartDiagramValueViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
begin
  inherited;
  if HasCaption then
    CaptionViewInfo.Calculate(CalculateCaptionBounds);
end;

function TcxGridChartDiagramValueViewInfo.MouseDown(AHitTest: TcxCustomGridHitTest;
  AButton: TMouseButton; AShift: TShiftState): Boolean;
begin
  Result := inherited MouseDown(AHitTest, AButton, AShift);
  if (AButton = mbLeft) and not (ssDouble in AShift) and GridView.IsDesigning then
  begin
    GridView.Controller.DesignController.SelectObject(Series, not (ssShift in AShift));
    Result := True;
  end;
end;

{ TcxGridChartDiagramViewInfo }

constructor TcxGridChartDiagramViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo;
  ADiagram: TcxGridChartDiagram);
begin
  inherited Create(AGridViewInfo);
  FDiagram := ADiagram;
  FValueViewInfos := TList.Create;
end;

destructor TcxGridChartDiagramViewInfo.Destroy;
var
  I: Integer;
begin
  for I := 0 to ValueViewInfoCount - 1 do
    ValueViewInfos[I].Free;
  FValueViewInfos.Free;
  inherited;
end;

function TcxGridChartDiagramViewInfo.GetCategory(AIndex: Integer): Variant;
begin
  Result := ViewData.Categories[AIndex];
end;

function TcxGridChartDiagramViewInfo.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartDiagramViewInfo.GetSeries(AIndex: Integer): TcxGridChartSeries;
begin
  Result := GridView.VisibleSeries[AIndex];
end;

function TcxGridChartDiagramViewInfo.GetSeriesCount: Integer;
begin
  Result := GridView.VisibleSeriesCount;
end;

function TcxGridChartDiagramViewInfo.GetValue(ASeriesIndex, AIndex: Integer): Variant;
begin
  Result := GridView.VisibleSeries[ASeriesIndex].Values[AIndex];
end;

function TcxGridChartDiagramViewInfo.GetValueCount: Integer;
begin
  Result := ViewData.ValueCount;
end;

function TcxGridChartDiagramViewInfo.GetValueViewInfo(Index: Integer): TcxGridChartDiagramValueViewInfo;
begin
  Result := TcxGridChartDiagramValueViewInfo(FValueViewInfos[Index]);
end;

function TcxGridChartDiagramViewInfo.GetValueViewInfoCount: Integer;
begin
  Result := FValueViewInfos.Count;
end;

function TcxGridChartDiagramViewInfo.GetViewData: TcxGridChartViewData;
begin
  Result := GridView.ViewData;
end;

procedure TcxGridChartDiagramViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetBackgroundParams(AParams);
end;

procedure TcxGridChartDiagramViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  inherited;
  (AHitTest as TcxCustomGridChartDiagramHitTest).Diagram := Diagram;
end;

function TcxGridChartDiagramViewInfo.CreateValueViewInfo(ASeriesIndex, AValueIndex: Integer): TcxGridChartDiagramValueViewInfo;
begin
  Result := GetValueViewInfoClass.Create(Self, ASeriesIndex, AValueIndex);
  FValueViewInfos.Add(Result);
end;

function TcxGridChartDiagramViewInfo.GetValueCaption(ASeriesIndex, AValueIndex: Integer): string;
begin
  Result := Diagram.GetValueCaption(GridView.VisibleSeries[ASeriesIndex], AValueIndex);
end;

function TcxGridChartDiagramViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to ValueViewInfoCount - 1 do
  begin
    Result := ValueViewInfos[I].GetHitTest(P);
    if Result <> nil then Break;
  end;
end;

{ TcxGridChartColumnDiagramLegendViewInfo }

function TcxGridChartColumnDiagramLegendViewInfo.GetDiagram: TcxGridChartColumnDiagram;
begin
  Result := TcxGridChartColumnDiagram(inherited Diagram);
end;

function TcxGridChartColumnDiagramLegendViewInfo.GetItemObjectIndex(AIndex: Integer): Integer;
begin
  if (Diagram.GetCategoryAxisPosition in [cppTop, cppBottom]) and
    not Diagram.AxisCategory.CategoriesInReverseOrder or
    not (Diagram.GetCategoryAxisPosition in [cppTop, cppBottom]) and
    Diagram.AxisCategory.CategoriesInReverseOrder then
    Result := AIndex
  else
    Result := Count - 1 - AIndex;
end;

function TcxGridChartColumnDiagramLegendViewInfo.GetKind: TcxGridChartLegendKind;
begin
  if Diagram.Values.GetVaryColorsByCategory then
    Result := lkCategories
  else
    Result := lkSeries;
end;

{ TcxGridChartColumnDiagramAxisTitleViewInfo }

constructor TcxGridChartColumnDiagramAxisTitleViewInfo.Create(AContainer: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
  ATitle: TcxCustomGridChartTitle);
begin
  inherited Create(AContainer.GridViewInfo, ATitle);
  FContainer := AContainer;
end;

function TcxGridChartColumnDiagramAxisTitleViewInfo.GetTitle: TcxGridChartColumnDiagramAxisTitle;
begin
  Result := TcxGridChartColumnDiagramAxisTitle(inherited Title);
end;

procedure TcxGridChartColumnDiagramAxisTitleViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  FContainer.GetTitleViewParams(AParams);
end;

procedure TcxGridChartColumnDiagramAxisTitleViewInfo.InitHitTest(AHitTest: TcxCustomGridHitTest);
begin
  FContainer.DiagramViewInfo.InitHitTest(AHitTest);
  inherited;
end;

{ TcxGridChartColumnDiagramTickMarkLabelsViewInfo }

constructor TcxGridChartColumnDiagramTickMarkLabelsViewInfo.Create(ADiagramViewInfo: TcxGridChartColumnDiagramViewInfo);
begin
  inherited Create(ADiagramViewInfo.GridViewInfo);
  FDiagramViewInfo := ADiagramViewInfo;
  FTitleViewInfo := GetTitleViewInfoClass.Create(Self, Axis.Title);
end;

destructor TcxGridChartColumnDiagramTickMarkLabelsViewInfo.Destroy;
begin
  FreeAndNil(FTitleViewInfo);
  inherited;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaptionBounds(Index: Integer): TRect;
begin
  Result := FCaptionBounds[Index];
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaptionHeight: Integer;
begin
  if FCaptionHeight = 0 then
  begin
    CalculateParams;
    Canvas.Font := Params.Font;
    FCaptionHeight := Canvas.TextHeight('Qq');
  end;
  Result := FCaptionHeight;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaptionWidth(Index: Integer): Integer;
begin
  if Index >= Length(FCaptionWidths) then
    SetLength(FCaptionWidths, Index + 1);
  if FCaptionWidths[Index] = 0 then
  begin
    CalculateParams;
    Canvas.Font := Params.Font;
    FCaptionWidths[Index] := Canvas.TextWidth(Captions[Index]);
  end;
  Result := FCaptionWidths[Index];
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetDiagram: TcxGridChartColumnDiagram;
begin
  Result := DiagramViewInfo.Diagram;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetIsVertical: Boolean;
begin
  Result := Position in [cppLeft, cppRight];
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.SetCaptionBounds(Index: Integer;
  const Value: TRect);
begin
  FCaptionBounds[Index] := Value;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartColumnDiagramTickMarkLabelsPainter;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramAxisTitleViewInfo;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaption(Index: Integer): string;
begin
  Result := Values[Index];
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateCaptionBounds(AIndex: Integer): TRect;
var
  ACaptionWidth, ADirection: Integer;
begin
  Result := ContentBounds;
  if IsVertical then
  begin
    Result.Top := GetCaptionPosition(AIndex) - CaptionHeight div 2;
    Result.Bottom := Result.Top + CaptionHeight;
  end
  else
  begin
    ACaptionWidth := CaptionWidths[AIndex];
    Result.Left := GetCaptionPosition(AIndex) - ACaptionWidth div 2;
    Result.Right := Result.Left + ACaptionWidth;
    if IsTwoRowLayout then
    begin
      if IsReverseOrder then
        ADirection := -1
      else
        ADirection := 1;
      if AIndex > 0 then
        Result.Left := Max(Result.Left, GetCaptionPosition(AIndex - ADirection) + cxTextOffset);
      if AIndex < Count - 1 then
        Result.Right := Min(Result.Right, GetCaptionPosition(AIndex + ADirection) - cxTextOffset);
      if Odd(AIndex) then
        Result.Top := Result.Bottom - CaptionHeight;
    end;
  end;
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateCaptionsBounds;
var
  I: Integer;
begin
  SetLength(FCaptionBounds, Count);
  for I := 0 to Count - 1 do
    CaptionBounds[I] := CalculateCaptionBounds(I);
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateHeight(
  AWidth, ALeftReduction, ARightReduction: Integer): Integer;
begin
  IsTwoRowLayout := CalculateIsTwoRowLayout(AWidth, ALeftReduction, ARightReduction);
  if IsVertical then
    Result := 0
  else
  begin
    if CaptionsVisible then
    begin
      Result := CaptionHeight;
      if IsTwoRowLayout then
        Inc(Result, 2 * cxTextOffset + CaptionHeight);
    end
    else
      Result := 0;
    if TitleViewInfo.Visible then
    begin
      if CaptionsVisible then
        Inc(Result, ChartPartOffset);
      Inc(Result, TitleViewInfo.Height);
    end;
  end;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateWidth: Integer;
var
  I: Integer;
begin
  if IsVertical then
  begin
    Result := 0;
    if CaptionsVisible then
      for I := 0 to Count - 1 do
        Result := Max(Result, CaptionWidths[I]);
    if TitleViewInfo.Visible then
    begin
      if CaptionsVisible then
        Inc(Result, ChartPartOffset);
      Inc(Result, TitleViewInfo.Width);
    end;
  end
  else
    Result := 0;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateIsTwoRowLayout(
  AWidth, ALeftReduction, ARightReduction: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  if IsVertical or (Count <= 1) then Exit;
  AWidth := GetCaptionSpace(AWidth, ALeftReduction, ARightReduction);
  for I := 0 to Count - 1 do
  begin
    Result := CaptionWidths[I] > AWidth;
    if Result then Exit;
  end;
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.CalculateTitleBounds(out ATitleBounds, AContentBounds: TRect);
begin
  AContentBounds := CalculateContentBounds;
  if TitleViewInfo.Visible then
  begin
    PositionRect(ATitleBounds, AContentBounds, TitleViewInfo.Width, TitleViewInfo.Height,
      ChartPartOffset, Position);
    with DiagramViewInfo.PlotBounds do
      if IsVertical then
      begin
        ATitleBounds.Top := Top;
        ATitleBounds.Bottom := Bottom;
      end
      else
      begin
        ATitleBounds.Left := Left;
        ATitleBounds.Right := Right;
      end;
    AlignRect(ATitleBounds, TitleViewInfo.Width, TitleViewInfo.Height, not IsVertical,
      TitleViewInfo.Alignment);
  end
  else
    SetRectEmpty(ATitleBounds);
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetAlignmentHorz: TAlignment;
begin
  if IsVertical then
    if Position = cppLeft then
      Result := taRightJustify
    else
      Result := taLeftJustify
  else
    Result := taCenter;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaptionsVisible: Boolean;
begin
  Result := Axis.TickMarkLabels;
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetEdgeCaptionsReductions(
  var ALeftReduction, ARightReduction: Integer);
begin
  ALeftReduction := Max(ALeftReduction, CaptionWidths[0] div 2);
  ARightReduction := Max(ARightReduction, CaptionWidths[Count - 1] div 2);
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetTextAttributes(AForPainting: Boolean): Integer;
begin
  Result := inherited GetTextAttributes(AForPainting) or cxDontClip or cxShowEndEllipsis;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetVisible: Boolean;
begin
 Result := CaptionsVisible or TitleViewInfo.Visible;
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.Calculate(ALeftBound, ATopBound: Integer;
  AWidth: Integer = -1; AHeight: Integer = -1);
var
  ATitleBounds: TRect;
begin
  inherited;
  CalculateTitleBounds(ATitleBounds, FContentBounds);
  CalculateCaptionsBounds;
  if TitleViewInfo.Visible then
    TitleViewInfo.Calculate(ATitleBounds);
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.FitCaptionsHorz(AWidth: Integer;
  var ALeftReduction, ARightReduction: Integer);
var
  ACaptionSpace, ALeftOffset, ARightOffset: Integer;
begin
  if not CaptionsVisible then Exit;
  if IsTwoRowLayout and not IsEdgeCaptions then
  begin
    ACaptionSpace := GetCaptionSpace(AWidth, ALeftReduction, ARightReduction);
    ALeftOffset := Max(0, (CaptionWidths[0] - ACaptionSpace) div 2 - ALeftReduction);
    ARightOffset := Max(0, (CaptionWidths[Count - 1] - ACaptionSpace) div 2 - ARightReduction);

    Inc(ALeftReduction, MulDiv((2 * ARightOffset + (4 * Count - 2) * ALeftOffset), 1, 4 * Count - 4));
    Inc(ARightReduction, MulDiv((2 * ALeftOffset + (4 * Count - 2) * ARightOffset), 1, 4 * Count - 4));
  end
  else
    if IsEdgeCaptions and (Count <> 0) then
      GetEdgeCaptionsReductions(ALeftReduction, ARightReduction);
end;

procedure TcxGridChartColumnDiagramTickMarkLabelsViewInfo.FitCaptionsVert(
  var ATopReduction, ABottomReduction: Integer);
begin
  if not CaptionsVisible then Exit; 
  if IsEdgeCaptions then
  begin
    ATopReduction := Max(ATopReduction, CaptionHeight div 2);
    ABottomReduction := Max(ABottomReduction, CaptionHeight div 2);
  end;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetCaptionSpace(
  AWidth, ALeftReduction, ARightReduction: Integer): Integer;
var
  ACount: Integer;
begin
  ACount := Count;
  if IsEdgeCaptions then
  begin
    Dec(ACount);
    GetEdgeCaptionsReductions(ALeftReduction, ARightReduction);
  end;
  Dec(AWidth, ALeftReduction + ARightReduction);
  Result := AWidth div ACount - 4 * cxTextOffset;
end;

function TcxGridChartColumnDiagramTickMarkLabelsViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := FTitleViewInfo.GetHitTest(P);
end;

{ TcxGridChartColumnDiagramCategoryAxisTitleViewInfo }

function TcxGridChartColumnDiagramCategoryAxisTitleViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartHistogramCategoryAxisTitleHitTest;
end;

{ TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo }

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramCategoryAxisTitleViewInfo;
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetCount: Integer;
begin
  Result := DiagramViewInfo.ValueCount;
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetIsReverseOrder: Boolean;
begin
  Result := DiagramViewInfo.IsCategoriesInReverseOrder;
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetValue(Index: Integer): Variant;
begin
  Result := DiagramViewInfo.Categories[Index];
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetAxis: TcxGridChartColumnDiagramAxis;
begin
  Result := Diagram.AxisCategory;
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetCaptionPosition(Index: Integer): Integer;
begin
  Result := DiagramViewInfo.GetUnitOffset(DiagramViewInfo.CalculateCategoryMarkValue(Index, False));
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetIsEdgeCaptions: Boolean;
begin
  Result := False;
end;

function TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetPosition: TcxGridChartAxisPosition;
begin
  Result := DiagramViewInfo.CategoryAxisPosition;
end;

procedure TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetTitleViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsCategoryAxisTitle, nil, nil, AParams);
end;

procedure TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsCategoryAxis, nil, nil, AParams);
end;

{ TcxGridChartColumnDiagramValueAxisTitleViewInfo }

function TcxGridChartColumnDiagramValueAxisTitleViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartHistogramValueAxisTitleHitTest;
end;

{ TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo }

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetAxisValue: TcxGridChartColumnDiagramAxisValue;
begin
  Result := TcxGridChartColumnDiagramAxisValue(inherited Axis);
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetTitleViewInfoClass: TcxGridChartColumnDiagramAxisTitleViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramValueAxisTitleViewInfo;
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetCaption(Index: Integer): string;
begin
  Result := Axis.GetTickMarkLabel(Values[Index]);
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetCount: Integer;
begin
  Result := DiagramViewInfo.ValueMarkCount;
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetIsReverseOrder: Boolean;
begin
  Result := False;
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetValue(Index: Integer): Variant;
begin
  Result := DiagramViewInfo.ValueMarkValues[Index];
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetAxis: TcxGridChartColumnDiagramAxis;
begin
  Result := Diagram.AxisValue;
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetCaptionPosition(Index: Integer): Integer;
begin
  Result := DiagramViewInfo.ValueMarkPositions[Index];
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetIsEdgeCaptions: Boolean;
begin
  Result := True;
end;

function TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetPosition: TcxGridChartAxisPosition;
begin
  Result := DiagramViewInfo.ValueAxisPosition;
end;

procedure TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetTitleViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsValueAxisTitle, nil, nil, AParams);
end;

procedure TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsValueAxis, nil, nil, AParams);
end;

{ TcxGridChartColumnDiagramValueViewInfo }

function TcxGridChartColumnDiagramValueViewInfo.GetCaptionPosition: TcxGridChartColumnDiagramValueCaptionPosition;
begin
  Result := DiagramViewInfo.Diagram.Values.CaptionPosition;
end;

function TcxGridChartColumnDiagramValueViewInfo.GetDiagramViewInfo: TcxGridChartColumnDiagramViewInfo;
begin
  Result := TcxGridChartColumnDiagramViewInfo(inherited DiagramViewInfo);
end;

function TcxGridChartColumnDiagramValueViewInfo.CalculateCaptionBounds: TRect;

  function GetVerticalValueCaptionBounds(ACaptionWidth, ACaptionHeight: Integer;
    AIsUpDirection: Boolean): TRect;
  begin
    Result := ContentBounds;
    with Result do
    begin
      Left := GetRangeCenter(Left, Right) - ACaptionWidth div 2;
      Right := Left + ACaptionWidth;
      case CaptionPosition of
        cdvcpInsideBase:
          if AIsUpDirection then
            Top := Bottom - ACaptionHeight
          else
            Bottom := Top + ACaptionHeight;
        cdvcpInsideEnd:
          if AIsUpDirection then
            Bottom := Top + ACaptionHeight
          else
            Top := Bottom - ACaptionHeight;
        cdvcpOutsideEnd:
          if AIsUpDirection then
          begin
            Bottom := Self.Bounds.Top;
            Top := Bottom - ACaptionHeight;
          end
          else
          begin
            Top := Self.Bounds.Bottom;
            Bottom := Top + ACaptionHeight;
          end;
      end;
    end;  
  end;

  function GetHorizontalValueCaptionBounds(ACaptionWidth, ACaptionHeight: Integer;
    AIsRightDirection: Boolean): TRect;
  begin
    Result := ContentBounds;
    with Result do
    begin
      Top := GetRangeCenter(Top, Bottom) - ACaptionHeight div 2;
      Bottom := Top + ACaptionHeight;
      case CaptionPosition of
        cdvcpInsideBase:
          if AIsRightDirection then
            Right := Left + ACaptionWidth
          else
            Left := Right - ACaptionWidth;
        cdvcpInsideEnd:
          if AIsRightDirection then
            Left := Right - ACaptionWidth
          else
            Right := Left + ACaptionWidth;
        cdvcpOutsideEnd:
          if AIsRightDirection then
          begin
            Left := Self.Bounds.Right;
            Right := Left + ACaptionWidth;
          end
          else
          begin
            Right := Self.Bounds.Left;
            Left := Right - ACaptionWidth;
          end;
      end;
    end;  
  end;

var
  AIsPositive: Boolean;
begin
  AIsPositive := DiagramViewInfo.IsValuePositive(ValueIndex, SeriesIndex);
  if DiagramViewInfo.IsValueAxisVert then
    Result := GetVerticalValueCaptionBounds(CaptionViewInfo.CalculateWidth,
      CaptionViewInfo.CalculateHeight, AIsPositive)
  else
    Result := GetHorizontalValueCaptionBounds(CaptionViewInfo.CalculateWidth,
      CaptionViewInfo.CalculateHeight, AIsPositive);
end;

function TcxGridChartColumnDiagramValueViewInfo.GetBorderColor(AIndex: TcxBorder): TColor;
begin
  Result := Params.TextColor;
end;

function TcxGridChartColumnDiagramValueViewInfo.GetBorders: TcxBorders;
begin
  Result := cxBordersAll;
end;

function TcxGridChartColumnDiagramValueViewInfo.GetBorderWidth(AIndex: TcxBorder): Integer;
begin
  Result := DiagramViewInfo.Diagram.Values.BorderWidth;
end;

procedure TcxGridChartColumnDiagramValueViewInfo.GetCaptionViewParams(var AParams: TcxViewParams);
begin
  DiagramViewInfo.Diagram.Styles.GetViewParams(dsValueCaptions, nil, nil, AParams);
end;

function TcxGridChartColumnDiagramValueViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartColumnDiagramValuePainter;
end;

procedure TcxGridChartColumnDiagramValueViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  DiagramViewInfo.Diagram.Styles.GetValueParams(SeriesIndex, ValueIndex, AParams);
end;

function TcxGridChartColumnDiagramValueViewInfo.HasCaption: Boolean;
begin
  Result := CaptionPosition <> cdvcpNone;
end;

{ TcxGridChartColumnDiagramViewInfo }

constructor TcxGridChartColumnDiagramViewInfo.Create(AGridViewInfo: TcxCustomGridViewInfo;
  ADiagram: TcxGridChartDiagram);
begin
  inherited;
  FCategoryTickMarkLabelsViewInfo := GetCategoryTickMarkLabelsViewInfoClass.Create(Self);
  FValueTickMarkLabelsViewInfo := GetValueTickMarkLabelsViewInfoClass.Create(Self);
end;

destructor TcxGridChartColumnDiagramViewInfo.Destroy;
begin
  FValueTickMarkLabelsViewInfo.Free;
  FCategoryTickMarkLabelsViewInfo.Free;
  inherited;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryAxisColor: TColor;
var
  AParams: TcxViewParams;
begin
  Diagram.Styles.GetViewParams(dsCategoryAxis, nil, nil, AParams);
  Result := AParams.Color;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryGridLineColor: TColor;
var
  AParams: TcxViewParams;
begin
  Diagram.Styles.GetViewParams(dsCategoryGridLines, nil, nil, AParams);
  Result := AParams.Color;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryMarkCount: Integer;
begin
  Result := Length(FCategoryMarks);
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryMarkPosition(Index: Integer): Integer;
begin
  Result := FCategoryMarks[Index].Position;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryMarkValue(Index: Integer): Integer;
begin
  Result := FCategoryMarks[Index].Value;
end;

function TcxGridChartColumnDiagramViewInfo.GetDiagram: TcxGridChartColumnDiagram;
begin
  Result := TcxGridChartColumnDiagram(inherited Diagram);
end;

function TcxGridChartColumnDiagramViewInfo.GetHasCategoryAxis: Boolean;
begin
  Result := Diagram.AxisCategory.Visible and (ValueCount <> 0);
end;

function TcxGridChartColumnDiagramViewInfo.GetHasCategoryGridLines: Boolean;
begin
  Result := Diagram.AxisCategory.GridLines;
end;

function TcxGridChartColumnDiagramViewInfo.GetHasValueAxis: Boolean;
begin
  Result := Diagram.AxisValue.Visible and (ValueCount <> 0);
end;

function TcxGridChartColumnDiagramViewInfo.GetHasValueGridLines: Boolean;
begin
  Result := Diagram.AxisValue.GridLines;
end;

function TcxGridChartColumnDiagramViewInfo.GetIsCategoriesInReverseOrder: Boolean;
begin
  Result := Diagram.AxisCategory.CategoriesInReverseOrder;
end;

function TcxGridChartColumnDiagramViewInfo.GetIsCategoryAxisHorz: Boolean;
begin
  Result := CategoryAxisPosition in [cppTop, cppBottom];
end;

function TcxGridChartColumnDiagramViewInfo.GetIsValueAxisVert: Boolean;
begin
  Result := ValueAxisPosition in [cppLeft, cppRight];
end;

function TcxGridChartColumnDiagramViewInfo.GetPlotBounds: TRect;
begin
  if not FIsPlotBoundsCalculated then
  begin
    FPlotBounds := CalculatePlotBounds;
    FIsPlotBoundsCalculated := True;
  end;
  Result := FPlotBounds;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueAxisColor: TColor;
var
  AParams: TcxViewParams;
begin
  Diagram.Styles.GetViewParams(dsValueAxis, nil, nil, AParams);
  Result := AParams.Color;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueGridLineColor: TColor;
var
  AParams: TcxViewParams;
begin
  Diagram.Styles.GetViewParams(dsValueGridLines, nil, nil, AParams);
  Result := AParams.Color;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueMarkCount: Integer;
begin
  Result := Length(FValueMarks);
end;

function TcxGridChartColumnDiagramViewInfo.GetValueMarkPosition(Index: Integer): Integer;
begin
  Result := FValueMarks[Index].Position;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueMarkValue(Index: Integer): Extended;
begin
  Result := FValueMarks[Index].Value;
end;

function TcxGridChartColumnDiagramViewInfo.GetZeroValueOffset: Integer;
begin
  Result := GetValueOffset(0);
end;

procedure TcxGridChartColumnDiagramViewInfo.SetCategoryMarkPosition(Index: Integer; Value: Integer);
begin
  FCategoryMarks[Index].Position := Value;
end;

procedure TcxGridChartColumnDiagramViewInfo.SetValueMarkPosition(Index: Integer; Value: Integer);
begin
  FValueMarks[Index].Position := Value;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryTickMarkLabelsViewInfoClass: TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramCategoryTickMarkLabelsViewInfo;
end;

function TcxGridChartColumnDiagramViewInfo.GetPainterClass: TcxCustomGridCellPainterClass;
begin
  Result := TcxGridChartColumnDiagramPainter;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueTickMarkLabelsViewInfoClass: TcxGridChartColumnDiagramValueTickMarkLabelsViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramValueTickMarkLabelsViewInfo;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueViewInfoClass: TcxGridChartDiagramValueViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramValueViewInfo;
end;

procedure TcxGridChartColumnDiagramViewInfo.DoCalculateParams;
begin
  inherited;
  GetPlotBackgroundParams(PlotParams);
end;

procedure TcxGridChartColumnDiagramViewInfo.GetPlotBackgroundParams(out AParams: TcxViewParams);
begin
  Diagram.Styles.GetViewParams(dsPlot, nil, nil, AParams);
end;

function TcxGridChartColumnDiagramViewInfo.GetUnitCount: Integer;
begin
  Result := ValueCount * GetValueGroupAreaSizeUnits;
end;

function TcxGridChartColumnDiagramViewInfo.GetUnitOffset(AIndex: Integer): Integer;
var
  AOffset: Integer;
begin
  with PlotBounds do
    if IsCategoryAxisHorz then
    begin
      AOffset := MulDiv(Right - Left, AIndex, UnitCount);
      if IsCategoriesInReverseOrder then
        Result := Right - AOffset
      else
        Result := Left + AOffset;
    end
    else
    begin
      AOffset := MulDiv(Bottom - Top, AIndex, UnitCount);
      if IsCategoriesInReverseOrder then
        Result := Top + AOffset
      else
        Result := Bottom - AOffset;
    end;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueGroupAreaSizeUnits: Integer;
begin
  Result := SeriesCount * ValueSizeUnits + 2 * ValueOffsetUnits;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueOffsetUnits(AValueIndex, ASeriesIndex: Integer): Integer;
begin
  Result := AValueIndex * GetValueGroupAreaSizeUnits + ValueOffsetUnits + ASeriesIndex * ValueSizeUnits;
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateMinMaxValues(out AMinValue, AMaxValue: Extended);
var
  I, J: Integer;
  AValue: Extended;
begin
  AMinValue := 0;
  AMaxValue := 0;
  for I := 0 to ValueCount - 1 do
    for J := 0 to SeriesCount - 1 do
    begin
      AValue := Values[J, I];
      AMinValue := Min(AMinValue, AValue);
      AMaxValue := Max(AMaxValue, AValue);
    end;
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateMinMaxVisualValues(out AMinVisualValue, AMaxVisualValue: Extended);
begin
  if ValueStep = 0 then
  begin
    AMinVisualValue := MinValue;
    AMaxVisualValue := MaxValue;
  end
  else
  begin
    AMinVisualValue := Floor(MinValue / ValueStep);
    if (MinValue <> 0) and (Fraction(MinValue / ValueStep) = 0) then
      AMinVisualValue := AMinVisualValue - 1;
    AMinVisualValue := AMinVisualValue * ValueStep;
    
    AMaxVisualValue := Ceil(MaxValue / ValueStep);
    if (MaxValue <> 0) and (Fraction(MaxValue / ValueStep) = 0) then
      AMaxVisualValue := AMaxVisualValue + 1;
    AMaxVisualValue := AMaxVisualValue * ValueStep;
  end;
  if AMaxVisualValue - AMinVisualValue = 0 then
    AMaxVisualValue := AMinVisualValue + 1;
end;

function TcxGridChartColumnDiagramViewInfo.CalculateValueStep: Extended;
const
  MaxStepCount = 10;
  BaseStepCount = 3;
  BaseSteps: array[0..BaseStepCount - 1] of Integer = (1, 2, 5);
var
  AStep: Extended;
  AIntMultiple10, ABaseStepIndex: Integer;
begin
  AStep := (FMaxValue - FMinValue) / MaxStepCount;
  if AStep = 0 then
  begin
    Result := 0;
    Exit;
  end;
  AIntMultiple10 := Floor(Log10(AStep));
  if (AIntMultiple10 < 0) and IsDataInteger then
    AIntMultiple10 := 0;
  ABaseStepIndex := 0;
  repeat
    Result := BaseSteps[ABaseStepIndex] * IntPower(10, AIntMultiple10);
    if Result > AStep then Break;
    Inc(ABaseStepIndex);
    if ABaseStepIndex = BaseStepCount then
    begin
      ABaseStepIndex := 0;
      Inc(AIntMultiple10);
    end;
  until False;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueOffset(const AValue: Variant): Integer;
var
  AIsVertical: Boolean;
  AAreaSize, AOffset: Integer;
begin
  AIsVertical := IsValueAxisVert;
  with PlotBounds do
  begin
    if AIsVertical then
      AAreaSize := Bottom - Top - ValueGridLineWidth
    else
      AAreaSize := Right - Left - ValueGridLineWidth;
    AOffset := AAreaSize * (AValue - MinVisualValue) / (MaxVisualValue - MinVisualValue);
    if AIsVertical then
      Result := Bottom - ValueGridLineWidth - AOffset
    else
      Result := Left + AOffset;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.IsDataInteger: Boolean;
var
  I: Integer;
begin
  for I := 0 to SeriesCount - 1 do
  begin
    Result := Series[I].DataBinding.IsValueTypeInteger;
    if not Result then Exit;
  end;
  Result := True;
end;

function TcxGridChartColumnDiagramViewInfo.IsValuePositive(AValueIndex, ASeriesIndex: Integer): Boolean;
begin
  Result := Values[ASeriesIndex, AValueIndex] >= 0;
end;

procedure TcxGridChartColumnDiagramViewInfo.AddMark(var AMarks: TcxGridChartColumnDiagramMarks;
  const AValue: Variant);
begin
  SetLength(AMarks, Length(AMarks) + 1);
  AMarks[Length(AMarks) - 1].Value := AValue;
end;

procedure TcxGridChartColumnDiagramViewInfo.AddCategoryMark(AValue: Integer);
begin
  AddMark(FCategoryMarks, AValue);
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateCategoryMarkPositions;
var
  I, APosition: Integer;
begin
  for I := 0 to CategoryMarkCount - 1 do
  begin
    APosition := GetUnitOffset(CategoryMarkValues[I]);
    if IsCategoryAxisHorz and (CategoryMarkValues[I] = UnitCount) or
      not IsCategoryAxisHorz and (CategoryMarkValues[I] = 0) then
      Dec(APosition, CategoryGridLineWidth);
    CategoryMarkPositions[I] := APosition;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.CalculateCategoryMarkValue(AIndex: Integer;
  AValueAxisBetweenCategories: Boolean): Integer;
begin
  if AValueAxisBetweenCategories then
    Result := 0
  else
    Result := 1;
  Result := GetValueGroupAreaSizeUnits * (Result + 2 * AIndex) div 2;
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateCategoryMarkValues;
var
  ACount, I: Integer;
begin
  if ValueCount = 0 then Exit;
  ACount := ValueCount;
  if Diagram.AxisCategory.ValueAxisBetweenCategories then
    Inc(ACount);
  for I := 0 to ACount - 1 do
    AddCategoryMark(CalculateCategoryMarkValue(I, Diagram.AxisCategory.ValueAxisBetweenCategories));
end;

procedure TcxGridChartColumnDiagramViewInfo.AddValueMark(const AValue: Extended);
begin
  AddMark(FValueMarks, AValue);
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateValueMarkPositions;
var
  I: Integer;
begin
  for I := 0 to ValueMarkCount - 1 do
    ValueMarkPositions[I] := GetValueOffset(ValueMarkValues[I]);
end;

procedure TcxGridChartColumnDiagramViewInfo.CalculateValueMarkValues;
var
  AValue: Extended;
begin
  if ValueStep = 0 then Exit;
  AValue := MinVisualValue;
  repeat
    AddValueMark(AValue);
    AValue := AValue + ValueStep;
  until AValue > MaxVisualValue;
end;

function TcxGridChartColumnDiagramViewInfo.CalculateCategoryMarkHeight: Integer;
begin
  Result := MulDiv(CategoryTickMarkLabelsViewInfo.CaptionHeight, 1, 4);
end;

function TcxGridChartColumnDiagramViewInfo.CalculateValueMarkHeight: Integer;
begin
  Result := MulDiv(ValueTickMarkLabelsViewInfo.CaptionHeight, 1, 4);
end;

function TcxGridChartColumnDiagramViewInfo.CalculatePlotBounds: TRect;
var
  AReductions: TRect;
  ACaptionsViewInfoHorz, ACaptionsViewInfoVert: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;

  procedure ProcessVerticalAxisCaptions(ACaptionsViewInfo: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
    var AReductions: TRect);
  var
    AReduction: Integer;
  begin
    if not ACaptionsViewInfo.Visible then Exit;
    AReduction := TickMarkLabelsOffset + ACaptionsViewInfo.CalculateWidth;
    if ACaptionsViewInfo.Position = cppLeft then
      AReductions.Left := Max(AReductions.Left, AReduction)
    else
      AReductions.Right := Max(AReductions.Right, AReduction);
    ACaptionsViewInfo.FitCaptionsVert(AReductions.Top, AReductions.Bottom);
  end;

  procedure ProcessHorizontalAxisCaptions(ACaptionsViewInfo: TcxGridChartColumnDiagramTickMarkLabelsViewInfo;
    var AReductions: TRect; APlotWidth: Integer);
  var
    AReduction: Integer;
  begin
    if not ACaptionsViewInfo.Visible then Exit;
    AReduction := TickMarkLabelsOffset +
      ACaptionsViewInfo.CalculateHeight(APlotWidth, AReductions.Left, AReductions.Right);
    if ACaptionsViewInfo.Position = cppTop then
      AReductions.Top := Max(AReductions.Top, AReduction)
    else
      AReductions.Bottom := Max(AReductions.Bottom, AReduction);
    ACaptionsViewInfoHorz.FitCaptionsHorz(APlotWidth, AReductions.Left, AReductions.Right);
  end;

begin
  Result := Bounds;
  SetRectEmpty(AReductions);

  if ValueTickMarkLabelsViewInfo.IsVertical then
  begin
    ACaptionsViewInfoHorz := CategoryTickMarkLabelsViewInfo;
    ACaptionsViewInfoVert := ValueTickMarkLabelsViewInfo;
  end
  else
  begin
    ACaptionsViewInfoHorz := ValueTickMarkLabelsViewInfo;
    ACaptionsViewInfoVert := CategoryTickMarkLabelsViewInfo;
  end;

  ProcessVerticalAxisCaptions(ACaptionsViewInfoVert, AReductions);
  ProcessHorizontalAxisCaptions(ACaptionsViewInfoHorz, AReductions, Result.Right - Result.Left);

  Inc(Result.Left, AReductions.Left);
  Dec(Result.Right, AReductions.Right);
  Inc(Result.Top, AReductions.Top);
  Dec(Result.Bottom, AReductions.Bottom);
  with Result do
  begin
    if Left > Right then Left := Right;
    if Top > Bottom then Top := Bottom;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryAxisBounds: TRect;
begin
  Result := PlotBounds;
  if IsCategoryAxisHorz then
  begin
    Result.Top := ZeroValueOffset;
    Result.Bottom := Result.Top + CategoryAxisWidth;
  end
  else
  begin
    Result.Left := ZeroValueOffset;
    Result.Right := Result.Left + CategoryAxisWidth;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryAxisPosition: TcxGridChartAxisPosition;
begin
  Result := Diagram.GetCategoryAxisPosition;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryGridLineBounds(AIndex: Integer): TRect;
begin
  Result := PlotBounds;
  if IsCategoryAxisHorz then
  begin
    Result.Left := CategoryMarkPositions[AIndex];
    Result.Right := Result.Left + CategoryGridLineWidth;
  end
  else
  begin
    Result.Top := CategoryMarkPositions[AIndex];
    Result.Bottom := Result.Top + CategoryGridLineWidth;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryMarkBounds(Index: Integer): TRect;
var
  AIsHorizontal: Boolean;
begin
  AIsHorizontal := IsCategoryAxisHorz;

  Result := CategoryAxisBounds;
  if AIsHorizontal then
  begin
    Result.Left := CategoryMarkPositions[Index];
    Result.Right := Result.Left + MarkWidth;
  end
  else
  begin
    Result.Top := CategoryMarkPositions[Index];
    Result.Bottom := Result.Top + MarkWidth;
  end;

  if Diagram.AxisCategory.TickMarkKind in [tmkCross, tmkInside] then
    if AIsHorizontal then
      Dec(Result.Top, CategoryMarkHeight)
    else
      Inc(Result.Right, CategoryMarkHeight);
  if Diagram.AxisCategory.TickMarkKind in [tmkCross, tmkOutside] then
    if AIsHorizontal then
      Inc(Result.Bottom, CategoryMarkHeight)
    else
      Dec(Result.Left, CategoryMarkHeight);
end;

function TcxGridChartColumnDiagramViewInfo.GetCategoryTickMarkLabelsBounds: TRect;
begin
  Result := GetTickMarkLabelsBounds(CategoryAxisPosition);
end;

function TcxGridChartColumnDiagramViewInfo.GetTickMarkLabelsBounds(APosition: TcxGridChartAxisPosition): TRect;
begin
  Result := Bounds;
  case APosition of
    cppLeft:
      Result.Right := PlotBounds.Left - TickMarkLabelsOffset;
    cppRight:
      Result.Left := PlotBounds.Right + TickMarkLabelsOffset;
    cppTop:
      Result.Bottom := PlotBounds.Top - TickMarkLabelsOffset;
    cppBottom:
      Result.Top := PlotBounds.Bottom + TickMarkLabelsOffset;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueAxisBounds: TRect;
begin
  Result := PlotBounds;
  if IsValueAxisVert then
  begin
    if (ValueAxisPosition = cppLeft) xor IsCategoriesInReverseOrder then
      Result.Left := CategoryMarkPositions[0]
    else
      Result.Left := CategoryMarkPositions[CategoryMarkCount - 1];
    Result.Right := Result.Left + ValueAxisWidth;
  end
  else
  begin
    if (ValueAxisPosition = cppBottom) xor IsCategoriesInReverseOrder then
      Result.Top := CategoryMarkPositions[0]
    else
      Result.Top := CategoryMarkPositions[CategoryMarkCount - 1];
    Result.Bottom := Result.Top + ValueAxisWidth;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueAxisPosition: TcxGridChartAxisPosition;
begin
  Result := Diagram.GetValueAxisPosition;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueBounds(AValueIndex, ASeriesIndex: Integer): TRect;
var
  ACategoryOffset, ACategoryOffsetStart, ACategoryOffsetFinish, AValueOffsetStart, AValueOffsetFinish: Integer;
begin
  ACategoryOffset := GetValueOffsetUnits(AValueIndex, ASeriesIndex);
  ACategoryOffsetStart := GetUnitOffset(ACategoryOffset);
  ACategoryOffsetFinish := GetUnitOffset(ACategoryOffset + ValueSizeUnits);
  AValueOffsetStart := ZeroValueOffset;
  AValueOffsetFinish := GetValueOffset(Values[ASeriesIndex, AValueIndex]);

  if IsValueAxisVert then
  begin
    Result.Left := ACategoryOffsetStart;
    Result.Right := ACategoryOffsetFinish;
    Result.Bottom := AValueOffsetStart;
    Result.Top := AValueOffsetFinish;
    CheckRectBounds(Result);
    Inc(Result.Bottom, ValueGridLineWidth);
  end
  else
  begin
    Result.Bottom := ACategoryOffsetStart;
    Result.Top := ACategoryOffsetFinish;
    Result.Left := AValueOffsetStart;
    Result.Right := AValueOffsetFinish;
    CheckRectBounds(Result);
    Inc(Result.Right, ValueGridLineWidth);
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueGridLineBounds(AIndex: Integer): TRect;
begin
  Result := PlotBounds;
  if IsValueAxisVert then
  begin
    Result.Top := ValueMarkPositions[AIndex];
    Result.Bottom := Result.Top + ValueGridLineWidth;
  end
  else
  begin
    Result.Left := ValueMarkPositions[AIndex];
    Result.Right := Result.Left + ValueGridLineWidth;
  end;
end;

function TcxGridChartColumnDiagramViewInfo.GetValueMarkBounds(Index: Integer): TRect;
var
  AIsVertical: Boolean;
  AMarkKind: TcxGridChartHistogramTickMarkKind;
begin
  Result := ValueAxisBounds;
  AIsVertical := IsValueAxisVert;
  if AIsVertical then
  begin
    Result.Top := ValueMarkPositions[Index];
    Result.Bottom := Result.Top + MarkWidth;
  end
  else
  begin
    Result.Left := ValueMarkPositions[Index];
    Result.Right := Result.Left + MarkWidth;
  end;
  AMarkKind := Diagram.AxisValue.TickMarkKind;
  if (AMarkKind = tmkCross) or
    (ValueAxisPosition in [cppRight, cppTop]) and (AMarkKind = tmkInside) or
    (ValueAxisPosition in [cppLeft, cppBottom]) and (AMarkKind = tmkOutside) then
    if AIsVertical then
      Dec(Result.Left, ValueMarkHeight)
    else
      Inc(Result.Bottom, ValueMarkHeight);
  if (AMarkKind = tmkCross) or
    (ValueAxisPosition in [cppRight, cppTop]) and (AMarkKind = tmkOutside) or
    (ValueAxisPosition in [cppLeft, cppBottom]) and (AMarkKind = tmkInside) then
    if AIsVertical then
      Inc(Result.Right, ValueMarkHeight)
    else
      Dec(Result.Top, ValueMarkHeight);
end;

function TcxGridChartColumnDiagramViewInfo.GetValueTickMarkLabelsBounds: TRect;
begin
  Result := GetTickMarkLabelsBounds(ValueAxisPosition);
end;

function TcxGridChartColumnDiagramViewInfo.CustomDrawPlot(ACanvas: TcxCanvas): Boolean;
begin
  Result := False;
  Diagram.DoCustomDrawPlot(ACanvas, Self, PlotBounds, Result);
end;

function TcxGridChartColumnDiagramViewInfo.DoCustomDrawPlot(ACanvas: TcxCanvas): Boolean;
begin
  Result := HasCustomDrawPlot;
  if Result then
  begin
    ACanvas.SetParams(PlotParams);
    Result := CustomDrawPlot(ACanvas);
    if not Result then
      ACanvas.GetParams(PlotParams);
  end;
end;

function TcxGridChartColumnDiagramViewInfo.HasCustomDrawPlot: Boolean;
begin
  Result := Diagram.HasCustomDrawPlot;
end;

procedure TcxGridChartColumnDiagramViewInfo.Calculate(const ABounds: TRect);
var
  AValueIndex, ASeriesIndex: Integer;
begin
  inherited;
  CalculateMinMaxValues(FMinValue, FMaxValue);
  FValueStep := CalculateValueStep;
  CalculateMinMaxVisualValues(FMinVisualValue, FMaxVisualValue);
  CalculateCategoryMarkValues;
  CalculateValueMarkValues;

  FCategoryMarkHeight := CalculateCategoryMarkHeight;
  FValueMarkHeight := CalculateValueMarkHeight;
  CalculateCategoryMarkPositions;
  CalculateValueMarkPositions;
  if CategoryTickMarkLabelsViewInfo.Visible then
    CategoryTickMarkLabelsViewInfo.Calculate(GetCategoryTickMarkLabelsBounds);
  if ValueTickMarkLabelsViewInfo.Visible then
    ValueTickMarkLabelsViewInfo.Calculate(GetValueTickMarkLabelsBounds);

  for AValueIndex := 0 to ValueCount - 1 do
    for ASeriesIndex := 0 to SeriesCount - 1 do
      CreateValueViewInfo(ASeriesIndex, AValueIndex).Calculate(GetValueBounds(AValueIndex, ASeriesIndex));
end;

function TcxGridChartColumnDiagramViewInfo.GetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  Result := inherited GetHitTest(P);
  if Result = nil then
    if PtInRect(PlotBounds, P) then
    begin
      Result := TcxGridChartHistogramPlotHitTest.Instance(P);
      InitHitTest(Result);
    end
    else
    begin
      Result := CategoryTickMarkLabelsViewInfo.GetHitTest(P);
      if Result = nil then
        Result := ValueTickMarkLabelsViewInfo.GetHitTest(P);
    end;
end;

{ TcxGridChartTitleViewInfo }

function TcxGridChartTitleViewInfo.GetHitTestClass: TcxCustomGridHitTestClass;
begin
  Result := TcxGridChartTitleHitTest;
end;

procedure TcxGridChartTitleViewInfo.GetViewParams(var AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsTitle, nil, nil, AParams);
end;

{ TcxGridChartViewInfo }

function TcxGridChartViewInfo.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

procedure TcxGridChartViewInfo.CreateViewInfos;
var
  ADiagram: TcxGridChartDiagram;
begin
  inherited;
  ADiagram := GridView.ActiveDiagram;
  if ADiagram <> nil then
  begin
    FDiagramViewInfo := ADiagram.GetViewInfoClass.Create(Self, ADiagram);
    FLegendViewInfo := ADiagram.GetLegendViewInfoClass.Create(Self, ADiagram);
  end;
  FTitleViewInfo := GetTitleViewInfoClass.Create(Self, GridView.Title);
end;

procedure TcxGridChartViewInfo.DestroyViewInfos(AIsRecreating: Boolean);
begin
  FreeAndNil(FTitleViewInfo);
  FreeAndNil(FLegendViewInfo);
  FreeAndNil(FDiagramViewInfo);
  inherited;
end;

function TcxGridChartViewInfo.GetTitleViewInfoClass: TcxGridChartTitleViewInfoClass;
begin
  Result := TcxGridChartTitleViewInfo;
end;

procedure TcxGridChartViewInfo.Calculate;
var
  ADiagramBounds, ALegendBounds, ATitleBounds: TRect;
begin
  RecreateViewInfos;
  inherited;
  CalculatePartsBounds(ADiagramBounds, ALegendBounds, ATitleBounds);
  if FDiagramViewInfo <> nil then
    FDiagramViewInfo.Calculate(ADiagramBounds);
  if FLegendViewInfo <> nil then
    FLegendViewInfo.Calculate(ALegendBounds);
  FTitleViewInfo.Calculate(ATitleBounds);
end;

function TcxGridChartViewInfo.CalculateClientBounds: TRect;
begin
  Result := inherited CalculateClientBounds;
  InflateRect(Result, -ChartPartOffset, -ChartPartOffset);
end;

procedure TcxGridChartViewInfo.CalculateHeight(const AMaxSize: TPoint;
  var AHeight: Integer; var AFullyVisible: Boolean);
begin
  AHeight := MaxInt div 2;
  AFullyVisible := False;
  inherited;
end;

procedure TcxGridChartViewInfo.CalculatePartBounds(APart: TcxCustomGridChartPartViewInfo;
  var ABounds, APartBounds: TRect);
begin
  if APart.Visible then
  begin
    PositionRect(APartBounds, ABounds, APart.Width, APart.Height, ChartPartOffset, APart.Position);
    AlignRect(APartBounds, APart.Width, APart.Height,
      APart.Position in [cppTop, cppBottom], APart.Alignment);
  end
  else
    SetRectEmpty(APartBounds);
end;

procedure TcxGridChartViewInfo.CalculatePartsBounds(out ADiagramBounds, ALegendBounds, ATitleBounds: TRect);
begin
  ADiagramBounds := ClientBounds;
  CalculatePartBounds(FTitleViewInfo, ADiagramBounds, ATitleBounds);
  if FLegendViewInfo <> nil then
    CalculatePartBounds(FLegendViewInfo, ADiagramBounds, ALegendBounds);
end;

function TcxGridChartViewInfo.DoGetHitTest(const P: TPoint): TcxCustomGridHitTest;
begin
  if FDiagramViewInfo <> nil then
    Result := FDiagramViewInfo.GetHitTest(P)
  else
    Result := nil;
  if Result = nil then
  begin
    if FLegendViewInfo <> nil then
      Result := FLegendViewInfo.GetHitTest(P);
    if Result = nil then
    begin
      Result := FTitleViewInfo.GetHitTest(P);
      if Result = nil then
        Result := inherited DoGetHitTest(P);
    end;   
  end;
end;

{ TcxCustomGridChartTitle }

procedure TcxCustomGridChartTitle.SetAlignment(Value: TcxGridChartPartAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridChartTitle.SetPosition(Value: TcxGridChartPartPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxCustomGridChartTitle.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(vcLayout);
  end;
end;

function TcxCustomGridChartTitle.GetDefaultAlignment: TcxGridChartPartAlignment;
begin
  Result := cpaCenter;
end;

function TcxCustomGridChartTitle.GetDefaultOrientation: TcxGridChartPartOrientation;
begin
  if GetPosition in [cppTop, cppBottom] then
    Result := cpoHorizontal
  else
    Result := cpoVertical;
end;

procedure TcxCustomGridChartTitle.Assign(Source: TPersistent);
begin
  if Source is TcxCustomGridChartTitle then
    with TcxCustomGridChartTitle(Source) do
    begin
      Self.Alignment := Alignment;
      Self.Position := Position;
      Self.Text := Text;
    end;
  inherited;
end;

function TcxCustomGridChartTitle.GetAlignment: TcxGridChartPartAlignment;
begin
  Result := FAlignment;
  if Result = cpaDefault then
    Result := GetDefaultAlignment;
end;

function TcxCustomGridChartTitle.GetOrientation: TcxGridChartPartOrientation;
begin
  Result := GetDefaultOrientation;
end;

function TcxCustomGridChartTitle.GetPosition: TcxGridChartPartPosition;
begin
  if Text = '' then
    Result := cppNone
  else
  begin
    Result := FPosition;
    if Result = cppDefault then
      Result := GetDefaultPosition;
  end;
end;

{ TcxGridChartLegend }

procedure TcxGridChartLegend.SetAlignment(Value: TcxGridChartPartAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridChartLegend.SetBorder(Value: TcxGridChartLegendBorder);
begin
  if FBorder <> Value then
  begin
    FBorder := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridChartLegend.SetKeyBorder(Value: TcxGridChartLegendBorder);
begin
  if FKeyBorder <> Value then
  begin
    FKeyBorder := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridChartLegend.SetOrientation(Value: TcxGridChartPartOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Changed(vcLayout);
  end;
end;

procedure TcxGridChartLegend.SetPosition(Value: TcxGridChartPartPosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    Changed(vcLayout);
  end;
end;

function TcxGridChartLegend.GetDefaultAlignment: TcxGridChartPartAlignment;
begin
  Result := cpaCenter;
end;

function TcxGridChartLegend.GetDefaultBorder: TcxGridChartLegendBorder;
begin
  Result := lbNone;
end;

function TcxGridChartLegend.GetDefaultKeyBorder: TcxGridChartLegendBorder;
begin
  Result := lbSingle;
end;

function TcxGridChartLegend.GetDefaultOrientation(APosition: TcxGridChartPartPosition): TcxGridChartPartOrientation;
begin
  if APosition in [cppTop, cppBottom] then
    Result := cpoHorizontal
  else
    Result := cpoVertical;
end;

function TcxGridChartLegend.GetDefaultPosition: TcxGridChartPartPosition;
begin
  Result := cppRight;
end;

procedure TcxGridChartLegend.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartLegend then
    with TcxGridChartLegend(Source) do
    begin
      Self.Alignment := Alignment;
      Self.Border := Border;
      Self.KeyBorder := KeyBorder;
      Self.Orientation := Orientation;
      Self.Position := Position;
    end;
  inherited;
end;

function TcxGridChartLegend.GetAlignment: TcxGridChartPartAlignment;
begin
  Result := FAlignment;
  if Result = cpaDefault then
    if Parent = nil then
      Result := GetDefaultAlignment
    else
      Result := Parent.GetAlignment;
end;

function TcxGridChartLegend.GetBorder: TcxGridChartLegendBorder;
begin
  Result := FBorder;
  if Result = lbDefault then
    if Parent = nil then
      Result := GetDefaultBorder
    else
      Result := Parent.GetBorder;
end;

function TcxGridChartLegend.GetKeyBorder: TcxGridChartLegendBorder;
begin
  Result := FKeyBorder;
  if Result = lbDefault then
    if Parent = nil then
      Result := GetDefaultKeyBorder
    else
      Result := Parent.GetKeyBorder;
end;

function TcxGridChartLegend.GetOrientation(APosition: TcxGridChartPartPosition = cppDefault): TcxGridChartPartOrientation;
begin
  Result := FOrientation;
  if Result = cpoDefault then
    if Parent = nil then
      Result := GetDefaultOrientation(APosition)
    else
    begin
      if APosition = cppDefault then
        APosition := GetPosition;
      Result := Parent.GetOrientation(APosition);
    end;
end;

function TcxGridChartLegend.GetPosition: TcxGridChartPartPosition;
begin
  Result := FPosition;
  if Result = cppDefault then
    if Parent = nil then
      Result := GetDefaultPosition
    else
      Result := Parent.GetPosition;
end;

{ TcxCustomGridChartDiagramOptions }

constructor TcxCustomGridChartDiagramOptions.Create(ADiagram: TcxGridChartDiagram);
begin
  inherited Create;
  FDiagram := ADiagram;
end;

function TcxCustomGridChartDiagramOptions.GetGridView: TcxGridChartView;
begin
  Result := FDiagram.GridView;
end;

function TcxCustomGridChartDiagramOptions.GetLookAndFeelPainter: TcxCustomLookAndFeelPainterClass;
begin
  Result := FDiagram.GridView.LookAndFeelPainter;
end;

procedure TcxCustomGridChartDiagramOptions.Changed(AChange: TcxGridDiagramChange = dcLayout);
begin
  FDiagram.Changed(AChange);
end;

procedure TcxCustomGridChartDiagramOptions.Assign(Source: TPersistent);
begin
  if not (Source is TcxCustomGridChartDiagramOptions) then
    inherited;
end;

{ TcxGridChartDiagramValueData }

type
  TcxGridChartDiagramValueData = class
    ValueIndex: Integer;
    VisibleSeriesIndex: Integer;
  end;

{ TcxGridChartDiagramStyles }

constructor TcxGridChartDiagramStyles.Create(AOwner: TPersistent);
begin
  inherited;
  BitmapInViewParams := True;
end;

function TcxGridChartDiagramStyles.GetDiagram: TcxGridChartDiagram;
begin
  Result := TcxGridChartDiagram(Owner);
end;

function TcxGridChartDiagramStyles.GetGridViewValue: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

procedure TcxGridChartDiagramStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      dsLegend:
        GridView.Styles.GetViewParams(vsLegend, AData, nil, AParams);
      dsValueCaptions:
        TextColor := DefaultChartDiagramValueCaptionTextColor;
      dsValues:
        begin
          with TcxGridChartDiagramValueData(AData) do
            if VisibleSeriesIndex <> -1 then
              GridView.VisibleSeries[VisibleSeriesIndex].Styles.GetValueParams(ValueIndex,
                GetVaryColorsByCategory, AParams)
            else
              Color := GetDefaultValueColor(ValueIndex);
          TextColor := DefaultChartDiagramValueBorderColor;
        end;
    end;
end;

function TcxGridChartDiagramStyles.GetGridView: TcxCustomGridView;
begin
  Result := Diagram.GridView;
end;

procedure TcxGridChartDiagramStyles.GetBackgroundParams(out AParams: TcxViewParams);
begin
  GridView.Styles.GetViewParams(vsBackground, nil, nil, AParams);
end;

procedure TcxGridChartDiagramStyles.GetValueParams(AVisibleSeriesIndex, AValueIndex: Integer;
  out AParams: TcxViewParams);
var
  AData: TcxGridChartDiagramValueData;
begin
  AData := TcxGridChartDiagramValueData.Create;
  try
    AData.VisibleSeriesIndex := AVisibleSeriesIndex;
    AData.ValueIndex := AValueIndex;
    GetViewParams(dsValues, AData, nil, AParams);
  finally
    AData.Free;
  end;
end;

procedure TcxGridChartDiagramStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridChartDiagramStyles then
    with TcxGridChartDiagramStyles(Source) do
    begin
      Self.Legend := Legend;
      Self.ValueCaptions := ValueCaptions;
      Self.Values := Values;
    end;
end;

{ TcxGridChartDiagram }

constructor TcxGridChartDiagram.Create(AGridView: TcxGridChartView);
begin
  inherited Create;
  FEnabled := True;
  CreateSubObjects(AGridView);
  AGridView.AddDiagram(Self);
end;

destructor TcxGridChartDiagram.Destroy;
begin
  FGridView.RemoveDiagram(Self);
  DestroySubObjects;
  inherited;
end;

function TcxGridChartDiagram.GetActive: Boolean;
begin
  Result := FGridView.ActiveDiagram = Self;
end;

procedure TcxGridChartDiagram.SetActive(Value: Boolean);
begin
  if Value then
    FGridView.ActiveDiagram := Self;
end;

procedure TcxGridChartDiagram.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if FEnabled then
      if FGridView.ActiveDiagram = nil then
        Active := True
      else
    else
      if Active then
        FGridView.ActiveDiagram := nil;
    Changed(dcProperty);
  end;
end;

procedure TcxGridChartDiagram.SetLegend(Value: TcxGridChartLegend);
begin
  FLegend.Assign(Value);
end;

procedure TcxGridChartDiagram.SetStyles(Value: TcxGridChartDiagramStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxGridChartDiagram.SetOnCustomDrawLegend(Value: TcxGridChartDiagramLegendCustomDrawEvent);
begin
  if @FOnCustomDrawLegend <> @Value then
  begin
    FOnCustomDrawLegend := Value;
    Changed(dcProperty);
  end;
end;

procedure TcxGridChartDiagram.SetOnCustomDrawLegendItem(Value: TcxGridChartDiagramLegendItemCustomDrawEvent);
begin
  if @FOnCustomDrawLegendItem <> @Value then
  begin
    FOnCustomDrawLegendItem := Value;
    Changed(dcProperty);
  end;
end;

procedure TcxGridChartDiagram.SetOnCustomDrawValue(Value: TcxGridChartDiagramValueCustomDrawEvent);
begin
  if @FOnCustomDrawValue <> @Value then
  begin
    FOnCustomDrawValue := Value;
    Changed(dcProperty);
  end;
end;

function TcxGridChartDiagram.GetOwner: TPersistent;
begin
  Result := FGridView;
end;

procedure TcxGridChartDiagram.CreateSubObjects(AGridView: TcxGridChartView);
begin
  FLegend := AGridView.GetLegendClass.Create(AGridView);
  FLegend.Parent := AGridView.Legend;
  FStyles := GetStylesClass.Create(Self);
end;

procedure TcxGridChartDiagram.DestroySubObjects;
begin
  FreeAndNil(FStyles);
  FreeAndNil(FLegend);
end;

procedure TcxGridChartDiagram.SetGridView(Value: TcxGridChartView);
begin
  FGridView := Value;
end;

function TcxGridChartDiagram.GetStylesClass: TcxGridChartDiagramStylesClass;
begin
  Result := TcxGridChartDiagramStyles;
end;

procedure TcxGridChartDiagram.Changed(AChange: TcxGridDiagramChange = dcLayout);
begin
  //if FGridView <> nil then
    FGridView.Changed(TcxGridViewChangeKind(AChange));
end;

function TcxGridChartDiagram.GetDisplayText: string;
begin
  Result := ClassName;
  Delete(Result, 1, Length('TcxGridChart'));
  Insert(' ', Result, Pos('Diagram', Result));
end;

procedure TcxGridChartDiagram.DoCustomDrawLegend(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawLegend then
    FOnCustomDrawLegend(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridChartDiagram.DoCustomDrawLegendItem(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawLegendItem then
    FOnCustomDrawLegendItem(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridChartDiagram.DoCustomDrawValue(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawValue then
    FOnCustomDrawValue(Self, ACanvas, AViewInfo, ADone);
end;

function TcxGridChartDiagram.HasCustomDrawLegend: Boolean;
begin
  Result := Assigned(FOnCustomDrawLegend);
end;

function TcxGridChartDiagram.HasCustomDrawLegendItem: Boolean;
begin
  Result := Assigned(FOnCustomDrawLegendItem);
end;

function TcxGridChartDiagram.HasCustomDrawValue: Boolean;
begin
  Result := Assigned(FOnCustomDrawValue);
end;

procedure TcxGridChartDiagram.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartDiagram then
    with TcxGridChartDiagram(Source) do
    begin
      Self.Enabled := Enabled;  // must be assigned before Active
      Self.Active := Active;
      Self.Legend := Legend;
      Self.Styles := Styles;
      Self.OnCustomDrawLegend := OnCustomDrawLegend;
      Self.OnCustomDrawLegendItem := OnCustomDrawLegendItem;
      Self.OnCustomDrawValue := OnCustomDrawValue;
    end
  else
    inherited;
end;

function TcxGridChartDiagram.GetNamePath: string;
begin
  Result := FGridView.GetDiagramNamePath(Self);
end;

function TcxGridChartDiagram.GetValueCaption(ASeries: TcxGridChartSeries;
  AValueIndex: Integer): string;
begin
  Result := ASeries.GetValueCaption(AValueIndex);
end;

{ TcxGridChartColumnDiagramAxisTitle }

constructor TcxGridChartColumnDiagramAxisTitle.Create(AAxis: TcxGridChartColumnDiagramAxis);
begin
  FAxis := AAxis;
  inherited Create(nil);
end;

function TcxGridChartColumnDiagramAxisTitle.GetDefaultPosition: TcxGridChartPartPosition;
begin
  Result := FAxis.GetPosition;
end;

function TcxGridChartColumnDiagramAxisTitle.GetGridViewValue: TcxCustomGridView;
begin
  Result := FAxis.GridView;
end;

{ TcxGridChartColumnDiagramAxis }

constructor TcxGridChartColumnDiagramAxis.Create(ADiagram: TcxGridChartDiagram);
begin
  inherited;
  FGridLines := True;
  FTickMarkKind := tmkOutside;
  FTickMarkLabels := True;
  FTitle := GetTitleClass.Create(Self);
  FVisible := True;
end;

destructor TcxGridChartColumnDiagramAxis.Destroy;
begin
  FreeAndNil(FTitle);
  inherited;
end;

function TcxGridChartColumnDiagramAxis.GetDiagram: TcxGridChartColumnDiagram;
begin
  Result := TcxGridChartColumnDiagram(inherited Diagram);
end;

procedure TcxGridChartColumnDiagramAxis.SetGridLines(Value: Boolean);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxis.SetTickMarkKind(Value: TcxGridChartHistogramTickMarkKind);
begin
  if FTickMarkKind <> Value then
  begin
    FTickMarkKind := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxis.SetTickMarkLabels(Value: Boolean);
begin
  if FTickMarkLabels <> Value then
  begin
    FTickMarkLabels := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxis.SetTitle(Value: TcxGridChartColumnDiagramAxisTitle);
begin
  FTitle.Assign(Value);
end;

procedure TcxGridChartColumnDiagramAxis.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Changed;
  end;
end;

function TcxGridChartColumnDiagramAxis.GetTitleClass: TcxGridChartColumnDiagramAxisTitleClass;
begin
  Result := TcxGridChartColumnDiagramAxisTitle;
end;

procedure TcxGridChartColumnDiagramAxis.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartColumnDiagramAxis then
    with TcxGridChartColumnDiagramAxis(Source) do
    begin
      Self.GridLines := GridLines;
      Self.TickMarkKind := TickMarkKind;
      Self.TickMarkLabels := TickMarkLabels;
      Self.Title := Title;
      Self.Visible := Visible;
    end;
  inherited;
end;

{ TcxGridChartColumnDiagramAxisCategory }

constructor TcxGridChartColumnDiagramAxisCategory.Create(ADiagram: TcxGridChartDiagram);
begin
  inherited;
  FValueAxisBetweenCategories := True;
end;

procedure TcxGridChartColumnDiagramAxisCategory.SetCategoriesInReverseOrder(Value: Boolean);
begin
  if FCategoriesInReverseOrder <> Value then
  begin
    FCategoriesInReverseOrder := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxisCategory.SetValueAxisAtMaxCategory(Value: Boolean);
begin
  if FValueAxisAtMaxCategory <> Value then
  begin
    FValueAxisAtMaxCategory := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxisCategory.SetValueAxisBetweenCategories(Value: Boolean);
begin
  if FValueAxisBetweenCategories <> Value then
  begin
    FValueAxisBetweenCategories := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxisCategory.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartColumnDiagramAxisCategory then
    with TcxGridChartColumnDiagramAxisCategory(Source) do
    begin
      Self.CategoriesInReverseOrder := CategoriesInReverseOrder;
      Self.ValueAxisAtMaxCategory := ValueAxisAtMaxCategory;
      Self.ValueAxisBetweenCategories := ValueAxisBetweenCategories;
    end;
  inherited;
end;

function TcxGridChartColumnDiagramAxisCategory.GetPosition: TcxGridChartAxisPosition;
begin
  Result := Diagram.GetCategoryAxisPosition;
end;

{ TcxGridChartColumnDiagramAxisValue }

procedure TcxGridChartColumnDiagramAxisValue.SetTickMarkLabelFormat(const Value: string);
begin
  if FTickMarkLabelFormat <> Value then
  begin
    FTickMarkLabelFormat := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramAxisValue.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartColumnDiagramAxisValue then
    TickMarkLabelFormat := TcxGridChartColumnDiagramAxisValue(Source).TickMarkLabelFormat;
  inherited;
end;

function TcxGridChartColumnDiagramAxisValue.GetPosition: TcxGridChartAxisPosition;
begin
  Result := Diagram.GetValueAxisPosition;
end;

function TcxGridChartColumnDiagramAxisValue.GetTickMarkLabel(const ATickMarkValue: Variant): string;
var
  ATickMarkLabelFormat: string;
begin
  ATickMarkLabelFormat := GetTickMarkLabelFormat;
  if ATickMarkLabelFormat = '' then
    Result := ATickMarkValue
  else
    Result := FormatFloat(ATickMarkLabelFormat, ATickMarkValue);
end;

function TcxGridChartColumnDiagramAxisValue.GetTickMarkLabelFormat: string;
var
  I: Integer;
  AValueCaptionFormat: string;
begin
  Result := TickMarkLabelFormat;
  if Result = '' then
    for I := 0 to GridView.VisibleSeriesCount - 1 do
    begin
      AValueCaptionFormat := GridView.VisibleSeries[I].ValueCaptionFormat;
      if (I <> 0) and (AValueCaptionFormat <> Result) then
      begin
        Result := '';
        Break;
      end;
      Result := AValueCaptionFormat;
    end;
end;

{ TcxGridChartColumnDiagramStyles }

procedure TcxGridChartColumnDiagramStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      dsAxis:
        begin
          Color := DefaultChartHistogramAxisColor;
          TextColor := DefaultContentTextColor;
        end;
      dsCategoryAxis, dsValueAxis:
        GetViewParams(dsAxis, nil, nil, AParams);
      dsAxisTitle:
        TextColor := DefaultContentTextColor;
      dsCategoryAxisTitle, dsValueAxisTitle:
        GetViewParams(dsAxisTitle, nil, nil, AParams);
      dsGridLines:
        Color := DefaultChartHistogramGridLineColor;
      dsCategoryGridLines, dsValueGridLines:
        GetViewParams(dsGridLines, nil, nil, AParams);
      dsPlot:
        Color := DefaultChartHistogramPlotColor;
    end;
end;

function TcxGridChartColumnDiagramStyles.GetVaryColorsByCategory: Boolean;
begin
  Result := TcxGridChartColumnDiagram(Diagram).Values.GetVaryColorsByCategory;
end;

procedure TcxGridChartColumnDiagramStyles.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartColumnDiagramStyles then
    with TcxGridChartColumnDiagramStyles(Source) do
    begin
      Self.Axis := Axis;
      Self.AxisTitle := AxisTitle;
      Self.CategoryAxis := CategoryAxis;
      Self.CategoryAxisTitle := CategoryAxisTitle;
      Self.CategoryGridLines := CategoryGridLines;
      Self.GridLines := GridLines;
      Self.Plot := Plot;
      Self.ValueAxis := ValueAxis;
      Self.ValueAxisTitle := ValueAxisTitle;
      Self.ValueGridLines := ValueGridLines;
    end;
  inherited;
end;

{ TcxGridChartColumnDiagramValues }

constructor TcxGridChartColumnDiagramValues.Create(ADiagram: TcxGridChartDiagram);
begin
  inherited;
  FBorderWidth := cxGridChartColumnDiagramDefaultBorderWidth;
end;

procedure TcxGridChartColumnDiagramValues.SetBorderWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Changed;
  end
end;

procedure TcxGridChartColumnDiagramValues.SetCaptionPosition(Value: TcxGridChartColumnDiagramValueCaptionPosition);
begin
  if FCaptionPosition <> Value then
  begin
    FCaptionPosition := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramValues.SetVaryColorsByCategory(Value: Boolean);
begin
  if FVaryColorsByCategory <> Value then
  begin
    FVaryColorsByCategory := Value;
    Changed;
  end;
end;

procedure TcxGridChartColumnDiagramValues.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridChartColumnDiagramValues then
    with TcxGridChartColumnDiagramValues(Source) do
    begin
      Self.BorderWidth := BorderWidth;
      Self.CaptionPosition := CaptionPosition;
      Self.VaryColorsByCategory := VaryColorsByCategory;
    end;
end;

function TcxGridChartColumnDiagramValues.GetVaryColorsByCategory: Boolean;
begin
  Result := (GridView.VisibleSeriesCount = 1) and FVaryColorsByCategory;
end;

{ TcxGridChartColumnDiagram }

function TcxGridChartColumnDiagram.GetStyles: TcxGridChartColumnDiagramStyles;
begin
  Result := TcxGridChartColumnDiagramStyles(inherited Styles);
end;

procedure TcxGridChartColumnDiagram.SetAxisCategory(Value: TcxGridChartColumnDiagramAxisCategory);
begin
  FAxisCategory.Assign(Value);
end;

procedure TcxGridChartColumnDiagram.SetAxisValue(Value: TcxGridChartColumnDiagramAxisValue);
begin
  FAxisValue.Assign(Value);
end;

procedure TcxGridChartColumnDiagram.SetStyles(Value: TcxGridChartColumnDiagramStyles);
begin
  inherited Styles := Value;
end;

procedure TcxGridChartColumnDiagram.SetValues(Value: TcxGridChartColumnDiagramValues);
begin
  FValues.Assign(Value);
end;

procedure TcxGridChartColumnDiagram.SetOnCustomDrawPlot(Value: TcxGridChartColumnDiagramPlotCustomDrawEvent);
begin
  if @FOnCustomDrawPlot <> @Value then
  begin
    FOnCustomDrawPlot := Value;
    Changed(dcProperty);
  end;
end;

procedure TcxGridChartColumnDiagram.CreateSubObjects(AGridView: TcxGridChartView);
begin
  inherited;
  FAxisCategory := GetAxisCategoryClass.Create(Self);
  FAxisValue := GetAxisValueClass.Create(Self);
  FValues := GetValuesClass.Create(Self);
end;

procedure TcxGridChartColumnDiagram.DestroySubObjects;
begin
  FreeAndNil(FValues);
  FreeAndNil(FAxisValue);
  FreeAndNil(FAxisCategory);
  inherited;
end;

function TcxGridChartColumnDiagram.GetAxisCategoryClass: TcxGridChartColumnDiagramAxisCategoryClass;
begin
  Result := TcxGridChartColumnDiagramAxisCategory;
end;

function TcxGridChartColumnDiagram.GetAxisValueClass: TcxGridChartColumnDiagramAxisValueClass;
begin
  Result := TcxGridChartColumnDiagramAxisValue;
end;

function TcxGridChartColumnDiagram.GetStylesClass: TcxGridChartDiagramStylesClass;
begin
  Result := TcxGridChartColumnDiagramStyles;
end;

function TcxGridChartColumnDiagram.GetValuesClass: TcxGridChartColumnDiagramValuesClass;
begin
  Result := TcxGridChartColumnDiagramValues;
end;

function TcxGridChartColumnDiagram.GetLegendViewInfoClass: TcxGridChartLegendViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramLegendViewInfo;
end;

function TcxGridChartColumnDiagram.GetViewInfoClass: TcxGridChartDiagramViewInfoClass;
begin
  Result := TcxGridChartColumnDiagramViewInfo;
end;

procedure TcxGridChartColumnDiagram.DoCustomDrawPlot(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartColumnDiagramViewInfo; const ABounds: TRect; var ADone: Boolean);
begin
  if HasCustomDrawPlot then
    FOnCustomDrawPlot(Self, ACanvas, AViewInfo, ABounds, ADone);
end;

function TcxGridChartColumnDiagram.HasCustomDrawPlot: Boolean;
begin
  Result := Assigned(FOnCustomDrawPlot);
end;

procedure TcxGridChartColumnDiagram.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartColumnDiagram then
    with TcxGridChartColumnDiagram(Source) do
    begin
      Self.AxisCategory := AxisCategory;
      Self.AxisValue := AxisValue;
      Self.Values := Values;
      Self.OnCustomDrawPlot := OnCustomDrawPlot;
    end;
  inherited;
end;

function TcxGridChartColumnDiagram.GetCategoryAxisPosition: TcxGridChartAxisPosition;
begin
  Result := cppBottom;
end;

function TcxGridChartColumnDiagram.GetValueAxisPosition: TcxGridChartAxisPosition;
begin
  if AxisCategory.ValueAxisAtMaxCategory xor AxisCategory.CategoriesInReverseOrder then
    Result := cppRight
  else
    Result := cppLeft;
end;

{ TcxGridChartBarDiagram }

function TcxGridChartBarDiagram.GetCategoryAxisPosition: TcxGridChartAxisPosition;
begin
  Result := cppLeft;
end;

function TcxGridChartBarDiagram.GetValueAxisPosition: TcxGridChartAxisPosition;
begin
  if AxisCategory.ValueAxisAtMaxCategory xor AxisCategory.CategoriesInReverseOrder then
    Result := cppTop
  else
    Result := cppBottom;
end;

{ TcxGridChartItemDataBinding }

constructor TcxGridChartItemDataBinding.Create(AGridView: TcxGridChartView;
  AIsValue: Boolean; ADefaultValueTypeClass: TcxValueTypeClass);
begin
  inherited Create;
  FGridView := AGridView;
  FIsValue := AIsValue;
  FDefaultValueTypeClass := ADefaultValueTypeClass;
end;

function TcxGridChartItemDataBinding.GetDataController: TcxCustomDataController;
begin
  Result := FDataField.DataController;
end;

function TcxGridChartItemDataBinding.GetDataIndex: Integer;
begin
  Result := FDataField.Index;
end;

function TcxGridChartItemDataBinding.GetSortOrder: TcxDataSortOrder;
begin
  Result := DataController.GetItemSortOrder(DataIndex);
end;

function TcxGridChartItemDataBinding.GetValueType: string;
begin
  if ValueTypeClass = nil then
    Result := ''
  else
    Result := ValueTypeClass.Caption;
end;

function TcxGridChartItemDataBinding.GetValueTypeClass: TcxValueTypeClass;
begin
  Result := DataController.GetItemValueTypeClass(DataIndex);
end;

procedure TcxGridChartItemDataBinding.SetData(Value: TObject);
begin
  if FData <> Value then
  begin
    FData := Value;
    FGridView.Changed(vcProperty);
  end;
end;

procedure TcxGridChartItemDataBinding.SetDataField(Value: TcxCustomDataField);
begin
  if FDataField <> Value then
  begin
    FDataField := Value;
    if FDataField <> nil then
      ValueTypeClass := GetDefaultValueTypeClass;
  end;
end;

procedure TcxGridChartItemDataBinding.SetSortOrder(Value: TcxDataSortOrder);
begin
  if SortOrder <> Value then
  begin
    GridView.BeginUpdate;
    try
      if SortOrder = soNone then
        DataController.ClearSorting(False);
      DataController.ChangeSorting(DataIndex, Value);
    finally
      GridView.EndUpdate;
    end;
  end;
end;

procedure TcxGridChartItemDataBinding.SetValueType(const Value: string);
begin
  if ValueType <> Value then
    ValueTypeClass := cxValueTypeClassList.ItemByCaption(Value);
end;

procedure TcxGridChartItemDataBinding.SetValueTypeClass(Value: TcxValueTypeClass);
begin
  DataController.ChangeValueTypeClass(DataIndex, Value);
end;

function TcxGridChartItemDataBinding.GetDefaultValueTypeClass: TcxValueTypeClass;
begin
  Result := FDefaultValueTypeClass;
end;

function TcxGridChartItemDataBinding.IsValueTypeInteger: Boolean;
begin
  Result := IsValueTypeValid(ValueTypeClass.GetVarType, True);
end;

function TcxGridChartItemDataBinding.IsValueTypeStored: Boolean;
begin
  Result := ValueTypeClass <> GetDefaultValueTypeClass;
end;

procedure TcxGridChartItemDataBinding.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartItemDataBinding then
    with TcxGridChartItemDataBinding(Source) do
    begin
      Self.Data := Data;
      Self.ValueTypeClass := ValueTypeClass;
    end
  else
    inherited;
end;

function TcxGridChartItemDataBinding.IsValueTypeClassValid(AValueTypeClass: TcxValueTypeClass): Boolean;
begin
  if IsValue then
    Result := cxGridChartView.IsValueTypeClassValid(AValueTypeClass)
  else
    Result := True;
end;

{ TcxGridChartCategories }

constructor TcxGridChartCategories.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FDataBinding := GridView.GetItemDataBindingClass.Create(GridView, False, GetDefaultValueTypeClass);
end;

destructor TcxGridChartCategories.Destroy;
begin
  FDataBinding.Free;
  inherited;
end;

function TcxGridChartCategories.GetGridView: TcxGridChartView;
begin
  Result := TcxGridChartView(inherited GridView);
end;

function TcxGridChartCategories.GetID: Integer;
begin
  Result := FDataBinding.ID;
end;

function TcxGridChartCategories.GetSortOrder: TcxDataSortOrder;
begin
  Result := FDataBinding.SortOrder;
end;

function TcxGridChartCategories.GetValue(Index: Integer): Variant;
begin
  Result := GridView.ViewData.Categories[Index];
end;

function TcxGridChartCategories.GetValueCount: Integer;
begin
  Result := GridView.ViewData.ValueCount;
end;

procedure TcxGridChartCategories.SetDataBinding(Value: TcxGridChartItemDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TcxGridChartCategories.SetSortOrder(Value: TcxDataSortOrder);
begin
  FDataBinding.SortOrder := Value;
end;

procedure TcxGridChartCategories.SetValue(Index: Integer; const Value: Variant);
begin
  GridView.ViewData.Categories[Index] := Value;
end;

procedure TcxGridChartCategories.SetValueCount(Value: Integer);
begin
  GridView.ViewData.ValueCount := Value;
end;

function TcxGridChartCategories.GetDefaultValueTypeClass: TcxValueTypeClass;
begin
  Result := TcxStringValueType;
end;

procedure TcxGridChartCategories.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartCategories then
    with TcxGridChartCategories(Source) do
    begin
      Self.DataBinding := DataBinding;
      Self.SortOrder := SortOrder;
    end;
  inherited;
end;

{ TcxGridChartSeriesStyles }

constructor TcxGridChartSeriesStyles.Create(AOwner: TPersistent);
begin
  inherited;
  BitmapInViewParams := True;
end;

function TcxGridChartSeriesStyles.GetSeries: TcxGridChartSeries;
begin
  Result := TcxGridChartSeries(Owner);
end;

procedure TcxGridChartSeriesStyles.SetOnGetValueStyle(Value: TcxGridChartSeriesGetValueStyleEvent);
begin
  if @FOnGetValueStyle <> @Value then
  begin
    FOnGetValueStyle := Value;
    Series.Changed(vcProperty);
  end;
end;

procedure TcxGridChartSeriesStyles.GetDefaultViewParams(Index: Integer;
  AData: TObject; out AParams: TcxViewParams);
begin
  inherited;
  if Index = ssValues then
    if Integer(AData) = -1 then
      AParams.Color := GetDefaultValueColor(Series.Index)
    else
      AParams.Color := GetDefaultValueColor(Integer(AData));
end;

function TcxGridChartSeriesStyles.GetGridView: TcxCustomGridView;
begin
  Result := Series.GridView;
end;

procedure TcxGridChartSeriesStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridChartSeriesStyles then
    with TcxGridChartSeriesStyles(Source) do
    begin
      Self.Values := Values;
      Self.OnGetValueStyle := OnGetValueStyle;
    end;
end;

procedure TcxGridChartSeriesStyles.GetValueParams(AValueIndex: Integer;
  AVaryColorsByCategory: Boolean; out AParams: TcxViewParams);
var
  AStyle: TcxStyle;
begin
  AStyle := nil;
  if (AValueIndex <> -1) and Assigned(FOnGetValueStyle) then
    FOnGetValueStyle(Series, AValueIndex, AStyle);
  if not AVaryColorsByCategory then AValueIndex := -1;
  GetViewParams(ssValues, TObject(AValueIndex), AStyle, AParams);
end;

{ TcxGridChartSeries }

constructor TcxGridChartSeries.Create(AOwner: TComponent);
begin
  inherited;
  FStyles := GetStylesClass.Create(Self);
  FVisible := True;
  FVisibleIndex := -1;
end;

destructor TcxGridChartSeries.Destroy;
begin
  if not GridView.IsDestroying and GridView.IsDesigning then
    GridView.Controller.DesignController.UnselectObject(Self);
  FGridView.RemoveSeries(Self);
  FStyles.Free;
  FDataBinding.Free;
  inherited;
end;

function TcxGridChartSeries.GetID: Integer;
begin
  Result := FDataBinding.ID;
end;

function TcxGridChartSeries.GetIndex: Integer;
begin
  Result := FGridView.IndexOfSeries(Self);
end;

function TcxGridChartSeries.GetSortOrder: TcxDataSortOrder;
begin
  Result := FDataBinding.SortOrder;
end;

function TcxGridChartSeries.GetTag: TcxTag;
begin
  Result := inherited Tag;
end;

function TcxGridChartSeries.GetValue(AIndex: Integer): Variant;
begin
  Result := FGridView.ViewData.Values[Index, AIndex];
end;

function TcxGridChartSeries.GetValueCount: Integer;
begin
  Result := FGridView.ViewData.ValueCount;
end;

procedure TcxGridChartSeries.SetDataBinding(Value: TcxGridChartItemDataBinding);
begin
  FDataBinding.Assign(Value);
end;

procedure TcxGridChartSeries.SetDisplayText(const Value: string);
begin
  if FDisplayText <> Value then
  begin
    FDisplayText := Value;
    Changed;
  end;
end;

procedure TcxGridChartSeries.SetIndex(Value: Integer);
begin
  FGridView.SetSeriesIndex(Self, Value);
end;

procedure TcxGridChartSeries.SetSortOrder(Value: TcxDataSortOrder);
begin
  FDataBinding.SortOrder := Value;
end;

procedure TcxGridChartSeries.SetStyles(Value: TcxGridChartSeriesStyles);
begin
  FStyles.Assign(Value);
end;

procedure TcxGridChartSeries.SetTag(Value: TcxTag);
begin
  if Tag <> Value then
  begin
    inherited Tag := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridChartSeries.SetValue(AIndex: Integer; const Value: Variant);
begin
  FGridView.ViewData.Values[Index, AIndex] := Value;
end;

procedure TcxGridChartSeries.SetValueCaptionFormat(const Value: string);
begin
  if FValueCaptionFormat <> Value then
  begin
    FValueCaptionFormat := Value;
    Changed;
  end;
end;

procedure TcxGridChartSeries.SetValueCount(Value: Integer);
begin
  FGridView.ViewData.ValueCount := Value;
end;

procedure TcxGridChartSeries.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    FGridView.RefreshVisibleSeriesList;
    Changed;
  end;
end;

procedure TcxGridChartSeries.SetOnCustomDrawValue(Value: TcxGridChartSeriesValueCustomDrawEvent);
begin
  if @FOnCustomDrawValue <> @Value then
  begin
    FOnCustomDrawValue := Value;
    Changed(vcProperty);
  end;
end;

function TcxGridChartSeries.IsTagStored: Boolean;
begin
  Result := Tag <> 0;
end;

procedure TcxGridChartSeries.Changed(AChange: TcxGridViewChangeKind = vcLayout);
begin
  FGridView.Changed(AChange);
end;

function TcxGridChartSeries.GetDefaultDisplayText: string;
begin
  Result := Name;
  if Result = '' then
    Result := DefaultSeriesDisplayText;
end;

function TcxGridChartSeries.GetDefaultValueTypeClass: TcxValueTypeClass;
begin
  Result := TcxFloatValueType;
end;

function TcxGridChartSeries.GetStylesClass: TcxGridChartSeriesStylesClass;
begin
  Result := TcxGridChartSeriesStyles;
end;

procedure TcxGridChartSeries.SetGridView(Value: TcxGridChartView);
begin
  FGridView := Value;
  if FDataBinding = nil then
    FDataBinding := GridView.GetItemDataBindingClass.Create(GridView, True, GetDefaultValueTypeClass);
end;

procedure TcxGridChartSeries.SetName(const NewName: TComponentName);
begin
  inherited;
  Changed;
end;

procedure TcxGridChartSeries.DoCustomDrawValue(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartDiagramValueViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawValue then
    FOnCustomDrawValue(Self, ACanvas, AViewInfo, ADone);
end;

function TcxGridChartSeries.HasCustomDrawValue: Boolean;
begin
  Result := Assigned(FOnCustomDrawValue);
end;

procedure TcxGridChartSeries.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartSeries then
    with TcxGridChartSeries(Source) do
    begin
      Self.DataBinding := DataBinding;
      Self.DisplayText := DisplayText;
      Self.SortOrder := SortOrder;
      Self.Styles := Styles;
      Self.Tag := Tag;
      Self.ValueCaptionFormat := ValueCaptionFormat;
      Self.Visible := Visible;
      Self.OnCustomDrawValue := OnCustomDrawValue;
    end
  else
    inherited;
end;

function TcxGridChartSeries.GetParentComponent: TComponent;
begin
  Result := FGridView;
end;

function TcxGridChartSeries.HasParent: Boolean;
begin
  Result := FGridView <> nil;
end;

procedure TcxGridChartSeries.SetParentComponent(AParent: TComponent);
begin
  if AParent is TcxGridChartView then
    TcxGridChartView(AParent).AddSeries(Self);
end;

function TcxGridChartSeries.AddValue(const AValue: Variant): Integer;
begin
  ValueCount := ValueCount + 1;
  Result := ValueCount - 1;
  Values[Result] := AValue;
end;

function TcxGridChartSeries.GetDisplayText: string;
begin
  Result := DisplayText;
  if Result = '' then
    Result := GetDefaultDisplayText;
end;

function TcxGridChartSeries.GetValueCaption(AIndex: Integer): string;
begin
  if ValueCaptionFormat = '' then
    Result := Values[AIndex]
  else
    Result := FormatFloat(ValueCaptionFormat, Values[AIndex]);
end;

{ TcxGridChartTitle }

function TcxGridChartTitle.GetDefaultPosition: TcxGridChartPartPosition;
begin
  Result := cppTop;
end;

{ TcxGridChartOptionsBehavior }

constructor TcxGridChartOptionsBehavior.Create(AGridView: TcxCustomGridView);
begin
  inherited;
  FValueHints := True;
end;

procedure TcxGridChartOptionsBehavior.Assign(Source: TPersistent);
begin
  if Source is TcxGridChartOptionsBehavior then
    ValueHints := TcxGridChartOptionsBehavior(Source).ValueHints;
  inherited;
end;

procedure TcxGridChartOptionsBehavior.SetValueHints(Value: Boolean);
begin
  if FValueHints <> Value then
  begin
    FValueHints := Value;
    Changed(vcProperty);
  end;
end;

{ TcxGridChartViewStyles }

constructor TcxGridChartViewStyles.Create(AOwner: TPersistent);
begin
  inherited;
  BitmapInViewParams := True;
end;

procedure TcxGridChartViewStyles.GetDefaultViewParams(Index: Integer; AData: TObject;
  out AParams: TcxViewParams);
begin
  inherited;
  with AParams, LookAndFeelPainter do
    case Index of
      vsLegend:
        begin
          Color := DefaultContentColor;
          TextColor := DefaultContentTextColor;
        end;
      vsTitle:
        TextColor := DefaultContentTextColor;
    end;
end;

procedure TcxGridChartViewStyles.Assign(Source: TPersistent);
begin
  inherited;
  if Source is TcxGridChartViewStyles then
    with TcxGridChartViewStyles(Source) do
    begin
      Self.Legend := Legend;
      Self.Title := Title;
    end;
end;

{ TcxGridChartView }

function TcxGridChartView.GetController: TcxGridChartController;
begin
  Result := TcxGridChartController(inherited Controller);
end;

function TcxGridChartView.GetDataController: TcxGridChartDataController;
begin
  Result := TcxGridChartDataController(FDataController);
end;

function TcxGridChartView.GetDiagram(Index: Integer): TcxGridChartDiagram;
begin
  Result := TcxGridChartDiagram(FDiagrams[Index]);
end;

function TcxGridChartView.GetDiagramCount: Integer;
begin
  Result := FDiagrams.Count;
end;

function TcxGridChartView.GetOptionsBehavior: TcxGridChartOptionsBehavior;
begin
  Result := TcxGridChartOptionsBehavior(inherited OptionsBehavior);
end;

function TcxGridChartView.GetSeries(Index: Integer): TcxGridChartSeries;
begin
  Result := TcxGridChartSeries(FSeries[Index]);
end;

function TcxGridChartView.GetSeriesCount: Integer;
begin
  Result := FSeries.Count;
end;

function TcxGridChartView.GetStyles: TcxGridChartViewStyles;
begin
  Result := TcxGridChartViewStyles(inherited Styles);
end;

function TcxGridChartView.GetViewData: TcxGridChartViewData;
begin
  Result := TcxGridChartViewData(inherited ViewData);
end;

function TcxGridChartView.GetViewInfo: TcxGridChartViewInfo;
begin
  Result := TcxGridChartViewInfo(inherited ViewInfo);
end;

function TcxGridChartView.GetVisibleSeries(Index: Integer): TcxGridChartSeries;
begin
  Result := TcxGridChartSeries(FVisibleSeries[Index]);
end;

function TcxGridChartView.GetVisibleSeriesCount: Integer;
begin
  Result := FVisibleSeries.Count;
end;

procedure TcxGridChartView.SetActiveDiagram(Value: TcxGridChartDiagram);
begin
  if Value = nil then
    Value := GetFirstAvailableDiagram;
  if (FActiveDiagram <> Value) and ((Value = nil) or Value.Enabled) then
  begin
    FActiveDiagram := Value;
    Changed(vcLayout);
    DoActiveDiagramChanged(FActiveDiagram);
  end;
end;

procedure TcxGridChartView.SetCategories(Value: TcxGridChartCategories);
begin
  FCategories.Assign(Value);
end;

procedure TcxGridChartView.SetDataController(Value: TcxGridChartDataController);
begin
  FDataController.Assign(Value);
end;

procedure TcxGridChartView.SetDiagramBar(Value: TcxGridChartBarDiagram);
begin
  FDiagramBar.Assign(Value);
end;

procedure TcxGridChartView.SetDiagramColumn(Value: TcxGridChartColumnDiagram);
begin
  FDiagramColumn.Assign(Value);
end;

procedure TcxGridChartView.SetLegend(Value: TcxGridChartLegend);
begin
  FLegend.Assign(Value);
end;

procedure TcxGridChartView.SetOptionsBehavior(Value: TcxGridChartOptionsBehavior);
begin
  inherited OptionsBehavior := Value;
end;

procedure TcxGridChartView.SetSeries(Index: Integer; Value: TcxGridChartSeries);
begin
  Series[Index].Assign(Value);
end;

procedure TcxGridChartView.SetStyles(Value: TcxGridChartViewStyles);
begin
  inherited Styles := Value;
end;

procedure TcxGridChartView.SetTitle(Value: TcxGridChartTitle);
begin
  FTitle.Assign(Value);
end;

procedure TcxGridChartView.SetOnActiveDiagramChanged(Value: TcxGridChartDiagramEvent);
begin
  if @FOnActiveDiagramChanged <> @Value then
  begin
    FOnActiveDiagramChanged := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridChartView.SetOnCustomDrawLegend(Value: TcxGridChartLegendCustomDrawEvent);
begin
  if @FOnCustomDrawLegend <> @Value then
  begin
    FOnCustomDrawLegend := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridChartView.SetOnCustomDrawLegendItem(Value: TcxGridChartLegendItemCustomDrawEvent);
begin
  if @FOnCustomDrawLegendItem <> @Value then
  begin
    FOnCustomDrawLegendItem := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridChartView.SetOnGetValueHint(Value: TcxGridChartGetValueHintEvent);
begin
  if @FOnGetValueHint <> @Value then
  begin
    FOnGetValueHint := Value;
    Changed(vcProperty);
  end;
end;

procedure TcxGridChartView.RefreshVisibleSeriesList;
var
  I: Integer;
  ASeries: TcxGridChartSeries;
begin
  FVisibleSeries.Clear;
  for I := 0 to SeriesCount - 1 do
  begin
    ASeries := Series[I];
    if ASeries.Visible then
      ASeries.FVisibleIndex := FVisibleSeries.Add(ASeries)
    else
      ASeries.FVisibleIndex := -1;
  end;
end;

function TcxGridChartView.IsLayoutChangeable: Boolean;
begin
  Result := False;
end;

procedure TcxGridChartView.DoMenuItemAction(AIndex: Integer; var AModified: Boolean);
begin
  if not Diagrams[AIndex].Active then
  begin
    Diagrams[AIndex].Active := True;
    AModified := True;
  end;  
  if TcxGridLevel(Level).IsTop then
    TcxGridLevel(Level).Active := True;
end;

function TcxGridChartView.GetMenuItemAction(AIndex: Integer): TcxGridViewDesignerMenuItemAction;
begin
  Result := vmiaSelectComponent;
end;

function TcxGridChartView.GetMenuItemCount: Integer;
begin
  Result := DiagramCount;
end;

function TcxGridChartView.GetMenuItemObject(AIndex: Integer): TObject;
begin
  Result := Diagrams[AIndex];
end;

procedure TcxGridChartView.PrepareMenuItem(AIndex: Integer; AMenuItem: TMenuItem);
begin
  AMenuItem.Caption := Diagrams[AIndex].DisplayText;
  AMenuItem.Checked := Diagrams[AIndex].Active;
end;

procedure TcxGridChartView.DoAssign(ASource: TcxCustomGridView);

  procedure AssignItems(ASource: TcxGridChartView);
  var
    I: Integer;
    ASeries: TcxGridChartSeries;
  begin
    Categories := ASource.Categories;
    Categories.DataBinding.ID := ASource.Categories.ID;

    for I := 0 to ASource.SeriesCount - 1 do
    begin
      ASeries := FindSeriesByID(ASource.Series[I].ID);
      if ASeries = nil then
      begin
        ASeries := CreateSeries;
        ASeries.DataBinding.ID := ASource.Series[I].ID;
      end;
      ASeries.Index := I;
      ASeries.Assign(ASource.Series[I]);
    end;
    for I := SeriesCount - 1 downto ASource.SeriesCount do
      Series[I].Free;

    FNextID := ASource.FNextID;
  end;

begin
  if ASource is TcxGridChartView then
  begin
    AssignItems(TcxGridChartView(ASource));
    with TcxGridChartView(ASource) do
    begin
      Self.DiagramBar := DiagramBar;
      Self.DiagramColumn := DiagramColumn;
      Self.Legend := Legend;
      Self.Title := Title;
      Self.OnActiveDiagramChanged := OnActiveDiagramChanged;
      Self.OnCustomDrawLegend := OnCustomDrawLegend;
      Self.OnCustomDrawLegendItem := OnCustomDrawLegendItem;
      Self.OnGetValueHint := OnGetValueHint;
    end;
  end;
  inherited;
end;

procedure TcxGridChartView.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := 0 to SeriesCount - 1 do
    if Series[I].Owner = Root then Proc(Series[I]);
end;

procedure TcxGridChartView.GetFakeComponentLinks(AList: TList);
var
  I: Integer;
begin
  inherited;
  for I := 0 to DiagramCount - 1 do
    Diagrams[I].Styles.GetFakeComponentLinks(AList);
  for I := 0 to SeriesCount - 1 do
    Series[I].Styles.GetFakeComponentLinks(AList);
end;

procedure TcxGridChartView.SetChildOrder(Child: TComponent; Order: Integer);
begin
  inherited;
  if Child is TcxGridChartSeries then
    TcxGridChartSeries(Child).Index := Order;
end;

function ChartViewGetSeries(ACaller: TComponent; Index: Integer): TComponent;
begin
  Result := TcxGridChartView(ACaller).Series[Index];
end;

procedure TcxGridChartView.SetName(const NewName: TComponentName);
var
  AOldName: TComponentName;
begin
  AOldName := Name;
  inherited;
  if Name <> AOldName then
    RenameComponents(Self, Owner, Name, AOldName, SeriesCount, @ChartViewGetSeries);
end;

procedure TcxGridChartView.UpdateControl(AInfo: TcxUpdateControlInfo);
begin
  if not (IsLoading or IsDestroying) and not (AInfo is TcxFocusedRowChangedInfo) then
  begin
    Changed(vcLayout);
    if (AInfo is TcxDataChangedInfo) or (AInfo is TcxLayoutChangedInfo) then
      Synchronize;
  end;
  inherited;
end;

function TcxGridChartView.GetControllerClass: TcxCustomGridControllerClass;
begin
  Result := TcxGridChartController;
end;

function TcxGridChartView.GetDataControllerClass: TcxCustomDataControllerClass;
begin
  Result := TcxGridChartDataController;
end;

function TcxGridChartView.GetItemDataBindingClass: TcxGridChartItemDataBindingClass;
begin
  Result := TcxGridChartItemDataBinding;
end;

function TcxGridChartView.GetPainterClass: TcxCustomGridPainterClass;
begin
  Result := TcxGridChartPainter;
end;

function TcxGridChartView.GetViewDataClass: TcxCustomGridViewDataClass;
begin
  Result := TcxGridChartViewData;
end;

function TcxGridChartView.GetViewInfoClass: TcxCustomGridViewInfoClass;
begin
  Result := TcxGridChartViewInfo;
end;

function TcxGridChartView.GetLegendClass: TcxGridChartLegendClass;
begin
  Result := TcxGridChartLegend;
end;

function TcxGridChartView.GetOptionsBehaviorClass: TcxCustomGridOptionsBehaviorClass;
begin
  Result := TcxGridChartOptionsBehavior;
end;

function TcxGridChartView.GetStylesClass: TcxCustomGridViewStylesClass;
begin
  Result := TcxGridChartViewStyles;
end;

function TcxGridChartView.GetTitleClass: TcxGridChartTitleClass;
begin
  Result := TcxGridChartTitle;
end;

function TcxGridChartView.GetBarDiagramClass: TcxGridChartBarDiagramClass;
begin
  Result := TcxGridChartBarDiagram;
end;

function TcxGridChartView.GetCategoriesClass: TcxGridChartCategoriesClass;
begin
  Result := TcxGridChartCategories;
end;

function TcxGridChartView.GetColumnDiagramClass: TcxGridChartColumnDiagramClass;
begin
  Result := TcxGridChartColumnDiagram;
end;

procedure TcxGridChartView.AddDiagram(ADiagram: TcxGridChartDiagram);
begin
  FDiagrams.Add(ADiagram);
  ADiagram.SetGridView(Self);
  if ActiveDiagram = nil then
    ActiveDiagram := GetFirstAvailableDiagram;
end;

procedure TcxGridChartView.RemoveDiagram(ADiagram: TcxGridChartDiagram);
begin
  ADiagram.SetGridView(nil);
  FDiagrams.Remove(ADiagram);
  DiagramRemoved(ADiagram);  
  if ActiveDiagram = ADiagram then
    ActiveDiagram := nil;
end;

procedure TcxGridChartView.ClearDiagrams;
var
  I: Integer;
begin
  for I := DiagramCount - 1 downto 0 do
    Diagrams[I].Free;
end;

function TcxGridChartView.CreateDiagram(ADiagramClass: TcxGridChartDiagramClass): TcxGridChartDiagram;
begin
  Result := ADiagramClass.Create(Self);
end;

procedure TcxGridChartView.CreateDiagrams;
begin
  FDiagramColumn := TcxGridChartColumnDiagram(CreateDiagram(GetColumnDiagramClass));  // should first to be default
  FDiagramBar := TcxGridChartBarDiagram(CreateDiagram(GetBarDiagramClass));
end;

procedure TcxGridChartView.DiagramRemoved(ADiagram: TcxGridChartDiagram);
begin
  if ADiagram = FDiagramBar then
    FDiagramBar := nil;
  if ADiagram = FDiagramColumn then
    FDiagramColumn := nil;
end;
  
function TcxGridChartView.GetDiagramNamePath(ADiagram: TcxGridChartDiagram): string;
var
  APropList: PPropList;
  I: Integer;
begin
  Result := Name;
  if Result <> '' then
    Result := Result + '.';
  I := GetPropList(ClassInfo, [tkClass], nil);
  GetMem(APropList, I * SizeOf(PPropInfo));
  GetPropList(ClassInfo, [tkClass], APropList);
  try
    for I := 0 to I - 1 do
      if APropList[I].PropType^ = ADiagram.ClassInfo then
      begin
        Result := Result + APropList[I].Name;
        Break;
      end;
  finally
    FreeMem(APropList);
  end;  
end;

function TcxGridChartView.GetFirstAvailableDiagram: TcxGridChartDiagram;
var
  I: Integer;
begin
  for I := 0 to DiagramCount - 1 do
  begin
    Result := Diagrams[I];
    if Result.Enabled then Exit;
  end;
  Result := nil;
end;

function TcxGridChartView.GetNextID: Integer;
begin
  Result := FNextID;
  Inc(FNextID);
end;

procedure TcxGridChartView.ReleaseID(AID: Integer);
begin
  if AID = FNextID - 1 then Dec(FNextID);
end;

procedure TcxGridChartView.AddSeries(ASeries: TcxGridChartSeries);
begin
{$IFDEF DELPHI6}
  if csTransient in ComponentStyle then
    ASeries.FComponentStyle := ASeries.FComponentStyle + [csTransient];
{$ENDIF}
  FSeries.Add(ASeries);
  ASeries.SetGridView(Self);
  RefreshVisibleSeriesList;
  UpdateDataController(ASeries, ASeries.DataBinding, True);
  Changed(vcLayout);
end;

procedure TcxGridChartView.RemoveSeries(ASeries: TcxGridChartSeries);
begin
  ASeries.SetGridView(nil);
  FSeries.Remove(ASeries);
  RefreshVisibleSeriesList;
  UpdateDataController(ASeries, ASeries.DataBinding, False);
  Changed(vcLayout);
end;

function TcxGridChartView.GetSeriesClass: TcxGridChartSeriesClass;
begin
  Result := TcxGridChartSeries;
end;

function TcxGridChartView.IndexOfSeries(ASeries: TcxGridChartSeries): Integer;
begin
  Result := FSeries.IndexOf(ASeries);
end;

procedure TcxGridChartView.SetSeriesIndex(ASeries: TcxGridChartSeries;
  AIndex: Integer);
begin
  FSeries.Move(IndexOfSeries(ASeries), AIndex);
  RefreshVisibleSeriesList;
  Changed(vcLayout);
end;

procedure TcxGridChartView.UpdateDataController(AItem: TObject;
  ADataBinding: TcxGridChartItemDataBinding; AAdd: Boolean);
begin
  if AAdd then
  begin
    ADataBinding.DataField := FDataController.AddItem(AItem);
    ADataBinding.ID := GetNextID;
  end
  else
  begin
    ReleaseID(ADataBinding.ID);
    ADataBinding.DataField := nil;
    FDataController.RemoveItem(AItem);
  end;
end;

procedure TcxGridChartView.CreateHandlers;
begin
  FCategories := GetCategoriesClass.Create(Self);
  FDiagrams := TList.Create;
  FSeries := TList.Create;
  FVisibleSeries := TList.Create;
  CreateDiagrams;
  inherited;
  UpdateDataController(FCategories, FCategories.DataBinding, True);
end;

procedure TcxGridChartView.DestroyHandlers;
begin
  ClearDiagrams;
  ClearSeries;
  UpdateDataController(FCategories, FCategories.DataBinding, False);
  inherited;
  FreeAndNil(FVisibleSeries);
  FreeAndNil(FSeries);
  FreeAndNil(FDiagrams);
  FreeAndNil(FCategories);
end;

procedure TcxGridChartView.CreateOptions;
begin
  inherited;
  FLegend := GetLegendClass.Create(Self);
  FTitle := GetTitleClass.Create(Self);
end;

procedure TcxGridChartView.DestroyOptions;
begin
  FreeAndNil(FTitle);
  FreeAndNil(FLegend);
  inherited;
end;

procedure TcxGridChartView.CalculateImageWidth(var AWidth: Integer);
const
  DefaultWidth = 700;
begin
  if AWidth = 0 then
  begin
    if Control <> nil then
      AWidth := Control.Width;
    if AWidth = 0 then
      AWidth := DefaultWidth;
  end;
end;

procedure TcxGridChartView.CalculateImageHeight(var AHeight: Integer);
const
  DefaultHeight = 500;
begin
  if AHeight = 0 then
  begin
    AHeight := TcxGridLevel(Level).Parent.MaxDetailHeight;
    if AHeight = 0 then
    begin
      if Control <> nil then
        AHeight := Control.Height;
      if AHeight = 0 then
        AHeight := DefaultHeight;
    end;
  end;
end;

procedure TcxGridChartView.DoActiveDiagramChanged(ADiagram: TcxGridChartDiagram);
begin
  if Assigned(FOnActiveDiagramChanged) and (ADiagram <> nil) then
    FOnActiveDiagramChanged(Self, ADiagram);
end;

procedure TcxGridChartView.DoCustomDrawLegend(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawLegend then
    FOnCustomDrawLegend(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridChartView.DoCustomDrawLegendItem(ACanvas: TcxCanvas;
  AViewInfo: TcxGridChartLegendItemViewInfo; var ADone: Boolean);
begin
  if HasCustomDrawLegendItem then
    FOnCustomDrawLegendItem(Self, ACanvas, AViewInfo, ADone);
end;

procedure TcxGridChartView.DoGetValueHint(ASeries: TcxGridChartSeries; AValueIndex: Integer;
  var AHint: string);
begin
  if Assigned(FOnGetValueHint) then
    FOnGetValueHint(Self, ASeries, AValueIndex, AHint);
end;

function TcxGridChartView.HasCustomDrawLegend: Boolean;
begin
  Result := Assigned(FOnCustomDrawLegend);
end;

function TcxGridChartView.HasCustomDrawLegendItem: Boolean;
begin
  Result := Assigned(FOnCustomDrawLegendItem);
end;

procedure TcxGridChartView.ClearSeries;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := SeriesCount - 1 downto 0 do
      Series[I].Free;
  finally
    EndUpdate;
  end;
end;

function TcxGridChartView.CreateSeries: TcxGridChartSeries;
begin
  Result := GetSeriesClass.Create(Owner);
  AddSeries(Result);
end;

function TcxGridChartView.FindSeriesByID(AID: Integer): TcxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to SeriesCount - 1 do
  begin
    Result := Series[I];
    if Result.ID = AID then Exit;
  end;
  Result := nil;
end;

function TcxGridChartView.FindSeriesByName(const AName: string): TcxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to SeriesCount - 1 do
  begin
    Result := Series[I];
    if Result.Name = AName then Exit;
  end;
  Result := nil;
end;

function TcxGridChartView.FindSeriesByTag(ATag: TcxTag): TcxGridChartSeries;
var
  I: Integer;
begin
  for I := 0 to SeriesCount - 1 do
  begin
    Result := Series[I];
    if Result.Tag = ATag then Exit;
  end;
  Result := nil;
end;

{$IFNDEF DELPHI6}

type
  TGraphicAccess = class(TGraphic);
  TGraphicAccessClass = class of TGraphicAccess;

{$ENDIF}

function TcxGridChartView.CreateImage(AGraphicClass: TGraphicClass;
  AWidth: Integer = 0; AHeight: Integer = 0): TGraphic;

  procedure DrawImage(AImageCanvas: TCanvas);
  var
    AViewInfo: TcxCustomGridViewInfo;
    ACanvas: TcxCanvas;
  begin
    AViewInfo := CreateViewInfo;
    try
      AViewInfo.IsInternalUse := True;
      AViewInfo.MainCalculate(Rect(0, 0, AWidth, AHeight));
      ACanvas := TcxCanvas.Create(AImageCanvas);
      try
        Painter.Paint(ACanvas, AViewInfo);
      finally
        ACanvas.Free;
      end;
    finally
      AViewInfo.Free;
    end;
  end;

var
  AMetaFileCanvas: TMetaFileCanvas;
begin
  if IsPattern or
    not (AGraphicClass.InheritsFrom(TMetafile) or AGraphicClass.InheritsFrom(TBitmap)) then
  begin
    Result := nil;
    Exit;
  end;
  CalculateImageWidth(AWidth);
  CalculateImageHeight(AHeight);
  Result := {$IFNDEF DELPHI6}TGraphicAccessClass{$ENDIF}(AGraphicClass).Create;
  Result.Width := AWidth;
  Result.Height := AHeight;
  if Result is TMetaFile then
  begin
    Result.Transparent := True;
    AMetaFileCanvas := TMetaFileCanvas.Create(TMetaFile(Result), 0);
    try
      DrawImage(AMetaFileCanvas);
    finally
      AMetaFileCanvas.Free;
    end;
  end
  else
    DrawImage(TBitmap(Result).Canvas);
end;

initialization
  cxGridRegisteredViews.Register(TcxGridChartView, 'Chart');
  Classes.RegisterClass(TcxGridChartSeries);

finalization
  cxGridRegisteredViews.Unregister(TcxGridChartView);

end.
