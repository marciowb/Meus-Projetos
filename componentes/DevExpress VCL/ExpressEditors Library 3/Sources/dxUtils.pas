
{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       Express inplace editors utils unit                          }
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

unit dxUtils;

interface

{$I dxEdVer.inc}

uses
  SysUtils, Messages, Windows, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, CommCtrl{$IFDEF DELPHI4}, ImgList {$ENDIF};

const
  // DrawTextRect() Format Flags
  // Alignment
  DX_DTR_LEFT             = 0;
  DX_DTR_CENTER           = 1;
  DX_DTR_RIGHT            = 2;
  // DrawAlignment
  DX_DTR_SINGLELINE       = 0;
  DX_DTR_TOP              = 0;
  DX_DTR_VCENTER          = 4;
  DX_DTR_BOTTOM           = 8;
  DX_DTR_MULTILINE        = $10;
  // Other
  DX_DTR_END_ELLIPSIS     = $100;
  DX_DTR_PATH_ELLIPSIS    = $200;
  DX_DTR_FOCUS_RECT       = $400;
  DX_DTR_EXACT_FOCUS_RECT = $800;
  DX_DTR_TRANSPARENT      = $1000;
  DX_DTR_PREFIX           = $2000;
  DX_DTR_CALCRECT         = $4000;
  DX_DTR_NOTRANSPARENTBKG = $8000;
  // Mask
  DX_DTR_ALIGNMENT_MASK     = DX_DTR_LEFT or DX_DTR_CENTER or DX_DTR_RIGHT;
  DX_DTR_DRAWALIGNMENT_MASK = DX_DTR_TOP or DX_DTR_VCENTER or DX_DTR_BOTTOM or DX_DTR_MULTILINE;
  DX_DTR_DRAWTEXT_MASK      = DX_DTR_END_ELLIPSIS or DX_DTR_PATH_ELLIPSIS or DX_DTR_MULTILINE;
  DX_DTR_HARD_MASK          = DX_DTR_PREFIX or DX_DTR_MULTILINE; // TODO !!!

type
  { TdxRegIniWrapper }

  TdxRegIniWrapper = class
  private
    FRegIniObject: TObject;
  public
    function ReadBinaryData(const Section, Ident: string; var Buffer; BufSize: Integer): Integer;
    procedure WriteBinaryData(const Section, Ident: string; var Buffer; BufSize: Integer);
    function ReadString(const Section, Ident, Default: string): string;
    procedure WriteString(const Section, Ident, Value: string);
    function ReadInteger(const Section, Ident: string; Default: Longint): Longint;
    procedure WriteInteger(const Section, Ident: string; Value: Longint);
    function ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
    procedure WriteBool(const Section, Ident: string; Value: Boolean);
    procedure ReadSection(const Section: string; Strings: TStrings);
    procedure ReadSections(Strings: TStrings);
    procedure ReadSectionValues(const Section: string; Strings: TStrings);
    procedure EraseSection(const Section: string);
    procedure DeleteKey(const Section, Ident: string);
    procedure Erase(const Path: string);
    property RegIniObject: TObject read FRegIniObject write FRegIniObject;
  end;

procedure CheckDrawBitmap(Bitmap: TBitmap; W, H: Integer);
procedure ShadeRect(DC: HDC; ARect: TRect; ABkColor: TColorRef);
procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; const R: TRect; ABitmap: TBitmap);
procedure TransparentDrawEx(DrawDC: HDC; Brush: HBRUSH; const FullRect, R: TRect; ABitmap: TBitmap);
function DrawTextRect(DC: HDC; const S: string; Len: Integer;
  const R, IndentRect: TRect; Format: UINT;
  Brush: HBRUSH; Font: HFONT; BkColor, TextColor: TColorRef;
  PLineTextHeight: PInteger): Integer;
procedure CheckScreenPosition(var P: TPoint; PopupWidth, PopupHeight, EditHeight: Integer);
procedure DrawImage(DC: HDC; X, Y, Index: Integer; ImageList: TImageList);
procedure DrawShadow(DC: HDC; ShadowRect: TRect; ShadowSize: Integer; Brush: HBRUSH);
function GetScreenWorkArea(const P: TPoint): TRect;

var
  HalftoneBrush: HBRUSH;
  ShadowBrush: HBRUSH;

implementation

uses
  Registry, IniFiles{$IFDEF DELPHI4}, MultiMon{$ENDIF};

procedure CheckDrawBitmap(Bitmap: TBitmap; W, H: Integer);
begin
  with Bitmap do
  begin
    if (Width < W) then Width := W;
    if (Height < H) then Height := H;
  end;
end;

procedure ShadeRect(DC: HDC; ARect: TRect; ABkColor: TColorRef);
var
  rcRect: TRect;
  nWidth, nHeight: Integer;
  PrevMemBitmap, Bitmap: HBITMAP;
  MemDC: HDC;
  PrevTextColor, PrevBkColor: TColor;
begin
  rcRect := ARect;
  OffsetRect(rcRect, -rcRect.Left, -rcRect.Top);
  nWidth := ARect.Right - ARect.Left;
  nHeight := ARect.Bottom - ARect.Top;
  // bitmap
  Bitmap := CreateCompatibleBitmap(DC, nWidth, nHeight);
  MemDC := CreateCompatibleDC(DC);
  PrevMemBitmap := SelectObject(MemDC, Bitmap);
  // draw pattern
  SetTextColor(MemDC, 0);
  SetBkColor(MemDC, $FFFFFF);
  FillRect(MemDC, rcRect, HalftoneBrush);
  BitBlt(MemDC, 0, 0, nWidth, nHeight, DC, ARect.Left, ARect.Top, SRCAND);
  // draw highlight pattern
//  PrevTextColor := SetTextColor(DC, GetSysColor(COLOR_HIGHLIGHT));
  PrevTextColor := SetTextColor(DC, ABkColor);
  PrevBkColor := SetBkColor(DC, 0);
  FillRect(DC, ARect, HalftoneBrush);
  BitBlt(DC, ARect.Left, ARect.Top, nWidth, nHeight, MemDC, 0, 0, SRCPAINT);
  // restore colors
  SetTextColor(DC, PrevTextColor);
  SetBkColor(DC, PrevBkColor);
  // Clean up
  SelectObject(MemDC, PrevMemBitmap);
  DeleteObject(Bitmap);
  DeleteDC(MemDC);
end;

procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; const R: TRect; ABitmap: TBitmap);
const
  ROP_DSPDxax = $00E20746;
var
  BW, BH: Integer;
  DC, MaskDC: HDC;
  B, MaskHandle: HBITMAP;
  ATextColor, ABackColor: COLORREF;
  ABrush: HBRUSH;
begin
  with R do
  begin
    BW := ABitmap.Width;
    BH := ABitmap.Height;

    DC := CreateCompatibleDC(DrawDC);
    B := SelectObject(DC, CreateCompatibleBitmap(DrawDC, BW, BH));
    try
      BitBlt(DC, 0, 0, BW, BH, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);

      MaskDC := CreateCompatibleDC(DrawDC);
      MaskHandle := SelectObject(MaskDC, CreateBitmap(BW, BH, 1, 1, nil));
      try
        ABackColor := SetBkColor(DC, ColorToRGB(ABitmap.TransparentColor){GetPixel(DC, 0, BH - 1)});
        BitBlt(MaskDC, 0, 0, BW, BH, DC, 0, 0, SRCCOPY);
        SetBkColor(DC, ABackColor);

        ATextColor := SetTextColor(DC, 0);
        ABackColor := SetBkColor(DC, $FFFFFF);
        ABrush := SelectObject(DC, Brush);
        BitBlt(DC, 0, 0, BW, BH, MaskDC, 0, 0, ROP_DSPDxax);
        SelectObject(DC, ABrush);
        SetTextColor(DC, ATextColor);
        SetBkColor(DC, ABackColor);
      finally
        DeleteObject(SelectObject(MaskDC, MaskHandle));
        DeleteDC(MaskDC);
      end;

      BitBlt(DrawDC, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
    finally
      DeleteObject(SelectObject(DC, B));
      DeleteDC(DC);
    end;
  end;
end;

procedure TransparentDrawEx(DrawDC: HDC; Brush: HBRUSH; const FullRect, R: TRect; ABitmap: TBitmap);
const
  ROP_DSPDxax = $00E20746;
var
  X, Y, BW, BH: Integer;
  DC, MaskDC: HDC;
  B, MaskHandle: HBITMAP;
  ATextColor, ABackColor: COLORREF;
  ABrush: HBRUSH;
begin
  with FullRect do
  begin
    X := R.Left - Left;
    Y := R.Top - Top;
    BW := Right - Left;
    BH := Bottom - Top;

    DC := CreateCompatibleDC(DrawDC);
    B := SelectObject(DC, CreateCompatibleBitmap(DrawDC, BW, BH));
    try
      FillRect(DC, Rect(0, 0, BW, BH), Brush);
      BitBlt(DC, X, Y, R.Right - R.Left, R.Bottom - R.Top, ABitmap.Canvas.Handle, 0, 0, SRCCOPY);

      MaskDC := CreateCompatibleDC(DrawDC);
      MaskHandle := SelectObject(MaskDC, CreateBitmap(BW, BH, 1, 1, nil));
      try
        ABackColor := SetBkColor(DC, ColorToRGB(ABitmap.TransparentColor){GetPixel(DC, 0, BH - 1)});
        BitBlt(MaskDC, 0, 0, BW, BH, DC, 0, 0, SRCCOPY);
        SetBkColor(DC, ABackColor);

        ATextColor := SetTextColor(DC, 0);
        ABackColor := SetBkColor(DC, $00FFFFFF);
        ABrush := SelectObject(DC, Brush);
        BitBlt(DC, 0, 0, BW, BH, MaskDC, 0, 0, ROP_DSPDxax);
        SelectObject(DC, ABrush);
        SetTextColor(DC, ATextColor);
        SetBkColor(DC, ABackColor);
      finally
        DeleteObject(SelectObject(MaskDC, MaskHandle));
        DeleteDC(MaskDC);
      end;

      BitBlt(DrawDC, Left, Top, Right - Left, Bottom - Top, DC, 0, 0, SRCCOPY);
    finally
      DeleteObject(SelectObject(DC, B));
      DeleteDC(DC);
    end;
  end;
end;

function DrawTextRect(DC: HDC; const S: string; Len: Integer;
  const R, IndentRect: TRect; Format: UINT;
  Brush: HBRUSH; Font: HFONT; BkColor, TextColor: TColorRef;
  PLineTextHeight: PInteger): Integer;
const
  // TODO DT_EDITCONTROL ?
  AlignFlags: array [DX_DTR_LEFT..DX_DTR_RIGHT] of Integer = (DT_LEFT, DT_CENTER, DT_RIGHT);
  ClipFlags: array [Boolean] of Integer = (DT_NOCLIP, 0);
  EllipsisFlags: array [Boolean] of Integer = (0, DT_END_ELLIPSIS);
  PathEllipsisFlags: array [Boolean] of Integer = (0, DT_PATH_ELLIPSIS);
  PrefixFlags: array [Boolean] of Integer = (DT_NOPREFIX, 0);
var
  PrevFont: HFONT;
  PrevBkColor, PrevTextColor: TColorRef;
  PrevBkMode: Integer;
  Size: TSize;
  ClipFlag, DrawTextFlag: Boolean;
  FullRect, TextRect: TRect;
  DTFormat: Integer;
begin
  Result := 0;
  PrevFont := SelectObject(DC, Font);
  PrevBkColor := SetBkColor(DC, BkColor);
  PrevTextColor := SetTextColor(DC, TextColor);
  GetTextExtentPoint32(DC, PChar(S), Length(S), Size);
  if (Format and DX_DTR_CALCRECT <> 0) and (PLineTextHeight <> nil) then // Calculate
  begin
    PLineTextHeight^ := Size.CY;
    if Size.CY = 0 then Exit;
  end;  
  if Format and DX_DTR_HARD_MASK <> 0 then
  begin
    ClipFlag := True;
    DrawTextFlag := True;
  end
  else
  begin
    ClipFlag := Size.CX > (IndentRect.Right - IndentRect.Left);
    if not ClipFlag and ((Pos(#13, S) = 0) and (Pos(#10, S) = 0)) then
      DrawTextFlag := False                                   // TODO
    else
      DrawTextFlag := (Format and DX_DTR_DRAWTEXT_MASK) <> 0;
  end;
  TextRect := IndentRect;
  if not DrawTextFlag then
  begin
    FullRect := R;
    if ClipFlag then
      with FullRect do
      begin
        if Format and DX_DTR_TRANSPARENT = 0 then // not Transparent
          FillRect(DC, Rect(IndentRect.Right, Top, Right, Bottom), Brush);
        Right := IndentRect.Right;
      end;
    with TextRect do
    begin
      if not ClipFlag then
      begin
        case Format and DX_DTR_ALIGNMENT_MASK of
          DX_DTR_RIGHT:
            Left := Right - Size.CX;
          DX_DTR_CENTER: 
            Left := (Left + Right - Size.CX) shr 1;
        end;
        Right := Left + Size.CX;
      end;
      {
      if Format and DX_DTR_VCENTER <> 0 then // DrawAlignment = daVCenter
      begin
        Top := (Top + Bottom - Size.CY) shr 1;
        Bottom := Top + Size.CY;
      end;
      }
      case Format and DX_DTR_DRAWALIGNMENT_MASK of
        DX_DTR_VCENTER:
          begin
            Top := (Top + Bottom - Size.CY) shr 1;
            Bottom := Top + Size.CY;
          end;
        DX_DTR_BOTTOM:
          Top := Bottom - Size.CY;
      end;
    end;
    if Format and DX_DTR_CALCRECT = 0 then // not Calculate
    begin
      if Format and DX_DTR_TRANSPARENT <> 0 then // Transparent
      begin
        if Format and DX_DTR_NOTRANSPARENTBKG = 0 then // No Transparent Text Background
          PrevBkMode := SetBkMode(DC, Windows.TRANSPARENT)
        else PrevBkMode := 0;
        ExtTextOut(DC, TextRect.Left, TextRect.Top, ETO_CLIPPED,
          @FullRect, PChar(S), Len, nil);
        if PrevBkMode <> 0 then // No Transparent Text Background
          SetBkMode(DC, PrevBkMode);
      end
      else
        ExtTextOut(DC, TextRect.Left, TextRect.Top, ETO_CLIPPED or ETO_OPAQUE,
          @FullRect, PChar(S), Len, nil);
    end;
  end
  else
  begin
    DTFormat := DT_EXPANDTABS or AlignFlags[Format and DX_DTR_ALIGNMENT_MASK] or
      ClipFlags[ClipFlag] or PrefixFlags[Format and DX_DTR_PREFIX <> 0] or
      EllipsisFlags[Format and DX_DTR_END_ELLIPSIS <> 0] or
      PathEllipsisFlags[Format and DX_DTR_PATH_ELLIPSIS <> 0];
    case Format and DX_DTR_DRAWALIGNMENT_MASK of
      DX_DTR_VCENTER: DTFormat := DTFormat or DT_SINGLELINE or DT_VCENTER;
      DX_DTR_BOTTOM: DTFormat := DTFormat or DT_SINGLELINE or DT_BOTTOM;
      DX_DTR_MULTILINE: DTFormat := DTFormat or DT_WORDBREAK;
    else
      DTFormat := DTFormat or DT_SINGLELINE or DT_TOP;
    end;
    if Format and DX_DTR_CALCRECT <> 0 then // Calculate
      Size.CY := DrawText(DC, PChar(S), Len, TextRect, DTFormat or DT_CALCRECT)
    else
    begin
      if Format and DX_DTR_TRANSPARENT = 0 then // not Transparent
        FillRect(DC, R, Brush);
      if Format and DX_DTR_NOTRANSPARENTBKG = 0 then // No Transparent Text Background
        PrevBkMode := SetBkMode(DC, Windows.TRANSPARENT)
      else PrevBkMode := 0;
      DrawText(DC, PChar(S), Len, TextRect, DTFormat);
      if PrevBkMode <> 0 then
        SetBkMode(DC, PrevBkMode);
      if Format and (DX_DTR_FOCUS_RECT or DX_DTR_EXACT_FOCUS_RECT) =
        (DX_DTR_FOCUS_RECT or DX_DTR_EXACT_FOCUS_RECT) then // FocusRect and ExactFocusRect
      begin
        DrawText(DC, PChar(S), Len, TextRect, DTFormat or DT_CALCRECT);
        if Format and DX_DTR_MULTILINE = 0 then // not MultiLine
          TextRect.Top := TextRect.Bottom - Size.CY;
      end;
    end;
  end;
  if Format and DX_DTR_CALCRECT <> 0 then // Calculate
    Result := (R.Bottom - R.Top) - (IndentRect.Bottom - IndentRect.Top) + Size.CY
  else
    if Format and DX_DTR_FOCUS_RECT <> 0  then // FocusRect
    begin
      if Format and DX_DTR_EXACT_FOCUS_RECT = 0 then // not ExactFocusRect
        TextRect := IndentRect;
      if (Len > 0) or (Format and DX_DTR_EXACT_FOCUS_RECT = 0) then
      begin
        InflateRect(TextRect, 1, 1);
        SetBkColor(DC, clBlack);
        SetTextColor(DC, clWhite);
        DrawFocusRect(DC, TextRect);
      end;
    end;
  SetTextColor(DC, PrevTextColor);
  SetBkColor(DC, PrevBkColor);
  SelectObject(DC, PrevFont);
end;

procedure CheckScreenPosition(var P: TPoint; PopupWidth, PopupHeight, EditHeight: Integer);
var
  R: TRect;
begin
  R := GetScreenWorkArea(P);
  if P.X < R.Left then P.X := R.Left;
  if P.X + PopupWidth > R.Right then P.X := R.Right - PopupWidth;
  if (P.Y + PopupHeight > (R.Bottom - R.Top)) and
    ((R.Bottom - (P.Y + EditHeight)) < (P.Y - R.Top)) then
    P.Y := P.Y - (PopupHeight + EditHeight);
end;

procedure DrawImage(DC: HDC; X, Y, Index: Integer; ImageList: TImageList);

  function GetRGBColor(Value: TColor): DWORD;
  begin
    Result := ColorToRGB(Value);
    case Result of
      clNone: Result := CLR_NONE;
      clDefault: Result := CLR_DEFAULT;
    end;
  end;

const
  DrawingStyles: array[TDrawingStyle] of Longint = (ILD_FOCUS,
    ILD_SELECTED, ILD_NORMAL, ILD_TRANSPARENT);
  Images: array[TImageType] of Longint = (0, ILD_MASK);
begin
  with ImageList do
    if HandleAllocated then
      ImageList_DrawEx(Handle, Index, DC, X, Y, 0, 0,
        GetRGBColor(BkColor), GetRGBColor(BlendColor),
        DrawingStyles[DrawingStyle] or Images[ImageType]);
end;

procedure DrawShadow(DC: HDC; ShadowRect: TRect; ShadowSize: Integer; Brush: HBRUSH);
var
  R: TRect;
begin
  R := ShadowRect;
  R.Top := R.Bottom - ShadowSize;
  FillRect(DC, R, Brush);
  R.Left := R.Right - ShadowSize;
  R.Top := ShadowRect.Top;
  FillRect(DC, R, Brush);
end;

function GetScreenWorkArea(const P: TPoint): TRect;
{$IFDEF DELPHI4}
var
  MonitorHandle: HMONITOR;
  MonitorInfo: TMonitorInfo;
{$ENDIF}
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
  {$IFDEF DELPHI4}
  MonitorHandle := MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST);
  if MonitorHandle <> 0 then
  begin
    MonitorInfo.cbSize := SizeOf(MonitorInfo);
    if GetMonitorInfo(MonitorHandle, @MonitorInfo) then
      Result := MonitorInfo.rcWork;
  end;
  {$ENDIF}
end;

{ TdxRegIniWrapper }

type TRegistryWrapper = class(TRegistry);

function TdxRegIniWrapper.ReadBinaryData(const Section, Ident: string; var Buffer; BufSize: Integer): Integer;
var
  Key, OldKey: HKEY;
begin
  Result := 0;
  if FRegIniObject is TRegistry then
    with TRegistryWrapper(FRegIniObject) do
    begin
      Key := GetKey(Section);
      if Key <> 0 then
      try
        OldKey := CurrentKey;
        SetCurrentKey(Key);
        try
          if ValueExists(Ident) then
            if BufSize > 0 then
              Result := ReadBinaryData(Ident, Buffer, BufSize)
            else
              Result := GetDataSize(Ident);
        finally
          SetCurrentKey(OldKey);
        end;
      finally
        RegCloseKey(Key);
      end;
    end;
end;

procedure TdxRegIniWrapper.WriteBinaryData(const Section, Ident: string; var Buffer; BufSize: Integer);
var
  Key, OldKey: HKEY;
begin
  if FRegIniObject is TRegistry then
    with TRegistryWrapper(FRegIniObject) do
    begin
      CreateKey(Section);
      Key := GetKey(Section);
      if Key <> 0 then
      try
        OldKey := CurrentKey;
        SetCurrentKey(Key);
        try
          WriteBinaryData(Ident, Buffer, BufSize);
        finally
          SetCurrentKey(OldKey);
        end;
      finally
        RegCloseKey(Key);
      end;
    end;
end;

function TdxRegIniWrapper.ReadString(const Section, Ident, Default: string): string;
begin
  if FRegIniObject is TIniFile then
    Result := TIniFile(FRegIniObject).ReadString(Section, Ident, Default)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    Result := TMemIniFile(FRegIniObject).ReadString(Section, Ident, Default)
  else
  {$ENDIF}
    Result := TRegIniFile(FRegIniObject).ReadString(Section, Ident, Default);
end;

procedure TdxRegIniWrapper.WriteString(const Section, Ident, Value: string);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).WriteString(Section, Ident, Value)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).WriteString(Section, Ident, Value)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).WriteString(Section, Ident, Value);
end;

function TdxRegIniWrapper.ReadInteger(const Section, Ident: string; Default: Longint): Longint;
begin
  if FRegIniObject is TIniFile then
    Result := TIniFile(FRegIniObject).ReadInteger(Section, Ident, Default)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    Result := TMemIniFile(FRegIniObject).ReadInteger(Section, Ident, Default)
  else
  {$ENDIF}
    Result := TRegIniFile(FRegIniObject).ReadInteger(Section, Ident, Default);
end;

procedure TdxRegIniWrapper.WriteInteger(const Section, Ident: string; Value: Longint);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).WriteInteger(Section, Ident, Value)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).WriteInteger(Section, Ident, Value)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).WriteInteger(Section, Ident, Value);
end;

function TdxRegIniWrapper.ReadBool(const Section, Ident: string; Default: Boolean): Boolean;
begin
  if FRegIniObject is TIniFile then
    Result := TIniFile(FRegIniObject).ReadBool(Section, Ident, Default)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    Result := TMemIniFile(FRegIniObject).ReadBool(Section, Ident, Default)
  else
  {$ENDIF}
    Result := TRegIniFile(FRegIniObject).ReadBool(Section, Ident, Default);
end;

procedure TdxRegIniWrapper.WriteBool(const Section, Ident: string; Value: Boolean);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).WriteBool(Section, Ident, Value)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).WriteBool(Section, Ident, Value)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).WriteBool(Section, Ident, Value);
end;

procedure TdxRegIniWrapper.ReadSection(const Section: string; Strings: TStrings);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).ReadSection(Section, Strings)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).ReadSection(Section, Strings)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).ReadSection(Section, Strings);
end;

procedure TdxRegIniWrapper.ReadSections(Strings: TStrings);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).ReadSections(Strings)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).ReadSections(Strings)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).ReadSections(Strings);
end;

procedure TdxRegIniWrapper.ReadSectionValues(const Section: string; Strings: TStrings);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).ReadSectionValues(Section, Strings)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).ReadSectionValues(Section, Strings)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).ReadSectionValues(Section, Strings);
end;

procedure TdxRegIniWrapper.EraseSection(const Section: string);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).EraseSection(Section)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).EraseSection(Section)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).EraseSection(Section);
end;

procedure TdxRegIniWrapper.DeleteKey(const Section, Ident: string);
begin
  if FRegIniObject is TIniFile then
    TIniFile(FRegIniObject).DeleteKey(Section, Ident)
  else
  {$IFDEF DELPHI4}
  if FRegIniObject is TMemIniFile then
    TMemIniFile(FRegIniObject).DeleteKey(Section, Ident)
  else
  {$ENDIF}
    TRegIniFile(FRegIniObject).DeleteKey(Section, Ident);
end;

procedure TdxRegIniWrapper.Erase(const Path: string);
var
  Sections: TStrings;
  I: Integer;
begin
  // clear prev settings - only in ini-files
  if (FRegIniObject is TIniFile){$IFDEF DELPHI4} or (FRegIniObject is TMemIniFile){$ENDIF} then
  begin
    Sections := TStringList.Create;
    try
      ReadSections(Sections);
      for I := 0 to Sections.Count - 1 do
        if Copy(Sections[I], 1, Length(Path)) = Path then
          EraseSection(Sections[I]);
    finally
      Sections.Free;
    end;
  end;
end;

var
  DC: HDC;
  X, Y: Integer;
  Pattern: HBITMAP;

initialization
  // HalftoneBrush
  Pattern := CreateBitmap(8, 8, 1, 1, nil);
  DC := CreateCompatibleDC(0);
  Pattern := SelectObject(DC, Pattern);
  FillRect(DC, Rect(0, 0, 8, 8), GetStockObject(WHITE_BRUSH));
  for Y := 0 to 7 do
    for X := 0 to 7 do
      if (Y mod 2) = (X mod 2) then
        SetPixel(DC, X, Y, 0);
  Pattern := SelectObject(DC, Pattern);
  DeleteDC(DC);
  HalftoneBrush := CreatePatternBrush(Pattern);
  DeleteObject(Pattern);

finalization
  if HalftoneBrush <> 0 then DeleteObject(HalftoneBrush);

end.



