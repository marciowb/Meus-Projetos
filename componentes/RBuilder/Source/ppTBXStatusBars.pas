{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{******************************************************************************
  TBX add-on package for Toolbar 2000
  Copyright © 2001–2005 Alex A. Denisov. All rights reserved.
  http://www.g32.org/tbx/index.html

  The contents of this file are subject to the "TBX License"; you may
  not use or distribute this file except in compliance with the
  "TBX Licensee". A copy of the "TBX License" may be found in
  TBX.chm or at

  http://www.g32.org/tbx/index.html#License

  The TBX source files may be downloaded from

  http://www.g32.org/files/tbx/tbx-2_1-beta1.zip
******************************************************************************}

unit ppTBXStatusBars;

// TBX Package
// Copyright 2001-2004 Alex A. Denisov. All Rights Reserved
// See TBX.chm for license and installation instructions
//
// $Id: TBXStatusBars.pas 15 2004-05-15 04:45:26Z Alex@ZEISS $

interface

{$I ppTB2Ver.inc}
{$I ppTBX.inc}

uses
  Windows,
  Messages,
  Classes,
  SysUtils,
  Controls,
  Forms,
  Graphics,
  ImgList,
  ppTBX,
  ppTBXThemes,
  ppTB2ITem;

type
  TppTBXCustomStatusBar = class;

  TPercent = 0..100;

  TppTBXStatusPanel = class(TCollectionItem)
  private
    FAlignment: TAlignment;
    FText: TCaption;
    FControl: TControl;
    FEnabled: Boolean;
    FFramed: Boolean;
    FFontSettings: TFontSettings;
    FHint: string;
    FImageIndex: TImageIndex;
    FMaxSize: Integer;
    FWidth: Integer;
    FStretchPriority: TPercent;
    FTag: Integer;
    FTextTruncation: TTextTruncation;
    FViewPriority: TPercent;
    procedure FontSettingsChanged(Sender: TObject);
    procedure SetAlignment(Value: TAlignment);
    procedure SetText(const Value: TCaption);
    procedure SetControl(Value: TControl);
    procedure SetEnabled(Value: Boolean);
    procedure SetFramed(Value: Boolean);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetMaxSize(Value: Integer);
    procedure SetWidth(Value: Integer);
    procedure SetStretchPriority(Value: TPercent);
    procedure SetTextTruncation(Value: TTextTruncation);
    procedure SetViewPriority(Value: TPercent);
    procedure SetFontSettings(const Value: TFontSettings);
  protected
    CachedBounds: TRect;
    CachedSize: Integer;
    CachedVisible: Boolean;
    CachedGripper: Boolean;
    function StatusBar: TppTBXCustomStatusBar;
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property BoundsRect: TRect read CachedBounds;
    property Visible: Boolean read CachedVisible;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Text: TCaption read FText write SetText;
    property Control: TControl read FControl write SetControl;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Framed: Boolean read FFramed write SetFramed default True;
    property FontSettings: TFontSettings read FFontSettings write SetFontSettings;
    property Hint: string read FHint write FHint;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property MaxSize: Integer read FMaxSize write SetMaxSize default 0;
    property ViewPriority: TPercent read FViewPriority write SetViewPriority default 100;
    property Width: Integer read FWidth write SetWidth default 50;
    property StretchPriority: TPercent read FStretchPriority write SetStretchPriority default 0;
    property Tag: Integer read FTag write FTag;
    property TextTruncation: TTextTruncation read FTextTruncation write SetTextTruncation default twNone;
  end;

  TppTBXStatusPanels = class(TCollection)
  private
    FStatusBar: TppTBXCustomStatusBar;
    function  GetItem(Index: Integer): TppTBXStatusPanel;
    procedure SetItem(Index: Integer; Value: TppTBXStatusPanel);
  protected
    function  GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AStatusBar: TppTBXCustomStatusBar);
    function Add: TppTBXStatusPanel;
    function FindPanel(AControl: TControl): TppTBXStatusPanel;
    property StatusBar: TppTBXCustomStatusBar read FStatusBar;
    property Items[Index: Integer]: TppTBXStatusPanel read GetItem write SetItem; default;
  end;

  TSBAdjustContentRect = procedure(Sender: TppTBXCustomStatusBar; Panel: TppTBXStatusPanel; var ARect: TRect) of object;
  TSBAdjustFont = procedure(Sender: TppTBXCustomStatusBar; Panel: TppTBXStatusPanel; AFont: TFont) of object;
  TSBPanelEvent = procedure(Sender: TppTBXCustomStatusBar; Panel: TppTBXStatusPanel) of object;

  TppTBXCustomStatusBar = class(TCustomControl)
  private
    FPanels: TppTBXStatusPanels;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FSimplePanel: Boolean;
    FSimpleText: TCaption;
    FSizeGrip: Boolean;
    FUpdateCount: Integer;
    FUseSystemFont: Boolean;
    FOnAdjustContentRect: TSBAdjustContentRect;
    FOnAdjustFont: TSBAdjustFont;
    FOnPanelClick: TSBPanelEvent;
    FOnPanelDblClick: TSBPanelEvent;
    FFixAlign: Boolean;
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(Value: TCustomImageList);
    procedure SetPanels(Value: TppTBXStatusPanels);
    procedure SetSimplePanel(Value: Boolean);
    procedure SetSimpleText(const Value: TCaption);
    procedure SetSizeGrip(Value: Boolean);
    procedure SetUseSystemFont(Value: Boolean);
    procedure TBMThemeChange(var Message); message TBM_THEMECHANGE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    CachedPanelMargins: TppTBXMargins;
    procedure AdjustPanelContentRect(APanel: TppTBXStatusPanel; var ARect: TRect); virtual;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure BeginUpdate;
    procedure Change; dynamic;
    procedure ChangeScale(M, D: Integer); override;
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DblClick; override;
    procedure DoAdjustFont(APanel: TppTBXStatusPanel; AFont: TFont); virtual;
    procedure DoPanelClick(APanel: TppTBXStatusPanel); virtual;
    procedure DoPanelDblClick(APanel: TppTBXStatusPanel); virtual;
    procedure EndUpdate;
    function  GetGripperRect: TRect;
    procedure Loaded; override;
    function  IsSizeGripVisible: Boolean;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure PaintPanel(ARect: TRect; APanel: TppTBXStatusPanel; IsLast: Boolean); virtual;
    procedure Resize; override;
    procedure UpdateCache; virtual;
    procedure UpdatePanels; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function  GetPanelAt(const Pt: TPoint): TppTBXStatusPanel; overload;
    function  GetPanelAt(X, Y: Integer): TppTBXStatusPanel; overload;
    function  GetPanelRect(APanel: TppTBXStatusPanel): TRect;
    procedure FlipChildren(AllLevels: Boolean); override;
    property Align default alBottom;
    property FixAlign: Boolean read FFixAlign write FFixAlign default False;
    property DoubleBuffered default True;
    property Images: TCustomImageList read FImages write SetImages;
    property Panels: TppTBXStatusPanels read FPanels write SetPanels;
    property SimplePanel: Boolean read FSimplePanel write SetSimplePanel default False;
    property SimpleText: TCaption read FSimpleText write SetSimpleText;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default True;
    property UseSystemFont: Boolean read FUseSystemFont write SetUseSystemFont;
    property OnAdjustContentRect: TSBAdjustContentRect read FOnAdjustContentRect write FOnAdjustContentRect;
    property OnAdjustFont: TSBAdjustFont read FOnAdjustFont write FOnAdjustFont;
    property OnPanelClick: TSBPanelEvent read FOnPanelClick write FOnPanelClick;
    property OnPanelDblClick: TSBPanelEvent read FOnPanelDblClick write FOnPanelDblClick;
  published
    property Height default 22;
  end;

  TppTBXStatusBar = class(TppTBXCustomStatusBar)
  published
    property Action;
    property Align;
    property Anchors;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FixAlign;
    property Font;
    property Images;
    property Panels;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property SimplePanel;
    property SimpleText;
    property SizeGrip;
    property ShowHint;
    property UseSystemFont;
    property Visible;
    property OnAdjustContentRect;
    property OnClick;
{$IFDEF JR_D5}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPanelClick;
    property OnPanelDblClick;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  ppTBXUtils;

type TFontSettingsAccess = class(TFontSettings);

function CompareViewPriorities(Item1, Item2: Pointer): Integer;
var
  P1, P2: TppTBXStatusPanel;
begin
  P1 := TppTBXStatusPanel(Item1);
  P2 := TppTBXStatusPanel(Item2);
  Result := P2.ViewPriority - P1.ViewPriority;
end;

function CompareStretchPriorities(Item1, Item2: Pointer): Integer;
var
  P1, P2: TppTBXStatusPanel;
begin
  P1 := TppTBXStatusPanel(Item1);
  P2 := TppTBXStatusPanel(Item2);
  Result := P1.StretchPriority - P2.StretchPriority;
end;

{ TppTBXStatusPanel }

procedure TppTBXStatusPanel.Assign(Source: TPersistent);

  function FindControl(AControl: TControl): TControl;
  begin
    if AControl <> nil then
      Result := StatusBar.Owner.FindComponent(AControl.Name) as TControl
    else
      Result := nil;
  end;

begin
  if Source is TppTBXStatusPanel then
  begin
    ViewPriority := TppTBXStatusPanel(Source).ViewPriority;
    Control := FindControl(TppTBXStatusPanel(Source).Control);
  end
  else inherited Assign(Source);
end;

constructor TppTBXStatusPanel.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FWidth := 50;
  FEnabled := True;
  FFramed := True;
  FImageIndex := -1;
  FViewPriority := 100;
  FFontSettings := TFontSettings.Create;
  TFontSettingsAccess(FFontSettings).OnChange := FontSettingsChanged;
end;

destructor TppTBXStatusPanel.Destroy;
var
  AControl: TControl;
begin
  AControl := Control;
  FControl := nil;
  FFontSettings.Free;
  inherited Destroy;
  if (AControl <> nil) and not (csDestroying in AControl.ComponentState) and
    ((AControl is TWinControl) and TWinControl(AControl).HandleAllocated) then
  begin
    AControl.BringToFront;
    AControl.Perform(CM_SHOWINGCHANGED, 0, 0);
  end;
end;

function TppTBXStatusPanel.GetDisplayName: string;
begin
  Result := Text;
  if (Result = '') and (Control <> nil) then Result := '[ ' + Control.Name + ' ]';
  if Result = '' then Result := inherited GetDisplayName;
end;

procedure TppTBXStatusPanel.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  Changed(False);
end;

procedure TppTBXStatusPanel.SetText(const Value: TCaption);
begin
  if Value <> FText then
  begin
    FText := Value;
    Changed(False);
  end;
end;

procedure TppTBXStatusPanel.SetControl(Value: TControl);
var
  Panel: TppTBXStatusPanel;
  PrevControl: TControl;
  P: TControl;
begin
  if FControl <> Value then
  begin
    if Value <> nil then
    begin
      P := StatusBar;
      while P <> nil do
        if P = Value then raise EInvalidOperation.Create('Can''t insert own parent')
        else P := P.Parent;

      Panel := TppTBXStatusPanels(Collection).FindPanel(Value);
      if (Panel <> nil) and (Panel <> Self) then Panel.SetControl(nil);
    end;
    PrevControl := FControl;
    FControl := Value;
    FControl.Parent := StatusBar;
    if Value <> nil then Value.FreeNotification(StatusBar);
    Changed(True);
    if PrevControl <> nil then PrevControl.Perform(CM_SHOWINGCHANGED, 0, 0);
  end;
end;

procedure TppTBXStatusPanel.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    Changed(False);
  end;
end;

procedure TppTBXStatusPanel.SetFramed(Value: Boolean);
begin
  if Value <> FFramed then
  begin
    FFramed := Value;
    Changed(False);
  end;
end;

procedure TppTBXStatusPanel.SetMaxSize(Value: Integer);
begin
  if Value <> FMaxSize then
  begin
    FMaxSize := Value;
    Changed(True);
  end;
end;

procedure TppTBXStatusPanel.SetViewPriority(Value: TPercent);
begin
  if Value <> FViewPriority then
  begin
    FViewPriority := Value;
    Changed(True);
  end;
end;

procedure TppTBXStatusPanel.SetWidth(Value: Integer);
begin
  if Value <> FWidth then
  begin
    FWidth := Value;
    Changed(True);
  end;
end;

procedure TppTBXStatusPanel.SetStretchPriority(Value: TPercent);
begin
  if Value <> FStretchPriority then
  begin
    FStretchPriority := Value;
    Changed(True);
  end;
end;

procedure TppTBXStatusPanel.SetTextTruncation(Value: TTextTruncation);
begin
  FTextTruncation := Value;
  Changed(False);
end;

function TppTBXStatusPanel.StatusBar: TppTBXCustomStatusBar;
begin
  Result := TppTBXStatusPanels(Collection).StatusBar;
end;

procedure TppTBXStatusPanel.SetImageIndex(Value: TImageIndex);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    if StatusBar.Images <> nil then Changed(False);
  end;
end;

procedure TppTBXStatusPanel.FontSettingsChanged(Sender: TObject);
begin
  Changed(False);
end;

procedure TppTBXStatusPanel.SetFontSettings(const Value: TFontSettings);
begin
  FFontSettings := Value;
end;

{ TppTBXStatusPanels }

function TppTBXStatusPanels.Add: TppTBXStatusPanel;
begin
  Result := TppTBXStatusPanel(inherited Add);
end;

constructor TppTBXStatusPanels.Create(AStatusBar: TppTBXCustomStatusBar);
begin
  inherited Create(TppTBXStatusPanel);
  FStatusBar := AStatusBar;
end;

function TppTBXStatusPanels.FindPanel(AControl: TControl): TppTBXStatusPanel;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TppTBXStatusPanel(inherited GetItem(I));
    if Result.FControl = AControl then Exit;
  end;
  Result := nil;
end;

function TppTBXStatusPanels.GetItem(Index: Integer): TppTBXStatusPanel;
begin
  Result := TppTBXStatusPanel(inherited GetItem(Index));
end;

function TppTBXStatusPanels.GetOwner: TPersistent;
begin
  Result := FStatusBar;
end;

procedure TppTBXStatusPanels.SetItem(Index: Integer; Value: TppTBXStatusPanel);
begin
  inherited SetItem(Index, Value);
end;

procedure TppTBXStatusPanels.Update(Item: TCollectionItem);
begin
  FStatusBar.UpdatePanels;
end;

{ TppTBXCustomStatusBar }

procedure TppTBXCustomStatusBar.AdjustPanelContentRect(APanel: TppTBXStatusPanel; var ARect: TRect);
begin
  if APanel.Framed then
    with CachedPanelMargins do
    begin
      Inc(ARect.Left, LeftWidth);
      Inc(ARect.Top, TopHeight);
      Dec(ARect.Right, RightWidth);
      Dec(ARect.Bottom, BottomHeight);
    end;
  if Assigned(FOnAdjustContentRect) then FOnAdjustContentRect(Self, APanel, ARect);
end;

procedure TppTBXCustomStatusBar.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if not (csDestroying in ComponentState) and (FUpdateCount = 0) and
    ((AControl = nil) and (Panels.Count > 0) or (AControl is TWinControl)) then
  begin
    Invalidate;
    UpdatePanels;
  end;
end;

procedure TppTBXCustomStatusBar.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TppTBXCustomStatusBar.Change;
var
  Form: TCustomForm;
begin
  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  end;
end;

procedure TppTBXCustomStatusBar.ChangeScale(M, D: Integer);
begin
  if UseSystemFont then ScalingFlags := [sfTop];
  inherited;
end;

procedure TppTBXCustomStatusBar.Click;
var
  Pt: TPoint;
  Panel: TppTBXStatusPanel;
begin
  inherited;
  GetCursorPos(Pt);
  Panel := GetPanelAt(ScreenToClient(Pt));
  if Panel <> nil then DoPanelClick(Panel);
end;

procedure TppTBXCustomStatusBar.CMControlChange(var Message: TCMControlChange);
var
  Panel: TppTBXStatusPanel;
begin
  if FUpdateCount = 0 then
  begin
    { Can only accept TWinControl descendants }
    if not (csLoading in ComponentState) then
      if Message.Inserting and (Message.Control is TWinControl) then
      begin
        with Panels.Add do SetControl(Message.Control);
      end
      else
      begin
        Panel := Panels.FindPanel(Message.Control);
        if Panel <> nil then Panel.Free;
      end;
  end;
end;

procedure TppTBXCustomStatusBar.CMFontChanged(var Message: TMessage);
begin
  inherited;
  UpdatePanels;
  Invalidate;
end;

procedure TppTBXCustomStatusBar.CMHintShow(var Message: TCMHintShow);
var
  Panel: TppTBXStatusPanel;
begin
  Panel := GetPanelAt(Message.HintInfo.CursorPos);
  if Panel <> nil then
  begin
    Message.HintInfo.HintStr := Panel.Hint;
    Message.HintInfo.CursorRect := Panel.BoundsRect;
  end;
end;

procedure TppTBXCustomStatusBar.CMVisibleChanged(var Message: TMessage);
begin
  if FixAlign and (Parent <> nil) then Top := Parent.ClientHeight;
  inherited;
end;

constructor TppTBXCustomStatusBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents, csDoubleClicks];
  if not (csDesigning in ComponentState) then ControlStyle := ControlStyle - [csOpaque];
  Height := 22;
  Align := alBottom;
  Width := 150;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FPanels := TppTBXStatusPanels.Create(Self);
  FSizeGrip := True;
  DoubleBuffered := True;
  AddThemeNotification(Self);
end;

procedure TppTBXCustomStatusBar.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TppTBXCustomStatusBar.CreateWnd;
begin
  inherited CreateWnd;
  if not (csLoading in ComponentState) then UpdatePanels;
end;

procedure TppTBXCustomStatusBar.DblClick;
var
  Pt: TPoint;
  Panel: TppTBXStatusPanel;
begin
  inherited;
  GetCursorPos(Pt);
  Panel := GetPanelAt(ScreenToClient(Pt));
  if Panel <> nil then DoPanelDblClick(Panel);
end;

destructor TppTBXCustomStatusBar.Destroy;
begin
  RemoveThemeNotification(Self);
  FImageChangeLink.Free;
  FPanels.Free;
  inherited Destroy;
end;

procedure TppTBXCustomStatusBar.DoAdjustFont(APanel: TppTBXStatusPanel; AFont: TFont);
begin
  { Changing AFont.Color will do nothing since it is replaced by the theme }
  if Assigned(FOnAdjustFont) then FOnAdjustFont(Self, APanel, AFont);
end;

procedure TppTBXCustomStatusBar.DoPanelClick(APanel: TppTBXStatusPanel);
begin
  if Assigned(FOnPanelClick) then FOnPanelClick(Self, APanel);
end;

procedure TppTBXCustomStatusBar.DoPanelDblClick(APanel: TppTBXStatusPanel);
begin
  if Assigned(FOnPanelDblClick) then FOnPanelDblClick(Self, APanel);
end;

procedure TppTBXCustomStatusBar.EndUpdate;
begin
  Dec(FUpdateCount);
end;

procedure TppTBXCustomStatusBar.FlipChildren(AllLevels: Boolean);
begin
  { do not flip controls }
end;

function TppTBXCustomStatusBar.GetGripperRect: TRect;
begin
  Result := ClientRect;
  with Result do
  begin
    Inc(Top, 3);
    Left := Right - GetSystemMetrics(SM_CXVSCROLL);
  end;
end;

function TppTBXCustomStatusBar.GetPanelAt(const Pt: TPoint): TppTBXStatusPanel;
var
  I: Integer;
begin
  for I := 0 to Panels.Count - 1 do
  begin
    Result := Panels[I];
    if Result.CachedVisible and PtInRect(Panels[I].BoundsRect, Pt) then Exit;
  end;
  Result := nil;
end;

function TppTBXCustomStatusBar.GetPanelAt(X, Y: Integer): TppTBXStatusPanel;
begin
  Result := GetPanelAt(Point(X, Y));
end;

function TppTBXCustomStatusBar.GetPanelRect(APanel: TppTBXStatusPanel): TRect;
begin
  if (APanel <> nil) and APanel.CachedVisible then Result := APanel.CachedBounds
  else Result := Rect(0, 0, 0, 0);
end;

procedure TppTBXCustomStatusBar.ImageListChange(Sender: TObject);
begin
  if Sender = Images then Invalidate;
end;

function TppTBXCustomStatusBar.IsSizeGripVisible: Boolean;
var
  ParentForm: TCustomForm;
  PBR, BR: TPoint;
begin
  Result := False;
  if SizeGrip then
  begin
    ParentForm := GetParentForm(Self);
    if (ParentForm <> nil) and (ParentForm.WindowState = wsNormal) then
    begin
      PBR := ParentForm.ClientToScreen(ParentForm.ClientRect.BottomRight);
      BR := ClientToScreen(ClientRect.BottomRight);
      Result := (PBR.X = BR.X) and (PBR.Y = BR.Y);
    end;
  end;
end;

procedure TppTBXCustomStatusBar.Loaded;
begin
  inherited Loaded;
  UpdatePanels;
end;

procedure TppTBXCustomStatusBar.Notification(AComponent: TComponent; Operation: TOperation);
var
  Panel: TppTBXStatusPanel;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if not (csDestroying in ComponentState) then
    begin
      Panel := Panels.FindPanel(TControl(AComponent));
      if Panel <> nil then Panel.FControl := nil;
    end
    else if AComponent = Images then Images := nil;
  end;
end;

procedure TppTBXCustomStatusBar.Paint;
const
  CEnabledState: array [Boolean] of Integer = (ISF_DISABLED, 0);
var
  CR, R: TRect;
  I: Integer;
  Panel: TppTBXStatusPanel;
//  PartID: Integer;
  Flags: Cardinal;
  lItemInfo: TppTBXItemInfo;
  lSepRect: TRect;
begin
  inherited;
  CR := ClientRect;
  CurrentTheme.PaintStatusBar(Canvas, CR, SBP_BODY);
  Inc(CR.Top, 2);
  if SimplePanel then
  begin
    if Length(SimpleText) > 0 then
    begin
      if UseSystemFont then Canvas.Font := ToolbarFont
      else Canvas.Font := Self.Font;

      Canvas.Brush.Style := bsClear;
      Flags := DT_SINGLELINE or DT_VCENTER;
      InflateRect(CR, -4, 0);
      DrawTBXCaption(Canvas, CR, SimpleText, Flags, ISF_STATUSCOLOR or CEnabledState[Enabled]);
      Canvas.Brush.Style := bsSolid;
    end;
  end
  else
    for I := 0 to Panels.Count - 1 do
    begin
      Panel := Panels[I];
      if Panel.CachedVisible and RectVisible(Canvas.Handle, Panel.CachedBounds) then
      begin
        R := Panel.CachedBounds;

        // NAM
        // draw separator between items
          FillChar(lItemInfo, SizeOf(TppTBXItemInfo), 0);
          lItemInfo.ViewType := VT_STATUSBAR;
//          lItemInfo.ItemOptions := CToolbarStyle[IsToolbarStyle] or CDesigning[csDesigning in Item.ComponentState];
          lItemInfo.Enabled := True;
          lItemInfo.Pushed := False;
          lItemInfo.Selected := False;
          lItemInfo.ImageShown := False;
          lItemInfo.ImageWidth := 0;
          lItemInfo.ImageHeight := 0;
          lItemInfo.IsVertical := True;
//          if not IsToolbarStyle then lItemInfo.PopupMargin := GetPopupMargin(Self);

        lSepRect := R;
        lSepRect.Left := R.Left - 10;
        lSepRect.Right := R.Left;
        CurrentTheme.PaintSeparator(Canvas, lSepRect, lItemInfo, False, True);



{        if Panel.Framed then
        begin
          if Panel.CachedGripper then PartID := SBP_LASTPANE
          else PartID := SBP_PANE;
          CurrentTheme.PaintStatusBar(Canvas, R, PartID);
        end;
}
        if UseSystemFont then Canvas.Font := ToolbarFont
        else Canvas.Font := Self.Font;

        Panel.FontSettings.Apply(Canvas.Font);
        DoAdjustFont(Panel, Canvas.Font);
        AdjustPanelContentRect(Panel, R);
        PaintPanel(R, Panel, I = Panels.Count - 1);
      end;
    end;
  if IsSizeGripVisible then
    CurrentTheme.PaintStatusBar(Canvas, GetGripperRect, SBP_GRIPPER);
end;

procedure TppTBXCustomStatusBar.PaintPanel(ARect: TRect; APanel: TppTBXStatusPanel; IsLast: Boolean);
const
  EnabledState: array [Boolean] of Integer = (ISF_DISABLED, 0);
  Alignments: array [TAlignment] of Integer = (DT_LEFT, DT_RIGHT, DT_CENTER);
  Truncations: array [TTextTruncation] of Integer = (0, DT_END_ELLIPSIS, DT_PATH_ELLIPSIS);
var
  Flags: Integer;
  R: TRect;
begin
  InflateRect(ARect, -1, 0);
  if (APanel.ImageIndex >= 0) and (Images <> nil) then
  begin
    R := ARect;
    R.Top := (R.Top + R.Bottom - Images.Height) div 2;
    R.Bottom := R.Top + Images.Height;
    case APanel.Alignment of
      taLeftJustify:
        begin
          R.Right := R.Left + Images.Width;
          ARect.Left := R.Right + 4;
        end;
      taRightJustify:
        begin
          R.Left := R.Right - Images.Width;
          ARect.Right := R.Left - 4;
        end;
      taCenter:
        begin
          R.Left := (R.Left + R.Right - Images.Width) div 2;
          R.Right := R.Left + Images.Width;
        end;
    end;
    if APanel.Enabled then Images.Draw(Canvas, R.Left, R.Top, APanel.ImageIndex)
    else DrawTBXImage(Canvas, R, Images, APanel.ImageIndex, ISF_DISABLED);
  end;
  Canvas.Brush.Style := bsClear;
  Flags := DT_SINGLELINE or DT_VCENTER or Alignments[APanel.Alignment] or Truncations[APanel.TextTruncation];
  DrawTBXCaption(Canvas, ARect, APanel.Text, Flags, ISF_STATUSCOLOR or EnabledState[APanel.Enabled]);
  Canvas.Brush.Style := bsSolid;
end;

procedure TppTBXCustomStatusBar.Resize;
begin
  UpdatePanels;
  Invalidate;
  inherited;
end;

procedure TppTBXCustomStatusBar.SetImages(Value: TCustomImageList);
begin
  if FImages <> nil then FImages.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  Invalidate;
end;

procedure TppTBXCustomStatusBar.SetPanels(Value: TppTBXStatusPanels);
begin
  FPanels.Assign(Value);
end;

procedure TppTBXCustomStatusBar.SetSimplePanel(Value: Boolean);
begin
  if FSimplePanel <> Value then
  begin
    FSimplePanel := Value;
    Invalidate;
  end;
end;

procedure TppTBXCustomStatusBar.SetSimpleText(const Value: TCaption);
begin
  if FSimpleText <> Value then
  begin
    FSimpleText := Value;
    Invalidate;
  end;
end;

procedure TppTBXCustomStatusBar.SetSizeGrip(Value: Boolean);
begin
  FSizeGrip := Value;
  Invalidate;
end;

procedure TppTBXCustomStatusBar.SetUseSystemFont(Value: Boolean);
begin
  if Value <> FUseSystemFont then
  begin
    FUseSystemFont := Value;
    UpdatePanels;
    Invalidate;
  end;
end;

procedure TppTBXCustomStatusBar.TBMThemeChange(var Message);
begin
  UpdatePanels;
  Invalidate;
end;

procedure TppTBXCustomStatusBar.UpdateCache;
var
  CR: TRect;
  Position, I: Integer;
  MaxWidth, WorkWidth: Integer;
  TotalSize, Delta, NewSize: Integer;
  SortList: TList;
  Panel: TppTBXStatusPanel;
begin
  if Panels.Count = 0 then Exit;
  CurrentTheme.GetMargins(MID_STATUSPANE, CachedPanelMargins);
  CR := ClientRect;
  Inc(CR.Top, 2);
  Position := 0;

  MaxWidth := CR.Right - CR.Left;
  WorkWidth := MaxWidth;
  TotalSize := 0;

  SortList := TList.Create;
  try
    { First Pass: Gather the panels with non-zero ViewPriority }
    for I := 0 to Panels.Count - 1 do
      with Panels[I] do
      begin
        CachedGripper := False;
        if ViewPriority > 0 then
        begin
          CachedSize := Width;
          CachedVisible := True;
          Inc(TotalSize, Width);
          SortList.Add(Panels[I])
        end
        else
          CachedVisible := False;
      end;

    SortList.Sort(CompareViewPriorities);

    { If necessary, hide the panels with low ViewPriority }
    if TotalSize > WorkWidth then
    begin
      while (TotalSize > WorkWidth) and (SortList.Count > 1) and
        (TppTBXStatusPanel(SortList.Last).ViewPriority < 100) do
      begin
        TppTBXStatusPanel(SortList.Last).CachedVisible := False;
        Dec(TotalSize, TppTBXStatusPanel(SortList.Last).Width);
        SortList.Count := SortList.Count - 1;
      end;
    end;

    { Stretch to fill the empty space }
    Delta := WorkWidth - TotalSize;
    if Delta > 0 then
    begin
      for I := SortList.Count - 1 downto 0 do
        if TppTBXStatusPanel(SortList[I]).StretchPriority = 0 then SortList.Delete(I);
      while (SortList.Count > 0) and (Delta > 0) do
      begin
        SortList.Sort(CompareStretchPriorities);

        { Start stretching with higher ViewPriority panels}
        Panel := TppTBXStatusPanel(SortList.Last);
        NewSize := Panel.CachedSize + Delta;
        if (Panel.MaxSize > Panel.CachedSize) and (NewSize > Panel.MaxSize) then
        begin
          NewSize := Panel.MaxSize;
          Dec(Delta, NewSize - Panel.CachedSize);
        end;
        Panel.CachedSize := NewSize;
        SortList.Count := SortList.Count - 1;
      end;
    end;

    for I := 0 to Panels.Count - 1 do
      with Panels[I] do
      begin
        if Position >= WorkWidth then CachedVisible := False;
        if CachedVisible then
        begin
          CachedBounds := CR;
          CachedBounds.Left := Position;
          Inc(Position, CachedSize);
          if Position = WorkWidth then CachedGripper := True;
          CachedBounds.Right := Position;
        end
        else CachedBounds := Rect(0, 0, 0, 0);
      end;

  finally
    SortList.Free;
  end;
end;

procedure TppTBXCustomStatusBar.UpdatePanels;
var
  I: Integer;
  R: TRect;
begin
  Invalidate;
  UpdateCache;
  for I := 0 to Panels.Count - 1 do
  begin
    with Panels[I] do
      if Visible then
      begin
        if Control <> nil then
        begin
          R := CachedBounds;
          if Framed then
            with CachedPanelMargins do
            begin
              Inc(R.Left, LeftWidth);
              Inc(R.Top, TopHeight);
              Dec(R.Right, RightWidth);
              Dec(R.Bottom, BottomHeight);
            end;
          Control.BoundsRect := R;
        end;
      end
      else if Control <> nil then Control.BoundsRect := Rect(0, 0, 0, 0);
  end;
end;

procedure TppTBXCustomStatusBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TppTBXCustomStatusBar.WMNCHitTest(var Message: TWMNCHitTest);
var
  Pt: TPoint;
begin
  inherited;
  if (Message.Result = HTCLIENT) and IsSizeGripVisible then
  begin
    Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
    if PtInRect(GetGripperRect, Pt) then Message.Result := HTBOTTOMRIGHT;
  end;
end;

end.
