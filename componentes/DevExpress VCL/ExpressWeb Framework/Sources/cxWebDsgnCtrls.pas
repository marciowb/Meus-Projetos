{*******************************************************************}
{                                                                   }
{       ExpressWeb Framework by Developer Express                   }
{       Designer Module                                             }
{                                                                   }
{       Copyright (c) 2000-2010 Developer Express Inc.              }
{       ALL RIGHTS RESERVED                                         }
{                                                                   }
{   The entire contents of this file is protected by U.S. and       }
{   International Copyright Laws. Unauthorized reproduction,        }
{   reverse-engineering, and distribution of all or any portion of  }
{   the code contained in this file is strictly prohibited and may  }
{   result in severe cb levfnmivil and criminal penalties and will  }
{   be prosecuted to the maximum extent possible under the law.     }
{                                                                   }
{   RESTRICTIONS                                                    }
{                                                                   }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES           }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE    }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS   }
{   LICENSED TO DISTRIBUTE THE EXPRESSWEB FRAMEWORK AND ALL         }
{   ACCOMPANYING VCL CLASSES AS PART OF AN EXECUTABLE WEB           }
{   APPLICATION ONLY.                                               }
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
unit cxWebDsgnCtrls;

{$I cxVer.inc}

interface

uses Classes,
  {$IFDEF VCL}
  Forms, ExtCtrls, Windows, Controls, Messages, Graphics, StdCtrls,
  {$ELSE}
  QForms, QExtCtrls, Qt, Types, QControls, QGraphics, QStdCtrls,
  {$ENDIF}
  cxWebIntf, cxWebDsgnIntf, cxWebDsgnIntfImpl, cxCustomData, cxWebTypes,
  cxWebModule, cxWebClasses, cxWebGraphics, cxWebControls, cxWebStdCtrls,
  cxWebDataCtrls, cxWebGrids, cxWebDataNavigator, cxWebTV, cxWebMenus,
  cxWebMainMenu, cxWebCalendar, cxWebDateEdit, cxWebTable, cxWebDBLookup,
  cxWebNavBar;

type
  TcxWebDesignControlClass = class of TcxWebDesignControl;
  TcxWebDesignControl = class(TCustomControl, IInterface, IcxWebDesignerControl,
        IcxWebDesignerControlNotify, IcxWebDesignerControlUpdatePosition,
        IcxWebDesignerControlRepaint)
  private
    FIsBgPainting: Boolean;
    FBuffBitmap: TBitmap;
    FDesignerControlHelper: TcxWebDesignerControlHelper;
    FOnUpdateConstrolPosition: TUpdateConstrolPositionEvent;
    FRefCount: Integer;
    FDefaultWebStyle: TcxWebStyle;
    FControlWebStyle: TcxWebStyle;

    function GetControlWebStyle: TcxWebStyle;
    function IsTransparent: Boolean;
    {$IFDEF VCL}
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    {$ENDIF}
  protected
    {$IFDEF VCL}
    procedure CreateWnd; override;
    {$ELSE}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    {$ENDIF}
    procedure Paint; override;
    procedure DrawBorder(var R: TRect); virtual;
    procedure DrawBackground; virtual;
    procedure DrawFace; virtual;
    procedure DrawInterior(var R: TRect); virtual;

    function GetDrawStyle(AStyleItem: TcxWebStyleItem; ADefStyle: TcxWebStyle): TcxWebStyle;
    function GetMainControlStyles: TcxWebStyles; virtual;
    function GetInternalWebControl: TcxWebControl; overload; virtual;
    procedure SetOnUpdateConstrolPosition(Value: TUpdateConstrolPositionEvent);

    { IInterface }
    function IInterface.QueryInterface = _QueryInterface;
    function _QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IcxWebDesignerControlRepaint }
    procedure RepaintControl;

    procedure DefineDefaultWebStyle; virtual;
    property DesignerControlHelper: TcxWebDesignerControlHelper
        read FDesignerControlHelper implements IcxWebDesignerControl, IcxWebDesignerControlNotify;
    property DefaultWebStyle: TcxWebStyle read FDefaultWebStyle;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property ControlWebStyle: TcxWebStyle read GetControlWebStyle;
    property WebControl: TcxWebControl read GetInternalWebControl;
  end;

  TcxWebDesignCustomControl = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebCustomControl; reintroduce; overload;
  end;

  TcxWebDesignLabel = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebLabel; reintroduce; overload;
  public
    property WebLabel: TcxCustomWebLabel read GetInternalWebControl;
  end;

  TcxWebDesignButton = class(TcxWebDesignControl)
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebButton; reintroduce; overload;
  public
    property WebButton: TcxWebButton read GetInternalWebControl;
  end;

  TcxWebDesignEditControl = class(TcxWebDesignControl)
  protected
    function GetControlText: string; virtual;
    procedure DefineDefaultWebStyle; override;
  end;

  TcxWebDesignScrollControl = class(TcxWebDesignEditControl)
  private
    FScrollBar: TScrollBar;
    FPrevRect: TRect;
    procedure UpdateScrollBar(R: TRect);
  protected
    function ShowScrollBar: Boolean; virtual;
    procedure DrawInterior(var R: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TcxWebDesignEdit = class(TcxWebDesignEditControl)
  protected
    function GetControlText: string; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebEdit; reintroduce; overload;
  public
    property WebEdit: TcxCustomWebEdit read GetInternalWebControl;
  end;

  TcxWebDesignMemo = class(TcxWebDesignScrollControl)
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebMemo; reintroduce; overload;
  public
    property WebMemo: TcxCustomWebMemo read GetInternalWebControl;
  end;

  TcxWebDesignListBox = class(TcxWebDesignScrollControl)
  protected
    function ShowScrollBar: Boolean; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebListBox; reintroduce; overload;
  public
    property WebListBox: TcxCustomWebListBox read GetInternalWebControl;
  end;

  TcxWebDesignComboBox = class(TcxWebDesignEditControl)
  protected
    function GetControlText: string; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebComboBox; reintroduce; overload;
  public
    property WebComboBox: TcxCustomWebComboBox read GetInternalWebControl;
  end;

  TcxWebDesignCheckBox = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebCheckBox; reintroduce; overload;
  public
    property WebCheckBox: TcxCustomWebCheckBox read GetInternalWebControl;
  end;

  TcxWebDesignRadioGroup = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebRadioGroup; reintroduce; overload;
  public
    property WebRadioGroup: TcxCustomWebRadioGroup read GetInternalWebControl;
  end;

  TcxWebDesignImage = class(TcxWebDesignControl)
  protected
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebImage; reintroduce; overload;
  public
    property WebImage: TcxCustomWebImage read GetInternalWebControl;
  end;

  TcxWebDesignCustomGrid = class(TcxWebDesignControl)
  private
    FBitmaps: array[TcxWebGridButtons] of TBitmap;
    FGroupDefStyle: TcxWebStyle;
    FHeaderDefStyle: TcxWebStyle;
    FIndDefStyle: TcxWebStyle;
    FStatusDefStyle: TcxWebStyle;
    FGroupNodeDefStyle: TcxWebStyle;
    FItemsDefStyle: TcxWebStyle;
    procedure LoadBitmaps;
    procedure FreeBitmaps;

    procedure DrawCell(var R: TRect; ARowIndex, AColIndex: Integer);
    procedure DrawHeaderCell(var R: TRect; AIndex, AMargin: Integer);
    procedure DrawGroupNode(R: TRect; ARowIndex: Integer);
    procedure DrawIndicator(var R: TRect; ABtn1, ABtn2: TcxWebGridButtons);
    procedure DrawHeader(var R: TRect);
    procedure DrawGroupPanel(var R: TRect);
    procedure DrawRow(AIndex: Integer; var R: Trect);
    procedure DrawStatusPanel(var R: TRect);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawBorder(var R: TRect); override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebGrid; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebGrid: TcxCustomWebGrid read GetInternalWebControl;
  end;

  TcxWebDesignDataNavigator = class(TcxWebDesignControl)
  private
    FBitmaps: array[TcxWebNavigatorButtonType] of TBitmap;
    FEdStyle: TcxWebStyle;
    procedure LoadBitmaps;
    procedure FreeBitmaps;
    procedure DrawButton(var XPos, YPos: Integer; Index: Integer);
    procedure DrawEdit(var XPos, YPos: Integer; Text: string);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawFace; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebDataNavigator; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebDataNavigator: TcxCustomWebDataNavigator read GetInternalWebControl;
  end;

  TcxWebDesignTreeView = class(TcxWebDesignControl)
  private
    procedure DrawItems(var R: TRect; AItem: TcxWebTreeItem);
  protected
    procedure DrawBorder(var R: TRect); override;
    procedure DefineDefaultWebStyle; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebTreeView; reintroduce; overload;
  public
    property WebTreeView: TcxWebTreeView read GetInternalWebControl;
  end;

  TcxWebDesignPanel = class(TcxWebDesignControl)
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawBorder(var R: TRect); override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebPanel; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    property Panel: TcxWebPanel read GetInternalWebControl;
  end;

  TcxWebDesignMainMenu = class(TcxWebDesignControl)
  private
    procedure DrawEmptyMenu(R: TRect);
    procedure DrawMenuItem(R: TRect; AItem: TcxWebMenuItem);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawBorder(var R: TRect); override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebMainMenu; reintroduce; overload;
  public
    property WebMainMenu: TcxWebMainMenu read GetInternalWebControl;
  end;

  TcxWebDesignCalendar = class(TcxWebDesignControl)
  private
    FDayHeaderDefStyle: TcxWebStyle;
    FOtherMonthDayDefStyle: TcxWebStyle;
    FSelectedDefStyle: TcxWebStyle;
    FTitleDefStyle: TcxWebStyle;
    FTodayPanelDefStyle: TcxWebStyle;
    procedure DrawFooter(var R: TRect);
    procedure DrawSheet(var R: TRect);
    procedure DrawHeader(var R: TRect);
    procedure DrawTitle(var R: TRect);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxCustomWebCalendar; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebCalendar: TcxCustomWebCalendar read GetInternalWebControl;
  end;

  TcxWebDesignDateEdit = class(TcxWebDesignEditControl)
  private
    FButtonImage: TBitmap;
    FButtonDefStyle: TcxWebStyle;
    procedure DrawButton(var R: TRect);
  protected
    function GetMainControlStyles: TcxWebStyles; override;
    procedure DefineDefaultWebStyle; override;
    procedure DrawFace; override;
    function GetControlText: string; override;
    function GetInternalWebControl: TcxCustomWebDateEdit; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebDateEdit: TcxCustomWebDateEdit read GetInternalWebControl;
  end;

  TcxAccessWebTable = class(TcxCustomWebTable);

  TcxWebDesignCustomTable = class(TcxWebDesignControl)
  private
    FPagingDefStyle: TcxWebStyle;
    FPagingNumDefStyle: TcxWebStyle;
    FItemsDefStyle: TcxWebStyle;
    FHeaderDefStyle: TcxWebStyle;
    function GetColumnWidth(AColumn: TcxCustomWebTableColumn): Integer;
    procedure DrawPaging(ARect: TRect);
    procedure DrawPagings(var ARect: TRect);
    procedure DrawHeader(var ARect: TRect);
    procedure DrawCell(Index: Integer; AStyle: TcxWebStyle;
      AAlignment: TcxWebHorzAlignment; Text: string; var ARect: TRect);
    procedure DrawItems(var ARect: TRect);
    procedure DrawRow(AIndex: Integer; var ARect: TRect);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxAccessWebTable; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Table: TcxAccessWebTable read GetInternalWebControl;
  end;

  TcxWebDesignExtDBLookup = class(TcxWebDesignEditControl)
  private
    FButtonImage: TBitmap;
    FButtonDefStyle: TcxWebStyle;
    procedure DrawButton(var R: TRect);
  protected
    function GetMainControlStyles: TcxWebStyles; override;
    procedure DefineDefaultWebStyle; override;
    procedure DrawFace; override;
    function GetControlText: string; override;
    function GetInternalWebControl: TcxWebExtDBLookup; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebExtDBLookup: TcxWebExtDBLookup read GetInternalWebControl;
  end;

  TcxWebDesignNavBar = class(TcxWebDesignControl)
  private
    FHeaderDefStyle: TcxWebStyle;
    FColHeaderDefStyle: TcxWebStyle;
    FLeftColImage, FLeftExpImage: TBitmap;
    FRightColImage, FRightExpImage: TBitmap;
    procedure DrawGroup(Index: Integer; var XPos, YPos: Integer);
    procedure DrawGroupHeader(Index: Integer; var XPos, YPos: Integer);
    procedure DrawGroupBody(Index: Integer; var XPos, YPos: Integer);
  protected
    procedure DefineDefaultWebStyle; override;
    procedure DrawFace; override;
    procedure DrawInterior(var R: TRect); override;
    function GetInternalWebControl: TcxWebNavBar; reintroduce; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property WebNavBar: TcxWebNavBar read GetInternalWebControl;
  end;

implementation

{$R cxWebNavImgs.res}
{$R cxWebGridImgs.res}

uses
  SysUtils, ToolsAPI, DateUtils,
  cxWebUtils, cxWebDsgnConsts, cxWebDsgnGraphics, cxWebColors, cxWebCtrlsFactory,
  Math, cxWebDsgnUtils, cxWebMetrics;

{ utilities }
type
  TCanvasAccess = class(TCanvas);
  TCustomControlAccess = class(TCustomControl);

  TcxTextHAlignment = (thaNone, thaLeft, thaRight, thaCenter);
  TcxTextVAlignment = (tvaNone, tvaTop, tvaBottom, tvaCenter);

  TcxBorderEdge = (cxbeLeft, cxbeTop, cxbeRight, cxbeBottom);
  TcxBorderEdges = set of TcxBorderEdge;

  PTrapezium = ^TTrapezium;
  TTrapezium = array[0..3] of TPoint;

  TcxAbstractStylePainter = class
  protected
    class function GetFirstColor(AColor: TColor; TopLeft: Boolean): TColor; virtual;
    class function GetSecondColor(AColor: TColor; TopLeft: Boolean): TColor; virtual;
    class function GetWidth(const R: TRect; AEdge: TcxBorderEdge): Integer;
    class function IsTopLeft(AEdge: TcxBorderEdge): Boolean;
    class function IsVertical(AEdge: TcxBorderEdge): Boolean;
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); virtual;
  end;

  TcxStylePainterClass = class of TcxAbstractStylePainter;

  TcxSolidStylePainter = class(TcxAbstractStylePainter)
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); override;
  end;

  TcxDottedStylePainter = class(TcxAbstractStylePainter)
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); override;
  end;

  TcxDashedStylePainter = class(TcxAbstractStylePainter)
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); override;
  end;

  TcxDoubleStylePainter = class(TcxAbstractStylePainter)
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); override;
  end;

  TcxGrooveStylePainter = class(TcxAbstractStylePainter)
  protected
    class function GetFirstColor(AColor: TColor; TopLeft: Boolean): TColor; override;
    class function GetSecondColor(AColor: TColor; TopLeft: Boolean): TColor; override;
  public
    class procedure PaintRect(ACanvas: TCanvas; R: TRect;
      ABaseColor: TColor; AEdge: TcxBorderEdge); override;
  end;

  TcxRidgeStylePainter = class(TcxGrooveStylePainter)
  protected
    class function GetFirstColor(AColor: TColor; TopLeft: Boolean): TColor; override;
    class function GetSecondColor(AColor: TColor; TopLeft: Boolean): TColor; override;
  end;

  TcxInsetStylePainter = class(TcxGrooveStylePainter)
  protected
    class function GetFirstColor(AColor: TColor; TopLeft: Boolean): TColor; override;
    class function GetSecondColor(AColor: TColor; TopLeft: Boolean): TColor; override;
  end;

  TcxOutsetStylePainter = class(TcxInsetStylePainter)
  protected
    class function GetFirstColor(AColor: TColor; TopLeft: Boolean): TColor; override;
    class function GetSecondColor(AColor: TColor; TopLeft: Boolean): TColor; override;
  end;

  TcxBaseBorderPainter = class
  private
    FPoints: TTrapezium;
    function GetPaintRect: TRect;
  protected
    procedure CalcTrapezium(OuterRect, InnerRect: TRect); virtual; abstract;
    function GetEdge: TcxBorderEdge; virtual; abstract;
  public
    procedure DrawBorderEdge(ACanvas: TCanvas; ABorder: TcxWebBorder);
    constructor Create(OuterRect, InnerRect: TRect);
  end;

  TcxTopBorderPainter = class(TcxBaseBorderPainter)
  protected
    procedure CalcTrapezium(OuterRect, InnerRect: TRect); override;
    function GetEdge: TcxBorderEdge; override;
  end;

  TcxLeftBorderPainter = class(TcxBaseBorderPainter)
  protected
    procedure CalcTrapezium(OuterRect, InnerRect: TRect); override;
    function GetEdge: TcxBorderEdge; override;
  end;

  TcxBottomBorderPainter = class(TcxBaseBorderPainter)
  protected
    procedure CalcTrapezium(OuterRect, InnerRect: TRect); override;
    function GetEdge: TcxBorderEdge; override;
  end;

  TcxRightBorderPainter = class(TcxBaseBorderPainter)
  protected
    procedure CalcTrapezium(OuterRect, InnerRect: TRect); override;
    function GetEdge: TcxBorderEdge; override;
  end;

const
  cxStylePainters: array[TcxWebBorderStyle] of TcxStylePainterClass =
    (nil, TcxSolidStylePainter, TcxDottedStylePainter, TcxDashedStylePainter,
     TcxDoubleStylePainter, TcxGrooveStylePainter, TcxRidgeStylePainter,
     TcxInsetStylePainter, TcxOutsetStylePainter);

var
  FCanvasBrush: TBrush;
  FCanvasCopyMode: TCopyMode;
  FCanvasFont: TFont;
  FCanvasPen: TPen;

procedure StoreCanvas(ACanvas: TCanvas);
begin
  with ACanvas do
  begin
    FCanvasBrush.Assign(Brush);
    FCanvasCopyMode := CopyMode;
    FCanvasFont.Assign(Font);
    FCanvasPen.Assign(Pen);
 end;
end;

procedure RestoreCanvas(ACanvas: TCanvas);
begin
  ACanvas.Lock;
  try
    ACanvas.Brush := FCanvasBrush;
    ACanvas.CopyMode := FCanvasCopyMode;
    ACanvas.Font := FCanvasFont;
    ACanvas.Pen := FCanvasPen;
  finally
    ACanvas.Unlock;
  end;
end;

{$IFNDEF VCL}
function GetRValue(Color: Integer): Byte;
begin
  Result := Byte(Color);
end;

function GetGValue(Color: Integer): Byte;
begin
  Result := Byte(Color shr 8);
end;

function GetBValue(Color: Integer): Byte;
begin
  Result := Byte(Color shr 16);
end;

function RGB(R, G, B: Byte): Integer;
begin
  Result := (R or (G shl 8) or (B shl 16));
end;

function ColorToRGB(Color: TColor): Longint;
var
  R, G, B: Byte;
begin
  Result := QGraphics.ColorToRGB(Color);
  if Color < 0 then
  begin
    R := GetRValue(Result);
    G := GetGValue(Result);
    B := GetBValue(Result);
    Result := RGB(B, G, R);
  end;
end;
{$ENDIF}

function cxGetShadowColor(AColor: TColor): TColor;
var
  RGBValue: Cardinal;
begin
  RGBValue := ColorToRGB(AColor);
  Result := RGB(GetRValue(RGBValue) div 4 * 3,
    GetGValue(RGBValue) div 4 * 3,
    GetBValue(RGBValue) div 4 * 3);
end;

function cxGetDarkColor(AColor: TColor): TColor;
var
  RGBValue: Cardinal;
begin
  RGBValue := ColorToRGB(AColor);
  Result := RGB(GetRValue(RGBValue) div 2,
    GetGValue(RGBValue) div 2,
    GetBValue(RGBValue) div 2);
end;

function cxGetDarkDarkColor(AColor: TColor): TColor;
begin
  Result := cxGetDarkColor(cxGetDarkColor(AColor));
end;

procedure DoTextRect(ACanvas: TCanvas; const ARect: TRect; const X, Y: Integer;
   const AText: string; const AHorzAlignment: TcxTextHAlignment = thaNone;
   const AVertAlignment: TcxTextVAlignment = tvaNone; AWordBreak: Boolean = False);
const
  {$IFDEF VCL}
  HAlignments: array[TcxTextHAlignment] of Integer =
    (0, DT_LEFT, DT_RIGHT, DT_CENTER);
  VAlignments: array[TcxTextVAlignment] of Integer =
    (0, DT_TOP, DT_BOTTOM, DT_VCENTER);
  {$ELSE}
  HAlignments: array[TcxTextHAlignment] of Integer =
    (0, Ord(AlignmentFlags_AlignLeft), Ord(AlignmentFlags_AlignRight), Ord(AlignmentFlags_AlignHCenter));
  VAlignments: array[TcxTextVAlignment] of Integer =
    (0, Ord(AlignmentFlags_AlignTop), Ord(AlignmentFlags_AlignBottom), Ord(AlignmentFlags_AlignVCenter));
  {$ENDIF}
var
  Flags: Integer;
{$IFDEF VCL}
  R: TRect;
{$ENDIF}
begin
  Flags := HAlignments[AHorzAlignment] or VAlignments[AVertAlignment];
  if AVertAlignment <> tvaNone then
    Flags := Flags or {$IFDEF VCL}DT_SINGLELINE{$ELSE}Ord(AlignmentFlags_SingleLine){$ENDIF};
  if AWordBreak then
    Flags := Flags or {$IFDEF VCL}DT_WORDBREAK{$ELSE}Ord(AlignmentFlags_WordBreak){$ENDIF};
  {$IFDEF VCL}
  R.Left := X;
  R.Top := Y;
  R.Right := ARect.Right;
  R.Bottom := ARect.Bottom;
  DrawText(ACanvas.Handle, PChar(AText), Length(AText), R, Flags);
  {$ELSE}
  ACanvas.TextRect(ARect, X, Y, AText, Flags);
  {$ENDIF}
end;

procedure DrawFrame(ACanvas: TCanvas; AColor: TColor; var R: TRect);
begin
  StoreCanvas(ACanvas);
  try
    with ACanvas do
    begin
      Pen.Style := psSolid;
      Pen.Color := AColor;
      Brush.Style := bsClear;
      Rectangle(R);
    end;
    InflateRect(R, -1, -1);
  finally
    RestoreCanvas(ACanvas);
  end;
end;

function CalcStylishTextExtent(ACanvas: TCanvas; AStyle: TcxWebStyle; const AText: string): TSize;
var
  SaveFont: TFont;
begin
  SaveFont := TFont.Create;
  try
    SaveFont.Assign(ACanvas.Font);
    try
      if AStyle <> nil then
        WebFontToFont(AStyle.Font, ACanvas.Font);
      Result := ACanvas.TextExtent(AText);
    finally
      ACanvas.Font := SaveFont;
    end;
  finally
    SaveFont.Free;
  end;
end;

{ TcxBaseBorderPainter }

constructor TcxBaseBorderPainter.Create(OuterRect, InnerRect: TRect);
begin
  inherited Create;
  CalcTrapezium(OuterRect, InnerRect);
end;

function TcxBaseBorderPainter.GetPaintRect: TRect;

  function Min(const Data: array of Integer): Integer;
  var
    I: Integer;
  begin
    Result := Data[Low(Data)];
    for I := Low(Data) + 1 to High(Data) do
      if Result > Data[I] then
        Result := Data[I];
  end;

  function Max(const Data: array of Integer): Integer;
  var
    I: Integer;
  begin
    Result := Data[Low(Data)];
    for I := Low(Data) + 1 to High(Data) do
      if Result < Data[I] then
        Result := Data[I];
  end;

begin
  Result.Left := Min([FPoints[0].X, FPoints[1].X, FPoints[2].X, FPoints[3].X]);
  Result.Top := Min([FPoints[0].Y, FPoints[1].Y, FPoints[2].Y, FPoints[3].Y]);
  Result.Right := Max([FPoints[0].X, FPoints[1].X, FPoints[2].X, FPoints[3].X]);
  Result.Bottom := Max([FPoints[0].Y, FPoints[1].Y, FPoints[2].Y, FPoints[3].Y]);
end;

procedure TcxBaseBorderPainter.DrawBorderEdge(ACanvas: TCanvas; ABorder: TcxWebBorder);
var
  SaveRgn, DrawRgn: {$IFDEF VCL}HRGN{$ELSE}QRegionH{$ENDIF};
  {$IFDEF VCL}
  ClipRgnExists: Boolean;
  {$ELSE}
  I: Integer;
  Points: TPointArray;
  {$ENDIF}
begin
  if cxStylePainters[ABorder.Style] = nil then Exit;
  {$IFDEF VCL}
  SaveRgn := CreateRectRgn(0, 0, 0, 0);
  ClipRgnExists := GetClipRgn(ACanvas.Handle, SaveRgn) = 1;
  {$ELSE}
  SaveRgn := QRegion_create(QPainter_clipRegion(ACanvas.Handle));
  {$ENDIF}
  try
    {$IFDEF VCL}
    DrawRgn := CreatePolygonRgn(FPoints, 4, WINDING);
    SelectClipRgn(ACanvas.Handle, DrawRgn);
    DeleteObject(DrawRgn);
    {$ELSE}
    SetLength(Points, High(FPoints) + 1);
    for I := Low(FPoints) to High(FPoints) do
      Points[I] := FPoints[I];
    DrawRgn := QRegion_create(@Points[0], True);
    QPainter_setClipRegion(ACanvas.Handle, DrawRgn);
    QRegion_destroy(DrawRgn);
    {$ENDIF}
    cxStylePainters[ABorder.Style].PaintRect(ACanvas, GetPaintRect,
      ABorder.Color, GetEdge);
   finally
    {$IFDEF VCL}
     if ClipRgnExists then
       SelectClipRgn(ACanvas.Handle, SaveRgn)
     else
       SelectClipRgn(ACanvas.Handle, 0);
     DeleteObject(SaveRgn);
    {$ELSE}
     QPainter_setClipRegion(ACanvas.Handle, SaveRgn);
     QRegion_destroy(SaveRgn);
    {$ENDIF}
   end;
end;

{ TcxBottomBorderPainter }

procedure TcxBottomBorderPainter.CalcTrapezium(OuterRect, InnerRect: TRect);
begin
  FPoints[0] := Point(InnerRect.Left, InnerRect.Bottom);
  FPoints[1] := InnerRect.BottomRight;
  FPoints[2] := OuterRect.BottomRight;
  FPoints[3] := Point(OuterRect.Left, OuterRect.Bottom);
end;

function TcxBottomBorderPainter.GetEdge: TcxBorderEdge;
begin
  Result := cxbeBottom;
end;

{ TcxLeftBorderPainter }

procedure TcxLeftBorderPainter.CalcTrapezium(OuterRect, InnerRect: TRect);
begin
  FPoints[0] := OuterRect.TopLeft;
  FPoints[1] := InnerRect.TopLeft;
  FPoints[2] := Point(InnerRect.Left, InnerRect.Bottom);
  FPoints[3] := Point(OuterRect.Left, OuterRect.Bottom);
end;

function TcxLeftBorderPainter.GetEdge: TcxBorderEdge;
begin
  Result := cxbeLeft;
end;

{ TcxRightBorderPainter }

procedure TcxRightBorderPainter.CalcTrapezium(OuterRect, InnerRect: TRect);
begin
  FPoints[0] := Point(InnerRect.Right, InnerRect.Top);
  FPoints[1] := Point(OuterRect.Right, OuterRect.Top);
  FPoints[2] := OuterRect.BottomRight;
  FPoints[3] := InnerRect.BottomRight;
end;

function TcxRightBorderPainter.GetEdge: TcxBorderEdge;
begin
  Result := cxbeRight;
end;

{ TcxTopBorderPainter }

procedure TcxTopBorderPainter.CalcTrapezium(OuterRect, InnerRect: TRect);
begin
  FPoints[0] := OuterRect.TopLeft;
  FPoints[1] := Point(OuterRect.Right, OuterRect.Top);
  FPoints[2] := Point(InnerRect.Right, InnerRect.Top);
  FPoints[3] := InnerRect.TopLeft;
end;

function TcxTopBorderPainter.GetEdge: TcxBorderEdge;
begin
  Result := cxbeTop;
end;

{ TcxAbstractStylePainter }

class function TcxAbstractStylePainter.GetFirstColor(
  AColor: TColor; TopLeft: Boolean): TColor;
begin
  Result := AColor;
end;

class function TcxAbstractStylePainter.GetSecondColor(
  AColor: TColor; TopLeft: Boolean): TColor;
begin
  Result := AColor;
end;

class function TcxAbstractStylePainter.GetWidth(
  const R: TRect; AEdge: TcxBorderEdge): Integer;
begin
  if IsVertical(AEdge) then
    Result := R.Right - R.Left
  else
    Result := R.Bottom - R.Top;
end;

class function TcxAbstractStylePainter.IsTopLeft(
  AEdge: TcxBorderEdge): Boolean;
begin
  Result := AEdge in [cxbeLeft, cxbeTop];
end;

class function TcxAbstractStylePainter.IsVertical(
  AEdge: TcxBorderEdge): Boolean;
begin
  Result := AEdge in [cxbeLeft, cxbeRight];
end;

class procedure TcxAbstractStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
begin
  with ACanvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := GetFirstColor(ABaseColor, IsTopLeft(AEdge));
    Pen.Style := psClear;
  end;
end;

{ TcxSolidStylePainter }

class procedure TcxSolidStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
begin
  inherited;
  ACanvas.FillRect(R);
end;

{ TcxDottedStylePainter }

class procedure TcxDottedStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
var
  Width: Integer;
  I, Count, Len: Integer;
  DeltaX, DeltaY: Single;
begin
  inherited;
  DeltaX := 0;
  DeltaY := 0;
  Width := GetWidth(R, AEdge);
  if IsVertical(AEdge) then
    Len := R.Bottom - R.Top - Width
  else
    Len := R.Right - R.Left - Width;
  Count := Len div (Width * 2);
  if Count = 0 then
    Count := 1;
  if IsVertical(AEdge) then
    DeltaY := Len / Count
  else
    DeltaX := Len / Count;
  for I := 0 to Count do
    if Width > 2 then
      ACanvas.Ellipse(Bounds(R.Left + Trunc(DeltaX * I), R.Top + Trunc(DeltaY * I),
        Width + 1, Width + 1))
    else
      ACanvas.FillRect(Bounds(R.Left + Trunc(DeltaX * I), R.Top + Trunc(DeltaY * I),
        Width, Width));
end;

{ TcxDashedStylePainter }

class procedure TcxDashedStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
var
  Width: Integer;
  I, Count, Len: Integer;
  DeltaX, DeltaY: Single;
begin
  inherited;
  DeltaX := 0;
  DeltaY := 0;
  Width := GetWidth(R, AEdge);
  if IsVertical(AEdge) then
    Len := R.Bottom - R.Top - Width * 2
  else
    Len := R.Right - R.Left - Width * 2;
  Count := Len div (Width * 3);
  if Count = 0 then
    Count := 1;
  if IsVertical(AEdge) then
    DeltaY := Len / Count
  else
    DeltaX := Len / Count;
  for I := 0 to Count do
    ACanvas.FillRect(Bounds(R.Left + Trunc(DeltaX * I), R.Top + Trunc(DeltaY * I),
      Width * 2, Width * 2));
end;

{ TcxDoubleStylePainter }

class procedure TcxDoubleStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
var
  Width: Integer;
begin
  inherited;
  Width := GetWidth(R, AEdge);
  if IsVertical(AEdge) then
  begin
    ACanvas.FillRect(Bounds(R.Left, R.Top, (Width + 2) div 3, R.Bottom - R.Top));
    ACanvas.FillRect(Rect(R.Right - (Width + 2) div 3, R.Top, R.Right, R.Bottom));
  end
  else
  begin
    ACanvas.FillRect(Bounds(R.Left, R.Top, R.Right - R.Left, (Width + 2) div 3));
    ACanvas.FillRect(Rect(R.Left, R.Bottom - (Width + 2) div 3, R.Right, R.Bottom));
  end;
end;

{ TcxGrooveStylePainter }

class function TcxGrooveStylePainter.GetFirstColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := AColor
end;

class function TcxGrooveStylePainter.GetSecondColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := cxGetDarkDarkColor(AColor)
end;

class procedure TcxGrooveStylePainter.PaintRect(ACanvas: TCanvas; R: TRect;
  ABaseColor: TColor; AEdge: TcxBorderEdge);
var
  Width: Integer;
begin
  inherited;
  ACanvas.FillRect(R);
  ACanvas.Brush.Color := GetSecondColor(ABaseColor, IsTopLeft(AEdge));
  Width := GetWidth(R, AEdge);
  if IsVertical(AEdge) then
    ACanvas.FillRect(Bounds(R.Left, R.Top, (Width + 1) div 2, R.Bottom - R.Top))
  else
    ACanvas.FillRect(Bounds(R.Left, R.Top, R.Right - R.Left, (Width + 1) div 2));
end;

{ TcxRidgeStylePainter }

class function TcxRidgeStylePainter.GetFirstColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := cxGetDarkColor(AColor)
end;

class function TcxRidgeStylePainter.GetSecondColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := cxGetShadowColor(AColor)
end;

{ TcxInsetStylePainter }

class function TcxInsetStylePainter.GetFirstColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  if TopLeft then
    Result := cxGetDarkColor(AColor)
  else
    Result := AColor;
end;

class function TcxInsetStylePainter.GetSecondColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  if TopLeft then
    Result := cxGetDarkDarkColor(AColor)
  else
    Result := cxGetShadowColor(AColor);
end;

{ TcxOutsetStylePainter }

class function TcxOutsetStylePainter.GetFirstColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := inherited GetFirstColor(AColor, not TopLeft);
end;

class function TcxOutsetStylePainter.GetSecondColor(AColor: TColor;
  TopLeft: Boolean): TColor;
begin
  Result := inherited GetSecondColor(AColor, not TopLeft);
end;

procedure DrawBorderEdges(ACanvas: TCanvas; ABorders: TcxWebBorders;
  InRect, OutRect: TRect; AEdges: TcxBorderEdges);
begin
  if (cxbeLeft in AEdges) and (InRect.Left <> OutRect.Left)then
    with TcxLeftBorderPainter.Create(OutRect, InRect) do
      try
        DrawBorderEdge(ACanvas, ABorders.Left);
      finally
        Free;
      end;
  if (cxbeTop in AEdges) and (InRect.Top <> OutRect.Top) then
    with TcxTopBorderPainter.Create(OutRect, InRect) do
      try
        DrawBorderEdge(ACanvas, ABorders.Top);
      finally
        Free;
      end;
  if (cxbeRight in AEdges) and (InRect.Right <> OutRect.Right) then
    with TcxRightBorderPainter.Create(OutRect, InRect) do
      try
        DrawBorderEdge(ACanvas, ABorders.Right);
      finally
        Free;
      end;
  if (cxbeBottom in AEdges) and (InRect.Bottom <> OutRect.Bottom) then
    with TcxBottomBorderPainter.Create(OutRect, InRect) do
      try
        DrawBorderEdge(ACanvas, ABorders.Bottom);
      finally
        Free;
      end;
end;

procedure DrawStylishBorder(ACanvas: TCanvas; AStyleBorders: TcxWebBorders; var R: TRect);

  function GetBorderWidth(ABorder: TcxWebBorder): Integer;
  begin
    if (wbavStyle in ABorder.AssignedValues) and (ABorder.Style <> wbsNone) and
       (wbavWidth in ABorder.AssignedValues) then
      Result := ABorder.Width
    else
      Result := 0;
  end;

var
  NewRect: TRect;
begin
  if AStyleBorders <> nil then
  begin
    StoreCanvas(ACanvas);
    try
      NewRect := Rect(R.Left + GetBorderWidth(AStyleBorders.Left),
                      R.Top + GetBorderWidth(AStyleBorders.Top),
                      R.Right - GetBorderWidth(AStyleBorders.Right),
                      R.Bottom - GetBorderWidth(AStyleBorders.Bottom));
      DrawBorderEdges(ACanvas, AStyleBorders, NewRect, R, [cxbeLeft, cxbeTop, cxbeRight, cxbeBottom]);
      R := NewRect;
    finally
      RestoreCanvas(ACanvas);
    end;
  end;
end;

procedure DrawStylishText(ACanvas: TCanvas; R: TRect; AStyle: TcxWebStyle;
   const AText: string; AHorzAlignment: TcxTextHAlignment = thaNone;
   AVertAlignment: TcxTextVAlignment = tvaNone; AFill: Boolean = True);
begin
  StoreCanvas(ACanvas);
  try
    with ACanvas do
      if AStyle <> nil then
      begin
        WebFontToFont(AStyle.Font, Font);
        if AFill and (wsavColor in AStyle.Shading.AssignedValues) then
        begin
          Brush.Style := bsSolid;
          Brush.Color := AStyle.Shading.Color;
          FillRect(R);
        end
        else
          Brush.Style := bsClear;
      end
      else
      begin
        Brush.Style := bsClear;
        Font.Color := clBlack;
        Font.Style := []; 
      end;
    DoTextRect(ACanvas, R, R.Left, R.Top, AText, AHorzAlignment, AVertAlignment);
  finally
    RestoreCanvas(ACanvas);
  end;
end;

function GetDrawTextFlagByAlignment(AHorzAlignment: TcxWebHorzAlignment): Integer;
const
{$IFDEF VCL}
  Formats: Array[TcxWebHorzAlignment] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT, DT_CENTER, DT_CENTER);
{$ELSE}
  Formats: Array[TcxWebHorzAlignment] of AlignmentFlags = (AlignmentFlags_AlignLeft, AlignmentFlags_AlignHCenter,
        AlignmentFlags_AlignRight, AlignmentFlags_AlignHCenter, AlignmentFlags_AlignHCenter);
{$ENDIF}
begin
  Result := Integer(Formats[AHorzAlignment]);
end;

procedure FrameRect(const ACanvas: TCanvas; var ARect: TRect);
{$IFDEF VCL}
begin
  ACanvas.FrameRect(ARect);
{$ELSE}
var
  R: TRect;
begin
  R := ARect;
  R.Right := R.Left + 1;
  ACanvas.FillRect(R);
  R := ARect;
  R.Bottom := R.Top + 1;
  ACanvas.FillRect(R);
  R := ARect;
  R.Left := R.Right - 1;
  ACanvas.FillRect(R);
  R := ARect;
  R.Top := R.Bottom - 1;
  ACanvas.FillRect(R);
  InflateRect(ARect, -1, -1);
{$ENDIF}
end;

{ TcxWebDesignControl }
constructor TcxWebDesignControl.Create(AOwner: TComponent);
begin
  FRefCount := 0;
  FIsBgPainting := False;
  inherited Create(AOwner);
  FBuffBitmap := TBitmap.Create;
  FDesignerControlHelper := TcxWebDesignerControlHelper.Create(self);
  ControlStyle := ControlStyle + [csOpaque];
  {$IFNDEF VCL}
  ControlStyle := ControlStyle + [csNoFocus];
  {$ENDIF}
  FDefaultWebStyle := TcxWebStyle.Create(nil);
  DefineDefaultWebStyle;
  FControlWebStyle := TcxWebStyle.Create(nil);
end;

destructor TcxWebDesignControl.Destroy;
begin
  FRefCount := 0;
  if (WebControl <> nil) and not (csDestroying in WebControl.ComponentState) then
    (WebControl as IcxWebControl).DesignerControl := nil;
  FDesignerControlHelper.Free;
  FDefaultWebStyle.Free;
  FControlWebStyle.Free;
  FBuffBitmap.Free;
  inherited Destroy;
end;

function TcxWebDesignControl.GetInternalWebControl: TcxWebControl;
var
  AComponent: TComponent;
begin
  AComponent := GetComponentByInterface(FDesignerControlHelper.WebControl);
  if(AComponent <> nil) and (AComponent is TcxWebControl) then
    Result := TcxWebControl(AComponent)
  else Result := nil;
end;

procedure TcxWebDesignControl.SetOnUpdateConstrolPosition(Value: TUpdateConstrolPositionEvent);
begin
  FOnUpdateConstrolPosition := Value;
end;

{ IInterface }
function TcxWebDesignControl._QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj)
end;

function TcxWebDesignControl._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TcxWebDesignControl._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
  if Result = 0 then
    Free;
end;

procedure TcxWebDesignControl.RepaintControl;
begin
  if IsTransparent then
    Invalidate;
end;

procedure TcxWebDesignControl.DefineDefaultWebStyle;
begin
  with DefaultWebStyle do
  begin
    Shading.AssignedValues := [];
    Numbering.AssignedValues := [];
    Borders.Color := clBlack;
    Borders.Width := 4;
    Borders.Style := wbsNone;
    Borders.Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
  end;
end;

type
  TWinControlAccess = class(TWinControl);

{$IFDEF VCL}
procedure TcxWebDesignControl.CreateWnd;
begin
  inherited CreateWnd;
  if HandleAllocated then EnableWindow(Handle, False);
end;
{$ELSE}
function TcxWebDesignControl.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  if (Parent <> nil) and
   (QEvent_type(Event) in [QEventType_MouseButtonPress, QEventType_MouseButtonRelease,
        QEventType_MouseButtonDblClick, QEventType_MouseMove]) then
  begin
    QApplication_sendEvent(Parent.Handle, Event);
    Result := False;
  end else Result := inherited EventFilter(Sender, Event);
end;
{$ENDIF}

{$IFNDEF VCL}
function RectVisible(Handle: QPainterH; const R: TRect): Boolean;
begin
  Result := not QPainter_hasClipping(Handle);
  if Result then
    Result := not IsRectEmpty(R)
  else
    Result := QRegion_contains(QPainter_clipRegion(Handle), PRect(@R));
end;
{$ENDIF}

procedure TcxWebDesignControl.Paint;
begin
  if not RectVisible(Canvas.Handle, ClientRect) or FIsBgPainting then Exit;
  DrawBackground;
  DrawFace;
  FDesignerControlHelper.DrawSelectionMarks;
end;

procedure TcxWebDesignControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  ARect: TRect;
  AUpdate: Boolean;
begin
  SetRect(ARect, ALeft, ATop, ALeft + AWidth, ATop + AHeight);
  if (FDesignerControlHelper.WebControl <> nil) and
    not EqualRect(ARect, FDesignerControlHelper.WebControl.BoundsRect) then
    FDesignerControlHelper.WebControl.BoundsRect := ARect
  else
  begin
    inherited SetBounds(ALeft, ATop, AWidth, AHeight);
    if Assigned(FOnUpdateConstrolPosition) then
    begin
      AUpdate := True;
      FOnUpdateConstrolPosition(AUpdate);
      if AUpdate then
        WebControl.UpdateControlPosition;
    end;
  end;
end;

procedure TcxWebDesignControl.DrawBorder(var R: TRect);
begin
  DrawStylishBorder(Canvas, ControlWebStyle.Borders, R);
end;

procedure TcxWebDesignControl.DrawBackground;
begin
  if not IsTransparent then Exit;
  FIsBgPainting := True;
  try
    {$IFDEF VCL}
    TCustomControlAccess(Parent).PaintTo(Canvas.Handle, -Left, -Top);
    {$ELSE}
    //TODO: LINUX NOT IMPLEMENTED
      Canvas.Brush.Style := bsClear;
      Canvas.FillRect(ClientRect);
    {$ENDIF}
  finally
    FIsBgPainting := False;
  end;
end;

procedure TcxWebDesignControl.DrawFace;
var
  R: TRect;
begin
  R := ClientRect;
  if not IsTransparent then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := WebColorToColor(ControlWebStyle.Shading.Color);
    Canvas.FillRect(R);
  end
  else
    Canvas.Brush.Style := bsClear;
  WebFontToFont(ControlWebStyle.Font, Canvas.Font);
  DrawBorder(R);
  DrawInterior(R);
end;

procedure TcxWebDesignControl.DrawInterior(var R: TRect);
begin
end;

{$IFDEF VCL}
procedure TcxWebDesignControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  DefaultHandler(Message);
end;
{$ENDIF}

function TcxWebDesignControl.GetControlWebStyle: TcxWebStyle;
begin
  if GetMainControlStyles.Default <> nil then
  begin
    FControlWebStyle.Assign(GetMainControlStyles.Default.Style);
    FControlWebStyle.Merge(FDefaultWebStyle);
  end
  else
    FControlWebStyle.Assign(FDefaultWebStyle);
  Result := FControlWebStyle;
end;

function TcxWebDesignControl.IsTransparent: Boolean;
begin
  Result := not (wsavColor in ControlWebStyle.Shading.AssignedValues);
end;

function TcxWebDesignControl.GetDrawStyle(AStyleItem: TcxWebStyleItem; ADefStyle: TcxWebStyle): TcxWebStyle;
begin
  Result := TcxWebStyle.Create(nil);
  if AStyleItem <> nil then
  begin
    Result.Assign(AStyleItem.Style);
    Result.Merge(ADefStyle);
  end
  else
    Result.Assign(ADefStyle);
end;


function TcxWebDesignControl.GetMainControlStyles: TcxWebStyles;
begin
  Result := WebControl.Styles;
end;

{ TcxWebDesignCustomControl }

procedure TcxWebDesignCustomControl.DrawInterior(var R: TRect);
begin
  inherited;
  with Canvas do
  begin
    Brush.Color := clBtnShadow;
    Brush.Style := bsBDiagonal;
    Pen.Color := clBtnShadow;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Rectangle(R);
    DoTextRect(Canvas, R, R.Left, R.Top, WebControl.Name, thaCenter, tvaCenter);
  end;
end;

function TcxWebDesignCustomControl.GetInternalWebControl: TcxWebCustomControl;
begin
  Result := inherited GetInternalWebControl as TcxWebCustomControl;
end;

{ TcxWebDesignLabel }

procedure TcxWebDesignLabel.DrawInterior(var R: TRect);
var
  Alignment: TcxTextHAlignment;
begin
  inherited;
  if (WebLabel is TcxWebURLLabel) and
    (TcxWebURLLabel(WebLabel).URL.Href <> '') then
    Canvas.Font.Style := Canvas.Font.Style + [fsUnderline];
  case WebLabel.Alignment of
    whalCenter: Alignment := thaCenter;
    whalLeft: Alignment := thaLeft;
    whalRight: Alignment := thaRight;
  else
    Alignment := thaNone;
  end;
  DoTextRect(Canvas, R, R.Left, R.Top, WebLabel.Caption, Alignment, tvaNone, WebLabel.WordWrap);
end;

function TcxWebDesignLabel.GetInternalWebControl: TcxCustomWebLabel;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebLabel;
end;

{ TcxWebDesignButton }

procedure TcxWebDesignButton.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clWebButtonHighlight;
    Borders.Width := 2;
    Borders.Style := wbsOutset;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
    Font.Name := 'MS Sans Serif';
    Font.Size.Value := 10;
  end;
end;

procedure TcxWebDesignButton.DrawInterior(var R: TRect);
begin
  inherited;
  DoTextRect(Canvas, R, R.Left, R.Top, WebButton.Caption, thaCenter, tvaCenter);
end;

function TcxWebDesignButton.GetInternalWebControl: TcxWebButton;
begin
  Result := inherited GetInternalWebControl as TcxWebButton;
end;

{ TcxWebDesignEditControl }

procedure TcxWebDesignEditControl.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clWebButtonHighlight;
    Borders.Style := wbsInset;
    Borders.Width := 2;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
    Font.Name := 'MS Sans Serif';
    Font.Size.Value := 10;
  end;
end;

function TcxWebDesignEditControl.GetControlText: string;
begin
  Result := '';
end;

{ TcxWebDesignScrollControl }

constructor TcxWebDesignScrollControl.Create(AOwner: TComponent);
begin
  inherited;
  FScrollBar := TScrollBar.Create(Self);
  FScrollBar.ControlStyle := FScrollBar.ControlStyle - [csFramed];
  {$IFNDEF VCL}
  FScrollBar.ParentColor := False;
  {$ENDIF}
  FScrollBar.Visible := False;
  FScrollBar.Kind := sbVertical;
  FScrollBar.Parent := Self;
  FScrollBar.SetParams(0, 0, 1);
  FPrevRect := Bounds(0, 0, 0, 0);
end;

procedure TcxWebDesignScrollControl.DrawInterior(var R: TRect);
begin
  if not EqualRect(R, FPrevRect) then
  begin
    UpdateScrollBar(R);
    FPrevRect := R;
  end;
  if FScrollBar.Visible then
    R.Right := R.Right - FScrollBar.Width;
  inherited;
end;

function TcxWebDesignScrollControl.ShowScrollBar: Boolean;
begin
  Result := WebControl <> nil;
end;

procedure TcxWebDesignScrollControl.UpdateScrollBar(R: TRect);
begin
  if FScrollBar = nil then Exit;
  if ShowScrollBar then
  begin
    FScrollBar.SetBounds(R.Right - FScrollBar.Width, R.Top, FScrollBar.Width, R.Bottom - R.Top);
    FScrollBar.Visible := True;
  end
  else
    FScrollBar.Visible := False;
end;

{ TcxWebDesignEdit }

procedure TcxWebDesignEdit.DrawInterior(var R: TRect);
begin
  inherited;
  DoTextRect(Canvas, R, R.Left + 2, R.Top, GetControlText, thaLeft, tvaCenter);
end;

function TcxWebDesignEdit.GetControlText: string;
var
  I: Integer;
begin
  if WebEdit.Password then
  begin
    SetLength(Result, Length(WebEdit.Text));
    for I := 1 to Length(Result) do
      Result[I] := '*';
  end
  else
    Result := WebEdit.Text;
end;

function TcxWebDesignEdit.GetInternalWebControl: TcxCustomWebEdit;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebEdit;
end;

{ TcxWebDesignMemo }

procedure TcxWebDesignMemo.DefineDefaultWebStyle;
begin
  inherited;
  DefaultWebStyle.Font.Name := 'Courier New';
end;

procedure TcxWebDesignMemo.DrawInterior(var R: TRect);
begin
  inherited;
  DoTextRect(Canvas, R, R.Left + 2, R.Top + 2, WebMemo.Text, thaNone, tvaNone, WebMemo.WordWrap);
end;

function TcxWebDesignMemo.GetInternalWebControl: TcxCustomWebMemo;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebMemo;
end;

{ TcxWebDesignListBox }

procedure TcxWebDesignListBox.DrawInterior(var R: TRect);
var
  DrawRect: TRect;
  I: Integer;
  FontColor, BrushColor: TColor;
begin
  inherited;
  DrawRect := R;
  if WebListBox.ItemHeight <> 0 then
    DrawRect.Bottom := DrawRect.Top + WebListBox.ItemHeight
  else
    DrawRect.Bottom := DrawRect.Top + 16;
  FontColor := Canvas.Font.Color;
  BrushColor := Canvas.Brush.Color;
  for I := 0 to WebListBox.Items.Count - 1 do
  begin
    if WebListBox.Items[I].Selected then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
      Canvas.FillRect(DrawRect);
    end;
    DoTextRect(Canvas, DrawRect, DrawRect.Left + 2, DrawRect.Top,
      WebListBox.Items[I].Text, thaLeft, tvaCenter);
    Canvas.Brush.Color := BrushColor;
    Canvas.Font.Color := FontColor;
    if WebListBox.ItemHeight <> 0 then
      OffsetRect(DrawRect, 0, WebListBox.ItemHeight)
    else
      OffsetRect(DrawRect, 0, 16);
    if DrawRect.Bottom > R.Bottom then
      break;
  end;
end;

function TcxWebDesignListBox.ShowScrollBar: Boolean;
begin
  Result := inherited ShowScrollBar and
    (WebListBox.Items.Count > WebListBox.Size);
end;

function TcxWebDesignListBox.GetInternalWebControl: TcxCustomWebListBox;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebListBox;
end;

{ TcxWebDesignComboBox }

procedure TcxWebDesignComboBox.DrawInterior(var R: TRect);
var
  DrawRect: TRect;
  ButtonWidth: Integer;
  {$IFNDEF VCL}
  ArrowRect: TRect;
  ScrollSize: TSize;
  {$ENDIF}
begin
  inherited;
  DrawRect := R;
  {$IFDEF VCL}
  ButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  {$ELSE}
  QStyle_scrollBarExtent(QWidget_style(Handle), @ScrollSize);
  ButtonWidth := ScrollSize.cx;
  {$ENDIF}
  DrawRect.Left := DrawRect.Right - ButtonWidth;
  {$IFDEF VCL}
  DrawFrameControl(Canvas.Handle, DrawRect, DFC_SCROLL, DFCS_SCROLLDOWN);
  {$ELSE}
  TCanvasAccess(Canvas).Changing;
  Canvas.Start(False);
  try
    QStyle_drawButton(QWidget_style(Handle), Canvas.Handle,
      DrawRect.Left, DrawRect.Top, ButtonWidth, DrawRect.Bottom - DrawRect.Top,
      QWidget_colorGroup(Handle), False, nil);
    QStyle_buttonRect(QWidget_style(Handle), @ArrowRect,
      DrawRect.Left, DrawRect.Top, ButtonWidth, DrawRect.Bottom - DrawRect.Top);
    QStyle_drawArrow(QWidget_style(Handle), Canvas.Handle, ArrowType_DownArrow,
      False, ArrowRect.Left, ArrowRect.Top, ArrowRect.Right - ArrowRect.Left, ArrowRect.Bottom - ArrowRect.Top,
      QWidget_colorGroup(Handle), True, nil);
  finally
    Canvas.Stop;
  end;
  TCanvasAccess(Canvas).Changed;
  {$ENDIF}
  Dec(R.Right, ButtonWidth);
  DoTextRect(Canvas, R, R.Left + 2, R.Top, GetControlText, thaLeft, tvaCenter);
end;

function TcxWebDesignComboBox.GetControlText: string;
begin
  Result := WebComboBox.Text;
end;

function TcxWebDesignComboBox.GetInternalWebControl: TcxCustomWebComboBox;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebComboBox;
end;

{ TcxWebDesignCheckBox }

procedure TcxWebDesignCheckBox.DrawInterior(var R: TRect);
{$IFDEF VCL}
const
  CheckState: array[Boolean] of UINT = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED);
{$ENDIF}
var
  CheckRect: TRect;
begin
  inherited;
  if Assigned(cxWebMetricsUtils) then
    CheckRect := Bounds(R.Left + 4, R.Top + ((R.Bottom - R.Top) - cxWebMetricsUtils.CheckHeight) div 2,
      cxWebMetricsUtils.CheckWidth, cxWebMetricsUtils.CheckHeight)
  else
    CheckRect := Bounds(R.Left + 4, R.Top + ((R.Bottom - R.Top) - 12) div 2,
      12, 12);
  R.Left := CheckRect.Right + 3;
  {$IFDEF VCL}
  DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, CheckState[WebCheckBox.Checked]);
  {$ELSE}
  TCanvasAccess(Canvas).Changing;
  Canvas.Start(False);
  try
    Palette.BaseColor := Canvas.Brush.Color;
    QStyle_drawIndicator(QWidget_style(Handle), Canvas.Handle,
      CheckRect.Left, CheckRect.Top, CheckRect.Right - CheckRect.Left,
      CheckRect.Bottom - CheckRect.Top,
      Palette.ColorGroup(cgActive), Integer(WebCheckBox.Checked), False, True);
  finally
    Canvas.Stop;
  end;
  TCanvasAccess(Canvas).Changed;
  {$ENDIF}
  DoTextRect(Canvas, R, R.Left, R.Top, WebCheckBox.Caption, thaLeft, tvaCenter);
end;

function TcxWebDesignCheckBox.GetInternalWebControl: TcxCustomWebCheckBox;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebCheckBox;
end;

{ TcxWebDesignRadioGroup }

procedure TcxWebDesignRadioGroup.DrawInterior(var R: TRect);
const
  RestSpace = 5;
  {$IFDEF VCL}
  State: array[Boolean] of UINT = (DFCS_BUTTONRADIO, DFCS_BUTTONRADIO or DFCS_CHECKED);
  {$ENDIF}
var
  CR, TR: TRect;
  I: Integer;
begin
  inherited;
  if WebRadioGroup.Items.Count = 0 then
  with Canvas do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBtnShadow;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Rectangle(R);
    Canvas.Font.Color := clBtnShadow;
    Canvas.Font.Style := [];
    Canvas.Font.Size := 10;
    DoTextRect(Canvas, R, R.Left, R.Top, '(no items)', thaCenter, tvaCenter);
    Exit;
  end;
  if Assigned(cxWebMetricsUtils) then
    CR := Bounds(R.Left, R.Top, cxWebMetricsUtils.CheckWidth, WebRadioGroup.ItemHeight)
  else
    CR := Bounds(R.Left, R.Top, 12, 16);
  Offsetrect(CR, RestSpace, 0);
  TR := Rect(CR.Right + RestSpace, CR.Top, R.Right, CR.Bottom);
  if Assigned(cxWebMetricsUtils) then
    InflateRect(CR, 0, -(WebRadioGroup.ItemHeight - cxWebMetricsUtils.CheckHeight) div 2)
  else
    InflateRect(CR, 0, -(16 - 12) div 2);
  for I := 0 to WebRadioGroup.Items.Count - 1 do
  begin
    {$IFDEF VCL}
    DrawFrameControl(Canvas.Handle, CR, DFC_BUTTON, State[WebRadioGroup.ItemIndex = I]);
    {$ELSE}
    TCanvasAccess(Canvas).Changing;
    Canvas.Start(False);
    QPainter_save(Canvas.Handle);
    try
      Palette.BaseColor := Canvas.Brush.Color;
      QStyle_drawExclusiveIndicator(QWidget_style(Handle), Canvas.Handle,
        CR.Left, CR.Top, CR.Right - CR.Left, CR.Bottom - CR.Top,
        Palette.ColorGroup(cgActive), WebRadioGroup.ItemIndex = I, False, True);
    finally
      QPainter_restore(Canvas.Handle);
      Canvas.Stop;
    end;
    TCanvasAccess(Canvas).Changed;
    {$ENDIF}
    DoTextRect(Canvas, TR, TR.Left, TR.Top, WebRadioGroup.Items[I], thaLeft, tvaCenter);
    if WebRadioGroup.ItemHeight <> 0 then
    begin
      OffsetRect(TR, 0, WebRadioGroup.ItemHeight);
      OffsetRect(CR, 0, WebRadioGroup.ItemHeight);
    end
    else
    begin
      OffsetRect(TR, 0, 16);
      OffsetRect(CR, 0, 16);
    end;
    if TR.Bottom > R.Bottom then
      break;
  end;
end;

function TcxWebDesignRadioGroup.GetInternalWebControl: TcxCustomWebRadioGroup;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebRadioGroup;
end;

{ TcxWebDesignImage }
type
  TcxWebImageUtilsAcess = class(TcxWebImageUtils);

procedure TcxWebDesignImage.DrawInterior(var R: TRect);
var
  S: string;
  VA: TcxTextVAlignment;
begin
  if (WebImage.DesignPicture = nil) or WebImage.DesignPicture.IsEmpty then
  begin
    with Canvas do
    begin
      Pen.Style := psSolid;
      Pen.Color := clBtnShadow;
      Pen.Width := 1;
      Brush.Style := bsClear;
      Rectangle(R);
    end;
    inherited;
    S := WebImage.DesignPicture.GetErrMessage;
    if S <> '' then
    begin
      Canvas.Font.Color := clRed;
      VA := tvaNone;
    end
    else
    begin
      S := WebImage.AltText;
      if S = '' then
        S := '(no image)';
      Canvas.Font.Color := clBtnShadow;
      VA := tvaCenter;
    end;
    Canvas.Font.Style := [];
    Canvas.Font.Size := 10;
    DoTextRect(Canvas, R, R.Left, R.Top, S, thaCenter, VA, True);
  end
  else
    Canvas.StretchDraw(R, TcxWebImageUtilsAcess(WebImage.DesignPicture).GetGraphic);
  //TODO: Image vert and horiz space
end;

function TcxWebDesignImage.GetInternalWebControl: TcxCustomWebImage;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebImage;
end;

procedure DrawRectBorder(Canvas: TCanvas; R: TRect; BorderWidth: Integer; BorderColor: TColor);
begin
  Canvas.Brush.Style := bsSolid;
  Canvas.Brush.Color := BorderColor;
  while BorderWidth > 0 do
  begin
    FrameRect(Canvas, R);
    Dec(BorderWidth);
  end;
end;

procedure Draw3DButton(Canvas: TCanvas; R: TRect);
begin
//  Canvas.Brush.Color := clBtnFace;
  Canvas.FillRect(R);
  Canvas.Pen.Color := clWhite;
  Canvas.MoveTo(R.Right - 1, R.Top);
  Canvas.LineTo(R.Left, R.Top);
  Canvas.LineTo(R.Left, R.Bottom - 1);
  Canvas.Pen.Color := clBlack;
  Canvas.LineTo(R.Right - 1, R.Bottom - 1);
  Canvas.LineTo(R.Right - 1, R.Top - 1);
end;

{ TcxWebDesignGrid }

type
  TcxCustomWebGridAccess = class(TcxCustomWebGrid);

constructor TcxWebDesignCustomGrid.Create(AOwner: TComponent);
begin
  FGroupDefStyle := TcxWebStyle.Create(nil);
  FHeaderDefStyle := TcxWebStyle.Create(nil);
  FIndDefStyle := TcxWebStyle.Create(nil);
  FStatusDefStyle := TcxWebStyle.Create(nil);
  FGroupNodeDefStyle := TcxWebStyle.Create(nil);
  FItemsDefStyle := TcxWebStyle.Create(nil);
  inherited Create(AOwner);
  LoadBitmaps;
end;

destructor TcxWebDesignCustomGrid.Destroy;
begin
  FreeBitmaps;
  FItemsDefStyle.Free;
  FGroupDefStyle.Free;
  FHeaderDefStyle.Free;
  FIndDefStyle.Free;
  FStatusDefStyle.Free;
  FGroupNodeDefStyle.Free;
  inherited Destroy;
end;

procedure TcxWebDesignCustomGrid.FreeBitmaps;
var
  I: TcxWebGridButtons;
begin
  for I := Low(TcxWebGridButtons) to High(TcxWebGridButtons) do
    FBitmaps[I].Free;
end;

procedure TcxWebDesignCustomGrid.LoadBitmaps;
const
  cxImgsResName: array[TcxWebGridButtons] of string =
  ('CXWEBGRID_NODE', 'CXWEBGRID_DELETE', 'CXWEBGRID_INSERT',
   'CXWEBGRID_POST', 'CXWEBGRID_CANCEL', 'CXWEBGRID_CURSOR',
   'CXWEBGRID_EXPAND', 'CXWEBGRID_COLLAPSE');
var
  I: TcxWebGridButtons;
begin
  for I := Low(TcxWebGridButtons) to High(TcxWebGridButtons) do
  begin
    FBitmaps[I] := TBitmap.Create;
    FBitmaps[I].LoadFromResourceName(HInstance, cxImgsResName[I]);
    FBitmaps[I].Transparent := True;
  end;
end;

procedure TcxWebDesignCustomGrid.DrawCell(var R: TRect; ARowIndex, AColIndex: Integer);
var
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  Text: string;
  HAlignment: TcxTextHAlignment;
  VAlignment: TcxTextVAlignment;
begin
  if (ARowIndex < 0) and (ARowIndex >= WebGrid.RowCount) then Exit;
  if not WebGrid.Columns[AColIndex].Visible then Exit;
  DrawRect := R;
  DrawRect.Right := DrawRect.Left + WebGrid.Columns[AColIndex].Width;
  R.Left := DrawRect.Right;
  if Odd(ARowIndex) and (WebGrid.Columns[AColIndex].AlternatingStyles.Default <> nil) then
    AStyle := GetDrawStyle(WebGrid.Columns[AColIndex].AlternatingStyles.Default, FItemsDefStyle)
  else
    if WebGrid.Columns[AColIndex].Styles.Default <> nil then
      AStyle := GetDrawStyle(WebGrid.Columns[AColIndex].Styles.Default, FItemsDefStyle)
    else
      AStyle := GetDrawStyle(WebGrid.Styles.Default, FItemsDefStyle);
  if not WebGrid.ShowGrid then
    AStyle.Borders.Style := wbsNone;
  if ARowIndex = WebGrid.FocusedRow then
  begin
    AStyle.Shading.Color := WebGrid.SelectedColor;
    AStyle.Font.Color := WebGrid.SelectedFontColor;
  end;
  case WebGrid.Columns[AColIndex].Alignment of
    whalCenter: HAlignment := thaCenter;
    whalLeft: HAlignment := thaLeft;
    whalRight: HAlignment := thaRight;
  else
    HAlignment := thaNone;
  end;
  case WebGrid.Columns[AColIndex].VAlignment of
    wvalCenter: VAlignment := tvaCenter;
    wvalTop: VAlignment := tvaTop;
    wvalBottom: VAlignment := tvaBottom;
  else
    VAlignment := tvaNone;
  end;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  Text := WebGrid.Columns[AColIndex].GetCellText(ARowIndex);
  DrawStylishText(Canvas, DrawRect, AStyle, Text, HAlignment, VAlignment);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DrawGroupNode(R: TRect; ARowIndex: Integer);
var
  OffX, OffY, ColIndex: Integer;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  Image: TBitmap;
  Text: string;
begin
  ColIndex := WebGrid.GetGroupingItemIndex(WebGrid.GetRowLevel(ARowIndex));
  if (ARowIndex < 0) or (ARowIndex >= WebGrid.RowCount) then Exit;
  DrawRect := R;
  if WebGrid.GroupNodesStyles.Default = nil then
    AStyle := GetDrawStyle(WebGrid.Styles.Default, FGroupNodeDefStyle)
  else
    AStyle := GetDrawStyle(WebGrid.GroupNodesStyles.Default, FGroupNodeDefStyle);
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  if wsavColor in AStyle.Shading.AssignedValues then
    with Canvas do
    begin
      Brush.Color := WebColorToColor(AStyle.Shading.Color);
      Brush.Style := bsSolid;
      FillRect(DrawRect);
    end;
  Image := FBitmaps[gbExpand]; //TODO: collapse
  OffX := DrawRect.Left + 3;
  OffY := DrawRect.Top + (DrawRect.Bottom - DrawRect.Top - Image.Height) div 2;
  with Canvas do
  begin
    Pen.Style := psSolid;
    Pen.Width := 1;
    Pen.Color := WebColorToColor(clWebThreeDHighlight);
    MoveTo(OffX - 1, OffY - 1);
    LineTo(OffX + Image.Width, OffY - 1);
    Pen.Color := WebColorToColor(clWebThreeDDarkShadow);
    LineTo(OffX + Image.Width, OffY + Image.Height);
    LineTo(OffX - 1, OffY + Image.Height);
    Pen.Color := WebColorToColor(clWebThreeDHighlight);
    LineTo(OffX - 1, OffY - 1);
  end;
  Canvas.Draw(OffX, OffY, Image);
  Inc(DrawRect.Left, Image.Width + 6);
  Text := WebGrid.Columns[ColIndex].Title + ': ' + WebGrid.Columns[ColIndex].GetCellText(ARowIndex);
  DrawStylishText(Canvas, DrawRect, AStyle, Text, thaLeft, tvaCenter, False);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DrawHeaderCell(var R: TRect; AIndex, AMargin: Integer);
var
  AStyle: TcxWebStyle;
  DrawRect: TRect;
  ColWidth: Integer;
begin
  if (AIndex = -1) or (WebGrid.ColumnCount <= AIndex) or not WebGrid.Columns[AIndex].Visible then Exit;
  ColWidth := WebGrid.Columns[AIndex].Width;
  if (AIndex = TcxCustomWebGridAccess(WebGrid).FirstVisibleColumnIndex) and
    (WebGrid.GetGroupingItemCount > 0) then
    Inc(ColWidth, WebGrid.IndicatorWidth);
  DrawRect := Bounds(R.Left + AMargin, R.Top + AMargin, ColWidth, WebGrid.HeaderHeight);
  R.Left := DrawRect.Right;
  R.Top := R.Top + AMargin;
  if WebGrid.HeaderStyles.Default = nil then
    AStyle := GetDrawStyle(WebGrid.Styles.Default, FHeaderDefStyle)
  else
    AStyle := GetDrawStyle(WebGrid.HeaderStyles.Default, FHeaderDefStyle);
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  DrawStylishText(Canvas, DrawRect, AStyle, WebGrid.Columns[AIndex].Title, thaCenter, tvaCenter);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DrawIndicator(var R: TRect; ABtn1, ABtn2: TcxWebGridButtons);
var
  AStyle: TcxWebStyle;
  DrawRect: TRect;
  Image: TBitmap;
  OffX, OffY: Integer;
begin
  if not WebGrid.ShowIndicator then Exit;
  if WebGrid.IndicatorStyles.Default = nil then
    AStyle := GetDrawStyle(WebGrid.Styles.Default, FIndDefStyle)
  else
    AStyle := GetDrawStyle(WebGrid.IndicatorStyles.Default, FIndDefStyle);
  DrawRect := Bounds(R.Left, R.Top, WebGrid.IndicatorWidth, R.Bottom - R.Top);
  R.Left := DrawRect.Right;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  if wsavColor in AStyle.Shading.AssignedValues then
    with Canvas do
    begin
      Brush.Color := WebColorToColor(AStyle.Shading.Color);
      Brush.Style := bsSolid;
      FillRect(DrawRect);
    end;
  if WebGrid.IndicatorType = itDataOp then
    Image := FBitmaps[ABtn1]
  else
    Image := FBitmaps[ABtn2];
  OffX := DrawRect.Left + (WebGrid.IndicatorWidth - Image.Width) div 2;
  OffY := DrawRect.Top + (DrawRect.Bottom - DrawRect.Top - Image.Height) div 2;
  Canvas.Draw(OffX, OffY, Image);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DrawHeader(var R: TRect);
var
  DrawRect: TRect;
  I: Integer;
begin
  if not WebGrid.ShowHeader or (WebGrid.ColumnCount = 0) then Exit;
  DrawRect := Bounds(R.Left, R.Top, R.Right - R.Left, WebGrid.HeaderHeight);
  R.Top := DrawRect.Bottom;
  DrawIndicator(DrawRect, gbInsert, gbNode);
  for I := 0 to WebGrid.ColumnCount - 1 do
    DrawHeaderCell(DrawRect, I, 0);
end;

procedure TcxWebDesignCustomGrid.DrawGroupPanel(var R: TRect);
const
  Margin = 10;
var
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  PHeight, I: Integer;
  Text: string;
begin
  if not WebGrid.ShowGroupPanel then exit;
  if WebGrid.GroupPanelStyles.Default = nil then
    AStyle := GetDrawStyle(WebGrid.Styles.Default, FGroupDefStyle)
  else
    AStyle := GetDrawStyle(WebGrid.GroupPanelStyles.Default, FGroupDefStyle);
  if WebGrid.GroupPanelStyles.Default = nil then
    with AStyle.Borders do
    begin
      Style := wbsSolid;
      Color := WebGrid.BorderColor;
      Width := WebGrid.BorderWidth;
      Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    end;
  if WebGrid.GetGroupingItemCount > 0 then
    PHeight := (WebGrid.GetGroupingItemCount + 1) * Margin + WebGrid.HeaderHeight
  else
    PHeight := 0;
  if WebGrid.GroupPanelHeight > PHeight then
    PHeight := WebGrid.GroupPanelHeight;
  Inc(PHeight, AStyle.Borders.VertBordersSize);  
  DrawRect := Bounds(R.Left, R.Top, R.Right - R.Left, PHeight);
  R.Top := DrawRect.Bottom;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  if WebGrid.GetGroupingItemCount = 0 then
    Text := '  Drag a column header here to group by that column'
  else
    Text := '';
  DrawStylishText(Canvas, DrawRect, AStyle, Text, thaLeft, tvaCenter, True);
  for I := 0 to WebGrid.GetGroupingItemCount - 1 do
    DrawHeaderCell(DrawRect, WebGrid.GetGroupingItemIndex(I), Margin);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DrawRow(AIndex: Integer; var R: TRect);
var
  DrawRect: TRect;
  I: Integer;
begin
  if (AIndex < 0) or (AIndex >= WebGrid.RowCount) then Exit;
  DrawRect := Bounds(R.Left, R.Top, R.Right - R.Left, WebGrid.RowHeight);
  R.Top := DrawRect.Bottom;
  if WebGrid.GetRowLevel(AIndex) < WebGrid.GetGroupingItemCount then
  begin
    DrawIndicator(DrawRect, gbNode, gbNode);
    DrawGroupNode(DrawRect, AIndex);
  end
  else
  begin
    if WebGrid.FocusedRow = AIndex then
      DrawIndicator(DrawRect, gbDelete, gbCursor)
    else
      DrawIndicator(DrawRect, gbDelete, gbNode);
    for I := 0 to WebGrid.ColumnCount - 1 do
      DrawCell(DrawRect, AIndex, I);
  end;
end;

procedure TcxWebDesignCustomGrid.DrawStatusPanel(var R: TRect);
var
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  AHeight: Integer;
begin
  if not WebGrid.ShowStatusPanel then exit;
  if WebGrid.StatusPanelStyles.Default = nil then
    AStyle := GetDrawStyle(WebGrid.Styles.Default, FStatusDefStyle)
  else
    AStyle := GetDrawStyle(WebGrid.StatusPanelStyles.Default, FStatusDefStyle);
  if WebGrid.StatusPanelStyles.Default = nil then
    with AStyle.Borders do
    begin
      Style := wbsSolid;
      Color := WebGrid.BorderColor;
      Width := WebGrid.BorderWidth;
      Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
      Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    end;
  AHeight := Max(CalcStylishTextExtent(Canvas, AStyle, 'Wq').cy, WebGrid.StatusPanelHeight) +
    AStyle.Borders.VertBordersSize;
  DrawRect := Rect(R.Left, R.Bottom - AHeight, R.Right, R.Bottom);
  R.Bottom := DrawRect.Top;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  DrawStylishText(Canvas, DrawRect, AStyle, '  ' + WebGrid.StatusPanelText, thaLeft, tvaCenter);
  AStyle.Free;
end;

procedure TcxWebDesignCustomGrid.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
  with FItemsDefStyle do
  begin
    Borders.Style := wbsSolid;
    Borders.Left.Style := wbsNone;
    Borders.Top.Style := wbsNone;
    Borders.Bottom.Color := clWebBlack;
    Borders.Right.Color := clWebBlack;
    Borders.Width := 1;
  end;
  with FGroupDefStyle do
  begin
    Shading.Color := clWebButtonShadow;
    Shading.AssignedValues := [wsavColor];
    Font.Color := clWebButtonFace;
  end;
  with FHeaderDefStyle do
  begin
    Borders.Left.Color := clWebThreeDHighlight;
    Borders.Top.Color := clWebThreeDHighlight;
    Borders.Bottom.Color := clWebThreeDDarkShadow;
    Borders.Right.Color := clWebThreeDDarkShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
  end;
  with FIndDefStyle do
  begin
    Borders.Left.Color := clWebThreeDHighlight;
    Borders.Top.Color := clWebThreeDHighlight;
    Borders.Bottom.Color := clWebThreeDDarkShadow;
    Borders.Right.Color := clWebThreeDDarkShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
  end;
  with FStatusDefStyle do
  begin
    Borders.Width := 1;
    Borders.Color := clWebBlack;
    Borders.Style := wbsSolid;
    Shading.Color := clWebButtonShadow;
    Shading.AssignedValues := [wsavColor];
    Font.Color := clWebButtonFace;
  end;
  with FGroupNodeDefStyle do
  begin
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
  end;
end;

procedure TcxWebDesignCustomGrid.DrawBorder(var R: TRect);
begin
 // no standard border
end;

procedure TcxWebDesignCustomGrid.DrawInterior(var R: TRect);
var
  I: Integer;
  DrawRect: TRect;
begin
  DrawGroupPanel(R);
  DrawStatusPanel(R);
  with Canvas do
  begin
    Brush.Color := WebColorToColor(WebGrid.BorderColor);
    Brush.Style := bsSolid;
    DrawRect := Bounds(R.Left, R.Top, WebGrid.BorderWidth, R.Bottom - R.Top);
    FillRect(DrawRect);
    DrawRect := Bounds(R.Right - WebGrid.BorderWidth, R.Top, WebGrid.BorderWidth, R.Bottom - R.Top);
    FillRect(DrawRect);
    if not WebGrid.ShowGroupPanel then
    begin
      DrawRect := Bounds(R.Left, R.Top, R.Right - R.Left, WebGrid.BorderWidth);
      FillRect(DrawRect);
      Inc(R.Top, WebGrid.BorderWidth);
    end;
    if not WebGrid.ShowStatusPanel then
    begin
      DrawRect := Bounds(R.Left, R.Bottom - WebGrid.BorderWidth, R.Right - R.Left, WebGrid.BorderWidth);
      FillRect(DrawRect);
      Dec(R.Bottom, WebGrid.BorderWidth);
    end;
  end;
  InflateRect(R, -WebGrid.BorderWidth, 0);
  DrawHeader(R);
  with WebGrid do
    for I := 0 to PageSize - 1 do
      DrawRow(FirstVisibleRow + I, R);
end;

function TcxWebDesignCustomGrid.GetInternalWebControl: TcxCustomWebGrid;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebGrid;
end;

{ TcxWebDesignGridNavigator }

constructor TcxWebDesignDataNavigator.Create(AOwner: TComponent);
begin
  FEdStyle := TcxWebStyle.Create(nil);
  inherited Create(AOwner);
  LoadBitmaps;
end;

destructor TcxWebDesignDataNavigator.Destroy;
begin
  FreeBitmaps;
  FEdStyle.Free;
  inherited Destroy;
end;

procedure TcxWebDesignDataNavigator.LoadBitmaps;
const
  cxImgsResName: array[TcxWebNavigatorButtonType] of string =
  ('CXWEBNAV_FIRST', 'CXWEBNAV_PRIORPAGE', 'CXWEBNAV_PRIOR', 'CXWEBNAV_PAGESIZE',
   'CXWEBNAV_APPLYPAGESIZE', 'CXWEBNAV_NEXT', 'CXWEBNAV_NEXTPAGE', 'CXWEBNAV_LAST',
   'CXWEBNAV_INSERT', 'CXWEBNAV_EDIT', 'CXWEBNAV_DELETE', 'CXWEBNAV_POST',
   'CXWEBNAV_CANCEL', 'CXWEBNAV_REFRESH', 'CXWEBNAV_PAGESIZE');
var
  I: TcxWebNavigatorButtonType;
begin
  for I := Low(TcxWebNavigatorButtonType) to High(TcxWebNavigatorButtonType) do
  begin
    FBitmaps[I] := TBitmap.Create;
    FBitmaps[I].LoadFromResourceName(HInstance, cxImgsResName[I]);
    FBitmaps[I].Transparent := True;
  end;
end;

procedure TcxWebDesignDataNavigator.FreeBitmaps;
var
  I: TcxWebNavigatorButtonType;
begin
  for I := Low(TcxWebNavigatorButtonType) to High(TcxWebNavigatorButtonType) do
    FBitmaps[I].Free;
end;

procedure TcxWebDesignDataNavigator.DrawButton(var XPos, YPos: Integer; Index: Integer);
var
  R: TRect;
  OffX, OffY: Integer;
  Image: TBitmap;
begin
  R := Bounds(XPos, YPos, WebDataNavigator.ButtonWidth, WebDataNavigator.Height);
  DrawStylishBorder(Canvas, ControlWebStyle.Borders, R);
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := WebColorToColor(ControlWebStyle.Shading.Color);
    FillRect(R);
  end;
  if WebDataNavigator.Buttons.Items[Index].ButtonType <> nbCustom then
  begin
    Image := FBitmaps[WebDataNavigator.Buttons.Items[Index].ButtonType];
    OffX := R.Left + (WebDataNavigator.ButtonWidth - Image.Width) div 2;
    OffY := R.Top + (WebDataNavigator.Height - Image.Height) div 2;
    Canvas.Draw(OffX, OffY, Image);
  end;
  Inc(XPos, WebDataNavigator.ButtonWidth);
end;

procedure TcxWebDesignDataNavigator.DrawEdit(var XPos, YPos: Integer; Text: string);
var
  R: TRect;
  AStyle: TcxWebStyle;
begin
  if GetMainControlStyles.Default <> nil then
    AStyle := GetMainControlStyles.Default.Style
  else
    AStyle := FEdStyle;
  R := Bounds(XPos, YPos, WebDataNavigator.ButtonWidth * 2, WebDataNavigator.Height);
  XPos := R.Right;
  DrawStylishBorder(Canvas, AStyle.Borders, R);
  DrawStylishText(Canvas, R, AStyle, Text, thaLeft, tvaCenter);
end;

procedure TcxWebDesignDataNavigator.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Left.Color := clWebWhite;
    Borders.Top.Color := clWebWhite;
    Borders.Right.Color := clWebBlack;
    Borders.Bottom.Color := clWebBlack;
    Borders.Width := 1;
    Borders.Style := wbsSolid;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
  end;
  with FEdStyle do
  begin
    Borders.Color := clWebButtonHighlight;
    Borders.Style := wbsInset;
    Borders.Width := 2;
    Borders.Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
    Font.Name := 'MS Sans Serif';
    Font.Size.Value := 10;
  end;
end;

procedure TcxWebDesignDataNavigator.DrawFace;
var
  R: TRect;
begin
  R := ClientRect;
  DrawInterior(R);
end;

procedure TcxWebDesignDataNavigator.DrawInterior(var R: TRect);
var
  I, XPos, YPos: Integer;
begin
  XPos := 0;
  YPos := 0;
  for I := 0 to WebDataNavigator.Buttons.Count - 1 do
  begin
    if WebDataNavigator.Buttons.Items[I].Visible then
      if WebDataNavigator.Buttons.Items[I].ButtonType = nbPageSize then
        DrawEdit(XPos, YPos, IntToStr(WebDataNavigator.PageSize))
      else
        DrawButton(XPos, YPos, I);
  end;
end;

function TcxWebDesignDataNavigator.GetInternalWebControl: TcxCustomWebDataNavigator;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebDataNavigator;
end;

{ TcxWebDesignTreeView }

procedure TcxWebDesignTreeView.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Width := 1;
    Borders.Style := wbsSolid;
  end;
end;

procedure TcxWebDesignTreeView.DrawBorder(var R: TRect);
begin
  if WebTreeView.Items.Count > 0 then
    inherited;
end;

procedure TcxWebDesignTreeView.DrawInterior(var R: TRect);
begin
  inherited;
  if WebTreeView.Items.Count = 0 then
    with Canvas do
    begin
      Brush.Style := bsClear;
      Pen.Color := clBtnShadow;
      Pen.Style := psSolid;
      Pen.Width := 1;
      Rectangle(R);
      Canvas.Font.Color := clBtnShadow;
      Canvas.Font.Style := [];
      Canvas.Font.Size := 10;
      DoTextRect(Canvas, R, R.Left, R.Top, '(no items)', thaCenter, tvaCenter);
    end
  else
    DrawItems(R, WebTreeView.Items);
end;

procedure TcxWebDesignTreeView.DrawItems(var R: TRect; AItem: TcxWebTreeItem);

  procedure DrawExpandButton(const Rect: TRect; Expanded: Boolean);
  const
    BtnSize = 9;
  var
    BtnRect: TRect;
  begin
    StoreCanvas(Canvas);
    BtnRect := Bounds(Rect.Left - BtnSize - 2,
      Rect.Top + (Rect.Bottom - Rect.Top - BtnSize) div 2,
      BtnSize, BtnSize);
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBtnShadow;
    FrameRect(Canvas, BtnRect);
    Canvas.Pen.Color := clWindowText;
    Canvas.Pen.Style := psSolid;
    Canvas.MoveTo(BtnRect.Left + 2, BtnRect.Top + BtnSize div 2);
    Canvas.LineTo(BtnRect.Right - 2, BtnRect.Top + BtnSize div 2);
    if not Expanded then
    begin
      Canvas.MoveTo(BtnRect.Left + BtnSize div 2, BtnRect.Top + 2);
      Canvas.LineTo(BtnRect.Left + BtnSize div 2, BtnRect.Bottom - 2);
    end;
    RestoreCanvas(Canvas);
  end;

var
  I: Integer;
  ItemRect: TRect;
begin
  if AItem.Level >= 0 then
  begin
    ItemRect := R;
    ItemRect.Left := R.Left + WebTreeView.Indent * (AItem.Level + 1);
    ItemRect.Bottom := R.Top + Canvas.TextHeight(AItem.Text);
    if WebTreeView.ShowButtons and AItem.HasChildren then
      DrawExpandButton(ItemRect, AItem.Expanded);
    DoTextRect(Canvas, ItemRect, ItemRect.Left, ItemRect.Top, AItem.Text);
    R.Top := ItemRect.Bottom;
  end;
  if AItem.Expanded then
    for I := 0 to AItem.Count - 1 do
      DrawItems(R, AItem.Items[I]);
end;

function TcxWebDesignTreeView.GetInternalWebControl: TcxWebTreeView;
begin
  Result := inherited GetInternalWebControl as TcxWebTreeView;
end;


{ TcxWebDesignPanel }

constructor TcxWebDesignPanel.Create(AOwner: TComponent);
begin
  inherited Create(Owner);
  ControlStyle := ControlStyle + [csAcceptsControls];
end;

procedure TcxWebDesignPanel.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clBlack;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
end;

procedure TcxWebDesignPanel.DrawBorder(var R: TRect);
begin
  //do not delete
end;

procedure TcxWebDesignPanel.DrawInterior(var R: TRect);
var
  BR: TRect;
  Text: string;
begin
  inherited;
  if Panel.Caption <> '' then
    Text := Format(' %s ', [Panel.Caption])
  else
    Text := '';  
  BR := R;
  R := Bounds(R.Left + 10, R.Top, Canvas.TextWidth(Text), Canvas.TextHeight(Text));
  Inc(BR.Top, (R.Bottom - R.Top) div 2);
  inherited DrawBorder(BR);
  DrawStylishText(Canvas, R, ControlWebStyle, Text, thaLeft, tvaCenter);
end;

function TcxWebDesignPanel.GetInternalWebControl: TcxWebPanel;
begin
  Result := inherited GetInternalWebControl as TcxWebPanel;
end;

{ TcxWebDesignMainMenu }

procedure TcxWebDesignMainMenu.DrawEmptyMenu(R: TRect);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBtnShadow;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Rectangle(R);
    Canvas.Font.Color := clBtnShadow;
    Canvas.Font.Style := [];
    Canvas.Font.Size := 10;
    DoTextRect(Canvas, R, R.Left, R.Top, '(no items)', thaCenter, tvaCenter);
  end;
end;

procedure TcxWebDesignMainMenu.DrawMenuItem(R: TRect; AItem: TcxWebMenuItem);
var
  Alignment: TcxTextHAlignment;
begin
  case AItem.Align of
    maCenter: Alignment := thaCenter;
    maLeft: Alignment := thaLeft;
    maRight: Alignment := thaRight;
  else
    Alignment := thaNone;
  end;
  DoTextRect(Canvas, R, R.Left, R.Top, AItem.Caption, Alignment, tvaCenter);
end;

procedure TcxWebDesignMainMenu.DrawInterior(var R: TRect);
var
  I: Integer;
begin
  if WebMainMenu.Items.Count = 0 then
    DrawEmptyMenu(R)
  else
    for I := 0 to WebMainMenu.Items.Count - 1 do
      if WebMainMenu.Items[I].Visible then
      begin
        if WebMainMenu.Items[I].Break = mbBreak then
        begin
          if WebMainMenu.Horizontal then
            R.Right := R.Left + WebMainMenu.SeparatorWidth
          else
            R.Bottom := R.Top + WebMainMenu.SeparatorWidth;
          StoreCanvas(Canvas);
          try
            Canvas.Brush.Color := WebColorToColor(WebMainMenu.SeparatorColor);
            Canvas.Brush.Style := bsSolid;
            Canvas.FillRect(R);
          finally
            RestoreCanvas(Canvas);
          end;
        end
        else
        begin
          if WebMainMenu.Horizontal then
            R.Right := R.Left + WebMainMenu.Items[I].Width
          else
            R.Bottom := R.Top + WebMainMenu.ItemHeight;
          DrawMenuItem(R, WebMainMenu.Items[I]);
        end;
        if WebMainMenu.Horizontal then
          R.Left := R.Right
        else
          R.Top := R.Bottom;
      end;
end;

function TcxWebDesignMainMenu.GetInternalWebControl: TcxWebMainMenu;
begin
  Result := inherited GetInternalWebControl as TcxWebMainMenu;
end;

procedure TcxWebDesignMainMenu.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clWebBlack;
    Borders.Width := 1;
    Borders.Style := wbsSolid;
    Shading.Color := clWebLightGrey;
    Shading.AssignedValues := [wsavColor];
  end;
end;

procedure TcxWebDesignMainMenu.DrawBorder(var R: TRect);
begin
  if WebMainMenu.Items.Count > 0 then
    inherited;
end;

{ TcxWebDesignCalendar }

type
  TcxCalendarSheetAccess = class(TcxCalendarSheet);

constructor TcxWebDesignCalendar.Create(AOwner: TComponent);
begin
  FDayHeaderDefStyle := TcxWebStyle.Create(nil);
  FOtherMonthDayDefStyle := TcxWebStyle.Create(nil);
  FSelectedDefStyle := TcxWebStyle.Create(nil);
  FTitleDefStyle := TcxWebStyle.Create(nil);
  FTodayPanelDefStyle := TcxWebStyle.Create(nil);
  inherited;
end;

destructor TcxWebDesignCalendar.Destroy;
begin
  FDayHeaderDefStyle.Free;
  FOtherMonthDayDefStyle.Free;
  FSelectedDefStyle.Free;
  FTitleDefStyle.Free;
  FTodayPanelDefStyle.Free;
  inherited;
end;

procedure TcxWebDesignCalendar.DrawTitle(var R: TRect);
var
  TxtSize: TSize;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  Txt: string;
begin
  DrawRect := R;
  AStyle := GetDrawStyle(WebCalendar.TitleStyle.Default, FTitleDefStyle);
  TxtSize := CalcStylishTextExtent(Canvas, AStyle, 'Wg');
  //todo: prev, next images
  DrawRect.Bottom := DrawRect.Top + TxtSize.cy;
  Inc(DrawRect.Bottom, AStyle.Borders.VertBordersSize);
  R.Top := DrawRect.Bottom;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  DrawStylishText(Canvas, DrawRect, AStyle, WebCalendar.PrevMonthText, thaLeft);
  Txt := WebCalendar.MonthNames[WebCalendar.CalendarSheet.Month];
  if WebCalendar.ShowYear then
    Txt := Txt + ' ' + IntToStr(WebCalendar.CalendarSheet.Year);
  DrawStylishText(Canvas, DrawRect, AStyle, Txt, thaCenter, tvaNone, False);
  DrawStylishText(Canvas, DrawRect, AStyle, WebCalendar.NextMonthText, thaRight, tvaNone, False);
  AStyle.Free;
end;

procedure TcxWebDesignCalendar.DrawHeader(var R: TRect);
var
  TxtSize: TSize;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  I, Off, Idx: Integer;
begin
  DrawRect := R;
  AStyle := GetDrawStyle(WebCalendar.DayHeaderStyle.Default, FDayHeaderDefStyle);
  TxtSize := CalcStylishTextExtent(Canvas, AStyle, 'Wg');
  DrawRect.Bottom := DrawRect.Top + TxtSize.cy;
  Off := WebCalendar.CellPadding + WebCalendar.CellSpacing;
  Inc(DrawRect.Bottom, Off * 2);
  Inc(DrawRect.Bottom, AStyle.Borders.VertBordersSize);
  R.Top := DrawRect.Bottom;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  if wsavColor in AStyle.Shading.AssignedValues then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := AStyle.Shading.Color;
    Canvas.FillRect(DrawRect);
  end;
  DrawRect.Right := (DrawRect.Right - DrawRect.Left) div 7 + DrawRect.Left;
  InflateRect(DrawRect, -Off, -Off);
  Idx := WebCalendar.CalendarSheet.StartOfWeek + 1;
  for I := 1 to 7 do
  begin
    DrawStylishText(Canvas, DrawRect, AStyle, WebCalendar.DaysOfWeekNames[Idx],
      thaCenter, tvaCenter, False);
    OffsetRect(DrawRect, Off * 2 + (DrawRect.Right - DrawRect.Left), 0);
    Inc(Idx);
    if Idx > 7 then Dec(Idx, 7);
  end;
  AStyle.Free;
end;

procedure TcxWebDesignCalendar.DrawSheet(var R: TRect);
var
  TxtSize: TSize;
  DrawRect, FirstCell, SaveRect: TRect;
  ASelStyle, AOtherStyle: TcxWebStyle;
  RowCnt, I, J, Off: Integer;
begin
  DrawRect := R;
  ASelStyle := GetDrawStyle(WebCalendar.SelectedStyle.Default, FSelectedDefStyle);
  AOtherStyle := GetDrawStyle(WebCalendar.OtherMonthDayStyle.Default, FOtherMonthDayDefStyle);
  TxtSize := CalcStylishTextExtent(Canvas, ControlWebStyle, 'Wg');
  if wsavColor in ControlWebStyle.Shading.AssignedValues then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := ControlWebStyle.Shading.Color;
    Canvas.FillRect(DrawRect);
  end;
  DrawRect.Right := (DrawRect.Right - DrawRect.Left) div 7 + DrawRect.Left;
  RowCnt := WebCalendar.CalendarSheet.DayCount div 7;
  if WebCalendar.CalendarSheet.DayCount mod 7 > 0 then
    Inc(RowCnt);
  DrawRect.Bottom := (DrawRect.Bottom - DrawRect.Top) div RowCnt + DrawRect.Top;
  Off := WebCalendar.CellPadding + WebCalendar.CellSpacing;
  InflateRect(DrawRect, -Off, -Off);
  FirstCell := DrawRect;
  for I := 0 to RowCnt - 1 do
  begin
    for J := 0 to 6 do
    begin
      if TcxCalendarSheetAccess(WebCalendar.CalendarSheet).IsSelectedDay(I*7 + J) then
      begin
        SaveRect := DrawRect;
        DrawStylishBorder(Canvas, ASelStyle.Borders, SaveRect);
        DrawStylishText(Canvas, SaveRect, ASelStyle,
          IntToStr(DayOf(WebCalendar.CalendarSheet.Dates[I*7 + J])),
          thaCenter, tvaCenter);
      end
      else
        if TcxCalendarSheetAccess(WebCalendar.CalendarSheet).IsOtherMonthDay(I*7 + J) then
        begin
          SaveRect := DrawRect;
          DrawStylishBorder(Canvas, AOtherStyle.Borders, SaveRect);
          DrawStylishText(Canvas, SaveRect, AOtherStyle,
            IntToStr(DayOf(WebCalendar.CalendarSheet.Dates[I*7 + J])),
            thaCenter, tvaCenter);
        end
        else
          DrawStylishText(Canvas, DrawRect, ControlWebStyle,
            IntToStr(DayOf(WebCalendar.CalendarSheet.Dates[I*7 + J])),
            thaCenter, tvaCenter, False);
      OffsetRect(DrawRect, Off * 2 + (DrawRect.Right - DrawRect.Left), 0);
    end;
    OffsetRect(DrawRect, 0, Off * 2 + (DrawRect.Bottom - DrawRect.Top));
    DrawRect.Left := FirstCell.Left;
    DrawRect.Right := FirstCell.Right;
  end;
  ASelStyle.Free;
  AOtherStyle.Free;
end;

procedure TcxWebDesignCalendar.DrawFooter(var R: TRect);
var
  TxtSize: TSize;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
begin
  DrawRect := R;
  AStyle := GetDrawStyle(WebCalendar.TodayPanelStyle.Default, FTodayPanelDefStyle);
  TxtSize := CalcStylishTextExtent(Canvas, AStyle, 'Wg');
  DrawRect.Top := DrawRect.Bottom - TxtSize.cy;
  Dec(DrawRect.Top, AStyle.Borders.VertBordersSize);
  R.Bottom := DrawRect.Top;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  DrawStylishText(Canvas, DrawRect, AStyle, 'Today', thaCenter);
  AStyle.Free;
end;

procedure TcxWebDesignCalendar.DrawInterior(var R: TRect);
begin
  DrawTitle(R);
  DrawHeader(R);
  if WebCalendar.ShowTodayLink then
    DrawFooter(R);
  DrawSheet(R);
end;

function TcxWebDesignCalendar.GetInternalWebControl: TcxCustomWebCalendar;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebCalendar;
end;

procedure TcxWebDesignCalendar.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clWebBlack;
    Borders.Width := 1;
    Borders.Style := wbsSolid;
    Shading.Color := clWebWhite;
    Shading.AssignedValues := [wsavColor];
  end;
  with FDayHeaderDefStyle do
  begin
    Shading.Color := clWebGray;
    Shading.AssignedValues := [wsavColor];
  end;
  with FOtherMonthDayDefStyle do
  begin
    Shading.AssignedValues := [];
  end;
  with FSelectedDefStyle do
  begin
    Borders.Color := clWebRed;
    Borders.Width := 1;
    Borders.Style := wbsSolid;
    Shading.Color := clWebLightGrey;
    Shading.AssignedValues := [wsavColor];
  end;
  with FTitleDefStyle do
  begin
    Shading.Color := TcxWebColor($EEEEEE);
    Shading.AssignedValues := [wsavColor];
  end;
  with FTodayPanelDefStyle do
  begin
    Shading.Color := TcxWebColor($EEEEEE);
    Shading.AssignedValues := [wsavColor];
  end;
end;

{ TcxWebDesignDateEdit }

constructor TcxWebDesignDateEdit.Create(AOwner: TComponent);
begin
  FButtonDefStyle := TcxWebStyle.Create(nil);
  inherited;
  FButtonImage := TBitmap.Create;
  FButtonImage.LoadFromResourceName(HInstance, 'CXWEBDATEEDIT');
  FButtonImage.Transparent := True;
end;

procedure TcxWebDesignDateEdit.DefineDefaultWebStyle;
begin
  inherited;
  with FButtonDefStyle do
  begin
    Borders.Color := clWebButtonHighlight;
    Borders.Width := 2;
    Borders.Style := wbsOutset;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
    Borders.Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
  end;
end;

destructor TcxWebDesignDateEdit.Destroy;
begin
  FButtonDefStyle.Free;
  FButtonImage.Free;
  inherited;
end;

procedure TcxWebDesignDateEdit.DrawButton(var R: TRect);
var
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  OffX, OffY: Integer;
begin
  DrawRect := R;
  Dec(R.Right, WebDateEdit.ButtonWidth);
  DrawRect.Left := R.Right;
  AStyle := GetDrawStyle(WebDateEdit.ButtonStyles.Default, FButtonDefStyle);
  with Canvas do
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := WebColorToColor(AStyle.Shading.Color);
    FillRect(DrawRect);
  end;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  OffX := (DrawRect.Right - DrawRect.Left - FButtonImage.Width) div 2;
  OffY := (DrawRect.Bottom - DrawRect.Top - FButtonImage.Height) div 2;
  Canvas.Draw(DrawRect.Left + OffX, Drawrect.Top + OffY, FButtonImage);
  AStyle.Free;
end;

procedure TcxWebDesignDateEdit.DrawFace;
var
  R: TRect;
begin
  R := ClientRect;
  DrawButton(R);
  DrawBorder(R);
  DrawStylishText(Canvas, R, ControlWebStyle, GetControlText, thaLeft, tvaCenter);
end;

function TcxWebDesignDateEdit.GetControlText: string;
begin
  Result := DateToStr(WebDateEdit.SelectedDate);
end;

function TcxWebDesignDateEdit.GetInternalWebControl: TcxCustomWebDateEdit;
begin
  Result := inherited GetInternalWebControl as TcxCustomWebDateEdit;
end;

function TcxWebDesignDateEdit.GetMainControlStyles: TcxWebStyles;
begin
  Result := WebDateEdit.EditorStyles;
end;

{TcxWebDesignCustomTable}

constructor TcxWebDesignCustomTable.Create(AOwner: TComponent);
begin
  FPagingDefStyle := TcxWebStyle.Create(nil);
  FPagingNumDefStyle := TcxWebStyle.Create(nil);
  FItemsDefStyle := TcxWebStyle.Create(nil);
  FHeaderDefStyle := TcxWebStyle.Create(nil);
  inherited;
end;

destructor TcxWebDesignCustomTable.Destroy;
begin
  FHeaderDefStyle.Free;
  FPagingDefStyle.Free;
  FPagingNumDefStyle.Free;
  FItemsDefStyle.Free;
  inherited;
end;

procedure TcxWebDesignCustomTable.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Left.Color := clWebThreeDHighlight;
    Borders.Top.Color := clWebThreeDHighlight;
    Borders.Right.Color := clWebThreeDShadow;
    Borders.Bottom.Color := clWebThreeDShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
  with FHeaderDefStyle do
  begin
    Borders.Right.Color := clWebThreeDHighlight;
    Borders.Bottom.Color := clWebThreeDHighlight;
    Borders.Left.Color := clWebThreeDShadow;
    Borders.Top.Color := clWebThreeDShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
  with FPagingDefStyle do
  begin
    Borders.Right.Color := clWebThreeDHighlight;
    Borders.Bottom.Color := clWebThreeDHighlight;
    Borders.Left.Color := clWebThreeDShadow;
    Borders.Top.Color := clWebThreeDShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
  with FPagingNumDefStyle do
  begin
    Borders.Width := 0;
    Borders.Left.AssignedValues := [wbavWidth];
    Borders.Top.AssignedValues := [wbavWidth];
    Borders.Right.AssignedValues := [wbavWidth];
    Borders.Bottom.AssignedValues := [wbavWidth];
    Shading.AssignedValues := [];
  end;
  with FItemsDefStyle do
  begin
    Borders.Right.Color := clWebThreeDHighlight;
    Borders.Bottom.Color := clWebThreeDHighlight;
    Borders.Left.Color := clWebThreeDShadow;
    Borders.Top.Color := clWebThreeDShadow;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWindow;
    Shading.AssignedValues := [wsavColor];
  end;
end;

function TcxWebDesignCustomTable.GetInternalWebControl: TcxAccessWebTable;
begin
  Result := TcxAccessWebTable(inherited GetInternalWebControl as TcxCustomWebTable);
end;

function TcxWebDesignCustomTable.GetColumnWidth(AColumn: TcxCustomWebTableColumn): Integer;
var
  I, FixedWidth, FixedCount: Integer;
  MaxWidth: Integer;
begin
  Result := AColumn.Width;
  if Result = 0 then
  begin
    FixedWidth := 0;
    FixedCount := 0;
    for I := 0 to Table.Columns.Count - 1 do
      if Table.Columns[I].Width > 0 then
      begin
        Inc(FixedWidth, Table.Columns[I].Width);
        Inc(FixedCount);
      end;
    MaxWidth := Table.Width - ControlWebStyle.Borders.HorzBordersSize -
      Table.CellSpacing * (2 + Table.Columns.Count - 1);
    Result := (MaxWidth - FixedWidth) div (Table.Columns.Count - FixedCount);
  end;
end;

procedure TcxWebDesignCustomTable.DrawInterior(var R: TRect);
begin
  DrawPagings(R);
  if Table.ShowHeaders then
    DrawHeader(R);
  DrawItems(R);
end;

procedure TcxWebDesignCustomTable.DrawPagings(var ARect: TRect);
var
  AHeight: Integer;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
begin
  if (Table.Paging.PagingType = tptNone) or (Table.Paging.MaxPageIndex = 0) then exit;
  DrawRect := ARect;
  if Table.Styles.Default <> nil then
    AStyle := GetDrawStyle(Table.PagingStyles.Default, ControlWebStyle)
  else
    AStyle := GetDrawStyle(Table.PagingStyles.Default, FPagingDefStyle);
  AHeight := CalcStylishTextExtent(Canvas, AStyle, 'Wg').cy;
  if Table.Paging.PagingType in [tptTop, tptBoth] then
  begin
    DrawRect.Bottom := ARect.Top + AHeight;
    Inc(DrawRect.Bottom, (Table.CellPadding + Table.CellSpacing) * 2);
    Inc(DrawRect.Bottom, AStyle.Borders.VertBordersSize);
    ARect.Top := DrawRect.Bottom;
    InflateRect(DrawRect, -Table.CellSpacing, -Table.CellSpacing);
    DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
    if wsavColor in AStyle.Shading.AssignedValues then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := AStyle.Shading.Color;
      Canvas.FillRect(DrawRect);
    end;
    InflateRect(DrawRect, -Table.CellPadding, -Table.CellPadding);
    DrawPaging(DrawRect);
  end;
  DrawRect := ARect;
  if Table.Paging.PagingType in [tptBottom, tptBoth] then
  begin
    DrawRect.Top := ARect.Bottom - AHeight;
    Dec(DrawRect.Top, (Table.CellPadding + Table.CellSpacing) * 2);
    Dec(DrawRect.Top, AStyle.Borders.VertBordersSize);
    ARect.Bottom := DrawRect.Top;
    InflateRect(DrawRect, -Table.CellSpacing, -Table.CellSpacing);
    DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
    if wsavColor in AStyle.Shading.AssignedValues then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := AStyle.Shading.Color;
      Canvas.FillRect(DrawRect);
    end;
    InflateRect(DrawRect, -Table.CellPadding, -Table.CellPadding);
    DrawPaging(DrawRect);
  end;
  AStyle.Free;
end;

procedure TcxWebDesignCustomTable.DrawPaging(ARect: TRect);
var
  Str: string;
  I, StrWidth: Integer;
  AStyle: TcxWebStyle;
  AParentStyleItem: TcxWebStyleItem;
  DrawRect: TRect;
begin
  // TODO: each element should be drawn separately
  // TODO: SelectingPagingNumbersStyles support
  if Table.GetPageIndex = Table.Paging.StartPageIndex then
    Str := '<'
  else
    Str := '<<';
  for I := Table.Paging.StartPageIndex to Table.Paging.EndPageIndex - 1 do
  begin
    Str := Str + ' ' + IntToStr(I + 1) + ' ';
  end;
  if Table.Paging.EndPageIndex = Table.Paging.MaxPageIndex then
    Str := Str + '>'
  else
    Str := Str + '>>';
  AParentStyleItem := Table.PagingStyles.Default;
  if AParentStyleItem = nil then
    AParentStyleItem := Table.Styles.Default;
  AStyle := GetDrawStyle(Table.PagingNumbersStyles.Default, FPagingNumDefStyle);
  if AParentStyleItem <> nil then
  begin
    AStyle.Merge(AParentStyleItem.Style);
    if Table.PagingNumbersStyles.Default = nil then
      AStyle.Font.Assign(AParentStyleItem.Style.Font);
  end;
  StrWidth := CalcStylishTextExtent(Canvas, AStyle, Str).cx + AStyle.Borders.HorzBordersSize;
  case Table.Paging.Alignment of
    whalCenter:
      DrawRect := Bounds(ARect.Left + (ARect.Right - ARect.Left - StrWidth) div 2,
        ARect.Top, StrWidth, ARect.Bottom - ARect.Top);
    whalRight:
      DrawRect := Bounds(ARect.Right - StrWidth, ARect.Top, StrWidth, ARect.Bottom - ARect.Top);
  else
    DrawRect := Bounds(ARect.Left, ARect.Top, StrWidth, ARect.Bottom - ARect.Top);
  end;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  DrawStylishText(Canvas, DrawRect, AStyle, Str);
  AStyle.Free;
end;

procedure TcxWebDesignCustomTable.DrawHeader(var ARect: TRect);
var
  AHeight, I: Integer;
  DrawRect: TRect;
  AStyle: TcxWebStyle;
begin
  if Table.Columns.Count = 0 then Exit;
  DrawRect := ARect;
  if Table.Styles.Default <> nil then
    AStyle := GetDrawStyle(Table.HeaderStyles.Default, ControlWebStyle)
  else
    AStyle := GetDrawStyle(Table.HeaderStyles.Default, FHeaderDefStyle);
  AHeight := CalcStylishTextExtent(Canvas, AStyle, 'Wg').cy;
  DrawRect.Bottom := ARect.Top + AHeight;
  Inc(DrawRect.Bottom, Table.CellPadding * 2 + Table.CellSpacing);
  Inc(DrawRect.Bottom, AStyle.Borders.VertBordersSize);
  ARect.Top := DrawRect.Bottom;
  InflateRect(DrawRect, -Table.CellSpacing, 0);
  Dec(DrawRect.Bottom, Table.CellSpacing);
  for I := 0 to Table.Columns.Count - 1 do
    DrawCell(I, AStyle, Table.Columns[I].TitleAlignment, Table.Columns[I].Title, DrawRect);
  AStyle.Free;
end;

procedure TcxWebDesignCustomTable.DrawCell(Index: Integer; AStyle: TcxWebStyle;
  AAlignment: TcxWebHorzAlignment; Text: string; var ARect: TRect);
var
  DrawRect: TRect;
  Alignment: TcxTextHAlignment;
begin
  DrawRect := ARect;
  if Index <> Table.Columns.Count - 1 then
  begin
    DrawRect.Right := DrawRect.Left + GetColumnWidth(Table.Columns[Index]);
    ARect.Left := DrawRect.Right + Table.CellSpacing;
  end
  else
    DrawRect.Right := ARect.Right;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  if wsavColor in AStyle.Shading.AssignedValues then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := AStyle.Shading.Color;
    Canvas.FillRect(DrawRect);
  end;
  case AAlignment of
    whalCenter: Alignment := thaCenter;
    whalLeft: Alignment := thaLeft;
    whalRight: Alignment := thaRight;
  else
    Alignment := thaNone;
  end;
  InflateRect(DrawRect, -Table.CellPadding, -Table.CellPadding);
  DrawStylishText(Canvas, DrawRect, AStyle, Text, Alignment, tvaCenter, False);
end;

procedure TcxWebDesignCustomTable.DrawItems(var ARect: TRect);
var
  I: Integer;
begin
  if Table.GetEndRowIndex < Table.GetStartRowIndex then Exit;
  for I := Table.GetStartRowIndex to Table.GetEndRowIndex do
    DrawRow(I, ARect);
end;

procedure TcxWebDesignCustomTable.DrawRow(AIndex: Integer; var ARect: TRect);
var
  ARowStyle, ACellStyle: TcxWebStyle;
  AHeight: Integer;
  I: Integer;
  DrawRect: TRect;
begin
  if ARect.Bottom < ARect.Top then Exit;
  DrawRect := ARect;
  if Table.Styles.Default <> nil then
    ARowStyle := GetDrawStyle(Table.ItemsStyles.Default, ControlWebStyle)
  else
    ARowStyle := GetDrawStyle(Table.ItemsStyles.Default, FItemsDefStyle);
  if (Table.AlternatingItemsStyles.Default <> nil) and
    Odd(AIndex - Table.GetStartRowIndex) then
  begin
    ARowStyle.Free;
    if Table.Styles.Default <> nil then
      ARowStyle := GetDrawStyle(Table.AlternatingItemsStyles.Default, ControlWebStyle)
    else
      ARowStyle := GetDrawStyle(Table.AlternatingItemsStyles.Default, FItemsDefStyle);
  end;
  AHeight := CalcStylishTextExtent(Canvas, ARowStyle, 'Wg').cy;
  DrawRect.Bottom := ARect.Top + AHeight;
  Inc(DrawRect.Bottom, Table.CellPadding * 2 + Table.CellSpacing);
  Inc(DrawRect.Bottom, ARowStyle.Borders.VertBordersSize);
  ARect.Top := DrawRect.Bottom;
  InflateRect(DrawRect, -Table.CellSpacing, 0);
  Dec(DrawRect.Bottom, Table.CellSpacing);
  if DrawRect.Bottom > ARect.Bottom then
  begin
    DrawRect.Bottom := ARect.Bottom;
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := clWhite;
      Pen.Style := psSolid;
      Pen.Width := 1;
      Pen.Color := clRed;
      Rectangle(DrawRect);
      PenPos := DrawRect.TopLeft;
      LineTo(DrawRect.Right - 1, DrawRect.Bottom - 1);
      MoveTo(DrawRect.Right - 1, DrawRect.Top);
      LineTo(DrawRect.Left, DrawRect.Bottom - 1);
    end;
    Exit;
  end;
  for I := 0 to Table.Columns.Count - 1 do
  begin
    ACellStyle := GetDrawStyle(Table.Columns[I].Styles.Default, ARowStyle);
    DrawCell(I, ACellStyle, Table.Columns[I].Alignment,
      Table.GetDisplayText(Table.Columns[I], AIndex), DrawRect);
    ACellStyle.Free;
  end;
  ARowStyle.Free;
end;

{ TcxWebDesignExtDBLookup }

constructor TcxWebDesignExtDBLookup.Create(AOwner: TComponent);
begin
  FButtonDefStyle := TcxWebStyle.Create(nil);
  inherited;
  FButtonImage := TBitmap.Create;
  FButtonImage.LoadFromResourceName(HInstance, 'CXWEBDATEEDIT');
  FButtonImage.Transparent := True;
end;

procedure TcxWebDesignExtDBLookup.DefineDefaultWebStyle;
begin
  inherited;
  with FButtonDefStyle do
  begin
    Borders.Color := clWebButtonHighlight;
    Borders.Width := 2;
    Borders.Style := wbsOutset;
    Shading.Color := clWebButtonFace;
    Shading.AssignedValues := [wsavColor];
    Borders.Left.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Top.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Right.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
    Borders.Bottom.AssignedValues := [wbavColor, wbavStyle, wbavWidth];
  end;
end;

destructor TcxWebDesignExtDBLookup.Destroy;
begin
  FButtonDefStyle.Free;
  FButtonImage.Free;
  inherited;
end;

procedure TcxWebDesignExtDBLookup.DrawButton(var R: TRect);
var
  DrawRect: TRect;
  AStyle: TcxWebStyle;
  OffX, OffY: Integer;
begin
  DrawRect := R;
  Dec(R.Right, WebExtDBLookup.ButtonWidth);
  DrawRect.Left := R.Right;
  AStyle := GetDrawStyle(WebExtDBLookup.ButtonStyles.Default, FButtonDefStyle);
  with Canvas do
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := WebColorToColor(AStyle.Shading.Color);
    FillRect(DrawRect);
  end;
  DrawStylishBorder(Canvas, AStyle.Borders, DrawRect);
  OffX := (DrawRect.Right - DrawRect.Left - FButtonImage.Width) div 2;
  OffY := (DrawRect.Bottom - DrawRect.Top - FButtonImage.Height) div 2;
  Canvas.Draw(DrawRect.Left + OffX, Drawrect.Top + OffY, FButtonImage);
  AStyle.Free;
end;

procedure TcxWebDesignExtDBLookup.DrawFace;
var
  R: TRect;
begin
  R := ClientRect;
  DrawButton(R);
  DrawBorder(R);
  DrawStylishText(Canvas, R, ControlWebStyle, GetControlText, thaLeft, tvaCenter);
end;

function TcxWebDesignExtDBLookup.GetControlText: string;
begin
  Result := WebExtDBLookup.Text;
end;

function TcxWebDesignExtDBLookup.GetInternalWebControl: TcxWebExtDBLookup;
begin
  Result := inherited GetInternalWebControl as TcxWebExtDBLookup;
end;

function TcxWebDesignExtDBLookup.GetMainControlStyles: TcxWebStyles;
begin
  Result := WebExtDBLookup.EditorStyles;
end;

{ TcxWebDesignNavBar }

constructor TcxWebDesignNavBar.Create(AOwner: TComponent);
begin
  FHeaderDefStyle := TcxWebStyle.Create(nil);
  FColHeaderDefStyle := TcxWebStyle.Create(nil);
  inherited;
  FLeftColImage := TBitmap.Create;
  FLeftColImage.LoadFromResourceName(HInstance, 'CXWEBNB_LEFTCOL');
  FLeftColImage.Transparent := True;
  FLeftExpImage := TBitmap.Create;
  FLeftExpImage.LoadFromResourceName(HInstance, 'CXWEBNB_LEFTEXP');
  FLeftExpImage.Transparent := True;
  FRightColImage := TBitmap.Create;
  FRightColImage.LoadFromResourceName(HInstance, 'CXWEBNB_RIGHTCOL');
  FRightColImage.Transparent := True;
  FRightExpImage := TBitmap.Create;
  FRightExpImage.LoadFromResourceName(HInstance, 'CXWEBNB_RIGHTEXP');
  FRightExpImage.Transparent := True;
end;

destructor TcxWebDesignNavBar.Destroy;
begin
  FHeaderDefStyle.Free;
  FColHeaderDefStyle.Free;
  FLeftColImage.Free;
  FLeftExpImage.Free;
  FRightColImage.Free;
  FRightExpImage.Free;
  inherited;
end;


procedure TcxWebDesignNavBar.DrawGroup(Index: Integer; var XPos, YPos: Integer);
begin
  DrawGroupHeader(Index, XPos, YPos);
  if WebNavBar.Groups[Index].Expanded then
    DrawGroupBody(Index, XPos, YPos);
  Inc(YPos, 2);
end;

procedure TcxWebDesignNavBar.DrawGroupHeader(Index: Integer; var XPos, YPos: Integer);
var
  R: TRect;
  AStyle: TcxWebStyle;
  H: Integer;
  ALeftImage, ARightImage: TBitmap;
begin
  if WebNavBar.Groups[Index].Expanded then
  begin
    AStyle := GetDrawStyle(WebNavBar.HeaderStyles.Default, FHeaderDefStyle);
    H := Max(FLeftExpImage.Height, FRightExpImage.Height);
    ALeftImage := FLeftExpImage;
    ARightImage := FRightExpImage;
  end
  else
  begin
    AStyle := GetDrawStyle(WebNavBar.HeaderCollapsedStyles.Default, FColHeaderDefStyle);
    H := Max(FLeftColImage.Height, FRightColImage.Height);
    ALeftImage := FLeftColImage;
    ARightImage := FRightColImage;
  end;
  H := Max(H, CalcStylishTextExtent(Canvas, AStyle, 'Wq').cx);
  R := Bounds(XPos, YPos, WebNavBar.Width - 1, H);
  with Canvas do
  begin
    Brush.Style := bsSolid;
    Brush.Color := WebColorToColor(AStyle.Shading.Color);
    Pen.Style := psSolid;
    Pen.Width := 1; // AStyle.Borders.Width;
    Pen.Color := WebColorToColor(AStyle.Borders.Color);
    Polygon([Point(R.Left + 2, R.Top), Point(R.Right - 2, R.Top),
      Point(R.Right, R.Top + 2), Point(R.Right, R.Bottom),
      Point(R.Left, R.Bottom), Point(R.Left, R.Top + 2)]);
    Draw(R.Left + 2, R.Top + (R.Bottom - R.Top - ALeftImage.Height) div 2, ALeftImage);
  end;
  Inc(R.Left, ALeftImage.Width + 3);
  DrawStylishText(Canvas, R, AStyle, WebNavBar.Groups[Index].Text, thaLeft, tvaCenter, False);
  Canvas.Draw(R.Right - ARightImage.Width - 2, R.Top + (R.Bottom - R.Top - ARightImage.Height) div 2, ARightImage);
  XPos := 0;
  YPos := R.Bottom + 1;
  AStyle.Free;
end;

procedure TcxWebDesignNavBar.DrawGroupBody(Index: Integer; var XPos, YPos: Integer);
var
  I, ItemCount: Integer;
  R, ARect: TRect;
  H: Integer;
begin
  H := CalcStylishTextExtent(Canvas, ControlWebStyle, 'Wq').cx + WebNavBar.SeparatorWidth;
  ItemCount := WebNavBar.Groups[Index].Items.Count;
  with Canvas do
  begin
    R := Bounds(XPos, YPos, WebNavBar.Width, H * ItemCount);
    Brush.Style := bsSolid;
    Brush.Color := WebColorToColor(ControlWebStyle.Shading.Color);
    FillRect(R);
    Pen.Style := psSolid;
    Pen.Width := 1; // ControlWebStyle.Borders.Width
    Pen.Color := WebColorToColor(ControlWebStyle.Borders.Color);
    MoveTo(R.Left, R.Top);
    LineTo(R.Left, R.Bottom);
    LineTo(R.Right - 1, R.Bottom);
    LineTo(R.Right - 1, R.Top - 1);
  end;
  for I := 0 to ItemCount - 1 do
  begin
    R := Bounds(XPos + 26, YPos, WebNavBar.Width - 1, H);
    Canvas.Brush.Color := WebColorToColor(ControlWebStyle.Font.Color);
    Canvas.Pen.Color := WebColorToColor(ControlWebStyle.Font.Color);
    ARect := Bounds(R.Left, R.Top + H div 2 - 3, 5, 5);
    Canvas.Ellipse(ARect);
    Inc(R.Left, 26);
    DrawStylishText(Canvas, R, ControlWebStyle, WebNavBar.Groups[Index].Items[I].Text, thaLeft, tvaCenter, False);
    XPos := 0;
    YPos := R.Bottom;
  end;
end;

procedure TcxWebDesignNavBar.DrawInterior(var R: TRect);
var
  I, XPos, YPos: Integer;
begin
  if WebNavBar.Groups.Count = 0 then
  with Canvas do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBtnShadow;
    Pen.Style := psSolid;
    Pen.Width := 1;
    Rectangle(R);
    Canvas.Font.Color := clBtnShadow;
    Canvas.Font.Style := [];
    Canvas.Font.Size := 10;
    DoTextRect(Canvas, R, R.Left, R.Top, '(no items)', thaCenter, tvaCenter);
    Exit;
  end;
  XPos := 0;
  YPos := 0;
  for I := 0 to WebNavBar.Groups.Count - 1 do
    DrawGroup(I, XPos, YPos);
end;

procedure TcxWebDesignNavBar.DrawFace;
var
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Style := bsClear;
  WebFontToFont(ControlWebStyle.Font, Canvas.Font);
  DrawInterior(R);
end;

procedure TcxWebDesignNavBar.DefineDefaultWebStyle;
begin
  inherited;
  with DefaultWebStyle do
  begin
    Borders.Color := clWebSteelBlue;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebWhite;
    Shading.AssignedValues := [wsavColor];
    Font.Color := clWebDarkSlateGray;
  end;
  with FHeaderDefStyle do
  begin
    Borders.Color := clWebSteelBlue;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebSteelBlue;
    Shading.AssignedValues := [wsavColor];
    Font.Color := clWebWhite;
  end;
  with FColHeaderDefStyle do
  begin
    Borders.Color := clWebDarkGray;
    Borders.Style := wbsSolid;
    Borders.Width := 1;
    Shading.Color := clWebSilver;
    Shading.AssignedValues := [wsavColor];
    Font.Color := clWebDarkBlue;
  end;
end;

function TcxWebDesignNavBar.GetInternalWebControl: TcxWebNavBar;
begin
  Result := inherited GetInternalWebControl as TcxWebNavBar;
end;

{ registration helpers }
procedure RegisterDesignControls;
begin
  with WebDesignControlsFactory do
  begin
    RegisterDesignControl(TcxWebControl, TcxWebDesignControl);
    RegisterDesignControl(TcxWebCustomControl, TcxWebDesignCustomControl);
    RegisterDesignControl(TcxCustomWebLabel, TcxWebDesignLabel);
    RegisterDesignControl(TcxWebButton, TcxWebDesignButton);
    RegisterDesignControl(TcxCustomWebEdit, TcxWebDesignEdit);
    RegisterDesignControl(TcxCustomWebMemo, TcxWebDesignMemo);
    RegisterDesignControl(TcxCustomWebListBox, TcxWebDesignListBox);
    RegisterDesignControl(TcxCustomWebComboBox, TcxWebDesignComboBox);
    RegisterDesignControl(TcxCustomWebCheckBox, TcxWebDesignCheckBox);
    RegisterDesignControl(TcxCustomWebRadioGroup, TcxWebDesignRadioGroup);
    RegisterDesignControl(TcxCustomWebImage, TcxWebDesignImage);
    RegisterDesignControl(TcxCustomWebGrid, TcxWebDesignCustomGrid);
    RegisterDesignControl(TcxCustomWebDataNavigator, TcxWebDesignDataNavigator);
    RegisterDesignControl(TcxWebTreeView, TcxWebDesignTreeView);
    RegisterDesignControl(TcxWebPanel, TcxWebDesignPanel);
    RegisterDesignControl(TcxWebMainMenu, TcxWebDesignMainMenu);
    RegisterDesignControl(TcxCustomWebCalendar, TcxWebDesignCalendar);
    RegisterDesignControl(TcxCustomWebDateEdit, TcxWebDesignDateEdit);
    RegisterDesignControl(TcxCustomWebTable, TcxWebDesignCustomTable);
    RegisterDesignControl(TcxWebExtDBLookup, TcxWebDesignExtDBLookup);
    RegisterDesignControl(TcxWebNavBar, TcxWebDesignNavBar);
  end;
end;

procedure UnregisterDesignControls;
begin
  with WebDesignControlsFactory do
  begin
    UnregisterDesignControl(TcxWebDesignNavBar);
    UnregisterDesignControl(TcxWebDesignExtDBLookup);
    UnregisterDesignControl(TcxWebDesignCustomTable);
    UnregisterDesignControl(TcxWebDesignDateEdit);
    UnregisterDesignControl(TcxWebDesignCalendar);
    UnregisterDesignControl(TcxWebDesignMainMenu);
    UnregisterDesignControl(TcxWebDesignPanel);
    UnregisterDesignControl(TcxWebDesignTreeView);
    UnregisterDesignControl(TcxWebDesignDataNavigator);
    UnregisterDesignControl(TcxWebDesignCustomGrid);
    UnregisterDesignControl(TcxWebDesignImage);
    UnregisterDesignControl(TcxWebDesignRadioGroup);
    UnregisterDesignControl(TcxWebDesignCheckBox);
    UnregisterDesignControl(TcxWebDesignComboBox);
    UnregisterDesignControl(TcxWebDesignListBox);
    UnregisterDesignControl(TcxWebDesignMemo);
    UnregisterDesignControl(TcxWebDesignEdit);
    UnregisterDesignControl(TcxWebDesignButton);
    UnregisterDesignControl(TcxWebDesignLabel);
    UnregisterDesignControl(TcxWebDesignCustomControl);
    UnregisterDesignControl(TcxWebDesignControl);
  end;
end;

initialization
  RegisterDesignControls;
  FCanvasBrush := TBrush.Create;
  FCanvasFont := TFont.Create;
  FCanvasPen := TPen.Create;

finalization
  UnregisterDesignControls;
  FCanvasBrush.Free;
  FCanvasFont.Free;
  FCanvasPen.Free;

end.

