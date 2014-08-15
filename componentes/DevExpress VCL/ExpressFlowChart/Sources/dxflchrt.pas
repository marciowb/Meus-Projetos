{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressFlowChart                                            }
{                                                                   }
{       Copyright (c) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSFLOWCHART AND ALL ACCOMPANYING}
{   VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY.             }
{                                                                   }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED      }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE        }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE       }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT  }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                      }
{                                                                   }
{   CONSULT THE end USER LICENSE AGREEMENT FOR INFORMATION ON       }
{   ADDITIONAL RESTRICTIONS.                                        }
{                                                                   }
{*******************************************************************}

unit dxflchrt;

{$I cxVer.inc}

interface

uses 
  Types, SysUtils, Classes, Windows, Graphics, Messages, StdCtrls, Forms, dxLines,
  ImgList, Controls, cxControls, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters;

const
  TO_HOME = $8000000;
  TO_END = $7FFFFFF;

type
  TdxFcItem = class;
  TdxFcObject = class;
  TdxFcConnection = class;
  TdxCustomFlowChart = class;

  TdxFcShapeType = (fcsNone, fcsRectangle, fcsEllipse, fcsRoundRect, fcsDiamond,
    fcsNorthTriangle, fcsSouthTriangle, fcsEastTriangle, fcsWestTriangle,
    fcsHexagon, fcsUser);

  TdxFclStyle = (fclStraight, fclCurved, fclRectH, fclRectV);
  TdxFcaType = (fcaNone, fcaArrow, fcaEllipse, fcaRectangle);

  TdxFcHorzPos = (fchpLeft, fchpCenter, fchpRight);
  TdxFcVertPos = (fcvpUp, fcvpCenter, fcvpDown);
  TdxFcHitTest = set of (htNowhere, htByObject, htOnObject, htOnConnection,
    htOnConLabel, htOnArrowSrc, htOnArrowDst, htOnSelPoint);
  TdxFcOption = (fcoCanDelete, fcoCanDrag, fcoCanSelect, fcoMultiSelect,
    fcoHideSelection, fcoDelOnClick, fcoDynamicSizing, fcoDynamicMoving);
  TdxFcOptions = set of TdxFcOption;

  TdxFcDragHandler = procedure(X, Y: Integer; State: TDragState) of object;
  TdxFcEvent = procedure(Sender: TdxCustomFlowChart; Item: TdxFcItem) of object;
  TdxFcAllowEvent = procedure(Sender: TdxCustomFlowChart; Item: TdxFcItem; var Allow: Boolean) of object;
  TdxFcEditEvent = procedure(Sender: TdxCustomFlowChart; AObject: TdxFcObject; var S: string) of object;
  TdxFcDrawEvent = procedure(Sender: TdxCustomFlowChart; AObject: TdxFcObject; R: TRect) of object;

  TdxFcObjData = packed record
    Left: Integer;
    Top: Integer;
    Width: Word;
    Height: Word;
    Edge: Word;
    Border: Word;
    HTPos: TdxFcHorzPos;
    VTPos: TdxFcVertPos;
    HIPos: TdxFcHorzPos;
    VIPos: TdxFcVertPos;
    BkColor: TColor;
    ShColor: TColor;
    Tag: Integer;
    ObjCnt: Word;
    Image: Smallint;
    Shape: TdxFcShapeType;
    ShWidth: Byte;
    ParFont: Boolean;
    Transparent: Boolean;
  end;

  TdxFcArwData = packed record
    AType: TdxFcaType;
    Width: Byte;
    Height: Byte;
    Color: TColor;
  end;

  TdxFcConData = packed record
    ObjSrc: Smallint;
    ObjDst: Smallint;
    PtCount: Word;
    Color: TColor;
    PtSrc: Byte;
    PtDst: Byte;
    Style: TdxFclStyle;
    ParFont: Boolean;
    ArwSrc: TdxFcArwData;
    ArwDst: TdxFcArwData;
  end;

  TdxFcFntData = packed record
    Height: Smallint;
    Color: TColor;
    Pitch: TFontPitch;
    Style: TFontStyles;
    Charset: TFontCharset;
  end;

  TdxFcSelectionPoints = array[0..7] of TPoint;

  { TdxFlowChartPainter }

  TdxFlowChartPainter = class(TObject)
  private
    procedure PrepareBrush(ACanvas: TcxCanvas; AColor: TColor);
    procedure PreparePen(ACanvas: TcxCanvas; AColor: TColor; AStyle: TPenStyle; AWidth: Integer);
  public
    procedure DrawEdge(ACanvas: TcxCanvas; const R: TRect; AEdgeStyle, ABorderStyle: Cardinal); virtual;
    procedure DrawEllipse(ACanvas: TcxCanvas; const R: TRect; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); virtual;
    procedure DrawPolygon(ACanvas: TcxCanvas; const P: array of TPoint; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); virtual;
    procedure DrawPolyline(ACanvas: TcxCanvas; const P: array of TPoint; AColor: TColor;
      AStyle: TPenStyle; AWidth: Integer); virtual;
    procedure DrawRectangle(ACanvas: TcxCanvas; const R: TRect; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); virtual;
    procedure DrawRegion(ACanvas: TcxCanvas; ARegionHandle: TcxRegionHandle;
      ABackgroundColor: TColor; AFrameColor: TColor; AFrameWidth: Integer); virtual;
    procedure DrawRoundRect(ACanvas: TcxCanvas; const R: TRect; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth, ARadiusX, ARadiusY: Integer); virtual;
  end;

  { TdxFlowChartGDIPlusPainter }

  TdxFlowChartGDIPlusPainter = class(TdxFlowChartPainter)
  public
    procedure DrawEllipse(ACanvas: TcxCanvas; const R: TRect; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); override;
    procedure DrawPolygon(ACanvas: TcxCanvas; const P: array of TPoint;
      ABackgroundColor, AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); override;
    procedure DrawPolyline(ACanvas: TcxCanvas; const P: array of TPoint;
      AColor: TColor; AStyle: TPenStyle; AWidth: Integer); override;
    procedure DrawRectangle(ACanvas: TcxCanvas; const R: TRect; ABackgroundColor: TColor;
      AFrameColor: TColor; AFrameStyle: TPenStyle; AFrameWidth: Integer); override;
    procedure DrawRoundRect(ACanvas: TcxCanvas; const R: TRect;
      ABackgroundColor: TColor; AFrameColor: TColor; AFrameStyle: TPenStyle;
      AFrameWidth: Integer; ARadiusX: Integer; ARadiusY: Integer); override;
  end;

  { TdxFcItem }

  TdxFcItem = class(TPersistent)
  private
    FDestroying: Boolean;
    FFont: TFont;
    FOwner: TdxCustomFlowChart;
    FParentFont: Boolean;
    FRealFont: TFont;
    FSelected: Boolean;
    FText: string;
    procedure CalculateRealFont;
    procedure OnFontChange(Sender: TObject);
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure SetSelected(Value: Boolean);
  protected
    function GetDisplayRect: TRect; virtual; abstract;
    function GetSelectionRect: TRect; virtual;
    function SelList: TList; virtual; abstract;
    procedure Changed;
    procedure FontChanged; virtual;
    procedure Invalidate; virtual; abstract;
    procedure LoadFont(Stream: TStream; AIsUnicode: Boolean);
    procedure SaveFont(Stream: TStream);
    procedure SetText(Value: string); virtual; abstract;
    procedure ScaleFont;
    //
    property DisplayRect: TRect read GetDisplayRect;
    property RealFont: TFont read FRealFont;
    property SelectionRect: TRect read GetSelectionRect;
  public
    constructor Create(AOwner: TdxCustomFlowChart);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //
    property Destroying: Boolean read FDestroying;
    property Font: TFont read FFont write SetFont;
    property Owner: TdxCustomFlowChart read FOwner;
    property ParentFont: Boolean read FParentFont write SetParentFont;
    property Selected: Boolean read FSelected write SetSelected;
    property Text: string read FText write SetText;
  end;

  { TdxFcObject }

  TdxFcObject = class(TdxFcItem)
  private
    FBkColor: TColor;
    FBorder: Word;
    FConnections: TList;
    FCustomData: string;
    FData: Pointer;
    FEdge: Word;
    FHeight: Word;
    FHorzImagePos: TdxFcHorzPos;
    FHorzTextPos: TdxFcHorzPos;
    FImageIndex: Smallint;
    FLeft: Integer;
    FLinkedObjects: TList;
    FObjects: TList;
    FRealContentIndent: Integer;
    FRealHeight: Integer;
    FRealLeft: Integer;
    FRealSW: Word;
    FRealTop: Integer;
    FRealWidth: Integer;
    FShapeColor: TColor;
    FShapeStyle: TPenStyle;
    FShapeType: TdxFcShapeType;
    FShapeWidth: Byte;
    FTag: Integer;
    FTop: Integer;
    FTransparent: Boolean;
    FVertImagePos: TdxFcVertPos;
    FVertTextPos: TdxFcVertPos;
    FVisible: Boolean;
    FWidth: Word;
    function GetClientRect: TRect;
    function GetConnection(Index: Integer): TdxFcConnection;
    function GetConnectionCount: Integer;
    function GetIsUnion: Boolean;
    function GetLinkedObject(Index: Integer): TdxFcObject;
    function GetLinkedObjectCount: Integer;
    function GetObjectCount: Integer;
    function GetObjectValue(Index: Integer): TdxFcObject;  // renamed because of C++Builder
    function GetPainter: TdxFlowChartPainter;
    function GetPoint(const P: array of TPoint; X, Y, Cnt: Integer): Integer;
    function GetZOrder: Word;
    function HasEdge: Boolean;
    function HasImage: Boolean;
    function Quadrant(X, Y: Integer): Integer;
    procedure CalculateLinkedPoints;
    procedure CalculateRealBounds;
    procedure CalculateRealShapeWidth;
    procedure ResolveObjRefs;

    procedure SelPoints(var Pts: TdxFcSelectionPoints);
    procedure SetBkColor(Value: TColor);
    procedure SetBorder(Value: Word);
    procedure SetEdge(Value: Word);
    procedure SetHeight(Value: Word);
    procedure SetHorzImagePos(Value: TdxFcHorzPos);
    procedure SetHorzTextPos(Value: TdxFcHorzPos);
    procedure SetImageIndex(Value: Smallint);
    procedure SetLeft(Value: Integer);
    procedure SetShapeColor(Value: TColor);
    procedure SetShapeStyle(Value: TPenStyle);
    procedure SetShapeType(Value: TdxFcShapeType);
    procedure SetShapeWidth(Value: Byte);
    procedure SetTop(Value: Integer);
    procedure SetTransparent(Value: Boolean);
    procedure SetVertImagePos(Value: TdxFcVertPos);
    procedure SetVertTextPos(Value: TdxFcVertPos);
    procedure SetVisible(Value: Boolean);
    procedure SetWidth(Value: Word);
    procedure SetZOrder(Value: Word);
    procedure UpdateConnections;
    procedure ZoomChanged;
  protected
    LinkedPoints: array[0..15] of TPoint;
    function CalculatePolygon(out APolygon: TPointArray; AIndent: Integer): Boolean; virtual;
    function CalculateRegion(const ARect: TRect; AShapeWidth: Integer): TcxRegionHandle; virtual;
    function CreateClientRegion: TcxRegionHandle;
    function CreateShapeRegion: TcxRegionHandle;
    function GetDisplayRect: TRect; override;
    function SelList: TList; override;
    function UserRegion(R: TRect): HRgn; virtual;
    procedure Invalidate; override;
    procedure Load(Stream: TStream; AIsUnicode: Boolean); virtual;
    procedure Save(Stream: TStream); virtual;
    procedure SetText(Value: string); override;
    procedure UserLinkedPoints; virtual;
    //
    procedure Paint(ACanvas: TcxCanvas);
    procedure PaintBackground(ACanvas: TcxCanvas);
    //
    property ClientRect: TRect read GetClientRect;
    property Painter: TdxFlowChartPainter read GetPainter;
    property RealContentIndent: Integer read FRealContentIndent;
    property RealSW: Word read FRealSW;
  public
    constructor Create(AOwner: TdxCustomFlowChart);
    destructor Destroy; override;
    function GetLinkedPoint(X, Y: Integer): Integer;
    function GetSelPoint(X, Y: Integer): Integer;
    function HasInUnion(AObject: TdxFcObject): Boolean;
    function HitTest(const P: TPoint): TdxFcHitTest; virtual;
    function InRect(const R: TRect): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure AddToUnion(AObject: TdxFcObject);
    procedure RemoveFromUnion(AObject: TdxFcObject);
    procedure BringToFront;
    procedure ClearUnion;
    procedure MakeVisible;
    procedure PaintImage(const R: TRect);
    procedure PaintText(const R: TRect);
    procedure PutInFrontOf(Value: TdxFcObject);
    procedure SelectUnion;
    procedure SendToBack;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); overload;
    procedure SetBounds(const R: TRect); overload;
    //
    property BkColor: TColor read FBkColor write SetBkColor;
    property BorderStyle: Word read FBorder write SetBorder;
    property ConnectionCount: Integer read GetConnectionCount;
    property Connections[Index: Integer]: TdxFcConnection read GetConnection;
    property CustomData: string read FCustomData write FCustomData;
    property Data: Pointer read FData write FData;
    property EdgeStyle: Word read FEdge write SetEdge;
    property Height: Word read FHeight write SetHeight;
    property HorzImagePos: TdxFcHorzPos read FHorzImagePos write SetHorzImagePos;
    property HorzTextPos: TdxFcHorzPos read FHorzTextPos write SetHorzTextPos;
    property ImageIndex: Smallint read FImageIndex write SetImageIndex;
    property IsUnion: Boolean read GetIsUnion;
    property Left: Integer read FLeft write SetLeft;
    property LinkedObjectCount: Integer read GetLinkedObjectCount;
    property LinkedObjects[Index: Integer]: TdxFcObject read GetLinkedObject;
    property ObjectCount: Integer read GetObjectCount;
    property Objects[Index: Integer]: TdxFcObject read GetObjectValue;
    property RealHeight: Integer read FRealHeight;
    property RealLeft: Integer read FRealLeft;
    property RealTop: Integer read FRealTop;
    property RealWidth: Integer read FRealWidth;
    property ShapeColor: TColor read FShapeColor write SetShapeColor;
    property ShapeStyle: TPenStyle read FShapeStyle write SetShapeStyle;
    property ShapeType: TdxFcShapeType read FShapeType write SetShapeType;
    property ShapeWidth: Byte read FShapeWidth write SetShapeWidth;
    property Tag: Integer read FTag write FTag;
    property Top: Integer read FTop write SetTop;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property VertImagePos: TdxFcVertPos read FVertImagePos write SetVertImagePos;
    property VertTextPos: TdxFcVertPos read FVertTextPos write SetVertTextPos;
    property Visible: Boolean read FVisible write SetVisible;
    property Width: Word read FWidth write SetWidth;
    property ZOrder: Word read GetZOrder write SetZOrder;
  end;

  { TdxFcConnectionArrow }

  TdxFcConnectionArrow = class(TPersistent)
  private
    FArrowType: TdxFcaType;
    FColor: TColor;
    FHeight: Byte;
    FOwner: TdxFcConnection;
    FPoints: array[0..3] of TPoint;
    FRealHeight: Word;
    FRealWidth: Word;
    FWidth: Byte;
    function DisplayRect(Ext: Boolean): TRect;
    function GetActive: Boolean;
    function GetPainter: TdxFlowChartPainter;
    procedure SetArrowType(Value: TdxFcaType);
    procedure SetColor(Value: TColor);
    procedure SetHeight(Value: Byte);
    procedure SetPoints(Index: Integer);
    procedure SetRealBounds;
    procedure SetWidth(Value: Byte);
  protected
    procedure ClearPoints;
    procedure OffsetPoints(DX, DY: Integer);
    procedure Paint(ACanvas: TcxCanvas);
    procedure Reset;
    procedure Load(const AData: TdxFcArwData);
    procedure Save(out AData: TdxFcArwData);
    //
    property Active: Boolean read GetActive;
    property Painter: TdxFlowChartPainter read GetPainter;
  public
    constructor Create(AOwner: TdxFcConnection);
    procedure Assign(Source: TPersistent); override;
    //
    property Owner: TdxFcConnection read FOwner;
    property ArrowType: TdxFcaType read FArrowType write SetArrowType;
    property Height: Byte read FHeight write SetHeight;
    property Width: Byte read FWidth write SetWidth;
    property Color: TColor read FColor write SetColor;
  end;

  { TdxFcConnection }

(*
  Point1 and Point2 properties is the linked point type.
  It may have value from 0..15.
  0   1   2   3   4
  15              5
  14              6
  13              7
  12  11  10  9   8
*)

  TdxFcConnection = class(TdxFcItem)
  private
    FArrowDest: TdxFcConnectionArrow;
    FArrowSource: TdxFcConnectionArrow;
    FColor: TColor;
    FDisplayRect: TRect;
    FMassCenter: TPoint;
    FObjectDest: TdxFcObject;
    FObjectSource: TdxFcObject;
    FPenStyle: TPenStyle;
    FPenWidth: Integer;
    FPointDest: Byte;
    FPoints: TdxFcPoints;
    FPointSource: Byte;
    FRealPoints: TdxFcPoints;
    FStyle: TdxFclStyle;
    FTextRect: TRect;
    FTransparent: Boolean;
    function GetPoint(Index: Integer): TPoint;
    function GetPointCount: Integer;
    function GetRealCount: Integer;
    function GetRealPoint(Index: Integer): TPoint;
    function GetRealTextRect: TRect;
    function HasPoint(const P: TPoint): Boolean;
    function IndexValid(var Index: Integer; AMax: Integer): Boolean;
    function RealStyle: TdxFclStyle;
    function ScreenPoint(Index: Integer): TPoint;
    procedure CalculateDisplayRect;
    procedure CalculateTextRect;
    procedure DelObj(AObj, Partneur: TdxFcObject; Index: Integer);
    procedure InsObj(AObj, Partneur: TdxFcObject; Index: Integer);
    procedure InvalidateText;
    procedure NewPoint(X, Y: Integer; Handler: TdxFcDragHandler);
    procedure OffsetRealPoints(DX, DY: Integer);
    procedure SetArrowSource(Value: TdxFcConnectionArrow);
    procedure SetArrowDest(Value: TdxFcConnectionArrow);
    procedure SetColor(Value: TColor);
    procedure SetObjectPoints;
    procedure SetPenStyle(Value: TPenStyle);
    procedure SetPenWidth(Value: Integer);
    procedure SetPoint(AIndex: Integer; AValue: TPoint);
    procedure SetStyle(Value: TdxFclStyle);
    procedure SetTransparent(Value: Boolean);
    procedure ZoomChanged;
  protected
    function GetDisplayRect: TRect; override;
    function SelList: TList; override;
    procedure ArrowChanged(Value: TdxFcConnectionArrow);
    procedure ConnectionChanged;
    procedure FontChanged; override;
    procedure InternalInsertPoint(AIndex: Integer; P: TPoint);
    procedure Invalidate; override;
    procedure Load(Stream: TStream; AIsUnicode: Boolean); virtual;
    procedure Save(Stream: TStream); virtual;
    procedure SetText(Value: string); override;
    //
    procedure DrawContent(ACanvas: TcxCanvas);
    procedure DrawLine(ACanvas: TcxCanvas);
    procedure DrawText(ACanvas: TcxCanvas);
    procedure Paint(ACanvas: TcxCanvas; Upper: Boolean);
    //
    property RealCount: Integer read GetRealCount;
    property RealPoints[Index: Integer]: TPoint read GetRealPoint;
    property RealTextRect: TRect read GetRealTextRect;
  public
    constructor Create(AOwner: TdxCustomFlowChart);
    destructor Destroy; override;
    function GetNearestPoint(X, Y: Integer): Integer;
    function InRect(const R: TRect): Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure AddPoint(const P: TPoint);
    procedure InsertPoint(Index: Integer; const P: TPoint);
    procedure RemovePoint(Index: Integer);
    procedure SetObjectSource(AObject: TdxFcObject; APoint: Byte);
    procedure SetObjectDest(AObject: TdxFcObject; APoint: Byte);
    //
    property ArrowSource: TdxFcConnectionArrow read FArrowSource write SetArrowSource;
    property ArrowDest: TdxFcConnectionArrow read FArrowDest write SetArrowDest;
    property Color: TColor read FColor write SetColor;
    property ObjectSource: TdxFcObject read FObjectSource;
    property ObjectDest: TdxFcObject read FObjectDest;
    property PenStyle: TPenStyle read FPenStyle write SetPenStyle;
    property PenWidth: Integer read FPenWidth write SetPenWidth;  // is not saved in the stream/file
    property PointCount: Integer read GetPointCount;
    property Points[Index: Integer]: TPoint read GetPoint write SetPoint;
    property PointSource: Byte read FPointSource;
    property PointDest: Byte read FPointDest;
    property Style: TdxFclStyle read FStyle write SetStyle;
    property Transparent: Boolean read FTransparent write SetTransparent;
  end;

  { TdxFcSelection }

  TdxFcSelection = class(TObject)
  private
    Owner: TdxCustomFlowChart;
    Counts: TList;
    Points: TList;
  protected
    procedure AddPoint(const P: TPoint); overload;
    procedure AddPoint(X, Y: Integer); overload;
    procedure Clear;
    procedure Paint;
  public
    constructor Create(AOwner: TdxCustomFlowChart);
    destructor Destroy; override;
  end;

  { TdxFlowChartDragHelper }

  TdxFlowChartDragHelper = class(TObject)
  private
    FBase: TPoint;
    FDragConnection: TdxFcConnection;
    FDragging: Boolean;
    FDragHandler: TdxFcDragHandler;
    FDragObject: TdxFcObject;
    FDynamicMoving: Boolean;
    FDynamicSizing: Boolean;
    FIndex: Integer;
    FMobile: TPoint;
    FOwner: TdxCustomFlowChart;
    FPaintLocked: Boolean;
    FRegion: TcxRegionHandle;
    function GetCanvas: TcxCanvas;
    function GetConnectionAt: TdxFcConnection;
    function GetObjectAt: TdxFcObject;
  protected
    procedure CallDragHandler(X, Y: Integer; State: TDragState);
    procedure DoDragConnect(X, Y: Integer; State: TDragState);
    procedure DoDragMove(X, Y: Integer; State: TDragState);
    procedure DoDragPoint(X, Y: Integer; State: TDragState);
    procedure DoDragResize(X, Y: Integer; State: TDragState);
    //
    property ConnectionAt: TdxFcConnection read GetConnectionAt;
    property DynamicMoving: Boolean read FDynamicMoving;
    property DynamicSizing: Boolean read FDynamicSizing;
    property ObjectAt: TdxFcObject read GetObjectAt;
  public
    constructor Create(AOwner: TdxCustomFlowChart);
    procedure CheckDragStart(X, Y: Integer;
      const AShift: TShiftState; const AHitTest: TdxFcHitTest);
    procedure DragStart(X, Y: Integer; AHandler: TdxFcDragHandler);
    procedure DragMove(X, Y: Integer);
    procedure DragStop(X, Y: Integer);
    //
    property Canvas: TcxCanvas read GetCanvas;
    property Dragging: Boolean read FDragging;
    property Owner: TdxCustomFlowChart read FOwner;
    property PaintLocked: Boolean read FPaintLocked;
  end;

  { TdxCustomFlowChart }

  TdxCustomFlowChart = class(TcxControl)
  private
    FAntialiasing: Boolean;
    FChangeLink: TChangeLink;
    FChartHeight: Integer;
    FChartLeft: Integer;
    FChartTop: Integer;
    FChartWidth: Integer;
    FConnectionAt: TdxFcConnection;
    FConnections: TList;
    FDragHelper: TdxFlowChartDragHelper;
    FDragStartPoint: TPoint;
    FHitTest: TdxFcHitTest;
    FHitX: Integer;
    FHitY: Integer;
    FImages: TCustomImageList;
    FLeftEdge: Integer;
    FLoading: Boolean;
    FLockUpdates: Integer;
    FObjectAt: TdxFcObject;
    FObjects: TList;
    FOptions: TdxFcOptions;
    FPainter: TdxFlowChartPainter;
    FRealZoom: Word;
    FRepaint: Boolean;
    FSelConnections: TList;
    FSelection: TdxFcSelection;
    FSelObjects: TList;
    FTopEdge: Integer;
    FZoom: Word;
    FOnChange: TdxFcEvent;
    FOnCreateItem: TdxFcEvent;
    FOnDeletion: TdxFcEvent;
    FOnDrawObject: TdxFcDrawEvent;
    FOnEdited: TdxFcEditEvent;
    FOnEditing: TdxFcAllowEvent;
    FOnSelected: TdxFcEvent;
    FOnSelection: TdxFcAllowEvent;
    function CanPaint: Boolean;
    function GetBackgroundColor: TColor;
    function GetBorderStyle: TBorderStyle;
    function GetClientHeight: Integer;
    function GetClientWidth: Integer;
    function GetConnection(Index: Integer): TdxFcConnection;
    function GetConnectionCount: Integer;
    function GetObjectCount: Integer;
    function GetObjectValue(Index: Integer): TdxFcObject;  // renamed because of C++Builder
    function GetSelConnect: TdxFcConnection;
    function GetSelectedConnection(Index: Integer): TdxFcConnection;
    function GetSelectedConnectionCount: Integer;
    function GetSelectedObject(Index: Integer): TdxFcObject;
    function GetSelectedObjectCount: Integer;
    function GetSelObj: TdxFcObject;
    function HasSelection: Boolean;
    function TmpSel: Integer;
    procedure AbortDrag;
    procedure CalculateChartSizes;
    procedure CalculateRealPos;
    procedure DoChangeLink(Sender: TObject);
    procedure HitTest(X, Y: Integer);
    procedure InvalidateSel;
    procedure RestoreSel(Value: Integer);
    procedure ScalePoint(var P: TPoint);
    procedure SetAntialiasing(AValue: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetChartSizes;
    procedure SetConnection(Index: Integer; Value: TdxFcConnection);
    procedure SetImages(Value: TCustomImageList);
    procedure SetLeftEdge(Value: Integer);
    procedure SetObjectValue(Index: Integer; Value: TdxFcObject);
    procedure SetOptions(Value: TdxFcOptions);
    procedure SetSelConnect(Value: TdxFcConnection);
    procedure SetSelObj(Value: TdxFcObject);
    procedure SetTopEdge(Value: Integer);
    procedure SetZoom(AValue: Word);
    //
    procedure CMCtl3DChanged(var Msg: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMErase(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetCursor(var Message: TWMSetCursor); message WM_SETCURSOR;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    function CanSelect(Item: TdxFcItem): Boolean; virtual;
    function CreatePainter: TdxFlowChartPainter; virtual;
    function InternalCreateConnection: TdxFcConnection; virtual;
    function InternalCreateObject: TdxFcObject; virtual;
    function NeedRedrawOnResize: Boolean; override;
    function ScrollPoint(const P: TPoint; APositiveFactor: Boolean = True): TPoint;
    function ScrollRect(const R: TRect; APositiveFactor: Boolean = True): TRect;
    procedure BoundsChanged; override;
    procedure CalculateRealZoomFactor;
    procedure Changed(Item: TdxFcItem); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DefaultDrawObject(AObject: TdxFcObject; R: TRect); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Delete(Item: TdxFcItem); virtual;
    procedure DoDrawObject(AObject: TdxFcObject; R: TRect); virtual;
    procedure InitScrollBarsParameters; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure LookAndFeelChanged(Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MoveObjects(DX, DY: Integer);
    procedure NeedRepaint;
    procedure NeedRepaintObject(AItem: TdxFcItem);
    procedure Paint; override;
    procedure PaintSelection;
    procedure Scroll(AScrollBarKind: TScrollBarKind;
      AScrollCode: TScrollCode; var AScrollPos: Integer); override;
    procedure Select(Item: TdxFcItem); virtual;
    procedure WndProc(var Message: TMessage); override;

    property BackgroundColor: TColor read GetBackgroundColor;
    property BorderStyle: TBorderStyle read GetBorderStyle write SetBorderStyle default bsSingle;
    property ChartHeight: Integer read FChartHeight;
    property ChartWidth: Integer read FChartWidth;
    property ClientHeight: Integer read GetClientHeight;
    property ClientWidth: Integer read GetClientWidth;
    property DragHelper: TdxFlowChartDragHelper read FDragHelper;
    property Images: TCustomImageList read FImages write SetImages;
    property Options: TdxFcOptions read FOptions write SetOptions;
    property Painter: TdxFlowChartPainter read FPainter;
    property Zoom: Word read FZoom write SetZoom default 100;

    property OnChange: TdxFcEvent read FOnChange write FOnChange;
    property OnCreateItem: TdxFcEvent read FOnCreateItem write FOnCreateItem;
    property OnDeletion: TdxFcEvent read FOnDeletion write FOnDeletion;
    property OnDrawObject: TdxFcDrawEvent read FOnDrawObject write FOnDrawObject;
    property OnEdited: TdxFcEditEvent read FOnEdited write FOnEdited;
    property OnEditing: TdxFcAllowEvent read FOnEditing write FOnEditing;
    property OnSelected: TdxFcEvent read FOnSelected write FOnSelected;
    property OnSelection: TdxFcAllowEvent read FOnSelection write FOnSelection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function ChartPoint(X, Y: Integer): TPoint;
    function CreateObject(L, T, W, H: Integer; AShape: TdxFcShapeType): TdxFcObject;
    function CreateConnection(OSrc, ODst: TdxFcObject; PSrc, PDst: Byte): TdxFcConnection;
    function GetConnectionAt(X, Y: Integer): TdxFcConnection;
    function GetObjectAt(X, Y: Integer): TdxFcObject;
    function GetHitTestAt(X, Y: Integer): TdxFcHitTest;
    function SelCount: Integer;
    procedure BeginUpdate;
    procedure CancelUpdate;   
    procedure EndUpdate;
    procedure Clear;
    procedure ClearSelection;
    procedure DeleteSelection;
    procedure DeleteConnection(AConnection: TdxFcConnection);
    procedure DeleteObject(AObject: TdxFcObject);
    procedure Invalidate; override;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream); virtual;
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream); virtual;
    procedure SelectAll;
    procedure SetLeftTop(ALeft, ATop: Integer);

    property Antialiasing: Boolean read FAntialiasing write SetAntialiasing default False;
    property Color default clDefault;
    property ConnectionCount: Integer read GetConnectionCount;
    property Connections[Index: Integer]: TdxFcConnection read GetConnection write SetConnection;
    property LeftEdge: Integer read FLeftEdge write SetLeftEdge;
    property ObjectCount: Integer read GetObjectCount;
    property Objects[Index: Integer]: TdxFcObject read GetObjectValue write SetObjectValue;
    property RealZoom: Word read FRealZoom;
    property SelectedConnection: TdxFcConnection read GetSelConnect write SetSelConnect;
    property SelectedConnectionCount: Integer read GetSelectedConnectionCount;
    property SelectedConnections[Index: Integer]: TdxFcConnection read GetSelectedConnection;
    property SelectedObject: TdxFcObject read GetSelObj write SetSelObj;
    property SelectedObjectCount: Integer read GetSelectedObjectCount;
    property SelectedObjects[Index: Integer]: TdxFcObject read GetSelectedObject;
    property TopEdge: Integer read FTopEdge write SetTopEdge;
  end;

  { TdxFlowChart }

  TdxFlowChart = class(TdxCustomFlowChart)
  published
    property Align;
    property Antialiasing;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property Images;
    property LookAndFeel;
    property OnChange;
    property OnCreateItem;
    property OnDeletion;
    property OnDrawObject;
    property OnEdited;
    property OnEditing;
    property OnSelected;
    property OnSelection;
    property Options;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabStop default True;
    property Visible;
    property Zoom;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

implementation

uses
  Math, dxCore, cxGeometry, cxDrawTextUtils, cxScrollBar, dxGDIPlusClasses,
  dxGDIPlusAPI;

const
  StreamDescriptionANSI: AnsiString = 'VER1.0A';
  StreamDescriptionUNICODE: AnsiString = 'VER1.0U';

procedure Swap(var A, B: Integer);
var
  C: Integer;
begin
  C := A;
  A := B;
  B := C;
end;

procedure ExtSelRect(var R: TRect; ASelected: Boolean);
begin
  if ASelected then
    InflateRect(R, 3, 3);
end;

function GetListItem(List: TList; Index: Integer): Pointer;
begin
  if (Index >= 0) and (Index < List.Count) then
    Result := List[Index]
  else
    Result := nil;
end;

function ReadStr(Stream: TStream; AIsUnicode: Boolean): string;
var
  L: Word;
  SA: AnsiString;
  SW: WideString;
begin
  Stream.ReadBuffer(L, SizeOf(Word));
  if AIsUnicode then
  begin
    SetLength(SW, L);
    if L > 0 then Stream.ReadBuffer(SW[1], L * 2);
    Result := SW;
  end
  else
  begin
    SetLength(SA, L);
    if L > 0 then Stream.ReadBuffer(SA[1], L);
  {$IFDEF DELPHI12}
    Result := UTF8ToWideString(SA);
  {$ELSE}
    Result := SA;
  {$ENDIF}
  end;
end;

procedure WriteStr(Stream: TStream; const S: string);
var
  L: Integer;
{$IFDEF STREAMANSIFORMAT}
  SA: AnsiString;
{$ENDIF}
begin
  L := Length(S);
  if L > $FFFF then L := $FFFF;
  Stream.WriteBuffer(L, SizeOf(Word));
  if L > 0 then
  begin
  {$IFDEF STREAMANSIFORMAT}
    {$IFDEF DELPHI12}
      SA := UTF8Encode(S);
    {$ELSE}
      SA := S;
    {$ENDIF}
    Stream.WriteBuffer(SA[1], L);
  {$ELSE}
    Stream.WriteBuffer(S[1], L * SizeOf(Char));
  {$ENDIF}
  end;
end;

function AdjustRect(var R: TRect; const Bounds: TRect; HPos: TdxFcHorzPos; VPos: TdxFcVertPos): Boolean;
var
  DX, DY: Integer;
begin
  DX := Bounds.Right - Bounds.Left + R.Left - R.Right;
  DY := Bounds.Bottom - Bounds.Top + R.Top - R.Bottom;
  Result := (DX >= 0) and (DY >= 0);
  if DX < 0 then Inc(R.Right, DX);
  if DY < 0 then Inc(R.Bottom, DY);
  if (DX < 0) or (HPos = fchpLeft) then DX := 0;
  if (DY < 0) or (VPos = fcvpUp) then DY := 0;
  if HPos = fchpCenter then DX := DX shr 1;
  if VPos = fcvpCenter then DY := DY shr 1;
  DX := DX + Bounds.Left - R.Left;
  DY := DY + Bounds.Top - R.Top;
  Inc(R.Left, DX); Inc(R.Right, DX);
  Inc(R.Top, DY); Inc(R.Bottom, DY);
end;

{ TdxFcSelection }

constructor TdxFcSelection.Create(AOwner: TdxCustomFlowChart);
begin
  inherited Create;
  Owner := AOwner;
  Counts := TList.Create;
  Points := TList.Create;
end;

destructor TdxFcSelection.Destroy;
begin
  FreeAndNil(Counts);
  FreeAndNil(Points);
  inherited Destroy;
end;

procedure TdxFcSelection.AddPoint(const P: TPoint);
begin
  AddPoint(P.X, P.Y);
end;

procedure TdxFcSelection.AddPoint(X, Y: Integer);

  procedure AddOnePoint(X, Y: Integer);
  begin
    Points.Add(Pointer(X));
    Points.Add(Pointer(Y));
  end;

begin
  Dec(X, Owner.LeftEdge);
  Dec(Y, Owner.TopEdge);
  Counts.Add(Pointer(5));
  AddOnePoint(X - 2, Y - 2);
  AddOnePoint(X + 2, Y - 2);
  AddOnePoint(X + 2, Y + 2);
  AddOnePoint(X - 2, Y + 2);
  AddOnePoint(X - 2, Y - 2);
end;

procedure TdxFcSelection.Clear;
begin
  Counts.Clear;
  Points.Clear;
end;

procedure TdxFcSelection.Paint;
var
  DC: HDC;
begin
  if Counts.Count > 0 then
  begin
    DC := Owner.Canvas.Handle;
    SelectObject(DC, GetStockObject(BLACK_PEN));
    SelectObject(DC, GetStockObject(BLACK_BRUSH));
    PolyPolygon(DC, Points.List^, Counts.List^, Counts.Count);
  end;
end;

{ TdxFlowChartPainter }

procedure TdxFlowChartPainter.DrawEdge(
  ACanvas: TcxCanvas; const R: TRect; AEdgeStyle, ABorderStyle: Cardinal);
var
  R1: TRect;
begin
  R1 := R;
  Windows.DrawEdge(ACanvas.Handle, R1, AEdgeStyle, ABorderStyle);
end;

procedure TdxFlowChartPainter.DrawEllipse(ACanvas: TcxCanvas; const R: TRect;
  ABackgroundColor: TColor; AFrameColor: TColor; AFrameStyle: TPenStyle;
  AFrameWidth: Integer);
begin
  ACanvas.SaveState;
  try
    PrepareBrush(ACanvas, ABackgroundColor);
    PreparePen(ACanvas, AFrameColor, AFrameStyle, AFrameWidth);
    ACanvas.Canvas.Ellipse(R);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TdxFlowChartPainter.DrawPolygon(ACanvas: TcxCanvas;
  const P: array of TPoint; ABackgroundColor, AFrameColor: TColor;
  AFrameStyle: TPenStyle; AFrameWidth: Integer);
begin
  ACanvas.SaveState;
  try
    PrepareBrush(ACanvas, ABackgroundColor);
    PreparePen(ACanvas, AFrameColor, AFrameStyle, AFrameWidth);
    ACanvas.Polygon(P);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TdxFlowChartPainter.DrawPolyline(ACanvas: TcxCanvas;
  const P: array of TPoint; AColor: TColor; AStyle: TPenStyle; AWidth: Integer);
begin
  ACanvas.SaveState;
  try
    PreparePen(ACanvas, AColor, AStyle, AWidth);
    ACanvas.Polyline(P);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TdxFlowChartPainter.DrawRectangle(ACanvas: TcxCanvas;
  const R: TRect; ABackgroundColor: TColor; AFrameColor: TColor;
  AFrameStyle: TPenStyle; AFrameWidth: Integer);
begin
  ACanvas.SaveState;
  try
    PrepareBrush(ACanvas, ABackgroundColor);
    PreparePen(ACanvas, AFrameColor, AFrameStyle, AFrameWidth);
    ACanvas.Canvas.Rectangle(R);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TdxFlowChartPainter.DrawRegion(ACanvas: TcxCanvas;
  ARegionHandle: TcxRegionHandle; ABackgroundColor: TColor;
  AFrameColor: TColor; AFrameWidth: Integer);
begin
  if ARegionHandle <> 0 then
  begin
    ACanvas.SaveState;
    try
      ACanvas.DrawRegion(ARegionHandle, ABackgroundColor, AFrameColor, AFrameWidth, AFrameWidth);
    finally
      ACanvas.RestoreState;
    end;
  end;
end;

procedure TdxFlowChartPainter.DrawRoundRect(ACanvas: TcxCanvas;
  const R: TRect; ABackgroundColor: TColor; AFrameColor: TColor;
  AFrameStyle: TPenStyle; AFrameWidth, ARadiusX, ARadiusY: Integer);
begin
  ACanvas.SaveState;
  try
    PrepareBrush(ACanvas, ABackgroundColor);
    PreparePen(ACanvas, AFrameColor, AFrameStyle, AFrameWidth);
    ACanvas.Canvas.RoundRect(R.Left, R.Top, R.Right, R.Bottom, ARadiusX, ARadiusY);
  finally
    ACanvas.RestoreState;
  end;
end;

procedure TdxFlowChartPainter.PrepareBrush(ACanvas: TcxCanvas; AColor: TColor);
begin
  if AColor <> clNone then
    ACanvas.Brush.Color := AColor
  else
    ACanvas.Brush.Style := bsClear;
end;

procedure TdxFlowChartPainter.PreparePen(
  ACanvas: TcxCanvas; AColor: TColor; AStyle: TPenStyle; AWidth: Integer);
begin
  if AColor = clNone then
    ACanvas.Pen.Style := psClear
  else
  begin
    ACanvas.Pen.Style := AStyle;
    ACanvas.Pen.Width := AWidth;
    ACanvas.Pen.Color := AColor;
  end;
end;

{ TdxFlowChartGDIPlusPainter }

procedure TdxFlowChartGDIPlusPainter.DrawEllipse(ACanvas: TcxCanvas;
  const R: TRect; ABackgroundColor, AFrameColor: TColor; AFrameStyle: TPenStyle;
  AFrameWidth: Integer);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(ACanvas.Handle, R);
  try
    AGraphics.SmoothingMode := SmoothingModeAntiAlias;
    AGraphics.Ellipse(R, AFrameColor, ABackgroundColor, AFrameWidth, AFrameStyle);
  finally
    dxGpEndPaint(AGraphics);
  end;
end;

procedure TdxFlowChartGDIPlusPainter.DrawPolygon(ACanvas: TcxCanvas;
  const P: array of TPoint; ABackgroundColor, AFrameColor: TColor;
  AFrameStyle: TPenStyle; AFrameWidth: Integer);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(ACanvas.Handle, cxPointsBox(P));
  try
    AGraphics.SmoothingMode := SmoothingModeAntiAlias;
    AGraphics.Polygon(P, AFrameColor, ABackgroundColor, AFrameWidth, AFrameStyle);
  finally
    dxGpEndPaint(AGraphics);
  end;
end;

procedure TdxFlowChartGDIPlusPainter.DrawPolyline(ACanvas: TcxCanvas;
  const P: array of TPoint; AColor: TColor; AStyle: TPenStyle; AWidth: Integer);
var
  AGraphics: TdxGPGraphics;
begin
  if Length(P) > 1 then
  begin
    AGraphics := dxGpBeginPaint(ACanvas.Handle, cxPointsBox(P));
    try
      AGraphics.SmoothingMode := SmoothingModeAntiAlias;
      AGraphics.Polyline(P, AColor, AWidth, AStyle);
    finally
      dxGpEndPaint(AGraphics);
    end;
  end;
end;

procedure TdxFlowChartGDIPlusPainter.DrawRectangle(ACanvas: TcxCanvas;
  const R: TRect; ABackgroundColor, AFrameColor: TColor; AFrameStyle: TPenStyle;
  AFrameWidth: Integer);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(ACanvas.Handle, R);
  try
    AGraphics.SmoothingMode := SmoothingModeAntiAlias;
    AGraphics.Rectangle(R, AFrameColor, ABackgroundColor, AFrameWidth, AFrameStyle);
  finally
    dxGpEndPaint(AGraphics);
  end;
end;

procedure TdxFlowChartGDIPlusPainter.DrawRoundRect(ACanvas: TcxCanvas;
  const R: TRect; ABackgroundColor: TColor; AFrameColor: TColor;
  AFrameStyle: TPenStyle; AFrameWidth: Integer; ARadiusX, ARadiusY: Integer);
var
  AGraphics: TdxGPGraphics;
begin
  AGraphics := dxGpBeginPaint(ACanvas.Handle, R);
  try
    AGraphics.SmoothingMode := SmoothingModeAntiAlias;
    AGraphics.RoundRect(R, AFrameColor, ABackgroundColor,
      ARadiusX div 2, ARadiusY div 2, AFrameWidth);
  finally
    dxGpEndPaint(AGraphics);
  end;
end;

{ TdxFcItem }

constructor TdxFcItem.Create(AOwner: TdxCustomFlowChart);
begin
  inherited Create;
  FOwner := AOwner;
  FFont := TFont.Create;
  FRealFont := TFont.Create;
  FFont.Assign(AOwner.Font);
  CalculateRealFont;
  FFont.OnChange := OnFontChange;
  FParentFont := True;
end;

destructor TdxFcItem.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FRealFont);
  inherited Destroy;
end;

procedure TdxFcItem.Changed;
begin
  if not Owner.FLoading then Owner.Changed(Self);
end;

procedure TdxFcItem.OnFontChange(Sender: TObject);
begin
  FParentFont := False;
  CalculateRealFont;
  if Text <> '' then
    FontChanged;
  Changed;
end;

procedure TdxFcItem.ScaleFont;
begin
  RealFont.Size := MulDiv(Font.Size, Owner.RealZoom, 100);
end;

procedure TdxFcItem.CalculateRealFont;
begin
  RealFont.Assign(Font);
  ScaleFont;
end;

procedure TdxFcItem.SetFont(Value: TFont);
begin
  Font.Assign(Value);
end;

procedure TdxFcItem.FontChanged;
begin
  Invalidate;
end;

function TdxFcItem.GetSelectionRect: TRect;
begin
  Result := DisplayRect;
  ExtSelRect(Result, True);
end;

procedure TdxFcItem.SetParentFont(Value: Boolean);
begin
  if Value <> ParentFont then
  begin
    if Value then
      Font.Assign(Owner.Font);
    FParentFont := Value;
    Changed;
  end;
end;

procedure TdxFcItem.SetSelected(Value: Boolean);
begin
  if Selected <> Value then
  begin
    if Value and not Owner.CanSelect(Self) then Exit;
    if Selected then
    begin
      Invalidate;
      SelList.Remove(Self);
    end;
    FSelected := Value;
    if Selected then
    begin
      if not (fcoMultiSelect in Owner.Options) then
        Owner.ClearSelection;
      SelList.Add(Self);
      Invalidate;
    end;
    Owner.Select(Self);
  end;
end;

procedure TdxFcItem.Assign(Source: TPersistent);
begin
  if Source is TdxFcItem then
  begin
    Text := TdxFcItem(Source).Text;
    ParentFont := TdxFcItem(Source).ParentFont;
    if not ParentFont then Font := TdxFcItem(Source).Font;
  end
  else
    inherited Assign(Source);
end;

procedure TdxFcItem.LoadFont(Stream: TStream; AIsUnicode: Boolean);
var
  Data: TdxFcFntData;
  FtName: string;
begin
  if ParentFont then Exit;
  Stream.ReadBuffer(Data, SizeOf(Data));
  FtName := ReadStr(Stream, AIsUnicode);
  with Font do
  begin
    OnChange := nil;
    Height := Data.Height;
    Color := Data.Color;
    Pitch := Data.Pitch;
    Style := Data.Style;
    Charset := Data.Charset;
    if FtName <> '' then
      Name := FtName;
    OnChange := OnFontChange;
  end;
  CalculateRealFont;
end;

procedure TdxFcItem.SaveFont(Stream: TStream);
var
  Data: TdxFcFntData;
  FtName: string;
begin
  if ParentFont then Exit;
  if Font.Name = Owner.Font.Name then
    FtName := ''
  else
    FtName := Font.Name;
  with Data do
  begin
    Height := Font.Height;
    Color := Font.Color;
    Pitch := Font.Pitch;
    Style := Font.Style;
    Charset := Font.Charset;
  end;
  Stream.WriteBuffer(Data, SizeOf(Data));
  WriteStr(Stream, FtName);
end;

{TdxFcObject}

constructor TdxFcObject.Create(AOwner: TdxCustomFlowChart);
begin
  inherited Create(AOwner);
  FConnections := TList.Create;
  FLinkedObjects := TList.Create;
  FObjects := TList.Create;
  FBkColor := AOwner.Color;
  FVisible := True;
  FImageIndex := -1;
  FShapeWidth := 1;
  FBorder := BF_RECT;
  CalculateRealShapeWidth;
  AOwner.FObjects.Add(Self);
end;

destructor TdxFcObject.Destroy;
var
  I: Integer;
begin
  Owner.Delete(Self);
  while ConnectionCount > 0 do
    Connections[0].Free;
  FreeAndNil(FConnections);
  FreeAndNil(FLinkedObjects);
  FreeAndNil(FObjects);

  Owner.FObjects.Remove(Self);
  
  with Owner do
    for I := 0 to ObjectCount - 1 do
      Objects[I].FObjects.Remove(Self);

  Owner.SetChartSizes;
  inherited Destroy;
end;

procedure TdxFcObject.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (ALeft = Left) and (ATop = Top) and (AWidth = Width) and (AHeight = Height) then Exit;

  FTop := ATop;
  FLeft := ALeft;
  FWidth := Word(AWidth);
  FHeight := Word(AHeight);

  Owner.NeedRepaintObject(Self);
  CalculateRealBounds;
  UpdateConnections;
  Owner.NeedRepaintObject(Self);
  Owner.SetChartSizes;
end;

procedure TdxFcObject.SetBounds(const R: TRect);
begin
  SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
end;

function TdxFcObject.GetLinkedObject(Index: Integer): TdxFcObject;
begin
  Result := TdxFcObject(GetListItem(FLinkedObjects, Index));
end;

function TdxFcObject.GetConnection(Index: Integer): TdxFcConnection;
begin
  Result := TdxFcConnection(GetListItem(FConnections, Index));
end;

function TdxFcObject.GetObjectValue(Index: Integer): TdxFcObject;
begin
  Result := TdxFcObject(GetListItem(FObjects, Index));
end;

function TdxFcObject.GetPainter: TdxFlowChartPainter;
begin
  Result := Owner.Painter;
end;

function TdxFcObject.GetIsUnion: Boolean;
begin
  Result := FObjects.Count > 0;
end;

function TdxFcObject.GetConnectionCount: Integer;
begin
  Result := FConnections.Count;
end;

function TdxFcObject.GetLinkedObjectCount: Integer;
begin
  Result := FLinkedObjects.Count;
end;

function TdxFcObject.GetObjectCount: Integer;
begin
  Result := FObjects.Count;
end;

function TdxFcObject.SelList: TList;
begin
  Result := Owner.FSelObjects;
end;

function TdxFcObject.HasEdge: Boolean;
begin
  Result := (ShapeType = fcsRectangle) and (EdgeStyle <> 0);
end;

function TdxFcObject.HasImage: Boolean;
begin
  Result := (Owner.Images <> nil) and (ImageIndex >= 0) and (ImageIndex < Owner.Images.Count);
end;

procedure TdxFcObject.SetBkColor(Value: TColor);
begin
  if FBkColor <> Value then
  begin
    FBkColor := Value;
    if not Transparent and (ShapeType <> fcsNone) then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetHeight(Value: Word);
begin
  SetBounds(Left, Top, Width, Value);
end;

procedure TdxFcObject.SetHorzImagePos(Value: TdxFcHorzPos);
begin
  if (FHorzImagePos <> Value) then
  begin
    FHorzImagePos := Value;
    if HasImage then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetHorzTextPos(Value: TdxFcHorzPos);
begin
  if (FHorzTextPos <> Value) then
  begin
    FHorzTextPos := Value;
    if Text <> '' then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetImageIndex(Value: Smallint);
begin
  if (FImageIndex <> Value) then
  begin
    FImageIndex := Value;
    if Owner.Images <> nil then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetLeft(Value: Integer);
begin
  SetBounds(Value, Top, Width, Height);
end;

procedure TdxFcObject.SetShapeColor(Value: TColor);
begin
  if FShapeColor <> Value then
  begin
    FShapeColor := Value;
    if ShapeType <> fcsNone then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetShapeType(Value: TdxFcShapeType);
begin
  if FShapeType <> Value then
  begin
    FShapeType := Value;
    CalculateLinkedPoints;
    UpdateConnections;
    Owner.NeedRepaintObject(Self);
  end;
end;

procedure TdxFcObject.SetShapeStyle(Value: TPenStyle);
begin
  if FShapeStyle <> Value then
  begin
    FShapeStyle := Value;
    Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetShapeWidth(Value: Byte);
begin
  if FShapeWidth <> Value then
  begin
    FShapeWidth := Value;
    CalculateRealShapeWidth;
    if ShapeType <> fcsNone then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetText(Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if ShapeType <> fcsNone then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetTop(Value: Integer);
begin
  SetBounds(Left, Value, Width, Height);
end;

procedure TdxFcObject.SetVertImagePos(Value: TdxFcVertPos);
begin
  if FVertImagePos <> Value then
  begin
    FVertImagePos := Value;
    if HasImage then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetVertTextPos(Value: TdxFcVertPos);
begin
  if FVertTextPos <> Value then
  begin
    FVertTextPos := Value;
    if Text <> '' then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Owner.FHitTest := [];
    Owner.NeedRepaintObject(Self);
  end;
end;

procedure TdxFcObject.SetWidth(Value: Word);
begin
  SetBounds(Left, Top, Value, Height);
end;

procedure TdxFcObject.SetBorder(Value: Word);
begin
  if Value <> FBorder then
  begin
    FBorder := Value;
    if (ShapeType = fcsRectangle) and (FEdge <> 0) then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetEdge(Value: Word);
begin
  if Value <> FEdge then
  begin
    FEdge := Value;
    if ShapeType = fcsRectangle then
      Owner.NeedRepaintObject(Self);
    Changed;
  end;
end;

procedure TdxFcObject.SetZOrder(Value: Word);
begin
  if Value >= Owner.ObjectCount then
    Value := Owner.ObjectCount - 1;
  if Value <> ZOrder then
    with Owner do
    begin
      FHitTest := [];
      FObjects.Remove(Self);
      FObjects.Insert(Value, Self);
      NeedRepaintObject(Self);
      Changed(Self);
    end;
end;

procedure TdxFcObject.BringToFront;
begin
  SetZOrder(Owner.ObjectCount - 1);
end;

procedure TdxFcObject.SendToBack;
begin
  SetZOrder(0);
end;

procedure TdxFcObject.PutInFrontOf(Value: TdxFcObject);
var
  Z: Integer;
begin
  Z := Value.ZOrder;
  if Z < ZOrder then Inc(Z);
  SetZOrder(Z);
end;

procedure TdxFcObject.CalculateRealBounds;
begin
  FRealLeft := MulDiv(Left, Owner.RealZoom, 100);
  FRealTop := MulDiv(Top, Owner.RealZoom, 100);
  FRealWidth := MulDiv(Width, Owner.RealZoom, 100);
  FRealHeight := MulDiv(Height, Owner.RealZoom, 100);
  CalculateLinkedPoints;
end;

procedure TdxFcObject.ZoomChanged;
begin
  CalculateRealBounds;
  CalculateRealShapeWidth;
  ScaleFont;
end;

procedure TdxFcObject.CalculateLinkedPoints;
var
  qWidth, qHeight, ARight, ABottom: Integer;
  DX, DY: Integer;

  procedure IncP(Index, IX, IY: Integer);
  begin
    Inc(LinkedPoints[Index].X, IX);
    Inc(LinkedPoints[Index].Y, IY);
  end;

  procedure Trio(I1, I2, I3: Integer);
  begin
    LinkedPoints[I1].X := LinkedPoints[I2].X;
    LinkedPoints[I1].Y := LinkedPoints[I3].Y;
    LinkedPoints[I2].Y := LinkedPoints[I1].Y;
    LinkedPoints[I3].X := LinkedPoints[I1].X;
  end;

  procedure TrioX(I1, I2, I3, I4: Integer);
  begin
    LinkedPoints[I1].X := LinkedPoints[I2].X + DX;
    LinkedPoints[I3].X := LinkedPoints[I4].X - DX;
  end;

  procedure TrioY(I1, I2, I3, I4: Integer);
  begin
    LinkedPoints[I1].Y := LinkedPoints[I2].Y + DY;
    LinkedPoints[I3].Y := LinkedPoints[I4].Y - DY;
  end;

  function Scale(Value, Coef: Integer): Integer;
  begin
    Result := (Value * Coef + 512) shr 10;
  end;

begin
  Owner.FHitTest := [];
  qWidth := RealWidth div 4;
  qHeight := RealHeight div 4;
  ARight := RealLeft + RealWidth;
  ABottom := RealTop + RealHeight;
  for DX := 4 to 8 do
    LinkedPoints[DX].X := ARight;
  for DX := 12 to 16 do
    LinkedPoints[DX and 15].X := RealLeft;
  for DX := 0 to 4 do
    LinkedPoints[DX].Y := RealTop;
  for DX := 8 to 12 do
    LinkedPoints[DX].Y := ABottom;
  LinkedPoints[1].X := RealLeft + qWidth;
  LinkedPoints[2].X := RealLeft + RealWidth shr 1;
  LinkedPoints[3].X := ARight - qWidth;
  LinkedPoints[5].Y := RealTop + qHeight;
  LinkedPoints[6].Y := RealTop + RealHeight shr 1;
  LinkedPoints[7].Y := ABottom - qHeight;
  LinkedPoints[9].X := LinkedPoints[3].X;
  LinkedPoints[10].X := LinkedPoints[2].X;
  LinkedPoints[11].X := LinkedPoints[1].X;
  LinkedPoints[13].Y := LinkedPoints[7].Y;
  LinkedPoints[14].Y := LinkedPoints[6].Y;
  LinkedPoints[15].Y := LinkedPoints[5].Y;
  for DX := 4 to 8 do
    Dec(LinkedPoints[DX].X);
  for DX := 8 to 12 do
    Dec(LinkedPoints[DX].Y);
  DX := qWidth shr 1; DY := qHeight shr 1;
  case ShapeType of
    fcsUser: UserLinkedPoints;
    fcsNorthTriangle:
      begin
        Trio(0, 1, 14);
        TrioX(13, 13, 15, 2);
        Trio(4, 3, 6);
        TrioX(5, 2, 7, 7);
      end;
    fcsSouthTriangle:
      begin
        Trio(12, 11, 14);
        TrioX(15, 15, 13, 10);
        Trio(8, 9, 6);
        TrioX(7, 10, 5, 5);
      end;
    fcsEastTriangle:
      begin
        Trio(4, 2, 5);
        TrioY(1, 1, 3, 6);
        Trio(8, 10, 7);
        TrioY(9, 6, 11, 11);
      end;
    fcsWestTriangle:
      begin
        Trio(0, 2, 15);
        TrioY(3, 3, 1, 14);
        Trio(12, 10, 13);
        TrioY(11, 14, 9, 9);
      end;
    fcsHexagon:
      begin
        IncP(0, DX, qHeight);
        IncP(4, -DX, qHeight);
        IncP(8, -DX, -qHeight);
        IncP(12, DX, -qHeight);
        IncP(13, DX, 0);
        IncP(15, DX, 0);
        IncP(5, -DX, 0);
        IncP(7, -DX, 0);
      end;
    fcsDiamond:
      begin
        IncP(0, qWidth, qHeight);
        IncP(4, -qWidth, qHeight);
        IncP(8, -qWidth, -qHeight);
        IncP(12, qWidth, -qHeight);
        IncP(1, DX, DY);
        IncP(3, -DX, DY);
        IncP(5, -DX, DY);
        IncP(7, -DX, -DY);
        IncP(9, -DX, -DY);
        IncP(11, DX, -DY);
        IncP(13, DX, -DY);
        IncP(15, DX, DY);
      end;
    fcsRoundRect:
      begin
        DX := Scale(RealWidth, 75);
        DY := Scale(RealHeight, 75);
        IncP(0, DX, DY);
        IncP(4, -DX, DY);
        IncP(8, -DX, -DY);
        IncP(12, DX, -DY);
      end;
    fcsEllipse:
      begin
        DX := Scale(RealWidth, 150);
        DY := Scale(RealHeight, 150);
        IncP(0, DX, DY);
        IncP(4, -DX, DY);
        IncP(8, -DX, -DY);
        IncP(12, DX, -DY);
        DX := Scale(RealWidth, 68);
        DY := Scale(RealHeight, 68);
        IncP(13, DX, 0);
        IncP(15, DX, 0);
        IncP(5, -DX, 0);
        IncP(7, -DX, 0);
        IncP(1, 0, DY);
        IncP(3, 0, DY);
        IncP(9, 0, -DY);
        IncP(11, 0, -DY);
      end;
  end;
end;

procedure TdxFcObject.CalculateRealShapeWidth;
begin
  FRealSW := (ShapeWidth * Owner.RealZoom + 50) div 100;
  if (RealSW = 0) and (ShapeWidth <> 0) then
    FRealSW := 1;
  FRealContentIndent := FRealSW div 2 + 1;
end;

procedure TdxFcObject.UpdateConnections;
var
  I: Integer;
begin
  Changed;
  for I := 0 to ConnectionCount - 1 do
    with Connections[I] do
    begin
      ConnectionChanged;
      SetObjectPoints;
      CalculateDisplayRect;
      Changed;
    end;
end;

procedure TdxFcObject.Invalidate;
begin
  Owner.NeedRepaintObject(Self);
end;

function TdxFcObject.GetClientRect: TRect;
begin
  Result.TopLeft := LinkedPoints[0];
  Result.BottomRight := LinkedPoints[8];
  case ShapeType of
    fcsNorthTriangle:
      Result.Right := LinkedPoints[4].X;
    fcsSouthTriangle:
      Result.Left := LinkedPoints[1].X;
    fcsEastTriangle:
      Result.Top := LinkedPoints[15].Y;
    fcsWestTriangle:
      Result.Bottom := LinkedPoints[7].Y;
  end;
  InflateRect(Result, -RealSW, -RealSW);
  Result := Owner.ScrollRect(Result, False);
end;

function TdxFcObject.GetDisplayRect: TRect;
begin
  Result := cxRectBounds(RealLeft, RealTop, RealWidth, RealHeight);
  Result := Owner.ScrollRect(Result, False);
end;

function TdxFcObject.GetZOrder: Word;
begin
  Result := Word(Owner.FObjects.IndexOf(Self));
end;

function TdxFcObject.CalculatePolygon(out APolygon: TPointArray; AIndent: Integer): Boolean;

  function AdjustPoint(APointPosition: Integer): TPoint;
  begin
    Result := LinkedPoints[APointPosition];
    if (APointPosition >= 0) and (APointPosition <= 4) then
      Inc(Result.Y, AIndent);
    if (APointPosition >= 4) and (APointPosition <= 8) then
      Dec(Result.X, AIndent);
    if (APointPosition >= 8) and (APointPosition <= 12) then
      Dec(Result.Y, AIndent);
    if (APointPosition >= 12) and (APointPosition <= 15) or (APointPosition = 0) then
      Inc(Result.X, AIndent);
  end;

  procedure SetPolygon(const AIndexes: array of Integer);
  var
    ALength: Integer;
    I: Integer;
  begin
    ALength := Length(AIndexes);
    SetLength(APolygon, ALength);
    for I := 0 to ALength - 1 do
      APolygon[I] := Owner.ScrollPoint(AdjustPoint(AIndexes[I]), False);
  end;

begin
  case ShapeType of
    fcsDiamond: 
      SetPolygon([2, 6, 10, 14]);
    fcsHexagon: 
      SetPolygon([1, 3, 6, 9, 11, 14]);
    fcsNorthTriangle: 
      SetPolygon([2, 8, 12]);
    fcsSouthTriangle: 
      SetPolygon([0, 4, 10]);
    fcsEastTriangle: 
      SetPolygon([0, 6, 12]);
    fcsWestTriangle: 
      SetPolygon([4, 8, 14]);
    else
      SetLength(APolygon, 0);
  end;
  Result := Length(APolygon) > 0;
end;

function TdxFcObject.CalculateRegion(const ARect: TRect; AShapeWidth: Integer): TcxRegionHandle;
var
  P: TPointArray;
  R: TRect;
begin
  Result := 0;
  InflateRect(R, -AShapeWidth, -AShapeWidth);
  case ShapeType of
    fcsUser:
      Result := UserRegion(R);
    fcsRectangle, fcsNone:
      Result := CreateRectRgnIndirect(R);
    fcsEllipse:
      Result := CreateEllipticRgnIndirect(R);
    fcsRoundRect:
      Result := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom,
        cxRectWidth(R) div 2, cxRectHeight(R) div 2);
    else
      if CalculatePolygon(P, AShapeWidth) then
      begin
        Result := CreatePolygonRgn(P[0], Length(P), ALTERNATE);
        P := nil;
      end;
  end;
end;

function TdxFcObject.CreateClientRegion: TcxRegionHandle;
begin
  Result := CalculateRegion(DisplayRect, RealSW);
end;

function TdxFcObject.CreateShapeRegion: TcxRegionHandle;
var
  ARgn: TcxRegionHandle;
begin
  Result := CalculateRegion(DisplayRect, 0);
  ARgn := CalculateRegion(DisplayRect, RealSW);
  CombineRgn(Result, Result, ARgn, RGN_DIFF);
  DeleteObject(ARgn);
end;

procedure TdxFcObject.SelPoints(var Pts: TdxFcSelectionPoints);
var
  I: Integer;
begin
  for I := 2 to 4 do
    Pts[I].X := RealLeft + RealWidth - 1;
  for I := 6 to 8 do
    Pts[I and 7].X := RealLeft;
  for I := 0 to 2 do
    Pts[I].Y := RealTop;
  for I := 4 to 6 do
    Pts[I].Y := RealTop + RealHeight - 1;
  Pts[1].X := RealLeft + RealWidth shr 1; 
  Pts[5].X := Pts[1].X;
  Pts[3].Y := RealTop + RealHeight shr 1; 
  Pts[7].Y := Pts[3].Y;
end;

function TdxFcObject.Quadrant(X, Y: Integer): Integer;
begin
  Result := Ord(X < RealLeft + RealWidth shr 1) shl 1 + Ord(Y >= RealTop + RealHeight shr 1);
  if Result > 1 then 
    Result := Result xor 1;
end;

function TdxFcObject.GetPoint(const P: array of TPoint; X, Y, Cnt: Integer): Integer;
var
  I, Cur, Min, Mask, Start: Integer;
begin
  Result := 0;
  Min := $7FFFFFFF; I := Cnt shr 1;
  if Cnt = 2 then
    Mask := 7
  else
    Mask := 15;

  Inc(X, Owner.LeftEdge);
  Inc(Y, Owner.TopEdge);
  Start := Quadrant(X, Y) shl I + I;
  for I := Start to Start + Cnt do
  begin
    Cur := QDistance(X, Y, P[I and Mask]);
    if Cur < Min then
    begin
      Min := Cur;
      Result := I and Mask;
    end;
  end;
end;

function TdxFcObject.GetSelPoint(X, Y: Integer): Integer;
var
  P: TdxFcSelectionPoints;
begin
  SelPoints(P);
  Result := GetPoint(P, X, Y, 2);
end;

function TdxFcObject.HitTest(const P: TPoint): TdxFcHitTest;
var
  ARegion: TcxRegionHandle;
begin
  if Visible and PtInRect(DisplayRect, P) then
  begin
    Result := [htByObject];
    ARegion := CreateClientRegion;
    if PtInRegion(ARegion, P.X, P.Y) then
      Include(Result, htOnObject);
    DeleteObject(ARegion);
  end
  else
    Result := [];
end;

function TdxFcObject.InRect(const R: TRect): Boolean;
var
  ARegion: TcxRegionHandle;
begin
  Result := Visible;
  if Result then
  begin
    ARegion := CreateClientRegion;
    Result := RectInRegion(ARegion, R);
    DeleteObject(ARegion);
  end;
end;

function TdxFcObject.GetLinkedPoint(X, Y: Integer): Integer;
begin
  Result := GetPoint(LinkedPoints, X, Y, 4);
end;

function TdxFcObject.HasInUnion(AObject: TdxFcObject): Boolean;
var
  I: Integer;
begin
  Result := (AObject = nil) or (AObject = Self);
  if Result then Exit;
  for I := 0 to ObjectCount - 1 do
  begin
    Result := Objects[I].HasInUnion(AObject);
    if Result then Exit;
  end;
end;

procedure TdxFcObject.AddToUnion(AObject: TdxFcObject);
begin
  if not HasInUnion(AObject) then FObjects.Add(AObject);
end;

procedure TdxFcObject.RemoveFromUnion(AObject: TdxFcObject);
begin
  FObjects.Remove(AObject);
end;

procedure TdxFcObject.ClearUnion;
begin
  FObjects.Clear;
end;

procedure TdxFcObject.SelectUnion;
var
  I: Integer;
begin
  Selected := True;
  if fcoMultiSelect in Owner.Options then
  begin
    for I := 0 to ObjectCount - 1 do
      Objects[I].SelectUnion;
  end;
end;

procedure TdxFcObject.MakeVisible;
var
  R: TRect;
  X, Y: Integer;
begin
  Visible := True;
  if (RealWidth > Owner.ClientWidth) or (RealHeight > Owner.ClientHeight) then
    R := ClientRect
  else
    R := DisplayRect;

  X := R.Left;
  Y := R.Top;
  if R.Right > Owner.ClientWidth then
    Inc(X, Owner.ClientWidth - R.Right);
  if R.Bottom > Owner.ClientHeight then
    Inc(Y, Owner.ClientHeight - R.Bottom);

  X := Max(X, 0);
  Y := Max(Y, 0);
  if (X <> R.Left) or (Y <> R.Top) then
    Owner.SetLeftTop(Owner.LeftEdge + R.Left - X, Owner.TopEdge + R.Top - Y);
end;

procedure TdxFcObject.Paint(ACanvas: TcxCanvas);
begin
  PaintBackground(ACanvas);
  Owner.DoDrawObject(Self, ClientRect);
end;

procedure TdxFcObject.PaintBackground(ACanvas: TcxCanvas);

  function GetBackgroundColor: TColor;
  begin
    if Transparent then
      Result := clNone
    else
      Result := BkColor;
  end;

  function GetFrameColor: TColor;
  begin
    if HasEdge then
      Result := clNone
    else
      Result := ShapeColor;
  end;

var
  P: TPointArray;
  R: TRect;
begin
  if ShapeType = fcsNone then Exit;

  R := cxRectInflate(DisplayRect, -RealContentIndent, -RealContentIndent);
  case ShapeType of
    fcsUser:
      Painter.DrawRegion(ACanvas, UserRegion(R), GetBackgroundColor, GetFrameColor, RealSW);
    fcsEllipse:
      Painter.DrawEllipse(ACanvas, R, GetBackgroundColor, GetFrameColor, ShapeStyle, RealSW);
    fcsRectangle:
      Painter.DrawRectangle(ACanvas, R, GetBackgroundColor, GetFrameColor, ShapeStyle, RealSW);
    fcsRoundRect:
      Painter.DrawRoundRect(ACanvas, R, GetBackgroundColor,
        GetFrameColor, ShapeStyle, RealSW, RealWidth shr 1, RealHeight shr 1);
    fcsDiamond, fcsNorthTriangle, fcsSouthTriangle, fcsEastTriangle, fcsWestTriangle, fcsHexagon:
      if CalculatePolygon(P, RealContentIndent) then
      try
        Painter.DrawPolygon(ACanvas, P, GetBackgroundColor, GetFrameColor, ShapeStyle, RealSW);
      finally
        P := nil;
      end;
  end;

  if HasEdge then
    Painter.DrawEdge(ACanvas, DisplayRect, EdgeStyle, BorderStyle);
end;

procedure TdxFcObject.PaintImage(const R: TRect);
var
  AImageRect: TRect;
begin
  if Owner.Images <> nil then
  begin
    AImageRect := Rect(0, 0, Owner.Images.Width, Owner.Images.Height);
    if AdjustRect(AImageRect, R, HorzImagePos, VertImagePos) then
      Owner.Images.Draw(Owner.Canvas.Canvas, AImageRect.Left, AImageRect.Top, ImageIndex);
  end;
end;

procedure TdxFcObject.PaintText(const R: TRect);
const
  Aligns: array[TdxFcHorzPos] of Word = (CXTO_LEFT, CXTO_CENTER_HORIZONTALLY, CXTO_RIGHT);
var
  AFlags: Cardinal;
  ATextRect: TRect;
begin
  ATextRect := R;
  AFlags := CXTO_EXPANDTABS or CXTO_WORDBREAK or Aligns[HorzTextPos];
  if VertTextPos <> fcvpUp then
  begin
    cxTextOut(Owner.Canvas.Handle, Text, ATextRect, AFlags or CXTO_CALCRECT, RealFont);
    AdjustRect(ATextRect, R, HorzTextPos, VertTextPos);
  end;
  cxTextOut(Owner.Canvas.Handle, Text, ATextRect, AFlags, RealFont);
end;

procedure TdxFcObject.ResolveObjRefs;
var
  I: Integer;
begin
  for I := 0 to ObjectCount - 1 do
    FObjects[I] := Owner.Objects[Integer(FObjects[I])];
end;

procedure TdxFcObject.Assign(Source: TPersistent);
begin
  if Source is TdxFcObject then
    with TdxFcObject(Source) do
    begin
      Self.Data := Data;
      Self.Tag := Tag;
      Self.CustomData := CustomData;
      Self.SetBounds(Left, Top, Width, Height);
      Self.EdgeStyle := EdgeStyle;
      Self.BorderStyle := BorderStyle;
      Self.HorzTextPos := HorzTextPos;
      Self.VertTextPos := VertTextPos;
      Self.HorzImagePos := HorzImagePos;
      Self.VertImagePos := VertImagePos;
      Self.BkColor := BkColor;
      Self.ShapeColor := ShapeColor;
      Self.ImageIndex := ImageIndex;
      Self.Transparent := Transparent;
      Self.ShapeType := ShapeType;
      Self.ShapeWidth := ShapeWidth;
    end;
  inherited Assign(Source);
end;

procedure TdxFcObject.Load(Stream: TStream; AIsUnicode: Boolean);
var
  I: Integer;
  ObjData: TdxFcObjData;
begin
  Stream.ReadBuffer(ObjData, SizeOf(ObjData));
  with ObjData do
  begin
    SetBounds(Left, Top, Width, Height);
    EdgeStyle := Edge;
    BorderStyle := Border;
    HorzTextPos := HTPos;
    VertTextPos := VTPos;
    HorzImagePos := HIPos;
    VertImagePos := VIPos;
    Self.BkColor :=
    BkColor; ShapeColor := ShColor;
    Self.Tag := Tag;
    ImageIndex := Image;
    ShapeType := Shape;
    ShapeWidth := ShWidth;
    ParentFont := ParFont;
    Self.Transparent := Transparent;
    while ObjCnt > 0 do
    begin
      I := 0; Dec(ObjCnt);
      Stream.ReadBuffer(I, SizeOf(Word));
      FObjects.Add(Pointer(I));
    end;
  end;
  LoadFont(Stream, AIsUnicode);
  Text := ReadStr(Stream, AIsUnicode);
  CustomData := ReadStr(Stream, AIsUnicode);
end;

procedure TdxFcObject.Save(Stream: TStream);
var
  I: Integer;
  W: Word;
  ObjData: TdxFcObjData;
begin
  with ObjData do
  begin
    Left := Self.Left;
    Top := Self.Top;
    Width := Self.Width;
    Height := Self.Height;
    Edge := EdgeStyle;
    Border := BorderStyle;
    HTPos := HorzTextPos;
    VTPos := VertTextPos;
    HIPos := HorzImagePos;
    VIPos := VertImagePos;
    BkColor := Self.BkColor;
    ShColor := ShapeColor;
    Tag := Self.Tag;
    Image := ImageIndex;
    Shape := ShapeType;
    ShWidth := ShapeWidth;
    ParFont := ParentFont;
    Transparent := Self.Transparent;
    ObjCnt := Word(ObjectCount);
  end;
  Stream.WriteBuffer(ObjData, SizeOf(ObjData));
  for I := 0 to ObjectCount - 1 do
  begin
    W := Objects[I].ZOrder;
    Stream.WriteBuffer(W, SizeOf(W));
  end;
  SaveFont(Stream);
  WriteStr(Stream, Text);
  WriteStr(Stream, CustomData);
end;

function TdxFcObject.UserRegion(R: TRect): HRgn;
begin
  Result := 0;
end;

procedure TdxFcObject.UserLinkedPoints;
begin
end;

{TdxFcConnectionArrow}

constructor TdxFcConnectionArrow.Create(AOwner: TdxFcConnection);
begin
  inherited Create;
  FOwner := AOwner;
  FColor := AOwner.Owner.Color;
end;

procedure TdxFcConnectionArrow.ClearPoints;
begin
  if ArrowType = fcaArrow then
  begin
    FPoints[1] := Point(0, 0);
    FPoints[3] := Point(0, 0);
  end;
end;

procedure TdxFcConnectionArrow.Reset;
begin
  ClearPoints;
  Owner.ArrowChanged(Self);
  Owner.Changed;
end;

procedure TdxFcConnectionArrow.Load(const AData: TdxFcArwData);
begin
  ArrowType := AData.AType;
  Color := AData.Color;
  Height := AData.Height;
  Width := AData.Width;
end;

procedure TdxFcConnectionArrow.Save(out AData: TdxFcArwData);
begin
  AData.AType := ArrowType;
  AData.Width := Width;
  AData.Height := Height;
  AData.Color := Color;
end;

procedure TdxFcConnectionArrow.SetRealBounds;
begin
  FRealWidth := MulDiv(Width, Owner.Owner.RealZoom, 100);
  FRealHeight := MulDiv(Height, Owner.Owner.RealZoom, 100);
end;

procedure TdxFcConnectionArrow.SetArrowType(Value: TdxFcaType);
begin
  if (FArrowType <> Value) then
  begin
    Owner.ArrowChanged(Self);
    FArrowType := Value;
    Reset;
  end;
end;

procedure TdxFcConnectionArrow.SetHeight(Value: Byte);
begin
  if (FHeight <> Value) then
  begin
    Owner.ArrowChanged(Self);
    FHeight := Value;
    SetRealBounds;
    Reset;
  end;
end;

procedure TdxFcConnectionArrow.SetWidth(Value: Byte);
begin
  if (FWidth <> Value) then
  begin
    Owner.ArrowChanged(Self);
    FWidth := Value;
    SetRealBounds;
    Reset;
  end;
end;

procedure TdxFcConnectionArrow.SetColor(Value: TColor);
begin
  if (FColor <> Value) then
  begin
    FColor := Value;
    if ArrowType in [fcaRectangle, fcaEllipse] then
      Owner.ArrowChanged(Self);
    Owner.Changed;
  end;
end;

function TdxFcConnectionArrow.GetActive: Boolean;
begin
  Result := (ArrowType <> fcaNone) and (Owner.RealCount > 1);
end;

function TdxFcConnectionArrow.GetPainter: TdxFlowChartPainter;
begin
  Result := Owner.Owner.Painter;
end;

function TdxFcConnectionArrow.DisplayRect(Ext: Boolean): TRect;
begin
  if ArrowType = fcaArrow then
  begin
    Result.TopLeft := FPoints[1];
    Result.BottomRight := FPoints[1];
    dxLines.ExtendRect(Result, FPoints[0]);
    dxLines.ExtendRect(Result, FPoints[2]);
  end
  else
    with Result do
    begin
      Left := FPoints[1].X - FRealWidth shr 1;
      Top := FPoints[1].Y - FRealHeight shr 1;
      Right := Left + FRealWidth;
      Bottom := Top + FRealHeight;
    end;
  ExtSelRect(Result, Ext);
end;

procedure TdxFcConnectionArrow.SetPoints(Index: Integer);
var
  DX, DY, DXY, IsRect: Integer;
  P1, P3: TPoint;

  procedure Rotate(var P: TPoint);
  var
    X, Y: Integer;
  begin
    X := (P.X * DX - P.Y * DY) div DXY;
    Y := (P.X * DY + P.Y * DX) div DXY;
    P.X := X + FPoints[1].X;
    P.Y := Y + FPoints[1].Y;
  end;

begin
  if Active then
  begin
    IsRect := Ord(Owner.Style) xor Ord(Index <> 0);

    P1 := Owner.FRealPoints[Index];
    if Index = 0 then
      Inc(Index)
    else
      Dec(Index);

    P3 := Owner.FRealPoints.Points[Index];
    if (P1.X = FPoints[1].X) and (P1.Y = FPoints[1].Y) and
       (P3.X = FPoints[3].X) and (P3.Y = FPoints[3].Y)
    then
      Exit;

    FPoints[1] := P1;
    FPoints[3] := P3;

    if ArrowType = fcaArrow then
    begin
      DX := P3.X - P1.X;
      DY := P3.Y - P1.Y;
      if (IsRect = 2) and (DX <> 0) then DY := 0;
      if (IsRect = 3) and (DY <> 0) then DX := 0;

      if (DX = 0) or (DY = 0) then
        DXY := Abs(DX + DY)
      else
        DXY := Round(Sqrt(DX * DX + DY * DY));

      if DXY = 0 then
        DXY := 1;

      FPoints[0].X := FRealWidth;
      FPoints[0].Y := (FRealHeight + 1) shr 1;
      FPoints[2].X := FRealWidth;
      FPoints[2].Y := -FPoints[0].Y;
      Rotate(FPoints[0]);
      Rotate(FPoints[2]);
      FPoints[3] := FPoints[2];
    end;
  end;
end;

procedure TdxFcConnectionArrow.OffsetPoints(DX, DY: Integer);
var
  I: Integer;
begin
  if Active then
  begin
    for I := Low(FPoints) to Length(FPoints) - 1 do
    begin
      Inc(FPoints[I].X, DX);
      Inc(FPoints[I].Y, DY);
    end;
  end;
end;

procedure TdxFcConnectionArrow.Assign(Source: TPersistent);
begin
  if Source is TdxFcConnectionArrow then
    with TdxFcConnectionArrow(Source) do
    begin
      Self.ArrowType := ArrowType;
      Self.Color := Color;
      Self.Height := Height;
      Self.Width := Width;
    end
  else
    inherited Assign(Source);
end;

procedure TdxFcConnectionArrow.Paint(ACanvas: TcxCanvas);
begin
  if not Active then
    Exit;

  case ArrowType of
    fcaArrow:
      Painter.DrawPolyline(ACanvas, FPoints, Owner.Color, Owner.PenStyle, Owner.PenWidth);
    fcaEllipse:
      Painter.DrawEllipse(ACanvas, DisplayRect(False),
        Color, Owner.Color, Owner.PenStyle, Owner.PenWidth);
    fcaRectangle:
      Painter.DrawRectangle(ACanvas, DisplayRect(False),
        Color, Owner.Color, Owner.PenStyle, Owner.PenWidth);
  end;
end;

{TdxFcConnection}

constructor TdxFcConnection.Create(AOwner: TdxCustomFlowChart);
begin
  inherited Create(AOwner);
  FPoints := TdxFcPoints.Create;
  FRealPoints := TdxFcPoints.Create;
  FArrowSource := TdxFcConnectionArrow.Create(Self);
  FArrowDest := TdxFcConnectionArrow.Create(Self);
  AOwner.FConnections.Add(Self);
  FPenWidth := 1;
end;

destructor TdxFcConnection.Destroy;
var
  Resize: Boolean;
begin
  Owner.Delete(Self);
  //Update linked objects for dest and source object.
  Resize := not ((ObjectSource <> nil) and ObjectSource.Destroying or
    (ObjectDest <> nil) and ObjectDest.Destroying);
  SetObjectSource(nil, 0);
  SetObjectDest(nil, 0);
  FreeAndNil(FPoints);
  FreeAndNil(FRealPoints);
  FreeAndNil(FArrowSource);
  FreeAndNil(FArrowDest);
  Owner.FConnections.Remove(Self);
  if Resize then Owner.SetChartSizes;
  inherited Destroy;
end;

function TdxFcConnection.IndexValid(var Index: Integer; AMax: Integer): Boolean;
begin
  Result := (Index >= 0) and (Index <= PointCount - AMax);
  if ObjectSource <> nil then
    Inc(Index);
end;

function TdxFcConnection.GetPoint(Index: Integer): TPoint;
begin
  if IndexValid(Index, 1) then
    Result := FPoints[Index]
  else
    Result := cxNullPoint;
end;

function TdxFcConnection.GetRealPoint(Index: Integer): TPoint;
begin
  Result := FRealPoints[Index];
end;

function TdxFcConnection.GetRealTextRect: TRect;
begin
  Result := Owner.ScrollRect(FTextRect, False);
end;

procedure TdxFcConnection.SetPoint(AIndex: Integer; AValue: TPoint);
begin
  if IndexValid(AIndex, 1) then
  begin
    ConnectionChanged;
    FPoints[AIndex] := AValue;
    Owner.ScalePoint(AValue);
    FRealPoints[AIndex] := AValue;
    CalculateDisplayRect;
    Changed;
    Owner.SetChartSizes;
  end;
end;

function TdxFcConnection.GetRealCount: Integer;
begin
  Result := FRealPoints.Count;
end;

function TdxFcConnection.GetPointCount: Integer;
begin
  Result := RealCount;
  if ObjectSource <> nil then
    Dec(Result);
  if ObjectDest <> nil then
    Dec(Result);
end;

function TdxFcConnection.SelList: TList;
begin
  Result := Owner.FSelConnections;
end;

procedure TdxFcConnection.AddPoint(const P: TPoint);
begin
  InsertPoint(PointCount, P);
end;

procedure TdxFcConnection.InsertPoint(Index: Integer; const P: TPoint);
begin
  if IndexValid(Index, 0) then
  begin
    ConnectionChanged;
    InternalInsertPoint(Index, P);
    CalculateDisplayRect;
    Changed;
    Owner.SetChartSizes;
  end;
end;

procedure TdxFcConnection.RemovePoint(Index: Integer);
begin
  if IndexValid(Index, 1) then
  begin
    ConnectionChanged;
    FPoints.Delete(Index);
    FRealPoints.Delete(Index);
    CalculateDisplayRect;
    Changed;
    Owner.SetChartSizes;
  end;
end;

procedure TdxFcConnection.SetPenStyle(Value: TPenStyle);
begin
  if FPenStyle <> Value then
  begin
    FPenStyle := Value;
    ConnectionChanged;
    Changed;
  end;
end;

procedure TdxFcConnection.SetPenWidth(Value: Integer);
begin
  if FPenWidth <> Value then
  begin
    FPenWidth := Value;
    ConnectionChanged;
    Changed;
  end;
end;

procedure TdxFcConnection.SetStyle(Value: TdxFclStyle);
begin
  if (FStyle <> Value) then
  begin
    if (ArrowSource.ArrowType = fcaArrow) or (ArrowDest.ArrowType = fcaArrow) then
      ConnectionChanged;
    FStyle := Value;
    ArrowSource.ClearPoints;
    ArrowDest.ClearPoints;
    CalculateDisplayRect;
    Changed;
  end;
end;

procedure TdxFcConnection.SetText(Value: string);
begin
  if (FText <> Value) then
  begin
    if Text <> '' then InvalidateText;
    FText := Value;
    if Text <> '' then
    begin
      CalculateTextRect;
      InvalidateText;
    end;
    Changed;
    Owner.SetChartSizes;
  end;
end;

procedure TdxFcConnection.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    ConnectionChanged;
    Changed;
  end;
end;

procedure TdxFcConnection.SetTransparent(Value: Boolean);
begin
  if (FTransparent <> Value) then
  begin
    FTransparent := Value;
    ConnectionChanged;
    Changed;
  end;
end;

procedure TdxFcConnection.SetArrowSource(Value: TdxFcConnectionArrow);
begin
  ArrowSource.Assign(Value);
end;

procedure TdxFcConnection.SetArrowDest(Value: TdxFcConnectionArrow);
begin
  ArrowDest.Assign(Value);
end;

function TdxFcConnection.GetDisplayRect: TRect;
begin
  Result := FDisplayRect;
  if Text <> '' then
    UnionRect(Result, Result, FTextRect);
  if ArrowSource.Active then
    UnionRect(Result, Result, ArrowSource.DisplayRect(True));
  if ArrowDest.Active then
    UnionRect(Result, Result, ArrowDest.DisplayRect(True));
  Result := Owner.ScrollRect(Result, False);
end;

procedure TdxFcConnection.InvalidateText;
begin
  if FPoints.Count >= 2 then
  begin
    if Owner.CanPaint then
      Owner.InvalidateRect(RealTextRect, True);
    Owner.NeedRepaintObject(Self);
  end;
end;

procedure TdxFcConnection.ConnectionChanged;
begin
  if FPoints.Count >= 2 then
  begin
    ArrowSource.SetPoints(0);
    ArrowDest.SetPoints(RealCount - 1);
    Owner.NeedRepaintObject(Self);
  end;
end;

procedure TdxFcConnection.InternalInsertPoint(AIndex: Integer; P: TPoint);
begin
  FPoints.Insert(AIndex, P);
  Owner.ScalePoint(P);
  FRealPoints.Insert(AIndex, P);
end;

procedure TdxFcConnection.Invalidate;
begin
  ConnectionChanged;
end;

procedure TdxFcConnection.CalculateDisplayRect;
var
  I: Integer;
begin
  Owner.FHitTest := [];
  if Destroying or (FPoints.Count < 2) then Exit;
  FDisplayRect.TopLeft := FRealPoints[0];
  FDisplayRect.BottomRight := FDisplayRect.TopLeft;
  for I := 1 to RealCount - 1 do
    dxLines.ExtendRect(FDisplayRect, FRealPoints[I]);
  FMassCenter := FRealPoints.GetLineCenter(TLineType(Style));
  Inc(FDisplayRect.Right);
  Inc(FDisplayRect.Bottom);
  if Text <> '' then
    CalculateTextRect;
  ConnectionChanged;
end;

procedure TdxFcConnection.CalculateTextRect;
var
  DX, DY: Integer;
begin
  Owner.FHitTest := [];
  FTextRect := cxRect(0, 0, 1, 0);
  cxTextOut(cxScreenCanvas.Handle, Text, FTextRect, CXTO_CALCRECT, RealFont);
  DX := FMassCenter.X - cxRectWidth(FTextRect) div 2;
  DY := FMassCenter.Y - cxRectHeight(FTextRect) div 2;
  OffsetRect(FTextRect, DX, DY);
end;

procedure TdxFcConnection.FontChanged;
begin
  InvalidateText;
  CalculateTextRect;
  InvalidateText;
  Owner.SetChartSizes;
end;

procedure TdxFcConnection.ZoomChanged;
var
  J: Integer;
  P: TPoint;
begin
  for J := 0 to RealCount - 1 do
  begin
    P := FPoints[J];
    Owner.ScalePoint(P);
    FRealPoints[J] := P;
  end;
  ArrowSource.SetRealBounds;
  ArrowDest.SetRealBounds;
  SetObjectPoints;
  ScaleFont;
  if Text <> '' then
    CalculateTextRect;
  CalculateDisplayRect;
end;

procedure TdxFcConnection.SetObjectPoints;

  procedure SetPoint(AObj: TdxFcObject; Arrow: TdxFcConnectionArrow; PtIndex, ListIndex: Integer);
  begin
    FRealPoints[ListIndex] := AObj.LinkedPoints[PtIndex];
    Arrow.SetPoints(ListIndex);
  end;

begin
  if Destroying or (FPoints.Count < 2) then Exit;
  if ObjectSource <> nil then
    SetPoint(ObjectSource, ArrowSource, FPointSource, 0);
  if ObjectDest <> nil then
    SetPoint(ObjectDest, ArrowDest, FPointDest, RealCount - 1);
end;

procedure TdxFcConnection.DelObj(AObj, Partneur: TdxFcObject; Index: Integer);
begin
  if Partneur <> nil then
  begin
    AObj.FLinkedObjects.Remove(Partneur);
    Partneur.FLinkedObjects.Remove(AObj);
  end;
  AObj.FConnections.Remove(Self);
  FRealPoints.Delete(Index);
  FPoints.Delete(Index);
end;

procedure TdxFcConnection.InsObj(AObj, Partneur: TdxFcObject; Index: Integer);
begin
  if Partneur <> nil then
  begin
    AObj.FLinkedObjects.Add(Partneur);
    Partneur.FLinkedObjects.Add(AObj);
  end;
  AObj.FConnections.Add(Self);
  InternalInsertPoint(Index, cxNullPoint);
end;

procedure TdxFcConnection.SetObjectSource(AObject: TdxFcObject; APoint: Byte);
begin
  if (AObject <> ObjectSource) or (APoint <> FPointSource) then
  begin
    ConnectionChanged;
    if AObject <> ObjectSource then
    begin
      if ObjectSource <> nil then
        DelObj(ObjectSource, ObjectDest, 0);
      if AObject <> nil then
        InsObj(AObject, ObjectDest, 0);
      FObjectSource := AObject;
    end;
    FPointSource := APoint;
    SetObjectPoints;
    CalculateDisplayRect;
    Changed;
  end;
end;

procedure TdxFcConnection.SetObjectDest(AObject: TdxFcObject; APoint: Byte);
begin
  if (AObject <> ObjectDest) or (APoint <> FPointDest) then
  begin
    ConnectionChanged;
    if AObject <> ObjectDest then
    begin
      if ObjectDest <> nil then
        DelObj(ObjectDest, ObjectSource, RealCount - 1);
      if AObject <> nil then
        InsObj(AObject, ObjectSource, RealCount);
      FObjectDest := AObject;
    end;
    FPointDest := APoint;
    SetObjectPoints;
    CalculateDisplayRect;
    Changed;
  end;
end;

function TdxFcConnection.ScreenPoint(Index: Integer): TPoint;
begin
  Result := Owner.ScrollPoint(FRealPoints[Index], False);
end;

function TdxFcConnection.HasPoint(const P: TPoint): Boolean;
begin
  Result := FRealPoints.IsPointOnLine(TLineType(Style), P);
end;

function TdxFcConnection.InRect(const R: TRect): Boolean;
begin
  Result := FRealPoints.IsRectOnLine(TLineType(Style), Owner.ScrollRect(R));
end;

function TdxFcConnection.GetNearestPoint(X, Y: Integer): Integer;
begin
  Result := FRealPoints.GetNearestPointIndex(Owner.ScrollPoint(Point(X, Y)));
  if ObjectSource <> nil then
    Dec(Result);
end;

procedure TdxFcConnection.ArrowChanged(Value: TdxFcConnectionArrow);
begin
  //TODO optimized the drawing
  if Value = ArrowSource then
    Value.SetPoints(0);
  if Value = ArrowDest then
    Value.SetPoints(RealCount - 1);
  ConnectionChanged;
end;

procedure TdxFcConnection.Assign(Source: TPersistent);
var
  I: Integer;
begin
  if Source is TdxFcConnection then
    with TdxFcConnection(Source) do
    begin
      if Self.PointCount > 0 then Self.RemovePoint(0);
      Self.FPoints.Clear;
      Self.FRealPoints.Clear;
      Self.SetObjectSource(ObjectSource, PointSource);
      Self.SetObjectDest(ObjectDest, PointDest);
      Self.ArrowSource := ArrowSource;
      Self.ArrowDest := ArrowDest;
      Self.Color := Color;
      Self.Transparent := Transparent;
      for I := 0 to PointCount - 1 do
        Self.AddPoint(Points[I]);
      Self.PenStyle := PenStyle;
      Self.PenWidth := PenWidth;
      Self.Style := Style;
    end;
  inherited Assign(Source);
end;

procedure TdxFcConnection.OffsetRealPoints(DX, DY: Integer);
begin
  FRealPoints.OffsetPoints(DX, DY);
  ArrowSource.OffsetPoints(DX, DY);
  ArrowDest.OffsetPoints(DX, DY);
end;

procedure TdxFcConnection.NewPoint(X, Y: Integer; Handler: TdxFcDragHandler);
var
  I: Integer;
  P0, P1, P2: TPoint;
begin
  I := PointIndex + 1;
  if (I <= 0) or (I >= RealCount) then
  begin
    I := GetNearestPoint(X, Y);
    if ObjectSource <> nil then Inc(I);
    if I = 0 then
      Inc(I)
    else
      if I < RealCount - 1 then
      begin
        P0 := ScreenPoint(I);
        P1 := ScreenPoint(I - 1);
        P2 := ScreenPoint(I + 1);
        Dec(P0.X, X); Dec(P0.Y, Y);
        Dec(P1.X, X); Dec(P1.Y, Y);
        Dec(P2.X, X); Dec(P2.Y, Y);
        if (P0.X * P2.X) + (P0.Y * P2.Y) < (P0.X * P1.X) + (P0.Y * P1.Y) then Inc(I);
      end;
  end;
  InternalInsertPoint(I, Owner.ChartPoint(X, Y));
  Owner.DragHelper.FIndex := I;
  Owner.DragHelper.FDragConnection := Self;
  ConnectionChanged;
  Owner.DragHelper.DragStart(X, Y, Handler);
end;

function TdxFcConnection.RealStyle: TdxFclStyle;
begin
  if (Style = fclCurved) and (RealCount < 3) then
    Result := fclStraight
  else
    Result := Style;
end;

procedure TdxFcConnection.DrawContent(ACanvas: TcxCanvas);
begin
  OffsetRealPoints(-Owner.LeftEdge, -Owner.TopEdge);
  try
    DrawLine(ACanvas);
    ArrowSource.Paint(ACanvas);
    ArrowDest.Paint(ACanvas);
  finally
    OffsetRealPoints(Owner.LeftEdge, Owner.TopEdge);
  end;
end;

procedure TdxFcConnection.DrawLine(ACanvas: TcxCanvas);
var
  P: TPointArray;
begin
  FRealPoints.CalculatePolyline(TLineType(RealStyle), P);
  Owner.Painter.DrawPolyline(ACanvas, P, Color, PenStyle, PenWidth);
  P := nil;
end;

procedure TdxFcConnection.DrawText(ACanvas: TcxCanvas);
var
  R: TRect;
begin
  if Text <> '' then
  begin
    R := RealTextRect;
    cxTextOut(ACanvas.Handle, Text, R, CXTO_CENTER_HORIZONTALLY, RealFont);
  end;
end;

procedure TdxFcConnection.Paint(ACanvas: TcxCanvas; Upper: Boolean);
begin
  if Transparent xor Upper then
  begin
    DrawContent(ACanvas);
    DrawText(ACanvas);
  end;
end;

procedure TdxFcConnection.Load(Stream: TStream; AIsUnicode: Boolean);
var
  P: TPoint;
  ConData: TdxFcConData;
begin
  Stream.ReadBuffer(ConData, SizeOf(ConData));
  Style := ConData.Style;
  Color := ConData.Color;
  ParentFont := ConData.ParFont;
  Transparent := ConData.PtDst and $80 <> 0;
  PenStyle := TPenStyle(ConData.PtSrc shr 4);
  ConData.PtDst := ConData.PtDst and $7F;
  ConData.PtSrc := ConData.PtSrc and $0F;
  SetObjectSource(Owner.Objects[ConData.ObjSrc], ConData.PtSrc);
  SetObjectDest(Owner.Objects[ConData.ObjDst], ConData.PtDst);
  while ConData.PtCount > 0 do
  begin
    Stream.ReadBuffer(P, SizeOf(P));
    InternalInsertPoint(PointCount + Ord(ObjectSource <> nil), P);
    Dec(ConData.PtCount);
  end;
  ArrowSource.Load(ConData.ArwSrc);
  ArrowDest.Load(ConData.ArwDst);
  SetObjectPoints;
  CalculateDisplayRect;
  LoadFont(Stream, AIsUnicode);
  Text := ReadStr(Stream, AIsUnicode);
end;

procedure TdxFcConnection.Save(Stream: TStream);

  function GetZOrder(AObject: TdxFcObject): Integer;
  begin
    if AObject = nil then
      Result := -1
    else
      Result := AObject.ZOrder;
  end;

var
  I: Integer;
  P: TPoint;
  ConData: TdxFcConData;
begin
  with ConData do
  begin
    ObjSrc := GetZOrder(ObjectSource);
    ObjDst := GetZOrder(ObjectDest);

    PtCount := Word(PointCount);
    Color := Self.Color;
    PtSrc := FPointSource;
    PtDst := FPointDest;
    Style := Self.Style;
    ParFont := ParentFont;
    PtSrc := PtSrc or Ord(PenStyle) shl 4;
    if Transparent then
      PtDst := PtDst or $80;
    ArrowSource.Save(ArwSrc);
    ArrowDest.Save(ArwDst);
  end;
  Stream.WriteBuffer(ConData, SizeOf(ConData));
  for I := 0 to PointCount - 1 do
  begin
    P := Points[I];
    Stream.WriteBuffer(P, SizeOf(P));
  end;
  SaveFont(Stream);
  WriteStr(Stream, Text);
end;

{ TdxFlowChartDragHelper }

constructor TdxFlowChartDragHelper.Create(AOwner: TdxCustomFlowChart);
begin
  inherited Create;
  FOwner := AOwner;
end;

procedure TdxFlowChartDragHelper.CallDragHandler(X, Y: Integer; State: TDragState);
begin
  ShowCursor(False);
  FDragHandler(X, Y, State);
  ShowCursor(True);
end;

procedure TdxFlowChartDragHelper.CheckDragStart(X, Y: Integer;
  const AShift: TShiftState; const AHitTest: TdxFcHitTest);

  function CheckNewConnectionDragMode: Boolean;
  var
    APoint: Byte;
  begin
    Result := (ObjectAt <> nil) and ObjectAt.Selected and ([htOnObject, htOnSelPoint] * AHitTest = []);
    if Result then
    begin
      FIndex := 1;
      APoint := ObjectAt.GetLinkedPoint(X, Y);
      FDragConnection := Owner.CreateConnection(ObjectAt, ObjectAt, APoint, APoint);
      DragStart(X, Y, DoDragConnect);
    end;
  end;

  procedure CheckPointDragStart;
  begin
    if Owner.SelectedObjectCount <> 1 then
    begin
      FDragConnection := ConnectionAt;
      FIndex := FDragConnection.GetNearestPoint(X, Y);
      if FDragConnection.ObjectSource <> nil then
        Inc(FIndex);
      if (FIndex = 0) or (FIndex = FDragConnection.RealCount - 1) then
        DragStart(X, Y, DoDragConnect)
      else
        DragStart(X, Y, DoDragPoint);
    end
    else
      DragStart(X, Y, DoDragResize);
  end;

begin
  if (fcoCanDrag in Owner.Options) and cxShiftStateLeftOnly(AShift) then
  begin
    if not CheckNewConnectionDragMode then
    begin
      if htOnSelPoint in AHitTest then
        CheckPointDragStart
      else
        if (htOnObject in AHitTest) and ObjectAt.Selected then
          DragStart(X, Y, DoDragMove)
        else
          if (htOnConnection in AHitTest) and
             (ConnectionAt = Owner.SelectedConnection)
          then
            ConnectionAt.NewPoint(X, Y, DoDragPoint);
    end;
  end;
end;

procedure TdxFlowChartDragHelper.DragMove(X, Y: Integer);
begin
  if Dragging then
    CallDragHandler(X, Y, dsDragMove);
end;

procedure TdxFlowChartDragHelper.DragStart(X, Y: Integer; AHandler: TdxFcDragHandler);
begin
  FDragging := True;
  FDragHandler := AHandler;
  CallDragHandler(X, Y, dsDragEnter);
end;

procedure TdxFlowChartDragHelper.DragStop(X, Y: Integer);
begin
  if Dragging then
  begin
    FDragging := False;
    CallDragHandler(X, Y, dsDragLeave);
    FDragHandler := nil;
  end;
end;

procedure TdxFlowChartDragHelper.DoDragMove(X, Y: Integer; State: TDragState);

  procedure DrawRgn;
  begin
    SetROP2(Canvas.Handle, R2_NOTXORPEN);
    FillRgn(Canvas.Handle, FRegion, GetStockObject(BLACK_BRUSH));
  end;

  procedure DragMoveStart;
  var
    ARegion: TcxRegionHandle;
    I: Integer;
  begin
    FDynamicMoving := fcoDynamicMoving in Owner.Options;
    if not DynamicMoving then
    begin
      FPaintLocked := True;
      FRegion := CreateRectRgnIndirect(cxNullRect);
      for I := 0 to FOwner.SelectedObjectCount - 1 do
      begin
        ARegion := FOwner.SelectedObjects[I].CreateShapeRegion;
        CombineRgn(FRegion, FRegion, ARegion, RGN_OR);
        DeleteObject(ARegion);
      end;
      DrawRgn;
    end;
    FBase := Point(X, Y);
    FMobile := FBase;
  end;

  procedure DragMoveMove;
  var
    dX, dY: Integer;
  begin
    dX := X - FMobile.X;
    dY := Y - FMobile.Y;
    if DynamicMoving then
      Owner.MoveObjects(dX, dY)
    else
    begin
      DrawRgn;
      OffsetRgn(FRegion, dX, dY);
      DrawRgn;
    end;
    FMobile := Point(X, Y);
  end;

  procedure DragMoveLeave;
  begin
    if not DynamicMoving then
    begin
      DrawRgn;
      Windows.DeleteObject(FRegion);
      FMobile := Owner.ChartPoint(X, Y);
      FBase := Owner.ChartPoint(FBase.X, FBase.Y);
      Owner.MoveObjects(FMobile.X - FBase.X, FMobile.Y - FBase.Y);
      FPaintLocked := False;
    end;
  end;

begin
  case State of
    dsDragEnter:
      DragMoveStart;
    dsDragMove:
      DragMoveMove;
    dsDragLeave:
      DragMoveLeave;
  end;
end;

procedure TdxFlowChartDragHelper.DoDragResize(X, Y: Integer; State: TDragState);

  function NormalizeRect(const R: TRect): TRect;
  begin
    Result := R;
    if Result.Left > Result.Right then
      Swap(Result.Left, Result.Right);
    if Result.Top > Result.Bottom then
      Swap(Result.Top, Result.Bottom);
  end;

  procedure UpdateDragObjectBounds;
  begin
    FDragObject.SetBounds(NormalizeRect(Rect(
      Owner.ChartPoint(FBase.X, FBase.Y),
      Owner.ChartPoint(FMobile.X, FMobile.Y))));
  end;

  procedure DrawRect(Init: Boolean);
  begin
    if Init then
    begin
      Canvas.Pen.Color := clBlack;
      Canvas.Brush.Style := bsClear;
      SetROP2(Canvas.Handle, R2_NOTXORPEN);
    end;
    Canvas.Canvas.Rectangle(NormalizeRect(cxRect(FBase, FMobile)));
  end;

  procedure DragResizeStart;
  begin
    FDynamicSizing := fcoDynamicSizing in Owner.Options;
    FDragObject := Owner.SelectedObject;
    FIndex := Word(FDragObject.GetSelPoint(X, Y));
    FMobile := FDragObject.DisplayRect.BottomRight;
    FBase := FDragObject.DisplayRect.TopLeft;

    if (FIndex < 2) or (FIndex > 5) then
      Swap(FBase.X, FMobile.X);
    if (FIndex < 4) then
      Swap(FBase.Y, FMobile.Y);
    FIndex := FIndex and 3;

    if not DynamicSizing then
    begin
      FPaintLocked := True;
      DrawRect(True);
    end;
  end;

  procedure DrawResizeLeave;
  begin
    FPaintLocked := False;
    if FDragObject <> nil then
    begin
      UpdateDragObjectBounds;
      FDragObject := nil;
    end;
    Owner.Invalidate;
  end;

  procedure DrawResizeMove;
  begin
    if not DynamicSizing then
      DrawRect(True);
    if FIndex <> 1 then
      FMobile.X := X;
    if FIndex <> 3 then
      FMobile.Y := Y;
    if DynamicSizing then
      UpdateDragObjectBounds
    else
      DrawRect(False);
  end;

begin
  case State of
    dsDragEnter:
      DragResizeStart;
    dsDragMove:
      DrawResizeMove;
    dsDragLeave:
      DrawResizeLeave;
  end;
end;

procedure TdxFlowChartDragHelper.DoDragPoint(X, Y: Integer; State: TDragState);

  function CanRemovePoint(X, Y: Integer): Boolean;
  var
    ACurPoint: TPoint;
    P: array[0..1] of TPoint;
  begin
    Result := (fcoDelOnClick in FOwner.Options) and (FBase.X = 0);
    if not Result then
    begin
      ACurPoint := FOwner.ChartPoint(X, Y);
      FBase := FDragConnection.RealPoints[FIndex - 1];
      FMobile := FDragConnection.RealPoints[FIndex + 1];
      case FDragConnection.Style of
        fclRectH:
          Result := (ACurPoint.X = FMobile.X) or (ACurPoint.Y = FBase.Y);
        fclRectV:
          Result := (ACurPoint.X = FBase.X) or (ACurPoint.Y = FMobile.Y);
        fclStraight:
          begin
            P[0] := FBase;
            P[1] := FMobile;
            Result := PtOnLine(liStraight, P[0], Length(P),
              Screen.Width shr 9, ACurPoint.X, ACurPoint.Y);
          end;
      end;
    end;
  end;

  procedure DoSetPoint(X, Y, AIndex: Integer);
  begin
    FDragConnection.FRealPoints.Points[AIndex] := Owner.ScrollPoint(Point(X, Y));
    FDragConnection.ConnectionChanged;
  end;

  procedure DragPointBegin;
  begin
    FBase.X := 0;
    FMobile := FDragConnection.FRealPoints.Points[FIndex];
  end;

  procedure DragPointMove;
  begin
    FBase.X := 1;
    DoSetPoint(X, Y, FIndex);
    Owner.Invalidate;
  end;

  procedure DragPointLeave;
  var
    AIndex: Integer;
  begin
    AIndex := FIndex;
    DoSetPoint(FMobile.X, FMobile.Y, FIndex);
    if FDragConnection.ObjectSource <> nil then
      Dec(AIndex);
    if CanRemovePoint(X, Y) then
      FDragConnection.RemovePoint(AIndex)
    else
      FDragConnection.Points[AIndex] := Point(X, Y);
  end;

begin
  case State of
    dsDragEnter:
      DragPointBegin;
    dsDragMove:
      DragPointMove;
    dsDragLeave:
      DragPointLeave;
  end;
end;

procedure TdxFlowChartDragHelper.DoDragConnect(X, Y: Integer; State: TDragState);

  procedure DragConnectStart;
  begin
    if (FIndex = 0) and (FDragConnection.ObjectSource <> nil) or
      (FIndex <> 0) and (FDragConnection.ObjectDest <> nil) then
    begin
      FBase := FDragConnection.RealPoints[FIndex];
      if FIndex = 0 then
        FDragConnection.SetObjectSource(nil, 0)
      else
        FDragConnection.SetObjectDest(nil, 0);

      FDragConnection.FPoints.Insert(FIndex, FBase);
      FDragConnection.FRealPoints.Insert(FIndex, FBase);
    end;
    FDragConnection.ConnectionChanged;
  end;

  procedure DrawConnectLeave;
  var
    I: Integer;
  begin
    FOwner.HitTest(X, Y);
    if ObjectAt = nil then
    begin
      Dec(FIndex, Ord(FDragConnection.ObjectSource <> nil));
      FDragConnection.Points[FIndex] := Owner.ChartPoint(X, Y);
    end
    else
    begin
      I := ObjectAt.GetLinkedPoint(X, Y);
      FDragConnection.FPoints.Delete(FIndex);
      FDragConnection.FRealPoints.Delete(FIndex);
      if FIndex = 0 then
        FDragConnection.SetObjectSource(ObjectAt, I)
      else
        FDragConnection.SetObjectDest(ObjectAt, I);
    end;
    FOwner.FHitTest := [];
    FOwner.Invalidate;
  end;

begin
  case State of
    dsDragEnter:
      DragConnectStart;
    dsDragLeave:
      DrawConnectLeave;
    dsDragMove:
      begin
        FDragConnection.FRealPoints[FIndex] := Owner.ScrollPoint(Point(X, Y));
        FDragConnection.ConnectionChanged;
        FOwner.Invalidate;
      end;
  end;
end;

function TdxFlowChartDragHelper.GetCanvas: TcxCanvas;
begin
  Result := FOwner.Canvas;
end;

function TdxFlowChartDragHelper.GetConnectionAt: TdxFcConnection;
begin
  Result := FOwner.FConnectionAt;
end;

function TdxFlowChartDragHelper.GetObjectAt: TdxFcObject;
begin
  Result := FOwner.FObjectAt;
end;

{TdxCustomFlowChart}

constructor TdxCustomFlowChart.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Color := clDefault;
  ControlStyle := ControlStyle - [csCaptureMouse];
  Width := 320;
  Height := 200;
  ParentColor := False;
  TabStop := True;
  FObjects := TList.Create;
  FConnections := TList.Create;
  FSelObjects := TList.Create;
  FSelConnections := TList.Create;
  FSelection := TdxFcSelection.Create(Self);
  FZoom := 100;
  FRealZoom := 100;
  DoubleBuffered := True;
  FDragHelper := TdxFlowChartDragHelper.Create(Self);
  FOptions := [fcoCanDelete, fcoCanDrag, fcoCanSelect, fcoMultiSelect, fcoHideSelection, fcoDelOnClick];
  FChangeLink := TChangeLink.Create;
  FChangeLink.OnChange := DoChangeLink;
  BorderStyle := bsSingle;
  FPainter := CreatePainter;
end;

destructor TdxCustomFlowChart.Destroy;
begin
  OnDeletion := nil;
  OnSelected := nil;
  Clear;
  FreeAndNil(FObjects);
  FreeAndNil(FConnections);
  FreeAndNil(FSelObjects);
  FreeAndNil(FDragHelper);
  FreeAndNil(FSelConnections);
  FreeAndNil(FSelection);
  FreeAndNil(FChangeLink);
  FreeAndNil(FPainter);
  inherited Destroy;
end;

procedure TdxCustomFlowChart.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WindowClass.Style := Params.WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
  Params.Style := Params.Style or WS_TABSTOP;
end;

procedure TdxCustomFlowChart.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FImages) then Images := nil;
end;

function TdxCustomFlowChart.GetBackgroundColor: TColor;
begin
  Result := Color;
  if Result = clDefault then
    Result := LookAndFeelPainter.DefaultEditorBackgroundColor(False);
  if Result = clDefault then
    Result := clWindow;
end;

function TdxCustomFlowChart.GetBorderStyle: TBorderStyle;
const
  BorderStyleMap: array[TcxControlBorderStyle] of TBorderStyle = (bsNone, bsSingle);
begin
  Result := BorderStyleMap[inherited BorderStyle];
end;

function TdxCustomFlowChart.GetClientHeight: Integer;
begin
  Result := cxRectHeight(ClientBounds);
end;

function TdxCustomFlowChart.GetClientWidth: Integer;
begin
  Result := cxRectWidth(ClientBounds)
end;

function TdxCustomFlowChart.GetConnection(Index: Integer): TdxFcConnection;
begin
  Result := TdxFcConnection(GetListItem(FConnections, Index));
end;

function TdxCustomFlowChart.GetObjectValue(Index: Integer): TdxFcObject;
begin
  Result := TdxFcObject(GetListItem(FObjects, Index));
end;

function TdxCustomFlowChart.GetConnectionCount: Integer;
begin
  Result := FConnections.Count;
end;

function TdxCustomFlowChart.GetObjectCount: Integer;
begin
  Result := FObjects.Count;
end;

function TdxCustomFlowChart.GetSelectedObject(Index: Integer): TdxFcObject;
begin
  Result := TdxFcObject(GetListItem(FSelObjects, Index));
end;

function TdxCustomFlowChart.GetSelectedObjectCount: Integer;
begin
  Result := FSelObjects.Count;
end;

function TdxCustomFlowChart.GetSelectedConnection(Index: Integer): TdxFcConnection;
begin
  Result := TdxFcConnection(GetListItem(FSelConnections, Index));
end;

function TdxCustomFlowChart.GetSelectedConnectionCount: Integer;
begin
  Result := FSelConnections.Count;
end;

function TdxCustomFlowChart.SelCount: Integer;
begin
  Result := FSelObjects.Count + FSelConnections.Count;
end;

procedure TdxCustomFlowChart.SetAntialiasing(AValue: Boolean);
var
  AOldPainter: TdxFlowChartPainter;
begin
  if AValue <> FAntialiasing then
  begin
    FAntialiasing := AValue;
    AOldPainter := FPainter;
    FPainter := CreatePainter;
    FreeAndNil(AOldPainter);
    Invalidate;
  end;
end;

procedure TdxCustomFlowChart.SetBorderStyle(Value: TBorderStyle);
const
  BorderStyleMap: array[TBorderStyle] of TcxControlBorderStyle = (cxcbsNone, cxcbsDefault);
begin
  inherited BorderStyle := BorderStyleMap[Value];
end;

procedure TdxCustomFlowChart.SetImages(Value: TCustomImageList);
begin
  if (FImages <> Value) then
  begin
    if (FImages <> nil) and not (csDestroying in FImages.ComponentState) then
      FImages.UnRegisterChanges(FChangeLink);
    FImages := Value;
    if (FImages <> nil) then
    begin
      FImages.RegisterChanges(FChangeLink);
      FImages.FreeNotification(Self);
    end;
    if not (csDestroying in ComponentState) then NeedRepaint;
  end;
end;

procedure TdxCustomFlowChart.SetOptions(Value: TdxFcOptions);
const
  Sel: TdxFcOptions = [fcoCanSelect, fcoMultiSelect];
var
  NewOpts: TdxFcOptions;
begin
  if (Options <> Value) then
  begin
    NewOpts := (Options + Value) - (Options * Value);
    FOptions := Value;
    if (NewOpts * Sel <> []) and (Options * Sel <> Sel) then
      ClearSelection;
    if (fcoHideSelection in NewOpts) and not Focused then
      InvalidateSel;
  end;
end;

procedure TdxCustomFlowChart.SetConnection(Index: Integer; Value: TdxFcConnection);
begin
  Connections[Index].Assign(Value);
end;

procedure TdxCustomFlowChart.SetObjectValue(Index: Integer; Value: TdxFcObject);
begin
  Objects[Index].Assign(Value);
end;

procedure TdxCustomFlowChart.SetZoom(AValue: Word);
begin
  if AValue <> Zoom then
  begin
    FZoom := AValue;
    CalculateRealZoomFactor;
  end;
end;

procedure TdxCustomFlowChart.ScalePoint(var P: TPoint);
begin
  P.X := MulDiv(P.X, RealZoom, 100);
  P.Y := MulDiv(P.Y, RealZoom, 100);
end;

function TdxCustomFlowChart.ChartPoint(X, Y: Integer): TPoint;
begin
  Result.X := MulDiv(X + LeftEdge, 100, RealZoom);
  Result.Y := MulDiv(Y + TopEdge, 100, RealZoom);
end;

procedure TdxCustomFlowChart.CalculateChartSizes;

  procedure DoExtendRect(R: TRect; var ANewR: TRect);
  begin
    R := ScrollRect(R);
    dxLines.ExtendRect(ANewR, R.TopLeft);
    dxLines.ExtendRect(ANewR, R.BottomRight);
  end;

var
  AOldR, ANewR: TRect;
  I: Integer;
begin
  ANewR := cxNullRect;
  AOldR := cxRectBounds(FChartLeft, FChartTop, FChartWidth, FChartHeight);

  for I := 0 to ObjectCount - 1 do
    DoExtendRect(Objects[I].DisplayRect, ANewR);
  for I := 0 to ConnectionCount - 1 do
    DoExtendRect(Connections[I].DisplayRect, ANewR);

  if not cxRectCompare(AOldR, ANewR) then
  begin
    FChartTop := ANewR.Top;
    FChartLeft := ANewR.Left;
    FChartWidth := cxRectWidth(ANewR);
    FChartHeight := cxRectHeight(ANewR);
    UpdateScrollBars;
  end;
end;

procedure TdxCustomFlowChart.CalculateRealPos;
var
  I: Integer;
begin
  BeginUpdate;
  try
    for I := 0 to ObjectCount - 1 do
      Objects[I].ZoomChanged;
    for I := 0 to ConnectionCount - 1 do
      Connections[I].ZoomChanged;
    NeedRepaint;
  finally
    EndUpdate;
  end;
end;

procedure TdxCustomFlowChart.DoChangeLink(Sender: TObject);
begin
  NeedRepaint;
end;

function TdxCustomFlowChart.InternalCreateObject: TdxFcObject;
begin
  Result := TdxFcObject.Create(Self);
end;

function TdxCustomFlowChart.InternalCreateConnection: TdxFcConnection;
begin
  Result := TdxFcConnection.Create(Self);
end;

function TdxCustomFlowChart.NeedRedrawOnResize: Boolean;
begin
  Result := True;
end;

function TdxCustomFlowChart.ScrollPoint(
  const P: TPoint; APositiveFactor: Boolean = True): TPoint;
begin
  Result := cxPointOffset(P, LeftEdge, TopEdge, APositiveFactor);
end;

function TdxCustomFlowChart.ScrollRect(
  const R: TRect; APositiveFactor: Boolean = True): TRect;
begin
  Result := cxRectOffset(R, LeftEdge, TopEdge, APositiveFactor);
end;

function TdxCustomFlowChart.CreateObject(L, T, W, H: Integer; AShape: TdxFcShapeType): TdxFcObject;
begin
  Result := InternalCreateObject;
  if Assigned(OnCreateItem) then OnCreateItem(Self, Result);
  with Result do
  begin
    FShapeType := AShape;
    SetBounds(L, T, W, H);
  end;
end;

function TdxCustomFlowChart.CreateConnection(OSrc, ODst: TdxFcObject; PSrc, PDst: Byte): TdxFcConnection;
begin
  Result := InternalCreateConnection;
  if Assigned(OnCreateItem) then OnCreateItem(Self, Result);
  with Result do
  begin
    SetObjectSource(OSrc, PSrc);
    SetObjectDest(ODst, PDst);
  end;
end;

procedure TdxCustomFlowChart.DeleteObject(AObject: TdxFcObject);
begin
  AObject.Free;
end;

procedure TdxCustomFlowChart.DeleteConnection(AConnection: TdxFcConnection);
begin
  AConnection.Free;
end;

procedure TdxCustomFlowChart.Clear;
begin
  if ObjectCount + ConnectionCount = 0 then Exit;
  BeginUpdate;
  FSelConnections.Clear;
  FSelObjects.Clear;
  while ConnectionCount > 0 do
    Connections[0].Free;
  while ObjectCount > 0 do
    Objects[0].Free;
  EndUpdate;
end;

procedure TdxCustomFlowChart.ClearSelection;
begin
  while SelectedConnectionCount > 0 do
    SelectedConnections[0].Selected := False;
  while SelectedObjectCount > 0 do
    SelectedObjects[0].Selected := False;
end;

procedure TdxCustomFlowChart.DeleteSelection;
begin
  while SelectedConnectionCount > 0 do
    SelectedConnections[0].Free;
  while SelectedObjectCount > 0 do
    SelectedObjects[0].Free;
end;

procedure TdxCustomFlowChart.SelectAll;
var
  I: Integer;
begin
  for I := 0 to ObjectCount - 1 do
    Objects[I].Selected := True;
  for I := 0 to ConnectionCount - 1 do
    Connections[I].Selected := True;
end;

function TdxCustomFlowChart.GetSelConnect: TdxFcConnection;
begin
  if (SelectedObjectCount = 0) and (SelectedConnectionCount = 1) then
    Result := SelectedConnections[0]
  else
    Result := nil;
end;

function TdxCustomFlowChart.GetSelObj: TdxFcObject;
begin
  if (SelectedObjectCount = 1) and (SelectedConnectionCount = 0) then
    Result := SelectedObjects[0]
  else
    Result := nil;
end;

procedure TdxCustomFlowChart.SetSelConnect(Value: TdxFcConnection);
begin
  if Value <> SelectedConnection then
  begin
    ClearSelection;
    if Value <> nil then
      Value.Selected := True;
  end;
end;

procedure TdxCustomFlowChart.SetSelObj(Value: TdxFcObject);
begin
  if Value <> SelectedObject then
  begin
    ClearSelection;
    if Value <> nil then
      Value.Selected := True;
  end;
end;

function TdxCustomFlowChart.CanPaint: Boolean;
begin
  Result := (FLockUpdates = 0) and HandleAllocated;
end;

procedure TdxCustomFlowChart.NeedRepaint;
begin
  FRepaint := True;
  if CanPaint then
    Invalidate;
end;

procedure TdxCustomFlowChart.NeedRepaintObject(AItem: TdxFcItem);
begin
  FRepaint := True;
  if CanPaint then
    InvalidateRect(AItem.SelectionRect, True);
end;

procedure TdxCustomFlowChart.BeginUpdate;
begin
  if FLockUpdates = 0 then
    FRepaint := False;
  Inc(FLockUpdates);
end;

procedure TdxCustomFlowChart.CancelUpdate;
begin
  if FLockUpdates <> 0 then
    Dec(FLockUpdates);
end;

procedure TdxCustomFlowChart.EndUpdate;
begin
  if FLockUpdates > 0 then
  begin
    Dec(FLockUpdates);
    if FLockUpdates = 0 then
    begin
      if FRepaint then
        NeedRepaint;
      SetChartSizes;
    end;
  end;
end;

procedure TdxCustomFlowChart.Invalidate;
begin
  if FLockUpdates > 0 then
    FRepaint := True
  else
    inherited Invalidate;
end;

procedure TdxCustomFlowChart.InvalidateSel;
var
  I: Integer;
begin
  for I := 0 to SelectedObjectCount - 1 do
    NeedRepaintObject(SelectedObjects[I]);
  for I := 0 to SelectedConnectionCount - 1 do
    SelectedConnections[I].ConnectionChanged;
end;

function TdxCustomFlowChart.HasSelection: Boolean;
begin
  Result := Focused or not (fcoHideSelection in Options);
end;

procedure TdxCustomFlowChart.Paint;
var
  I: Integer;
begin
  inherited Paint;
  Canvas.FillRect(ClientBounds, BackgroundColor);
  for I := 0 to ConnectionCount - 1 do
    Connections[I].Paint(Canvas, False);
  for I := 0 to ObjectCount - 1 do
    Objects[I].Paint(Canvas);
  for I := 0 to ConnectionCount - 1 do
    Connections[I].Paint(Canvas, True);
  PaintSelection;
end;

procedure TdxCustomFlowChart.PaintSelection;

  procedure AddSelectedObject(AObject: TdxFcObject);
  var
    I: Integer;
    P: TdxFcSelectionPoints;
  begin
    AObject.SelPoints(P);
    for I := Low(P) to High(P) do
      FSelection.AddPoint(P[I]);
  end;

  procedure AddSelectedConnection(AConnection: TdxFcConnection);
  var
    I: Integer;
  begin
    for I := 0 to AConnection.RealCount - 1 do
      FSelection.AddPoint(AConnection.FRealPoints[I]);
  end;

var
  I: Integer;
begin
  FSelection.Clear;
  if HasSelection then
  begin
    for I := 0 to SelectedObjectCount - 1 do
      AddSelectedObject(SelectedObjects[I]);
    for I := 0 to SelectedConnectionCount - 1 do
      AddSelectedConnection(SelectedConnections[I]);
  end;
  FSelection.Paint;
end;

procedure TdxCustomFlowChart.DoDrawObject(AObject: TdxFcObject; R: TRect);
begin
  if Assigned(OnDrawObject) then
    OnDrawObject(Self, AObject, R)
  else
    DefaultDrawObject(AObject, R);
end;

procedure TdxCustomFlowChart.DefaultDrawObject(AObject: TdxFcObject; R: TRect);
begin
  if AObject.HasImage then
    AObject.PaintImage(R);
  if AObject.Text <> '' then
    AObject.PaintText(R);
end;

procedure TdxCustomFlowChart.InitScrollBarsParameters;

  function DoSetScrollBarInfo(AKind: TScrollBarKind; APage, AMin, ASize: Integer): Integer;
  var
    AScrollBar: TcxScrollBar;
  begin
    if AKind = sbHorizontal then
      AScrollBar := HScrollBar
    else
      AScrollBar := VScrollBar;

    if AScrollBar <> nil then
      Result := AScrollBar.Position
    else
      Result := 0;

    if Zoom = 0 then
      APage := ASize + 1;

    SetScrollBarInfo(AKind, AMin, AMin + ASize, 1, APage, Result, True, True);
  end;

var
  ANewX, ANewY: Integer;
begin
  if HandleAllocated then
  begin
    ANewX := DoSetScrollBarInfo(sbHorizontal, ClientWidth, FChartLeft, FChartWidth);
    ANewY := DoSetScrollBarInfo(sbVertical, ClientHeight, FChartTop, FChartHeight);
    SetLeftTop(ANewX, ANewY);
  end;
end;

procedure TdxCustomFlowChart.SetLeftTop(ALeft, ATop: Integer);

  procedure Adjust(AMin, AMax: Integer; var AValue: Integer);
  begin
    AValue := Max(Min(AValue, AMax), AMin);
  end;
  
begin
  Adjust(FChartLeft, FChartLeft + FChartWidth - ClientWidth, ALeft);
  Adjust(FChartTop, FChartTop + FChartHeight - ClientHeight, ATop);
  if (ALeft <> LeftEdge) or (ATop <> TopEdge) then
  begin
    FTopEdge := ATop;
    FLeftEdge := ALeft;
    if HandleAllocated then
    begin
      if HScrollBar <> nil then
        HScrollBar.Position := ALeft;
      if VScrollBar <> nil then
        VScrollBar.Position := ATop;
      Invalidate;
      Update;
    end;
  end;
end;

procedure TdxCustomFlowChart.SetChartSizes;
begin
  if (FLockUpdates = 0) and not IsDestroying then
    CalculateChartSizes;
end;

procedure TdxCustomFlowChart.SetLeftEdge(Value: Integer);
begin
  if Value <> LeftEdge then
    SetLeftTop(Value, TopEdge);
end;

procedure TdxCustomFlowChart.SetTopEdge(Value: Integer);
begin
  if Value <> TopEdge then
    SetLeftTop(LeftEdge, Value);
end;

procedure TdxCustomFlowChart.HitTest(X, Y: Integer);
const
  ConnectionHitTest: TdxFcHitTest = [htOnConnection, htOnConLabel, htOnArrowSrc, htOnArrowDst];

  function IsInPoint(const ACursorPoint, P: TPoint): Boolean;
  begin
    Result := (ACursorPoint.X >= P.X - 2) and (ACursorPoint.X <= P.X + 2) and
      (ACursorPoint.Y >= P.Y - 2) and (ACursorPoint.Y <= P.Y + 2);
    if Result then
      Include(FHitTest, htOnSelPoint);
  end;

  function BySel(Item: TdxFcItem; const P: TPoint): Boolean;
  begin
    Result := (Item <> nil) and PtInRect(Item.SelectionRect, ScrollPoint(P, False));
  end;

  procedure CalculateObjectsHitTest(const P: TPoint);
  var
    AHitTest: TdxFcHitTest;
    I: Integer;
  begin
    FObjectAt := nil;
    for I := ObjectCount - 1 downto 0 do
    begin
      AHitTest := Objects[I].HitTest(P);
      if htByObject in AHitTest then
      begin
        if FHitTest = [htNowhere] then
        begin
          FHitTest := [htByObject];
          FObjectAt := Objects[I];
        end;
        if htOnObject in AHitTest then
        begin
          FHitTest := [htByObject, htOnObject];
          FObjectAt := Objects[I];
          Break;
        end;
      end;
    end;
  end;

  procedure CalculateConnectionsHitTest(const P: TPoint);

    function DoArrowHitTest(AArrow: TdxFcConnectionArrow): Boolean;
    begin
      if AArrow.ArrowType = fcaNone then
        Result := False
      else
        Result := PtInRect(AArrow.DisplayRect(False), ScrollPoint(P));
    end;

  var
    I: Integer;
  begin
    FConnectionAt := nil;
    for I := ConnectionCount - 1 downto 0 do
    begin
      if PtInRect(Connections[I].SelectionRect, P) then
      begin
        FConnectionAt := Connections[I];
        if FHitTest = [htNowhere] then FHitTest := [];
        if FConnectionAt.HasPoint(ScrollPoint(P)) then
          Include(FHitTest, htOnConnection);
        if DoArrowHitTest(FConnectionAt.ArrowSource) then
          Include(FHitTest, htOnArrowSrc);
        if DoArrowHitTest(FConnectionAt.ArrowDest) then
          Include(FHitTest, htOnArrowDst);
        if FConnectionAt.Text <> '' then
        begin
          if PtInRect(FConnectionAt.RealTextRect, P) then
            Include(FHitTest, htOnConLabel);
        end;
        if FHitTest * ConnectionHitTest <> [] then
          Break;
      end;
    end;
  end;

var
  ASelection: TdxFcSelectionPoints;
  I, Q: Integer;
  P: TPoint;
begin
  if (FHitTest <> []) and (X = FHitX) and (Y = FHitY) then Exit;

  FHitX := X;
  FHitY := Y;
  FHitTest := [htNowhere];
  P := Point(X, Y);

  CalculateObjectsHitTest(P);
  CalculateConnectionsHitTest(P);

  if (htOnObject in FHitTest) and (FHitTest * ConnectionHitTest <> []) then
  begin
    if FConnectionAt.Transparent then
      FHitTest := FHitTest - ConnectionHitTest
    else
      Exclude(FHitTest, htOnObject);
  end;
  P := ScrollPoint(P);
  if BySel(SelectedObject, P) then
  begin
    SelectedObject.SelPoints(ASelection);
    Q := SelectedObject.Quadrant(P.X, P.Y) shl 1 + 1;
    for I := Q to Q + 2 do
      if IsInPoint(P, ASelection[I and 7]) then
      begin
        if FObjectAt <> SelectedObject then
          Exclude(FHitTest, htOnObject);
        FObjectAt := SelectedObject;
        Exit;
      end;
  end;

  if BySel(SelectedConnection, P) then
  begin
    for I := 0 to SelectedConnection.RealCount - 1 do
    begin
      if IsInPoint(P, SelectedConnection.FRealPoints[I]) then
      begin
        if FConnectionAt <> SelectedConnection then
          FHitTest := FHitTest - ConnectionHitTest;
        Include(FHitTest, htOnConnection);
        FConnectionAt := SelectedConnection;
      end;
    end;
  end;

  if FHitTest = [] then
  begin
    FHitTest := [htNowhere];
    FConnectionAt := nil;
  end;
end;

function TdxCustomFlowChart.GetConnectionAt(X, Y: Integer): TdxFcConnection;
begin
  HitTest(X, Y);
  Result := FConnectionAt;
end;

function TdxCustomFlowChart.GetObjectAt(X, Y: Integer): TdxFcObject;
begin
  HitTest(X, Y);
  Result := FObjectAt;
end;

function TdxCustomFlowChart.GetHitTestAt(X, Y: Integer): TdxFcHitTest;
begin
  HitTest(X, Y);
  Result := FHitTest;
end;

function TdxCustomFlowChart.TmpSel: Integer;
var
  I: Integer;
  Opt: TdxFcOptions;
  Sel1: TdxFcEvent;
  Sel2: TdxFcAllowEvent;
begin
  Result := SelectedObjectCount;
  if Result = 0 then Exit;
  Opt := Options; FOptions := Opt + [fcoCanSelect, fcoMultiSelect];
  Sel1 := OnSelected; OnSelected := nil;
  Sel2 := OnSelection; OnSelection := nil;
  Inc(FLockUpdates);
  for I := 0 to Result - 1 do
    SelectedObjects[I].SelectUnion;
  Dec(FLockUpdates); FOptions := Opt;
  OnSelected := Sel1; OnSelection := Sel2;
end;

procedure TdxCustomFlowChart.RestoreSel(Value: Integer);
var
  I: Integer;
begin
  for I := Value to SelectedObjectCount - 1 do
    SelectedObjects[I].FSelected := False;
  FSelObjects.Count := Value;
end;

procedure TdxCustomFlowChart.MoveObjects(DX, DY: Integer);

  function IsSel(AObject: TdxFcObject): Boolean;
  begin
    Result := (AObject <> nil) and AObject.Selected;
  end;

var
  I, EndSel: Integer;
  P: TPoint;
begin
  if (DX or DY = 0) or (SelectedObjectCount = 0) then Exit;
  P.X := DX; P.Y := DY;
  ScalePoint(P);
  EndSel := TmpSel;
  for I := 0 to SelectedObjectCount - 1 do
  begin
    NeedRepaintObject(SelectedObjects[I]);
    with SelectedObjects[I] do
    begin
      Inc(FLeft, DX);
      Inc(FTop, DY);
      CalculateRealBounds;
      Changed;
    end;
    NeedRepaintObject(SelectedObjects[I]);
  end;
  for I := 0 to ConnectionCount - 1 do
    with Connections[I] do
      if IsSel(ObjectSource) or IsSel(ObjectDest) then
      begin
        ConnectionChanged;
        if IsSel(ObjectSource) and IsSel(ObjectDest) then
        begin
          FPoints.OffsetPoints(DX, DY);
          FRealPoints.OffsetPoints(P.X, P.Y);
        end;
        SetObjectPoints;
        CalculateDisplayRect;
        Changed;
      end;
  RestoreSel(EndSel);
  SetChartSizes;
end;

procedure TdxCustomFlowChart.KeyDown(var Key: Word; Shift: TShiftState);
  procedure Resize(DX, DY: Integer);
  var
    W, H: Integer;
  begin
    if SelectedObject = nil then Exit;
    if RealZoom < 100 then
    begin
      DX := MulDiv(DX, 100, RealZoom);
      DY := MulDiv(DY, 100, RealZoom);
    end;
    with SelectedObject do
    begin
      W := Width + DX;
      H := Height + DY;
      if (W > 0) and (H > 0) then SetBounds(Left, Top, W, H);
      MakeVisible;
    end;
  end;
  procedure SelNext(Mode: Integer);
  var
    I, DX, DY, Rate, Min: Integer; Obj: TdxFcObject;
  begin
    if SelectedObject = nil then Exit;
    Obj := nil; Min := $20000000;
    for I := 0 to ObjectCount - 1 do
    begin
      if Objects[I].Selected or not Objects[I].Visible then Continue;
      DX := Objects[I].Left - SelectedObject.Left;
      DY := Objects[I].Top - SelectedObject.Top;
      if Mode > 1 then Swap(DX, DY);
      if Mode and 1 <> 0 then DX := -DX;
      Rate := Abs(DX) + Abs(DY) shl 3 + DX shr 2;
      if Rate < Min then
      begin
        Min := Rate;
        Obj := Objects[I];
      end;
    end;
    if Obj <> nil then
    begin
      ClearSelection;
      Obj.Selected := True;
      if Obj.Selected then Obj.MakeVisible;
    end;
  end;
begin
  if DragHelper.Dragging then Exit;
  inherited KeyDown(Key, Shift);
  if (Shift = [ssShift]) and (fcoCanDrag in Options) then
    case Key of
      VK_RIGHT: Resize(1, 0);
      VK_LEFT: Resize(-1, 0);
      VK_DOWN: Resize(0, 1);
      VK_UP: Resize(0, -1);
      VK_NEXT: Resize(1, 1);
      VK_PRIOR: Resize(1, -1);
      VK_HOME: Resize(-1, -1);
      VK_END: Resize(-1, 1);
    end;
  if (Shift = [ssAlt]) and (fcoCanDrag in Options) then
    case Key of
      VK_RIGHT: MoveObjects(1, 0);
      VK_LEFT: MoveObjects(-1, 0);
      VK_DOWN: MoveObjects(0, 1);
      VK_UP: MoveObjects(0, -1);
      VK_NEXT: MoveObjects(1, 1);
      VK_PRIOR: MoveObjects(1, -1);
      VK_HOME: MoveObjects(-1, -1);
      VK_END: MoveObjects(-1, 1);
    end;
  if Shift = [ssCtrl] then
    case Key of
      VK_RIGHT: LeftEdge := LeftEdge + ClientWidth - 16;
      VK_LEFT: LeftEdge := LeftEdge - ClientWidth + 16;
      VK_PRIOR: TopEdge := TO_HOME;
      VK_NEXT: TopEdge := TO_END;
      VK_HOME: SetLeftTop(TO_HOME, TO_HOME);
      VK_END: SetLeftTop(TO_END, TO_END);
    end;
  if Shift = [] then
    case Key of
      VK_DELETE:
        if fcoCanDelete in Options then DeleteSelection;
      VK_NEXT: TopEdge := TopEdge + ClientHeight - 16;
      VK_PRIOR: TopEdge := TopEdge - ClientHeight + 16;
      VK_HOME: LeftEdge := TO_HOME;
      VK_END: LeftEdge := TO_END;
      VK_RIGHT: SelNext(0);
      VK_LEFT: SelNext(1);
      VK_DOWN: SelNext(2);
      VK_UP: SelNext(3);
    end;
end;

procedure TdxCustomFlowChart.LookAndFeelChanged(
  Sender: TcxLookAndFeel; AChangedValues: TcxLookAndFeelValues);
begin
  inherited LookAndFeelChanged(Sender, AChangedValues);
  if HandleAllocated then
    Invalidate;
end;

procedure TdxCustomFlowChart.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
  if not (ssDouble in Shift) then
    SetCapture(Handle);
  if (Button = mbLeft) and (Shift * [ssCtrl, ssAlt] = []) then
  begin
    HitTest(X, Y);
    FDragStartPoint := Point(X, Y);
    if htOnSelPoint in FHitTest then
      DragHelper.CheckDragStart(X, Y, Shift, FHitTest);
    if DragHelper.Dragging then
      Exit;
    if (htOnObject in FHitTest) and FObjectAt.Selected and not (ssShift in Shift) then
      FObjectAt.SelectUnion
    else
      if FHitTest * [htOnObject, htOnConnection, htOnConLabel, htOnArrowSrc, htOnArrowDst] <> [] then
      begin
        if not (ssShift in Shift) then
          ClearSelection;
        if htOnObject in FHitTest then
          FObjectAt.Selected := not FObjectAt.Selected
        else
          FConnectionAt.Selected := not FConnectionAt.Selected;
      end
      else
        ClearSelection;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TdxCustomFlowChart.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if GetCapture = Handle then
  begin
    if DragHelper.Dragging then
      DragHelper.DragMove(X, Y)
    else
      if Focused and (ssLeft in Shift) and (Abs(X - FDragStartPoint.X) + Abs(Y - FDragStartPoint.Y) > 4) then
        DragHelper.CheckDragStart(X, Y, Shift, FHitTest);
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure TdxCustomFlowChart.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if GetCapture = Handle then
    ReleaseCapture;
  DragHelper.DragStop(X, Y);
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TdxCustomFlowChart.AbortDrag;
begin
  if DragHelper.Dragging then
  begin
    with CalcCursorPos do
      MouseUp(mbLeft, [], X, Y);
  end;
end;

procedure TdxCustomFlowChart.LoadFromStream(Stream: TStream);

  function GetIsUnicodeFormat(AStream: TStream): Boolean;
  var
    B: array[0..6] of AnsiChar;
  begin
    Result := False;
    if (Stream.Size - Stream.Position) > SizeOf(B) then
    begin
      Stream.ReadBuffer(B, SizeOf(B));
      Result := B = StreamDescriptionUNICODE;
      if not Result and (B <> StreamDescriptionANSI) then
        Stream.Position := Stream.Position - SizeOf(B);
    end;
  end;

  procedure LoadObjects(AStream: TStream; AIsUnicode: Boolean);
  var
    ACount, I: Integer;
  begin
    ACount := 0;
    Stream.ReadBuffer(ACount, SizeOf(Word));
    while ACount > 0 do
    begin
      InternalCreateObject.Load(AStream, AIsUnicode);
      Dec(ACount);
    end;
    for I := 0 to ObjectCount - 1 do
      Objects[I].ResolveObjRefs;
  end;

  procedure LoadConnections(AStream: TStream; AIsUnicode: Boolean);
  var
    ACount: Integer;
  begin
    ACount := 0;
    Stream.ReadBuffer(ACount, SizeOf(Word));
    while ACount > 0 do
    begin
      InternalCreateConnection.Load(AStream, AIsUnicode);
      Dec(ACount);
    end;
  end;

var
  AIsUnicode: Boolean;
begin
  BeginUpdate;
  try
    AIsUnicode := GetIsUnicodeFormat(Stream);
    FLoading := True;
    try
      Clear;
      LoadObjects(Stream, AIsUnicode);
      LoadConnections(Stream, AIsUnicode);
    finally
      FLoading := False;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TdxCustomFlowChart.SaveToStream(Stream: TStream);
var
  I: Integer;
begin
  I := ObjectCount;
{$IFNDEF STREAMANSIFORMAT}
  {$IFDEF DELPHI12}
      Stream.WriteBuffer(StreamDescriptionUNICODE[1], StrLen(PAnsiChar(StreamDescriptionUNICODE)));
  {$ELSE}
      Stream.WriteBuffer(StreamDescriptionANSI[1], Length(StreamDescriptionANSI));
  {$ENDIF}
{$ENDIF}
  Stream.WriteBuffer(I, SizeOf(Word));
  for I := 0 to ObjectCount - 1 do
    Objects[I].Save(Stream);
  I := ConnectionCount;
  Stream.WriteBuffer(I, SizeOf(Word));
  for I := 0 to ConnectionCount - 1 do
    Connections[I].Save(Stream);
end;

procedure TdxCustomFlowChart.LoadFromFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(S);
  finally
    S.Free;
  end;
end;

procedure TdxCustomFlowChart.SaveToFile(const FileName: string);
var
  S: TStream;
begin
  S := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(S);
  finally
    S.Free;
  end;
end;

procedure TdxCustomFlowChart.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Items', LoadFromStream, SaveToStream, ObjectCount > 0);
end;

function TdxCustomFlowChart.CreatePainter: TdxFlowChartPainter;
begin
  if Antialiasing and CheckGdiPlus then
    Result := TdxFlowChartGDIPlusPainter.Create
  else
    Result := TdxFlowChartPainter.Create;
end;

function TdxCustomFlowChart.CanSelect(Item: TdxFcItem): Boolean;
begin
  Result := fcoCanSelect in Options;
  if Assigned(OnSelection) then OnSelection(Self, Item, Result);
end;

procedure TdxCustomFlowChart.BoundsChanged;
begin
  inherited BoundsChanged;
  CalculateRealZoomFactor;
end;

procedure TdxCustomFlowChart.CalculateRealZoomFactor;
var
  APrevZoom: Word;
  W, H: Integer;
begin
  APrevZoom := FRealZoom;
  if Zoom <> 0 then
    FRealZoom := Zoom
  else
  begin
    W := MulDiv(FChartWidth, 100, RealZoom);
    H := MulDiv(FChartHeight, 100, RealZoom);
    if ClientWidth * H <= ClientHeight * W then
      FRealZoom := MulDiv(ClientWidth, 95, W)
    else
      FRealZoom := MulDiv(ClientHeight, 95, H);
    FRealZoom := Max(1, Min(FRealZoom, 100));
  end;
  if APrevZoom <> FRealZoom then
  begin
    CalculateRealPos;
    CalculateChartSizes;
  end;
end;

procedure TdxCustomFlowChart.Changed(Item: TdxFcItem);
begin
  if Assigned(OnChange) then OnChange(Self, Item);
end;

procedure TdxCustomFlowChart.Delete(Item: TdxFcItem);
begin
  AbortDrag;
  Item.Invalidate;
  if Item.Selected then
  begin
    Item.SelList.Remove(Item);
    Item.FSelected := False;
    Select(Item);
  end;
  if Assigned(OnDeletion) then OnDeletion(Self, Item);
  Item.FDestroying := True;
  FHitTest := [];
end;

procedure TdxCustomFlowChart.Scroll(AScrollBarKind: TScrollBarKind;
  AScrollCode: TScrollCode; var AScrollPos: Integer);

  function DoScroll(ACode: TScrollCode; AValue, APage: Integer): Integer;
  const
    LineSize = 16;
  begin
    case ACode of
      scLineDown:
        Inc(AValue, LineSize);
      scLineUp:
        Dec(AValue, LineSize);
      scPageDown:
        Inc(AValue, APage - LineSize);
      scPageUp:
        Dec(AValue, APage - LineSize);
      scTop:
        AValue := TO_HOME;
      scBottom:
        AValue := TO_END;
      scPosition, scTrack:
        AValue := AScrollPos;
    end;
    Result := AValue;
  end;

begin
  if AScrollBarKind = sbHorizontal then
  begin
    SetLeftEdge(DoScroll(AScrollCode, LeftEdge, ClientWidth));
    AScrollPos := LeftEdge;
  end
  else
  begin
    SetTopEdge(DoScroll(AScrollCode, TopEdge, ClientHeight));
    AScrollPos := TopEdge;
  end;
end;

procedure TdxCustomFlowChart.Select(Item: TdxFcItem);
begin
  if Assigned(OnSelected) then OnSelected(Self, Item);
end;

procedure TdxCustomFlowChart.WndProc(var Message: TMessage);
begin
  if (Message.Msg >= WM_KEYFIRST) and (Message.Msg <= WM_KEYLAST) then
  begin
    if DragHelper.Dragging then
      Exit;
  end;
  inherited WndProc(Message);
end;

procedure TdxCustomFlowChart.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if fcoHideSelection in Options then InvalidateSel;
end;

procedure TdxCustomFlowChart.WMKillFocus(var Msg: TWMKillFocus);
begin
  if GetCapture = Handle then
    ReleaseCapture; // Fix: by Kirill
  AbortDrag;
  WMSetFocus(TWMSetFocus(Msg));
end;

procedure TdxCustomFlowChart.WMSetCursor(var Message: TWMSetCursor);
const
  Cursors: array[0..3] of TCursor = (crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE);
var
  pt: TPoint;
begin
  GetCursorPos(pt);
  pt := ScreenToClient(pt);
  HitTest(pt.X, pt.Y);
  if htOnSelPoint in FHitTest then
  begin
    if(FObjectAt <> nil) and (FObjectAt = SelectedObject) then
      Windows.SetCursor(Screen.Cursors[Cursors[FObjectAt.GetSelPoint(pt.X, pt.Y) and 3]])
    else
      Windows.SetCursor(Screen.Cursors[crSize]);
  end
  else
    inherited;
end;

procedure TdxCustomFlowChart.WMErase(var Msg: TWMEraseBkgnd);
begin
  Msg.Result := 1;
end;

procedure TdxCustomFlowChart.WMGetDlgCode(var Msg: TWMGetDlgCode);
begin
  inherited;
  Msg.Result := Msg.Result or DLGC_WANTARROWS;
end;

procedure TdxCustomFlowChart.WMPaint(var Msg: TWMPaint);
begin
  if not (DragHelper.Dragging and DragHelper.PaintLocked) then
    inherited;
end;

procedure TdxCustomFlowChart.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  DefaultHandler(Msg);
  if (csDesigning in ComponentState) and not (Msg.Result in [HTHSCROLL, HTVSCROLL])
    then Msg.Result := HTCLIENT;
end;

procedure TdxCustomFlowChart.CMCtl3DChanged(var Msg: TMessage);
begin
  inherited;
  if BorderStyle = bsSingle then RecreateWnd;
end;

procedure TdxCustomFlowChart.CMFontChanged(var Msg: TMessage);
  procedure ResetFont(Item: TdxFcItem);
  begin
    if Item.ParentFont then
      with Item do
      begin
        Font.Assign(Self.Font);
        FParentFont := True;
      end;
  end;
var
  I: Integer;
begin
  BeginUpdate;
  for I := 0 to ObjectCount - 1 do
    ResetFont(Objects[I]);
  for I := 0 to ConnectionCount - 1 do
    ResetFont(Connections[I]);
  EndUpdate;
end;

end.

