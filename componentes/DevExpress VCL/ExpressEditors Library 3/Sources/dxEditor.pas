
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express standard inplace editors                            }
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

unit dxEditor;

interface

{$I dxEdVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, Mask, dxCntner{$IFDEF DELPHI4}, ActnList, StdActns{$ENDIF},
  RichEdit, ActiveX, dxUtils{$IFDEF DELPHI6}, MaskUtils, Variants{$ENDIF};

type
  { IRichEditOleCallback }
  IRichEditOleCallback = interface(IUnknown)
    ['{00020D03-0000-0000-C000-000000000046}']
    function GetNewStorage(out stg: IStorage): HResult; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame;
      out Doc: IOleInPlaceUIWindow; lpFrameInfo: POleInPlaceFrameInfo): HResult; stdcall;
    function ShowContainerUI(fShow: BOOL): HResult; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HResult; stdcall;
    function DeleteObject(const oleobj: IOleObject): HResult; stdcall;
    function QueryAcceptData(const dataobj: IDataObject;
      var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
      hMetaPict: HGLOBAL): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataobj: IDataObject): HResult; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HResult; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out menu: HMENU): HResult; stdcall;
  end;

  { TdxInplaceTextEdit }
  TdxTextEditViewData = class(TdxEditViewData)
    CharCase: TEditCharCase;
    EndEllipsis: Boolean;
    PasswordChar: Char;
    SelectionBar: Boolean;
  end;

  TdxInplaceTextEdit = class(TdxInplaceEdit, IUnknown, IRichEditOleCallback)
  private
    FAssigningText: Boolean;
    FAutoSelect: Boolean;
    FCharCase: TEditCharCase;
    FCharCaseChanging: Boolean;
    FCreating: Boolean;
    FEditPopupMenu: TPopupMenu;
    FHideSelection: Boolean;
    FMaxLength: Integer;
    FModified: Boolean;
    FOEMConvert: Boolean;
    FPasswordChar: Char;
    FRefCount: Longint;
    FSelectionBar: Boolean;
    FOnSelectionChange: TNotifyEvent;
    procedure EditPopupMenuClick(Sender: TObject);
    function GetCanPaste: Boolean;
    function GetCanRedo: Boolean;
    function GetCanUndo: Boolean;
    function IsMaxLengthStored: Boolean;
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetHideSelection(Value: Boolean);
    procedure SetMaxLength(Value: Integer);
    procedure SetOEMConvert(Value: Boolean);
    procedure SetPasswordChar(Value: Char);
    procedure SetSelectionBar(Value: Boolean);
    procedure SetSelText(const Value: string);
    // messages
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMContextMenu(var Message: TMessage); message WM_CONTEXTMENU;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
    procedure WMSetText(var Message: TMessage); message WM_SETTEXT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  protected
    // IUnknown
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; {$IFDEF DELPHI4} override; {$ENDIF} stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    // IRichEditOleCallback
    function GetNewStorage(out stg: IStorage): HResult; stdcall;
    function GetInPlaceContext(out Frame: IOleInPlaceFrame;
      out Doc: IOleInPlaceUIWindow; lpFrameInfo: POleInPlaceFrameInfo): HResult; stdcall;
    function ShowContainerUI(fShow: BOOL): HResult; stdcall;
    function QueryInsertObject(const clsid: TCLSID; const stg: IStorage;
      cp: Longint): HResult; stdcall;
    function DeleteObject(const oleobj: IOleObject): HResult; stdcall;
    function QueryAcceptData(const dataobj: IDataObject;
      var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL;
      hMetaPict: HGLOBAL): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    function GetClipboardData(const chrg: TCharRange; reco: DWORD;
      out dataobj: IDataObject): HResult; stdcall;
    function GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
      var dwEffect: DWORD): HResult; stdcall;
    function GetContextMenu(seltype: Word; const oleobj: IOleObject;
      const chrg: TCharRange; out menu: HMENU): HResult; stdcall;
    // Control
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    {$IFNDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    {$ENDIF}
    procedure DestroyWnd; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
    // virtual
    procedure AssignEditProperties; override;
    procedure AssignEditValue(const Value: Variant); override;
    procedure CheckCharCase; virtual;
    function CreateViewData(IsPaintCopy: Boolean): TdxEditViewData; override;
    procedure DoSetMaxLength(Value: Integer); virtual;
    function GetModified: Boolean; override;
    function GetSelLength: Integer; virtual;
    function GetSelStart: Integer; virtual;
    function GetSelText: string; virtual;
    function IsDisableDragDrop: Boolean; virtual;
    procedure SelectionChange; virtual;
    procedure SetEditMaxLength(Value: Integer); virtual;
    procedure SetEditReadOnly(Value: Boolean); override;
    procedure SetModified(Value: Boolean); override;
    procedure SetSelLength(Value: Integer); virtual;
    procedure SetSelStart(Value: Integer); virtual;
    property AssigningText: Boolean read FAssigningText write FAssigningText;
    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default True;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property MaxLength: Integer read FMaxLength write SetMaxLength stored IsMaxLengthStored;
    property OEMConvert: Boolean read FOEMConvert write SetOEMConvert default False; // TODO
    property ParentColor default False;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
    property SelectionBar: Boolean read FSelectionBar write SetSelectionBar default False;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure ClearSelection;
    procedure ClearUndo;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    function DefaultMaxLength: Integer; virtual;
    procedure Deselect; override;
    class function DrawClientArea(ADC: HDC; var ARect: TRect;
      AViewData: TdxEditViewData; IsControl: Boolean): Boolean; override;
    function GetSelection: TCharRange;
    function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer; virtual;
    function GetTextLenEx: Integer;
    class function GetViewDataClass: TdxEditViewDataClass; override;
    function IsEditClass: Boolean; override;
    procedure PasteFromClipboard;
    procedure Redo;
    procedure RestoreDefaults; override;
    procedure SelectAll; override;
    procedure SetSelection(StartPos, EndPos: Longint; ScrollCaret: Boolean);
    procedure SetSelTextBuf(Buffer: PChar);
    procedure Undo;
    {$IFDEF DELPHI4}
    procedure DefaultHandler(var Message); override;
    {$ENDIF}
    property CanPaste: Boolean read GetCanPaste;
    property CanRedo: Boolean read GetCanRedo;
    property CanUndo: Boolean read GetCanUndo;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelText: string read GetSelText write SetSelText;
    property Text;
  end;

  { TdxInplaceMaskEdit }
  TdxInplaceMaskEdit = class(TdxInplaceTextEdit)
  private
    FBtnDownX: Integer;
    FCaretPos: Integer;
    FEditMask: string;
    FIgnoreMaskBlank: Boolean;
    FMaskBlank: Char;
    FMaskSave: Boolean;
    FMaskState: TMaskedState;
    FMaxChars: Integer;
    FStopKeyDown: Boolean;
    function AddEditFormat(const Value: string; Active: Boolean): string;
    procedure ArrowKeys(CharCode: Word; Shift: TShiftState);
    function CharKeys(var CharCode: Char): Boolean;
    procedure CursorDec(CursorPos: Integer);
    procedure CursorInc(CursorPos: Integer; Incr: Integer);
    procedure DeleteKeys(CharCode: Word);
    function DeleteSelection(var Value: string; Offset: Integer; Len: Integer): Boolean;
    function DoInputChar(var NewChar: Char; MaskOffset: Integer): Boolean;
    function FindLiteralChar(MaskOffset: Integer; InChar: Char): Integer;
    function GetEditText: string;
    function GetMasked: Boolean;
    function GetText: string;
    procedure HomeEndKeys(CharCode: Word; Shift: TShiftState);
    function InputChar(var NewChar: Char; Offset: Integer): Boolean;
    function InputString(var Value: string; const NewValue: string; Offset: Integer): Integer;
    function IsEditMaskStored: Boolean;
    function RemoveEditFormat(const Value: string): string;
    procedure SetEditText(const Value: string);
    procedure SetEditMask(const Value: string);
    procedure SetText(const Value: string);
    function Validate(const Value: string; var Pos: Integer): Boolean;
    // messages
    procedure WMClear(var Message); message WM_CLEAR;
    procedure WMCut(var Message: TMessage); message WM_CUT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure EMReplaceSel(var Message: TMessage); message EM_REPLACESEL;
  protected
    // Control
    procedure AssignEditProperties; override;
    procedure AssignEditValue(const Value: Variant); override;
    procedure CheckCursor;
    function GetDisableCloseEditor: Boolean; override;
    function GetFirstEditChar: Integer;
    function GetLastEditChar: Integer;
    function GetMaxChars: Integer;
    function GetNextEditChar(Offset: Integer): Integer;
    function GetPriorEditChar(Offset: Integer): Integer;
    procedure GetSel(var SelStart: Integer; var SelStop: Integer); virtual;
    function IsDisableDragDrop: Boolean; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure ReformatText(const NewMask: string);
    function ReturnEditValue: Variant; override;
    procedure SetCursor(Pos: Integer);
    procedure SetEditEditMask(const Value: string); virtual;
    procedure SetEditMaxLength(Value: Integer); override;
    procedure SetSel(SelStart: Integer; SelStop: Integer);
    procedure SetSelEx(SelStart, SelStop: Integer; RightToLeft: Boolean);
    procedure ValidateError;
    property EditMask: string read FEditMask write SetEditMask stored IsEditMaskStored;
    property IgnoreMaskBlank: Boolean read FIgnoreMaskBlank write FIgnoreMaskBlank;
    property MaskState: TMaskedState read FMaskState write FMaskState;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear;
    function DefaultEditMask: string; virtual;
    function DefaultMaxLength: Integer; override;
    function GetBlankText: string;
    function GetEditingText: string; override;
    function GetTextLen: Integer;
    procedure ValidateEdit; override;
    property EditText: string read GetEditText write SetEditText;
    property IsMasked: Boolean read GetMasked;
    property Text: string read GetText write SetText;
  end;

  {$IFDEF DELPHI4}
  TdxEditAction = class(TEditAction)
  private
    FEdit: TdxInplaceTextEdit;
    procedure SetEdit(Value: TdxInplaceTextEdit);
  protected
    function GetEdit(Target: TObject): TdxInplaceTextEdit; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    function HandlesTarget(Target: TObject): Boolean; override;
    procedure UpdateTarget(Target: TObject); override;
    property Edit: TdxInplaceTextEdit read FEdit write SetEdit;
  end;

  TdxEditCut = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditCopy = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditPaste = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditClear = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditSelectAll = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditUndo = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;

  TdxEditRedo = class(TdxEditAction)
  public
    procedure ExecuteTarget(Target: TObject); override;
  end;
  {$ENDIF}

var
  sdxEditUndoCaption: string;
  sdxEditRedoCaption: string;
  sdxEditCutCaption: string;
  sdxEditCopyCaption: string;
  sdxEditPasteCaption: string;
  sdxEditDeleteCaption: string;
  sdxEditSelectAllCaption: string;

function ConvertTextCase(const S: string; ACharCase: TEditCharCase): string;
function HasPopup(Control: TControl): Boolean;

const
  // DrawTextRect
  DrawAlignmentFlags: array [TdxDrawAlignment] of Integer = (
    DX_DTR_SINGLELINE or DX_DTR_TOP,
    DX_DTR_SINGLELINE or DX_DTR_VCENTER,
    DX_DTR_SINGLELINE or DX_DTR_BOTTOM,
    DX_DTR_MULTILINE);
  SelectionBarSize = 8;

implementation

uses
  Consts, Clipbrd, dxEdStr;

{ TdxInplaceTextEdit }

function HasPopup(Control: TControl): Boolean;
begin
  Result := True;
  while Control <> nil do
    if TdxInplaceTextEdit(Control).PopupMenu <> nil then Exit else Control := Control.Parent;
  Result := False;
end;

function ConvertTextCase(const S: string; ACharCase: TEditCharCase): string;
begin
  case ACharCase of
    ecUpperCase:
      Result := AnsiUpperCase(S);
    ecLowerCase:
      Result := AnsiLowerCase(S);
    else
      Result := S;
  end
end;

constructor TdxInplaceTextEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csClickEvents, csSetCaption, csDoubleClicks];
  ParentColor := False;
  FAutoSelect := True;
  FHideSelection := True;
end;

destructor TdxInplaceTextEdit.Destroy;
begin
  if FEditPopupMenu <> nil then FEditPopupMenu.Free;
  FEditPopupMenu := nil;  
  inherited Destroy;
end;

procedure TdxInplaceTextEdit.Clear;
begin
  SetWindowText(Handle, '');
end;

procedure TdxInplaceTextEdit.ClearSelection;
begin
  SendMessage(Handle, WM_CLEAR, 0, 0);
end;

procedure TdxInplaceTextEdit.ClearUndo;
begin
  if HandleAllocated then
    SendMessage(Handle, EM_EMPTYUNDOBUFFER, 0, 0);
end;

procedure TdxInplaceTextEdit.CopyToClipboard;
begin
  SendMessage(Handle, WM_COPY, 0, 0);
end;

procedure TdxInplaceTextEdit.CutToClipboard;
begin
  SendMessage(Handle, WM_CUT, 0, 0);
end;

function TdxInplaceTextEdit.DefaultMaxLength: Integer;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.EditLimit
  else Result := 0;
end;

procedure TdxInplaceTextEdit.Deselect;
begin
  SendMessage(Handle, EM_SETSEL, $7FFFFFFF, Longint($FFFFFFFF));
end;

class function TdxInplaceTextEdit.DrawClientArea(ADC: HDC; var ARect: TRect;
  AViewData: TdxEditViewData; IsControl: Boolean): Boolean;
const
  AlignmentFlags: array [TAlignment] of Integer = (
    DX_DTR_LEFT, DX_DTR_RIGHT, DX_DTR_CENTER);
  EndEllipsisFlag: array [Boolean] of Integer = (0, DX_DTR_END_ELLIPSIS);
  FocusFlags: array [Boolean] of Integer = (0, DX_DTR_FOCUS_RECT);
  NoTransparentTextFlags: array [Boolean] of Integer = (0, DX_DTR_NOTRANSPARENTBKG);
  TransparentFlags: array [Boolean] of Integer = (0, DX_DTR_TRANSPARENT);
var
  R: TRect;
  S: string;
begin
  if not AViewData.IsEditClass then
    IsControl := False;
  if IsControl then
    Result := False
  else
    with TdxTextEditViewData(AViewData) do
    begin
      R := ARect;
      if DataLength = 0 then
        DataLength := Length(AViewData.Data);
      if CharCase <> ecNormal then
        Data := ConvertTextCase(Data, CharCase);
      if (PasswordChar <> #0) and (Length(Data) > 0) then
      begin
        S := Data;
        FillChar(S[1], Length(S), PasswordChar);
        Data := S;
      end;
      if SelectionBar then
        Inc(R.Left, SelectionBarSize);
      if FocusRect then
        InflateRect(R, -2, -2)
      else
      begin
        InflateRect(R, -1, -1);
        Inc(R.Left, OffsetSize.Left{TextOffsetX});
        Inc(R.Top, OffsetSize.Top{TextOffsetY});
        Dec(R.Right, OffsetSize.Right);
        if Alignment = taRightJustify then
          Dec(R.Right);
      end;
      if CalcHeight then
      begin
        LineCount := 0;
        LineTextHeight := 0;
        LineHeight :=
          DrawTextRect(ADC, string(AViewData.Data), DataLength,
            ARect, R, AlignmentFlags[Alignment] or DrawAlignmentFlags[DrawAlignment] or
            FocusFlags[FocusRect and Focused] or TransparentFlags[Transparent] or
            NoTransparentTextFlags[NoTransparentText] or EndEllipsisFlag[EndEllipsis] or DX_DTR_CALCRECT,
            Brush, Font, BkColor, TextColor, @AViewData.LineTextHeight);
        // Dec Height - don't use offset
        if LineHeight <> 0 then
        begin
          if FocusRect then
            Dec(LineHeight, 2)
          else Dec(LineHeight, 2 + OffsetSize.Top{TextOffsetY});
          if LineTextHeight <> 0 then
            LineCount := LineHeight div LineTextHeight;
        end;
      end
      else
      begin
        DrawTextRect(ADC, string(AViewData.Data), DataLength,
          ARect, R, AlignmentFlags[Alignment] or DrawAlignmentFlags[DrawAlignment] or
          FocusFlags[FocusRect and Focused] or TransparentFlags[Transparent] or
          NoTransparentTextFlags[NoTransparentText] or EndEllipsisFlag[EndEllipsis],
          Brush, Font, BkColor, TextColor, nil);
      end;    
      Result := True;
    end;
end;

function TdxInplaceTextEdit.GetSelection: TCharRange;
begin
  SendMessage(Handle, EM_EXGETSEL, 0, Longint(@Result));
end;

function TdxInplaceTextEdit.GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer;
var
  S: string;
begin
  S := SelText;
  Result := Length(S);
  if BufSize < Result then Result := BufSize;
  StrPLCopy(Buffer, S, Result);
end;

function TdxInplaceTextEdit.GetTextLenEx: Integer;
var
  Len: TGETTEXTLENGTHEX;
begin
  Len.flags := GTL_DEFAULT;
  Len.codepage := CP_ACP;
  Result := SendMessage(Handle, EM_GETTEXTLENGTHEX, Integer(@Len), 0);
end;

function TdxInplaceTextEdit.IsEditClass: Boolean;
begin
  Result := True;
end;

procedure TdxInplaceTextEdit.PasteFromClipboard;
begin
  SendMessage(Handle, WM_PASTE, 0, 0);
end;

procedure TdxInplaceTextEdit.Redo;
begin
  SendMessage(Handle, EM_REDO, 0, 0);
end;

procedure TdxInplaceTextEdit.RestoreDefaults;
begin
  inherited RestoreDefaults;
  SetEditMaxLength(DefaultMaxLength);
end;

procedure TdxInplaceTextEdit.SelectAll;
begin
  SetSelection(0, -1, False);
end;

procedure TdxInplaceTextEdit.SetSelection(StartPos, EndPos: Longint; ScrollCaret: Boolean);
var
  CharRange: TCharRange;
begin
  with CharRange do
  begin
    cpMin := StartPos;
    cpMax := EndPos;
  end;
  SendMessage(Handle, EM_EXSETSEL, 0, Longint(@CharRange));
end;

procedure TdxInplaceTextEdit.SetSelTextBuf(Buffer: PChar);
begin
  SendMessage(Handle, EM_REPLACESEL, 0, LongInt(Buffer));
end;

procedure TdxInplaceTextEdit.Undo;
begin
  SendMessage(Handle, EM_UNDO, 0, 0);
end;

procedure TdxInplaceTextEdit.DefaultHandler(var Message);
begin
  case TMessage(Message).Msg of
    WM_RBUTTONUP:
      Exit;
    WM_SETFOCUS:
      if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
        not IsWindow(TWMSetFocus(Message).FocusedWnd) then
        TWMSetFocus(Message).FocusedWnd := 0;
  end;
  inherited;
end;

// IUnknown
function TdxInplaceTextEdit.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then Result := S_OK
  else Result := E_NOINTERFACE;
end;

function TdxInplaceTextEdit._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TdxInplaceTextEdit._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

// IRichEditOleCallback
function TdxInplaceTextEdit.GetNewStorage(out stg: IStorage): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.GetInPlaceContext(out Frame: IOleInPlaceFrame;
  out Doc: IOleInPlaceUIWindow; lpFrameInfo: POleInPlaceFrameInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.ShowContainerUI(fShow: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.QueryInsertObject(const clsid: TCLSID;
  const stg: IStorage; cp: Longint): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.DeleteObject(const oleobj: IOleObject): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.QueryAcceptData(const dataobj: IDataObject;
  var cfFormat: TClipFormat; reco: DWORD; fReally: BOOL; hMetaPict: HGLOBAL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.ContextSensitiveHelp(fEnterMode: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.GetClipboardData(const chrg: TCharRange; reco: DWORD;
  out dataobj: IDataObject): HResult;
begin
  Result := E_NOTIMPL;
end;

function TdxInplaceTextEdit.GetDragDropEffect(fDrag: BOOL; grfKeyState: DWORD;
  var dwEffect: DWORD): HResult;
begin
  dwEffect := DROPEFFECT_NONE;
  Result := S_OK;
end;

function TdxInplaceTextEdit.GetContextMenu(seltype: Word; const oleobj: IOleObject;
  const chrg: TCharRange; out menu: HMENU): HResult;
begin
  Result := E_NOTIMPL;
end;

// protected TdxInplaceTextEdit
procedure TdxInplaceTextEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
  CharCases: array[TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  OEMConverts: array[Boolean] of DWORD = (0, ES_OEMCONVERT);
  Passwords: array[Boolean] of DWORD = (0, ES_PASSWORD);
  ReadOnlys: array[Boolean] of DWORD = (0, ES_READONLY);
  SelectionBars: array[Boolean] of DWORD = (0, ES_SELECTIONBAR);
var
  S: string;
begin
  inherited CreateParams(Params);
  S := ClassName;
  if IsEditClass then
  begin
    CreateSubClass(Params, RICHEDIT_CLASS); // CreateSubClass(Params, 'EDIT');
    with Params do
    begin
      Style := Style or (ES_AUTOHSCROLL or ES_AUTOVSCROLL) or
        Passwords[FPasswordChar <> #0] or
        ReadOnlys[not CanModify] or CharCases[FCharCase] or
        HideSelections[FHideSelection] or OEMConverts[FOEMConvert] or
        Alignments[Alignment] or SelectionBars[FSelectionBar];
    end;
  end
  else
    S  := S + 'NoEdit';
  with Params do
  begin
    System.Move(S[1], WinClassName[0], Length(S));
    WinClassName[Length(S)] := #0;
  end;
end;

procedure TdxInplaceTextEdit.CreateWnd;
var
  S: string;
begin
  FCreating := True;
  try
    S := Text;
    inherited CreateWnd;
    // Mode
//    S := Text;
    SendMessage(Handle, WM_SETTEXT, 0, 0);
    SendMessage(Handle, EM_SETTEXTMODE, TM_PLAINTEXT, 0);
    Text := S;
  finally
    FCreating := False;
  end;
  // Max Length
  DoSetMaxLength(FMaxLength);
  // Event Mask
  SendMessage(Handle, EM_SETEVENTMASK, 0, ENM_CHANGE or ENM_SELCHANGE or ENM_DRAGDROPDONE);
  // Bk Color
  SendMessage(Handle, CM_COLORCHANGED, 0, 0);
  // Password
  if FPasswordChar <> #0 then
    SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(FPasswordChar), 0);
  if IsDisableDragDrop then
    SendMessage(Handle, EM_SETOLECALLBACK, 0, LPARAM(IRichEditOleCallback(Self)));
  Modified := FModified;
end;

procedure TdxInplaceTextEdit.DestroyWnd;
begin
  FModified := Modified;
  inherited DestroyWnd;
end;

procedure TdxInplaceTextEdit.Loaded;
begin
  inherited Loaded;
  CheckCharCase;
end;

procedure TdxInplaceTextEdit.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);
  if ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_MBUTTONDOWN) or
    (Message.Msg = WM_RBUTTONDOWN)) and
    (GetFocus <> Handle) and not (csDesigning in ComponentState) and
    not Dragging then
  begin
    if Message.Msg = WM_MBUTTONDOWN then
      PostMessage(Handle, WM_MBUTTONUP, 0, 0);
    ReleaseCapture;
  end;
end;

procedure TdxInplaceTextEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  if not (svEditLimit in StoredValues) then
    SetEditMaxLength(DefaultMaxLength);
  if HandleAllocated then
    SendMessage(Handle, EM_SETREADONLY, Ord(not CanModify), 0);
end;

procedure TdxInplaceTextEdit.AssignEditValue(const Value: Variant);
begin
  FAssigningText := True;
  try
    inherited AssignEditValue(Value);
    ClearUndo;
  finally
    FAssigningText := False;
  end;
end;

procedure TdxInplaceTextEdit.CheckCharCase;
var
  ACharRange: TCharRange;
  APrevModified: Boolean;
  AText: string;
begin
  if FCharCase <> ecNormal then
  begin
    AText := ConvertTextCase(Text, FCharCase);
    if AText <> Text then
    begin
      FCharCaseChanging := True;
      try
        if HandleAllocated then
          ACharRange := GetSelection;
        APrevModified := Modified;
        try
          Text := AText;
        finally
          Modified := APrevModified;
        end;
        if HandleAllocated then
          with ACharRange do
            SetSelection(cpMin, cpMax, True);
      finally
        FCharCaseChanging := False;
      end;
    end;
  end;
end;

function TdxInplaceTextEdit.CreateViewData(IsPaintCopy: Boolean): TdxEditViewData;
begin
  Result := inherited CreateViewData(IsPaintCopy);
  with TdxTextEditViewData(Result) do
  begin
    CharCase := Self.CharCase;
    FocusRect := not IsInplace and not IsEditClass;
    PasswordChar := Self.PasswordChar;
    SelectionBar := Self.SelectionBar;
  end;  
end;

procedure TdxInplaceTextEdit.DoSetMaxLength(Value: Integer);
begin
  if HandleAllocated then
    SendMessage(Handle, EM_EXLIMITTEXT, 0, Value);
//  SendMessage(Handle, EM_LIMITTEXT, Value, 0);
end;

function TdxInplaceTextEdit.GetModified: Boolean;
begin
  if HandleAllocated and IsEditClass then
    Result := SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0
  else Result := FModified;
end;

function TdxInplaceTextEdit.GetSelLength: Integer;
begin
  with GetSelection do
    Result := cpMax - cpMin;
end;

function TdxInplaceTextEdit.GetSelStart: Integer;
begin
  Result := GetSelection.cpMin;
end;

function TdxInplaceTextEdit.GetSelText: string;
begin
  SetLength(Result, GetSelLength + 1);
  SetLength(Result, SendMessage(Handle, EM_GETSELTEXT, 0, Longint(PChar(Result))));
end;

class function TdxInplaceTextEdit.GetViewDataClass: TdxEditViewDataClass;
begin
  Result := TdxTextEditViewData; 
end;

function TdxInplaceTextEdit.IsDisableDragDrop: Boolean;
begin
  Result := Assigned(DataDefinition);
end;

procedure TdxInplaceTextEdit.SelectionChange;
begin
  if Assigned(FOnSelectionChange) then FOnSelectionChange(Self);
end;

procedure TdxInplaceTextEdit.SetEditMaxLength(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    DoSetMaxLength(FMaxLength);
  end;
end;

procedure TdxInplaceTextEdit.SetEditReadOnly(Value: Boolean);
begin
  inherited SetEditReadOnly(Value);
  if HandleAllocated then
    SendMessage(Handle, EM_SETREADONLY, Ord(Value{ReadOnly}), 0);
end;

procedure TdxInplaceTextEdit.SetModified(Value: Boolean);
begin
  if HandleAllocated and IsEditClass then
    SendMessage(Handle, EM_SETMODIFY, Byte(Value), 0)
  else
    FModified := Value;
end;

procedure TdxInplaceTextEdit.SetSelLength(Value: Integer);
begin
  with GetSelection do
    SetSelection(cpMin, cpMin + Value, True);
end;

procedure TdxInplaceTextEdit.SetSelStart(Value: Integer);
begin
  SetSelection(Value, Value, False);
end;

// private TdxInplaceTextEdit
procedure TdxInplaceTextEdit.EditPopupMenuClick(Sender: TObject);
begin
  case TMenuItem(Sender).Tag of
    -1: Undo;
    -2: Redo;
    -3: CutToClipboard;
    -4: CopyToClipboard;
    -5: PasteFromClipboard;
    -6: ClearSelection;
    -7: SelectAll;
  end;
end;

function TdxInplaceTextEdit.GetCanPaste: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := CanModify and (SendMessage(Handle, EM_CANPASTE, 0, 0) <> 0);
end;

function TdxInplaceTextEdit.GetCanRedo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANREDO, 0, 0) <> 0;
end;

function TdxInplaceTextEdit.GetCanUndo: Boolean;
begin
  Result := False;
  if HandleAllocated then
    Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

function TdxInplaceTextEdit.IsMaxLengthStored: Boolean;
begin
  Result := svEditLimit in StoredValues;
end;

procedure TdxInplaceTextEdit.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    CheckCharCase;
  end;
end;

procedure TdxInplaceTextEdit.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceTextEdit.SetMaxLength(Value: Integer);
begin
  Include(FStoredValues, svEditLimit);
  SetEditMaxLength(Value);
end;

procedure TdxInplaceTextEdit.SetOEMConvert(Value: Boolean);
begin
  if FOEMConvert <> Value then
  begin
    FOEMConvert := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceTextEdit.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then
  begin
    FPasswordChar := Value;
    if HandleAllocated then
    begin
      SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(FPasswordChar), 0);
      SetTextBuf(PChar(Text));
    end;
  end;
end;

procedure TdxInplaceTextEdit.SetSelectionBar(Value: Boolean);
begin
  if FSelectionBar <> Value then
  begin
    FSelectionBar := Value;
    RecreateWnd;
  end;
end;

procedure TdxInplaceTextEdit.SetSelText(const Value: String);
begin
  SendMessage(Handle, EM_REPLACESEL, 0, Longint(PChar(Value)));
end;

procedure TdxInplaceTextEdit.WMChar(var Message: TWMChar);
var
  S: string;
begin
  if FCharCase <> ecNormal then
  begin
    S := Char(Message.CharCode);
    S := ConvertTextCase(S, FCharCase);
    if Length(S) > 0 then
      Message.CharCode := Word(S[1]);
  end;
  inherited;
end;

procedure TdxInplaceTextEdit.WMContextMenu(var Message: TMessage);

  function NewItem(const ACaption: string; ATag: Integer): TMenuItem;
  begin
    Result := TMenuItem.Create(Self);
    with Result do
    begin
      Caption := ACaption;
      Tag := ATag;
      OnClick := EditPopupMenuClick;
    end;
  end;

  procedure UpdateItems;
  var
    F: Boolean;
  begin
    with FEditPopupMenu do
    begin
      F := SelLength > 0;
      Items[0].Enabled := CanUndo;
      Items[1].Enabled := CanRedo;
      Items[3].Enabled := F and CanModify and (PasswordChar = #0);
      Items[4].Enabled := F and (PasswordChar = #0);
      Items[5].Enabled := CanPaste;
      Items[6].Enabled := F and CanModify;
      Items[8].Enabled := SelLength <> GetTextLenEx;
    end;
  end;

var
  P: TPoint;
begin
  inherited;
  if IsEditClass and (Message.Result = 0) and not HasPopup(Self) {DELPHI3} then
  begin
    P := SmallPointToPoint(TSmallPoint(Message.LParam));
    if (P.X = -1) and (P.Y = -1) then
    begin
      GetCaretPos(P);
      if P.X > ClientWidth then
        P.X := ClientWidth; 
      Windows.ClientToScreen(Handle, P);
    end
    else
      if not PtInRect(ClientRect, ScreenToClient(P)) then Exit;
    // Popup
    if FEditPopupMenu = nil then
    begin
      FEditPopupMenu := TPopupMenu.Create(Self);
      with FEditPopupMenu.Items do
      begin
        Add(NewItem(sdxEditUndoCaption, -1));
        Add(NewItem(sdxEditRedoCaption, -2));
        Add(NewItem('-', MaxInt));
        Add(NewItem(sdxEditCutCaption, -3));
        Add(NewItem(sdxEditCopyCaption, -4));
        Add(NewItem(sdxEditPasteCaption, -5));
        Add(NewItem(sdxEditDeleteCaption, -6));
        Add(NewItem('-', MaxInt));
        Add(NewItem(sdxEditSelectAllCaption, -7));
      end;
    end;
    UpdateItems;
    FEditPopupMenu.Popup(P.X, P.Y);
  end;
end;

procedure TdxInplaceTextEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if not IsInplace then
    Message.Result := Message.Result and not DLGC_WANTTAB;
end;

procedure TdxInplaceTextEdit.WMRButtonUp(var Message: TWMRButtonUp);
var
  P: TPoint;
begin
  inherited;
//  if IsDisableDragDrop then // IRichEditOleCallback.GetContextMenu
  begin
    P := SmallPointToPoint(Message.Pos);
    Windows.ClientToScreen(Handle, P);
    PostMessage(Handle, WM_CONTEXTMENU, Handle, Integer(PointToSmallPoint(P)));
  end;
end;

procedure TdxInplaceTextEdit.WMSetFont(var Message: TWMSetFont);
var
  Format: TCharFormat2;
begin
  inherited;
  FillChar(Format, SizeOf(Format), 0);
  with Format do
  begin
    cbSize := SizeOf(Format);
    dwMask := CFM_COLOR;
    if (Font.Color = clWindowText) or (Font.Color = clDefault) then
      dwEffects := CFE_AUTOCOLOR
    else
      crTextColor := ColorToRGB(Font.Color);
    SendMessage(Handle, EM_SETCHARFORMAT, 0, LPARAM(@Format));
  end;
end;

procedure TdxInplaceTextEdit.WMSetText(var Message: TMessage);
begin
  inherited;
  DoSetMaxLength(FMaxLength);
end;

procedure TdxInplaceTextEdit.WMSize(var Message: TWMSize);
var
  R: TRect;
begin
  inherited;
  R := ClientRect;
  InflateRect(R, -1, -1);
  if (GetWindowLong(Handle, GWL_STYLE) and ES_SELECTIONBAR) <> 0 then
    Inc(R.Left, SelectionBarSize);
  if Alignment = taRightJustify then Dec(R.Right);
  Inc(R.Left, OffsetSize.Left{TextOffsetX});
  Inc(R.Top, OffsetSize.Top{TextOffsetY});
  Dec(R.Right, OffsetSize.Right);
  SendMessage(Handle, EM_SETRECT, 0, LongInt(@R));
end;

procedure TdxInplaceTextEdit.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then
    SendMessage(Handle, EM_SETBKGNDCOLOR, 0, ColorToRGB(Color))
end;

procedure TdxInplaceTextEdit.CMEnter(var Message: TCMGotFocus);
begin
  if FAutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  inherited;
end;

procedure TdxInplaceTextEdit.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  Perform(CM_COLORCHANGED, 0, 0);
end;

procedure TdxInplaceTextEdit.CMTextChanged(var Message: TMessage);
begin
  if IsEditClass then
  begin
    inherited;
    if not (csLoading in ComponentState) and
      not HandleAllocated and not (FCreating or FAssigningText) then
      Change;
  end
  else
    if not (csLoading in ComponentState) and not FCharCaseChanging then
    begin
      CheckCharCase;
      if not (FCreating or FAssigningText) then
        Change;
      InvalidateClientRect;
    end;
end;

procedure TdxInplaceTextEdit.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_CHANGE) and not (csLoading in ComponentState) and
    not FCharCaseChanging then
  begin
    CheckCharCase;
    if not (FCreating or FAssigningText) then
    begin
//      if not (Assigned(Container) and Container.IsInitEdit) and
//        not FInternalChanging and CanModify then
//        EditCanModify; // TODO: bug in RE (WM_CHAR does not appear in Unicode Win)
      Change;
    end;  
  end;  
end;

procedure TdxInplaceTextEdit.CNNotify(var Message: TWMNotify);
begin
  if (Message.NMHdr^.code = EN_SELCHANGE) and not (csLoading in ComponentState) then
    SelectionChange;
  inherited;
end;

{ TdxInplaceMaskEdit }

{ Mask utility routines }
function MaskGetCharType(const EditMask: string; MaskOffset: Integer): TMaskCharType;
var
  MaskChar: Char;
begin
  Result := mcLiteral;
  MaskChar := #0;
  if MaskOffset <= Length(EditMask) then
    MaskChar := EditMask[MaskOffset];
  if MaskOffset > Length(EditMask) then
    Result := mcNone
  {$IFDEF DELPHI3}
  else if ByteType(EditMask, MaskOffset) <> mbSingleByte then
    Result := mcLiteral
  {$ENDIF}
  else if (MaskOffset > 1) and (EditMask[MaskOffset - 1] = mDirLiteral) and
      {$IFDEF DELPHI3}(ByteType(EditMask, MaskOffset - 1) = mbSingleByte) and{$ENDIF}
      not ((MaskOffset > 2) and (EditMask[MaskOffset - 2] = mDirLiteral)
      {$IFDEF DELPHI3}and (ByteType(EditMask, MaskOffset - 2) = mbSingleByte){$ENDIF}) then
    Result := mcLiteral

  else if (MaskChar = MaskFieldSeparator) and
         (Length(EditMask) >= 4) and
         (MaskOffset > Length(EditMask) - 4) then
    Result := mcFieldSeparator

  else if (Length(EditMask) >= 4) and
         (MaskOffset > (Length(EditMask) - 4)) and
         (EditMask[MaskOffset - 1] = MaskFieldSeparator) and
         not ((MaskOffset > 2) and (EditMask[MaskOffset - 2] = mDirLiteral)
         {$IFDEF DELPHI3}and (ByteType(EditMask, MaskOffset - 2) <> mbTrailByte){$ENDIF}) then
    Result := mcField

  else if MaskChar in [mMskTimeSeparator, mMskDateSeparator] then
    Result := mcIntlLiteral

  else if MaskChar in [mDirReverse, mDirUpperCase, mDirLowerCase,
      mDirLiteral] then
    Result := mcDirective

  else if MaskChar in [mMskAlphaOpt, mMskAlphaNumOpt, mMskAsciiOpt,
      mMskNumSymOpt, mMskNumericOpt] then
    Result := mcMaskOpt

  else if MaskChar in [mMskAlpha, mMskAlphaNum, mMskAscii, mMskNumeric] then
    Result := mcMask;
end;

function MaskGetCurrentDirectives(const EditMask: string;
  MaskOffset: Integer): TMaskDirectives;
var
  I: Integer;
  MaskChar: Char;
begin
  Result := [];
  for I := 1 to Length(EditMask) do
  begin
    MaskChar := EditMask[I];
    if (MaskChar = mDirReverse) then
      Include(Result, mdReverseDir)
    else if (MaskChar = mDirUpperCase) and (I < MaskOffset) then
    begin
      Exclude(Result, mdLowerCase);
      if not ((I > 1) and (EditMask[I-1] = mDirLowerCase)) then
        Include(Result, mdUpperCase);
    end
    else if (MaskChar = mDirLowerCase) and (I < MaskOffset) then
    begin
      Exclude(Result, mdUpperCase);
      Include(Result, mdLowerCase);
    end;
  end;
  if MaskGetCharType(EditMask, MaskOffset) = mcLiteral then
    Include(Result, mdLiteralChar);
end;

function MaskIntlLiteralToChar(IChar: Char): Char;
begin
  Result := IChar;
  case IChar of
    mMskTimeSeparator: Result := TimeSeparator;
    mMskDateSeparator: Result := DateSeparator;
  end;
end;

function MaskDoFormatText(const EditMask: string; const Value: string;
  Blank: Char): string;
var
  I: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  Dir: TMaskDirectives;
begin
  Result := Value;
  Dir := MaskGetCurrentDirectives(EditMask, 1);

  if not (mdReverseDir in Dir) then
  begin
      { starting at the beginning, insert literal chars in the string
        and add spaces on the end }
    Offset := 1;
    for MaskOffset := 1 to Length(EditMask) do
    begin
      CType := MaskGetCharType(EditMask, MaskOffset);

      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Copy(Result, 1, Offset - 1) +
          MaskIntlLiteralToChar(EditMask[MaskOffset]) +
          Copy(Result, Offset, Length(Result) - Offset + 1);
        Inc(Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset > Length(Result) then
          Result := Result + Blank;
        Inc(Offset);
      end;
    end;
  end
  else
  begin
      { starting at the end, insert literal chars in the string
        and add spaces at the beginning }
    Offset := Length(Result);
    for I := 0 to(Length(EditMask) - 1) do
    begin
      MaskOffset := Length(EditMask) - I;
      CType := MaskGetCharType(EditMask, MaskOffset);
      if CType in [mcLiteral, mcIntlLiteral] then
      begin
        Result := Copy(Result, 1, Offset) +
               MaskIntlLiteralToChar(EditMask[MaskOffset]) +
               Copy(Result, Offset + 1, Length(Result) - Offset);
      end
      else if CType in [mcMask, mcMaskOpt] then
      begin
        if Offset < 1 then
          Result := Blank + Result
        else
          Dec(Offset);
      end;
    end;
  end;
end;

function MaskGetMaskSave(const EditMask: string): Boolean;
var
  I: Integer;
  Sep1, Sep2: Integer;
begin
  Result := True;
  if Length(EditMask) >= 4 then
  begin
    Sep1 := -1;
    Sep2 := -1;
    I := Length(EditMask);
    while Sep2 < 0 do
    begin
      if (MaskGetCharType(EditMask, I) =  mcFieldSeparator) then
      begin
        if Sep1 < 0 then
          Sep1 := I
        else
          Sep2 := I;
      end;
      Dec(I);
      if (I <= 0) or(I < Length(EditMask) - 4) then
        Break;
    end;
    if Sep2 < 0 then
      Sep2 := Sep1;
    if Sep2 <> Length(EditMask) then
      Result := not (EditMask [Sep2 + 1] = MaskNoSave);
  end;
end;

function MaskGetMaskBlank(const EditMask: string): Char;
begin
  Result := DefaultBlank;
  if Length(EditMask) >= 4 then
  begin
    if (MaskGetCharType(EditMask, Length(EditMask) - 1) =
                                                  mcFieldSeparator) then
    begin
        {in order for blank specifier to be valid, there
         must also be a save specifier }
      if (MaskGetCharType(EditMask, Length(EditMask) - 2) =
                                                  mcFieldSeparator) or
        (MaskGetCharType(EditMask, Length(EditMask) - 3) =
                                                  mcFieldSeparator) then
      begin
        Result := EditMask [Length(EditMask)];
      end;
    end;
  end;
end;

function MaskOffsetToOffset(const EditMask: String; MaskOffset: Integer): Integer;
var
  I: Integer;
  CType: TMaskCharType;
begin
  Result := 0;
  for I := 1 to MaskOffset do
  begin
    CType := MaskGetCharType(EditMask, I);
    if not (CType in [mcDirective, mcField, mcFieldSeparator]) then
      Inc(Result);
  end;
end;

function OffsetToMaskOffset(const EditMask: string; Offset: Integer): Integer;
var
  I: Integer;
  Count: Integer;
  MaxChars: Integer;
begin
  MaxChars  := MaskOffsetToOffset(EditMask, Length(EditMask));
  if Offset > MaxChars then
  begin
    Result := -1;
    Exit;
  end;

  Result := 0;
  Count := Offset;
  for I := 1 to Length(EditMask) do
  begin
    Inc(Result);
    if not (mcDirective = MaskGetCharType(EditMask, I)) then
    begin
      Dec(Count);
      if Count < 0 then
        Exit;
    end;
  end;
end;

function IsLiteralChar(const EditMask: string; Offset: Integer): Boolean;
var
  MaskOffset: Integer;
  CType: TMaskCharType;
begin
  Result := False;
  MaskOffset := OffsetToMaskOffset(EditMask, Offset);
  if MaskOffset >= 0 then
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    Result := CType in [mcLiteral, mcIntlLiteral];
  end;
end;

function PadSubField(const EditMask: String; const Value: string;
  StartFld, StopFld, Len: Integer; Blank: Char): string;
var
  Dir: TMaskDirectives;
  StartPad: Integer;
  K: Integer;
begin
  if (StopFld - StartFld) < Len then
  begin
     { found literal at position J, now pad it }
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    StartPad := StopFld - 1;
    if mdReverseDir in Dir then
      StartPad := StartFld - 1;
    Result := Copy(Value, 1, StartPad);
    for K := 1 to (Len - (StopFld - StartFld)) do
      Result := Result + Blank;
    Result := Result + Copy(Value, StartPad + 1, Length(Value));
  end
  else if (StopFld - StartFld) > Len then
  begin
    Dir := MaskGetCurrentDirectives(EditMask, 1);
    if mdReverseDir in Dir then
      Result := Copy(Value, 1, StartFld - 1) +
        Copy(Value, StopFld - Len, Length(Value))
    else
      Result := Copy(Value, 1, StartFld + Len - 1) +
        Copy(Value, StopFld, Length(Value));
  end
  else
    Result := Value;
end;

function PadInputLiterals(const EditMask: String; const Value: string;
  Blank: Char): string;
var
  J: Integer;
  LastLiteral, EndSubFld: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  MaxChars: Integer;
begin
  LastLiteral := 0;

  Result := Value;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
    begin
      Offset := MaskOffsetToOffset(EditMask, MaskOffset);
      EndSubFld := Length(Result) + 1;
      for J := LastLiteral + 1 to Length(Result) do
      begin
        if Result[J] = MaskIntlLiteralToChar(EditMask[MaskOffset]) then
        begin
          EndSubFld := J;
          Break;
        end;
      end;
       { we have found a subfield, ensure that it complies }
      if EndSubFld > Length(Result) then
        Result := Result + MaskIntlLiteralToChar(EditMask[MaskOffset]);
      Result := PadSubField(EditMask, Result, LastLiteral + 1, EndSubFld,
        Offset - (LastLiteral + 1), Blank);
      LastLiteral := Offset;
    end;
  end;

    {ensure that the remainder complies, too }
  MaxChars  := MaskOffsetToOffset(EditMask, Length(EditMask));
  if Length (Result) <> MaxChars then
    Result := PadSubField(EditMask, Result, LastLiteral + 1, Length (Result) + 1,
      MaxChars - LastLiteral, Blank);

    { replace non-literal blanks with blank char }
  for Offset := 1 to Length (Result) do
  begin
    if Result[Offset] = ' ' then
    begin
      if not IsLiteralChar(EditMask, Offset - 1) then
        Result[Offset] := Blank;
    end;
  end;
end;

constructor TdxInplaceMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMaskState := [];
  FMaskBlank := DefaultBlank;
end;

procedure TdxInplaceMaskEdit.Clear;
begin
  Text := '';
end;

function TdxInplaceMaskEdit.DefaultEditMask: string;
begin
  if Assigned(DataDefinition) then
    Result := DataDefinition.EditMask
  else Result := '';
end;

function TdxInplaceMaskEdit.DefaultMaxLength: Integer;
begin
  if IsMasked then
    Result := FMaxChars
  else Result := inherited DefaultMaxLength;
end;

function TdxInplaceMaskEdit.GetBlankText: string;
begin
  Result := EditText;
  DeleteSelection(Result, 0, MaxLength);
end;

function TdxInplaceMaskEdit.GetEditingText: String;
begin
  if IgnoreMaskBlank then
    Result := EditText
  else
  begin
    if IsMasked and (EditText = GetBlankText) then
      Result := ''
    else Result := Text;
  end;
end;

function TdxInplaceMaskEdit.GetTextLen: Integer;
begin
  Result := Length(Text);
end;

procedure TdxInplaceMaskEdit.ValidateEdit;
var
  Str: string;
  Pos: Integer;
begin
//  inherited ValidateEdit;
  if IsMasked then
  begin
    Str := EditText;
    if Modified and not Validate(Str, Pos) then
    begin
      if FCloseFlag then
      begin
        Reset;
        Exit;
      end;
      if not (csDesigning in ComponentState) then
      begin
        Include(FMaskState, msReEnter);
        if IsWindowVisible(Handle) then
          Windows.SetFocus(Handle);
      end;
      SetCursor(Pos);
      ValidateError;
      FStopKeyDown := True;
    end;
    CheckCursor;
  end;
  inherited ValidateEdit;
end;

procedure TdxInplaceMaskEdit.AssignEditProperties;
begin
  inherited AssignEditProperties;
  if not (svEditMask in StoredValues) then
    SetEditEditMask(DefaultEditMask);
end;

procedure TdxInplaceMaskEdit.AssignEditValue(const Value: Variant);
begin
  if IsMasked then
  begin
    FAssigningText := True;
    try
//      inherited AssignEditValue(Value);
      if VarIsNull(Value) then
        Text := ''
      else
        Text := Value;
      ClearUndo;
    finally
      FAssigningText := False;
    end;
  end
  else
    inherited AssignEditValue(Value);
end;

procedure TdxInplaceMaskEdit.CheckCursor;
var
  SelStart, SelStop: Integer;
begin
  if not HandleAllocated then Exit;
  if (IsMasked) then
  begin
    GetSel(SelStart, SelStop);
    if SelStart = SelStop then
      SetCursor(SelStart);
  end;
end;

function TdxInplaceMaskEdit.GetDisableCloseEditor: Boolean;
begin
  Result := inherited GetDisableCloseEditor;
  if not Modified then Result := False;
end;

function TdxInplaceMaskEdit.GetFirstEditChar: Integer;
begin
  Result := 0;
  if IsMasked then
    Result := GetNextEditChar(0);
end;

function TdxInplaceMaskEdit.GetLastEditChar: Integer;
begin
  Result := GetMaxChars;
  if IsMasked then
    Result := GetPriorEditChar(Result - 1);
end;

function TdxInplaceMaskEdit.GetMaxChars: Integer;
begin
  if IsMasked then
    Result := FMaxChars
  else
    Result := inherited GetTextLen;
end;

function TdxInplaceMaskEdit.GetNextEditChar(Offset: Integer): Integer;
begin
  Result := Offset;
  while(Result < FMaxChars) and (IsLiteralChar(EditMask, Result)) do
    Inc(Result);
end;

function TdxInplaceMaskEdit.GetPriorEditChar(Offset: Integer): Integer;
begin
  Result := Offset;
  while(Result >= 0) and (IsLiteralChar(EditMask, Result)) do
    Dec(Result);
  if Result < 0 then
    Result := GetNextEditChar(Result);
end;

procedure TdxInplaceMaskEdit.GetSel(var SelStart: Integer; var SelStop: Integer);
begin
  if IsEditClass then
    with GetSelection do
    begin
      SelStart := cpMin;
      SelStop := cpMax;
    end
  else
  begin
    SelStart := 0;
    SelStop := 0;
  end;
end;

function TdxInplaceMaskEdit.IsDisableDragDrop: Boolean;
begin
  Result := inherited IsDisableDragDrop or IsMasked;
end;

procedure TdxInplaceMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Reset;
  FStopKeyDown := False;
  if IsInplace and (Key in [VK_UP, VK_DOWN, VK_PRIOR, VK_NEXT, VK_TAB,
    VK_RETURN, VK_ESCAPE, VK_INSERT]) {CloseEditor} then ValidateEdit;
  DisableValidate;
  try
    if not FStopKeyDown then
    begin
      if ((Key = Ord('V')) and (ssCtrl in Shift)) or
        ((Key = VK_INSERT) and (ssShift in Shift)) then
      begin
        PostMessage(Handle, WM_PASTE, 0, 0);
        Key := 0;
      end;
      inherited KeyDown(Key, Shift);
    end;
    if IsMasked and (Key <> 0) and not (ssAlt in Shift) then
    begin
      if (Key = VK_LEFT) or(Key = VK_RIGHT) then
      begin
        ArrowKeys(Key, Shift);
        if not ((ssShift in Shift) or (ssCtrl in Shift)) then
          Key := 0;
        Exit;
      end
      else if (Key = VK_UP) or(Key = VK_DOWN) then
      begin
        Key := 0;
        Exit;
      end
      else if (Key = VK_HOME) or(Key = VK_END) then
      begin
        HomeEndKeys(Key, Shift);
        Key := 0;
        Exit;
      end
      else if ((Key = VK_DELETE) and ([ssShift, ssCtrl] * Shift = [])) or
        (Key = VK_BACK) then
      begin
        if EditCanModify then
          DeleteKeys(Key);
        Key := 0;
        Exit;
      end
      else
        if (Key = Ord('A')) and (Shift = [ssCtrl]) then
        begin
          SelectAll;
          Key := 0;
          KillMessage(Handle, WM_CHAR);
          Exit;
        end;
      CheckCursor;
    end;
  finally
    EnableValidate;
  end;
end;

procedure TdxInplaceMaskEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if IsMasked and (Key <> #0) and not (Key in [^V, ^X, ^C]) then
  begin
    CharKeys(Key);
    Key := #0;
  end;
end;

procedure TdxInplaceMaskEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if IsMasked and (Key <> 0) then
  begin
    if ((Key = VK_LEFT) or(Key = VK_RIGHT)) and (ssCtrl in Shift) then
      CheckCursor;
  end;
end;

procedure TdxInplaceMaskEdit.ReformatText(const NewMask: string);
var
  OldText: string;
begin
  OldText := RemoveEditFormat(EditText);
  FEditMask := NewMask;
  FMaxChars  := MaskOffsetToOffset(EditMask, Length(NewMask));
  FMaskSave  := MaskGetMaskSave(NewMask);
  FMaskBlank := MaskGetMaskBlank(NewMask);
  OldText := AddEditFormat(OldText, True);
  EditText := OldText;
end;

function TdxInplaceMaskEdit.ReturnEditValue: Variant; 
begin
  Result := Text;
end;

procedure TdxInplaceMaskEdit.SetCursor(Pos: Integer);
var
  SelStart, SelStop: Integer;
  KeyState: TKeyboardState;
  NewKeyState: TKeyboardState;
begin
  {$IFDEF DELPHI3}
  if ByteType(EditText, Pos+1) = mbTrailByte then Dec(Pos);
  {$ENDIF}
  SelStart := Pos;
  if (IsMasked) then
  begin
    if SelStart < 0 then
      SelStart := 0;
    SelStop  := SelStart + 1;
    {$IFDEF DELPHI3}
    if (Length(EditText) > SelStop) and (EditText[SelStop] in LeadBytes) then
      Inc(SelStop);
    {$ENDIF}
    if SelStart >= FMaxChars then
    begin
      SelStart := FMaxChars;
      SelStop  := SelStart;
    end;

    SetSel(SelStop, SelStop);

    if SelStart <> SelStop then
    begin
      GetKeyboardState(KeyState);
      NewKeyState := KeyState;
      NewKeyState[VK_SHIFT] := $81;
      NewKeyState[VK_LEFT] := $81;
      NewKeyState[VK_CONTROL] := 0; // TODO: fill zero
      SetKeyboardState(NewKeyState);
      SendMessage(Handle, WM_KEYDOWN, VK_LEFT, 1);
      SendMessage(Handle, WM_KEYUP, VK_LEFT, 1);
      SetKeyboardState(KeyState);
    end;
    FCaretPos := SelStart;
  end
  else
  begin
    if SelStart < 0 then
      SelStart := 0;
    if SelStart >= Length(EditText) then
      SelStart := Length(EditText);
    SetSel(SelStart, SelStart);
  end;
end;

procedure TdxInplaceMaskEdit.SetEditEditMask(const Value: string);
var
  SelStart, SelStop: Integer;
begin
  if EditMask <> Value then
  begin
    if (csDesigning in ComponentState) and (Value <> '') and
      not (csLoading in ComponentState) then Clear;
    if HandleAllocated then GetSel(SelStart, SelStop);
    ReformatText(Value);
    Exclude(FMaskState, msMasked);
    if EditMask <> '' then Include(FMaskState, msMasked);
    SetEditMaxLength(0);
    if IsMasked and (FMaxChars > 0) then
      SetEditMaxLength(FMaxChars);
    if HandleAllocated and (GetFocus = Handle) and
       not (csDesigning in ComponentState) then
      SetCursor(SelStart);
    RecreateWnd; // new Richedit
  end;
end;

procedure TdxInplaceMaskEdit.SetEditMaxLength(Value: Integer);
begin
  if IsMasked then
    inherited SetEditMaxLength(FMaxChars)
  else
    inherited SetEditMaxLength(Value);
end;

procedure TdxInplaceMaskEdit.SetSel(SelStart: Integer; SelStop: Integer);
begin
  SendMessage(Handle, EM_SETSEL, SelStart, SelStop);
end;

procedure TdxInplaceMaskEdit.SetSelEx(SelStart, SelStop: Integer; RightToLeft: Boolean);
var
  ATemp: Integer;  
begin
  SetSel(SelStart, SelStop);
  if RightToLeft then
  begin
    ATemp := SelStart;
    SelStart := SelStop;
    SelStop := ATemp;
    SetSel(SelStart, SelStop);
  end;
end;

procedure TdxInplaceMaskEdit.ValidateError;
var
  Str: string;
begin
  MessageBeep(0);
  Str := EditMask;
  Str := {$IFDEF DELPHI3}Format {$ELSE}FmtLoadStr {$ENDIF}(SMaskEditErr, [Str]);
  raise EDBEditError.Create(Str);
end;

function TdxInplaceMaskEdit.AddEditFormat(const Value: string; Active: Boolean): string;
begin
  if not Active then
    Result := MaskDoFormatText(EditMask, Value, ' ')
  else
    Result := MaskDoFormatText(EditMask, Value, FMaskBlank);
end;

procedure TdxInplaceMaskEdit.ArrowKeys(CharCode: Word; Shift: TShiftState);
var
  SelStart, SelStop : Integer;
begin
  if (ssCtrl in Shift) then Exit;
  GetSel(SelStart, SelStop);
  if (ssShift in Shift) then
  begin
    if (CharCode = VK_RIGHT) then
    begin
      Inc(FCaretPos);
      if (SelStop = SelStart + 1) then
      begin
        SetSel(SelStart, SelStop);  {reset caret to end of string}
        Inc(FCaretPos);
      end;
      if FCaretPos > FMaxChars then FCaretPos := FMaxChars;
    end
    else  {if (CharCode = VK_LEFT) then}
    begin
      Dec(FCaretPos);
      if (SelStop = SelStart + 2) and
        (FCaretPos > SelStart) then
      begin
        SetSel(SelStart + 1, SelStart + 1);  {reset caret to show up at start}
        Dec(FCaretPos);
      end;
      if FCaretPos < 0 then FCaretPos := 0;
    end;
  end
  else
  begin
    if (SelStop - SelStart) > 1 then
    begin
    {$IFDEF DELPHI3}
      if ((SelStop - SelStart) = 2) and (EditText[SelStart+1] in LeadBytes) then
      begin
        if (CharCode = VK_LEFT) then
          CursorDec(SelStart)
        else
          CursorInc(SelStart, 2);
        Exit;
      end;
    {$ENDIF}
      if SelStop = FCaretPos then
        Dec(FCaretPos);
      SetCursor(FCaretPos);
    end
    else if (CharCode = VK_LEFT) then
      CursorDec(SelStart)
    else   { if (CharCode = VK_RIGHT) then  }
    begin
      if SelStop = SelStart then
        SetCursor(SelStart)
      else
      {$IFDEF DELPHI3}
        if EditText[SelStart+1] in LeadBytes then
          CursorInc(SelStart, 2)
        else
      {$ENDIF}
          CursorInc(SelStart, 1);
    end;
  end;
end;

function TdxInplaceMaskEdit.CharKeys(var CharCode: Char): Boolean;
var
  SelStart, SelStop : Integer;
  Txt: string;
  {$IFDEF DELPHI3}
  CharMsg: TMsg;
  {$ENDIF}
begin
  Result := False;
  if Word(CharCode) = VK_ESCAPE then
  begin
    Reset;
    Exit;
  end;
  if not IsInplace and (Word(CharCode) = VK_RETURN) then
  begin
    ValidateEdit;
    Exit;
  end;
  if not EditCanModify or not CanModify then Exit;
  if (Word(CharCode) = VK_BACK) then Exit;

  GetSel(SelStart, SelStop);
  if (SelStop - SelStart) > 1 then
  begin
    DeleteKeys(VK_DELETE);
    SelStart := GetNextEditChar(SelStart);
    SetCursor(SelStart);
  end;

  {$IFDEF DELPHI3}
  if (CharCode in LeadBytes) then
    if PeekMessage(CharMsg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
      if CharMsg.Message = WM_Quit then
        PostQuitMessage(CharMsg.wparam);
  {$ENDIF}
  Result := InputChar(CharCode, SelStart);
  if Result then
  begin
   {$IFDEF DELPHI3}
    if (CharCode in LeadBytes) then
    begin
      Txt := CharCode + Char(CharMsg.wParam);
      SetSel(SelStart, SelStart + 2);
    end
    else
   {$ENDIF}
      Txt := CharCode;
    SendMessage(Handle, EM_REPLACESEL, 0, LongInt(PChar(Txt)));
    GetSel(SelStart, SelStop);
    CursorInc(SelStart, 0);
  end;
end;

procedure TdxInplaceMaskEdit.CursorDec(CursorPos: Integer);
var
  nuPos: Integer;
begin
  nuPos := CursorPos;
  Dec(nuPos);
  nuPos := GetPriorEditChar(nuPos);
  SetCursor(NuPos);
end;

procedure TdxInplaceMaskEdit.CursorInc(CursorPos: Integer; Incr: Integer);
var
  NuPos: Integer;
begin
  NuPos := CursorPos + Incr;
  NuPos := GetNextEditChar(NuPos);
  if IsLiteralChar(EditMask, nuPos) then
    NuPos := CursorPos;
  SetCursor(NuPos);
end;

procedure TdxInplaceMaskEdit.DeleteKeys(CharCode: Word);
var
  SelStart, SelStop : Integer;
  NuSelStart: Integer;
  Str: string;
begin
  if not CanModify then Exit;
  GetSel(SelStart, SelStop);
  if ((SelStop - SelStart) <= 1) and (CharCode = VK_BACK) then
  begin
    NuSelStart := SelStart;
    CursorDec(SelStart);
    GetSel(SelStart, SelStop);
    if SelStart = NuSelStart then Exit;
  end;

  if (SelStop - SelStart) < 1 then Exit;

  Str := EditText;
  DeleteSelection(Str, SelStart, SelStop - SelStart);
  Str := Copy(Str, SelStart+1, SelStop - SelStart);
  SendMessage(Handle, EM_REPLACESEL, 0, LongInt(PChar(Str)));
  if (SelStop - SelStart) <> 1 then
  begin
    SelStart := GetNextEditChar(SelStart);
    SetCursor(SelStart);
  end
  else begin
    GetSel(SelStart, SelStop);
    SetCursor(SelStart - 1);
  end;
end;

function TdxInplaceMaskEdit.DeleteSelection(var Value: string; Offset: Integer;
  Len: Integer): Boolean;
var
  EndDel: Integer;
  StrOffset, MaskOffset, Temp: Integer;
  CType: TMaskCharType;
begin
  Result := True;
  if (Len = 0) or (Length(Value) = 0) then Exit;

  StrOffset := Offset + 1;
  EndDel := StrOffset + Len;
  Temp := OffsetToMaskOffset(EditMask, Offset);
  if Temp < 0 then  Exit;
  for MaskOffset := Temp to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
      Inc(StrOffset)
    else if CType in [mcMask, mcMaskOpt] then
    begin
      Value[StrOffset] := FMaskBlank;
      Inc(StrOffset);
    end;
    if StrOffset >= EndDel then Break;
  end;
end;

function TdxInplaceMaskEdit.DoInputChar(var NewChar: Char; MaskOffset: Integer): Boolean;
var
  Dir: TMaskDirectives;
  Str: string;
  CType: TMaskCharType;

  {$IFDEF DELPHI3}
  function IsKatakana(const Chr: Byte): Boolean;
  begin
    Result := (SysLocale.PriLangID = LANG_JAPANESE) and (Chr in [$A1..$DF]);
  end;

  function TestChar(NewChar: Char): Boolean;
  var
    Offset: Integer;
  begin
    Offset := MaskOffsetToOffset(EditMask, MaskOffset);
    Result := not ((MaskOffset < Length(EditMask)) and
               (UpCase(EditMask[MaskOffset]) = UpCase(EditMask[MaskOffset+1]))) or
               (ByteType(EditText, Offset) = mbTrailByte) or
               (ByteType(EditText, Offset+1) = mbLeadByte);
  end;
  {$ENDIF}

begin
  Result := True;
  CType := MaskGetCharType(EditMask, MaskOffset);
  if CType in [mcLiteral, mcIntlLiteral] then
    NewChar := MaskIntlLiteralToChar(EditMask[MaskOffset])
  else
  begin
    Dir := MaskGetCurrentDirectives(EditMask, MaskOffset);
    case EditMask[MaskOffset] of
      mMskNumeric, mMskNumericOpt:
        begin
          if not ((NewChar >= '0') and (NewChar <= '9')) then
            Result := False;
        end;
      mMskNumSymOpt:
        begin
          if not (((NewChar >= '0') and (NewChar <= '9')) or
                 (NewChar = ' ') or(NewChar = '+') or(NewChar = '-')) then
            Result := False;
        end;
      mMskAscii, mMskAsciiOpt:
        begin
         {$IFDEF DELPHI3}
          if (NewChar in LeadBytes) and TestChar(NewChar) then
          begin
            Result := False;
            Exit;
          end;
          {$ENDIF}
          if IsCharAlpha(NewChar) then
          begin
            Str := ' ';
            Str[1] := NewChar;
            if (mdUpperCase in Dir)  then
              Str := AnsiUpperCase(Str)
            else if mdLowerCase in Dir then
              Str := AnsiLowerCase(Str);
            NewChar := Str[1];
          end;
        end;
      mMskAlpha, mMskAlphaOpt, mMskAlphaNum, mMskAlphaNumOpt:
        begin
         {$IFDEF DELPHI3}
          if (NewChar in LeadBytes) then
          begin
            if TestChar(NewChar) then
              Result := False;
            Exit;
          end;
          {$ENDIF}
          Str := ' ';
          Str[1] := NewChar;
         {$IFDEF DELPHI3}
          if IsKatakana(Byte(NewChar)) then
          begin
              NewChar := Str[1];
              Exit;
          end;
         {$ENDIF}
          if not IsCharAlpha(NewChar) then
          begin
            Result := False;
            if ((EditMask[MaskOffset] = mMskAlphaNum) or
                (EditMask[MaskOffset] = mMskAlphaNumOpt)) and
                (IsCharAlphaNumeric(NewChar)) then
              Result := True;
          end
          else if mdUpperCase in Dir then
            Str := AnsiUpperCase(Str)
          else if mdLowerCase in Dir then
            Str := AnsiLowerCase(Str);
          NewChar := Str[1];
        end;
    end;
  end;
end;

function TdxInplaceMaskEdit.FindLiteralChar(MaskOffset: Integer; InChar: Char): Integer;
var
  CType: TMaskCharType;
  LitChar: Char;
begin
  Result := -1;
  while MaskOffset < Length(EditMask) do
  begin
    Inc(MaskOffset);
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral] then
    begin
      LitChar := EditMask[MaskOffset];
      if CType = mcIntlLiteral then
        LitChar := MaskIntlLiteralToChar(LitChar);
      if LitChar = InChar then
        Result := MaskOffset;
      Exit;
    end;
  end;
end;

function TdxInplaceMaskEdit.GetEditText: string;
begin
  Result := inherited Text;
end;

function TdxInplaceMaskEdit.GetMasked: Boolean;
begin
  Result := EditMask <> '';
end;

function TdxInplaceMaskEdit.GetText: string;
begin
  if not IsMasked then
    Result := inherited Text
  else
  begin
    Result := RemoveEditFormat(EditText);
    if FMaskSave then
      Result := AddEditFormat(Result, False);
  end;
end;

procedure TdxInplaceMaskEdit.HomeEndKeys(CharCode: Word; Shift: TShiftState);
var
  SelStart, SelStop : Integer;
begin
  GetSel(SelStart, SelStop);
  if (CharCode = VK_HOME) then
  begin
    if (ssShift in Shift) then
    begin
      if (SelStart <> FCaretPos) and (SelStop <> (SelStart + 1)) then
        SelStop := SelStart + 1;
      SetSel(0, SelStop);
      CheckCursor;
    end
    else
      SetCursor(0);
    FCaretPos := 0;
  end
  else
  begin
    if (ssShift in Shift) then
    begin
      if (SelStop <> FCaretPos) and (SelStop <> (SelStart + 1)) then
        SelStart := SelStop - 1;
      SetSel(SelStart, FMaxChars);
      CheckCursor;
    end
    else
      SetCursor(FMaxChars);
    FCaretPos := FMaxChars;
  end;
end;

function TdxInplaceMaskEdit.InputChar(var NewChar: Char; Offset: Integer): Boolean;
var
  MaskOffset: Integer;
  CType: TMaskCharType;
  InChar: Char;
begin
  Result := True;
  if EditMask <> '' then
  begin
    Result := False;
    MaskOffset := OffsetToMaskOffset(EditMask, Offset);
    if MaskOffset >= 0 then
    begin
      CType := MaskGetCharType(EditMask, MaskOffset);
      InChar := NewChar;
      Result := DoInputChar(NewChar, MaskOffset);
      if not Result and (CType in [mcMask, mcMaskOpt]) then
      begin
        MaskOffset := FindLiteralChar (MaskOffset, InChar);
        if MaskOffset > 0 then
        begin
          MaskOffset := MaskOffsetToOffset(EditMask, MaskOffset);
          SetCursor (MaskOffset);
          Exit;
        end;
      end;
    end;
  end;
  if not Result then
    MessageBeep(0)
end;

function TdxInplaceMaskEdit.InputString(var Value: string; const NewValue: string;
  Offset: Integer): Integer;
var
  NewOffset, MaskOffset, Temp: Integer;
  CType: TMaskCharType;
  NewVal: string;
  NewChar: Char;
begin
  Result := Offset;
  if NewValue = '' then Exit;
  { replace chars with new chars, except literals }
  NewOffset := 1;
  NewVal := NewValue;
  Temp := OffsetToMaskOffset(EditMask, Offset);
  if Temp < 0 then  Exit;
  MaskOffset := Temp;
  While MaskOffset <= Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral, mcMask, mcMaskOpt] then
    begin
      NewChar := NewVal[NewOffset];
      if not (DoInputChar(NewChar, MaskOffset)) then
      begin
        {$IFDEF DELPHI3}
        if (NewChar in LeadBytes) then
          NewVal[NewOffset + 1] := FMaskBlank;
        {$ENDIF}
        NewChar := FMaskBlank;
      end;
        { if pasted text does not contain a literal in the right place,
          insert one }
      if not ((CType in [mcLiteral, mcIntlLiteral]) and
        (NewChar <> NewVal[NewOffset])) then
      begin
        NewVal[NewOffset] := NewChar;
        {$IFDEF DELPHI3}
        if (NewChar in LeadBytes) then
        begin
          Inc(NewOffset);
          Inc(MaskOffset);
        end;
        {$ENDIF}
      end
      else
        NewVal := Copy(NewVal, 1, NewOffset-1) + NewChar +
          Copy(NewVal, NewOffset, Length (NewVal));
      Inc(NewOffset);
    end;
    if (NewOffset + Offset) > FMaxChars then Break;
    if (NewOffset) > Length(NewVal) then Break;
    Inc(MaskOffset);
  end;

  if (Offset + Length(NewVal)) < FMaxChars then
  begin
   {$IFDEF DELPHI3}
    if ByteType(Value, OffSet + Length(NewVal) + 1) = mbTrailByte then
    begin
      NewVal := NewVal + FMaskBlank;
      Inc(NewOffset);
    end;
   {$ENDIF}
    Value := Copy(Value, 1, Offset) + NewVal +
      Copy(Value, OffSet + Length(NewVal) + 1,
        FMaxChars -(Offset + Length(NewVal)));
  end
  else
  begin
    Temp := Offset;
   {$IFDEF DELPHI3}
    if (ByteType(NewVal, FMaxChars - Offset) = mbLeadByte) then
      Inc(Temp);
   {$ENDIF}
    Value := Copy(Value, 1, Offset) +
             Copy(NewVal, 1, FMaxChars - Temp);
  end;
  Result := NewOffset + Offset - 1;
end;

function TdxInplaceMaskEdit.IsEditMaskStored: Boolean;
begin
  Result := svEditMask in StoredValues; 
end;

function TdxInplaceMaskEdit.RemoveEditFormat(const Value: string): string;
var
  I: Integer;
  OldLen: Integer;
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
  Dir: TMaskDirectives;
begin
  Offset := 1;
  Result := Value;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);

    if CType in [mcLiteral, mcIntlLiteral] then
      Result := Copy(Result, 1, Offset - 1) +
        Copy(Result, Offset + 1, Length(Result) - Offset);
    if CType in [mcMask, mcMaskOpt] then Inc(Offset);
  end;

  Dir := MaskGetCurrentDirectives(EditMask, 1);
  if mdReverseDir in Dir then
  begin
    Offset := 1;
    for I := 1 to Length(Result) do
    begin
      if Result[I] = FMaskBlank then
        Inc(Offset)
      else
        break;
    end;
    if Offset <> 1 then
      Result := Copy(Result, Offset, Length(Result) - Offset + 1);
  end
  else begin
    OldLen := Length(Result);
    for I := 1 to OldLen do
    begin
      if Result[OldLen - I + 1] = FMaskBlank then
        SetLength(Result, Length(Result) - 1)
      else Break;
    end;
  end;
  if FMaskBlank <> ' ' then
  begin
    OldLen := Length(Result);
    for I := 1 to OldLen do
    begin
      if Result[I] = FMaskBlank then
        Result[I] := ' ';
      if I > OldLen then Break;
    end;
  end;
end;

procedure TdxInplaceMaskEdit.SetEditText(const Value: string);
begin
  if GetEditText <> Value then
  begin
    SetTextBuf(PChar(Value));
    CheckCursor;
  end;
end;

procedure TdxInplaceMaskEdit.SetEditMask(const Value: string);
begin
  Include(FStoredValues, svEditMask);
  SetEditEditMask(Value);
end;

procedure TdxInplaceMaskEdit.SetText(const Value: string);
var
  OldText: string;
begin
  if not IsMasked then
    inherited Text := Value
  else
  begin
    OldText := Value;
    if FMaskSave then
      OldText := PadInputLiterals(EditMask, OldText, FMaskBlank)
    else
      OldText := AddEditFormat(OldText, True);
    EditText := OldText;
  end;
end;

function TdxInplaceMaskEdit.Validate(const Value: string; var Pos: Integer): Boolean;
var
  Offset, MaskOffset: Integer;
  CType: TMaskCharType;
begin
  Result := True;
  Offset := 1;
  for MaskOffset := 1 to Length(EditMask) do
  begin
    CType := MaskGetCharType(EditMask, MaskOffset);
    if CType in [mcLiteral, mcIntlLiteral, mcMaskOpt] then
      Inc(Offset)
    else if (CType = mcMask) and (Value <> '') then
    begin
      if ((Value [Offset] = FMaskBlank) and not IgnoreMaskBlank)or
        ((Value [Offset] = ' ') and (EditMask[MaskOffset] <> mMskAscii)) then
      begin
        Result := False;
        Pos := Offset - 1;
        Exit;
      end;
      Inc(Offset);
    end;
  end;
end;

procedure TdxInplaceMaskEdit.WMClear(var Message);
var
  Str, S: string;
  SelStart, SelStop : Integer;
begin
  if not IsMasked then
    inherited
  else
  begin
    if not EditCanModify then Exit;
    if not Modified then 
      S := EditText
    else S := PrevTextValue;
    Str := EditText;
    SelectAll;
    GetSel(SelStart, SelStop);
    DeleteSelection(Str, SelStart, SelStop - SelStart);
    EditText := Str;
    SelStart := InputString(Str, '', SelStart);
    EditText := Str;
    PrevTextValue := S;
    Modified := True;
    CheckCursor;
  end;
end;

procedure TdxInplaceMaskEdit.WMCut(var Message: TMessage);
begin
  if not IsMasked then
    inherited
  else
  begin
    if not EditCanModify then Exit;
    CopyToClipboard;
    ClearSelection;
  end;
end;

procedure TdxInplaceMaskEdit.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FBtnDownX := Message.XPos;
end;

procedure TdxInplaceMaskEdit.WMLButtonUp(var Message: TWMLButtonUp);
var
  SelStart, SelStop: Integer;
begin
  inherited;
  if IsMasked then
  begin
    GetSel(SelStart, SelStop);
    FCaretPos := SelStart;
    if (SelStart <> SelStop) and (Message.XPos > FBtnDownX) then
      FCaretPos := SelStop;
    CheckCursor;
  end;
end;

procedure TdxInplaceMaskEdit.WMPaste(var Message: TMessage);
var
  Value: string;
  Str, S: string;
  SelStart, SelStop : Integer;
begin
  if not IsMasked or not CanModify then
    inherited
  else
  begin
    if not EditCanModify then Exit;
    Clipboard.Open;
    Value := Clipboard.AsText;
    Clipboard.Close;
    if not Modified then 
      S := EditText
    else S := PrevTextValue;
    GetSel(SelStart, SelStop);
    Str := EditText;
    DeleteSelection(Str, SelStart, SelStop - SelStart);
    EditText := Str;
    SelStart := InputString(Str, Value, SelStart);
    EditText := Str;
    SetCursor(SelStart);
    PrevTextValue := S;
    Modified := True;
    ValidateEdit;
  end;
end;

procedure TdxInplaceMaskEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if IsMasked then
    CheckCursor;
end;

procedure TdxInplaceMaskEdit.CMEnter(var Message: TCMEnter);
begin
  if IsMasked and not (csDesigning in ComponentState) then
  begin
    if not (msReEnter in FMaskState) then
      inherited; // Save to PrevTextValue 
    Exclude(FMaskState, msReEnter);
    CheckCursor;
  end
  else
    inherited;
end;

procedure TdxInplaceMaskEdit.CMTextChanged(var Message: TMessage);
var
  SelStart, SelStop : Integer;
  Temp: Integer;
begin
  inherited;
  if HandleAllocated then
  begin
    GetSel(SelStart, SelStop);
    Temp := GetNextEditChar(SelStart);
    if Temp <> SelStart then
      SetCursor(Temp);
  end;
end;

procedure TdxInplaceMaskEdit.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_ESCAPE) and IsMasked and Modified then
    Message.Result := 1;
end;

procedure TdxInplaceMaskEdit.CNCommand(var Message: TWMCommand);
begin
  // check text length
  if (Message.NotifyCode = EN_CHANGE) and not FCreating and
    IsMasked and (Length(EditText) <> GetMaxChars) then
      begin
        Text := EditText;
        Modified := True;
      end;
  inherited;
end;

procedure TdxInplaceMaskEdit.EMReplaceSel(var Message: TMessage);
begin
  if IsMasked and (DWORD(SelLength) <> StrLen(PChar(Message.LParam))) then Exit;
  inherited;
end;

{$IFDEF DELPHI4}
{ TdxEditAction }
function TdxEditAction.GetEdit(Target: TObject): TdxInplaceTextEdit;
begin
  Result := Target as TdxInplaceTextEdit;
end;

function TdxEditAction.HandlesTarget(Target: TObject): Boolean;
begin
  Result := inherited HandlesTarget(Target);
  if not Result then
    Result := ((Edit <> nil) and (Target = Edit) or
      (Edit = nil) and (Target is TdxInplaceTextEdit)) and
      TdxInplaceTextEdit(Target).Focused and
      TdxInplaceTextEdit(Target).IsSupportedAction;
end;

procedure TdxEditAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = Edit) then Edit := nil;
end;

type
  TCustomEditCrack = class(TCustomEdit);

procedure TdxEditAction.UpdateTarget(Target: TObject);
var
  B: Boolean;
begin
  if (Self is TdxEditPaste) then
  begin
    B := Clipboard.HasFormat(CF_TEXT);
    if Target is TCustomEdit then
      Enabled := B and not TCustomEditCrack(Target).ReadOnly
    else
      if Target is TdxInplaceTextEdit then
        Enabled := GetEdit(Target).CanPaste;
  end
  else
    if (Self is TdxEditCut) or (Self is TdxEditCopy) or (Self is TdxEditClear) then
    begin
      if (Target is TCustomEdit) then
      begin
        B := (Target as TCustomEdit).SelLength > 0;
        Enabled := B and ((Self is TdxEditCopy) or not TCustomEditCrack(Target).ReadOnly)
      end
      else
        if Target is TdxInplaceTextEdit then
        begin
          B := GetEdit(Target).SelLength > 0;
          Enabled := B and ((Self is TdxEditCopy) or GetEdit(Target).CanModify);
        end;
    end
    else
      if Self is TdxEditSelectAll then
      begin
        if Target is TCustomEdit then
          Enabled := (Target as TCustomEdit).SelLength <> (Target as TCustomEdit).GetTextLen
        else
          if Target is TdxInplaceTextEdit then
            Enabled := GetEdit(Target).SelLength <> GetEdit(Target).GetTextLenEx;
      end
      else
        if Self is TdxEditUndo then
        begin
          if Target is TCustomEdit then
            Enabled := (Target as TCustomEdit).CanUndo
          else
            if Target is TdxInplaceTextEdit then
              Enabled := GetEdit(Target).CanUndo;
        end
        else
          if Self is TdxEditRedo then
          begin
            if Target is TdxInplaceTextEdit then
              Enabled := GetEdit(Target).CanRedo;
          end;
end;

procedure TdxEditAction.SetEdit(Value: TdxInplaceTextEdit);
begin
  if Value <> FEdit then
  begin
    FEdit := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

{ TdxEditCopy }
procedure TdxEditCopy.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).CopyToClipboard
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).CopyToClipboard
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditCut }
procedure TdxEditCut.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).CutToClipboard
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).CutToClipboard
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditPaste }
procedure TdxEditPaste.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).PasteFromClipboard
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).PasteFromClipboard
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditClear }
procedure TdxEditClear.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).ClearSelection
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).ClearSelection
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditSelectAll }
procedure TdxEditSelectAll.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).SelectAll
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).SelectAll
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditUndo }
procedure TdxEditUndo.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).Undo
  else
    if Target is TCustomEdit then
      (Target as TCustomEdit).Undo
    else
      inherited ExecuteTarget(Target);
end;

{ TdxEditRedo }
procedure TdxEditRedo.ExecuteTarget(Target: TObject);
begin
  if Target is TdxInplaceTextEdit then
    GetEdit(Target).Redo
  else
    inherited ExecuteTarget(Target);
end;
{$ENDIF}

const
  RichEditModuleName = 'RICHED20.DLL';
var
  OldError: Longint;
  FLibHandle: THandle;

initialization
  OldError := SetErrorMode(SEM_NOOPENFILEERRORBOX);
  FLibHandle := LoadLibrary(RichEditModuleName);
  if (FLibHandle > 0) and (FLibHandle < HINSTANCE_ERROR) then FLibHandle := 0;
  SetErrorMode(OldError);

  sdxEditUndoCaption := LoadStr(dxSEditUndoCaption);
  sdxEditRedoCaption := LoadStr(dxSEditRedoCaption); 
  sdxEditCutCaption := LoadStr(dxSEditCutCaption);
  sdxEditCopyCaption := LoadStr(dxSEditCopyCaption);
  sdxEditPasteCaption := LoadStr(dxSEditPasteCaption);
  sdxEditDeleteCaption := LoadStr(dxSEditDeleteCaption);
  sdxEditSelectAllCaption := LoadStr(dxSEditSelectAllCaption);

finalization
  if FLibHandle <> 0 then FreeLibrary(FLibHandle);

end.
