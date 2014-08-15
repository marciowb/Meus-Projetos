{*******************************************************************}
{                                                                   }
{       Developer Express Cross platform Visual Component Library   }
{       ExpressSpreadSheet				            }
{                                                                   }
{       Copyright (c) 2001-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSSPREADSHEET AND ALL           }
{   ACCOMPANYING VCL AND CLX CONTROLS AS PART OF AN EXECUTABLE      }
{   PROGRAM ONLY.                                                   }
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

unit cxSSEditors;
{$I cxVer.inc}
interface
uses
  Classes, SysUtils, Math,
  Windows, Messages, Forms, Graphics, StdCtrls, Controls, cxGraphics, cxControls;

type
  TcxSSInplaceEditClass = class of TcxSSInplaceTextEdit;

  { TcxSSInplaceTextEdit }
  TcxSSInplaceTextEdit = class(TCustomMemo)
  private
    FAutoWidth: Boolean;
    FIsInit: Boolean;
    FIsCellEditor: Boolean;
    FIsUpdate: Boolean;
    FMinimalWidth: Integer;
    FMinimalHeight: Integer;
    FOnEndEdit: TNotifyEvent;
    FValidText: string;
    FWantTab: Boolean;
    {$IFNDEF DELPHI4}
    function CaretPos: TPoint;
    {$ENDIF}
    function GetDisplayText: string;
    procedure SetDisplayText(AText: string);
    procedure SetMinimalHeight(const Value: Integer);
    procedure SetMinimalWidth(const Value: Integer);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    procedure Change; override;
    function CaretPosToSelStart(const APos: TPoint): Integer;
    procedure DoAutoSize; virtual;
    procedure DoEndEdit; virtual;
    procedure DoExit; override;
    procedure DoLineBreak; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    function TextExtents(AFont: TFont; const Text: TStrings): TSize;
    property CaretPos{$IFNDEF DELPHI4}: TPoint read GetCaretPos{$ENDIF};
  public
    constructor Create(AOwner: TComponent; IsCellEditor: Boolean = True); reintroduce; overload;
    function GetEditPos(const XPos, YPos: Integer): TPoint;
    procedure InitEditor(const AValidText, AText: string);
    procedure SetCursorPosition(const APos: TPoint); virtual;
    property AutoWidth: Boolean read FAutoWidth write FAutoWidth;
    property DisplayText: string read GetDisplayText write SetDisplayText;
    property MinimalWidth: Integer read FMinimalWidth write SetMinimalWidth;
    property MinimalHeight: Integer read FMinimalHeight write SetMinimalHeight;
    property WantTab: Boolean read FWantTab write FWantTab; 
    property Color;
    property Font;
    property OnEndEdit: TNotifyEvent read FOnEndEdit write FOnEndEdit;
    property OnChange;
  end;

implementation

uses
  dxCore;

type
  TWinControlAccess = class(TWinControl);
const
  BreakChars = #13#10;
  BreakLen: Integer = Length(BreakChars);

procedure KillMessage(Wnd: HWnd; Msg: Integer);
var
  M: TMsg;
begin
  M.Message := 0;
  if PeekMessage(M, Wnd, Msg, Msg, PM_REMOVE) and (M.Message = WM_QUIT) then
    PostQuitMessage(M.Wparam);
end;

{ TcxSSMultiLineTextEdit }
constructor TcxSSInplaceTextEdit.Create(AOwner: TComponent; IsCellEditor: Boolean = True);
begin
  inherited Create(AOwner);
  Visible := False;
  if (AOwner <> nil) and (AOwner is TWinControl) then
    Parent := AOwner as TWinControl;
  FAutoWidth := True;
  FIsCellEditor := IsCellEditor;
  FMinimalWidth := -1;
  FMinimalHeight := -1;
end;

function TcxSSInplaceTextEdit.GetEditPos(const XPos, YPos: Integer): TPoint;
var
  ACanvas: TcxScreenCanvas;
  S: string;
begin
  if XPos <= 0 then
    FillChar(Result, SizeOf(Result), 0)
  else
  begin
    ACanvas := TcxScreenCanvas.Create;
    Result.Y := Min(Lines.Count, YPos div ACanvas.TextHeight('Wg'));
    S := Lines[Result.Y];
    try
      ACanvas.Font.Assign(Font);
      if ACanvas.TextWidth(S) < XPos then
        Result.X := Length(S)
      else
      begin
        Result.X := 1;
        while ACanvas.TextWidth(Copy(S, 1, Result.X)) < (XPos - 2) do
          Inc(Result.X);
      end;
    finally
      ACanvas.Free;
    end;
  end;
end;

procedure TcxSSInplaceTextEdit.InitEditor(const AValidText, AText: string);
begin
  FIsInit := True;
  BorderStyle := bsNone; 
  try
    FValidText := AValidText;
    DisplayText := AText;
    Visible := True;
  finally
    SendToBack;
    FIsInit := False;
    DoAutoSize;
    BorderStyle := bsNone;
    WantReturns := True;
    WordWrap := False;
  end;
end;

procedure TcxSSInplaceTextEdit.SetCursorPosition(const APos: TPoint);
begin
  if HandleAllocated then
   SelStart := CaretPosToSelStart(APos);
end;

procedure TcxSSInplaceTextEdit.Change;
begin
  DoAutoSize;
  inherited;

//  Screen.Cursor := Screen.Cursor;
end;

function TcxSSInplaceTextEdit.CaretPosToSelStart(const APos: TPoint): Integer;
var
  I: Integer;
begin
  Result := APos.Y * 2;
  for I := 0 to Min(APos.Y, Lines.Count) - 1 do
    Inc(Result, Length(Lines[I]));
  Inc(Result, APos.X);
end;

procedure TcxSSInplaceTextEdit.DoAutoSize;
begin
  if FIsUpdate then
    FIsUpdate := False
  else
    if not FIsInit and FAutoWidth then
    begin
       with TextExtents(Font, Lines) do
       begin
         ClientWidth := CX + 2;
         ClientHeight := CY;
       end;
    end;
end;

procedure TcxSSInplaceTextEdit.DoEndEdit;
begin
  if Assigned(FOnEndEdit) then
    FOnEndEdit(Self);
  if Visible then
    Visible := False;
end;

procedure TcxSSInplaceTextEdit.DoExit;
begin
  DoEndEdit;
end;

procedure TcxSSInplaceTextEdit.DoLineBreak;
var
  S: string;
  ACaretPos: TPoint;
begin
  ACaretPos := CaretPos;
  with ACaretPos do
  begin
    if (Lines.Count = Y) or (X = 0) then
      Lines.Insert(Y, '')
    else
    begin
      S := Lines[Y];
      FIsUpdate := False;
      if X <> Length(S) then
      begin
        FIsUpdate := True;
        System.Insert(BreakChars, S, X + 1);
        Lines[Y] := S;
      end
      else
        Lines.Insert(Y + 1, '');
    end;
    KillMessage(Handle, WM_SYSCHAR);
    SelStart := CaretPosToSelStart(Point(0, Y + 1));
  end;
end;

procedure TcxSSInplaceTextEdit.KeyDown(var Key: Word; Shift: TShiftState);

  procedure CallOwnerKeyDown;
  begin
    if Owner is TWinControl then
    begin
      (Owner as TWinControl).SetFocus;
      TWinControlAccess(Owner).KeyDown(Key, Shift);
      Key := 0;
    end;
  end;
var
  S: string;
  APos: TPoint;

begin
  if Assigned(Owner) and (Owner is TWinControl) and Assigned(TWinControlAccess(Owner).OnKeyDown) then
    TWinControlAccess(Owner).OnKeyDown(Owner, Key, Shift);
  inherited KeyDown(Key, Shift);
  APos := CaretPos;
  S := Lines[APos.Y];
  case Key of
    VK_TAB:
      if not (ssCtrl in Shift) then
      begin
        if not WantTab then
          CallOwnerKeyDown;
      end;
    VK_RETURN:
      begin
        if FIsCellEditor then
        begin
          if not (ssAlt in Shift) then
            CallOwnerKeyDown
          else
            DoLineBreak;
        end;
      end;
    VK_UP:
      if FIsCellEditor and (APos.Y = 0) then
        CallOwnerKeyDown;
    VK_DOWN:
      if FIsCellEditor and (APos.Y = Lines.Count - 1) then
        CallOwnerKeyDown;
    VK_NEXT, VK_HOME:
      if FIsCellEditor then
        CallOwnerKeyDown;
    VK_LEFT:
      if FIsCellEditor and ((APos.X = 0) and (SelLength = 0)) then
        CallOwnerKeyDown;
    VK_RIGHT:
      if FIsCellEditor and ((APos.X = Length(S)) and (SelLength = 0)) then
        CallOwnerKeyDown;
    VK_ESCAPE:
      begin
        Text := FValidText;
        CallOwnerKeyDown;
      end;
  end;
end;

procedure TcxSSInplaceTextEdit.KeyPress(var Key: Char);
begin
  if Assigned(Owner) and (Owner is TWinControl) and Assigned(TWinControlAccess(Owner).OnKeyPress) then
    TWinControlAccess(Owner).OnKeyPress(Owner, Key);
  if dxCharInSet(Key, [#13, #9, #10]) then
    Key := #0
  else
    inherited;
end;

procedure TcxSSInplaceTextEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if Assigned(Owner) and (Owner is TWinControl) and Assigned(TWinControlAccess(Owner).OnKeyUp) then
    TWinControlAccess(Owner).OnKeyUp(Owner, Key, Shift);
  if (ssAlt in Shift) and (Key = vk_Return) then
    Key := 0
  else
    inherited;
end;

function TcxSSInplaceTextEdit.TextExtents(AFont: TFont; const Text: TStrings): TSize;
var
  ACanvas: TcxScreenCanvas;
  I, StartPos: Integer;
  MinSize: TSize;
  AStr: string;
  LineCount: Integer;
begin
  FillChar(Result, SizeOf(Result), 0);
  ACanvas := TcxScreenCanvas.Create();
  try
    ACanvas.Font.Assign(AFont);
    AStr := Text.Text;
    StartPos := 1;
    MinSize := ACanvas.TextExtent('W');
    while StartPos <= Length(AStr) do
    begin
      while (StartPos <= Length(AStr)) and dxCharInSet(AStr[StartPos], [#13, #10]) do
        Inc(StartPos);
      I := 0;
      while not dxCharInSet(AStr[StartPos + I], [#13, #10]) and (I < Length(AStr)) do
        Inc(I);
      if I > 0 then
      begin
        with ACanvas.TextExtent(Copy(AStr, StartPos, I)) do
        begin
          if Result.cx < cx then
            Result.cx := cx + MinSize.cx shr 1 ;
        end;
        Inc(StartPos, I);
      end;
    end;
  finally
    LineCount := 1;
    while Pos(BreakChars, AStr) <> 0 do
    begin
      Delete(AStr, Pos(BreakChars, AStr), BreakLen);
      Inc(LineCount);
    end;
    if Int64(Result) = 0 then
    begin
      Result := MinSize;
      Result.cx := Result.cx shr 1;
    end;
    Result.cy := ACanvas.TextExtent('Wg').cy * LineCount;
    if Result.cx < FMinimalWidth then
      Result.cx := FMinimalWidth;
    if Result.cy < FMinimalHeight then
      Result.cy := FMinimalHeight;
    ACanvas.Free;
  end;
end;

{$IFNDEF DELPHI4}
function TcxSSInplaceTextEdit.CaretPos: TPoint;
begin
  Result.X := LongRec(SendMessage(Handle, EM_GETSEL, 0, 0)).Hi;
  Result.Y := SendMessage(Handle, EM_LINEFROMCHAR, Result.X, 0);
  Result.X := Result.X - SendMessage(Handle, EM_LINEINDEX, -1, 0);
end;
{$ENDIF}

function TcxSSInplaceTextEdit.GetDisplayText: string;
begin
  Result := Text;
  while Pos(#$D, Result) <> 0 do
    Delete(Result, Pos(#$D, Result), 1);
end;

procedure TcxSSInplaceTextEdit.SetDisplayText(AText: string);
var
  I: Integer;
begin
  I := 1;
  while I <= Length(AText) do
  begin
    if AText[I] = #$A then
    begin
      System.Insert(#$D, AText, I);
      Inc(I);
    end;
    Inc(I);
  end;
  Text := AText;
end;

procedure TcxSSInplaceTextEdit.SetMinimalHeight(const Value: Integer);
begin
  if FMinimalHeight <> Value then
  begin
    FMinimalHeight := Value;
    DoAutoSize;
  end;
end;

procedure TcxSSInplaceTextEdit.SetMinimalWidth(const Value: Integer);
begin
  if FMinimalWidth <> Value then
  begin
    FMinimalWidth := Value;
    DoAutoSize;
  end;
end;

procedure TcxSSInplaceTextEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result :=
    DLGC_WANTALLKEYS + DLGC_WANTARROWS + DLGC_WANTCHARS + DLGC_WANTTAB;
end;

end.
