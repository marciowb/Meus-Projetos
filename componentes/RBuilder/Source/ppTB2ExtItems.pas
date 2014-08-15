{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit ppTB2ExtItems;

{
  Toolbar2000
  Copyright (C) 1998-2004 by Jordan Russell
  All rights reserved.

  The contents of this file are subject to the "Toolbar2000 License"; you may
  not use or distribute this file except in compliance with the
  "Toolbar2000 License". A copy of the "Toolbar2000 License" may be found in
  TB2k-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/TB2k-LICENSE.txt

  Alternatively, the contents of this file may be used under the terms of the
  GNU General Public License (the "GPL"), in which case the provisions of the
  GPL are applicable instead of those in the "Toolbar2000 License". A copy of
  the GPL may be found in GPL-LICENSE.txt or at:
    http://www.jrsoftware.org/files/tb2k/GPL-LICENSE.txt
  If you wish to allow use of your version of this file only under the terms of
  the GPL and not to allow others to use your version of this file under the
  "Toolbar2000 License", indicate your decision by deleting the provisions
  above and replace them with the notice and other provisions required by the
  GPL. If you do not delete the provisions above, a recipient may use your
  version of this file under either the "Toolbar2000 License" or the GPL.

  $jrsoftware: tb2k/Source/TB2ExtItems.pas,v 1.56 2004/02/26 07:05:57 jr Exp $
}

interface

{$I ppTB2Ver.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CommCtrl, Menus, ActnList,
  ppTB2Item;

type
  TppTBEditItemOption = (tboUseEditWhenVertical);
  TppTBEditItemOptions = set of TppTBEditItemOption;

const
  EditItemDefaultEditOptions = [];
  EditItemDefaultEditWidth = 64;

{ Change reasons for TppTBEditItem.Text property }
  tcrSetProperty = 0;  // direct assignment to TppTBEditItem.Text property
  tcrActionLink  = 1;  // change comes from an action link
  tcrEditControl = 2;  // change is caused by typing in edit area

type
  TppTBEditItem = class;
  TppTBEditItemViewer = class;

  TppTBAcceptTextEvent = procedure(Sender: TObject; var NewText: String;
    var Accept: Boolean) of object;
  TppTBBeginEditEvent = procedure(Sender: TppTBEditItem; Viewer: TppTBEditItemViewer;
    EditControl: TEdit) of object;

  TppTBEditAction = class(TAction)
  private
    FEditOptions: TppTBEditItemOptions;
    FEditCaption: String;
    FEditWidth: Integer;
    FOnAcceptText: TppTBAcceptTextEvent;
    FText: String;
    procedure SetEditCaption(Value: String);
    procedure SetEditOptions(Value: TppTBEditItemOptions);
    procedure SetEditWidth(Value: Integer);
    procedure SetOnAcceptText(Value: TppTBAcceptTextEvent);
    procedure SetText(Value: String);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property EditCaption: String read FEditCaption write SetEditCaption;
    property EditOptions: TppTBEditItemOptions read FEditOptions write SetEditOptions default EditItemDefaultEditOptions;
    property EditWidth: Integer read FEditWidth write SetEditWidth default EditItemDefaultEditWidth;
    property Text: String read FText write SetText;

    property OnAcceptText: TppTBAcceptTextEvent read FOnAcceptText write SetOnAcceptText;
  end;

  TppTBEditItemActionLink = class(TppTBCustomItemActionLink)
  protected
    procedure AssignClient(AClient: TObject); override;
    function IsEditCaptionLinked: Boolean; virtual;
    function IsEditOptionsLinked: Boolean; virtual;
    function IsEditWidthLinked: Boolean; virtual;
    function IsOnAcceptTextLinked: Boolean; virtual;
    function IsTextLinked: Boolean; virtual;
    procedure SetEditCaption(const Value: String); virtual;
    procedure SetEditOptions(Value: TppTBEditItemOptions); virtual;
    procedure SetEditWidth(const Value: Integer); virtual;
    procedure SetOnAcceptText(Value: TppTBAcceptTextEvent); virtual;
    procedure SetText(const Value: String); virtual;
  end;

  TppTBEditItem = class(TppTBCustomItem)
  private
    FCharCase: TEditCharCase;
    FEditCaption: String;
    FEditOptions: TppTBEditItemOptions;
    FEditWidth: Integer;
    FExtendedAccept: Boolean;
    FMaxLength: Integer;
    FOnAcceptText: TppTBAcceptTextEvent;
    FOnBeginEdit: TppTBBeginEditEvent;
    FText: String;
    function IsEditCaptionStored: Boolean;
    function IsEditOptionsStored: Boolean;
    function IsEditWidthStored: Boolean;
    function IsTextStored: Boolean;
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetEditCaption(Value: String);
    procedure SetEditOptions(Value: TppTBEditItemOptions);
    procedure SetEditWidth(Value: Integer);
    procedure SetMaxLength(Value: Integer);
    procedure SetText(Value: String);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function DoAcceptText(var NewText: string): Boolean; virtual;
    procedure DoBeginEdit(Viewer: TppTBEditItemViewer); virtual;
    procedure DoTextChanging(const OldText: String; var NewText: String; Reason: Integer); virtual;
    procedure DoTextChanged(Reason: Integer); virtual;
    function GetActionLinkClass: TppTBCustomItemActionLinkClass; override;
    function GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    function NeedToRecreateViewer(AViewer: TppTBItemViewer): Boolean; override;
    property ExtendedAccept: Boolean read FExtendedAccept write FExtendedAccept default False;
    procedure SetTextEx(Value: String; Reason: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    procedure Click; override;
  published
    property Action;
    property AutoCheck;
    property Caption;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property Checked;
    property DisplayMode;
    property EditCaption: String read FEditCaption write SetEditCaption stored IsEditCaptionStored;
    property EditOptions: TppTBEditItemOptions read FEditOptions write SetEditOptions stored IsEditOptionsStored;
    property EditWidth: Integer read FEditWidth write SetEditWidth stored IsEditWidthStored;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property Enabled;
    property GroupIndex;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property ShortCut;
    property Text: String read FText write SetText stored IsTextStored;
    property Visible;

    property OnAcceptText: TppTBAcceptTextEvent read FOnAcceptText write FOnAcceptText;
    property OnBeginEdit: TppTBBeginEditEvent read FOnBeginEdit write FOnBeginEdit;
    property OnClick;
    property OnSelect;
  end;

  TEditClass = class of TEdit;

  TppTBEditItemViewer = class(TppTBItemViewer)
  private
    FEditControl: TEdit;
    FEditControlStatus: set of (ecsContinueLoop, ecsAccept, ecsClose);
    function EditLoop(const CapHandle: HWND): Boolean;
    procedure EditWndProc(var Message: TMessage);
    procedure MouseBeginEdit;
  protected
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
      override;
    function CaptionShown: Boolean; override;
    function DoExecute: Boolean; override;
    function GetAccRole: Integer; override;
    function GetAccValue(var Value: WideString): Boolean; override;
    function GetCaptionText: String; override;
    procedure GetCursor(const Pt: TPoint; var ACursor: HCURSOR); override;
    function  GetEditControlClass: TEditClass; virtual;
    procedure GetEditRect(var R: TRect); virtual;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;
      var MouseDownOnMenu: Boolean); override;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
      IsSelected, IsPushed, UseDisabledShadow: Boolean); override;
    function UsesSameWidth: Boolean; override;
  public
    property EditControl: TEdit read FEditControl;
  end;

  { TppTBVisibilityToggleItem }

  TppTBVisibilityToggleItem = class(TppTBCustomItem)
  private
    FControl: TControl;
    procedure SetControl(Value: TControl);
    procedure UpdateProps;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure Click; override;
    procedure InitiateAction; override;
  published
    property Caption;
    property Control: TControl read FControl write SetControl;
    property DisplayMode;
    property Enabled;
    property HelpContext;
    property Hint;
    property ImageIndex;
    property Images;
    property InheritOptions;
    property MaskOptions;
    property Options;
    property ShortCut;
    property Visible;

    property OnClick;
    property OnSelect;
  end;
  

implementation

uses
  ppTB2Common,
  ppTB2Consts;

const
  EditMenuTextMargin = 3;
  EditMenuMidWidth = 4;

type
  TControlAccess = class(TControl);
  TEditAccess = class(TEdit);


{ TppTBEditAction }

constructor TppTBEditAction.Create(AOwner: TComponent);
begin
  inherited;
  FEditOptions := EditItemDefaultEditOptions;
  FEditWidth := EditItemDefaultEditWidth;
  DisableIfNoHandler := False;
end;

procedure TppTBEditAction.SetEditCaption(Value: String);
var
  I: Integer;
begin
  if FEditCaption <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TppTBEditItemActionLink then
        TppTBEditItemActionLink(FClients[I]).SetEditCaption(Value);
    FEditCaption := Value;
    Change;
  end;
end;

procedure TppTBEditAction.SetEditOptions(Value: TppTBEditItemOptions);
var
  I: Integer;
begin
  if FEditOptions <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TppTBEditItemActionLink then
        TppTBEditItemActionLink(FClients[I]).SetEditOptions(Value);
    FEditOptions := Value;
    Change;
  end;
end;

procedure TppTBEditAction.SetEditWidth(Value: Integer);
var
  I: Integer;
begin
  if FEditWidth <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TppTBEditItemActionLink then
        TppTBEditItemActionLink(FClients[I]).SetEditWidth(Value);
    FEditWidth := Value;
    Change;
  end;
end;

procedure TppTBEditAction.SetOnAcceptText(Value: TppTBAcceptTextEvent);
var
  I: Integer;
begin
  if not MethodsEqual(TMethod(FOnAcceptText), TMethod(Value)) then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TppTBEditItemActionLink then
        TppTBEditItemActionLink(FClients[I]).SetOnAcceptText(Value);
    FOnAcceptText := Value;
    Change;
  end;
end;

procedure TppTBEditAction.SetText(Value: String);
var
  I: Integer;
begin
  if FText <> Value then begin
    for I := 0 to FClients.Count - 1 do
      if TBasicActionLink(FClients[I]) is TppTBEditItemActionLink then
        TppTBEditItemActionLink(FClients[I]).SetText(Value);
    FText := Value;
    Change;
  end;
end;


{ TppTBEditItemActionLink }

procedure TppTBEditItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := AClient as TppTBEditItem;
end;

function TppTBEditItemActionLink.IsEditCaptionLinked: Boolean;
begin
  if Action is TppTBEditAction then
    Result := TppTBEditItem(FClient).EditCaption = TppTBEditAction(Action).EditCaption
  else
    Result := False;
end;

function TppTBEditItemActionLink.IsEditOptionsLinked: Boolean;
begin
  if Action is TppTBEditAction then
    Result := TppTBEditItem(FClient).EditOptions = TppTBEditAction(Action).EditOptions
  else
    Result := False;
end;

function TppTBEditItemActionLink.IsEditWidthLinked: Boolean;
begin
  if Action is TppTBEditAction then
    Result := TppTBEditItem(FClient).EditWidth = TppTBEditAction(Action).EditWidth
  else
    Result := False;
end;

function TppTBEditItemActionLink.IsOnAcceptTextLinked: Boolean;
begin
  if Action is TppTBEditAction then
    Result := MethodsEqual(TMethod(TppTBEditItem(FClient).OnAcceptText),
      TMethod(TppTBEditAction(Action).OnAcceptText))
  else
    Result := False;
end;

function TppTBEditItemActionLink.IsTextLinked: Boolean;
begin
  if Action is TppTBEditAction then
    Result := TppTBEditItem(FClient).Text = TppTBEditAction(Action).Text
  else
    Result := False;
end;

procedure TppTBEditItemActionLink.SetEditCaption(const Value: String);
begin
  if IsEditCaptionLinked then TppTBEditItem(FClient).EditCaption := Value;
end;

procedure TppTBEditItemActionLink.SetEditOptions(Value: TppTBEditItemOptions);
begin
  if IsEditOptionsLinked then TppTBEditItem(FClient).EditOptions := Value;
end;

procedure TppTBEditItemActionLink.SetEditWidth(const Value: Integer);
begin
  if IsEditWidthLinked then TppTBEditItem(FClient).EditWidth := Value;
end;

procedure TppTBEditItemActionLink.SetOnAcceptText(Value: TppTBAcceptTextEvent);
begin
  if IsOnAcceptTextLinked then TppTBEditItem(FClient).OnAcceptText := Value;
end;

procedure TppTBEditItemActionLink.SetText(const Value: String);
begin
  if IsTextLinked then TppTBEditItem(FClient).SetTextEx(Value , tcrActionLink);
end;


{ TppTBEditItem }

constructor TppTBEditItem.Create(AOwner: TComponent);
begin
  inherited;
  FEditOptions := EditItemDefaultEditOptions;
  FEditWidth := EditItemDefaultEditWidth;
end;

procedure TppTBEditItem.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited;
  if Action is TppTBEditAction then
    with TppTBEditAction(Sender) do
    begin
      if not CheckDefaults or (Self.EditCaption = '') then
        Self.EditCaption := EditCaption;
      if not CheckDefaults or (Self.EditOptions = []) then
        Self.EditOptions := EditOptions;
      if not CheckDefaults or (Self.Text = '') then
        Self.SetTextEx(Text, tcrActionLink);
      if not CheckDefaults or not Assigned(Self.OnAcceptText) then
        Self.OnAcceptText := OnAcceptText;
    end;
end;

function TppTBEditItem.GetActionLinkClass: TppTBCustomItemActionLinkClass;
begin
  Result := TppTBEditItemActionLink;
end;

function TppTBEditItem.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  if not(tboUseEditWhenVertical in EditOptions) and
     (AView.Orientation = tbvoVertical) then
    Result := inherited GetItemViewerClass(AView)
  else
    Result := TppTBEditItemViewer;
end;

function TppTBEditItem.NeedToRecreateViewer(AViewer: TppTBItemViewer): Boolean;
begin
  Result := GetItemViewerClass(AViewer.View) <> AViewer.ClassType;
end;

procedure TppTBEditItem.Clear;
begin
  Text := '';
end;

procedure TppTBEditItem.Click;
begin
  inherited;
end;

procedure TppTBEditItem.DoBeginEdit(Viewer: TppTBEditItemViewer);
begin
  if Assigned(FOnBeginEdit) then
    FOnBeginEdit(Self, Viewer, Viewer.EditControl);
end;

function TppTBEditItem.IsEditOptionsStored: Boolean;
begin
  Result := (EditOptions <> EditItemDefaultEditOptions) and
    ((ActionLink = nil) or not(ActionLink is TppTBEditItemActionLink) or
     not TppTBEditItemActionLink(ActionLink).IsEditOptionsLinked);
end;

function TppTBEditItem.IsEditCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not(ActionLink is TppTBEditItemActionLink) or
    not TppTBEditItemActionLink(ActionLink).IsEditCaptionLinked;
end;

function TppTBEditItem.IsEditWidthStored: Boolean;
begin
  Result := (EditWidth <> EditItemDefaultEditWidth) and
    ((ActionLink = nil) or not(ActionLink is TppTBEditItemActionLink) or
     not TppTBEditItemActionLink(ActionLink).IsEditWidthLinked);
end;

function TppTBEditItem.IsTextStored: Boolean;
begin
  Result := (ActionLink = nil) or not(ActionLink is TppTBEditItemActionLink) or
    not TppTBEditItemActionLink(ActionLink).IsTextLinked;
end;

procedure TppTBEditItem.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then begin
    FCharCase := Value;
    Text := Text;  { update case }
  end;
end;

procedure TppTBEditItem.SetEditOptions(Value: TppTBEditItemOptions);
begin
  if FEditOptions <> Value then begin
    FEditOptions := Value;
    Change(True);
  end;
end;

procedure TppTBEditItem.SetEditCaption(Value: String);
begin
  if FEditCaption <> Value then begin
    FEditCaption := Value;
    Change(True);
  end;
end;

procedure TppTBEditItem.SetEditWidth(Value: Integer);
begin
  if FEditWidth <> Value then begin
    FEditWidth := Value;
    Change(True);
  end;
end;

procedure TppTBEditItem.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then begin
    FMaxLength := Value;
    Change(False);
  end;
end;

function TppTBEditItem.DoAcceptText(var NewText: string): Boolean;
begin
  Result := True;
  if Assigned(FOnAcceptText) then FOnAcceptText(Self, NewText, Result);
end;

procedure TppTBEditItem.DoTextChanging(const OldText: String; var NewText: String; Reason: Integer);
begin
  case FCharCase of
    ecUpperCase: NewText := AnsiUpperCase(NewText);
    ecLowerCase: NewText := AnsiLowerCase(NewText);
  end;
end;

procedure TppTBEditItem.DoTextChanged(Reason: Integer);
begin
end;

procedure TppTBEditItem.SetText(Value: String);
begin
  DoTextChanging(FText, Value, tcrSetProperty);
  if FText <> Value then begin
    FText := Value;
    Change(False);
    DoTextChanged(tcrSetProperty);
  end;
end;

procedure TppTBEditItem.SetTextEx(Value: String; Reason: Integer);
begin
  DoTextChanging(FText, Value, Reason);
  if FText <> Value then begin
    FText := Value;
    Change(False);
    DoTextChanged(Reason);
  end;
end;


{ TppTBEditItemViewer }

procedure TppTBEditItemViewer.EditWndProc(var Message: TMessage);
var
  Item: TppTBEditItem;

  procedure AcceptText;
  var
    S: String;
  begin
    S := FEditControl.Text;
    if Item.DoAcceptText(S) then Item.SetTextEx(S, tcrEditControl);
  end;

begin
  Item := TppTBEditItem(Self.Item);
  if FEditControl = nil then
    Exit;
  if Message.Msg = WM_CHAR then
    case TWMChar(Message).CharCode of
      VK_TAB: begin
          FEditControlStatus := [ecsAccept];
          AcceptText;
          Exit;
        end;
      VK_RETURN: begin
          FEditControlStatus := [ecsAccept, ecsClose];
          AcceptText;
          Exit;
        end;
      VK_ESCAPE: begin
          FEditControlStatus := [];
          Exit;
        end;
    end;
  TEditAccess(FEditControl).WndProc(Message);
end;

function TppTBEditItemViewer.GetEditControlClass: TEditClass;
begin
  Result := TEdit;
end;

procedure TppTBEditItemViewer.GetEditRect(var R: TRect);
var
  Item: TppTBEditItem;
  DC: HDC;
begin
  Item := TppTBEditItem(Self.Item);
  DC := GetDC(0);
  try
    SelectObject(DC, View.GetFont.Handle);
    R := BoundsRect;
    if not View.IsToolbar and (Item.EditCaption <> '') then begin
      Inc(R.Left, GetTextWidth(DC, Item.EditCaption, True) +
        EditMenuMidWidth + EditMenuTextMargin * 2);
    end;
  finally
    ReleaseDC(0, DC);
  end;
end;

procedure TppTBEditItemViewer.CalcSize(const Canvas: TCanvas;
  var AWidth, AHeight: Integer);
var
  Item: TppTBEditItem;
  DC: HDC;
  TextHeight, MinHeight: Integer;
begin
  Item := TppTBEditItem(Self.Item);
  DC := Canvas.Handle;
  TextHeight := GetTextHeight(DC);
  AWidth := Item.FEditWidth;
  AHeight := TextHeight;
  if not IsToolbarStyle and (Item.EditCaption <> '') then begin
    Inc(AWidth, GetTextWidth(DC, Item.EditCaption, True) + EditMenuMidWidth +
      EditMenuTextMargin * 2);
  end;
  MinHeight := AHeight + (EditMenuTextMargin * 2) + 1;
  if not IsToolbarStyle then
    Inc(AHeight, DivRoundUp(AHeight, 4));
  if AHeight < MinHeight then
    AHeight := MinHeight;
end;

function TppTBEditItemViewer.CaptionShown: Boolean;
begin
  Result := not IsToolbarStyle and inherited CaptionShown;
end;

function TppTBEditItemViewer.GetCaptionText: String;
begin
  Result := TppTBEditItem(Item).EditCaption;
end;

procedure TppTBEditItemViewer.Paint(const Canvas: TCanvas;
  const ClientAreaRect: TRect; IsSelected, IsPushed, UseDisabledShadow: Boolean);
const
  FillColors: array[Boolean] of TColor = (clBtnFace, clWindow);
  TextColors: array[Boolean] of TColor = (clGrayText, clWindowText);
var
  Item: TppTBEditItem;
  S: String;
  R: TRect;
  W: Integer;
begin
  Item := TppTBEditItem(Self.Item);
  R := ClientAreaRect;

  { Caption }
  if not IsToolbarStyle and (Item.EditCaption <> '') then begin
    S := Item.EditCaption;
    W := GetTextWidth(Canvas.Handle, S, True) + EditMenuTextMargin * 2;
    R.Right := R.Left + W;
    if IsSelected then
      Canvas.FillRect(R);
    Inc(R.Left, EditMenuTextMargin);
    DrawItemCaption(Canvas, R, S, UseDisabledShadow, DT_SINGLELINE or
      DT_LEFT or DT_VCENTER);
    R := ClientAreaRect;
    Inc(R.Left, W + EditMenuMidWidth);
  end;

  { Border }
  if IsSelected and Item.Enabled then
    DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
  InflateRect(R, -1, -1);
  Canvas.Brush.Color := FillColors[not Item.Enabled];
  Canvas.FrameRect(R);
  InflateRect(R, -1, -1);

  { Fill }
  Canvas.Brush.Color := FillColors[Item.Enabled];
  Canvas.FillRect(R);
  InflateRect(R, -1, -1);

  { Text }
  if Item.Text <> '' then begin
    S := Item.Text;
    Canvas.Brush.Style := bsClear;  { speed optimization }
    Canvas.Font.Color := TextColors[Item.Enabled];
    DrawText(Canvas.Handle, PChar(S), Length(S), R, DT_SINGLELINE or DT_NOPREFIX);
  end;
end;

procedure TppTBEditItemViewer.GetCursor(const Pt: TPoint; var ACursor: HCURSOR);
var
  R: TRect;
begin
  if not Item.Enabled then
    Exit;
  GetEditRect(R);
  OffsetRect(R, -BoundsRect.Left, -BoundsRect.Top);
  InflateRect(R, -2, -2);
  if PtInRect(R, Pt) then
    ACursor := LoadCursor(0, IDC_IBEAM);
end;

function TppTBEditItemViewer.EditLoop(const CapHandle: HWND): Boolean;

  procedure ControlMessageLoop;

    function PointInWindow(const Wnd: HWND; const P: TPoint): Boolean;
    var
      W: HWND;
    begin
      Result := False;
      W := WindowFromPoint(P);
      if W = 0 then Exit;
      if W = Wnd then
        Result := True
      else
        if IsChild(Wnd, W) then
          Result := True;
    end;

    function ContinueLoop: Boolean;
    begin
      Result := (ecsContinueLoop in FEditControlStatus) and
        FEditControl.Focused and Item.Enabled;
    end;

  var
    FirstLoop: Boolean;
    Msg: TMsg;
    IsKeypadDigit: Boolean;
    V: Integer;
  begin
    try
      FirstLoop := True;
      while ContinueLoop do begin
        if not FirstLoop then
          WaitMessage;
        FirstLoop := False;
        while ContinueLoop and PeekMessage(Msg, 0, 0, 0, PM_NOREMOVE) do begin
          case Msg.message of
            WM_SYSKEYDOWN: begin
                { Exit immediately if Alt+[key] or F10 are pressed, but not
                  Alt+Shift, Alt+`, or Alt+[keypad digit] }
                if (Msg.wParam <> VK_MENU) and (Msg.wParam <> VK_SHIFT) and
                   (Msg.wParam <> VK_HANJA) then begin
                  IsKeypadDigit := False;
                  { This detect digits regardless of whether Num Lock is on: }
                  if Lo(LongRec(Msg.lParam).Hi) <> 0 then
                    for V := VK_NUMPAD0 to VK_NUMPAD9 do
                      if MapVirtualKey(V, 0) = Lo(LongRec(Msg.lParam).Hi) then begin
                        IsKeypadDigit := True;
                        Break;
                      end;
                  if not IsKeypadDigit then begin
                    FEditControlStatus := [ecsClose];
                    Exit;
                  end;
                end;
              end;
            WM_SYSKEYUP: begin
                { Exit when Alt is released by itself }
                if Msg.wParam = VK_MENU then begin
                  FEditControlStatus := [ecsClose];
                  Exit;
                end;
              end;
            WM_LBUTTONDOWN..WM_MBUTTONDBLCLK,
            WM_NCLBUTTONDOWN..WM_NCMBUTTONDBLCLK: begin
                if Msg.hwnd <> FEditControl.Handle then
                  Exit;
              end;
            WM_MOUSEMOVE, WM_NCMOUSEMOVE: begin
                if GetCapture = CapHandle then begin
                  if PointInWindow(FEditControl.Handle, Msg.pt) then
                    ReleaseCapture;
                end
                else if GetCapture = 0 then begin
                  if not PointInWindow(FEditControl.Handle, Msg.pt) then
                    SetCapture(CapHandle);
                end;
                if GetCapture = CapHandle then
                  SetCursor(LoadCursor(0, IDC_ARROW));
              end;
          end;
          if PeekMessage(Msg, 0, 0, 0, PM_REMOVE or PM_NOYIELD) then begin
            if ((Msg.message >= WM_MOUSEFIRST) and (Msg.message <= WM_MOUSELAST)) and
               (Msg.hwnd = CapHandle) then
              { discard, so that the selection doesn't get changed }
            else begin
              TranslateMessage(Msg);
              DispatchMessage(Msg);
            end;
          end;
        end;
      end;
    finally
      { Make sure there are no outstanding WM_*CHAR messages }
      RemoveMessages(WM_CHAR, WM_DEADCHAR);
      RemoveMessages(WM_SYSCHAR, WM_SYSDEADCHAR);
    end;
  end;

var
  Item: TppTBEditItem;
  R: TRect;
  ActiveWnd, FocusWnd: HWND;
  S: string;
begin
  Item := TppTBEditItem(Self.Item);
  GetEditRect(R);
  if IsRectEmpty(R) then begin
    Result := False;
    Exit;
  end;

  ActiveWnd := GetActiveWindow;
  FocusWnd := GetFocus;

  { Create the edit control }
  InflateRect(R, -3, -3);
  //View.FreeNotification (Self);
  FEditControl := GetEditControlClass.Create(nil);
  try
    FEditControl.Name := Format('%s_edit_control_%p', [ClassName,
      Pointer(FEditControl)]);
    FEditControl.Visible := False;
    FEditControl.BorderStyle := bsNone;
    FEditControl.AutoSize := False;
    FEditControl.Font.Assign(View.GetFont);
    FEditControl.Text := Item.Text;
    FEditControl.CharCase := Item.FCharCase;
    FEditControl.MaxLength := Item.FMaxLength;
    FEditControl.BoundsRect := R;
    FEditControl.WindowProc := EditWndProc;
    FEditControl.ParentWindow := View.Window.Handle;
    FEditControl.SelectAll;
    Item.DoBeginEdit(Self);
    FEditControl.Visible := True;
    FEditControl.SetFocus;
    if GetActiveWindow <> ActiveWnd then
      { don't gray out title bar of old active window }
      SendMessage(ActiveWnd, WM_NCACTIVATE, 1, 0)
    else
      ActiveWnd := 0;

    FEditControlStatus := [ecsContinueLoop];
    ControlMessageLoop;
  finally
    S := FEditControl.Text;
    FreeAndNil(FEditControl);
  end;

  with TppTBEditItem(Item) do
  if (FEditControlStatus = [ecsContinueLoop]) and ExtendedAccept then
    if DoAcceptText(S) then SetTextEx(S, tcrEditControl);

  { ensure the area underneath the edit control is repainted immediately }
  View.Window.Update;
  { If app is still active, set focus to previous control and restore capture
    to CapHandle if another control hasn't taken it }
  if GetActiveWindow <> 0 then begin
    SetFocus(FocusWnd);
    if GetCapture = 0 then
      SetCapture(CapHandle);
  end;
  if ActiveWnd <> 0 then
    SendMessage(ActiveWnd, WM_NCACTIVATE, Ord(GetActiveWindow = ActiveWnd), 0);
  { The SetFocus call above can change the Z order of windows. If the parent
    window is a popup window, reassert its topmostness. }
  if View.Window is TppTBPopupWindow then
    SetWindowPos(View.Window.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  { Send an MSAA "focus" event now that we're returning to the regular modal loop }
  View.NotifyFocusEvent;

  Result := ecsClose in FEditControlStatus;
  if not Result and (GetCapture = CapHandle) then begin
    if ecsAccept in FEditControlStatus then
      { if we are accepting but not closing, Tab must have been pressed }
      View.Selected := View.NextSelectable(View.Selected,
        GetKeyState(VK_SHIFT) >= 0);
  end;
end;

function TppTBEditItemViewer.DoExecute: Boolean;
begin
  { Close any delay-close popup menus before entering the edit loop }
  View.CancelChildPopups;
  Result := False;
  if EditLoop(View.GetCaptureWnd) then begin
    View.EndModal;
    if ecsAccept in FEditControlStatus then
      Result := True;
  end;
end;

procedure TppTBEditItemViewer.MouseBeginEdit;
begin
  if Item.Enabled then
    Execute(True)
  else begin
    if (View.ParentView = nil) and not View.IsPopup then
      View.EndModal;
  end;
end;

procedure TppTBEditItemViewer.MouseDown(Shift: TShiftState; X, Y: Integer;
  var MouseDownOnMenu: Boolean);
begin
  if IsPtInButtonPart(X, Y) then  { for TBX... }
    MouseBeginEdit
  else
    inherited;
end;

procedure TppTBEditItemViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
begin
  if IsPtInButtonPart(X, Y) then  { for TBX... }
    MouseBeginEdit
  else
    inherited;
end;

function TppTBEditItemViewer.UsesSameWidth: Boolean;
begin
  Result := False;
end;

function TppTBEditItemViewer.GetAccRole: Integer;
const
  ROLE_SYSTEM_TEXT = $2a;  { from OleAcc.h }
begin
  Result := ROLE_SYSTEM_TEXT;
end;

function TppTBEditItemViewer.GetAccValue(var Value: WideString): Boolean;
begin
  Value := TppTBEditItem(Item).Text;
  Result := True;
end;


{ TppTBToolbarVisibilityItem }

procedure TppTBVisibilityToggleItem.Click;
begin
  if Assigned(FControl) then
    FControl.Visible := not FControl.Visible;
  inherited;
end;

procedure TppTBVisibilityToggleItem.InitiateAction;
begin
  UpdateProps;
end;

procedure TppTBVisibilityToggleItem.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
    Control := nil;
end;

procedure TppTBVisibilityToggleItem.SetControl(Value: TControl);
begin
  if FControl <> Value then begin
    FControl := Value;
    if Assigned(Value) then begin
      Value.FreeNotification(Self);
      if (Caption = '') and not(csLoading in ComponentState) then
        Caption := TControlAccess(Value).Caption;
    end;
    UpdateProps;
  end;
end;

procedure TppTBVisibilityToggleItem.UpdateProps;
begin
  if (ComponentState * [csDesigning, csLoading, csDestroying] = []) then
    Checked := Assigned(FControl) and FControl.Visible;
end;

end.
