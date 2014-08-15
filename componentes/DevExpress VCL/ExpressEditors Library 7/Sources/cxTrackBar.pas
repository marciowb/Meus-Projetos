
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
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

unit cxTrackBar;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Types, Variants,
{$ENDIF}
  Windows, Classes, Controls, Forms, Graphics, Messages, SysUtils, cxClasses,
  cxContainer, cxControls, cxCustomData, cxEdit, cxExtEditConsts, cxLookAndFeelPainters,
  cxFilterControlUtils, cxGraphics, cxLookAndFeels, cxTextEdit, cxVariants, Math;

type
  TcxTrackBarOrientation = (tboHorizontal, tboVertical);
  TcxTrackBarTextOrientation = (tbtoHorizontal, tbtoVertical);
  TcxTrackBarTickMarks = (cxtmBoth, cxtmTopLeft, cxtmBottomRight);
  TcxTrackBarTickType = (tbttTicks, tbttNumbers, tbttValueNumber);
  TcxTrackBarMouseState = (tbmpInControl, tbmpUnderThumb, tbmpSliding);
  TcxTrackBarMouseStates = set of TcxTrackBarMouseState;
  TcxTrackBarSlideState = (tbksNormal, tbksIncludeSelection);
  TcxTrackBarThumbType = (cxttNone, cxttRegular, cxttCustom);
  TcxTrackBarThumbStep = (cxtsNormal, cxtsJump);

  TcxGetThumbRectEvent = procedure(Sender: TObject; var ARect: TRect) of object;
  TcxDrawThumbEvent = procedure(Sender: TObject; ACanvas: TcxCanvas;
    const ARect: TRect) of object;

  { TcxTrackBarStyle }

  TcxTrackBarStyle = class(TcxEditStyle)
  protected
    function DefaultBorderStyle: TcxContainerBorderStyle; override;
    function DefaultHotTrack: Boolean; override;
  end;

  { TcxCustomTrackBarViewInfo }

  TcxCustomTrackBar = class;

  TcxCustomTrackBarViewInfo = class(TcxCustomTextEditViewInfo)
  private
    FLookAndFeel: TcxLookAndFeel;
    FPosition: Integer;
    FSelectionEnd: Integer;
    FSelectionStart: Integer;
    FShowSelection: Boolean;
    FTBBitmap: TBitmap;
    FTBCanvas: TcxCanvas;
    FThumbHeight: Integer;
    FThumbWidth: Integer;
    FTrackBarState: Integer;
    FTrackSize: Integer;
    function GetEdit: TcxCustomTrackBar;
  protected
    RealTrackBarRect: TRect;
    TrackBarRect: TRect;
    TrackZoneRect: TRect;
    TrackRect: TRect;
    ThumbRect: TRect;
    SelectionRect: TRect;
    FromBorderIndent: Integer;
    procedure DrawTrack(ACanvas: TcxCanvas); virtual;
    procedure DrawSelection(ACanvas: TcxCanvas); virtual;
    procedure DrawTicks(ACanvas: TcxCanvas); virtual;
    procedure DrawThumb(ACanvas: TcxCanvas); virtual;
    function DrawingThumbRectToRealThumbRect(ACanvas: TcxCanvas): TRect; virtual;
    function GetThumbThemeType: Byte; virtual;
    procedure PaintTrackBar(ACanvas: TcxCanvas); virtual;
  public
    FocusRect: TRect;
    HasForegroundImage: Boolean;
    MouseStates: TcxTrackBarMouseStates;

    Min: Integer;
    Max: Integer;
    Frequency: Integer;

    ThumbLargeSize: Integer;
    ThumbSize: Integer;

    TickColor: TColor;
    TickMarks: TcxTrackBarTickMarks;
    TickOffset: Double;
    TickType: TcxTrackBarTickType;
    TickSize: Integer;

    TrackRectDelta: Integer;
    TrackBarBorderWidth: Integer;
    TrackHeight: Integer;
    TrackWidth: Integer;

    Orientation: TcxTrackBarOrientation;
    TextOrientation: TcxTrackBarTextOrientation;

    procedure Assign(Source: TObject); override;
    procedure DrawText(ACanvas: TcxCanvas); override;
    function GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion; override;
    function IsHotTrack: Boolean; overload; override;
    function IsHotTrack(P: TPoint): Boolean; overload; override;
    function NeedShowHint(ACanvas: TcxCanvas; const P: TPoint; out AText: TCaption;
      out AIsMultiLine: Boolean; out ATextRect: TRect): Boolean; override;
    procedure Offset(DX, DY: Integer); override;
    procedure Paint(ACanvas: TcxCanvas); override;
    constructor Create; override;
    destructor Destroy; override;

    property Edit: TcxCustomTrackBar read GetEdit;
    property LookAndFeel: TcxLookAndFeel read FLookAndFeel write FLookAndFeel;

    property Position: Integer read FPosition write FPosition;
    property SelectionEnd: Integer read FSelectionEnd write FSelectionEnd;
    property SelectionStart: Integer read FSelectionStart write FSelectionStart;
    property ThumbHeight: Integer read FThumbHeight write FThumbHeight;
    property ThumbWidth: Integer read FThumbWidth write FThumbWidth;
    property TrackBarState: Integer read FTrackBarState write FTrackBarState;
    property TrackSize: Integer read FTrackSize write FTrackSize;
  end;

  { TcxCustomTrackBarViewData }

  TcxCustomTrackBarProperties = class;

  TcxCustomTrackBarViewData = class(TcxCustomEditViewData)
  private
    procedure GetOnGetThumbRect(out AValue: TcxGetThumbRectEvent);
    function GetProperties: TcxCustomTrackBarProperties;
  protected
    procedure CalculateCustomTrackBarRects(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    function InternalGetEditConstantPartSize(ACanvas: TcxCanvas; AIsInplace: Boolean;
      AEditSizeProperties: TcxEditSizeProperties;
      var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo): TSize; override;
    function GetTopLeftTickSize(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomTrackBarViewInfo; ALeftTop: Boolean): Integer; virtual;
    procedure CalculateTBViewInfoProps(AViewInfo: TcxCustomEditViewInfo); virtual;
    procedure CalculateTrackBarRect(AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure CalculateTrackZoneRect(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure CalculateTrackRect(AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure CalculateThumbSize(AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure CalculateThumbRect(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure CalculateSelectionRect(AViewInfo: TcxCustomTrackBarViewInfo); virtual;
    procedure DoOnGetThumbRect(var ARect: TRect);
    function IsOnGetThumbRectEventAssigned: Boolean;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect; const P: TPoint;
      Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
      AIsMouseEvent: Boolean); override;
    procedure EditValueToDrawValue(ACanvas: TcxCanvas; const AEditValue: TcxEditValue;
      AViewInfo: TcxCustomEditViewInfo); override;
    property Properties: TcxCustomTrackBarProperties read GetProperties;
  end;

  { TcxCustomTrackBarProperties }

  TcxCustomTrackBarProperties = class(TcxCustomEditProperties)
  private
    FAutoSize: Boolean;
    FBorderWidth: Integer;
    FFrequency: Integer;
    FMin: Integer;
    FMax: Integer;
    FOrientation: TcxTrackBarOrientation;
    FTextOrientation: TcxTrackBarTextOrientation;
    FPageSize: TcxNaturalNumber;
    FSelectionStart: Integer;
    FSelectionEnd: Integer;
    FSelectionColor: TColor;
    FShowTicks: Boolean;
    FThumbType: TcxTrackBarThumbType;
    FShowTrack: Boolean;
    FTickColor: TColor;
    FTickType: TcxTrackBarTickType;
    FTickMarks: TcxTrackBarTickMarks;
    FTickSize: TcxNaturalNumber;
    FTrackColor: TColor;
    FTrackSize: Integer;
    FTrackRect: TRect;
    FThumbRect: TRect;
    FThumbHeight: Integer;
    FThumbWidth: Integer;
    FThumbColor: TColor;
    FThumbHighlightColor: TColor;
    FThumbStep: TcxTrackBarThumbStep;
    FTickOffset: Double;
    FOnGetThumbRect: TcxGetThumbRectEvent;
    FOnDrawThumb: TcxDrawThumbEvent;
    procedure SetAutoSize(Value: Boolean);
    procedure SetBorderWidth(Value: Integer);
    procedure SetFrequency(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetOrientation(Value: TcxTrackBarOrientation);
    procedure SetTextOrientation(Value: TcxTrackBarTextOrientation);
    procedure SetPageSize(Value: TcxNaturalNumber);
    procedure SetSelectionStart(Value: Integer);
    procedure SetSelectionEnd(Value: Integer);
    procedure SetSelectionColor(Value: TColor);
    procedure SetShowTicks(Value: Boolean);
    procedure SetThumbType(Value: TcxTrackBarThumbType);
    procedure SetShowTrack(Value: Boolean);
    procedure SetTickColor(Value: TColor);
    procedure SetTickType(Value: TcxTrackBarTickType);
    procedure SetTickMarks(Value: TcxTrackBarTickMarks);
    procedure SetTickSize(Value: TcxNaturalNumber);
    procedure SetTrackColor(Value: TColor);
    procedure SetTrackSize(Value: Integer);
    procedure SetThumbHeight(Value: Integer);
    procedure SetThumbWidth(Value: Integer);
    procedure SetThumbColor(Value: TColor);
    procedure SetThumbHighlightColor(Value: TColor);
    procedure DoDrawThumb(Sender: TObject; ACanvas: TcxCanvas; const ARect: TRect);
  protected
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    function HasDisplayValue: Boolean; override;
    function FixPosition(const APosition: Integer): Integer; virtual;
    function EditValueToPosition(const AEditValue: TcxEditValue): Integer;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CanCompareEditValue: Boolean; override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    class function GetStyleClass: TcxCustomEditStyleClass; override;
    function GetSupportedOperations: TcxEditSupportedOperations; override;
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    function IsEditValueValid(var EditValue: TcxEditValue; AEditFocused: Boolean): Boolean; override;
    procedure PrepareDisplayValue(const AEditValue: TcxEditValue;
      var DisplayValue: TcxEditValue; AEditFocused: Boolean); override;
    // !!!
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth
      default 0;
    property Frequency: Integer read FFrequency write SetFrequency default 1;
    property Max: Integer read FMax write SetMax default 10;
    property Min: Integer read FMin write SetMin default 0;
    property Orientation: TcxTrackBarOrientation read FOrientation
      write SetOrientation default tboHorizontal;
    property PageSize: TcxNaturalNumber read FPageSize write SetPageSize
      default 1;
    property SelectionColor: TColor read FSelectionColor write SetSelectionColor
      default clHighlight;
    property SelectionEnd: Integer read FSelectionEnd write SetSelectionEnd
      default 0;
    property SelectionStart: Integer read FSelectionStart
      write SetSelectionStart default 0;
    property ShowTicks: Boolean read FShowTicks write SetShowTicks default True;
    property ShowTrack: Boolean read FShowTrack write SetShowTrack default True;
    property TextOrientation: TcxTrackBarTextOrientation read FTextOrientation
      write SetTextOrientation default tbtoHorizontal;
    property ThumbColor: TColor read FThumbColor write SetThumbColor
      default clBtnFace;
    property ThumbHeight: Integer read FThumbHeight write SetThumbHeight
      default 12;
    property ThumbHighlightColor: TColor read FThumbHighlightColor
      write SetThumbHighlightColor default clSilver;
    property ThumbStep: TcxTrackBarThumbStep read FThumbStep write FThumbStep
      default cxtsNormal;
    property ThumbType: TcxTrackBarThumbType read FThumbType write SetThumbType
      default cxttRegular;
    property ThumbWidth: Integer read FThumbWidth write SetThumbWidth default 7;
    property TickColor: TColor read FTickColor write SetTickColor
      default clWindowText;
    property TickMarks: TcxTrackBarTickMarks read FTickMarks write SetTickMarks
      default cxtmBottomRight;
    property TickSize: TcxNaturalNumber read FTickSize write SetTickSize
      default 3;
    property TickType: TcxTrackBarTickType read FTickType write SetTickType
      default tbttTicks;
    property TrackColor: TColor read FTrackColor write SetTrackColor
      default clWindow;
    property TrackSize : Integer read FTrackSize write SetTrackSize default 5;
    property OnDrawThumb: TcxDrawThumbEvent read FOnDrawThumb
      write FOnDrawThumb;
    property OnGetThumbRect: TcxGetThumbRectEvent read FOnGetThumbRect
      write FOnGetThumbRect;
  end;

  { TcxTrackBarProperties }
  
  TcxTrackBarProperties = class(TcxCustomTrackBarProperties)
  published
    property AutoSize;
    property BorderWidth;
    property ClearKey;
    property Frequency;
    property Max;
    property Min;
    property Orientation;
    property PageSize;
    property SelectionColor;
    property SelectionEnd;
    property SelectionStart;
    property ShowTicks;
    property ShowTrack;
    property TextOrientation;
    property ThumbColor;
    property ThumbHeight;
    property ThumbHighlightColor;
    property ThumbStep;
    property ThumbType;
    property ThumbWidth;
    property TickColor;
    property TickMarks;
    property TickSize;
    property TickType;
    property TrackColor;
    property TrackSize;
    property OnChange;
    property OnDrawThumb;
    property OnGetThumbRect;
  end;

  { TcxCustomTrackBar }
  
  TcxCustomTrackBar = class(TcxCustomEdit)
  private
    FSlideState: TcxTrackBarSlideState;
    FStartSelectionPosition: Integer;
    function GetStyle: TcxTrackBarStyle;
    procedure SetStyle(Value: TcxTrackBarStyle);
    procedure SetNewSelectionPosition(const ANewPosition: Integer);
    function GetPosition: Integer;
    procedure SetPosition(Value: Integer);
    function GetProperties: TcxCustomTrackBarProperties;
    function GetActiveProperties: TcxCustomTrackBarProperties;
    procedure GetOnGetThumbRect(out AValue: TcxGetThumbRectEvent);
    function GetViewInfo: TcxCustomTrackBarViewInfo;
    procedure SetProperties(Value: TcxCustomTrackBarProperties);
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    function DefaultParentColor: Boolean; override;
    procedure FillSizeProperties(var AEditSizeProperties: TcxEditSizeProperties); override;
    procedure Initialize; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure SynchronizeDisplayValue; override;
    function WantNavigationKeys: Boolean; override;
    procedure InternalSetPosition(Value: Integer);
    property ViewInfo: TcxCustomTrackBarViewInfo read GetViewInfo;
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxCustomTrackBarProperties
      read GetActiveProperties;
    property Position: Integer read GetPosition write SetPosition default 0;
    property Properties: TcxCustomTrackBarProperties read GetProperties
      write SetProperties;
    property Style: TcxTrackBarStyle read GetStyle write SetStyle;
    property Transparent;
  end;

  { TcxCustomTrackBar }
  
  TcxTrackBar = class(TcxCustomTrackBar)
  private
    function GetActiveProperties: TcxTrackBarProperties;
    function GetProperties: TcxTrackBarProperties;
    procedure SetProperties(Value: TcxTrackBarProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxTrackBarProperties read GetActiveProperties;
  published
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Position;
    property Properties: TcxTrackBarProperties read GetProperties
      write SetProperties;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  cxGeometry, dxThemeConsts, dxThemeManager, dxUxTheme,
  cxEditConsts, cxEditPaintUtils, cxEditUtils, cxExtEditUtils, cxSpinEdit;

const
  TrackAndTickOffset = 1;
  FromBorderIndent = 7;

type
  { TcxFilterTrackBarHelper }

  TcxFilterTrackBarHelper = class(TcxFilterSpinEditHelper)
  public
    class procedure InitializeProperties(AProperties,
      AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean); override;
  end;

procedure CalculateCustomTrackBarViewInfo(ACanvas: TcxCanvas; AViewData: TcxCustomTrackBarViewData;
  AViewInfo: TcxCustomTrackBarViewInfo);

  procedure CheckFocusRectBounds;
  begin
    with AViewInfo do
    begin
      if FocusRect.Left < TextRect.Left - 1 then
        FocusRect.Left := TextRect.Left - 1;
      if FocusRect.Top < TextRect.Top - 1 then
        FocusRect.Top := TextRect.Top - 1;
      if FocusRect.Right > TextRect.Right + 1 then
        FocusRect.Right := TextRect.Right + 1;
      if FocusRect.Bottom > TextRect.Bottom + 1 then
        FocusRect.Bottom := TextRect.Bottom + 1;
    end;
  end;

begin
  with AViewInfo do
  begin
    BackgroundColor := AViewData.Style.Color;
    if not IsInplace and Focused then
      if Length(Text) = 0 then
        FocusRect := cxEmptyRect
      else
      begin
        FocusRect := TextRect;
        InflateRect(FocusRect, 1, 1);
        CheckFocusRectBounds;
      end;
  end;
end;

{ TcxTrackBarStyle }

function TcxTrackBarStyle.DefaultBorderStyle: TcxContainerBorderStyle;
begin
  if IsBaseStyle then
    Result := cbsNone
  else
    Result := inherited DefaultBorderStyle;
end;

function TcxTrackBarStyle.DefaultHotTrack: Boolean;
begin
  Result := False;
end;

{ TcxCustomTrackBarViewInfo }

constructor TcxCustomTrackBarViewInfo.Create;
begin
  inherited Create;
  FLookAndFeel := TcxLookAndFeel.Create(nil);
  FTBBitmap := TBitmap.Create;
  FTBBitmap.PixelFormat := pfDevice;
  FTBCanvas := TcxCanvas.Create(FTBBitmap.Canvas);
  MouseStates := [];
end;

destructor TcxCustomTrackBarViewInfo.Destroy;
begin
  FreeAndNil(FTBBitmap);
  FreeAndNil(FTBCanvas);
  FreeAndNil(FLookAndFeel);
  inherited Destroy;
end;

procedure TcxCustomTrackBarViewInfo.Assign(Source: TObject);
begin
  inherited Assign(Source);
  if Source is TcxCustomTrackBarViewInfo then
    with Source as TcxCustomTrackBarViewInfo do
    begin
      Self.LookAndFeel.Assign(LookAndFeel);
      Self.Position := Position;
      Self.TrackSize := TrackSize;
      Self.ThumbWidth := ThumbWidth;
      Self.ThumbHeight := ThumbHeight;
      Self.TrackBarBorderWidth := TrackBarBorderWidth;
      Self.TrackBarState := TrackBarState;
      Self.SelectionStart := SelectionStart;
      Self.SelectionEnd := SelectionEnd;
    end;
end;

function TcxCustomTrackBarViewInfo.GetUpdateRegion(AViewInfo: TcxContainerViewInfo): TcxRegion;
begin
  Result := inherited GetUpdateRegion(AViewInfo);
  if not (AViewInfo is TcxCustomTrackBarViewInfo) then Exit;
end;

function TcxCustomTrackBarViewInfo.IsHotTrack: Boolean;
begin
  Result := True;
end;

function TcxCustomTrackBarViewInfo.IsHotTrack(P: TPoint): Boolean;
begin
  Result := True;
end;

function TcxCustomTrackBarViewInfo.NeedShowHint(ACanvas: TcxCanvas;
  const P: TPoint; out AText: TCaption; out AIsMultiLine: Boolean;
  out ATextRect: TRect): Boolean;
begin
  Result := False;
end;

procedure TcxCustomTrackBarViewInfo.DrawText(ACanvas: TcxCanvas);
begin
  {Dummy}
end;

procedure TcxCustomTrackBarViewInfo.Offset(DX, DY: Integer);
begin
  inherited Offset(DX, DY);
  OffsetRect(RealTrackBarRect, DX, DY);
end;

procedure TcxCustomTrackBarViewInfo.Paint(ACanvas: TcxCanvas);

  procedure FillBackground;
  var
    AIsCustomBackground: Boolean;
  begin
    if IsInplace then
    begin
      if Transparent then
        BitBlt(FTBCanvas.Canvas.Handle, 0, 0, FTBBitmap.Width, FTBBitmap.Height,
          ACanvas.Handle, Bounds.Left, Bounds.Top, SRCCOPY)
      else
      begin
        FTBCanvas.WindowOrg := Bounds.TopLeft;
        try
          AIsCustomBackground := DrawBackground(FTBCanvas);
        finally
          FTBCanvas.WindowOrg := Point(0, 0);
        end;
        if not AIsCustomBackground then
        begin
          FTBCanvas.Brush.Color := BackgroundColor;
          FTBCanvas.FillRect(Rect(0, 0, FTBBitmap.Width, FTBBitmap.Height));
        end;
      end;
    end
    else
      if Edit.Transparent or NativeStyle or UseSkins then
        cxDrawTransparentControlBackground(Edit, FTBCanvas, Bounds)
      else
        DrawCustomEdit(FTBCanvas, Self, True, bpsSolid);
  end;

var
  APrevClipRgn: TcxRegion;
begin
  FTBBitmap.Width := cxRectWidth(Bounds);
  FTBBitmap.Height := cxRectHeight(Bounds);

  FillBackground;

  APrevClipRgn := FTBCanvas.GetClipRegion;
  try
    FTBCanvas.SetClipRegion(TcxRegion.Create(TrackBarRect), roSet);
    PaintTrackBar(FTBCanvas);
  finally
    FTBCanvas.SetClipRegion(APrevClipRgn, roSet);
  end;
  BitBlt(ACanvas.Canvas.Handle, Bounds.Left, Bounds.Top,
    FTBBitmap.Width, FTBBitmap.Height,
    FTBCanvas.Handle, 0, 0, SRCCOPY);
end;

procedure TcxCustomTrackBarViewInfo.PaintTrackBar(ACanvas: TcxCanvas);
var
  AEditProperties: TcxCustomTrackBarProperties;
begin
  AEditProperties := TcxCustomTrackBarProperties(EditProperties);
  if AEditProperties.ShowTrack then
  begin
    DrawTrack(ACanvas);
    if FShowSelection then
      DrawSelection(ACanvas);
  end;
  if AEditProperties.ShowTicks then
    DrawTicks(ACanvas);
  case AEditProperties.ThumbType of
    cxttRegular:
      DrawThumb(ACanvas);
    cxttCustom:
      AEditProperties.DoDrawThumb(Self, ACanvas, ThumbRect);
  end;
end;

procedure TcxCustomTrackBarViewInfo.DrawTrack(ACanvas: TcxCanvas);
begin
  LookAndFeel.Painter.DrawTrackBarTrack(ACanvas, TrackRect, SelectionRect, FShowSelection,
    Enabled, Orientation = tboHorizontal, TcxCustomTrackBarProperties(EditProperties).TrackColor);
end;

procedure TcxCustomTrackBarViewInfo.DrawSelection(ACanvas: TcxCanvas);
begin
  if not UseSkins then
    cxEditFillRect(ACanvas, SelectionRect,
      TcxCustomTrackBarProperties(EditProperties).SelectionColor);
end;

procedure TcxCustomTrackBarViewInfo.DrawTicks(ACanvas: TcxCanvas);

  function NeedDrawTickAsLine(ATickValue: Integer): Boolean;
  begin
    Result := (TickType = tbttTicks) or ((TickType = tbttValueNumber) and
      not ((ATickValue = Min) or (ATickValue = Max) or (ATickValue = Position)));
  end;

  function GetTickOffset(AIndex: Integer): Integer;
  begin
    Result := Trunc(TickOffset * (AIndex - Min)) + (ThumbSize div 2);
  end;

  procedure DrawTickAsLine(AIndex, ATickPosition: Integer);
  var
    ATickSize: Integer;
  begin
    ATickSize := TickSize;
    if (AIndex = Min) or (AIndex = Max) then
      ATickSize := ATickSize + (TickSize div 2);

    if Orientation = tboVertical then
    begin
      if TickMarks in [cxtmBottomRight, cxtmBoth] then
      begin
        ACanvas.MoveTo(ThumbRect.Right + TrackAndTickOffset + 1, ATickPosition);
        ACanvas.LineTo(ThumbRect.Right + TrackAndTickOffset + ATickSize + 1, ATickPosition);
      end;
      if TickMarks in [cxtmTopLeft, cxtmBoth] then
      begin
        ACanvas.MoveTo(ThumbRect.Left - (TrackAndTickOffset + ATickSize), ATickPosition);
        ACanvas.LineTo(ThumbRect.left - TrackAndTickOffset, ATickPosition);
      end;
    end
    else
    begin
      if TickMarks in [cxtmBottomRight, cxtmBoth] then
      begin
        ACanvas.MoveTo(ATickPosition, ThumbRect.Bottom + TrackAndTickOffset + 1);
        ACanvas.LineTo(ATickPosition, ThumbRect.Bottom + TrackAndTickOffset + ATickSize + 1);
      end;
      if TickMarks in [cxtmTopLeft, cxtmBoth] then
      begin
        ACanvas.MoveTo(ATickPosition, ThumbRect.Top - (TrackAndTickOffset + ATickSize));
        ACanvas.LineTo(ATickPosition, ThumbRect.Top - TrackAndTickOffset);
      end;
    end;
  end;

  procedure DrawTickAsText(AIndex, ATickPosition: Integer);
  const
    ARotationAngle: array [TcxTrackBarTextOrientation] of TcxRotationAngle = (ra0, raPlus90);
    AOrientation: array [TcxTrackBarTextOrientation] of TcxTrackBarOrientation = (tboHorizontal, tboVertical);
  var
    ATextSize: TSize;
    ADelta: Integer;
    ATopRect, ABottomRect: TRect;
    ATextWidth, ATextHeight: Integer;
  begin
    ATextSize := ACanvas.TextExtent(IntToStr(AIndex));

    if TextOrientation = tbtoVertical then
    begin
      ATextWidth := ATextSize.cy;
      ATextHeight := ATextSize.cx;
    end
    else
    begin
      ATextWidth := ATextSize.cx;
      ATextHeight := ATextSize.cy;
    end;

    if AOrientation[TextOrientation] <> Orientation then
      ADelta := 1
    else
      ADelta := 0;

    if Orientation = tboVertical then
    begin
      ATopRect := cxRectBounds(ThumbRect.Left - TrackAndTickOffset - ATextWidth, ATickPosition - ATextHeight div 2, ATextWidth, ATextHeight);
      ABottomRect := cxRectBounds(ThumbRect.Right + ADelta + TrackAndTickOffset, ATickPosition - ATextHeight div 2, ATextWidth, ATextHeight);
    end
    else
    begin
      ATopRect := cxRectBounds(ATickPosition - ATextWidth div 2, ThumbRect.Top - ADelta - TrackAndTickOffset - ATextHeight, ATextWidth, ATextHeight);
      ABottomRect := cxRectBounds(ATickPosition - ATextWidth div 2, ThumbRect.Bottom + TrackAndTickOffset, ATextWidth, ATextHeight);
    end;
    if TickMarks in [cxtmTopLeft, cxtmBoth] then
      cxDrawText(ACanvas, IntToStr(AIndex), ATopRect, 0, clDefault, ARotationAngle[TextOrientation]);
    if TickMarks in [cxtmBottomRight, cxtmBoth] then
      cxDrawText(ACanvas, IntToStr(AIndex), ABottomRect, 0, clDefault, ARotationAngle[TextOrientation]);
  end;

var
  I: Integer;
  ATickPosition: Integer;
begin
  ACanvas.Font.Assign(Font);
  ACanvas.Brush.Color := clBtnFace;
  if UseSkins then
  begin
    ACanvas.Font.Color := Painter.TrackBarTicksColor(True);
    ACanvas.Pen.Color := Painter.TrackBarTicksColor(False);
  end
  else
  begin
    ACanvas.Font.Color := TextColor;
    ACanvas.Pen.Color := TickColor;
  end;

  for I := Min to Max do
  begin
    if Orientation = tboVertical then
      ATickPosition := TrackRect.Top + GetTickOffset(I)
    else
      ATickPosition := TrackRect.Left + GetTickOffset(I);

    if (I = Min) or (I = Max) or ((Frequency > 0) and (((I - Min) mod Frequency) = 0)) then
    begin
      if NeedDrawTickAsLine(I) then
        DrawTickAsLine(I, ATickPosition)
      else
        DrawTickAsText(I, ATickPosition);
    end;
  end;
end;

const
  ATrackBarTicks2TicksAlign: array[TcxTrackBarTickMarks] of TcxTrackBarTicksAlign =
    (tbtaBoth, tbtaUp, tbtaDown);

procedure TcxCustomTrackBarViewInfo.DrawThumb(ACanvas: TcxCanvas);
const
  ATrackBarStates2BtnStates: array[1..5] of TcxButtonState =
    (cxbsNormal, cxbsHot, cxbsPressed, cxbsHot, cxbsDisabled);

 function GetThumbRealColor: TColor;
  begin
    case TrackBarState of
      TUS_DISABLED:
        Result := clBtnShadow;
      TUS_PRESSED, TUS_HOT:
        if LookAndFeel.Kind in [lfUltraFlat, lfOffice11] then
          Result := GetEditButtonHighlightColor(TrackBarState = TUS_PRESSED, LookAndFeel.Kind = lfOffice11)
        else
          Result :=  TcxCustomTrackBarProperties(EditProperties).ThumbHighLightColor;
      else
        Result := TcxCustomTrackBarProperties(EditProperties).ThumbColor;
    end;
  end;

begin
  LookAndFeel.Painter.DrawTrackBarThumb(ACanvas, ThumbRect,
    ATrackBarStates2BtnStates[TrackBarState],
    Orientation = tboHorizontal,
    ATrackBarTicks2TicksAlign[TickMarks], GetThumbRealColor);
end;

function TcxCustomTrackBarViewInfo.DrawingThumbRectToRealThumbRect(
  ACanvas: TcxCanvas): TRect;
begin
  Result := ThumbRect;
  LookAndFeel.Painter.CorrectThumbRect(ACanvas, Result, Orientation = tboHorizontal, ATrackBarTicks2TicksAlign[TickMarks]);
  OffsetRect(Result, RealTrackBarRect.Left, RealTrackBarRect.Top);
end;

function TcxCustomTrackBarViewInfo.GetThumbThemeType: Byte;
const
  AThumbThemeParts: array[TcxTrackBarTickMarks, Boolean] of Byte = (
    (TKP_THUMB, TKP_THUMBVERT),
    (TKP_THUMBTOP, TKP_THUMBLEFT),
    (TKP_THUMBBOTTOM, TKP_THUMBRIGHT)
  );
begin
  Result := AThumbThemeParts[TcxCustomTrackBarProperties(EditProperties).TickMarks,
    TcxCustomTrackBarProperties(EditProperties).Orientation = tboVertical];
end;

function TcxCustomTrackBarViewInfo.GetEdit: TcxCustomTrackBar;
begin
  Result := TcxCustomTrackBar(FEdit);
end;

{ TcxCustomTrackBarViewData }

procedure TcxCustomTrackBarViewData.CalculateTBViewInfoProps(AViewInfo: TcxCustomEditViewInfo);
begin
  with TcxCustomTrackBarViewInfo(AViewInfo) do
  begin
    Frequency := Properties.Frequency;
    Min := Properties.Min;
    Max := Properties.Max;
    TrackBarBorderWidth := Properties.BorderWidth;
    TrackSize := Properties.TrackSize;
    SelectionStart := Properties.SelectionStart;
    SelectionEnd := Properties.SelectionEnd;
    if not Enabled then
      TickColor := clBtnShadow
    else
      TickColor := Properties.TickColor;
    TickType := Properties.TickType;
    TickMarks := Properties.TickMarks;
    TickSize := Properties.TickSize;
    ThumbHeight := Properties.ThumbHeight;
    ThumbWidth := Properties.ThumbWidth;

    Orientation := Properties.Orientation;
    TextOrientation := Properties.TextOrientation;
  end;
end;

function TcxCustomTrackBarViewData.GetTopLeftTickSize(
  ACanvas: TcxCanvas; AViewInfo: TcxCustomTrackBarViewInfo;
  ALeftTop: Boolean): Integer;
var
  ACalcNumValue: string;
begin
  Result := 0;
  if ((Properties.TickMarks <> cxtmBottomRight) and (ALeftTop = True)) or
    (Properties.TickMarks <> cxtmTopLeft) and (ALeftTop = False) then
    case Properties.TickType of
      tbttTicks: Result := Properties.TickSize + TrackAndTickOffset;
      tbttNumbers, tbttValueNumber:
      begin
        if ((Properties.Orientation = tboHorizontal) and
          (Properties.TextOrientation = tbtoHorizontal)) or
          ((Properties.Orientation = tboVertical) and
          (Properties.TextOrientation = tbtoVertical)) then
          Result := ACanvas.TextHeight(IntToStr(Properties.Min))
        else
        begin
          if Length(IntToStr(Properties.Min)) > Length(IntToStr(Properties.Max)) then
            ACalcNumValue := IntToStr(Properties.Min)
          else
            ACalcNumValue := IntToStr(Properties.Max);
          Result := ACanvas.TextWidth(ACalcNumValue);
        end;
      end;
    end;
  if AViewInfo.TrackBarBorderWidth = 0 then
    Inc(Result, 1);
end;

procedure TcxCustomTrackBarViewData.CalculateTrackBarRect(
  AViewInfo: TcxCustomTrackBarViewInfo);
begin
  AViewInfo.RealTrackBarRect := AViewInfo.ClientRect;
  AViewInfo.TrackBarRect := AViewInfo.ClientRect;
  OffsetRect(AViewInfo.TrackBarRect, -Bounds.Left, -Bounds.Top);
  AViewInfo.TrackBarBorderWidth := Min(AViewInfo.TrackBarBorderWidth, cxRectWidth(AViewInfo.TrackBarRect) div 2);
  AViewInfo.TrackBarBorderWidth := Min(AViewInfo.TrackBarBorderWidth, cxRectHeight(AViewInfo.TrackBarRect) div 2);
end;

procedure TcxCustomTrackBarViewData.CalculateTrackZoneRect(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomTrackBarViewInfo);
var
  FTopLeftIndent, FBottomRightIndent: Integer;
  FTrackZoneSize, FRealTrackZoneSize: Integer;
  FCustomRect: TRect;
begin
  FTopLeftIndent := GetTopLeftTickSize(ACanvas, AViewInfo, True);
  FBottomRightIndent := GetTopLeftTickSize(ACanvas, AViewInfo, False);
  if Properties.Orientation = tboHorizontal then
    FTrackZoneSize := cxRectHeight(AViewInfo.TrackBarRect) - FTopLeftIndent - FBottomRightIndent
  else
    FTrackZoneSize := cxRectWidth(AViewInfo.TrackBarRect) - FTopLeftIndent - FBottomRightIndent;
  FRealTrackZoneSize := FTrackZoneSize;
  if FTrackZoneSize < 10 then FRealTrackZoneSize := 10;
  if FTrackZoneSize > 21 then FRealTrackZoneSize := 21;

  if (Properties.ThumbType = cxttCustom) and
    IsOnGetThumbRectEventAssigned then
  begin
    DoOnGetThumbRect(FCustomRect);
//    Properties.OnGetThumbRect(Properties, FCustomRect);
    if (Properties.Orientation = tboHorizontal) and
      (cxRectHeight(FCustomRect) > FRealTrackZoneSize) then
      FRealTrackZoneSize := cxRectHeight(FCustomRect);
    if (Properties.Orientation = tboVertical) and
      (cxRectWidth(FCustomRect) > FRealTrackZoneSize) then
      FRealTrackZoneSize := cxRectWidth(FCustomRect);
  end;

  AViewInfo.FromBorderIndent := FromBorderIndent;
  if AViewInfo.UseSkins then
    AViewInfo.TrackSize := AViewInfo.Painter.TrackBarTrackSize
  else
    if Properties.AutoSize then
      AViewInfo.TrackSize := FRealTrackZoneSize div 2;

  if Properties.Orientation = tboHorizontal then
  begin
    AViewInfo.TrackZoneRect.Top := AViewInfo.TrackBarRect.Top +
      ((FTrackZoneSize - FRealTrackZoneSize) div 2) + FTopLeftIndent;
    AViewInfo.TrackZoneRect.Bottom := AViewInfo.TrackZoneRect.Top + FRealTrackZoneSize;
    AViewInfo.TrackZoneRect.Left := AViewInfo.TrackBarRect.Left +
      AViewInfo.TrackBarBorderWidth + AViewInfo.FromBorderIndent;
    AViewInfo.TrackZoneRect.Right := AViewInfo.TrackBarRect.Right -
      AViewInfo.TrackBarBorderWidth - AViewInfo.FromBorderIndent;
  end
  else
  begin
    AViewInfo.TrackZoneRect.Left := AViewInfo.TrackBarRect.Left +
      ((FTrackZoneSize - FRealTrackZoneSize) div 2) + FTopLeftIndent;
    AViewInfo.TrackZoneRect.Right := AViewInfo.TrackZoneRect.Left + FRealTrackZoneSize;
    AViewInfo.TrackZoneRect.Top := AViewInfo.TrackBarRect.Top +
      AViewInfo.TrackBarBorderWidth + AViewInfo.FromBorderIndent;
    AViewInfo.TrackZoneRect.Bottom := AViewInfo.TrackBarRect.Bottom -
      AViewInfo.TrackBarBorderWidth - AViewInfo.FromBorderIndent;
  end;
end;

procedure TcxCustomTrackBarViewData.CalculateTrackRect(
  AViewInfo: TcxCustomTrackBarViewInfo);
begin
  if Properties.Orientation = tboHorizontal then
  begin
    AViewInfo.TrackRect.Left := AViewInfo.TrackZoneRect.Left;
    AViewInfo.TrackRect.Right := AViewInfo.TrackZoneRect.Right;
    AViewInfo.TrackRect.Top := AViewInfo.TrackZoneRect.Top +
      (cxRectHeight(AViewInfo.TrackZoneRect) - AViewInfo.TrackSize) div 2;
    AViewInfo.TrackRect.Bottom := AViewInfo.TrackRect.Top + AViewInfo.TrackSize;
  end
  else
  begin
    AViewInfo.TrackRect.Top := AViewInfo.TrackZoneRect.Top;
    AViewInfo.TrackRect.Bottom := AViewInfo.TrackZoneRect.Bottom;
    AViewInfo.TrackRect.Left := AViewInfo.TrackZoneRect.Left +
      (cxRectWidth(AViewInfo.TrackZoneRect) - AViewInfo.TrackSize) div 2;
    AViewInfo.TrackRect.Right := AViewInfo.TrackRect.Left + AViewInfo.TrackSize;
  end;
  Properties.FTrackRect := AViewInfo.TrackRect;
end;

procedure TcxCustomTrackBarViewData.CalculateThumbSize(
  AViewInfo: TcxCustomTrackBarViewInfo);
var
  AMinMaxDiff: Integer;
  ATickOffset: Double;
  AThumbSize, AThumbLargeSize: Integer;
  ACustomRect: TRect;
  APainterThumbSize: TSize;
begin
  AMinMaxDiff := Max(Properties.Max - Properties.Min, 1);
  if (Properties.ThumbType = cxttCustom) and IsOnGetThumbRectEventAssigned then
  begin
    DoOnGetThumbRect(ACustomRect);
    if Properties.Orientation = tboHorizontal then
    begin
      AThumbSize := cxRectWidth(ACustomRect);
      AThumbLargeSize := cxRectHeight(ACustomRect);
    end
    else
    begin
      AThumbSize := cxRectHeight(ACustomRect);
      AThumbLargeSize := cxRectWidth(ACustomRect);
    end;
    AViewInfo.ThumbWidth := AThumbSize;
    AViewInfo.ThumbHeight := AThumbLargeSize;
  end
  else
    if AViewInfo.UseSkins then
    begin
      APainterThumbSize := AViewInfo.Painter.TrackBarThumbSize(Properties.Orientation = tboHorizontal);
      if Properties.Orientation = tboHorizontal then
      begin
        AThumbSize := APainterThumbSize.cx;
        AThumbLargeSize := Min(APainterThumbSize.cy, cxRectHeight(AViewInfo.TrackZoneRect));
      end
      else
      begin
        AThumbSize := APainterThumbSize.cy;
        AThumbLargeSize := Min(APainterThumbSize.cx, cxRectWidth(AViewInfo.TrackZoneRect));
      end;
    end
    else
    begin
      if Properties.AutoSize then
      begin
        AThumbSize := AViewInfo.TrackSize;
        AThumbLargeSize := AThumbSize * 2;
        Inc(AThumbSize, AThumbSize mod 2);
      end
      else
      begin
        AThumbSize := AViewInfo.ThumbWidth;
        AThumbLargeSize := AViewInfo.ThumbHeight;
      end;
    end;

  if Properties.Orientation = tboHorizontal then
    ATickOffset := (cxRectWidth(AViewInfo.TrackRect) - AThumbSize) / AMinMaxDiff
  else
    ATickOffset := (cxRectHeight(AViewInfo.TrackRect) - AThumbSize) / AMinMaxDiff;
  AViewInfo.ThumbSize := AThumbSize;
  AViewInfo.ThumbLargeSize := AThumbLargeSize;
  AViewInfo.TickOffset := ATickOffset;
  Properties.FTickOffset := ATickOffset;
end;

procedure TcxCustomTrackBarViewData.CalculateThumbRect(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomTrackBarViewInfo);
var
  ACurrentTickOffset: Integer;
begin
  if Properties.Orientation = tboHorizontal then
  begin
    ACurrentTickOffset := Trunc((AViewInfo.TickOffset * (AViewInfo.Position - Properties.Min)) +
      AViewInfo.TrackRect.Left) + (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Left := ACurrentTickOffset - (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Right := ACurrentTickOffset + (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Top := AViewInfo.TrackRect.Top + (AViewInfo.TrackSize div 2) -
      (AViewInfo.ThumbLargeSize div 2);
    AViewInfo.ThumbRect.Bottom := AViewInfo.ThumbRect.Top + AViewInfo.ThumbLargeSize;
  end
  else
  begin
    ACurrentTickOffset := Trunc((AViewInfo.TickOffset * (AViewInfo.Position - Properties.Min)) +
      AViewInfo.TrackRect.Top) + (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Top := ACurrentTickOffset - (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Bottom := ACurrentTickOffset + (AViewInfo.ThumbSize div 2);
    AViewInfo.ThumbRect.Left := AViewInfo.TrackRect.Left + (AViewInfo.TrackSize -
      AViewInfo.ThumbLargeSize) div 2;
    AViewInfo.ThumbRect.Right := AViewInfo.ThumbRect.Left + AViewInfo.ThumbLargeSize;
  end;
  Properties.FThumbRect := AViewInfo.DrawingThumbRectToRealThumbRect(ACanvas);
end;

procedure TcxCustomTrackBarViewData.CalculateSelectionRect(
  AViewInfo: TcxCustomTrackBarViewInfo);
begin
  if AViewInfo.SelectionStart < Properties.Min then
    AViewInfo.SelectionStart := Properties.Min;
  if AViewInfo.SelectionEnd < Properties.Min then
    AViewInfo.SelectionEnd := Properties.Min;
  if AViewInfo.SelectionStart > Properties.Max then
    AViewInfo.SelectionStart := Properties.Max;
  if AViewInfo.SelectionEnd > Properties.Max then
    AViewInfo.SelectionEnd := Properties.Max;
  AViewInfo.FShowSelection := (AViewInfo.SelectionStart < AViewInfo.SelectionEnd);
  if AViewInfo.FShowSelection then
  begin
    if Properties.Orientation = tboHorizontal then
    begin
      AViewInfo.SelectionRect.Left := Trunc((AViewInfo.TickOffset * (AViewInfo.SelectionStart - Properties.Min)) +
        AViewInfo.TrackRect.Left) + (AViewInfo.ThumbSize div 2);
      AViewInfo.SelectionRect.Right := Trunc((AViewInfo.TickOffset * (AViewInfo.SelectionEnd - Properties.Min)) +
        AViewInfo.TrackRect.Left) + (AViewInfo.ThumbSize div 2) + 1;
      AViewInfo.SelectionRect.Top := AViewInfo.TrackRect.Top;
      AViewInfo.SelectionRect.Bottom := AViewInfo.TrackRect.Bottom;
      if not AViewInfo.UseSkins then
      begin
        Inc(AViewInfo.SelectionRect.Top, 2);
        Dec(AViewInfo.SelectionRect.Bottom);
      end;
    end
    else
    begin
      AViewInfo.SelectionRect.Top := Trunc((AViewInfo.TickOffset * (AViewInfo.SelectionStart - Properties.Min)) +
        AViewInfo.TrackRect.Top) + (AViewInfo.ThumbSize div 2);
      AViewInfo.SelectionRect.Bottom := Trunc((AViewInfo.TickOffset * (AViewInfo.SelectionEnd - Properties.Min)) +
        AViewInfo.TrackRect.Top) + (AViewInfo.ThumbSize div 2) + 1;
      AViewInfo.SelectionRect.Left := AViewInfo.TrackRect.Left;
      AViewInfo.SelectionRect.Right := AViewInfo.TrackRect.Right;
      if not AViewInfo.UseSkins then
      begin
        Inc(AViewInfo.SelectionRect.Left, 2);
        Dec(AViewInfo.SelectionRect.Right, 2);
      end;  
    end;
  end;
end;

procedure TcxCustomTrackBarViewData.DoOnGetThumbRect(var ARect: TRect);
var
  AOnGetThumbRect: TcxGetThumbRectEvent;
begin
  GetOnGetThumbRect(AOnGetThumbRect);
  AOnGetThumbRect(Properties, ARect);
end;

function TcxCustomTrackBarViewData.IsOnGetThumbRectEventAssigned: Boolean;
var
  AOnGetThumbRect: TcxGetThumbRectEvent;
begin
  GetOnGetThumbRect(AOnGetThumbRect);
  Result := Assigned(AOnGetThumbRect);
end;

procedure TcxCustomTrackBarViewData.CalculateCustomTrackBarRects(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomTrackBarViewInfo);
begin
  CalculateTrackBarRect(AViewInfo);
  CalculateTrackZoneRect(ACanvas, AViewInfo);
  CalculateTrackRect(AViewInfo);
  CalculateThumbSize(AViewInfo);
  CalculateThumbRect(ACanvas, AViewInfo);
  CalculateSelectionRect(AViewInfo);
end;

procedure TcxCustomTrackBarViewData.Calculate(ACanvas: TcxCanvas; const ABounds: TRect;
  const P: TPoint; Button: TcxMouseButton; Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
var
  FViewInfo : TcxCustomTrackBarViewInfo;
  FDisplayValue: TcxEditValue;
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);

  FViewInfo := TcxCustomTrackBarViewInfo(AViewInfo);

  {Standart properties}
  FViewInfo.LookAndFeel.Assign(Style.LookAndFeel);
  FViewInfo.IsEditClass := False;
  FViewInfo.DrawSelectionBar := False;
  FViewInfo.HasPopupWindow := False;
  FViewInfo.DrawTextFlags := 0;
  FViewInfo.DrawSelectionBar := False;
  if not FViewInfo.Enabled then
    FViewInfo.TrackBarState := TUS_DISABLED
  else
  begin
    if tbmpSliding in FViewInfo.MouseStates then
      FViewInfo.TrackBarState := TUS_PRESSED
    else
      if tbmpUnderThumb in FViewInfo.MouseStates then
        FViewInfo.TrackBarState := TUS_HOT
      else
        FViewInfo.TrackBarState := TUS_NORMAL;
  end;
  {TrackBar properties}
  if Assigned(Edit) and not FViewInfo.IsDBEditPaintCopyDrawing then
  begin
    Properties.PrepareDisplayValue(Edit.EditValue, FDisplayValue, Focused);
    FViewInfo.Position := FDisplayValue;
  end;
  CalculateTBViewInfoProps(AViewInfo);
  CalculateCustomTrackBarViewInfo(ACanvas, Self, FViewInfo);
  CalculateCustomTrackBarRects(ACanvas, FViewInfo);
end;

procedure TcxCustomTrackBarViewData.EditValueToDrawValue(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo);
var
  ADisplayValue: TcxEditValue;
begin
  Properties.PrepareDisplayValue(AEditValue, ADisplayValue, InternalFocused);
  TcxCustomTrackBarViewInfo(AViewInfo).Position := ADisplayValue;
end;

function TcxCustomTrackBarViewData.InternalGetEditConstantPartSize(ACanvas: TcxCanvas;
  AIsInplace: Boolean; AEditSizeProperties: TcxEditSizeProperties;
  var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo): TSize;
var
  ASize1: TSize;
begin
  Result := inherited InternalGetEditConstantPartSize(ACanvas, AIsInplace,
    AEditSizeProperties, MinContentSize, AViewInfo);

  ASize1.cx := cxRectWidth(TcxCustomTrackBarViewInfo(AViewInfo).ThumbRect);
  ASize1.cy := GetTextEditContentSize(ACanvas, Self, 'Wg', 0,
    AEditSizeProperties, 0, False).cy;
  Result.cx := Result.cx + ASize1.cx;
  Result.cy := Result.cy + ASize1.cy;
end;

procedure TcxCustomTrackBarViewData.GetOnGetThumbRect(out AValue: TcxGetThumbRectEvent);
begin
  if Edit = nil then
    AValue := Properties.OnGetThumbRect
  else
    TcxCustomTrackBar(Edit).GetOnGetThumbRect(AValue);
end;

function TcxCustomTrackBarViewData.GetProperties: TcxCustomTrackBarProperties;
begin
  Result := TcxCustomTrackBarProperties(FProperties);
end;

{ TcxCustomTrackBarProperties }

constructor TcxCustomTrackBarProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FAutoSize := True;
  FBorderWidth := 0;
  FFrequency := 1;
  FMin := 0;
  FMax := 10;
  FOrientation := tboHorizontal;
  FTextOrientation := tbtoHorizontal;
  FPageSize := 1;
  FTrackColor := clWindow;
  FTrackSize := 5;
  FTickColor := clWindowText;
  FSelectionStart := 0;
  FSelectionEnd := 0;
  FSelectionColor := clHighlight;
  FShowTicks := True;
  FThumbType := cxttRegular;
  FShowTrack := True;
  FTickType := tbttTicks;
  FTickMarks := cxtmBottomRight;
  FTickSize := 3;
  FThumbHeight := 12;
  FThumbWidth := 7;
  FThumbColor := clBtnFace;
  FThumbHighlightColor := clSilver;
  FThumbStep := cxtsNormal;
end;

destructor TcxCustomTrackBarProperties.Destroy;
begin
  inherited Destroy;
end;

procedure TcxCustomTrackBarProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomTrackBarProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomTrackBarProperties do
      begin
        Self.AutoSize := AutoSize;
        Self.BorderWidth := BorderWidth;
        Self.Frequency := Frequency;
        Self.Min := Min;
        Self.Max := Max;
        Self.Orientation := Orientation;
        Self.TextOrientation := TextOrientation;
        Self.PageSize := PageSize;
        Self.SelectionStart := SelectionStart;
        Self.SelectionEnd := SelectionEnd;
        Self.SelectionColor := SelectionColor;
        Self.ShowTicks := ShowTicks;
        Self.ThumbStep := ThumbStep;
        Self.ThumbType := ThumbType;
        Self.ShowTrack := ShowTrack;
        Self.TickColor := TickColor;
        Self.TickType := TickType;
        Self.TickMarks := TickMarks;
        Self.TickSize := TickSize;
        Self.TrackColor := TrackColor;
        Self.TrackSize := TrackSize;
        Self.ThumbHeight := ThumbHeight;
        Self.ThumbWidth := ThumbWidth;
        Self.ThumbColor := ThumbColor;
        Self.ThumbHighlightColor := ThumbHighlightColor;
        Self.OnGetThumbRect := OnGetThumbRect;
        Self.OnDrawThumb := OnDrawThumb;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomTrackBarProperties.CanCompareEditValue: Boolean;
begin
  Result := True;
end;

class function TcxCustomTrackBarProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxTrackBar;
end;

function TcxCustomTrackBarProperties.GetDisplayText(const AEditValue: TcxEditValue;
  AFullText: Boolean = False; AIsInplace: Boolean = True): WideString;
var
  ADisplayValue: TcxEditValue;
begin
  PrepareDisplayValue(AEditValue, ADisplayValue, False);
  Result := ADisplayValue;
end;

class function TcxCustomTrackBarProperties.GetStyleClass: TcxCustomEditStyleClass;
begin
  Result := TcxTrackBarStyle;
end;

function TcxCustomTrackBarProperties.GetSupportedOperations: TcxEditSupportedOperations;
begin
  Result := [esoAlwaysHotTrack, esoEditing, esoFiltering, esoSorting,
    esoTransparency];
end;

class function TcxCustomTrackBarProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxCustomTrackBarViewInfo;
end;

function TcxCustomTrackBarProperties.IsEditValueValid(var EditValue: TcxEditValue;
  AEditFocused: Boolean): Boolean;
begin
  Result := inherited IsEditValueValid(EditValue, AEditFocused);
end;

procedure TcxCustomTrackBarProperties.PrepareDisplayValue(const AEditValue:
  TcxEditValue; var DisplayValue: TcxEditValue; AEditFocused: Boolean);
begin
  LockUpdate(True);
  try
    DisplayValue := FixPosition(EditValueToPosition(AEditValue));
  finally
    LockUpdate(False);
  end;
end;

function TcxCustomTrackBarProperties.EditValueToPosition(
  const AEditValue: TcxEditValue): Integer;
begin
  if not IsVarEmpty(AEditValue) and (VarIsNumeric(AEditValue) or VarIsStr(AEditValue)) then
    Result := VarAsType(AEditValue, varInteger)
  else
    Result := FMin;
end;

class function TcxCustomTrackBarProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxCustomTrackBarViewData;
end;

function TcxCustomTrackBarProperties.HasDisplayValue: Boolean;
begin
  Result := False;
end;

procedure TcxCustomTrackBarProperties.SetTrackColor(Value: TColor);
begin
  if FTrackColor <> Value then
  begin
    FTrackColor := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetPageSize(Value: TcxNaturalNumber);
begin
  if Value <> FPageSize then
  begin
    FPageSize := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetSelectionStart(Value: Integer);
begin
  if FSelectionStart <> Value then
  begin
    FSelectionStart := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetSelectionEnd(Value: Integer);
begin
  if FSelectionEnd <> Value then
  begin
    FSelectionEnd := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetSelectionColor(Value: TColor);
begin
  if FSelectionColor <> Value then
  begin
    FSelectionColor := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetBorderWidth(Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    if Value < 0 then
      FBorderWidth := 0
    else
      FBorderWidth := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetFrequency(Value: Integer);
begin
  if FFrequency <> Value then
  begin
    if Value < 0 then
      FFrequency := 0
    else
      FFrequency := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetMin(Value: Integer);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    if FMax < FMin then FMax := FMin;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetMax(Value: Integer);
begin
  if FMax <> Value then
  begin
    FMax := Value;
    if FMin > FMax then FMin := FMax;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetOrientation(Value: TcxTrackBarOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTextOrientation(Value: TcxTrackBarTextOrientation);
begin
  if FTextOrientation <> Value then
  begin
    FTextOrientation := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetShowTrack(Value: Boolean);
begin
  if FShowTrack <> Value then
  begin
    FShowTrack := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetShowTicks(Value: Boolean);
begin
  if FShowTicks <> Value then
  begin
    FShowTicks := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetThumbType(Value: TcxTrackBarThumbType);
begin
  if FThumbType <> Value then
  begin
    FThumbType := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTickColor(Value: TColor);
begin
  if FTickColor <> Value then
  begin
    FTickColor := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTickType(Value: TcxTrackBarTickType);
begin
  if FTickType <> Value then
  begin
    FTickType := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTickMarks(Value: TcxTrackBarTickMarks);
begin
  if FTickMarks <> Value then
  begin
    FTickMarks := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTickSize(Value: TcxNaturalNumber);
begin
  if FTickSize <> Value then
  begin
    FTickSize := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetTrackSize(Value: Integer);
begin
  if FTrackSize <> Value then
  begin
    FTrackSize := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetThumbHeight(Value: Integer);
begin
  if FThumbHeight <> Value then
  begin
    FThumbHeight := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetThumbWidth(Value: Integer);
begin
  if FThumbWidth <> Value then
  begin
    FThumbWidth := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetThumbColor(Value: TColor);
begin
  if FThumbColor <> Value then
  begin
    FThumbColor := Value;
    Changed;
  end;
end;

procedure TcxCustomTrackBarProperties.SetThumbHighlightColor(Value: TColor);
begin
  if FThumbHighlightColor <> Value then
  begin
    FThumbHighlightColor := Value;
    Changed;
  end;
end;

function TcxCustomTrackBarProperties.FixPosition(const APosition: Integer): Integer;
begin
  Result := Math.Max(Math.Min(APosition, Max), Min);
end;

procedure TcxCustomTrackBarProperties.DoDrawThumb(Sender: TObject; ACanvas: TcxCanvas;
  const ARect: TRect);
begin
  if Assigned(OnDrawThumb) then
    OnDrawThumb(Self, ACanvas, ARect);
end;

{ TcxCustomTrackBar }

class function TcxCustomTrackBar.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomTrackBarProperties;
end;

function TcxCustomTrackBar.GetStyle: TcxTrackBarStyle;
begin
  Result := TcxTrackBarStyle(FStyles.Style);
end;

procedure TcxCustomTrackBar.SetStyle(Value: TcxTrackBarStyle);
begin
  FStyles.Style := Value;
end;

procedure TcxCustomTrackBar.SetNewSelectionPosition(const ANewPosition: Integer);
begin
  if ANewPosition < FStartSelectionPosition then
  begin
    ActiveProperties.FSelectionStart := ANewPosition;
    ActiveProperties.FSelectionEnd := FStartSelectionPosition;
  end
  else
  begin
    ActiveProperties.FSelectionStart := FStartSelectionPosition;
    ActiveProperties.FSelectionEnd := ANewPosition;
  end;
end;

function TcxCustomTrackBar.DefaultParentColor: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTrackBar.FillSizeProperties(var AEditSizeProperties: TcxEditSizeProperties);
begin
  AEditSizeProperties := DefaultcxEditSizeProperties;
  AEditSizeProperties.MaxLineCount := 1;
  AEditSizeProperties.Width := ViewInfo.TextRect.Right - ViewInfo.TextRect.Left;
end;

procedure TcxCustomTrackBar.Initialize;
begin
  inherited Initialize;
  FEditValue := 0;
  FSlideState := tbksNormal;
  AutoSize := False;
  ControlStyle := ControlStyle - [csDoubleClicks, csClickEvents];
  Width := 196;
  Height := 76;
end;

procedure TcxCustomTrackBar.KeyDown(var Key: Word; Shift: TShiftState);

  function GetNewPosition: Integer;
  begin
    case Key of
      VK_PRIOR:
        Result := ActiveProperties.FixPosition(Position - ActiveProperties.PageSize);
      VK_NEXT:
        Result := ActiveProperties.FixPosition(Position + ActiveProperties.PageSize);
      VK_END:
        Result := ActiveProperties.Max;
      VK_HOME:
        Result := ActiveProperties.Min;
      VK_LEFT, VK_UP:
        Result := ActiveProperties.FixPosition(Pred(Position));
      VK_RIGHT, VK_DOWN:
        Result := ActiveProperties.FixPosition(Succ(Position));
      else
        Result := Position;
    end;
  end;

var
  ANewPosition: Integer;
begin
  inherited KeyDown(Key, Shift);

  if Key = VK_SHIFT then
  begin
    if not IsInplace and (FSlideState <> tbksIncludeSelection) then
    begin
      FSlideState := tbksIncludeSelection;
      FStartSelectionPosition := Position;
    end;
    Exit;
  end;

  ANewPosition := GetNewPosition;
  if ANewPosition <> Position then
  begin
    if FSlideState = tbksIncludeSelection then
      SetNewSelectionPosition(ANewPosition);
    InternalSetPosition(ANewPosition);
  end;
end;

procedure TcxCustomTrackBar.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if not IsInplace and (Key = VK_SHIFT) then
    FSlideState := tbksNormal;
end;

procedure TcxCustomTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function GetPositionAfterJump: Integer;
  var
    FX, FY: Integer;
  begin
    if ActiveProperties.Orientation = tboHorizontal then
    begin
      FX := X - ActiveProperties.FTrackRect.Left;
      Result := Trunc(FX / ActiveProperties.FTickOffset) + ActiveProperties.Min;
    end
    else
    begin
      FY := Y - ActiveProperties.FTrackRect.Top;
      Result := Trunc(FY / ActiveProperties.FTickOffset) + ActiveProperties.Min;
    end;
  end;

  function GetNewHorizontalPosition: Integer;
  begin
    Result := Position;
    if X > ActiveProperties.FThumbRect.Right then
    begin
      if ActiveProperties.ThumbStep = cxtsNormal then
        Result := Position + 1
      else
        Result := GetPositionAfterJump;
    end
    else
      if X < ActiveProperties.FThumbRect.Left then
      begin
        if ActiveProperties.ThumbStep = cxtsNormal then
          Result := Position - 1
        else
          Result := GetPositionAfterJump;
      end;
  end;

  function GetNewVerticalPosition: Integer;
  begin
    Result := Position;
    if Y > ActiveProperties.FThumbRect.Bottom then
    begin
      if ActiveProperties.ThumbStep = cxtsNormal then
        Result := Position + 1
      else
        Result := GetPositionAfterJump;
    end
    else
      if Y < ActiveProperties.FThumbRect.Top then
      begin
        if ActiveProperties.ThumbStep = cxtsNormal then
          Result := Position - 1
        else
          Result := GetPositionAfterJump;
      end;
  end;

  function GetNewPosition: Integer;
  begin
    if ActiveProperties.Orientation = tboHorizontal then
      Result := GetNewHorizontalPosition
    else
      Result := GetNewVerticalPosition;
    Result := ActiveProperties.FixPosition(Result);
  end;

var
  ANewPosition: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and PtInRect(ClientBounds, Point(X, Y)) then
    if PtInRect(ActiveProperties.FThumbRect, Point(X, Y)) then
    begin
      Include(ViewInfo.MouseStates, tbmpSliding);
      if ssCtrl in Shift then
      begin
        FSlideState := tbksNormal;
        ActiveProperties.FSelectionStart := 0;
        ActiveProperties.FSelectionEnd := 0;
      end;
      ShortRefreshContainer(False);
    end
    else
    begin
      ANewPosition := GetNewPosition;
      if ANewPosition <> Position then
        InternalSetPosition(ANewPosition);
    end;
end;

procedure TcxCustomTrackBar.MouseEnter(AControl: TControl);
begin
  inherited;
  Include(ViewInfo.MouseStates, tbmpInControl);
  if (tbmpSliding in ViewInfo.MouseStates) and
    not (ssLeft in CurrentShiftState) then
  begin
    Exclude(ViewInfo.MouseStates, tbmpSliding);
    Exclude(ViewInfo.MouseStates, tbmpUnderThumb);
  end;
end;

procedure TcxCustomTrackBar.MouseLeave(AControl: TControl);
begin
  Exclude(ViewInfo.MouseStates, tbmpInControl);
  Exclude(ViewInfo.MouseStates, tbmpUnderThumb);
  inherited;
  ShortRefreshContainer(False);
end;

procedure TcxCustomTrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  FThumbOffset: Double;
  NewPos: Integer;
  FOldMouseStates: TcxTrackBarMouseStates;
  FNewPosition: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  if (tbmpSliding in ViewInfo.MouseStates) and (ssLeft in CurrentShiftState) then
  begin
    if ActiveProperties.Orientation = tboVertical then
    begin
      FThumbOffset := (ActiveProperties.FMax - ActiveProperties.FMin) / Height;
      NewPos := Round((Y - ActiveProperties.FThumbRect.Top -
        ((ActiveProperties.FThumbRect.Bottom - ActiveProperties.FThumbRect.Top) div 2)) * FThumbOffset);
      FNewPosition := ActiveProperties.FixPosition(Position + NewPos);
    end
    else
    begin
      FThumbOffset := (ActiveProperties.Max - ActiveProperties.Min) / Width;
      NewPos := Round((X - ActiveProperties.FThumbRect.Left -
        ((ActiveProperties.FThumbRect.Right - ActiveProperties.FThumbRect.Left) div 2)) * FThumbOffset);
      FNewPosition := ActiveProperties.FixPosition(Position + NewPos);
    end;
    if FNewPosition <> Position then
    begin
      if (ssShift in CurrentShiftState) and
        (FSlideState = tbksIncludeSelection) then
          SetNewSelectionPosition(FNewPosition);
      InternalSetPosition(FNewPosition);
    end;
  end
  else
  begin
    FOldMouseStates := ViewInfo.MouseStates;
    if PtInRect(ActiveProperties.FThumbRect, Point(X, Y)) then
      Include(ViewInfo.MouseStates, tbmpUnderThumb)
     else
      Exclude(ViewInfo.MouseStates, tbmpUnderThumb);
    if ViewInfo.MouseStates <> FOldMouseStates then
      ShortRefreshContainer(False);
//      ActiveProperties.ThumbChanged;
  end;
end;

procedure TcxCustomTrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FOldMouseStates: TcxTrackBarMouseStates;
begin
  inherited MouseUp(Button, Shift, X, Y);
  FOldMouseStates := ViewInfo.MouseStates;
  Exclude(ViewInfo.MouseStates, tbmpSliding);
  if PtInRect(ActiveProperties.FThumbRect, Point(X, Y)) then
    Include(ViewInfo.MouseStates, tbmpUnderThumb)
   else
    Exclude(ViewInfo.MouseStates, tbmpUnderThumb);
  if FOldMouseStates <> ViewInfo.MouseStates then
    ShortRefreshContainer(False);
//    ActiveProperties.ThumbChanged;
  SetCaptureControl(nil);
end;

procedure TcxCustomTrackBar.SynchronizeDisplayValue;
begin
  ShortRefreshContainer(False);
end;

function TcxCustomTrackBar.WantNavigationKeys: Boolean;
begin
  Result := True;
end;

procedure TcxCustomTrackBar.InternalSetPosition(Value: Integer);
begin
  Value := ActiveProperties.FixPosition(Value);
  if (Value <> Position) and DoEditing then
  begin
    InternalEditValue := Value;
    ActiveProperties.Changed;
    ModifiedAfterEnter := True;
    InternalPostEditValue;
  end;
end;

function TcxCustomTrackBar.GetProperties: TcxCustomTrackBarProperties;
begin
  Result := TcxCustomTrackBarProperties(FProperties);
end;

function TcxCustomTrackBar.GetActiveProperties: TcxCustomTrackBarProperties;
begin
  Result := TcxCustomTrackBarProperties(InternalGetActiveProperties);
end;

procedure TcxCustomTrackBar.GetOnGetThumbRect(out AValue: TcxGetThumbRectEvent);
begin
  AValue := Properties.OnGetThumbRect;
  if not Assigned(AValue) then
    AValue := ActiveProperties.OnGetThumbRect;
end;

function TcxCustomTrackBar.GetViewInfo: TcxCustomTrackBarViewInfo;
begin
  Result := TcxCustomTrackBarViewInfo(FViewInfo);
end;

procedure TcxCustomTrackBar.SetProperties(Value: TcxCustomTrackBarProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomTrackBar.WMLButtonUp(var Message: TWMLButtonUp);
begin
  ControlState := ControlState - [csClicked];
  inherited;
end;

procedure TcxCustomTrackBar.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
  if IsInplace then
    Message.Result := Message.Result or DLGC_WANTTAB;
end;

function TcxCustomTrackBar.GetPosition: Integer;
begin
  Result := ActiveProperties.FixPosition(
    ActiveProperties.EditValueToPosition(FEditValue));
end;

procedure TcxCustomTrackBar.SetPosition(Value: Integer);
begin
  if not IsLoading then
    Value := ActiveProperties.FixPosition(Value);
  if Value <> Position then
    InternalEditValue := Value;
end;

{ TcxCustomTrackBar }

class function TcxTrackBar.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxTrackBarProperties;
end;

function TcxTrackBar.GetActiveProperties: TcxTrackBarProperties;
begin
  Result := TcxTrackBarProperties(InternalGetActiveProperties);
end;

function TcxTrackBar.GetProperties: TcxTrackBarProperties;
begin
  Result := TcxTrackBarProperties(FProperties);
end;

procedure TcxTrackBar.SetProperties(Value: TcxTrackBarProperties);
begin
  FProperties.Assign(Value);
end;

{ TcxFilterTrackBarHelper }

class procedure TcxFilterTrackBarHelper.InitializeProperties(AProperties,
  AEditProperties: TcxCustomEditProperties; AHasButtons: Boolean);
begin
  inherited InitializeProperties(AProperties, AEditProperties, AHasButtons);
  with TcxCustomSpinEditProperties(AProperties) do
  begin
    Buttons.Add;
    Buttons.Add;
    MinValue := TcxCustomTrackBarProperties(AEditProperties).Min;
    MaxValue := TcxCustomTrackBarProperties(AEditProperties).Max;
    LargeIncrement := TcxCustomTrackBarProperties(AEditProperties).PageSize;
  end;
end;

initialization
  GetRegisteredEditProperties.Register(TcxTrackBarProperties, scxSEditRepositoryTrackBarItem);
  FilterEditsController.Register(TcxTrackBarProperties, TcxFilterTrackBarHelper);

finalization
  FilterEditsController.Unregister(TcxTrackBarProperties, TcxFilterTrackBarHelper);
  GetRegisteredEditProperties.Unregister(TcxTrackBarProperties);

end.

