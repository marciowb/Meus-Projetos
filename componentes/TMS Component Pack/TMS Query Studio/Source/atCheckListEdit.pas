{********************************************************************}
{ TatCheckListEdit component                                           }
{ for Delphi  & C++Builder                                           }
{ version 1.2                                                        }
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 1999-2004                                   }
{            Email : info@tmssoftware.com                            }
{            Web : http://www.tmssoftware.com                        }
{                                                                    }
{ The source code is given as is. The author is not responsible      }
{ for any possible damage done due to the use of this code.          }
{ The component can be freely used in any application. The source    }
{ code remains property of the author and may not be distributed     }
{ freely as such.                                                    }
{********************************************************************}

unit atCheckListEdit;

{$I TMSDEFS.INC}

interface


uses Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils,
  Forms, Graphics, Buttons, CheckLst

  {$IFDEF TMSDOTNET}
  , WinUtils, Types
  {$ENDIF}
  ;

const
  CL_CHECKED = $8;
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 2; // Minor version nr.
  REL_VER = 0; // Release nr.
  BLD_VER = 0; // Build nr.


type
  TatCheckListEdit = class;

{TatDropForm}
  TatDropForm = class(TForm)
  private
    procedure WMClose(var Msg: TMessage); message WM_CLOSE;
  end;

{TatIntList}
  TatIntList = class(TList)
  private
    procedure SetInteger(Index: Integer; Value: Integer);
    function GetInteger(Index: Integer): Integer;
  public
    constructor Create;
    property Items[index: Integer]: Integer read GetInteger write SetInteger; default;
    procedure Add(Value: integer);
    procedure Delete(Index: Integer);
  end;

{TatInplaceCheckListBox}

  TatInplaceCheckListBox = class(TCheckListBox)
  private
    fParentEdit: TatCheckListEdit;
    procedure WMKeyDown(var Msg: TWMKeydown); message wm_keydown;
  protected
    procedure DoExit; override;
    function GetDropDownWidth: Integer;
    property ParentEdit: TatCheckListEdit read fParentEdit write fParentEdit;
  end;

{ TatDropCheckListButton }
  TatDropCheckListButton = class(TSpeedButton)
  private
    FFocusControl: TWinControl;
    FMouseClick: TNotifyEvent;
    {$IFNDEF TMSDOTNET}
    procedure WMLButtonDown(var Msg: TMessage); message WM_LBUTTONDOWN;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    {$ENDIF}
  protected
    procedure Paint; override;
  public
    procedure Click; override;
    constructor Create(AOwner: TComponent); override;
  published
    property FocusControl: TWinControl read FFocusControl write FFocusControl;
    property MouseClick: TNotifyEvent read FMouseClick write FMouseClick;
  end;

  TatCheckListItemToText = procedure(sender: TObject; var aText: string) of object;
  TatTextToCheckListItem = procedure(sender: TObject; var aItem: string) of object;

  TatDropDirection = (ddDown, ddUp);


{ TatCheckListEdit }

  TatCheckListEdit = class(TCustomEdit)
  private
    FButton: TatDropCheckListButton;
    FEditorEnabled: Boolean;
    FOnClickBtn: TNotifyEvent;
    FCheckListBox: TatInplaceCheckListBox;
    {$IFNDEF TMSDOTNET}
    FItems: TStringList;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    FItems: TStrings;
    {$ENDIF}
    FDropHeight: integer;
    FDropWidth: integer;
    FDropColumns: integer;
    FDropColor: TColor;
    FDropFont: TFont;
    FDropFlat: Boolean;
    FDropSorted: Boolean;
    FDropDirection: TatDropDirection;
    FDroppedDown: Boolean;
    CheckFlag: Boolean;
    FChkForm: TForm;
    FIntList: TatIntList;
    FChkClosed: Boolean;
    FCloseClick: Boolean;
    FTextDelimiter: string;
    FTextStartChar: string;
    FTextEndChar: string;
    FOnCheckListItemToText: TatCheckListItemToText;
    FOnTextToCheckListItem: TatTextToCheckListItem;
    FOnClose: TNotifyEvent;
    FAutoDropWidthSize: Boolean;
    FAppNtfy: TNotifyEvent;
    function GetMinHeight: Integer;
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
    procedure WMKeyDown(var Msg: TWMKeydown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Msg: TWMKeydown); message WM_SYSKEYDOWN;
    procedure ItemChange(Sender: TObject);
    procedure CheckClick(Sender: TObject);
    procedure CheckClickCheck(Sender: TObject);
    {$IFNDEF TMSDOTNET}
    procedure SetItems(value: tstringlist);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    procedure SetItems(value: TStrings);
    {$ENDIF}
    function CheckToString: string;
    procedure StringToCheck(s: string);
    procedure ShowCheckList(Focus: boolean);
    procedure HideCheckList;
    function GetCheck(i: integer): boolean;
    procedure SetCheck(i: integer; value: boolean);
    function GetState(i: integer): TCheckBoxState;
    procedure SetState(i: integer; value: TCheckBoxState);
    procedure FormDeactivate(Sender: TObject);
    procedure AppDeactivate(Sender: TObject);
    procedure SetTextDelimiter(const Value: string);
    procedure SetTextEndChar(const Value: string);
    procedure SetTextStartChar(const Value: string);
    procedure MouseClick(Sender: TObject);
    procedure DownClick(Sender: TObject);
    procedure SetDropFont(const Value: TFont);
    function GetText: string;
    procedure SetText(const Value: string);
    function GetVersion: string;
    procedure SetVersion(const Value: string);
  protected
    function GetVersionNr: Integer; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function GetParentForm(Control: TControl): TCustomForm; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    property Button: TatDropCheckListButton read FButton;
    property Checked[i: Integer]: Boolean read GetCheck write SetCheck;
    property State[i: Integer]: TCheckBoxState read GetState write SetState;
    property Text: string read GetText write SetText;
    property DroppedDown: Boolean read FDroppedDown;
  published
{$IFDEF DELPHI4_LVL}
    property Anchors;
    property Constraints;
    property DragKind;
{$ENDIF}
    property AutoSelect;
    property AutoSize;
    property AutoDropWidthSize: Boolean read FAutoDropWidthSize write FAutoDropWidthSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Height;
    property Width;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF DELPHI4_LVL}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
    {$IFNDEF TMSDOTNET}
    property Items: TStringList read FItems write SetItems;
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    property Items: TStrings read FItems write SetItems;
    {$ENDIF}
    property DropWidth: integer read FDropWidth write fDropWidth;
    property DropHeight: integer read FDropHeight write fDropHeight;
    property DropColumns: integer read FDropColumns write fDropColumns;
    property DropColor: tColor read FDropColor write fDropColor;
{$IFDEF DELPHI4_LVL}
    property DropFlat: boolean read FDropFlat write fDropFlat;
{$ENDIF}
    property DropFont: TFont read FDropFont write SetDropFont;
    property DropDirection: TatDropDirection read FDropDirection write FDropDirection;
    property DropSorted: boolean read fDropSorted write fDropSorted;

    property TextDelimiter: string read fTextDelimiter write SetTextDelimiter nodefault;
    property TextEndChar: string read fTextEndChar write SetTextEndChar nodefault;
    property TextStartChar: string read fTextStartChar write SetTextStartChar nodefault;

    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnClickBtn: TNotifyEvent read FOnClickBtn write FOnClickBtn;
    property OnTextToCheckListItem: TatTextToCheckListItem read FOnTextToCheckListItem write FOnTextToCheckListItem;
    property OnCheckListItemToText: TatCheckListItemToText read FOnCheckListItemToText write FOnCheckListItemToText;
    property Version: string read GetVersion write SetVersion;
  end;

procedure Register;

implementation

uses
  qsRes;
  
{$R atCheckListEdit.res}

procedure Register;
begin
  RegisterComponents('TMS Query Studio', [TatCheckListEdit]);
end;

{ TatDropCheckListButton }

constructor TatDropCheckListButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Cursor := crArrow;
  Glyph.Handle := LoadBitmap(HInstance, 'ATARROW_DOWN');
end;

procedure TatDropCheckListButton.Paint;
begin
  inherited Paint;
end;

procedure TatDropCheckListButton.Click;
begin
  if (FFocusControl <> nil) and FFocusControl.CanFocus and (GetFocus <> FFocusControl.Handle) then
    FFocusControl.SetFocus;
  inherited Click;
end;

{$IFNDEF TMSDOTNET}
procedure TatDropCheckListButton.WMLButtonDown(var Msg: TMessage);
{$ENDIF}
{$IFDEF TMSDOTNET}
procedure TatDropCheckListButton.WMLButtonDown(var Msg: TWMLButtonDown);
{$ENDIF}
begin
  if assigned(FMouseClick) then FMouseClick(self);
  inherited;
end;

{ TatCheckListEdit }

constructor TatCheckListEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TatDropCheckListButton.Create(Self);
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.MouseClick := MouseClick;
  FButton.OnClick := DownClick;
  Text := '[]';
  ControlStyle := ControlStyle - [csSetCaption];
  FEditorEnabled := True;
  FCheckListBox := nil;
  FItems := TStringList.Create;
  {$IFNDEF TMSDOTNET}
  FItems.OnChange := ItemChange;
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  TStringList(FItems).OnChange := ItemChange;
  {$ENDIF}
  FDropHeight := 100;
  FDropWidth := self.Width;
  FDropSorted := False;
  FDropFlat := True;
  FDropColor := clWindow;
  FDropFont := TFont.Create;
  FIntList := TatIntList.Create;
  FChkClosed := True;
  FTextStartChar := '[';
  FTextEndChar := ']';
  FTextDelimiter := ',';
  FDroppedDown := False;
end;

destructor TatCheckListEdit.Destroy;
begin
  FButton.Free;
  FItems.Free;
  FIntList.Free;
  FDropFont.Free;
  inherited Destroy;
end;

function TatCheckListEdit.GetParentForm(Control: TControl): TCustomForm;
begin
  Result := nil;
  if Assigned(Control) then
    if Control is TCustomForm then
    begin
      Result := Control as TCustomForm;
      Exit;
    end else
    begin
      if Assigned(Control.Parent) then
        Result := GetParentForm(Control.Parent);
    end;
end;

procedure TatCheckListEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TatCheckListEdit.DestroyWnd;
begin
  inherited;
end;

procedure TatCheckListEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
  self.ReadOnly := true;
end;

procedure QuickSortList(List: TStringList; IntList: TatIntList; left, right: integer);
var
  i, j, si: integer;
  s, sw: string;
  so: TObject;

begin
  i := left;
  j := right;

 {get middle item here}
  s := List.Strings[(left + right) shr 1];

  repeat
    {$IFNDEF TMSDOTNET}
    while (AnsiStrComp(pchar(s), pchar(List.Strings[i])) > 0) and (i < right) do inc(i);
    while (AnsiStrComp(pchar(s), pchar(List.Strings[j])) < 0) and (j > left) do dec(j);
    {$ENDIF}
    {$IFDEF TMSDOTNET}
    while (AnsiCompareStr(s, List.Strings[i]) > 0) and (i < right) do inc(i);
    while (AnsiCompareStr(s, List.Strings[j]) < 0) and (j > left) do dec(j);
    {$ENDIF}

    if (i <= j) then
    begin
      if (i <> j) then
      begin
        {$IFNDEF TMSDOTNET}
        if AnsiStrComp(pchar(List.Strings[i]), pchar(List.Strings[j])) <> 0 then
        {$ENDIF}
        {$IFDEF TMSDOTNET}
        if AnsiCompareStr(List.Strings[i], List.Strings[j]) <> 0 then
        {$ENDIF}
        begin
          sw := List.Strings[i];
          so := List.Objects[i];

          si := IntList.Items[i];

          List.Strings[i] := List.Strings[j];
          List.Objects[i] := List.Objects[j];
          IntList.Items[i] := IntList.Items[j];
          List.Strings[j] := sw;
          List.Objects[j] := so;
          IntList.Items[j] := si;
        end;
      end;
      inc(i);
      dec(j);
    end;
  until (i > j);

  if (left < j) then QuicksortList(List, IntList, left, j);
  if (i < right) then QuickSortList(List, IntList, i, right);
end;


procedure TatCheckListEdit.ShowCheckList(focus: boolean);
var
  P: TPoint;
  FOldDropDirection: TatDropDirection;
  i: integer;

begin
  FOldDropDirection := FDropDirection;

  P := Point(0, 0);
  P := Self.ClientToScreen(P);

  if P.y + FDropHeight >= GetSystemMetrics(SM_CYSCREEN) then
    FDropDirection := ddUp;

  if P.y - FDropHeight <= 0 then
    FDropDirection := ddDown;

{$IFDEF DELPHI4_LVL}
  FChkForm := TatDropForm.CreateNew(self, 0);
{$ELSE}
  FChkForm := TatDropForm.CreateNew(self);
{$ENDIF}
  FChkForm.BorderStyle := bsNone;
  FChkForm.FormStyle := fsStayOnTop;
  FChkForm.Visible := False;
  FChkForm.Width := FDropWidth;
  FChkForm.Height := FDropHeight;
  FChkForm.OnDeactivate := FormDeactivate;

  FCheckListBox := TatInplaceCheckListBox.Create(FChkForm);
  FCheckListBox.Parent := FChkForm;
  FCheckListBox.Left := 0;
  FCheckListBox.Top := 0;
  FCheckListBox.Align := alClient;
  FCheckListBox.Width := FDropWidth;
  FCheckListBox.Height := FDropHeight;
  FCheckListBox.Color := FDropColor;
  FCheckListBox.Columns := FDropColumns;
{$IFDEF DELPHI4_LVL}
  FCheckListBox.Flat := fDropFlat;
{$ENDIF}
  FCheckListBox.Font.Assign(FDropFont);
  FCheckListBox.Sorted := FDropSorted;

  {$IFNDEF TMSDOTNET}
  if fDropSorted then QuickSortList(Items, fIntList, 0, self.items.Count - 1);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  if fDropSorted then QuickSortList(TStringList(Items), fIntList, 0, self.items.Count - 1);
  {$ENDIF}


  FCheckListBox.Font.Assign(fDropFont);
  FCheckListBox.Items.Assign(self.Items);

  if FAutoDropWidthSize then
    FChkForm.Width := FCheckListBox.GetDropDownWidth;

  for i := 1 to fIntList.Count do
  begin
    FChecklistbox.Checked[i - 1] := fIntList.Items[i - 1] and CL_CHECKED = CL_CHECKED;
    case fIntList.Items[i - 1] and $3 of
      1: FChecklistbox.State[i - 1] := cbChecked;
      2: FChecklistbox.State[i - 1] := cbGrayed;
    end;
  end;

  FCheckListBox.Ctl3D := false;
  FCheckListBox.OnClick := CheckClick;
  FCheckListBox.OnClickCheck := CheckClickCheck;
  FCheckListBox.ParentEdit := self;

  StringToCheck(self.Text);
  FCheckListBox.Visible := true;


  FCheckListBox.ItemIndex := 0;
  FCheckListBox.TabStop := true;

  P := Point(0, 0);
  P := ClientToScreen(P);

  if P.x + FChkForm.Width > GetSystemMetrics(SM_CXSCREEN) then
    FChkForm.Left := GetSystemMetrics(SM_CXSCREEN) - FChkForm.Width
  else
  FChkForm.Left := P.x;

  if (FDropDirection = ddDown) then
    FChkForm.Top := P.y + self.Height
  else
    FChkForm.Top := P.y - fDropHeight;

  FChkForm.Show;

  FAppNtfy := Application.OnDeactivate;

  Application.OnDeactivate := AppDeactivate;

  if Focus then FCheckListBox.SetFocus;

  FCheckListBox.Height := FCheckListBox.Height + 1;
  FCheckListBox.Height := FCheckListBox.Height - 1;

  FDropDirection := fOldDropDirection;

  FChkClosed := False;
  FDroppedDown := True;
end;

procedure TatCheckListEdit.HideCheckList;
begin
  PostMessage(FChkForm.Handle, WM_CLOSE, 0, 0);
  fChkClosed := true;
  Application.OnDeactivate := FAppNtfy;
  FDroppedDown := False;
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TatCheckListEdit.AppDeactivate(Sender: TObject);
begin
  HideCheckList;
end;


procedure TatCheckListEdit.SetEditRect;
var
  Loc: TRect;
begin
  {$IFNDEF TMSDOTNET}
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  Perform(EM_GETRECT, 0, Loc);
  {$ENDIF}
  Loc.Bottom := ClientHeight + 1; {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 3;
  if self.BorderStyle = bsNone then
  begin
    Loc.Top := 2;
    Loc.Left := 2;
  end
  else
  begin
    Loc.Top := 1;
    Loc.Left := 1;
  end;
  {$IFNDEF TMSDOTNET}
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc)); {debug}
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  Perform(EM_SETRECTNP, 0, Loc);
  Perform(EM_GETRECT, 0, Loc); {debug}
  {$ENDIF}
end;

procedure TatCheckListEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
  Dist: integer;
begin
  inherited;
  if BorderStyle = bsNone then Dist := 2 else Dist := 5;

  MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }

  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    if NewStyleControls and Ctl3D then
      FButton.SetBounds(Width - FButton.Width - Dist, 0, FButton.Width, Height - Dist)
    else FButton.SetBounds(Width - FButton.Width, 1, FButton.Width, Height - 3);
    SetEditRect;
  end;
end;

function TatCheckListEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  {Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 +2;}
  Result := Metrics.tmHeight + I div 4 {+ GetSystemMetrics(SM_CYBORDER) * 4};
end;
{
procedure TatCheckListEdit.Click (Sender: TObject);
begin
end;
}

procedure TatCheckListEdit.WMPaste(var Message: TWMPaste);
begin
  Exit;
  inherited;
end;

procedure TatCheckListEdit.WMCut(var Message: TWMPaste);
begin
  Exit;
  inherited;
end;

procedure TatCheckListEdit.CMExit(var Message: TCMExit);
begin
  inherited;
end;

procedure TatCheckListEdit.WMKeyDown(var Msg: TWMKeydown);
begin
  inherited;
  if (msg.CharCode = VK_DOWN) or (msg.CharCode = VK_F4) then
  begin
    ShowCheckList(true);
  end;
end;

procedure TatCheckListEdit.WMSysKeyDown(var Msg: TWMKeydown);
begin
  inherited;
  if (msg.CharCode = VK_DOWN) and (GetKeyState(VK_MENU) and $8000 = $8000) then
    ShowCheckList(true);
end;

procedure TatCheckListEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

procedure TatCheckListEdit.CheckClick(Sender: TObject);
begin
  inherited;
  checkflag := false;
end;

procedure TatCheckListEdit.CheckClickCheck(Sender: TObject);
var
  i: integer;
begin
  checkflag := true;
  for i := 1 to fCheckListBox.Items.Count do
  begin
    if fCheckListBox.Checked[i - 1] then fIntList.Items[i - 1] := fIntList.Items[i - 1] or CL_CHECKED else
      fIntList.Items[i - 1] := fIntList.Items[i - 1] and not CL_CHECKED;
  end;
  self.Text := CheckToString;
end;


procedure TatCheckListEdit.ItemChange(Sender: TObject);
begin
  inherited;

  while fItems.Count > fIntList.Count do fIntList.Add(0);
  while fItems.Count < fIntList.Count do fIntList.Delete(fIntList.Count - 1);
end;

{$IFNDEF TMSDOTNET}
procedure TatCheckListEdit.SetItems(value: tStringList);
begin
  if value <> nil then
    fItems.Assign(value);
end;
{$ENDIF}

{$IFDEF TMSDOTNET}
procedure TatCheckListEdit.SetItems(value: TStrings);
begin
  if value <> nil then
    fItems.Assign(value);
end;
{$ENDIF}

function TatCheckListEdit.CheckToString: string;
var
  i: integer;
  s, sli: string;

begin
  s := fTextStartChar;

  for i := 1 to FIntList.Count do
  begin
    if (FIntList.Items[i - 1] and CL_CHECKED = CL_CHECKED) then
    begin
      sli := FItems[i - 1];
      if assigned(FOnCheckListItemToText) then FOnCheckListItemToText(self, sli);
      s := s + sli + FTextDelimiter;
    end;
  end;

  if (length(s) > 0) then
    if s[length(s)] = FTextDelimiter then delete(s, length(s), 1);

  s := s + fTextEndChar;
  result := s;
end;

procedure TatCheckListEdit.StringToCheck(s: string);
var
  su, sli: string;
  i: integer;
begin
  if not assigned(FItems) then exit;

  if pos(fTextEndChar, s) > 0 then delete(s, pos(fTextEndChar, s), 1);
  if pos(fTextStartChar, s) > 0 then delete(s, pos(fTextStartChar, s), 1);

  for i := 1 to fIntList.Count do
    FIntList.Items[i - 1] := FIntList.Items[i - 1] and not CL_CHECKED;

  while (length(s) > 0) do
  begin
    if (pos(fTextDelimiter, s) > 0) then
      su := copy(s, 1, pos(fTextDelimiter, s) - 1)
    else su := s;

    sli := su;
    if assigned(FOnTextToCheckListItem) then
      FOnTextToCheckListItem(self, sli);

    i := FItems.Indexof(sli);

    if (i >= 0) then FIntList.Items[i] := FIntList.Items[i] or CL_CHECKED;

    delete(s, 1, length(su));
    if length(s) > 0 then delete(s, 1, 1);
  end;
end;

function TatCheckListEdit.GetCheck(i: integer): boolean;
begin
  ItemChange(self);

  if (i >= fItems.Count) or (i >= fIntList.Count) or (i < 0) then
    raise Exception.Create(_str(SIndexOutOfBounds));

  Result := FIntList.Items[i] and CL_CHECKED = CL_CHECKED;
end;

procedure TatCheckListEdit.SetCheck(i: integer; value: boolean);
begin
  ItemChange(self);

  if (i >= fItems.Count) or (i >= fIntList.Count) or (i < 0) then
    raise Exception.Create(_str(SIndexOutOfBounds));

  if value then
    FIntList.Items[i] := FIntList.Items[i] or CL_CHECKED
  else
    FIntList.Items[i] := FIntList.Items[i] and not CL_CHECKED;

  Self.Text := CheckToString;

  if not fchkClosed then
    FChecklistbox.Checked[i] := Value;
end;

function TatCheckListEdit.GetState(i: integer): TCheckBoxState;
begin
  ItemChange(self);

  if (i >= fItems.Count) or (i >= fIntList.Count) or (i < 0) then
    raise Exception.Create(_str(SIndexOutOfBounds));

  case fIntList.Items[i] and $3 of
    0: result := cbUnchecked;
    1: result := cbChecked;
    2: result := cbGrayed;
  else
    result := cbUnchecked;
  end;
end;

procedure TatCheckListEdit.SetState(i: integer; value: TCheckBoxState);
begin
  ItemChange(self);

  if (i >= fItems.Count) or (i >= fIntList.Count) or (i < 0) then
    raise Exception.Create(_str(SIndexOutOfBounds));

  fIntList.Items[i] := fIntList.Items[i] and not $3;

  case value of
    cbChecked: fIntList.Items[i] := fIntList.Items[i] or $1;
    cbGrayed: fIntList.Items[i] := fIntList.Items[i] or $2;
  end;

  self.Text := CheckToString;
end;

procedure TatCheckListEdit.FormDeactivate(Sender: TObject);
var
  pt: TPoint;
  r: TRect;
begin
  {check cursor here...}
  GetCursorPos(pt);
  pt := screentoclient(pt);
  r := clientrect;
  r.left := r.right - 16;
  FCloseClick := ptinrect(r, pt);
  HideCheckList;
end;

procedure TatCheckListEdit.SetTextDelimiter(const Value: string);
begin
  fTextDelimiter := Value;
  if not (csLoading in ComponentState) then self.Text := CheckToString;
end;

procedure TatCheckListEdit.SetTextEndChar(const Value: string);
begin
  FTextEndChar := Value;
  if not (csLoading in ComponentState) then self.Text := CheckToString;
end;

procedure TatCheckListEdit.SetTextStartChar(const Value: string);
begin
  FTextStartChar := Value;
  if not (csLoading in ComponentState) then self.Text := CheckToString;
end;

procedure TatCheckListEdit.Loaded;
begin
  inherited;
  self.Text := CheckToString;
end;

procedure TatCheckListEdit.DownClick(Sender: TObject);
begin
  if FChkClosed then
  begin
    if not FCloseClick then
    begin
      if Assigned(FOnClickBtn) then
        FOnClickBtn(Self);
      ShowCheckList(true);
    end;
  end;
  FCloseClick := False;
end;

procedure TatCheckListEdit.MouseClick(Sender: TObject);
begin
  if not FChkClosed then
  begin
    HideCheckList;
  end;
end;

procedure TatCheckListEdit.SetDropFont(const Value: TFont);
begin
  FDropFont.Assign(Value);
end;

function TatCheckListEdit.GetText: string;
begin
  result := inherited Text;
end;

procedure TatCheckListEdit.SetText(const Value: string);
begin
  inherited Text := value;
  if not (csLoading in ComponentState) then
  begin
    StringToCheck(value);
  end;
end;

function TatCheckListEdit.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TatCheckListEdit.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TatCheckListEdit.SetVersion(const Value: string);
begin

end;

{ TatInplaceCheckListBox }

procedure TatInplaceCheckListBox.WMKeyDown(var Msg: TWMKeydown);
begin
  if (msg.charcode = vk_tab) then Exit;

  if (msg.charcode = vk_escape) or (msg.charcode = vk_F4) or
    ((msg.CharCode = vk_up) and (getkeystate(vk_menu) and $8000 = $8000)) then
  begin
    postmessage((Parent as TForm).Handle, WM_CLOSE, 0, 0);
  end;

  inherited;
end;

procedure TatInplaceCheckListBox.DoExit;
begin
  inherited;
  if Visible then ParentEdit.HideCheckList;
end;


{TatIntList helper object}

constructor TatIntList.Create;
begin
  inherited Create;
end;

procedure TatIntList.SetInteger(Index: Integer; Value: Integer);
begin
  {$IFNDEF TMSDOTNET}
  inherited Items[Index] := Pointer(Value);
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  inherited Items[Index] := TObject(Value);
  {$ENDIF}
end;

function TatIntList.GetInteger(Index: Integer): Integer;
begin
  Result := Integer(inherited Items[Index]);
end;

procedure TatIntList.Add(Value: Integer);
begin
  {$IFNDEF TMSDOTNET}
  inherited Add(Pointer(Value));
  {$ENDIF}
  {$IFDEF TMSDOTNET}
  inherited Add(TObject(Value));
  {$ENDIF}
end;

procedure TatIntList.Delete(Index: Integer);
begin
  inherited Delete(Index);
end;

function TatInplaceCheckListBox.GetDropDownWidth: Integer;
const
  CheckBoxWidth: integer = 15;
var
  i: integer;
  Width, Height: integer;
  MaxWidth: integer;
begin
  MaxWidth := self.Width;
  Height := 0;

  for i := 0 to Items.Count - 1 do
  begin
    Width := CheckBoxWidth + 2 +
      2 * GetSystemMetrics(SM_CXBORDER) + Canvas.TextWidth(Items[i]);

    Height := Height + Self.Canvas.TextHeight(Items[i]);
    if Width > MaxWidth then begin
      MaxWidth := Width;
    end;
  end;

  if Height + 2 * GetSystemMetrics(SM_CYBORDER) > self.Height then
    MaxWidth := MaxWidth + GetSystemMetrics(SM_CXVSCROLL);

  Result := MaxWidth;
end;

{ TatDropForm }

procedure TatDropForm.WMClose(var Msg: TMessage);
begin
  inherited;
  self.Free;
end;

end.
