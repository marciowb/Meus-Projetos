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
{   result in severe civil and criminal penalties and will be       }
{   prosecuted to the maximum extent possible under the law.        }
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
unit cxWebFormDesigner;

{$I cxVer.inc}

interface

uses Classes, DesignIntf, DesignMenus, DesignEditors,
  {$IFDEF VCL}
  Windows, Messages, Controls, Menus, Forms, Graphics, ImgList, ExtCtrls,
  VCLEditors, VCLMenus,
  {$ELSE}
  Qt, Types, QControls, QMenus, QForms, QGraphics, QImgList, QExtCtrls,
  CLXEditors,
  {$ENDIF}
  cxWebCustomDesigner, cxWebIntf, cxWebClasses, cxWebDsgnIntf, cxWebRender,
  cxWebDsgnConsts, cxWebDsgnTypes, cxWebDsgnHTMLSource;

type
  TcxSelectionMarkHitTestCode = (smhtTopLeft, smhtTopCenter, smhtTopRight,
    smhtRight, smhtBottomRight, smhtBottomCenter, smhtBottomLeft, smhtLeft);

  TcxWebFormDesigner = class;

  TcxSelectionMark = class(TCustomControl)
  private
    FBorderColor: TColor;
    FBorderColorLocked: TColor;
    FColorLocked: TColor;
    FHitTestCode: TcxSelectionMarkHitTestCode;

    function GetLocked: Boolean;
    procedure SetBorderColor(Value: TColor);
    procedure SetBorderColorLocked(Value: TColor);
    procedure SetColorLocked(Value: TColor);
    procedure SetHitTestCode(Value: TcxSelectionMarkHitTestCode);
    function GetCursor: TCursor;

    {$IFDEF VCL}
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    {$ENDIF}
  protected
    {$IFDEF VCL}
    procedure CreateParams(var Params: TCreateParams); override;
    {$ELSE}
    FDesigner: TcxWebFormDesigner;
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    {$ENDIF}
    procedure Paint; override;

    function GetBorderColor: TColor; virtual;
    function GetInteriorColor: TColor; virtual;
  public
    constructor Create(AOwner: TComponent); override;

    property BorderColor: TColor read FBorderColor write SetBorderColor default clWindowText;
    property BorderColorLocked: TColor read FBorderColorLocked write SetBorderColorLocked default clWindowText;
    property Color default clWindowText;
    property ColorLocked: TColor read FColorLocked write SetColorLocked default clBtnFace;
    property HitTestCode: TcxSelectionMarkHitTestCode read FHitTestCode write SetHitTestCode;
    property Locked: Boolean read GetLocked;
    property ParentColor default False;
    property TabStop default False;
  end;

  PLines = ^TLines;
  TLines = array of string;

  {$IFDEF VCL}
  TcxWebDesignerHintWindowClass = class of TcxWebDesignerHintWindow;
  TcxWebDesignerHintWindow = class(TCustomControl)
  private
    FControl: IcxWebControl;

    procedure WMEraseBkgnd(var message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure GetTextMetrics(ALines: PLines; AWidth, AHeight: PInteger);
  public
    constructor Create(AOwner: TComponent); override;

    procedure Activate(const Pt: TPoint);
    procedure Deactivate;

    property Caption;
    property Control: IcxWebControl read FControl write FControl;
  end;
  {$ENDIF}

  TcxScreenCanvasClass = class of TcxScreenCanvas;
  TcxScreenCanvas = class({$IFDEF VCL}TCanvas{$ELSE}TQtCanvas{$ENDIF})
  private
  {$IFNDEF VCL}
    FWidget: QOpenWidgetH;
    FWidgetFlags: Integer;
  {$ENDIF}
    procedure FreeContext;
  protected
    procedure CreateHandle; override;
  public
    destructor Destroy; override;
  end;

  TcxWebDesignerUndoItem = class
  private
    FParent: TComponent;
    FStream: TStream;
  public
    constructor Create(AParent: TComponent; AStream: TStream);
    destructor Destroy; override;

    property Parent: TComponent read FParent;
    property Stream: TStream read FStream;
  end;

  TcxDesignSurface = class(TCustomControl)
  private
    FDesigner: TcxWebFormDesigner;
    FPattern: TBitmap;

    procedure PaintGrid;
    function GetControlBottom: Integer;
    function GetControlRight: Integer;
    function GetLeft: Integer;
    function GetTop: Integer;
    {$IFDEF VCL}
    procedure CMControlListChange(var Message: TMessage); message CM_CONTROLLISTCHANGE;
    {$ELSE}
    //TODO LINUX_NOT_IMPL
    {$ENDIF}
  protected
    procedure Paint; override;
   {$IFDEF VCL}
    procedure WndProc(var Message: TMessage); override;
    {$ELSE}
    function EventFilter(Sender: QObjectH; Event: QEventH): Boolean; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RefreshBounds;
    procedure RefreshPattern;

    property ControlBottom: Integer read GetControlBottom;
    property ControlRight: Integer read GetControlRight;
    property Designer: TcxWebFormDesigner read FDesigner;
    property MouseCapture;
    property Pattern: TBitmap read FPattern;
  end;

  TcxDesignSurfaceScrollBox = class(TScrollBox)
  private
    FDesignSurface: TcxDesignSurface;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

   {$IFDEF VCL}
    procedure WndProc(var Message: TMessage); override;
    {$ELSE}
    //TODO LINUX_NOT_IMPL
    {$ENDIF}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property DesignSurface: TcxDesignSurface read FDesignSurface;
  end;


  { TcxWebFormDesigner }
  TcxWebDesignerHintType = (htInfo, htSize, htPosition);
  TcxDesignerState = (dsNone, dsCreateControls, dsDragControls, dsSelectControls);
  TcxMoveAffect = (maLeft, maTop, maRight, maBottom);
  TcxDragAffect = (daNone, daMove, daSize);
  TcxResizeAffect = (raTopLeft, raTop, raTopRight, raRight, raBottomRight, raBottom, raBottomLeft, raLeft);

  PRects = ^TRects;
  TRects = array[0..High(Integer) div SizeOf(TRect) - 1] of TRect;

  {$IFNDEF VCL}
  HRGN = HANDLE;
  {$ENDIF}

  TcxWebFormDesigner = class(TcxWebCustomDesigner)
  private
    FClipRgn: HRGN;
    FDesignerControl: TWinControl;
    FDragAffect: TcxDragAffect;
    FDraggingPoint: TPoint;
    FDraggingRects: PRects;
    {$IFDEF VCL}
    FHintCanceled: Boolean;
    FHintHideTimer: TTimer;
    FHintShowTimer: TTimer;
    FHintWindow: TcxWebDesignerHintWindow;
    {$ENDIF}
    FHitControl: IcxWebControl;
    FHitDesignerParent: TWinControl;
    FHitCreatedDesignerParent: TWinControl;
    FMarks: array[TcxSelectionMarkHitTestCode] of TcxSelectionMark;
    FSaveDraggingRects: PRects;
    FSelectionRect: TRect;
    FShift: TShiftState;
    FScreenCanvas: TcxScreenCanvas;
    FResizingAffect: TcxResizeAffect;
    FState: TcxDesignerState;
    FUndoItem: TcxWebDesignerUndoItem;
    FUndoState: Boolean;
    FUpdateControlsPositionFlag: Boolean;

    FSelections: IInterfaceList; //contains the list of IcxWebControl
    FClipboardSelection: TList;

    function GetControlByWinControl(AControl: TWinControl): IcxWebControl;
    function GetWinControlByInterface(AInterface: IInterface): TWinControl;
    function CreateSelectionComponent: TList;

    function GetCreatedParentWinControl: TWinControl;
    function GetCreatedParentControl: IcxWebContainerControl;

    function GetFirstSelectionControl: IcxWebControl;
    function GetFirstSelectionDesignerControl: IcxWebDesignerControl;
    function GetFirstSelectionWinControl: TWinControl;

    function GetHitMark: TcxSelectionMark;
    function GetReadOnly: Boolean;

    function GetActiveControl: IcxWebControl;
    function GetActiveDesignerControl: IcxWebDesignerControl;
    function GetActiveWinControl: TWinControl;

    procedure SetActiveControl(Value: IcxWebControl);
    procedure SetActiveDesignerControl(Value: IcxWebDesignerControl);
    procedure SetActiveWinControl(Value: TWinControl);

    function GetSelectionCount: Integer;
    function GetSelectionComponent(Index: Integer): TComponent;
    function GetSelectionControl(Index: Integer): IcxWebControl;
    function GetSelectionDesignerControl(Index: Integer): IcxWebDesignerControl;
    function GetSelectionWinControl(Index: Integer): TWinControl;


    procedure SetReadOnly(const Value: Boolean);

    procedure DoUpdateControlPosition(var Value: Boolean);

    {$IFDEF VCL}
    function IsDesignMsg(var Message: TMessage): Boolean;
    {$ELSE}
    function IsDesignMsg(Sender: QObjectH; Event: QEventH): Boolean;
    {$ENDIF}
  protected
    function CanAlign: Boolean; override;
    function CanAlignToGrid: Boolean; override;
    { undo and clipboard supports }
    procedure ComponentRead(AComponent: TComponent);
    procedure CreateUndoItem(AParent: TComponent; AComponents: TList);
    procedure PasteComponents(AOwner, AParent: TComponent);
    procedure UndoComponents;
    { web components }
    procedure InernalComponentCreated(AnItem: TComponent);
    procedure InsertWebComponent(AComponent: TComponent);
    procedure RemoveWebComponent(AComponent: TComponent);
    { design controls }
    function InsertWebDesignControl(AWebControl: IcxWebControl): IcxWebDesignerControl;
    procedure RemoveWebDesignControl(AWebControl: IcxWebControl);
    procedure NillDesingerControls;
    { components creation }
    procedure BeginCreation(const Pt: TPoint);
    procedure CancelCreation(ARefreshFrame: Boolean);
    procedure DoCreation(const Pt: TPoint);
    procedure EndCreation;
    procedure PrepareCreateControl(const Pt: TPoint);
    { components dragging }
    procedure BeginDragControls(const Pt: TPoint);
    procedure CancelDragControls(ARefreshFrame: Boolean);
    procedure DoDragControls(const Pt: TPoint);
    procedure EndDragControls;
    procedure PrepareDragControls;
    { components selection }
    procedure BeginSelection(const Pt: TPoint);
    procedure CancelSelection(ARefreshFrame: Boolean);
    procedure DoSelection(const Pt: TPoint);
    procedure EndSelection;
    function InSelection(const AControl: IcxWebControl): Boolean;
    function MoveAffectForKey(Key: Word): TcxMoveAffect;
    procedure MoveSelection(AMoveAffect: TcxMoveAffect);
    procedure NormalizeSelection(ARelativeParent: IcxWebContainerControl);
    procedure ResizeSelection(AMoveAffect: TcxMoveAffect);
    procedure Select(AControl: IcxWebControl; AddToSelection: Boolean = True);
    procedure SelectParent(AControl: IcxWebControl; AddToSelection: Boolean = True);
    procedure SelectControlsInRect(ARect: TRect);
    procedure SelectNearestControl(AMoveAffect: TcxMoveAffect);
    procedure Unselect(AControl: IcxWebControl);
    procedure UnselectList(const AList: IInterfaceList);
    { frame painting }
    procedure DrawDragFrame(const R: TRect);
    procedure DrawDragFrames(ACleanPrevious: Boolean);
    procedure DrawSelectionFrame(const R: TRect);
    { selection marks }
    procedure CreateSelectionMarks;
    procedure FreeSelectionMarks;
    procedure ShowSelectionMarks(Value: Boolean);
    procedure UpdateSelectionBoundsRect;
    { states generally }
    procedure BeginState(const Pt: TPoint);
    procedure CancelState(ADropState, ARefreshFrame: Boolean);
    function CanMoveTo(const Pt: TPoint): Boolean;
    procedure DoState(const Pt: TPoint);
    procedure DropState;
    procedure EndState;
    function FindHitWinControlParent(AWebControl: IcxWebControl): TWinControl;
    function FindHitCreatedWinControlParent(AWebControl: IcxWebControl): TWinControl;
    function FindHitControl: IcxWebControl;
    function GetClipRect: TRect;
    function GetDragRect(Index: Integer; ArrangedToGrid: Boolean): TRect;
    function IsDeadZone(const Pt: TPoint): Boolean;
    //function IsProcessedDesignHitTest(const Pt: TSmallPoint; AShiftState: TShiftState): Boolean;
    procedure NormalizeRectCoords(var R: TRect);
    procedure PrepareCanvas(var Rgn: HRGN);
    procedure PrepareFrameRect(var R: TRect; const Pt: TPoint);
    procedure PrepareFrameRects(const Pt: TPoint);
    procedure RecognizeHitControls;
    procedure UnprepareCanvas(var Rgn: HRGN);
    {$IFDEF VCL}
    { hints }
    procedure HintActivate(const Pt: TPoint; const R: TRect;
      AControl: IcxWebControl; AHintType: TcxWebDesignerHintType; AImmediate: Boolean);
    function HintDataRect(AControl: IcxWebControl): TRect;
    procedure HintDeactivate(ACheckVisibility, ACancel, ADropControl: Boolean);
    function HintGetText(const R: TRect; AControl: IcxWebControl;
      AHintType: TcxWebDesignerHintType): string;
    procedure HintHide(Sender: TObject);
    procedure HintProcess(const Pt: TPoint);
    procedure HintShow(Sender: TObject);
    {$ENDIF}
  protected
    procedure DoAlignToGrid;
    procedure DoCopy;
    procedure DoCut;
    procedure DoDelete;
    procedure DoPaste;
    procedure DoUndo;

    function GetHTMLTemplateModified(var AFileName, AText: string): Boolean; override;

    function ShowTabOrderSelectionDlg: Boolean; override;
    procedure AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign); override;
    procedure ScaleSelection(AScaleFactor: Integer); override;
    procedure SizeSelection(AHorzAffect: TcxSizeAffect; AVertAffect: TcxSizeAffect;
      AHorzAbsolute: Integer; AVertAbsolute: Integer); override;

    {$IFDEF VCL}
    function GetHintWindowClass: TcxWebDesignerHintWindowClass; virtual;
    {$ENDIF}
    function GetScreenCanvasClass: TcxScreenCanvasClass; virtual;

    procedure IDEDesignerOptionsChagned; override;

    property CreatedParentWinControl: TWinControl read GetCreatedParentWinControl;
    property CreatedParentControl: IcxWebContainerControl read GetCreatedParentControl;
    property DesignerControl: TWinControl read GetDesignerControl;
    property DragAffect: TcxDragAffect read FDragAffect;

    property ActiveControl: IcxWebControl read GetActiveControl write SetActiveControl;
    property ActiveDesignerControl: IcxWebDesignerControl read GetActiveDesignerControl
        write SetActiveDesignerControl;
    property ActiveWinControl: TWinControl read GetActiveWinControl
        write SetActiveWinControl;
    property FirstSelectionControl: IcxWebControl read GetFirstSelectionControl;
    property FirstSelectionDesignerControl: IcxWebDesignerControl read GetFirstSelectionDesignerControl;
    property FirstSelectionWinControl: TWinControl read GetFirstSelectionWinControl;

    property HitControl: IcxWebControl read FHitControl;
    property HitDesignerParent: TWinControl read FHitDesignerParent;
    property HitCreatedDesignerParent: TWinControl read FHitCreatedDesignerParent;
    property HitMark: TcxSelectionMark read GetHitMark;
    property ResizingAffect: TcxResizeAffect read FResizingAffect;
    property Shift: TShiftState read FShift;
    property State: TcxDesignerState read FState;

    property SelectionCount: Integer read GetSelectionCount;
    property SelectionComponents[Index: Integer]: TComponent read GetSelectionComponent;
    property SelectionControls[Index: Integer]: IcxWebControl read GetSelectionControl;
    property SelectionDesignerControls[Index: Integer]: IcxWebDesignerControl read GetSelectionDesignerControl;
    property SelectionWinControls[Index: Integer]: TWinControl read GetSelectionWinControl;
  public
    constructor Create(AForm: TCustomForm; ADelphiDesigner: IDesigner); override;
    destructor Destroy; override;

    procedure ComponentCreated(AnItem: TComponent); override;
    procedure ComponentDestroyed(AnItem: TComponent); override;
    procedure ComponentChangedName(AComponent: TComponent; const AOldName, ANewName: string); override;

    procedure CreateDesignerControl(AParentControl: TWinControl); override;
    procedure DestroyDesignerControl; override;
    function GetDesignerControl: TWinControl; override;
    procedure UpdateDesignerControl; override;
    procedure RefreshDesignControls; override;

    procedure DesignerPositioningTypeChanged; override;
    function IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean; override;

    class function GetID: Integer; override;
    class function GetName: String; override;

    function CanCopy: Boolean; override;
    function CanCut: Boolean; override;
    function CanPaste: Boolean; override;
    function CanSelectAll: Boolean; override;
    function CanTabOrder: Boolean; override;
    function CanUndo: Boolean; override;

    { IcxWebDesigner }
    procedure AlignToGrid; override;
    function CanSelect(const AControl: TComponent): Boolean; override;
    procedure CopySelection; override;
    procedure CutSelection; override;
    procedure DeleteSelection; override;
    procedure Edit(AComponent: TComponent); override;
    procedure GetSelections(const AList: TList); override;
    procedure PasteSelection; override;
    procedure Modified; override;
    procedure SelectAll; override;
    procedure SelectionChanged(const AList: TList); override;
    procedure Undo; override;

    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property Root: TComponent read GetRoot;
  end;

implementation

uses
  SysUtils, ClipBrd, ComponentDesigner,
  cxWebGraphics, cxWebDsgnGraphics, cxWebDsgnUtils, cxWebDsgnStrs,
  cxWebDsgnFactory, cxWebCtrlsFactory, cxfmAlign, cxfmScale, cxfmTabOrder,
  cxWebUtils, cxWebStdCtrls;

const
  HintTypes: array[TcxDesignerState] of TcxWebDesignerHintType = (htInfo, htSize, htSize, htSize);
  CRLF = #13#10;

{$IFNDEF VCL}
procedure MapWindowPoints(AWidgetFrom, AWidgetTo: QWidgetH; var Points; PointNumber: Integer);
var
  APoint: TPoint;
  I: Integer;
begin
  if (AWidgetFrom = nil) and (AWidgetTo = nil) then exit;
  for I := 0 to PointNumber - 1 do
  begin
    Move((PChar(@Points) + I * SizeOf(APoint))^, APoint, SizeOf(APoint));
    if (AWidgetFrom = nil) then
      QWidget_mapFromGlobal(AWidgetTo, @APoint, @APoint)
    else
      if (AWidgetTo = nil) then
         QWidget_mapToGlobal(AWidgetFrom, @APoint, @APoint)
      else QWidget_mapTo(AWidgetFrom, @APoint, AWidgetFrom, @APoint);
    Move(APoint, (PChar(@Points) + I * SizeOf(APoint))^, SizeOf(APoint));
  end;
end;
{$ENDIF}


{ TcxSelectionMark }

constructor TcxSelectionMark.Create(AOwner: TComponent);
begin
  inherited;
  BorderColor := clWindowText;
  ParentColor := False;
  Color := clWindowText;
  FBorderColorLocked := clWindowText;
  FColorLocked := clBtnShadow;

  Height := cxMarkSize;
  Width := cxMarkSize;
  TabStop := False;
end;

{$IFDEF VCL}
procedure TcxSelectionMark.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.WindowClass.Style := 0;
end;
{$ENDIF}

procedure TcxSelectionMark.Paint;
begin
  Canvas.Pen.Color := GetBorderColor;
  Canvas.Brush.Color := GetInteriorColor;
  Canvas.Rectangle(ClientRect);
end;

function TcxSelectionMark.GetBorderColor: TColor;
begin
  if Locked then
    Result := BorderColorLocked
  else
    Result := BorderColor;
end;

function TcxSelectionMark.GetInteriorColor: TColor;
begin
  if Locked then
    Result := ColorLocked
  else
    Result := Color
end;

function TcxSelectionMark.GetLocked: Boolean;
begin
  Result := (ActiveDesigner <> nil) and ActiveDesigner.ControlsLocked;
end;

procedure TcxSelectionMark.SetBorderColor(Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    if not Locked then Invalidate;
  end;
end;

procedure TcxSelectionMark.SetBorderColorLocked(Value: TColor);
begin
  if FBorderColorLocked <> Value then
  begin
    FBorderColorLocked := Value;
    if Locked then Invalidate;
  end;
end;

procedure TcxSelectionMark.SetColorLocked(Value: TColor);
begin
  if FColorLocked <> Value then
  begin
    FColorLocked := Value;
    if Locked then Invalidate;
  end;
end;

procedure TcxSelectionMark.SetHitTestCode(Value: TcxSelectionMarkHitTestCode);
begin
  FHitTestCode := Value;
  Cursor := GetCursor;
end;

function TcxSelectionMark.GetCursor: TCursor;
const
  Cursors: array[TcxSelectionMarkHitTestCode] of TCursor =
    (crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE, crSizeNWSE, crSizeNS, crSizeNESW, crSizeWE);
begin
  Result := Cursors[HitTestCode];
end;

{$IFDEF VCL}
procedure TcxSelectionMark.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TcxSelectionMark.CMColorChanged(var Message: TMessage);
begin
  if not Locked then Invalidate;
end;
{$ELSE}
function TcxSelectionMark.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  case QEvent_type(Event) of
    QEventType_MouseButtonPress, QEventType_MouseButtonRelease,
    QEventType_MouseMove:
    begin
      if (QEvent_type(Event) = QEventType_MouseButtonPress) then
      begin
        FDesigner.DesignerControl.Cursor := GetCursor;
        FDesigner.ActiveWinControl.Cursor := GetCursor;
      end;
      FDesigner.IsDesignMsg(Handle, Event);
      Result := False;
    end;
    QEventType_KeyPress:
      begin
        FDesigner.IsDesignMsg(Handle, Event);
        Result := False;
      end;
    else Result := inherited EventFilter(Handle, Event);
  end;
end;
{$ENDIF}

{$IFDEF VCL}
{ TcxWebDesignerHintWindow }

constructor TcxWebDesignerHintWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Canvas.Font := Screen.HintFont;
end;

procedure TcxWebDesignerHintWindow.Activate(const Pt{, Delta}: TPoint);
const
  Offset: TPoint = (X: 16; Y: 16);
var
  R: TRect;
  W, H: Integer;
begin
  Application.CancelHint;

  H := 0;
  W := 0;
  GetTextMetrics(nil, @W, @H);
  R := Bounds(Pt.X + Offset.X, Pt.Y + Offset.Y, W, H);
  with R do
  begin
    if Right > Screen.Width then OffsetRect(R, Screen.Width - Right, 0);
    if Bottom > Screen.Height then OffsetRect(R, 0, Screen.Height - Bottom);
    if Left < 0 then OffsetRect(R, -Left, 0);
    if Top < 0 then OffsetRect(R, 0, -Top);
  end;

  if IsWindowVisible(Handle) then
    if (Width <> W) or (Height <> H) then
      ShowWindow(Handle, SW_HIDE)
    else
    begin
      InvalidateRect(Handle, nil, False);
      UpdateWindow(Handle);
    end;     
    
  SetWindowPos(Handle, HWND_TOPMOST, R.Left, R.Top, W, H, SWP_SHOWWINDOW or SWP_NOACTIVATE);
end;

procedure TcxWebDesignerHintWindow.Deactivate;
begin
  ShowWindow(Handle, SW_HIDE);
end;

procedure TcxWebDesignerHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_POPUP or WS_DISABLED;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    ExStyle := WS_EX_TOOLWINDOW;
  end;
end;

procedure TcxWebDesignerHintWindow.GetTextMetrics(ALines: PLines; AWidth, AHeight: PInteger);
var
  S, SubStr: string;
  I, P, W: Integer;
  R: TRect;
begin
  S := Caption;
  I := 0;
  repeat
    Inc(I);
    P := Pos(CRLF, S);
    if P <> 0 then
    begin
      SubStr := Copy(S, 1, P - 1);
      Delete(S, 1, P - 1 + Length(CRLF));
    end
    else
      SubStr := S;

    if ALines <> nil then
    begin
      SetLength(ALines^, I);
      ALines^[I - 1] := SubStr;
    end;

    if (AWidth <> nil) or (AHeight <> nil) then
    begin
      R := Rect(0, 0, Screen.Width, 0);
      DrawText(Canvas.Handle, PChar(SubStr), Length(SubStr), R,
        DT_CALCRECT or DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_NOPREFIX);

      if AWidth <> nil then
      begin
        W := R.Right - R.Left;
        if W > AWidth^ then AWidth^ := W;
      end;
      if AHeight <> nil then
        Inc(AHeight^, R.Bottom - R.Top + 3 + 3);
    end;
  until P = 0;

  if AWidth <> nil then Inc(AWidth^, 2 + 2);
  if AHeight <> nil then Inc(AHeight^, 2 + 2);
end;

procedure TcxWebDesignerHintWindow.Paint;
var
  R: TRect;
  I, H, W: Integer;
  Lines: TLines;
  S: string;
begin
  R := ClientRect;
  Frame3D(Canvas, R, clBtnFace, clWindowText, 1);
  Canvas.Font.Color := clInfoText;
  Canvas.Brush.Color := clInfoBk;
  Canvas.FillRect(R);

  H := 0;
  W := 0;
  GetTextMetrics(@Lines, @W, @H);
  H := (H - 2 - 2) div Length(Lines);
  for I := 0 to Length(Lines) - 1 do
  begin
    R := Bounds(2, 2 + I * H, W - 2, H);
    S := Lines[I];
    DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_NOPREFIX);
  end;
end;

procedure TcxWebDesignerHintWindow.WMEraseBkgnd(var message: TWMEraseBkgnd);
begin
  message.Result := 1;
end;
{$ENDIF}

{ TcxScreenCanvas }
destructor TcxScreenCanvas.Destroy;
begin
  FreeContext;
  inherited Destroy;
end;

procedure TcxScreenCanvas.CreateHandle;
begin
  {$IFDEF VCL}
  Handle := GetDC(0);
  {$ELSE}
  FWidget := QOpenWidgetH(QApplication_desktop);
  FWidgetFlags := QOpenWidget_getWFlags(FWidget);
  QOpenWidget_setWFlags(FWidget, FWidgetFlags or Integer(WidgetFlags_WPaintUnclipped));
  QtHandle := FWidget;
  inherited CreateHandle;
  Start;
  {$ENDIF}
end;


procedure TcxScreenCanvas.FreeContext;
begin
  {$IFDEF VCL}
  if Handle <> 0 then ReleaseDC(0, Handle);
  Handle := 0;
  {$ELSE}
  Stop;
  QOpenWidget_setWFlags(FWidget, FWidgetFlags);
  {$ENDIF}
end;

{ TcxWebDesignerUndoItem }

constructor TcxWebDesignerUndoItem.Create(AParent: TComponent; AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
  FParent := AParent;
end;

destructor TcxWebDesignerUndoItem.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

{TcxDesignSurface}

constructor TcxDesignSurface.Create(AOwner: TComponent);
begin
  inherited;
  ParentColor := False;
  Color := clWindow;
  ControlStyle := ControlStyle - [csCaptureMouse] + [csOpaque];
  TabStop := False;
end;

destructor TcxDesignSurface.Destroy;
begin
  if FPattern <> nil then
    FPattern.Free;
  FDesigner := nil;
  inherited Destroy;
end;

procedure TcxDesignSurface.RefreshPattern;
begin
  with FDesigner do
    if (FPattern <> nil) and (GridSizeX < 9) and (GridSizeY < 9) then
      with FPattern do
      begin
        Width := GridSizeX;
        Height := GridSizeY;
        Canvas.Brush.Color := clcxWebDesignerSurfaceColor;
        Canvas.FillRect(Rect(0, 0, Width, Height));
        Canvas.Pixels[0, 0] := clcxWebDesignerGridColor;
      end;
end;

procedure TcxDesignSurface.PaintGrid;

  procedure DrawGridPattern;
  begin
    if Pattern = nil then
    begin
      FPattern := TBitmap.Create;
      RefreshPattern;
    end;
    Canvas.Brush.Bitmap := Pattern;
    Canvas.FillRect(Canvas.ClipRect);
    Canvas.Brush.Bitmap := nil;
  end;

  procedure DrawGridPoints;
  var
    R: TRect;
    I, J: Integer;
  begin
    R := Canvas.ClipRect;
    with FDesigner do
      for I := 0 to ClientWidth - 1 do
        if I mod GridSizeX = 0 then
          for J := 0 to ClientHeight - 1 do
            if J mod GridSizeY = 0 then
              if PtInRect(R, Point(I, J)) then
                Canvas.Pixels[I, J] := clcxWebDesignerGridColor;
  end;

begin
  with FDesigner do
  begin
    if not DisplayGrid or (GridSizeX > 8) or (GridSizeY > 8) then
    begin
      Canvas.Brush.Color := clcxWebDesignerSurfaceColor;
      Canvas.FillRect(Canvas.ClipRect);
    end;
    if DisplayGrid then
      if (GridSizeX < 9) and (GridSizeY < 9) then
        DrawGridPattern
      else
        DrawGridPoints;
  end;
end;

function TcxDesignSurface.GetControlBottom: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ControlCount - 1 do
    if Result < Controls[i].BoundsRect.Bottom then
      Result := Controls[i].BoundsRect.Bottom;
end;

function TcxDesignSurface.GetControlRight: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to ControlCount - 1 do
    if Result < Controls[i].BoundsRect.Right then
      Result := Controls[i].BoundsRect.Right;
end;

function TcxDesignSurface.GetLeft: Integer;
begin
  Result := 0;
  if Parent <> nil then
   with TcxDesignSurfaceScrollBox(Parent).HorzScrollBar do
     if Visible and (Range <> 0) then
       Result := - Width * Position div Range;
end;

function TcxDesignSurface.GetTop: Integer;
begin
  Result := 0;
  if Parent <> nil then
   with TcxDesignSurfaceScrollBox(Parent).VertScrollBar do
     if Visible and (Range <> 0) then
       Result :=  - Height * Position div Range;
end;

{$IFDEF VCL}
procedure TcxDesignSurface.CMControlListChange(var Message: TMessage);
begin
  inherited;
  RefreshBounds;
end;
{$ENDIF}

procedure TcxDesignSurface.Paint;
begin
  inherited;
  PaintGrid;
end;

{$IFDEF VCL}
procedure TcxDesignSurface.WndProc(var Message: TMessage);
begin
  if (Designer <> nil) and Designer.IsDesignMsg(Message) or (Message.Msg = WM_ERASEBKGND) then
    Exit;
  inherited;
end;
{$ELSE}
function TcxDesignSurface.EventFilter(Sender: QObjectH; Event: QEventH): Boolean;
begin
  if (Designer <> nil) and Designer.IsDesignMsg(Sender, Event) then
    Result := True
  else Result := inherited EventFilter(Sender, Event);
end;
{$ENDIF}

procedure TcxDesignSurface.RefreshBounds;
var
  NewHeight, NewWidth: Integer;
  OldHorzScrollBarVisible, OldVertScrollBarVisible: Boolean;
begin
  if Parent = nil then exit;
  if (Height < Parent.ClientHeight) or (Parent.ClientHeight > ControlBottom) then
    NewHeight := Parent.ClientHeight
  else NewHeight := ControlBottom;
  if (Width < Parent.ClientWidth) or (Parent.ClientWidth > ControlRight) then
    NewWidth := Parent.ClientWidth
  else NewWidth := ControlRight;
  OldHorzScrollBarVisible := TcxDesignSurfaceScrollBox(Parent).HorzScrollBar.Visible;
  OldVertScrollBarVisible := TcxDesignSurfaceScrollBox(Parent).VertScrollBar.Visible;
  TcxDesignSurfaceScrollBox(Parent).HorzScrollBar.Visible := (NewWidth > Parent.ClientWidth);
  TcxDesignSurfaceScrollBox(Parent).VertScrollBar.Visible := (NewHeight > Parent.ClientHeight);

  if (OldHorzScrollBarVisible <> TcxDesignSurfaceScrollBox(Parent).HorzScrollBar.Visible)
  or (OldVertScrollBarVisible <> TcxDesignSurfaceScrollBox(Parent).VertScrollBar.Visible) then
    RefreshBounds
  else SetBounds(GetLeft, GetTop, NewWidth, NewHeight);
end;

{TcxDesignSurfaceScrollBox}
constructor TcxDesignSurfaceScrollBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignSurface := TcxDesignSurface.Create(self);
  FDesignSurface.Left := 0;
  FDesignSurface.Top := 0;
  FDesignSurface.Parent := self;
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
end;

destructor TcxDesignSurfaceScrollBox.Destroy;
begin
  inherited Destroy;
end;

{$IFDEF VCL}
procedure TcxDesignSurfaceScrollBox.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if (Message.Msg = WM_HSCROLL) or  (Message.Msg = WM_VSCROLL) then
    DesignSurface.SetBounds(DesignSurface.GetLeft, DesignSurface.GetTop,
                  DesignSurface.Width, DesignSurface.Height);
end;
{$ENDIF}

procedure TcxDesignSurfaceScrollBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if DesignSurface <> nil then
    DesignSurface.RefreshBounds; 
end;


{ TcxWebFormDesigner }

constructor TcxWebFormDesigner.Create(AForm: TCustomForm; ADelphiDesigner: IDesigner);
begin
  inherited Create(AForm, ADelphiDesigner);

  FSelections := TInterfaceList.Create;

  {$IFDEF VCL}
  FHintWindow := GetHintWindowClass.Create(nil);
  FHintShowTimer := TTimer.Create(nil);
  FHintShowTimer.Enabled := False;
  FHintShowTimer.OnTimer := HintShow;
  FHintHideTimer := TTimer.Create(nil);
  FHintHideTimer.Enabled := False;
  FHintHideTimer.OnTimer := HintHide;
  {$ENDIF}
  FUpdateControlsPositionFlag := False;
end;

destructor TcxWebFormDesigner.Destroy;
begin
  {$IFDEF VCL}
  FHintCanceled := True;
  FHintHideTimer.Free;
  FHintShowTimer.Free;
  FHintWindow.Free;
  {$ENDIF}
  FUndoItem.Free;
  inherited Destroy;
end;

function HorzCompareFunc(AItem1, AItem2: Pointer): Integer;
begin
  Result := IcxWebControl(AItem1).BoundsRect.Left - IcxWebControl(AItem2).BoundsRect.Left;
end;

function VertCompareFunc(AItem1, AItem2: Pointer): Integer;
begin
  Result := IcxWebControl(AItem1).BoundsRect.Top - IcxWebControl(AItem2).BoundsRect.Top;
end;

function TcxWebFormDesigner.GetHTMLTemplateModified(var AFileName, AText: string): Boolean;
var
  ADsgnHTMLSource: TcxWebDsgnHTMLSource;
begin
  ADsgnHTMLSource := TcxWebDsgnHTMLSource.Create('', DelphiDesigner);
  if (ADsgnHTMLSource.FSourceEditor <> nil) and
    (ADsgnHTMLSource.FSourceEditor.Modified or
     not FileExists(ADsgnHTMLSource.FSourceEditor.FileName)) then
  begin
    AFileName := ADsgnHTMLSource.FSourceEditor.FileName;
    AText := ADsgnHTMLSource.HTML;
    Result := True;
  end else Result := inherited GetHTMLTemplateModified(AFileName, AText);
  ADsgnHTMLSource.Free;
end;

function TcxWebFormDesigner.ShowTabOrderSelectionDlg: Boolean;
var
  Container: IcxWebContainerControl;
  Data: TcxTabOrderDlgData;
begin
  Container := CreatedParentControl;
  if Container <> nil then
  begin
    FillChar(Data, SizeOf(TcxTabOrderDlgData), 0);
    Data.Controls := TList.Create;
    try
      Container.GetTabOrderList(Data.Controls);
      Result := cxShowTabOrderDialog(@Data);
      if Result then
      begin
        Container.SetTabOrderList(Data.Controls);
        DelphiDesigner.Modified;
      end;
    finally
      Data.Controls.Free;
    end
  end
  else
    Result := False;
end;

procedure TcxWebFormDesigner.AlignSelection(AHorzAlign: TcxHorzAlign; AVertAlign: TcxVertAlign);

type
  PcxAlignData = ^TcxAlignData;
  TcxAlignData = record
    CenterWidth: Integer;
    CenterHeight: Integer;
    MostLeft: Integer;
    MostTop: Integer;
    ParentWidth: Integer;
    ParentHeight: Integer;
    HorzDistance: Integer;
    VertDistance: Integer;
    HorzSortedList: TList;
    VertSortedList: TList;
  end;

  procedure CalcAlignData(var AAlignData: TcxAlignData);
  var
    I: Integer;
    AWebControl: IcxWebControl;
    ALeftMost: IcxWebControl;
    ARightMost: IcxWebControl;
    ATopMost: IcxWebControl;
    ABottomMost: IcxWebControl;
    R: TRect;
  begin
    ALeftMost := nil;
    ARightMost := nil;
    ATopMost := nil;
    ABottomMost := nil;
    for I := 0 to SelectionCount - 1 do
    begin
      AWebControl := SelectionControls[I];
      R := AWebControl.BoundsRect;
      if (ALeftMost = nil) or (ALeftMost.BoundsRect.Left > R.Left) then
        ALeftMost := AWebControl;
      if (ARightMost = nil) or (ARightMost.BoundsRect.Right < R.Right) then
        ARightMost := AWebControl;
      if (ATopMost = nil) or (ATopMost.BoundsRect.Top > R.Top) then
        ATopMost := AWebControl;
      if (ABottomMost = nil) or (ABottomMost.BoundsRect.Bottom < R.Bottom) then
        ABottomMost := AWebControl;
    end;
    with AAlignData do
    begin
      with FindHitWinControlParent(FirstSelectionControl) do
      begin
        ParentWidth := ClientWidth;
        ParentHeight := ClientHeight;
      end;

      with FirstSelectionWinControl do
      begin
        CenterWidth := Width;
        CenterHeight := Height;
      end;

      if (SelectionCount > 1) then
      begin
        HorzDistance := (ARightMost.BoundsRect.Left - ALeftMost.BoundsRect.Left) div (SelectionCount - 1);
        VertDistance := (ABottomMost.BoundsRect.Top - ATopMost.BoundsRect.Top) div (SelectionCount - 1);
      end;
      
      HorzSortedList := nil;
      if AHorzAlign = haSpace then
      begin
        HorzSortedList := CloneList(FSelections);
        HorzSortedList.Sort(HorzCompareFunc);
      end;

      VertSortedList := nil;
      if AVertAlign = vaSpace then
      begin
        VertSortedList := CloneList(FSelections);
        VertSortedList.Sort(VertCompareFunc);
      end;
      MostLeft := ALeftMost.BoundsRect.Left;
      MostTop := ATopMost.BoundsRect.Top;
    end;
  end;

  procedure FreeList(AList: TList);
  var
    I: Integer;
  begin
    if AList = nil then Exit;
    for I := 0 to AList.Count - 1 do
      IInterface(AList[I])._Release;
    AList.Free;
  end;

  procedure PlaceControls(const AAlignData: TcxAlignData);
  var
    I, Index: Integer;
    AWebControl: IcxWebControl;
    ALeft, ATop, AWidth, AHeight: Integer;
  begin
    with AAlignData do
      for I := 0 to SelectionCount - 1 do
      begin
        AWebControl := SelectionControls[I];
        with AWebControl.BoundsRect do
        begin
          ALeft := Left;
          ATop := Top;
          AWidth := Right - Left;
          AHeight := Bottom - Top;
        end;
        case AHorzAlign of
          haLeft:
            ALeft := FirstSelectionWinControl.Left;
          haCenter:
            ALeft := FirstSelectionWinControl.Left - (AWidth - CenterWidth) div 2;
          haRight:
            ALeft := FirstSelectionWinControl.BoundsRect.Right - AWidth;
          haSpace:
            begin
              Index := HorzSortedList.IndexOf(Pointer(AWebControl));
              if (Index <> 0) and (Index <> HorzSortedList.Count - 1) then
                ALeft := MostLeft + HorzDistance * Index;
            end;
          haWinCenter:
            ALeft := (ParentWidth - AWidth) div 2;
        end;

        case AVertAlign of
          vaTop:
            ATop := FirstSelectionWinControl.Top;
          vaCenter:
            ATop := FirstSelectionWinControl.Top - (AHeight - CenterHeight) div 2;
          vaBottom:
            ATop := FirstSelectionWinControl.BoundsRect.Bottom - AHeight;
          vaSpace:
            begin
              Index := VertSortedList.IndexOf(Pointer(AWebControl));
              if (Index <> 0) and (Index <> VertSortedList.Count - 1) then
                ATop := MostTop + VertDistance * Index;
            end;
          vaWinCenter:
            ATop := (ParentHeight - AHeight) div 2;
        end;

        SelectionWinControls[i].SetBounds(ALeft, ATop, AWidth, AHeight);
      end;
  end;

var
  AlignData: TcxAlignData;
begin
  if (AHorzAlign = haNothing) and (AVertAlign = vaNothing) or
    (SelectionCount = 0)then
    Exit;

  BeginUpdate;
  try
    FillChar(AlignData, SizeOf(TcxAlignData), 0);
    try
      CalcAlignData(AlignData);
      PlaceControls(AlignData);
    finally
      FreeList(AlignData.HorzSortedList);
      FreeList(AlignData.VertSortedList);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebFormDesigner.ScaleSelection(AScaleFactor: Integer);
var
  I: Integer;
  Control: IcxWebControl;
  R: TRect;
begin
  BeginUpdate;
  try
    for I := 0 to SelectionCount - 1 do
    begin
      Control := SelectionControls[I];
      R := Control.BoundsRect;
      with R do
      begin
        Right := Left + MulDiv(Right - Left, AScaleFactor, 100);
        Bottom := Top + MulDiv(Bottom - Top, AScaleFactor, 100);
      end;
      Control.BoundsRect := R;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TcxWebFormDesigner.SizeSelection(AHorzAffect: TcxSizeAffect;
  AVertAffect: TcxSizeAffect; AHorzAbsolute: Integer; AVertAbsolute: Integer);
var
  I, AWidth, AHeight: Integer;
  ACurrentWidth, ACurrentHeight: Integer;
begin
  if (AHorzAffect = saNothing) and (AVertAffect = saNothing) then
    Exit;

  BeginUpdate;
  try
    AWidth := -1;
    AHeight := -1;
    if (AHorzAffect in [saShrink, saGrow]) or (AVertAffect in [saShrink, saGrow]) then
      for I := 0 to SelectionCount - 1 do
      begin
        if AHorzAffect in [saGrow, saShrink] then
        begin
          ACurrentWidth := SelectionWinControls[I].Width;
          case AHorzAffect of
            saShrink:
              if (ACurrentWidth < AWidth) or (AWidth = -1) then AWidth := ACurrentWidth;
            saGrow:
              if ACurrentWidth > AWidth then AWidth := ACurrentWidth;
          end;
        end;

        if AVertAffect in [saGrow, saShrink] then
        begin
          ACurrentHeight := SelectionWinControls[I].Height;
          case AVertAffect of
            saShrink:
              if (ACurrentHeight < AHeight) or (AHeight = -1) then AHeight := ACurrentHeight;
            saGrow:
              if ACurrentHeight > AHeight then AHeight := ACurrentHeight;
          end;
        end;
      end;

    if AHorzAffect = saAbsolute then AWidth := AHorzAbsolute;
    if AVertAffect = saAbsolute then AHeight := AVertAbsolute;

    for I := 0 to SelectionCount - 1 do
    begin
      if AHorzAffect <> saNothing then SelectionWinControls[I].Width := AWidth;
      if AVertAffect <> saNothing then SelectionWinControls[I].Height := AHeight;
    end;
  finally
    EndUpdate;
  end;
end;

function TcxWebFormDesigner.GetControlByWinControl(AControl: TWinControl): IcxWebControl;
var
  AWebDesignerControl: IcxWebDesignerControl;
begin
  if (AControl <> nil) and
    Supports(AControl, IcxWebDesignerControl, AWebDesignerControl) then
    Result := AWebDesignerControl.WebControl
  else Result := nil;  
end;

function TcxWebFormDesigner.GetWinControlByInterface(AInterface: IInterface): TWinControl;
var
  AWebControl: IcxWebControl;
  AWebContainerControl: IcxWebContainerControl;
  AWebDesignerControl: IcxWebDesignerControl;
begin
  Result := nil;
  if (AInterface = nil) then exit;

  Supports(AInterface, IcxWebDesignerControl, AWebDesignerControl);
  if (AWebDesignerControl = nil) and
    Supports(AInterface, IcxWebControl, AWebControl) and
    (AWebControl.DesignerControl <> nil) then
    AWebControl.DesignerControl.QueryInterface(IcxWebDesignerControl, AWebDesignerControl);
  if (AWebDesignerControl = nil) and
    Supports(AInterface, IcxWebContainerControl, AWebContainerControl) and
    Supports(AWebContainerControl, IcxWebControl, AWebControl) and
    (AWebControl.DesignerControl <> nil) then
    AWebControl.DesignerControl.QueryInterface(IcxWebDesignerControl, AWebDesignerControl);
  if AWebDesignerControl <> nil then
    Result := AWebDesignerControl.Implementor;
end;

function TcxWebFormDesigner.CreateSelectionComponent: TList;
var
  I: Integer;
begin
  Result := TList.Create;
  Result.Count := SelectionCount;
  for I := 0 to SelectionCount - 1 do
    Result[I] := GetComponentByInterface(SelectionControls[I]);
end;

function TcxWebFormDesigner.GetCreatedParentWinControl: TWinControl;
var
  AWebControl: IcxWebControl;
begin
  if FUndoState then
  begin
    Result := DesignerControl;
    if (FUndoItem.Parent <> nil) and
      Supports(FUndoItem.Parent, IcxWebControl, AWebControl) then
      Result := TWinControl(GetComponentByInterface(AWebControl.DesignerControl));
  end
  else
  begin  
    Result := HitCreatedDesignerParent;
    if Result = nil then
      Result := FindHitCreatedWinControlParent(ActiveControl);
  end;    
end;

function TcxWebFormDesigner.GetCreatedParentControl: IcxWebContainerControl;
var
  ACreatedParent: TComponent;
  AWebDesignerControl: IcxWebDesignerControl;
begin
  Result := nil;
  ACreatedParent := CreatedParentWinControl;
  if (ACreatedParent <> nil) and
    Supports(ACreatedParent, IcxWebDesignerControl, AWebDesignerControl) and
    (AWebDesignerControl.WebControl <> nil) then
    AWebDesignerControl.WebControl.QueryInterface(IcxWebContainerControl, Result);
  if Result = nil then
    Supports(Root, IcxWebContainerControl, Result);
end;

function TcxWebFormDesigner.GetFirstSelectionControl: IcxWebControl;
begin
  if SelectionCount > 0 then
    Result := SelectionControls[0]
  else Result := nil;  
end;

function TcxWebFormDesigner.GetFirstSelectionDesignerControl: IcxWebDesignerControl;
begin
  if SelectionCount > 0 then
    Result := SelectionDesignerControls[0]
  else Result := nil;
end;

function TcxWebFormDesigner.GetFirstSelectionWinControl: TWinControl;
begin
  if SelectionCount > 0 then
    Result := SelectionWinControls[0]
  else Result := nil;
end;

function TcxWebFormDesigner.GetHitMark: TcxSelectionMark;
var
  Pt: TPoint;
  I: TcxSelectionMarkHitTestCode;
  R: TRect;
begin
  Pt := Mouse.CursorPos;
  for I := Low(TcxSelectionMarkHitTestCode) to High(TcxSelectionMarkHitTestCode) do
  begin
    Result := FMarks[I];
    if Result.HandleAllocated and
    {$IFDEF VCL}IsWindowVisible(Result.Handle){$ELSE}QWidget_isVisible(Result.Handle){$ENDIF} then
    begin
      R := Result.BoundsRect;
      {$IFDEF VCL}
      if Result.ParentWindow <> 0 then
      begin
        MapWindowPoints(Result.ParentWindow, 0, R, 2);
        if PtInRect(R, Pt) then Exit;
      end;
      {$ELSE}
      if Result.ParentWidget <> nil then
      begin
        MapWindowPoints(Result.ParentWidget, nil, R, 2);
        if PtInRect(R, Pt) then Exit;
      end;
      {$ENDIF}
    end;
  end;
  Result := nil;
end;

function TcxWebFormDesigner.GetReadOnly: Boolean;
begin
  Result := DelphiDesigner.IsSourceReadOnly;
end;

function TcxWebFormDesigner.GetSelectionCount: Integer;
begin
  Result := FSelections.Count;
end;

function TcxWebFormDesigner.GetSelectionComponent(Index: Integer): TComponent;
begin
 Result := GetComponentByInterface(SelectionControls[Index]);
end;

function TcxWebFormDesigner.GetSelectionControl(Index: Integer): IcxWebControl;
begin
  Result := IcxWebControl(FSelections[Index]);
end;

function TcxWebFormDesigner.GetSelectionDesignerControl(Index: Integer): IcxWebDesignerControl;
begin
  SelectionControls[Index].DesignerControl.QueryInterface(IcxWebDesignerControl, Result);
end;

function TcxWebFormDesigner.GetSelectionWinControl(Index: Integer): TWinControl;
begin
  Result := SelectionDesignerControls[Index].Implementor;
end;

function TcxWebFormDesigner.GetActiveControl: IcxWebControl;
begin
  if SelectionCount = 1 then
    Result := SelectionControls[0]
  else Result := nil
end;

function TcxWebFormDesigner.GetActiveDesignerControl: IcxWebDesignerControl;
begin
  if SelectionCount = 1 then
    Result := SelectionDesignerControls[0]
  else Result := nil
end;

function TcxWebFormDesigner.GetActiveWinControl: TWinControl;
begin
  if SelectionCount = 1 then
    Result := SelectionWinControls[0]
  else Result := nil
end;

procedure TcxWebFormDesigner.SetActiveControl(Value: IcxWebControl);
begin
  if ActiveControl <> Value then
    Select(Value, False);
end;

procedure TcxWebFormDesigner.SetActiveDesignerControl(Value: IcxWebDesignerControl);
begin
  if Value <> nil then
    ActiveControl := Value.WebControl
  else ActiveControl := nil;  
end;

procedure TcxWebFormDesigner.SetActiveWinControl(Value: TWinControl);
begin
  ActiveControl := GetControlByWinControl(Value);
end;

procedure TcxWebFormDesigner.SetReadOnly(const Value: Boolean);
begin
  // nothing to do TODO paint another selection marks
end;

procedure TcxWebFormDesigner.DoUpdateControlPosition(var Value: Boolean);
begin
  Value := not FUpdateControlsPositionFlag and (UpdateCount = 0);
end;

{ IcxDesignerNotify }
procedure TcxWebFormDesigner.ComponentCreated(AnItem: TComponent);
var
  I: Integer;
begin
  InsertWebComponent(AnItem);
  for I := 0 to ClientCount - 1 do
    Clients[I].ItemInserted(AnItem);
end;

procedure TcxWebFormDesigner.ComponentDestroyed(AnItem: TComponent);
var
  I: Integer;
begin
  RemoveWebComponent(AnItem);
  for I := 0 to ClientCount - 1 do
    Clients[I].ItemDeleted(AnItem);
end;

procedure TcxWebFormDesigner.ComponentChangedName(AComponent: TComponent; const AOldName, ANewName: string);
var
  ADsgnHTMLSource: TcxWebDsgnHTMLSource;
begin
  if (AOldName <> '') and (ANewName <> AOldName) then
  begin
    ADsgnHTMLSource := TcxWebDsgnHTMLSource.Create('', DelphiDesigner);
    ADsgnHTMLSource.ChangeComponentName(AOldName, ANewName);
    ADsgnHTMLSource.Free;
  end;
  if Supports(AComponent, IcxWebControl) and
    not (csLoading in AComponent.ComponentState) and
    (AOldName = '') and (ANewName <> '') then
    InernalComponentCreated(AComponent);
end;

{ IcxDesigner }

type
TWinControlAccess = class(TWinControl);

{$IFDEF VCL}
function TcxWebFormDesigner.IsDesignMsg(var Message: TMessage): Boolean;
const
  Filters: array[Boolean] of TcxLocalMenuFilters = ([], [cxlmComponent]);
var
  Pt: TPoint;
  AHitControl: IcxWebControl;
  CanMove: Boolean;
  HM: TcxSelectionMark;
  MoveAffect: TcxMoveAffect;
begin
  FShift := [];
  Result := False;
  if (WM_MOUSEFIRST <= Message.Msg) and (Message.Msg <= WM_MOUSELAST) then
  begin
    FShift := KeysToShiftState(TWMMouse(Message).Keys);
    Pt := Mouse.CursorPos;
  end;

  case Message.Msg of
    CM_CANCELMODE,
    WM_CANCELMODE,
    WM_CAPTURECHANGED:
      begin
        HintDeactivate(False, True, True);
        if State <> dsNone then CancelState(True, True);
      end;

    WM_LBUTTONDOWN:
      try
        Result := True;
        HintDeactivate(False, True, True);
        BeginState(Pt);
      except
        CancelState(True, True);
        TWinControlAccess(DesignerControl).MouseCapture := False;
        raise;
      end;

    WM_ERASEBKGND:
      begin
        Message.Result := 1;
        Result := True;
      end;

    WM_LBUTTONUP:
      if TWinControlAccess(DesignerControl).MouseCapture then
      try
        HintDeactivate(False, True, True);
        CancelState(False, True);
        EndState;
      finally
        DropState;
        TWinControlAccess(DesignerControl).MouseCapture := False;
        Result := True;
      end;

    WM_RBUTTONDOWN:
      begin
        HintDeactivate(False, True, True);
        AHitControl := FindHitControl;
        if not InSelection(AHitControl) then
        begin
          if AHitControl = nil then
            SelectRoot
          else ActiveControl := AHitControl;
        end
        else NormalizeSelection(AHitControl.Parent);
        Result := True;
      end;

    WM_RBUTTONUP:
      begin
        HintDeactivate(False, True, True);
        InvokeLocalMenuAtCursor(nil, Filters[SelectionCount > 1]);
        Result := True;
      end;

    WM_LBUTTONDBLCLK:
      begin
        Edit(GetComponentByInterface(FindHitControl));
        Result := True;
      end;

    WM_MOUSEMOVE:
      begin
        CanMove := not (State in [dsCreateControls, dsDragControls]) or CanMoveTo(Pt);
        DoState(Pt);
        if CanMove then HintProcess(Pt);
        Result := State <> dsNone;
      end;

    WM_MOUSEACTIVATE:
      if DesignerControl.CanFocus then
        SetFocus(DesignerControl.Handle);

    WM_SETCURSOR:
      if (TWMSetCursor(Message).HitTest = HTCLIENT) and
      not ((ActiveDesigner <> nil) and ActiveDesigner.ControlsLocked) then
      begin
        HM := HitMark;
        if HM <> nil then
        begin
          SetCursor(Screen.Cursors[HM.Cursor]);
          Result := True;
        end;
      end;

    WM_GETDLGCODE:
      Message.Result := Message.Result or DLGC_WANTARROWS;

    WM_KEYDOWN:
      begin
        FShift := KeyDataToShiftState(TWMKey(Message).KeyData);
        case TWMKey(Message).CharCode of
          VK_ESCAPE:
            begin
              HintDeactivate(False, True, True);
              Result := True;
              if State <> dsNone then
              begin
                CancelState(True, True);
                TWinControlAccess(DesignerControl).MouseCapture := False;
              end
              else
                if SelectionCount <> 0 then
                  if FirstSelectionWinControl.Parent = DesignerControl then
                    SelectComponent(Root)
                  else
                    SelectParent(FirstSelectionControl, False);
            end;

          VK_DELETE:
            begin
              Result := True;
              if State <> dsNone then CancelState(True, True);
              DeleteSelection;
            end;

          VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN:
            if (State = dsNone) and (SelectionCount <> 0) then
            begin
              Result := True;
              MoveAffect := MoveAffectForKey(TWMKey(Message).CharCode);
              if ssCtrl in Shift then
                MoveSelection(MoveAffect)
              else
                if ssShift in Shift then
                  ResizeSelection(MoveAffect)
                else
                  SelectNearestControl(MoveAffect);
            end;
        end;
      end;

    CM_MOUSEENTER:
      FHintCanceled := False;

    CM_MOUSELEAVE:
      HintDeactivate(False, True, True);
  end;
end;
{$ELSE}
function TcxWebFormDesigner.IsDesignMsg(Sender: QObjectH; Event: QEventH): Boolean;
const
  Filters: array[Boolean] of TcxLocalMenuFilters = ([], [cxlmComponent]);
var
  Pt: TPoint;
  AHitControl: IcxWebControl;
  MoveAffect: TcxMoveAffect;
  Button: QT.ButtonState;
begin
  FShift := [];
  Result := False;
  if (QEvent_type(Event) in [QEventType_MouseButtonPress, QEventType_MouseButtonRelease,
        QEventType_MouseButtonDblClick, QEventType_MouseMove]) then
  begin
    FShift := ButtonStateToShiftState(QMouseEvent_state(QMouseEventH(Event)));
    Button := QMouseEvent_button(QMouseEventH(Event));
    GetCursorPos(Pt);
  end else Button := ButtonState_NoButton;

  case QEvent_type(Event) of

    QEventType_MouseButtonPress:
    begin
      if ButtonState_LeftButton = Button then
      begin
        try
          Result := True;
          BeginState(Pt);
        except
          CancelState(True, True);
          TWinControlAccess(DesignerControl).MouseCapture := False;
          raise;
        end;
      end;
      if ButtonState_RightButton = Button then
      begin
        AHitControl := FindHitControl;
        if not InSelection(AHitControl) then
        begin
          if AHitControl = nil then
            SelectRoot
          else ActiveControl := AHitControl;
        end
        else NormalizeSelection(AHitControl.Parent);
        Result := True;
      end;
    end;

    QEventType_MouseButtonRelease:
    begin
      if ButtonState_LeftButton = Button then
      begin
        if TWinControlAccess(DesignerControl).MouseCapture then
        try
          CancelState(False, True);
          EndState;
        finally
          DropState;
          TWinControlAccess(DesignerControl).MouseCapture := False;
          Result := True;
        end;
      end;
      if ButtonState_RightButton = Button then
      begin
        InvokeLocalMenuAtCursor(nil, Filters[SelectionCount > 1]);
        Result := True;
      end;
      DesignerControl.Cursor := crDefault;
      if ActiveWinControl <> nil then
        ActiveWinControl.Cursor := crDefault;
    end;

    QEventType_MouseButtonDblClick:
      if ButtonState_LeftButton = Button then
      begin
        Edit(GetComponentByInterface(FindHitControl));
        Result := True;
      end;

    QEventType_MouseMove:
      begin
        DoState(Pt);
        Result := State <> dsNone;
      end;

    QEventType_KeyPress:
      begin
        FShift := ButtonStateToShiftState(QKeyEvent_state(QKeyEventH(Event)));
        case QKeyEvent_key(QKeyEventH(Event)) of
          KEY_ESCAPE:
            begin
              Result := True;
              if State <> dsNone then
              begin
                CancelState(True, True);
                TWinControlAccess(DesignerControl).MouseCapture := False;
              end
              else
                if SelectionCount <> 0 then
                  if FirstSelectionWinControl.Parent = DesignerControl then
                    SelectComponent(Root)
                  else
                    SelectParent(FirstSelectionControl, False);
            end;

          KEY_DELETE:
            begin
              Result := True;
              if State <> dsNone then CancelState(True, True);
              DeleteSelection;
            end;

          KEY_LEFT, KEY_UP, KEY_RIGHT, KEY_DOWN:
            if (State = dsNone) and (SelectionCount <> 0) then
            begin
              Result := True;
              MoveAffect := MoveAffectForKey(QKeyEvent_key(QKeyEventH(Event)));
              if ssCtrl in Shift then
                MoveSelection(MoveAffect)
              else
                if ssShift in Shift then
                  ResizeSelection(MoveAffect)
                else
                  SelectNearestControl(MoveAffect);
            end;
        end;
      end;
  end;
end;
{$ENDIF}

function TcxWebFormDesigner.CanAlign: Boolean;
begin
  Result := True;
end;

function TcxWebFormDesigner.CanAlignToGrid: Boolean;
begin
  Result := True;
end;

function TcxWebFormDesigner.CanCopy: Boolean;
var
  AList: IDesignerSelections;
begin
  AList := TDesignerSelections.Create;
  DelphiDesigner.GetSelections(AList);
  Result := (AList.Count > 0) and (State = dsNone);
end;

function TcxWebFormDesigner.CanCut: Boolean;
begin
  Result := CanCopy and CanDelete;
end;

function TcxWebFormDesigner.CanPaste: Boolean;
begin
  Result := DelphiDesigner.CanPaste and (State = dsNone);
end;

function TcxWebFormDesigner.CanSelectAll: Boolean;
begin
  Result := True;
end;

function TcxWebFormDesigner.CanTabOrder: Boolean;
begin
  Result := True;
end;

function TcxWebFormDesigner.CanUndo: Boolean;
begin
  Result := (FUndoItem <> nil);
end;

type
  TComponentAccess = class(TComponent);

{ IcxWebDesigner }
procedure TcxWebFormDesigner.CreateDesignerControl(AParentControl: TWinControl);
begin
  FDesignerControl := TcxDesignSurfaceScrollBox.Create(nil);
  TcxDesignSurface(DesignerControl).FDesigner := self;
  FDesignerControl.Parent := AParentControl;
  FDesignerControl.Align := alClient;
  TComponentAccess(FDesignerControl).SetDesigning(False);
  TcxDesignSurfaceScrollBox(FDesignerControl).BorderStyle := bsNone;  
  CreateSelectionMarks;
end;

procedure TcxWebFormDesigner.DestroyDesignerControl;
begin
  NillDesingerControls;
  FreeSelectionMarks;
  FDesignerControl.Free;
  FDesignerControl := nil;
end;

function TcxWebFormDesigner.GetDesignerControl: TWinControl;
begin
  Result := TcxDesignSurfaceScrollBox(FDesignerControl).DesignSurface;
end;


procedure TcxWebFormDesigner.UpdateDesignerControl;
var
  AList: IInterfaceList;
  I: Integer;
  AWebDesignerControl: IcxWebDesignerControl;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
  begin
    AWebDesignerControl := InsertWebDesignControl(IcxWebControl(AList[I]));
    if AWebDesignerControl <> nil then
      with AWebDesignerControl do
      begin
       ParentChanged;
       BoundsChanged;
       UpdateContext;
      end;
  end;
end;

procedure TcxWebFormDesigner.RefreshDesignControls;
var
  AList: IInterfaceList;
  I: Integer;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
    if IcxWebControl(AList[I]).DesignerControl = nil then
      ComponentCreated(GetComponentByInterface(AList[I]));
  inherited RefreshDesignControls;
end;


procedure TcxWebFormDesigner.DesignerPositioningTypeChanged;
begin
  UpdateControlsPosition;
end;

function TcxWebFormDesigner.IsSupportPositioningTypeChanged(APositioningType: TcxWebPositioningType): Boolean;
begin
  Result := APositioningType <> cxptFlow;
end;


class function TcxWebFormDesigner.GetID: Integer;
begin
  Result := 1;
end;

class function TcxWebFormDesigner.GetName: String;
begin
  Result := 'Form';
end;

procedure TcxWebFormDesigner.AlignToGrid;
begin
  if CanAlignToGrid then DoAlignToGrid;
end;

function TcxWebFormDesigner.CanSelect(const AControl: TComponent): Boolean;
begin
  Result := True;
end;

procedure TcxWebFormDesigner.CopySelection;
begin
  if CanCopy then DoCopy;
end;

procedure TcxWebFormDesigner.CutSelection;
begin
  if CanCut then DoCut;
end;

procedure TcxWebFormDesigner.DeleteSelection;
begin
  if CanDelete then DoDelete;
end;

procedure TcxWebFormDesigner.Edit(AComponent: TComponent);
var
  AWebDesignerControl: IcxWebDesignerControl;
begin
  if Supports(AComponent, IcxWebDesignerControl, AWebDesignerControl) then
    AComponent := GetComponentByInterface(AWebDesignerControl.WebControl);
  if AComponent = nil then
    AComponent := Root;
  DelphiDesigner.Edit(AComponent);
end;

procedure TcxWebFormDesigner.GetSelections(const AList: TList);
var
  I: Integer;
begin
  AList.Clear;
  for I := 0 to SelectionCount - 1 do
    AList.Add(GetComponentByInterface(SelectionControls[I]));
end;

procedure TcxWebFormDesigner.PasteSelection;
begin
  if CanPaste then DoPaste;
end;

procedure TcxWebFormDesigner.Modified;
begin
  inherited Modified;
  if UpdateCount = 0 then
    ShowSelectionMarks(ActiveControl <> nil);  
end;

procedure TcxWebFormDesigner.SelectAll;
begin
  if CanSelectAll then DoSelectAll;
end;

procedure TcxWebFormDesigner.Undo;
begin
  if CanUndo then DoUndo;
end;

procedure TcxWebFormDesigner.DoAlignToGrid;

  procedure AlignControlToGrid(AControl: IcxWebControl);
  var
    R: TRect;
  begin
    R := AControl.BoundsRect;
    R.Left := GridSizeX * (R.Left div GridSizeX);
    R.Top := GridSizeY * (R.Top div GridSizeY);
    R.Right := R.Left + (GridSizeX * (R.Right - R.Left)) div GridSizeX;
    R.Bottom := R.Top + (GridSizeY * (R.Bottom - R.Top)) div GridSizeY;
    AControl.BoundsRect := R;
  end;

var
  I: Integer;
begin
  if SelectionCount > 0 then
  begin
    BeginUpdate;
    try
      for I := 0 to SelectionCount - 1 do
        AlignControlToGrid(SelectionControls[I]);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TcxWebFormDesigner.DoCopy;
begin
  DelphiDesigner.CopySelection;
end;

procedure TcxWebFormDesigner.DoCut;
begin
  DoCopy;
  DoDelete;
end;

procedure TcxWebFormDesigner.DoDelete;

  function CanDeleteItem(AControl: IcxWebControl): Boolean;
  var
    AComponent: TComponent;
    AContainerControl: IcxWebContainerControl;
    i: Integer;
  begin
    AComponent := GetComponentByInterface(AControl);
    Result := (AComponent <> Root);
    if Result then
    begin
      for I := 0 to SelectionCount - 1 do
        if Supports(SelectionControls[I], IcxWebContainerControl, AContainerControl) then
        begin
          Result := not ControlHasContainerAsParent(AControl, AContainerControl);
          if not Result then
            break;
        end;
    end;
  end;

var
  AList: TList;
  I: Integer;
begin
  BeginUpdate;
  try
    AList := TList.Create;
    try
      { Remove all child components from the list }
      for I := 0 to SelectionCount - 1 do
        if CanDeleteItem(SelectionControls[I]) then
          AList.Add(GetComponentByInterface(SelectionControls[I]));
      CreateUndoItem(Root, AList);

      FSelections.Clear;

      { delete }
      for I := 0 to AList.Count - 1 do
      try
        TComponent(AList[I]).Free;
      except
      end;
    finally
      AList.Free;
    end;
  finally
    EndUpdate;
  end;
  DelphiDesigner.DeleteSelection;
end;

procedure TcxWebFormDesigner.DoPaste;
begin
  BeginUpdate;
  try
    FClipboardSelection := TList.Create;
    try
      PasteComponents(Root, GetComponentByInterface(GetCreatedParentControl));
      SetSelections(FClipboardSelection);
    finally
      FClipboardSelection.Free;
    end;
  finally
    EndUpdate;
  end;
  if PositioningType = cxptGrid then
    UpdateControlsPosition;
end;

procedure TcxWebFormDesigner.DoUndo;
begin
  BeginUpdate;
  try
    FClipboardSelection := TList.Create;
    try
      FUndoState := True;
      try
        UndoComponents;
      finally
        FUndoState := False;
      end;  
      SetSelections(FClipboardSelection);
    finally
      FClipboardSelection.Free;
    end;
  finally
    EndUpdate;
  end;
end;

{$IFDEF VCL}
function TcxWebFormDesigner.GetHintWindowClass: TcxWebDesignerHintWindowClass;
begin
  Result := TcxWebDesignerHintWindow;
end;
{$ENDIF}

function TcxWebFormDesigner.GetScreenCanvasClass: TcxScreenCanvasClass;
begin
  Result := TcxScreenCanvas;
end;

procedure TcxWebFormDesigner.IDEDesignerOptionsChagned;
begin
  if (DesignerControl <> nil) and  DesignerControl.HandleAllocated then
  begin
    TcxDesignSurfaceScrollBox(FDesignerControl).FDesignSurface.RefreshPattern;
    DesignerControl.Invalidate;
  end;
end;


{ undo supports }
procedure TcxWebFormDesigner.ComponentRead(AComponent: TComponent);
begin
  FClipboardSelection.Add(AComponent);
end;

procedure TcxWebFormDesigner.CreateUndoItem(AParent: TComponent; AComponents: TList);
var
  Stream: TMemoryStream;
  Writer: TWriter;
  I: Integer;
begin
  if FUndoItem <> nil then 
  begin 
    FUndoItem.Free;
    FUndoItem := nil;
  end;  
  Stream := TMemoryStream.Create;
  try
    Writer := TWriter.Create(Stream, 1024);
    try
      Writer.Root := Root;
      for I := 0 to AComponents.Count - 1 do
      begin
        Writer.WriteSignature;
        Writer.WriteComponent(TComponent(AComponents[I]));
      end;
      Writer.WriteListEnd;
    finally
      Writer.Free;
    end;
    Stream.Position := 0;    
    FUndoItem := TcxWebDesignerUndoItem.Create(AParent, Stream);
  except
    FUndoItem.Free;
    FUndoItem := nil;
    raise;
  end;  
end;

procedure TcxWebFormDesigner.PasteComponents(AOwner, AParent: TComponent);
var
  Stream: TStream;
  Reader: TReader;
begin
  Stream := GetClipboardStream;
  try
    Reader := TReader.Create(Stream, 1024);
    try
      Reader.OnSetName := ReaderSetName;
      Reader.OnFindMethod := ReaderFindMethod;
      Reader.Parent := AParent;
      Reader.ReadComponents(AOwner, AParent, ComponentRead);
    finally
      Reader.Free;
    end;
  finally
    Stream.Free;
  end;
end;

procedure TcxWebFormDesigner.UndoComponents;
var
  Reader: TReader;
begin
  try
    Reader := TReader.Create(FUndoItem.Stream, 1024);
    try
      Reader.OnSetName := ReaderSetName;
      Reader.Parent := FUndoItem.Parent;
      Reader.ReadComponents(Root, FUndoItem.Parent, ComponentRead);
    finally
      Reader.Free;
    end;
  finally
    FUndoItem.Free;
    FUndoItem := nil;
  end;
end;

{ web components }

procedure TcxWebFormDesigner.InsertWebComponent(AComponent: TComponent);
var
  AWebControl: IcxWebControl;
begin
  if Supports(AComponent, IcxWebControl, AWebControl) and
    (AWebControl.DesignerControl = nil) then
    InsertWebDesignControl(AWebControl);
end;

procedure TcxWebFormDesigner.InernalComponentCreated(AnItem: TComponent);
var
  ByDblClickCreated: Boolean;
  AWebControl: IcxWebControl;
  AParentWidth, AParentHeight: Integer;
begin
  if Supports(AnItem, IcxWebControl, AWebControl) then
  try
    with FCreateRect do
      ByDblClickCreated := (Left = -1) and (Top = -1) and (Right = -1) and (Bottom = -1);

    if ByDblClickCreated then
    begin
      with CreatedParentWinControl do
      begin
        AParentWidth := Width;
        AParentHeight := Height;
      end;
      with AWebControl.BoundsRect do
        FCreateRect := Bounds((AParentWidth - Right + Left) div 2,
                (AParentHeight - Bottom + Top) div 2, Right - Left, Bottom - Top);
        
      if (ActiveControl <> nil) and (ActiveWinControl.Parent = CreatedParentWinControl) and
        EqualRect(ActiveControl.BoundsRect, FCreateRect) then
        OffsetRect(FCreateRect, GridSizeX, GridSizeY);
    end
    else           
      with FCreateRect do
      begin
        if Right = Left then
          Inc(Right, AWebControl.BoundsRect.Right - AWebControl.BoundsRect.Left);
        if Bottom = Top then
          Inc(Bottom, AWebControl.BoundsRect.Bottom - AWebControl.BoundsRect.Top);
      end;

    AWebControl.BoundsRect := FCreateRect;
    AWebControl.Parent := CreatedParentControl;
    DelphiDesigner.SelectComponent(AnItem);
  finally
    FCreateRect := Rect(-1, -1, -1, -1);
  end;
end;


procedure TcxWebFormDesigner.RemoveWebComponent(AComponent: TComponent);
var
  AWebControl: IcxWebControl;
begin
  if Supports(AComponent, IcxWebControl, AWebControl) then
    RemoveWebDesignControl(AWebControl);
end;

{ design controls }

function TcxWebFormDesigner.InsertWebDesignControl(AWebControl: IcxWebControl): IcxWebDesignerControl;
var
  AUpdatePosition: IcxWebDesignerControlUpdatePosition;
begin
  Result := WebDesignControlsFactory.CreateDesignControl(AWebControl, DesignerControl);
  if Supports(Result, IcxWebDesignerControlUpdatePosition, AUpdatePosition) then
    AUpdatePosition.SetOnUpdateConstrolPosition(DoUpdateControlPosition);
  AWebControl.DesignerControl := Result as IcxWebDesignerControlNotify;
end;

procedure TcxWebFormDesigner.RemoveWebDesignControl(AWebControl: IcxWebControl);
begin
{$IFNDEF VCL}
  if (ActiveControl = nil) and (AWebControl.DesignerControl = nil) and
     (FMarks[smhtTopLeft] <> nil) and FMarks[smhtTopLeft].Visible then
     ShowSelectionMarks(False);
{$ENDIF}
  if (AWebControl.DesignerControl <> nil) then
  begin
    if AWebControl = ActiveControl then
      ShowSelectionMarks(False);
    ActiveControl := nil;
  end;
end;

procedure TcxWebFormDesigner.NillDesingerControls;
var
  AList: IInterfaceList;
  I: Integer;
begin
  AList := CreateControlList;
  for I := 0 to AList.Count - 1 do
    IcxWebControl(AList[I]).DesignerControl := nil;
end;

{ components creation }

procedure TcxWebFormDesigner.BeginCreation(const Pt: TPoint);
begin
  FDragAffect := daSize;
  FResizingAffect := raBottomRight;
  SelectRoot;
  PrepareCreateControl(Pt);
  {$IFDEF VCL}
  HintProcess(Pt);
  {$ENDIF}
  DrawDragFrame(GetDragRect(0, True));
end;

procedure TcxWebFormDesigner.CancelCreation(ARefreshFrame: Boolean);
begin
  if ARefreshFrame then
    DrawDragFrame(GetDragRect(0, False));
end;

procedure TcxWebFormDesigner.DoCreation(const Pt: TPoint);
begin
  DrawDragFrame(GetDragRect(0, False));
  PrepareFrameRect(FDraggingRects^[0], Pt);
  DrawDragFrame(GetDragRect(0, True));
  FDraggingPoint := Pt;
end;

procedure TcxWebFormDesigner.EndCreation;
var
  R: TRect;
begin
  R := GetDragRect(0, False);
  NormalizeRectCoords(R);
  MapWindowPoints({$IFDEF VCL}0{$ELSE}nil{$ENDIF}, HitCreatedDesignerParent.Handle, R, 2);
  CreateComponent(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  ShowSelectionMarks(True);
end;

procedure TcxWebFormDesigner.PrepareCreateControl(const Pt: TPoint);
begin
  ReallocMem(FDraggingRects, 1 * SizeOf(TRect));
  FDraggingRects^[0].TopLeft := Pt;
  FDraggingRects^[0].BottomRight := Pt;
  ReallocMem(FSaveDraggingRects, 1 * SizeOf(TRect));
  FSaveDraggingRects^[0] := FDraggingRects^[0];
end;

{ components dragging }

procedure TcxWebFormDesigner.BeginDragControls(const Pt: TPoint);
begin
  PrepareDragControls;
  FDraggingPoint := Pt;
  if SelectionCount = 1 then
    ShowSelectionMarks(False);
  DesignerControl.Update;
  {$IFDEF VCL}
  HintProcess(Pt);
  {$ENDIF}
  DrawDragFrames(True);
end;

procedure TcxWebFormDesigner.CancelDragControls(ARefreshFrame: Boolean);
begin
  if ARefreshFrame then
    DrawDragFrames(True);
  if SelectionCount = 1 then
    ShowSelectionMarks(True);
end;

procedure TcxWebFormDesigner.DoDragControls(const Pt: TPoint);
begin
  DrawDragFrames(True);
  PrepareFrameRects(Pt);
  DrawDragFrames(False);
  FDraggingPoint := Pt;
end;

procedure TcxWebFormDesigner.EndDragControls;
begin
  UpdateSelectionBoundsRect;
  {$IFDEF VCL}
  RedrawWindow(DesignerControl.Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
  {$ELSE}
   DesignerControl.Invalidate;
  {$ENDIF}
  DesignerControl.Update;
  if SelectionCount = 1 then
    ShowSelectionMarks(True);
end;

procedure TcxWebFormDesigner.PrepareDragControls;
var
  I: Integer;
  HM: TcxSelectionMark;
begin
  ReallocMem(FDraggingRects, SelectionCount * SizeOf(TRect));
  ReallocMem(FSaveDraggingRects, SelectionCount * SizeOf(TRect));

  for I := 0 to SelectionCount - 1 do
    FDraggingRects^[I] := SelectionControls[I].BoundsRect;

  MapWindowPoints(HitDesignerParent.Handle, {$IFDEF VCL}0{$ELSE}nil{$ENDIF}, FDraggingRects^[0], 2 * SelectionCount);
  Move(FDraggingRects^, FSaveDraggingRects^, SelectionCount * SizeOf(TRect));

  FDragAffect := daMove;
  if SelectionCount = 1 then
  begin
    HM := HitMark;
    if HM <> nil then
    begin
      FDragAffect := daSize;
      FResizingAffect := TcxResizeAffect(HM.HitTestCode);
    end
  end;
end;

{ components selection }

procedure TcxWebFormDesigner.BeginSelection(const Pt: TPoint);
begin
  FDragAffect := daSize;
  FResizingAffect := raBottomRight;
  if not (ssShift in Shift) then SelectRoot;
  FSelectionRect.TopLeft := Pt;
  FSelectionRect.BottomRight := Pt;
  DrawSelectionFrame(FSelectionRect);
end;

procedure TcxWebFormDesigner.CancelSelection(ARefreshFrame: Boolean);
begin
  if ARefreshFrame then
    DrawSelectionFrame(FSelectionRect);
end;

procedure TcxWebFormDesigner.DoSelection(const Pt: TPoint);
begin
  DrawSelectionFrame(FSelectionRect);
  PrepareFrameRect(FSelectionRect, Pt);
  DrawSelectionFrame(FSelectionRect);
  FDraggingPoint := Pt;
end;

procedure TcxWebFormDesigner.EndSelection;
begin
//  CancelSelection(False);
  SelectControlsInRect(FSelectionRect);
end;

function TcxWebFormDesigner.InSelection(const AControl: IcxWebControl): Boolean;
begin
  Result := (AControl <> nil) and (FSelections.IndexOf(AControl) <> -1);
end;

function TcxWebFormDesigner.MoveAffectForKey(Key: Word): TcxMoveAffect;
begin
  if Key = {$IFDEF VCL}VK_LEFT{$ELSE}KEY_LEFT{$ENDIF} then
    Result := maLeft
  else
    if Key = {$IFDEF VCL}VK_UP{$ELSE}KEY_UP{$ENDIF} then
      Result := maTop
    else
      if Key = {$IFDEF VCL}VK_RIGHT{$ELSE}KEY_RIGHT{$ENDIF} then
        Result := maRight
      else
        Result := maBottom;
end;

procedure TcxWebFormDesigner.MoveSelection(AMoveAffect: TcxMoveAffect);
var
  I: Integer;
  ABoundsRect: TRect;
begin
  if FirstSelectionControl = nil then
    Exit;
  NormalizeSelection(FirstSelectionControl.Parent);
  for I := 0 to SelectionCount - 1 do
    with SelectionControls[I] do
    begin
      ABoundsRect := BoundsRect;
      case AMoveAffect of
        maLeft:
          OffSetRect(ABoundsRect, -1, 0);
        maTop:
          OffSetRect(ABoundsRect, 0, -1);
        maRight:
          OffSetRect(ABoundsRect, 1, 0);
        maBottom:
          OffSetRect(ABoundsRect, 0, 1);
      end;
      BoundsRect := ABoundsRect;
    end;
  Modified;  
end;

procedure TcxWebFormDesigner.NormalizeSelection(ARelativeParent: IcxWebContainerControl);
var
  AList: IInterfaceList;
  I: Integer;
begin
  if ARelativeParent = nil then
    exit;
  AList := TInterfaceList.Create;
  for I := 0 to SelectionCount - 1 do
    if (SelectionControls[I].Parent <> ARelativeParent) then
      AList.Add(SelectionControls[I]);
  UnselectList(AList);
end;

procedure TcxWebFormDesigner.ResizeSelection(AMoveAffect: TcxMoveAffect);
var
  I: Integer;
begin
  if FirstSelectionControl = nil then
    Exit;
  NormalizeSelection(FirstSelectionControl.Parent);
  for I := 0 to SelectionCount - 1 do
    with SelectionWinControls[I] do
      case AMoveAffect of
        maLeft:
          if Width > 0 then Width := Width - 1;
        maTop:
          if Height > 0 then Height := Height - 1;
        maRight:
          Width := Width + 1;
        maBottom:
          Height := Height + 1;
      end;
  Modified;
end;

procedure TcxWebFormDesigner.Select(AControl: IcxWebControl; AddToSelection: Boolean = True);
var
  AList: TList;
begin
  if AControl = nil then
    SelectRoot
  else
    if (not InSelection(AControl) or not AddToSelection) and
      CanSelect(GetComponentByInterface(AControl)) then
    begin
      if not AddToSelection then
      begin
        AList := TList.Create;
        SelectionChanged(AList);
        AList.Free;
      end;
      AList := CreateSelectionComponent;
      AList.Add(GetComponentByInterface(AControl));
      try
        SetSelections(AList);
      finally
        AList.Free;
      end;
    end;
end;

procedure TcxWebFormDesigner.SelectParent(AControl: IcxWebControl; AddToSelection: Boolean = True);
var
  AWebControl: IcxWebControl;
begin
  if (AControl <> nil) and (AControl.Parent <> nil) and
    Supports(AControl.Parent, IcxWebControl, AWebControl) then
    Select(AWebControl, AddToSelection)
  else Select(nil, AddToSelection);
end;

procedure TcxWebFormDesigner.SelectControlsInRect(ARect: TRect);
var
  AList: TList;

  procedure AddToList(AControl: IcxWebControl);
  var
    R: TRect;
    AWinControl: TWinControl;
  begin
    R := AControl.BoundsRect;
    AWinControl := GetWinControlByInterface(AControl);
    MapWindowPoints(AWinControl.Parent.Handle, {$IFDEF VCL}0{$ELSE}nil{$ENDIF}, R, 2);
    if (AWinControl.Parent = HitCreatedDesignerParent) and
      IntersectRect(R, R, ARect) and CanSelect(GetComponentByInterface(AControl)) then
      AList.Add(GetComponentByInterface(AControl));
  end;

var
  AControlList: IInterfaceList;
  I: Integer;
begin
  NormalizeRectCoords(ARect);
  if IsRectEmpty(ARect) then
  begin
    if ARect.Left = ARect.Right then
      ARect.Right := ARect.Left + 1;
    if ARect.Top = ARect.Bottom then
      ARect.Bottom := ARect.Top + 1;
  end;

  AList := TList.Create;
  AControlList := CreateControlList;

  try
    for I := 0 to AControlList.Count - 1 do
      AddToList(IcxWebControl(AControlList[I]));

    if AList.Count = 0 then
      AList.Add(Root);

    SetSelections(AList);
  finally
    AList.Free;
  end;
end;

type
  TFormAccess = class(TForm);

procedure TcxWebFormDesigner.SelectionChanged(const AList: TList);

  procedure RemoveDeletedItems;
  var
    i: Integer;
    AList: IInterfaceList;
  begin
    AList := CreateControlList;
    i := 0;
    while i < SelectionCount do
    begin
      if AList.IndexOf(SelectionControls[i]) > - 1 then
        Inc(i)
      else FSelections.Delete(i);
    end;
  end;

  function InternalIsListsEqual(const AList: TList): Boolean;
  var
    ASelections: TList;
  begin
    ASelections := CreateSelectionComponent;
    Result := IsListsEqual(ASelections, AList);
    ASelections.Free;
  end;


var
  I: Integer;
  AWebControl: IcxWebControl;
  AItem: TPersistent;
begin
  RemoveDeletedItems;
  if InternalIsListsEqual(AList) or (UpdateCount <> 0) then
    Exit;

  if SelectionCount = 1 then
    ShowSelectionMarks(False)
  else
    for I := 0 to SelectionCount - 1 do
      if not (csDestroying in SelectionDesignerControls[I].Implementor.ComponentState) then
        SelectionDesignerControls[I].Selected := False;

  FSelections.Clear;
  for I := 0 to AList.Count - 1 do
  begin
    AItem := TPersistent(AList[I]);
    if (AItem <> Root) and (FindRootDesigner(AItem) = FindRootDesigner(Root)) and
      Supports(AItem, IcxWebControl, AWebControl) then
      FSelections.Add(AWebControl);
  end;

  if SelectionCount = 1 then
    ShowSelectionMarks(True)
  else
    for I := 0 to SelectionCount - 1 do
      if not (csDestroying in SelectionDesignerControls[I].Implementor.ComponentState) then
        SelectionDesignerControls[I].Selected := True;

  for I := 0 to ClientCount - 1 do
    Clients[I].SelectionChanged(AList);
end;

var
  G_ActiveControl: TWinControl;

procedure Center(AControl: TControl; var X, Y: Integer);
begin
  X := AControl.Left + AControl.Width div 2;
  Y := AControl.Top + AControl.Height div 2;
end;

function Distance(AControl1, AControl2: TControl): Integer;
var
  X1, Y1: Integer;
  X2, Y2: Integer;
begin
  Center(AControl1, X1, Y1);
  Center(AControl2, X2, Y2);
  Result := Round(Sqrt(Sqr(X2 - X1) + Sqr(Y2 - Y1)));
end;

function FindNearestControl(AItem1, AItem2: Pointer): Integer;
begin
  Result := Distance(TControl(AItem1), G_ActiveControl) - Distance(TControl(AItem2), G_ActiveControl);
end;

procedure TcxWebFormDesigner.SelectNearestControl(AMoveAffect: TcxMoveAffect);

  procedure BuildCandidateList(const AList: TList; AParent: TWinControl;
    const ActiveRect: TRect; AMoveAffect: TcxMoveAffect);
  var
    I: Integer;
    AControl: TControl;
    R: TRect;
    Passed: Boolean;
  begin
    for I := 0 to AParent.ControlCount - 1 do
    begin
      AControl := AParent.Controls[I];
      R := AControl.BoundsRect;
      case AMoveAffect of
        maLeft:
          Passed := (R.Left < ActiveRect.Left) and (R.Top < ActiveRect.Bottom) and (R.Bottom > ActiveRect.Top);
        maTop:
          Passed := (R.Top < ActiveRect.Top) and (R.Left < ActiveRect.Right) and (R.Right > ActiveRect.Left);
        maRight:
          Passed := (R.Right > ActiveRect.Right) and (R.Top < ActiveRect.Bottom) and (R.Bottom > ActiveRect.Top);
      else { maBottom }
        Passed := (R.Bottom > ActiveRect.Bottom) and (R.Left < ActiveRect.Right) and (R.Right > ActiveRect.Left);
      end;
      if Passed then AList.Add(AControl);
    end;

    if AList.Count = 0 then
      for I := 0 to AParent.ControlCount - 1 do
      begin
        AControl := AParent.Controls[I];
        R := AControl.BoundsRect;
        case AMoveAffect of
          maLeft:
            Passed := R.Right < ActiveRect.Left;
          maTop:
            Passed := R.Bottom < ActiveRect.Top;
          maRight:
            Passed := R.Left > ActiveRect.Right;
        else { maBottom }
          Passed := R.Top > ActiveRect.Bottom;
        end;
        if Passed then AList.Add(AControl);
      end;
  end;

var
  AList: TList;
begin
  if ActiveWinControl <> nil then
  begin
    AList := TList.Create;
    try
      BuildCandidateList(AList, FindHitWinControlParent(ActiveControl), ActiveControl.BoundsRect, AMoveAffect);
      if AList.Count > 0 then
      begin
        G_ActiveControl := ActiveWinControl;
        try
          AList.Sort(FindNearestControl);
        finally
          G_ActiveControl := nil;
        end;
        SelectComponent(GetComponentByInterface(GetControlByWinControl(TWinControl(AList[0]))));
      end
    finally
      AList.Free;
    end;
  end;
end;

procedure TcxWebFormDesigner.Unselect(AControl: IcxWebControl);
var
  AList: TList;
begin
  if InSelection(AControl) then
  begin
    AList := CreateSelectionComponent;
    try
      AList.Remove(GetComponentByInterface(AControl));
      SetSelections(AList);
    finally
      AList.Free;
    end;
  end;
end;

procedure TcxWebFormDesigner.UnselectList(const AList: IInterfaceList);
var
  ASelectedList: TList;
  I: Integer;
begin
  if AList.Count = 0 then exit;
  
  ASelectedList := CreateSelectionComponent;
  for I := 0 to AList.Count - 1 do
    ASelectedList.Remove(GetComponentByInterface(AList[i]));
  SetSelections(ASelectedList);
end;

{ frames painting }
function GetPaintRect(const R: TRect): TRect;
begin
  Result := R;
  if Result.Left > Result.Right then
  begin
    Result.Left := R.Right;
    Result.Right := R.Left;
  end;
  if Result.Top > Result.Bottom then
  begin
    Result.Top := R.Bottom;
    Result.Bottom := R.Top;
  end;
end;

procedure TcxWebFormDesigner.DrawDragFrame(const R: TRect);

  procedure DrawFrame(const R: TRect);
  var
    PaintR: TRect;
  begin
    PaintR := GetPaintRect(R);
    FScreenCanvas.CopyRect(PaintR, FScreenCanvas, PaintR);
  end;

const
  BorderWidth = 2;
  {$IFDEF VCL}
  Flags: array[Boolean] of UINT =
    ((SWP_NOREPOSITION or SWP_NOSIZE or SWP_NOMOVE or SWP_HIDEWINDOW or SWP_NOACTIVATE),
     (SWP_NOREPOSITION or SWP_NOSIZE or SWP_NOMOVE or SWP_SHOWWINDOW or SWP_NOACTIVATE));
  {$ENDIF}
var
  PaintR: TRect;
{$IFDEF VCL}
  Msg: TMsg;
  PrevVisible: Boolean;
{$ENDIF}
begin
  {$IFDEF VCL}
  PrevVisible := IsWindowVisible(FHintWindow.Handle);
  if PrevVisible then
    SetWindowPos(FHintWindow.Handle, 0, 0, 0, 0, 0, Flags[False]);
  {$ENDIF}
  try
    FScreenCanvas.CopyMode := cmDstInvert;
    PaintR := GetPaintRect(R);
    { Left }
    DrawFrame(Rect(PaintR.Left, PaintR.Top, PaintR.Left + BorderWidth, PaintR.Bottom));
    { Top }
    DrawFrame(Rect(PaintR.Left + BorderWidth, PaintR.Top, PaintR.Right - BorderWidth, PaintR.Top + BorderWidth));
    { Right }
    DrawFrame(Rect(PaintR.Right - BorderWidth, PaintR.Top, PaintR.Right, PaintR.Bottom));
    { Bottom }
    DrawFrame(Rect(PaintR.Left + BorderWidth, PaintR.Bottom - BorderWidth, PaintR.Right - BorderWidth, PaintR.Bottom));

    FScreenCanvas.CopyMode := cmSrcCopy;
  finally
    {$IFDEF VCL}
    if PrevVisible then
    begin
      SetWindowPos(FHintWindow.Handle, 0, 0, 0, 0, 0, Flags[True]);
      PeekMessage(Msg, DesignerControl.Handle, WM_MOUSEMOVE, WM_MOUSEMOVE, PM_REMOVE);
    end;
    {$ENDIF}
  end;
end;

procedure TcxWebFormDesigner.DrawDragFrames(ACleanPrevious: Boolean);
var
  I: Integer;
begin
  for I := 0 to SelectionCount - 1 do
    DrawDragFrame(GetDragRect(I, not ACleanPrevious));
end;

procedure TcxWebFormDesigner.DrawSelectionFrame(const R: TRect);
var
  PaintR: TRect;
begin
  with FScreenCanvas do
  begin
    Pen.Color := clWindowText;
    Pen.Mode := pmNot;
    Pen.Style := psDot;
    Brush.Style := bsClear;
    PaintR := GetPaintRect(R);
    PolyLine([PaintR.TopLeft, Point(PaintR.Right, PaintR.Top),
        PaintR.BottomRight, Point(PaintR.Left, PaintR.Bottom), PaintR.TopLeft]);
    Pen.Mode := pmCopy;
  end;
end;

{ selection marks }

{
  0 ---- 1 ---- 2
  |             |
  |             |
  7             3
  |             |
  |             |
  6 ---- 5 ---- 4
}

procedure TcxWebFormDesigner.CreateSelectionMarks;
var
  I: TcxSelectionMarkHitTestCode;
begin
  for I := Low(TcxSelectionMarkHitTestCode) to High(TcxSelectionMarkHitTestCode) do
  begin
    FMarks[I] := TcxSelectionMark.Create(nil);
    {$IFNDEF VCL}
    FMarks[I].FDesigner := self;
    {$ENDIF}
    FMarks[I].HitTestCode := I;
  end;
end;

procedure TcxWebFormDesigner.FreeSelectionMarks;
var
  I: TcxSelectionMarkHitTestCode;
begin
  ShowSelectionMarks(False);
  for I := Low(TcxSelectionMarkHitTestCode) to High(TcxSelectionMarkHitTestCode) do
  begin
    FMarks[I].Free;
    FMarks[I] := nil;
  end;
end;

procedure TcxWebFormDesigner.ShowSelectionMarks(Value: Boolean);

  function GetMarkPlace(AMark: TcxSelectionMark): TPoint;
  var
    R: TRect;
  begin
    R := ActiveControl.BoundsRect;
    InflateRect(R, cxMarkSize div 2, cxMarkSize div 2);
    case AMark.HitTestCode of
      smhtTopLeft:
        Result := R.TopLeft;
      smhtTopCenter:
        Result := Point(R.Left + (R.Right - R.Left - cxMarkSize) div 2, R.Top);
      smhtTopRight:
        Result := Point(R.Right - cxMarkSize, R.Top);
      smhtRight:
        Result := Point(R.Right - cxMarkSize, R.Top + (R.Bottom - R.Top - cxMarkSize) div 2);
      smhtBottomRight:
        Result := Point(R.Right - cxMarkSize, R.Bottom - cxMarkSize);
      smhtBottomCenter:
        Result := Point(R.Left + (R.Right - R.Left - cxMarkSize) div 2, R.Bottom - cxMarkSize);
      smhtBottomLeft:
        Result := Point(R.Left, R.Bottom - cxMarkSize);
      smhtLeft:
        Result := Point(R.Left, R.Top + (R.Bottom - R.Top - cxMarkSize) div 2);
    end;
  end;

var
  I: TcxSelectionMarkHitTestCode;
  Pt: TPoint;
  Mark: TcxSelectionMark;
begin
  if (ActiveControl = nil) and Value then
    Exit;
  for I := Low(TcxSelectionMarkHitTestCode) to High(TcxSelectionMarkHitTestCode) do
  begin
    Mark := FMarks[I];
    if Mark = nil then Continue;
    if Value then
    begin
      Pt := GetMarkPlace(Mark);
      Mark.Left := Pt.X;
      Mark.Top := Pt.Y;
      if ActiveWinControl.Parent <> nil then
      begin
        {$IFDEF VCL}
        Mark.ParentWindow := ActiveWinControl.Parent.Handle;
        SetWindowPos(Mark.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE);
        {$ELSE}
        Mark.Parent := ActiveWinControl.Parent;
        Mark.Visible := True;
        QWidget_show(Mark.Handle);
        QWidget_raise(Mark.Handle);
        {$ENDIF}
      end;
    end
    else
      {$IFDEF VCL}
      Mark.ParentWindow := 0;
      {$ELSE}
      Mark.Visible := False;
      Mark.Parent := nil;
      {$ENDIF}
  end;
end;

procedure TcxWebFormDesigner.UpdateSelectionBoundsRect;
var
  I: Integer;
  R: TRect;
begin
  FUpdateControlsPositionFlag := True;
  try
    for I := 0 to SelectionCount - 1 do
    begin
      R := GetDragRect(I, False);
      NormalizeRectCoords(R);
      MapWindowPoints({$IFDEF VCL}0{$ELSE}nil{$ENDIF}, HitDesignerParent.Handle, R, 2);
      SelectionControls[I].BoundsRect := R;
    end;
  finally
    FUpdateControlsPositionFlag := False;
  end;
  
  for I := 0 to SelectionCount - 1 do
    SelectionControls[I].UpdateControlPosition;
  DelphiDesigner.Modified;  
end;

{ states generally }

procedure TcxWebFormDesigner.BeginState(const Pt: TPoint);
begin
  RecognizeHitControls;

  if (ActiveDesigner.Environment <> nil) and
  ActiveDesigner.Environment.GetToolSelected then
    FState := dsCreateControls
  else
    if (HitControl = nil) or (ssCtrl in Shift) then
      FState := dsSelectControls
    else
      if ssShift in Shift then
        if InSelection(HitControl) then
          Unselect(HitControl)
        else
          Select(HitControl, True)
      else
      begin
        NormalizeSelection(HitControl.Parent);
        FState := dsDragControls; // ???
        if not InSelection(HitControl) then Select(HitControl, False);

        if (SelectionCount = 0) or
        (ActiveDesigner <> nil) and ActiveDesigner.ControlsLocked then
        begin
          FState := dsNone;
          if (ActiveControl <> nil) and
          (ActiveDesigner <> nil) and ActiveDesigner.ControlsLocked then
            ShowSelectionMarks(True);
        end
        else
          FState := dsDragControls;
      end;

  if FState <> dsNone then
  begin
    {$IFDEF VCL}
    SetCapture(DesignerControl.Handle);
    {$ELSE}
    SetCaptureControl(DesignerControl);
    {$ENDIF}
    PrepareCanvas(FClipRgn);
    case State of
      dsCreateControls:
        BeginCreation(Pt);
      dsDragControls:
        BeginDragControls(Pt);
      dsSelectControls:
        BeginSelection(Pt);
    end;
  end;
end;

procedure TcxWebFormDesigner.CancelState(ADropState, ARefreshFrame: Boolean);
begin
  case State of
    dsCreateControls:
      CancelCreation(ARefreshFrame);
    dsDragControls:
      CancelDragControls(ARefreshFrame);
    dsSelectControls:
      CancelSelection(ARefreshFrame);
  end;
  UnprepareCanvas(FClipRgn);
  if ADropState then DropState;
end;

function TcxWebFormDesigner.CanMoveTo(const Pt: TPoint): Boolean;
begin
  Result := not SnapToGrid or 
    (ssAlt in Shift) or not IsDeadZone(Pt);
end;

procedure TcxWebFormDesigner.DoState(const Pt: TPoint);
begin
  case State of
    dsCreateControls:
      if CanMoveTo(Pt) then DoCreation(Pt);
    dsDragControls:
      if CanMoveTo(Pt) then DoDragControls(Pt);
    dsSelectControls:
      DoSelection(Pt);
  end;
end;

procedure TcxWebFormDesigner.DropState;
begin
  FState := dsNone;
  ReallocMem(FDraggingRects, 0);
  ReallocMem(FSaveDraggingRects, 0);
  FHitControl := nil;
  FHitDesignerParent := nil;
  FHitCreatedDesignerParent := nil;
end;

procedure TcxWebFormDesigner.EndState;
begin
  case State of
    dsCreateControls:
      EndCreation;
    dsSelectControls:
      EndSelection;
    dsDragControls:
      EndDragControls;
  end;
end;

function TcxWebFormDesigner.FindHitWinControlParent(AWebControl: IcxWebControl): TWinControl;
begin
  if AWebControl <> nil then
  begin
    Result := GetWinControlByInterface(AWebControl.Parent);
    if Result = nil then
      Result := DesignerControl;
  end
  else Result := DesignerControl;
end;

function TcxWebFormDesigner.FindHitCreatedWinControlParent(AWebControl: IcxWebControl): TWinControl;
begin
  if AWebControl <> nil then
  begin
    if Supports(AWebControl, IcxWebContainerControl) then
      Result := GetWinControlByInterface(AWebControl)
    else Result := GetWinControlByInterface(AWebControl.Parent);
    if Result = nil then
      Result := DesignerControl;
  end
  else Result := DesignerControl;
end;

function TcxWebFormDesigner.FindHitControl: IcxWebControl;

  function FindInChildren(AParent: TWinControl; Pt: TPoint): TControl;
  var
    Control: TControl;
  begin
    Control := AParent.ControlAtPos(Pt, True, True);
    if Control is TWinControl then
    begin
      MapWindowPoints(AParent.Handle, TWinControl(Control).Handle, Pt, 1);
      Result := FindInChildren(TWinControl(Control), Pt);
    end
    else
      if Control = nil then
        Result := AParent
      else
        Result := Control;
  end;

var
  AControl: TControl;
  AWebDesignerControl: IcxWebDesignerControl;
begin
  if HitMark <> nil then
    Result := ActiveControl
  else
  begin
    AControl := FindInChildren(DesignerControl, DesignerControl.ScreenToClient(Mouse.CursorPos));
    if (AControl <> nil) and CanSelect(AControl) and
      Supports(AControl, IcxWebDesignerControl, AWebDesignerControl) then
      Result := AWebDesignerControl.WebControl
    else Result := nil;
  end;
end;


function TcxWebFormDesigner.GetClipRect: TRect;
var
  UltimateRect: TRect;
  ClipControl: TWinControl;
begin
  if State = dsDragControls then
    ClipControl := HitDesignerParent
  else
    ClipControl := HitCreatedDesignerParent;

  Result := ClipControl.ClientRect;
  MapWindowPoints(ClipControl.Handle, {$IFDEF VCL}0{$ELSE}nil{$ENDIF}, Result, 2);

  UltimateRect := DesignerControl.ClientRect;
  MapWindowPoints(DesignerControl.Handle, {$IFDEF VCL}0{$ELSE}nil{$ENDIF}, UltimateRect, 2);
  IntersectRect(Result, Result, UltimateRect);
end;

function TcxWebFormDesigner.GetDragRect(Index: Integer; ArrangedToGrid: Boolean): TRect;

  procedure PrepareRect(Index: Integer; var R: TRect);

    function CheckValue(Value, Granularity, Adjustment: Integer): Integer;
    begin
      Result := Granularity * (Value div Granularity);
      if Value mod Granularity >= Granularity div 2 then
        Inc(Result, Granularity);
      Inc(Result, Adjustment);        
    end;

  var
    Height, Width: Integer;
  begin
    MapWindowPoints({$IFDEF VCL}0{$ELSE}nil{$ENDIF}, HitDesignerParent.Handle, R, 2);
    with R do
      case DragAffect of
        daMove:
          begin
            Width := Right - Left;
            Height := Bottom - Top;
            Left := CheckValue(Left, GridSizeX, 0);
            Top := CheckValue(Top, GridSizeY, 0);
            Right := Left + Width;
            Bottom := Top + Height;
          end;
        daSize:
          begin
            if (State = dsCreateControls) or (ResizingAffect in [raTopLeft, raLeft, raBottomLeft]) then
              Left := CheckValue(Left, GridSizeX, 0);
            if (State = dsCreateControls) or (ResizingAffect in [raTopLeft, raTop, raTopRight]) then
              Top := CheckValue(Top, GridSizeY, 0);
            if (State = dsCreateControls) or (ResizingAffect in [raTopRight, raRight, raBottomRight]) then
              Right := CheckValue(Right, GridSizeX, 1);
            if (State = dsCreateControls) or (ResizingAffect in [raBottomRight, raBottom, raBottomLeft]) then
              Bottom := CheckValue(Bottom, GridSizeY, 1);
          end;
      end;
    MapWindowPoints(HitDesignerParent.Handle, {$IFDEF VCL}0{$ELSE}nil{$ENDIF}, R, 2);
  end;

begin
  if ArrangedToGrid then
  begin
    Result := FDraggingRects[Index];
    if SnapToGrid and not (ssAlt in Shift) then
      PrepareRect(Index, Result);
    FSaveDraggingRects^[Index] := Result;
  end
  else
    Result := FSaveDraggingRects^[Index];
end;

function TcxWebFormDesigner.IsDeadZone(const Pt: TPoint): Boolean;
begin
  Result := (Abs(Pt.X - FDraggingPoint.X) < GridSizeX) and
    (Abs(Pt.Y - FDraggingPoint.Y) < GridSizeY);
end;

procedure TcxWebFormDesigner.NormalizeRectCoords(var R: TRect);
var
  V: Integer;
begin
  with R do
  begin
    if Right < Left then
    begin
      V := Right;
      Right := Left;
      Left := V;
    end;
    if Bottom < Top then
    begin
      V := Bottom;
      Bottom := Top;
      Top := V;
    end;
  end;
end;

{$IFDEF VCL}
procedure TcxWebFormDesigner.PrepareCanvas(var Rgn: HRGN);
var
  DC: HDC;
  R: TRect;
begin
  FScreenCanvas := GetScreenCanvasClass.Create;
  DC := FScreenCanvas.Handle;
  Rgn := CreateRectRgn(0, 0, 0, 0);
  if GetClipRgn(DC, Rgn) <> 1 then
  begin
    DeleteObject(Rgn);
    Rgn := 0;
  end;
  R := GetClipRect;
  IntersectClipRect(DC, R.Left, R.Top, R.Right, R.Bottom);
  ClipCursor(@R);
end;
{$ELSE}
procedure TcxWebFormDesigner.PrepareCanvas(var Rgn: HRGN);
var
  p: TPoint;
begin
  FScreenCanvas := GetScreenCanvasClass.Create;
  QPainter_setClipping(FScreenCanvas.Handle, True);
  p := Point(0, 0);
  MapWindowPoints(FDesignerControl.Handle, nil, p, 1);
  QPainter_setClipRect(FScreenCanvas.Handle, p.x, p.y,
        FDesignerControl.Width, FDesignerControl.Height);
end;
{$ENDIF}

procedure TcxWebFormDesigner.PrepareFrameRect(var R: TRect; const Pt: TPoint);
begin
  case DragAffect of
    daMove:
      OffsetRect(R, Pt.X - FDraggingPoint.X, Pt.Y - FDraggingPoint.Y);
    daSize:
      case ResizingAffect of
        raTopLeft:
          R.TopLeft := Pt;
        raTop:
          R.Top := Pt.Y;
        raTopRight:
          begin
            R.Right := Pt.X;
            R.Top := Pt.Y;
          end;
        raRight:
          R.Right := Pt.X;
        raBottomRight:
          R.BottomRight := Pt;
        raBottom:
          R.Bottom := Pt.Y;
        raBottomLeft:
          begin
            R.Left := Pt.X;
            R.Bottom := Pt.Y;
          end;
        raLeft:
          R.Left := Pt.X;
      end;
  end;
end;

procedure TcxWebFormDesigner.PrepareFrameRects(const Pt: TPoint);
var
  I: Integer;
begin
  for I := 0 to SelectionCount - 1 do
    PrepareFrameRect(FDraggingRects^[I], Pt);
end;

procedure TcxWebFormDesigner.RecognizeHitControls;
begin
  FHitControl := FindHitControl;
  FHitDesignerParent := FindHitWinControlParent(FHitControl);
  FHitCreatedDesignerParent := FindHitCreatedWinControlParent(FHitControl);
end;

{$IFDEF VCL}
procedure TcxWebFormDesigner.UnprepareCanvas(var Rgn: HRGN);
begin
  SelectClipRgn(FScreenCanvas.Handle, Rgn);
  if Rgn <> 0 then
  begin
    DeleteObject(Rgn);
    Rgn := 0;
  end;
  FScreenCanvas.Free;
  ClipCursor(nil);
end;
{$ELSE}
procedure TcxWebFormDesigner.UnprepareCanvas(var Rgn: HRGN);
begin
  QPainter_setClipping(FScreenCanvas.Handle, False);
  FScreenCanvas.Free;
end;
{$ENDIF}

{$IFDEF VCL}
{ hints }
procedure TcxWebFormDesigner.HintActivate(const Pt: TPoint; const R: TRect;
  AControl: IcxWebControl; AHintType: TcxWebDesignerHintType; AImmediate: Boolean);
begin
  FHintWindow.Caption := HintGetText(R, AControl, AHintType);
  FHintWindow.Control := AControl;
  FHintCanceled := False;
  if AImmediate then
  begin
    FHintWindow.Activate(Pt);
    if not (State in [dsCreateControls, dsDragControls]) then 
    begin
      FHintHideTimer.Interval := cxWebDesignerHintHidePause;
      FHintHideTimer.Enabled := True;
    end;
  end  
  else
  begin
    FHintShowTimer.Interval := cxWebDesignerHintShowPause;
    FHintShowTimer.Enabled := True;  
  end;
end;

function TcxWebFormDesigner.HintDataRect(AControl: IcxWebControl): TRect;
var
  I: Integer;
begin   
  FillChar(Result, SizeOf(TRect), 0);
  case State of 
    dsNone:
      if (AControl <> nil) and (AControl <> nil) then 
        Result := AControl.BoundsRect;
    dsCreateControls:
      Result := FDraggingRects^[0];
    dsDragControls:
      begin
        Result := FDraggingRects^[0];
        for I := 1 to SelectionCount - 1 do
          UnionRect(Result, Result, FDraggingRects^[I]);
        MapWindowPoints(0, GetWinControlByInterface(AControl).Parent.Handle, Result, 2);
      end;  
  end;
end;      

procedure TcxWebFormDesigner.HintDeactivate(ACheckVisibility, ACancel, ADropControl: Boolean);
begin
  if not ACheckVisibility or IsWindowVisible(FHintWindow.Handle) then
    FHintWindow.Deactivate;
  if ACancel then 
    FHintCanceled := True;
  if ADropControl then 
    FHintWindow.Control := nil;
end;

function TcxWebFormDesigner.HintGetText(const R: TRect; AControl: IcxWebControl;
  AHintType: TcxWebDesignerHintType): string;
var
  TabOrderable: IcxWebTabOrderable;
begin
  case AHintType of
    htInfo:
      with GetComponentByInterface(AControl), AControl do
      begin
        Result := Format('%s: %s', [Name, ClassName]);
        if ShowExtendedControlHints then 
        begin
          Result := Result + CRLF + 
            Format(scxHintOrigin + ': %d, %d;' + scxHintSize + ': %d x %d', 
              [R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top]);
          if GetInterface(IcxWebTabOrderable, TabOrderable) then 
            Result := Result + CRLF + 
              Format(scxHintTabStop + ': %s;' + scxHintTabOrder + ': %d', [SysUtils.BoolToStr(TabStop, True), TabOrder]);
        end;
      end;  
    htSize: 
      Result := Format('%d x %d', [R.Right - R.Left, R.Bottom - R.Top]);
  else    
    Result := Format('%d, %d', [R.Left, R.Top]);
  end;
end; 
 
procedure TcxWebFormDesigner.HintHide(Sender: TObject);
begin
  TTimer(Sender).Enabled := False;
  if not FHintCanceled and not (State in [dsCreateControls, dsDragControls]) then
    HintDeactivate(True, True, False);
end;

procedure TcxWebFormDesigner.HintProcess(const Pt: TPoint);
var
  AHitControl: IcxWebControl;
  ACanShowHint: Boolean;
  R: TRect;
  AHintType: TcxWebDesignerHintType;
begin
  if State in [dsCreateControls, dsDragControls] then
    AHitControl := HitControl
  else
    AHitControl := FindHitControl;
    
  ACanShowHint := ForegroundTask and ((State in [dsCreateControls, dsDragControls]) or
    ((State = dsNone) and ShowDesignerHints and
     (AHitControl <> nil) and (HitMark = nil) and 
     ((FHintWindow.Control = nil) or (FHintWindow.Control <> AHitControl))));

  if ACanShowHint then
  begin
    FHintShowTimer.Enabled := False;
    FHintHideTimer.Enabled := False;
    R := HintDataRect(AHitControl);
    AHintType := HintTypes[State];
    if (AHintType = htSize) and (State = dsDragControls) and (DragAffect = daMove) then
      AHintType := htPosition;
    HintActivate(Pt, R, AHitControl, AHintType, 
      IsWindowVisible(FHintWindow.Handle) or (State in [dsCreateControls, dsDragControls]));
  end;
  
  if not (State in [dsCreateControls, dsDragControls]) and (AHitControl = nil) then 
    HintDeactivate(False, True, True);
end;

procedure TcxWebFormDesigner.HintShow(Sender: TObject);
var
  R: TRect;
begin
  TTimer(Sender).Enabled := False;
  if not FHintCanceled and not (State in [dsCreateControls, dsDragControls]) and (FHintWindow <> nil) then
  begin
    R := FHintWindow.Control.BoundsRect;
    MapWindowPoints(GetWinControlByInterface(FHintWindow.Control).Handle, 0, R, 2);
    if PtInRect(R, Mouse.CursorPos) then
    begin
      FHintWindow.Activate(Mouse.CursorPos);
      FHintHideTimer.Interval := cxWebDesignerHintHidePause;
      FHintHideTimer.Enabled := True;
    end;  
  end;
end;
{$ENDIF}

initialization
  WebDesignerFactory.RegisterDesigner(TcxWebFormDesigner, False);

finalization
  WebDesignerFactory.UnregisterDesigner(TcxWebFormDesigner);


end.
