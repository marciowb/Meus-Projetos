{********************************************************************}
{                                                                    }
{           Developer Express Visual Component Library               }
{           ExpressLayoutControl common routines                     }
{                                                                    }
{           Copyright (c) 2001-2010 Developer Express Inc.           }
{           ALL RIGHTS RESERVED                                      }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSLAYOUTCONTROL AND ALL          }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM       }
{   ONLY.                                                            }
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

unit dxLayoutSelection;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Graphics, Classes, Controls, cxClasses, cxGraphics,
  StdCtrls, cxControls;

const
  dxLayoutSelectionDefaultColor: TColor = $EDC8A3;
  dxLayoutControlSelectionDefaultColor: TColor = $582801;
  dxLayoutSelectionBorderDefaultColor: TColor = $BD8753;
  dxLayoutSelectionDefaultAlphaChannel: Byte = 80;
  dxLayoutSelectionBorderMarkerInnerDefaultColor: TColor = clWhite;

type
  TdxSelectionAction = (saAdded, saChanged, saExtracted);

  TdxSelectionLayer = class;

  { IdxSelectionChanged }

  IdxSelectionChanged = interface
  ['{ECB1A3AE-1C91-4E5F-8ADC-34120676B1CA}']
    procedure SelectionChanged(ASelection: TList; AAction: TdxSelectionAction);
  end;

  { IdxLayoutSelectableItem }

  IdxLayoutSelectableItem = interface
  ['{2887168D-78EB-44A0-A440-E284B01BE407}']
    function CanDelete: Boolean;
    function IsOwner(AOwner: TComponent): Boolean;
    procedure MakeVisible;
    procedure SelectComponent(AShift: TShiftState = []);
    procedure SelectParent;
    procedure SelectionChanged;
    function IsVisible: Boolean;
  end;

  { IdxLayoutDesignerHelper }

  IdxLayoutDesignerHelper = interface
  ['{0FF95B61-5074-49E4-99C6-1A8BB34F1547}']
    procedure AddSelectionChangedListener(AListener: TPersistent);
    function IsActive: Boolean;
    function CanDeleteComponent(AComponent: TComponent): Boolean;
    function CanModify: Boolean;
    function CanProcessKeyboard: Boolean;
    procedure ClearSelection;
    procedure DeleteSelection;
    procedure GetSelection(AList: TList);
    function IsComponentSelected(AComponent: TPersistent): Boolean;
    procedure RemoveSelectionChangedListener(AListener: TPersistent);
    procedure SelectComponent(AComponent: TPersistent; AShift: TShiftState = []);
    procedure SetSelection(AList: TList);
    function UniqueName(const BaseName: string): string;
  end;

  { TdxLayoutRunTimeSelectionHelper }

  TdxLayoutRunTimeSelectionHelper = class(TcxOwnedPersistent, IdxLayoutDesignerHelper)
  private
    FListeners: TList;
    FRefCount: Integer;
    FSelectionList: TcxComponentList;
    function GetComponent: TComponent;
    procedure SelectionListNotifyHandler(Sender: TObject; AComponent: TComponent; AAction: TListNotification);
    procedure SelectionListChangedHandler(Sender: TObject; AComponent: TComponent; AAction: TcxComponentCollectionNotification);
  protected
    function GetComponentClass(AComponent: TComponent): TComponentClass;
    procedure NotifyListeners(AList: TList; AAction: TdxSelectionAction);
    procedure SelectionListNotify(AComponent: TComponent; AAction: TListNotification);

    procedure DoDeleteComponents(AList: TcxComponentList); virtual;

    //IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    property Component: TComponent read GetComponent;
    property Listeners: TList read FListeners;
    property SelectionList: TcxComponentList read FSelectionList;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;

    // IdxLayoutControlSelectionController
    procedure AddSelectionChangedListener(AListener: TPersistent); virtual;
    procedure RemoveSelectionChangedListener(AListener: TPersistent); virtual;

    //IcxLayoutControlDesignerHelper
    function IsActive: Boolean; virtual;
    function CanDeleteComponent(AComponent: TComponent): Boolean; virtual;
    function CanModify: Boolean; virtual;
    function CanProcessKeyboard: Boolean; virtual;
    procedure ClearSelection; virtual;
    procedure DeleteSelection; virtual;
    procedure GetSelection(AList: TList); virtual;
    function IsComponentSelected(AComponent: TPersistent): Boolean; virtual;
    procedure SelectComponent(AComponent: TPersistent; AShift: TShiftState = []); virtual;
    procedure SetSelection(AList: TList); virtual;
    function UniqueName(const BaseName: string): string; virtual;
  end;

  TdxLayoutRunTimeSelectionHelperClass = class of TdxLayoutRunTimeSelectionHelper;

  TdxSelectionLayerInplaceEdit = class(TEdit)
  private
    FClickTime: Longint;
    FHiding: Boolean;
    FSelectionLayer: TdxSelectionLayer;
    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure DblClick; override;
    function DoMouseWheel(Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint): Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure WndProc(var Message: TMessage); override;

    property SelectionLayer: TdxSelectionLayer read FSelectionLayer;
  public
    constructor Create(ASelectionLayer: TdxSelectionLayer); reintroduce; virtual;
    procedure Hide;
    procedure SetFocus; override;
    procedure Show(const ABounds: TRect; const AText: string);
  end;

  { TdxSelectionLayer }

  TdxSelectionLayerHitTestEvent = procedure(ASender: TObject; var AIsTransparent: Boolean) of object;
  TdxSelectionLayerEndRenameEvent = procedure(ASender: TObject; const AText: string; AAccept: Boolean) of object;

  TdxSelectionLayer = class(TCustomControl)
  private
    FEditorMode: Boolean;
    FInplaceEditBounds: TRect;
    FInplaceEdit: TdxSelectionLayerInplaceEdit;
    FParentControl: TcxControl;
    FStartOffset: TPoint;
    FSelectionImage: TcxAlphaBitmap;
    FWindowCanvas: TcxCanvas;
    FOnEndRename: TdxSelectionLayerEndRenameEvent;
    FOnHide: TNotifyEvent;
    FOnHitTest: TdxSelectionLayerHitTestEvent;
    FOnShow: TNotifyEvent;
    FOnUpdate: TNotifyEvent;
    function GetWindowCanvas: TcxCanvas;
    procedure SetParentControl(AValue: TcxControl);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WndProc(var Message: TMessage); override;

    procedure CheckInplaceEditorPosition;
    procedure DoHide; virtual;
    function DoHitTest: Boolean; virtual;
    procedure DoShow; virtual;
    procedure DoUpdate; virtual;
    procedure DoEndRename(const AText: string; AAccept: Boolean); virtual;
    function GetParentOffset: TPoint;

    property WindowCanvas: TcxCanvas read GetWindowCanvas;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(AParentControl: TcxControl; AParentWindow: HWND); reintroduce; overload; virtual;
    destructor Destroy; override;

    procedure Paint; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    procedure InvalidateRect(const R: TRect);
    procedure MoveTo(const P: TPoint);
    procedure Hide;
    procedure Show;
    procedure UpdateContent;

    procedure BeginRename(const ABounds: TRect; const AText: string; const AFont: TFont);
    procedure EndRename(AAccept: Boolean);

    property EditorMode: Boolean read FEditorMode;
    property SelectionImage: TcxAlphaBitmap read FSelectionImage;
    property ParentControl: TcxControl read FParentControl write SetParentControl;
    property OnEndRename: TdxSelectionLayerEndRenameEvent read FOnEndRename write FOnEndRename;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnHitTest: TdxSelectionLayerHitTestEvent read FOnHitTest write FOnHitTest;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
  end;

  { IdxCustomizeControlsHelper }

  IdxCustomizeControlsHelper = interface
  ['{AD2130FB-EDA5-4034-A551-9C26A8DAAE41}']
    function CanProcessChildren: Boolean;
  end;

  { TdxControlsDesignSelectorHelper }

  TdxControlsDesignSelectorHelperClass = class of TdxControlsDesignSelectorHelper;

  TdxControlsDesignSelectorHelper = class(TComponent)
  private
    FControl: TControl;
    FChecked: Boolean;
    FChildren: TcxComponentList;
    FParent: TdxControlsDesignSelectorHelper;
    FSelectorBounds: TRect;
    FWindowProcObject: TcxWindowProcLinkedObject;
    function GetControlWnd: THandle;
    function GetParentControl: TWinControl;
    function PointInSelectorBounds(const P: TPoint): Boolean;
    procedure SetSelectorBounds(const AValue: TRect);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure CallDefaultWndProc(var Message: TMessage);
    procedure ControlWndProc(var Message: TMessage);
    function DoControlWndProc(var Message: TMessage): Boolean;  virtual;
    function IsHitTestTransparent(const P: TPoint): Boolean; virtual;

    procedure CheckChildren; virtual;
    procedure DestroyChild(AChild: TdxControlsDesignSelectorHelper); virtual;
    function GetChildClass: TdxControlsDesignSelectorHelperClass; virtual;

    procedure PrepareChild(AItem: TdxControlsDesignSelectorHelper); virtual;

    function GetSelectorBoundsForChild(AChild: TdxControlsDesignSelectorHelper): TRect;

    function ClientToScreen(const P: TPoint): TPoint;
    function ScreenToClient(const P: TPoint): TPoint;

    function IsActiveDesignSelector: Boolean; virtual;
    function IsSelected: Boolean; virtual;
    function IsValid: Boolean; virtual;

    function IsWinControl: Boolean;
    function ControlAsWinControl: TWinControl;

    // Draw
    function CanDrawDesignSelector: Boolean; virtual;
    procedure DoDrawDesignSelector(DC: HDC); virtual;
    procedure DrawDesignSelector(DC: HDC);

    procedure StoreWndProc;
    procedure RestoreWndProc;

    property Children: TcxComponentList read FChildren;
    property ControlWnd: THandle read GetControlWnd;
    property Parent: TdxControlsDesignSelectorHelper read FParent write FParent;
    property ParentControl: TWinControl read GetParentControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property Control: TControl read FControl;
    property SelectorBounds: TRect read FSelectorBounds write SetSelectorBounds;
  end;

implementation

uses
  SysUtils, Types, cxGeometry, Forms, dxOffice11;

type
  TcxControlAccess = class(TcxControl);

{ TdxLayoutControlRunTimeSelectionHelper }

constructor TdxLayoutRunTimeSelectionHelper.Create(AOwner: TPersistent);
begin
  inherited;
  FListeners := TList.Create;
  FSelectionList := TcxComponentList.Create;
  SelectionList.OnNotify := SelectionListNotifyHandler;
  SelectionList.OnComponentListChanged := SelectionListChangedHandler;
end;

destructor TdxLayoutRunTimeSelectionHelper.Destroy;
begin
  FreeAndNil(FSelectionList);
  FreeAndNil(FListeners);
  inherited Destroy;
end;

procedure TdxLayoutRunTimeSelectionHelper.AddSelectionChangedListener(AListener: TPersistent);
begin
  if (AListener <> nil) and Supports(AListener, IdxSelectionChanged) and
      (Listeners.IndexOf(AListener) < 0) then
    Listeners.Add(AListener);
end;

procedure TdxLayoutRunTimeSelectionHelper.RemoveSelectionChangedListener(AListener: TPersistent);
begin
  Listeners.Remove(AListener);
end;

function TdxLayoutRunTimeSelectionHelper.IsActive: Boolean;
begin
  Result := True;
end;

function TdxLayoutRunTimeSelectionHelper.CanDeleteComponent(
  AComponent: TComponent): Boolean;
var
  ASelectableItem: IdxLayoutSelectableItem;
begin
  Result := not (csDestroying in AComponent.ComponentState) and
    Supports(AComponent, IdxLayoutSelectableItem, ASelectableItem) and
    ASelectableItem.CanDelete;
end;

function TdxLayoutRunTimeSelectionHelper.CanModify: Boolean;
begin
  Result := True;
end;

function TdxLayoutRunTimeSelectionHelper.CanProcessKeyboard: Boolean;
begin
  Result := False;
end;

procedure TdxLayoutRunTimeSelectionHelper.ClearSelection;
begin
  SelectionList.Clear;
end;

procedure TdxLayoutRunTimeSelectionHelper.DeleteSelection;

  procedure CheckDeleteItems(AList: TcxComponentList);
  var
    I: Integer;
    AIntf: IdxLayoutSelectableItem;
  begin
    for I := AList.Count - 1 downto 0 do
      if not Supports(AList[0], IdxLayoutSelectableItem, AIntf) or not AIntf.CanDelete then
        AList.Extract(AList[I]);
  end;

var
  AList: TcxComponentList;
begin
  AList := TcxComponentList.Create(True);
  try
    GetSelection(AList);
    CheckDeleteItems(AList);
    DoDeleteComponents(AList);
  finally
    AList.Free;
  end;
end;

procedure TdxLayoutRunTimeSelectionHelper.GetSelection(AList: TList);
var
  I: Integer;
begin
  for I := 0 to SelectionList.Count - 1 do
    AList.Add(SelectionList[I]);
end;

function TdxLayoutRunTimeSelectionHelper.IsComponentSelected(AComponent: TPersistent): Boolean;
begin
  Result := SelectionList.IndexOf(TComponent(AComponent)) <> -1;
end;

procedure TdxLayoutRunTimeSelectionHelper.SelectComponent(
  AComponent: TPersistent; AShift: TShiftState);
begin
  SelectionList.BeginUpdate;
  try
    if (ssCtrl in AShift) and IsComponentSelected(AComponent) then
      SelectionList.Delete(SelectionList.IndexOf(TComponent(AComponent)))
    else
    begin
      if [ssCtrl, ssShift] * AShift = [] then
        ClearSelection;
      if not IsComponentSelected(AComponent) then
        SelectionList.Add(TComponent(AComponent));
    end;
  finally
    SelectionList.EndUpdate;
  end;
end;

procedure TdxLayoutRunTimeSelectionHelper.SetSelection(AList: TList);
var
  I: Integer;
begin
  SelectionList.BeginUpdate;
  try
    ClearSelection;
    for I := 0 to AList.Count - 1 do
      if SelectionList.IndexOf(AList[I]) = -1 then
        SelectionList.Add(AList[I]);
  finally
    SelectionList.EndUpdate;
  end;
end;

function TdxLayoutRunTimeSelectionHelper.UniqueName(const BaseName: string): string;
begin
  Result := '';
end;

function TdxLayoutRunTimeSelectionHelper.GetComponentClass(AComponent: TComponent): TComponentClass;
begin
  Result := TComponentClass(AComponent.ClassType);
end;

procedure TdxLayoutRunTimeSelectionHelper.NotifyListeners(AList: TList; AAction: TdxSelectionAction);
var
  I: Integer;
  AIntf: IdxSelectionChanged;
begin
  for I := 0 to Listeners.Count - 1 do
    if Supports(TObject(Listeners[I]), IdxSelectionChanged, AIntf) then
    begin
      AIntf.SelectionChanged(AList, AAction);
      AIntf := nil;
    end;
end;

procedure TdxLayoutRunTimeSelectionHelper.SelectionListNotify(AComponent: TComponent;
  AAction: TListNotification);
var
  ASelectableItem: IdxLayoutSelectableItem;
begin
  if not (csDestroying in AComponent.ComponentState) and
      Supports(AComponent, IdxLayoutSelectableItem, ASelectableItem) then
    ASelectableItem.SelectionChanged;
end;

procedure TdxLayoutRunTimeSelectionHelper.DoDeleteComponents(AList: TcxComponentList);
var
  ASavedOwnsObjects: Boolean;
begin
  ASavedOwnsObjects := AList.OwnsObjects;
  AList.OwnsObjects := True;
  AList.Clear;
  AList.OwnsObjects := ASavedOwnsObjects;
end;

function TdxLayoutRunTimeSelectionHelper.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TdxLayoutRunTimeSelectionHelper._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TdxLayoutRunTimeSelectionHelper._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then
    Destroy;
end;

function TdxLayoutRunTimeSelectionHelper.GetComponent: TComponent;
begin
  Result := TComponent(Owner);
end;

procedure TdxLayoutRunTimeSelectionHelper.SelectionListNotifyHandler(Sender: TObject;
  AComponent: TComponent; AAction: TListNotification);
begin
  SelectionListNotify(AComponent, AAction);
end;

procedure TdxLayoutRunTimeSelectionHelper.SelectionListChangedHandler(Sender: TObject;
  AComponent: TComponent; AAction: TcxComponentCollectionNotification);
const
  Action: array[TcxComponentCollectionNotification] of TdxSelectionAction = (saAdded, saChanged, saExtracted, saExtracted, saExtracted);
var
  AList: TList;
begin
  if AAction in [ccnAdded, ccnChanged, ccnExtracted] then
  begin
    AList := TList.Create;
    try
      GetSelection(AList);
      NotifyListeners(AList, Action[AAction]);
    finally
      AList.Free;
    end;
  end;
end;

{ TdxLayoutControlInplaceEdit }

constructor TdxSelectionLayerInplaceEdit.Create(
  ASelectionLayer: TdxSelectionLayer);
begin
  inherited Create(nil);
  FSelectionLayer := ASelectionLayer;
  ParentCtl3D := False;
  Ctl3D := False;
  TabStop := False;
  BorderStyle := bsNone;
  BorderWidth := 1;
  DoubleBuffered := False;
  Parent := ASelectionLayer;
end;

procedure TdxSelectionLayerInplaceEdit.CMShowingChanged(var Message: TMessage);
begin
// do nothing
end;

procedure TdxSelectionLayerInplaceEdit.DblClick;
begin
  SelectionLayer.DblClick;
end;

function TdxSelectionLayerInplaceEdit.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint): Boolean;
begin
  Result := SelectionLayer.DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TdxSelectionLayerInplaceEdit.Hide;
begin
  FHiding := True;
  try
    if HandleAllocated and IsWindowVisible(Handle) then
    begin
      Invalidate;
      SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_HIDEWINDOW or SWP_NOZORDER or
        SWP_NOREDRAW);
      if Focused then
        Windows.SetFocus(SelectionLayer.Handle);
    end;
  finally
    FHiding := False;
  end;
end;

procedure TdxSelectionLayerInplaceEdit.SetFocus;
begin
  if HandleAllocated and IsWindowVisible(Handle) then
    Windows.SetFocus(Handle);
end;

procedure TdxSelectionLayerInplaceEdit.Show(const ABounds: TRect; const AText: string);
begin
  Text := AText;
  BoundsRect := ABounds;
  ShowWindow(Handle, SW_SHOWNORMAL);
  SetFocus;
  SelectAll;
end;

procedure TdxSelectionLayerInplaceEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure SendToParent;
  begin
    SelectionLayer.KeyDown(Key, Shift);
    Key := 0;
  end;

  procedure ParentEvent;
  var
    ASelectionLayerKeyDown: TKeyEvent;
  begin
    ASelectionLayerKeyDown := SelectionLayer.OnKeyDown;
    if Assigned(ASelectionLayerKeyDown) then
      ASelectionLayerKeyDown(SelectionLayer, Key, Shift);
  end;

  function Ctrl: Boolean;
  begin
    Result := ssCtrl in Shift;
  end;

begin
  case Key of
    VK_INSERT:
      if Shift = [] then
        SendToParent;
    VK_F2:
      SelectionLayer.EndRename(True);
    VK_DELETE:
      if Ctrl then
        SendToParent;
  end;
  if Key <> 0 then
  begin
    ParentEvent;
    inherited KeyDown(Key, Shift);
  end;
end;

procedure TdxSelectionLayerInplaceEdit.KeyPress(var Key: Char);
begin
  case Key of
    #9, #13, #27:
      begin
        SelectionLayer.EndRename(Key <> #27);
        Key := #0;
      end;
  end;
  if Key <> #0 then
    inherited KeyPress(Key);
end;

procedure TdxSelectionLayerInplaceEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  SelectionLayer.KeyUp(Key, Shift);
end;

procedure TdxSelectionLayerInplaceEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := Message.Result or DLGC_WANTTAB;
end;

procedure TdxSelectionLayerInplaceEdit.WMPaint(var Message: TWMPaint);

  procedure DrawBorders(DC: HDC);
  var
    R: TRect;
  begin
    R := ClientRect;
    R.Right := R.Right + 2 * BorderWidth;
    R.Bottom := R.Bottom + 2 * BorderWidth;
    FrameRectByColor(DC, R, dxLayoutSelectionBorderDefaultColor);
  end;

var
  ADC: HDC;
begin
  inherited;

  if Message.DC <> 0 then
    DrawBorders(Message.DC)
  else
  begin
    ADC := GetWindowDC(Handle);
    DrawBorders(ADC);
    ReleaseDC(Handle, ADC);
  end;
end;

procedure TdxSelectionLayerInplaceEdit.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_SETFOCUS:
      begin
        if (GetParentForm(Self) = nil) or GetParentForm(Self).SetFocusedControl(SelectionLayer) then
          Dispatch(Message);
        Exit;
      end;
    WM_KILLFOCUS:
      if not FHiding then
        SelectionLayer.EndRename(not (csDestroying in ComponentState));
    WM_LBUTTONDOWN:
      begin
        if UINT(GetMessageTime - FClickTime) < GetDoubleClickTime then
          Message.Msg := WM_LBUTTONDBLCLK;
        FClickTime := 0;
      end;
  end;
  inherited WndProc(Message);
end;

{ TdxSelectionLayer }

constructor TdxSelectionLayer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  FSelectionImage := TcxAlphaBitmap.Create;
  FWindowCanvas := TcxCanvas.Create(inherited Canvas);
  Visible := False;
end;

constructor TdxSelectionLayer.Create(AParentControl: TcxControl; AParentWindow: HWND);
begin
  CreateParented(AParentWindow);
  ParentControl := AParentControl;
end;

destructor TdxSelectionLayer.Destroy;
begin
  Hide;
  FreeAndNil(FInplaceEdit);
  FreeAndNil(FWindowCanvas);
  FreeAndNil(FSelectionImage);
  inherited Destroy;
end;

procedure TdxSelectionLayer.Paint;
var
  ABitmap: TcxBitmap32;
begin
  ABitmap := TcxBitmap32.CreateSize(ClientRect);
  try
    if ParentControl <> nil then
      cxPaintTo(ParentControl, ABitmap.cxCanvas, cxNullPoint, ClientRect)
    else
      cxPaintTo(Parent, ABitmap.cxCanvas, cxNullPoint, ClientRect);
    cxAlphaBlend(ABitmap.cxCanvas.Handle, SelectionImage.cxCanvas.Handle, ClientRect, ClientRect);
    cxBitBlt(WindowCanvas.Handle, ABitmap.cxCanvas.Handle, ClientRect, cxNullPoint, SRCCOPY);
  finally
    ABitmap.Free;
  end;
end;

procedure TdxSelectionLayer.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SelectionImage.SetSize(Width, Height);
end;

procedure TdxSelectionLayer.InvalidateRect(const R: TRect);
begin
  if HandleAllocated then
    cxInvalidateRect(Handle, R, False);
end;

procedure TdxSelectionLayer.MoveTo(const P: TPoint);
begin
  SetBounds(P.X, P.Y, Width, Height);
end;

procedure TdxSelectionLayer.Hide;
begin
  EndRename(False);
  if HandleAllocated then
  begin
    ShowWindow(Handle, SW_HIDE);
    DoHide;
  end;
end;

procedure TdxSelectionLayer.Show;
begin
  ShowWindow(Handle, SW_SHOWNOACTIVATE);
  DoShow;
end;

procedure TdxSelectionLayer.BeginRename(const ABounds: TRect; const AText: string; const AFont: TFont);
begin
  FEditorMode := True;
  if FInplaceEdit = nil then
    FInplaceEdit := TdxSelectionLayerInplaceEdit.Create(Self);
  FInplaceEdit.Font := AFont;
  FInplaceEditBounds := ABounds;
  FStartOffset := GetParentOffset;
  FInplaceEdit.Show(ABounds, AText);
end;

procedure TdxSelectionLayer.EndRename(AAccept: Boolean);
begin
  FEditorMode := False;
  if FInplaceEdit <> nil then
  try
    DoEndRename(FInplaceEdit.Text, AAccept);
  finally
    FInplaceEdit.Hide;
  end;
  Invalidate;
end;

procedure TdxSelectionLayer.UpdateContent;
begin
  SelectionImage.RecoverAlphaChannel(0);
  if not IsWindowVisible(Handle) then
    Show;
  DoUpdate;
  CheckInplaceEditorPosition;
  Invalidate;
end;

procedure TdxSelectionLayer.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style and not WS_POPUP or WS_CHILD;
    ExStyle := ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  end;
  if ParentControl <> nil then
    Params.WndParent := ParentControl.Handle;
end;

procedure TdxSelectionLayer.WndProc(var Message: TMessage);

  function SendMessageToParent: Boolean;
  begin
    Result := True;
    if ParentControl <> nil then
      with Message do
        Result := ParentControl.Perform(Msg, WParam, LParam)
    else
      if Parent <> nil then
        with Message do
          Result := Parent.Perform(Msg, WParam, LParam)
      else
        Result := False;
  end;

begin
  case Message.Msg of
    WM_MOUSEFIRST..WM_MOUSELAST, WM_SETCURSOR:
      if not SendMessageToParent then
        inherited;
  else
    inherited;
  end;
end;

procedure TdxSelectionLayer.CheckInplaceEditorPosition;
var
  R: TRect;
  P: TPoint;
begin
  if not EditorMode then Exit;
  R := FInplaceEditBounds;
  P := GetParentOffset;
  OffsetRect(R, FStartOffset.X - P.X, 0);
  OffsetRect(R, 0, FStartOffset.Y - P.Y);
  MoveWindow(FInplaceEdit.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, False);
end;

procedure TdxSelectionLayer.DoHide;
begin
  CallNotify(FOnHide, Self);
end;

function TdxSelectionLayer.DoHitTest: Boolean;
begin
  Result := False;
  if Assigned(FOnHitTest) then
    FOnHitTest(Self, Result);
end;

procedure TdxSelectionLayer.DoShow;
begin
  CallNotify(FOnShow, Self);
end;

procedure TdxSelectionLayer.DoUpdate;
begin
  CallNotify(FOnUpdate, Self);
end;

procedure TdxSelectionLayer.DoEndRename(const AText: string; AAccept: Boolean);
begin
  if Assigned(FOnEndRename) then
    FOnEndRename(Self, AText, AAccept);
end;

function TdxSelectionLayer.GetParentOffset: TPoint;
begin
  Result := cxNullPoint;
  with TcxControlAccess(ParentControl) do
  begin
    if HScrollBarVisible then
      Result.X := HScrollBar.Position;
    if VScrollBarVisible then
      Result.Y := VScrollBar.Position;
  end;
end;

function TdxSelectionLayer.GetWindowCanvas: TcxCanvas;
begin
  Result := FWindowCanvas;
end;

procedure TdxSelectionLayer.SetParentControl(AValue: TcxControl);
begin
  if FParentControl <> AValue then
  begin
    FParentControl := AValue;
    RecreateWnd;
  end;
end;

procedure TdxSelectionLayer.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TdxSelectionLayer.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if DoHitTest then
    Message.Result := HTTRANSPARENT
  else
    inherited;
end;

{ TdxControlsDesignSelectorHelper }

constructor TdxControlsDesignSelectorHelper.Create(AOwner: TComponent);
begin
  inherited Create(nil);
  FControl := AOwner as TControl;
  FSelectorBounds := cxInvalidRect;
  FChildren := TcxComponentList.Create(True);
  StoreWndProc;
  Control.FreeNotification(Self);
end;

destructor TdxControlsDesignSelectorHelper.Destroy;
begin
  Control.RemoveFreeNotification(Self);
  RestoreWndProc;
  FreeAndNil(FChildren);
  inherited Destroy;
end;

procedure TdxControlsDesignSelectorHelper.Assign(Source: TPersistent);
var
  AItem: TdxControlsDesignSelectorHelper;
begin
  if Source is TdxControlsDesignSelectorHelper then
  begin
    AItem := Source as TdxControlsDesignSelectorHelper;
    FSelectorBounds := AItem.GetSelectorBoundsForChild(Self);
    CheckChildren;
  end
  else
    inherited Assign(Source);
end;

procedure TdxControlsDesignSelectorHelper.ControlWndProc(var Message: TMessage);

  procedure InternalPaint(DC: HDC);
  var
    ADC: HDC;
  begin
    if not IsActiveDesignSelector then
      Exit;
    if DC <> 0 then
      DrawDesignSelector(DC)
    else
      if IsWinControl then
      begin
        ADC := GetWindowDC(ControlWnd);
        DrawDesignSelector(ADC);
        ReleaseDC(ControlWnd, ADC);
      end;
  end;

begin
  if not DoControlWndProc(Message) then
    CallDefaultWndProc(Message);
  case Message.Msg of
    CM_CONTROLCHANGE:
      CheckChildren;
    WM_PARENTNOTIFY:
      if Message.WParamLo in [WM_CREATE, WM_DESTROY] then
        CheckChildren;
    WM_PAINT:
      InternalPaint(TWMPaint(Message).DC);
    WM_WINDOWPOSCHANGED:
      if Parent <> nil then
        SelectorBounds := Parent.GetSelectorBoundsForChild(Self);
  end;
end;

function TdxControlsDesignSelectorHelper.DoControlWndProc(var Message: TMessage): Boolean;
begin
  Result := False;
  case Message.Msg of
    WM_NCHITTEST:
      if IsValid and IsActiveDesignSelector then
        if IsHitTestTransparent(ScreenToClient(Point(Message.LParamLo, Message.LParamHi))) then
        begin
          Message.Result := HTTRANSPARENT;
          Result := True;
        end;
    CM_HITTEST:
      if IsValid and IsActiveDesignSelector then
        if PointInSelectorBounds(Point(Message.LParamLo, Message.LParamHi)) then
        begin
          Message.Result := HTNOWHERE;
          Result := True;
        end;
    end;
end;

function TdxControlsDesignSelectorHelper.IsHitTestTransparent(const P: TPoint): Boolean;
begin
  Result := PointInSelectorBounds(P);
end;

procedure TdxControlsDesignSelectorHelper.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = Control) and (Parent <> nil) then
    Parent.DestroyChild(Self);
end;

procedure TdxControlsDesignSelectorHelper.CallDefaultWndProc(var Message: TMessage);
begin
  FWindowProcObject.DefaultProc(Message);
end;

procedure TdxControlsDesignSelectorHelper.CheckChildren;

  function GetChild(AControl: TControl): TdxControlsDesignSelectorHelper;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to FChildren.Count - 1 do
      if (FChildren[I] as TdxControlsDesignSelectorHelper).Control = AControl then
      begin
        Result := FChildren[I] as TdxControlsDesignSelectorHelper;
        Break;
      end;
    if Result = nil then
      Result := GetChildClass.Create(AControl);
  end;

  procedure TryAddChild(AControl: TControl); overload;
  var
    AIntf: IdxCustomizeControlsHelper;
  begin
    if (csDestroying in AControl.ComponentState) or ((Supports(AControl, IdxCustomizeControlsHelper, AIntf) and AIntf.CanProcessChildren)) or
        not (AControl is TWinControl) or not (AControl as TWinControl).HandleAllocated then
      Exit;

    PrepareChild(GetChild(AControl));
  end;

var
  I: Integer;
  AIntf: IdxCustomizeControlsHelper;
begin
  for I := 0 to FChildren.Count - 1 do
    (FChildren[I] as TdxControlsDesignSelectorHelper).FChecked := False;
  if IsWinControl and ControlAsWinControl.HandleAllocated and (not Supports(Control, IdxCustomizeControlsHelper, AIntf) or not AIntf.CanProcessChildren) then
  begin
    for I := 0 to ControlAsWinControl.ControlCount - 1 do
      TryAddChild(ControlAsWinControl.Controls[I]);
  end;
  for I := FChildren.Count - 1 downto 0 do
    if not (FChildren[I] as TdxControlsDesignSelectorHelper).FChecked then
      FChildren[I].Free;
end;

procedure TdxControlsDesignSelectorHelper.DestroyChild(AChild: TdxControlsDesignSelectorHelper);
begin
  AChild.Free;
  if not (csDestroying in ComponentState) then
    CheckChildren;
end;

function TdxControlsDesignSelectorHelper.GetChildClass: TdxControlsDesignSelectorHelperClass;
begin
  Result := TdxControlsDesignSelectorHelper;
end;

procedure TdxControlsDesignSelectorHelper.PrepareChild(AItem: TdxControlsDesignSelectorHelper);
begin
  if FChildren.IndexOf(AItem) = -1 then
    FChildren.Add(AItem);
  AItem.Parent := Self;
  AItem.Assign(Self);
  AItem.FChecked := True;
end;

function TdxControlsDesignSelectorHelper.GetSelectorBoundsForChild(AChild: TdxControlsDesignSelectorHelper): TRect;
var
  P: TPoint;
begin
  Result := SelectorBounds;
  P := ScreenToClient(AChild.ClientToScreen(cxNullPoint));
  Result := cxRectOffset(Result, P, False);
end;

function TdxControlsDesignSelectorHelper.ClientToScreen(const P: TPoint): TPoint;
begin
  Result := Control.ClientToScreen(P);
end;

function TdxControlsDesignSelectorHelper.ScreenToClient(const P: TPoint): TPoint;
begin
  Result := Control.ScreenToClient(P);
end;

function TdxControlsDesignSelectorHelper.IsActiveDesignSelector: Boolean;
begin
  Result := IsValid;
end;

function TdxControlsDesignSelectorHelper.IsSelected: Boolean;
begin
  Result := False;
end;

function TdxControlsDesignSelectorHelper.IsValid: Boolean;
begin
  Result := not (csDestroying in ComponentState) and
    (Control <> nil) and not (csDestroying in Control.ComponentState);
end;

function TdxControlsDesignSelectorHelper.IsWinControl: Boolean;
begin
  Result := Control is TWinControl;
end;

function TdxControlsDesignSelectorHelper.ControlAsWinControl: TWinControl;
begin
  Result := Control as TWinControl;
end;

function TdxControlsDesignSelectorHelper.CanDrawDesignSelector: Boolean;
begin
  Result := IsActiveDesignSelector and ((Parent = nil) or (IsWinControl and IsWindowVisible(ControlWnd)));
end;

procedure TdxControlsDesignSelectorHelper.DoDrawDesignSelector(DC: HDC);
var
  R: TRect;
  P: TPoint;
begin
  cxPaintCanvas.BeginPaint(DC);
  try
    SelectClipRgn(cxPaintCanvas.Handle, 0);
    R := SelectorBounds;
    if (Control <> nil) and not (csPaintCopy in Control.ControlState) and (Control.Parent <> nil) then
    begin
      P := Control.Parent.ScreenToClient(Control.ClientToScreen(cxNullPoint));
      P := cxPointOffset(P, Control.BoundsRect.TopLeft, False);
      R := cxRectOffset(R, P);
    end;
    cxDrawDesignRect(cxPaintCanvas, R, IsSelected);
  finally
    cxPaintCanvas.EndPaint;
  end;
end;

procedure TdxControlsDesignSelectorHelper.DrawDesignSelector(DC: HDC);
begin
  if CanDrawDesignSelector then
    DoDrawDesignSelector(DC);
end;

procedure TdxControlsDesignSelectorHelper.StoreWndProc;
begin
  if Control <> nil then
    FWindowProcObject := cxWindowProcController.Add(Control, ControlWndProc);
end;

procedure TdxControlsDesignSelectorHelper.RestoreWndProc;
begin
  if Assigned(FWindowProcObject) then
    cxWindowProcController.Remove(FWindowProcObject);
end;

function TdxControlsDesignSelectorHelper.GetControlWnd: THandle;
begin
  if IsWinControl and ControlAsWinControl.HandleAllocated then
    Result := ControlAsWincontrol.Handle
  else
    Result := 0;
end;

function TdxControlsDesignSelectorHelper.GetParentControl: TWinControl;
begin
  Result := Control.Parent; 
end;

procedure TdxControlsDesignSelectorHelper.SetSelectorBounds(const AValue: TRect);
begin
  if not EqualRect(AValue, FSelectorBounds) then
  begin
    FSelectorBounds := AValue;
    CheckChildren;
    if Control.Visible then
      Control.Invalidate;
  end;
end;

function TdxControlsDesignSelectorHelper.PointInSelectorBounds(const P: TPoint): Boolean;
begin
  Result := cxRectPtIn(SelectorBounds, P);
end;

end.
