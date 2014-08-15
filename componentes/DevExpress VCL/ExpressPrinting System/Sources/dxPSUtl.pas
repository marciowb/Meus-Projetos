{*******************************************************************}
{                                                                   }
{       Developer Express Visual Component Library                  }
{       ExpressPrinting System COMPONENT SUITE                      }
{                                                                   }
{       Copyright (C) 1998-2010 Developer Express Inc.              }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSPRINTINGSYSTEM AND            }
{   ALL ACCOMPANYING VCL CONTROLS AS PART OF AN                     }
{   EXECUTABLE PROGRAM ONLY.                                        }
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

unit dxPSUtl;

interface

{$I cxVer.inc}

uses
 {$IFDEF DELPHI6}
  Variants,
 {$ENDIF}
  Classes, Windows, SysUtils, Graphics, Messages, Controls, StdCtrls, ComCtrls,
  Dialogs, CommCtrl, Forms, Menus, ImgList, TypInfo, Registry,
  dxCore, cxClasses, cxControls, cxGraphics, dxPSGlbl, dxPrnDev;

const
  // Marlett Font                    
  CheckMarkIndex = 98;
  CheckTopLeftArcOuterIndex = 99;
  CheckBottomRightArcOuterIndex = 100;
  CheckTopLeftArcInnerIndex = 101;
  CheckBottomRightArcInnerIndex = 102;
  CheckInteriorIndex = 103;
    
  RadioBeanIndex = 105;
  RadioTopLeftArcOuterIndex = 106;
  RadioBottomRightArcOuterIndex = 107;
  RadioTopLeftArcInnerIndex = 108;
  RadioBottomRightArcInnerIndex = 109;
  RadioInteriorIndex = 110;

  SortUpMarkIndex = 116;
  SortDownMarkIndex = 117;

  // Symbol Font
  PlusSignIndex = 43;
  MinusSignIndex = 45;    
    
  InvalidFileNameChars = '<>:"|/\';
    
function Min(A, B: Integer): Integer;
function Max(A, B: Integer): Integer;
function MinMax(A, B, C: Integer): Integer;
function SetLoWord(AValue: Integer; ALoWord: Word): Integer;
function SetHiWord(AValue: Integer; AHiWord: Word): Integer;
function SetLoHiWords(AValue: Integer; ALoWord, AHiWord: Word): Integer;
function ScalePoint(const Pt: TPoint; Numerator, Denominator: Integer): TPoint;
function ScaleRect(const R: TRect; ANumeratorW, ADenominatorW, ANumeratorH, ADenominatorH: Integer): TRect; overload;
function ScaleRect(const R: TRect; ANumerator, ADenominator: Integer): TRect; overload;
function ArePointsEqual(const Pt1, Pt2: TPoint): Boolean;

// GDI
function GetRgnData(ARgn: HRGN; out ARgnDataHeader: TRgnDataHeader; out ARects: TRects): Integer;
function ExcludeClipRect(DC: HDC; const R: TRect): HRGN; overload;
function ExcludeClipRect(DC: HDC; ALeft, ATop, ARight, ABottom: Integer): HRGN; overload;
function IntersectClipRect(DC: HDC; const R: TRect; AlwaysClip: Boolean = False): HRGN; overload;
function IntersectClipRect(DC: HDC; ALeft, ATop, ARight, ABottom: Integer; AlwaysClip: Boolean = False): HRGN; overload;
function RectVisible(DC: HDC; const ARect: TRect): Boolean;
procedure RestoreClipRgn(DC: HDC; var ARgn: HRGN);

function dxAreBitmapsEqual(ABitmap1, ABitmap2: TBitmap): Boolean;
function dxAreBrushesEqual(ABrush1, ABrush2: TBrush): Boolean;
function dxAreGraphicsEqual(AGraphic1, AGraphic2: TGraphic): Boolean;
function dxAreFontsEqual(AFont1, AFont2: TFont): Boolean;
function dxArePensEqual(APen1, APen2: TPen): Boolean;
function dxIsTrueTypeFont(AFont: TFont): Boolean;

function FindNearestColor(AColor: TColor): TColor;
function InvertColor(AColor: TColor): TColor;
function OffsetColor(AColor: TColor; ARed, AGreen, ABlue: Byte): TColor;

function IsDisplayDC(DC: HDC): Boolean;
function IsMetafileDC(DC: HDC): Boolean;
function IsPrinterDC(DC: HDC): Boolean;

function PatternBrush: HBRUSH;
procedure SetFontAsNonAntialiased(AFont: TFont);
procedure ForcePictureToBitmap(APicture: TPicture);

function CreateGraphic(AGraphicClass: TGraphicClass): TGraphic;
function IconToBitmap(AnIcon: TIcon): TBitmap;
function CreateArrowBitmap(AUpDownGlyph: TdxUpDownGlyph; AWidth: Integer  = 16;
  AHeight: Integer = 16; AFontSize: Integer = 12): TBitmap;
function CreateDoubleArrowBitmap(AUpDownGlyph: TdxUpDownGlyph; AWidth: Integer  = 16;
  AHeight: Integer = 16; AFontSize: Integer = 8): TBitmap;
function CreateGlyphBitmap(AGlyphIndex: Integer; AWidth: Integer = 16;
  AHeight: Integer = 16; AFontSize: Integer = 12): TBitmap;
procedure DrawBlendedText(ACanvas: TCanvas; const R: TRect; const AText: string; AFont: TFont);
procedure DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
procedure DrawSizeGrip(DC: HDC; R: TRect);
procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; const R: TRect; ABitmap: TBitmap);

// System
function CopyDeviceMode(Src: HGLOBAL): HGLOBAL;
function GetDesktopWorkArea: TRect; overload;
function GetDesktopWorkArea(const P: TPoint): TRect; overload;
function GetLongFileName(const Source: string): string;
function GetMachineName: string;
function GetUserName: string;
function GetVolumeName(const APath: string): string;
function IsIntelliMousePresent: Boolean;
function IsNetworkPresent: Boolean;
function IsVolume(const APath: string): Boolean;
function IsWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
function PopulateShellImages(FullInit: Boolean): Boolean;
function ShellLargeImages: TImageList;
function ShellSmallImages: TImageList;
function ShowSystemSelectFolderDlg(var ADirPath: string): Boolean;
function FormatFileSize(const AFileSize: Int64): string;
function ValidateFileName(const FileName: string): Boolean;
procedure Delay(Value: DWORD); //milliseconds

procedure MessageError(const AMessage: string);
procedure MessageWarning(const AMessage: string);
function MessageQuestion(const AMessage: string): Boolean;

// string processing
function AddColon(const Source: string): string;
function AddEndEllipsis(const Source: string): string;
function DropAmpersand(const Source: string): string;
function DropColon(const Source: string): string;
function DropEndEllipsis(const Source: string): string;
function DropT(const Source: string): string;
function ReplaceSubStr(const Source, OldChars, NewChars: string): string;
function ReplicateChar(const S: string; ACount: Integer): string;

function dxBoolToStr(AValue: Boolean): string;
function dxSameStr(const S1, S2: string): Boolean;
function dxSameText(const S1, S2: string): Boolean;

function FormatFontInfo(AFont: TFont): string;
procedure FontInfoToText(AFont: TFont; AEdit: TEdit);

function MakePageIndexes(const Source: string; out AnOutput: TIntegers): Boolean;

// Number metrics conversation
function Chars2Int(const AText: string; AnUpperCase: Boolean): Integer;
function Int2Chars(AValue: Integer; AnUpperCase: Boolean): string;
function Roman2Int(AText: string; AnUpperCase: Boolean): Integer;
function Int2Roman(AValue: Integer; AnUpperCase: Boolean): string;

//RTTI
function HasPropertyEx(AClass: TClass; const AName: string; ATypeKinds: TTypeKinds): Boolean; overload;
function HasPropertyEx(AnObject: TObject; const AName: string; ATypeKinds: TTypeKinds): Boolean; overload;
function HasProperty(AClass: TClass; const AName: string): Boolean; overload;
function HasProperty(AnObject: TObject; const AName: string): Boolean; overload;

function GetProperty(AnObject: TObject; const AName: string): Variant;
procedure SetProperty(AnObject: TObject; const AName: string; const AValue: Variant);

procedure dxDrawComboBoxItem(ACanvas: TCanvas; const R: TRect; const AText: string; 
  AnImageList: TCustomImageList; AnImageIndex: Integer; AState: TOwnerDrawState);
procedure dxLoadStringsFromRegistry(const APath: string; AStrings: TStrings);
procedure dxSaveStringsToRegistry(const APath: string; AStrings: TStrings);
procedure dxLoadListViewColumnsFromRegistry(AListView: TListView; const APath: string);
procedure dxSaveListViewColumnsToRegistry(AListView: TListView; const APath: string);
procedure dxRestoreListViewSelection(AListView: TListView; ASelection: TList);
procedure dxSaveListViewSelection(AListView: TListView; ASelection: TList);

procedure CopyImages(ASourceHandle: HIMAGELIST; ADest: TCustomImageList);

procedure PlaceButtons(const AButtons: array of TButton; ABtnOffsetX, ARightOrigin, ATopOrigin: Integer);

procedure dxAppendList(ASource, ADest: TList);
procedure dxCopyList(ASource, ADest: TList);
procedure dxShiftIntegerListValues(AList: TList; AValue: Integer);

function dxCheckStateImageIndexMap(AState: TCheckBoxState): Integer;
procedure dxCreateCheckMarkImages(AnImageList: TCustomImageList);

function dxPSDrawModeImages: TCustomImageList;

{$IFNDEF DELPHI5}
procedure FreeAndNil(var Obj);
{$ENDIF}

// VCL Helpers - introduced mostly because of Delphi.Net

function dxAllocatehWnd(AMethod: TWndMethod): HWND;
procedure dxDeallocatehWnd(AWnd: HWND);
procedure dxRecreateWnd(AControl: TWinControl);

function MakeBounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
function MakePoint(X, Y: Integer): TPoint;
function MakeRect(ALeft, ATop, ARight, ABottom: Integer): TRect; overload;
function MakeRect(const ATopLeft, ABottomRight: TPoint): TRect; overload;

function TTagToInt(AValue:  Integer ): Integer;
function TTagToObj(AValue:  Integer ): TObject;
function TTagToClass(AValue:  Integer ): TClass;

function MakeTTag(AValue: Integer):  Integer ; overload;
function MakeTTag(AValue: TObject):  Integer ; overload;
function MakeTTag(AValue: TClass):  Integer ; overload;

function Control_GetColor(AControl: TControl): TColor;
function Control_GetControlStyle(AControl: TControl): TControlStyle;
function Control_GetCtl3D(AControl: TWinControl): Boolean;
function Control_GetFont(AControl: TControl): TFont;
function Control_GetPopupMenu(AControl: TControl): TPopupMenu;
function Control_GetText(AControl: TControl): string;
procedure Control_SetParentBackground(AControl: TWinControl; Value: Boolean);

procedure Control_DoContextPopup(AControl: TControl; const Pt: TPoint; var AHandled: Boolean);
procedure Control_PaintWindow(AControl: TWinControl; DC: HDC);
procedure Control_SendCancelMode(AControl, ASender: TControl);
procedure Control_UpdateBoundsRect(AControl: TControl; const R: TRect); overload;
procedure Control_UpdateBoundsRect(AControl: TControl; ALeft, ARight, AWidth, AHeight: Integer); overload;

procedure PopupMenu_DoPopup(APopupMenu: TPopupMenu);

function RichEdit_GetBorderStyle(AControl: TCustomRichEdit): TBorderStyle;
function RichEdit_GetLines(AControl: TCustomRichEdit): TStrings;

procedure Bitmap_LoadFromResourceName(ABitmap: TBitmap; const AResName: string; ABaseName: string = 'dxPSImgs');
procedure Icon_LoadFromResourceName(AIcon: TIcon; const AResName: string; ABaseName: string = 'dxPSImgs');

function IsDelphiObject(AData: DWORD): Boolean;

implementation

uses
 {$IFDEF DELPHI6}  
  Types, 
  StrUtils, 
 {$ENDIF} 
 {$IFDEF USEJPEGIMAGE}
  Jpeg, 
 {$ENDIF}
  Consts, ActiveX, ShlObj, ShellAPI, FileCtrl, dxPSRes, dxPSImgs;
  
  
const
  CharCount = 26;
  Chars: array[Boolean] of string[CharCount] = (('abcdefghijklmnopqrstuvwxyz'), ('ABCDEFGHIJKLMNOPQRSTUVWXYZ'));  

  ColumnPath = '\ColumnWidths';               // Don't Localize
  ColumnPattern = 'Column%d';                 // Don't Localize
      
var
  FDrawModeImages: TCustomImageList;
  FPatternBrush: HBRUSH;
  FShellLargeImages: TImageList;
  FShellSmallImages: TImageList;
  FNonTrueTypeFonts: TStringList;
  FTrueTypeFonts: TStringList;
  
type

  TControlAccess = class(TControl);
  TCustomRichEditAccess = class(TCustomRichEdit);
  TGraphicAccess = class(TGraphic);
 {$IFNDEF DELPHI6}
  TGraphicAccessClass = class of TGraphicAccess;
 {$ENDIF} 
 {$IFDEF DELPHI5}
  TPopupMenuAccess = class(TPopupMenu);
 {$ENDIF} 
  TWinControlAccess = class(TWinControl);

  
function FontStyleNames(AFontStyle: TFontStyle): string;
begin
  case AFontStyle of
    fsBold:                         
      Result := cxGetResourceString(@sdxFontStyleBold);
    fsItalic:
      Result := cxGetResourceString(@sdxFontStyleItalic);
    fsUnderline:
      Result := cxGetResourceString(@sdxFontStyleUnderline);
  else
    Result := cxGetResourceString(@sdxFontStyleStrikeOut);
  end;
end;
  
function NonTrueTypeFonts: TStringList;
begin
  if FNonTrueTypeFonts = nil then 
  begin
    FNonTrueTypeFonts := TStringList.Create;
    FNonTrueTypeFonts.Sorted := True;
  end;
  Result := FNonTrueTypeFonts;
end;

function TrueTypeFonts: TStringList;
begin
  if FTrueTypeFonts = nil then 
  begin
    FTrueTypeFonts := TStringList.Create;
    FTrueTypeFonts.Sorted := True;
  end;
  Result := FTrueTypeFonts;
end;

function Min(A, B: Integer): Integer;
begin
  Result := A;
  if A > B then Result := B;
end;

function Max(A, B: Integer): Integer;
begin
  Result := A;
  if B > A then Result := B;
end;

function MinMax(A, B, C: Integer): Integer;
begin
  if B > C then
    Result := A
  else 
    if A < B then
      Result := B
    else 
      if A > C then
        Result := C
      else
        Result := A;
end;

function SetLoWord(AValue: Integer; ALoWord: Word): Integer;
begin
  Result := (AValue and Integer($0000FFFF)) or (ALoWord shl 16);
end;

function SetHiWord(AValue: Integer; AHiWord: Word): Integer;
begin
  Result := (AValue and Integer($FFFF0000)) or (AHiWord and $FFFF);
end;

function SetLoHiWords(AValue: Integer; ALoWord, AHiWord: Word): Integer;
begin
  Result := SetHiWord(SetLoWord(AValue, ALoWord), AHiWord);
end;

function ScaleRect(const R: TRect; ANumeratorW, ADenominatorW, ANumeratorH, 
   ADenominatorH: Integer): TRect;
begin
  with Result do 
  begin
    Left := MulDiv(R.Left, ANumeratorW, ADenominatorW);
    Top := MulDiv(R.Top, ANumeratorH, ADenominatorH);
    Right := MulDiv(R.Right, ANumeratorW, ADenominatorW);
    Bottom := MulDiv(R.Bottom, ANumeratorH, ADenominatorH);
  end;  
end;

function ScaleRect(const R: TRect; ANumerator, ADenominator: Integer): TRect;
begin
  Result := ScaleRect(R, ANumerator, ADenominator, ANumerator, ADenominator);
end;

function ScalePoint(const Pt: TPoint; Numerator, Denominator: Integer): TPoint;
begin
  Result.X := MulDiv(Pt.X, Numerator, Denominator);
  Result.Y := MulDiv(Pt.Y, Numerator, Denominator);
end;

function ArePointsEqual(const Pt1, Pt2: TPoint): Boolean;
begin
  Result := (Pt1.X = Pt2.X) and (Pt1.Y = Pt2.Y);
end;

function GetRgnData(ARgn: HRGN; out ARgnDataHeader: TRgnDataHeader; 
  out ARects: TRects): Integer;
var
  Size: Integer;
  RgnData: PRgnData;
  I: Integer;
begin
  Size := GetRegionData(ARgn, 0, nil);
  RgnData := AllocMem(SizeOf(TRgnDataHeader) + SizeOf(TRect) * (Size - SizeOf(TRgnDataHeader)));
  try
    GetRegionData(ARgn, Size, RgnData);
    ARgnDataHeader := RgnData.rdh; 
    Result := RgnData.rdh.nCount;
    SetLength(ARects, Result);
    for I := 0 to Result - 1 do
      Move(RgnData.Buffer[I * SizeOf(TRect)], ARects[I], SizeOf(TRect));
  finally
    FreeMem(RgnData, Size);
  end;
end;

function ExcludeClipRect(DC: HDC; const R: TRect): HRGN;
begin
  with R do 
    Result := ExcludeClipRect(DC, Left, Top, Right, Bottom);
end;

function ExcludeClipRect(DC: HDC; ALeft, ATop, ARight, ABottom: Integer): HRGN;
begin
  Result := Windows.CreateRectRgn(0, 0, 0, 0);
  if Windows.GetClipRgn(DC, Result) <> 1 then 
  begin
    Windows.DeleteObject(Result);
    Result := 0;
  end;
  Windows.ExcludeClipRect(DC, ALeft, ATop, ARight, ABottom);
end;
  
function IntersectClipRect(DC: HDC; const R: TRect; AlwaysClip: Boolean = False): HRGN;
begin
  with R do 
    Result := IntersectClipRect(DC, Left, Top, Right, Bottom);
end;

function IntersectClipRect(DC: HDC; ALeft, ATop, ARight, ABottom: Integer; AlwaysClip: Boolean = False): HRGN;
begin
  Result := Windows.CreateRectRgn(0, 0, 0, 0);
  if Windows.GetClipRgn(DC, Result) <> 1 then
  begin
    Windows.DeleteObject(Result);
    Result := 0;
  end
  else
    if IsMetaFileDC(DC) then 
    begin
      Result := Windows.CreateRectRgn(0, 0, 320000, 320000);
      if Windows.SelectClipRgn(DC, Result) = ERROR then
      begin
        DeleteObject(Result);
        Result := 0;
        Exit;
      end;
    end;
  Windows.IntersectClipRect(DC, ALeft, ATop, ARight, ABottom);
end;

function RectVisible(DC: HDC; const ARect: TRect): Boolean;
begin
  if IsMetafileDC(DC) then
    Result := True
  else
    Result := Windows.RectVisible(DC, ARect);
end;

procedure RestoreClipRgn(DC: HDC; var ARgn: HRGN);
begin
  Windows.SelectClipRgn(DC, ARgn);
  if ARgn <> 0 then Windows.DeleteObject(ARgn);
  ARgn := 0;
end;

function dxBoolToStr(AValue: Boolean): string;
begin
 {$IFDEF DELPHI6}
  Result := SysUtils.BoolToStr(AValue, True);
 {$ELSE}
  if AValue then 
    Result := cxGetResourceString(@sdxTrue)
  else  
    Result := cxGetResourceString(@sdxFalse);
 {$ENDIF}
end;

function dxSameStr(const S1, S2: string): Boolean;
begin
 {$IFDEF DELPHI6}
    Result := AnsiSameStr(S1, S2);
 {$ELSE}
  Result := AnsiCompareStr(S1, S2) = 0;
 {$ENDIF}  
end;

function dxSameText(const S1, S2: string): Boolean;
begin
 {$IFDEF DELPHI6}
    Result := AnsiSameText(S1, S2);
 {$ELSE}
  Result := AnsiCompareText(S1, S2) = 0;
 {$ENDIF}  
end;

function dxAreBitmapsEqual(ABitmap1, ABitmap2: TBitmap): Boolean;
begin
  Result := dxAreGraphicsEqual(ABitmap1, ABitmap2);
end;

function dxAreBrushesEqual(ABrush1, ABrush2: TBrush): Boolean;
begin
  Result := ((ABrush1 = nil) and (ABrush2 = nil)) or
    ((ABrush1 <> nil) and (ABrush2 <> nil) and
     (ABrush1.Color = ABrush2.Color) and
     (ABrush1.Style = ABrush2.Style));
end;

function dxAreFontsEqual(AFont1, AFont2: TFont): Boolean;
begin
  Result := ((AFont1 = nil) and (AFont2 = nil)) or
    ((AFont1 <> nil) and (AFont2 <> nil) and
     (AFont1.Color = AFont2.Color) and
     (AFont1.Name = AFont2.Name) and
     (AFont1.Pitch = AFont2.Pitch) and
     (AFont1.Style = AFont2.Style) and
     (AFont1.Size = AFont2.Size)); // and
//    (AFont1.Charset = AFont2.Charset));
end;

function dxAreGraphicsEqual(AGraphic1, AGraphic2: TGraphic): Boolean;
begin
  Result := (AGraphic1 = AGraphic2) or ((AGraphic1 <> nil) and 
   TGraphicAccess(AGraphic1).Equals(AGraphic2));
end;

function dxArePensEqual(APen1, APen2: TPen): Boolean;
begin
  Result := ((APen1 = nil) and (APen2 = nil)) or
    ((APen1 <> nil) and (APen2 <> nil) and
     (APen1.Color = APen2.Color) and
     (APen1.Mode = APen2.Mode) and
     (APen1.Style = APen2.Style) and
     (APen1.Width = APen2.Width));
end;

function FormatFontInfo(AFont: TFont): string;
var
  S: string;
  FS: TFontStyle;
begin
  Result := '';
  if AFont = nil then Exit;  

  Result := Format('%d %s %s ', [AFont.Size, cxGetResourceString(@sdxPt), AFont.Name]);
  if AFont.Style <> [] then
  begin
    Result := Result + ' [';
    S := '';
    for FS := Low(TFontStyle) to High(TFontStyle) do
      if FS in AFont.Style then
      begin
        if S <> '' then 
          S := S + ', ';
        S := S + FontStyleNames(FS);
      end;
    Result := Result + S + ']';        
  end;  
end;

procedure FontInfoToText(AFont: TFont; AEdit: TEdit);
begin
  AEdit.Text := FormatFontInfo(AFont);
  if ColorToRGB(AFont.Color) <> ColorToRGB(AEdit.Color) then
    AEdit.Font.Color := AFont.Color
  else
    AEdit.Font.Color := clWindowText;
end;

type
  PSearchBuffer = ^TSearchBuffer;
  TSearchBuffer = record
    FontName: string;
    IsTrueType: Boolean;
  end;

function EnumFontsProc(var AnEnumLogFont: TEnumLogFont; var ATextMetric: TNewTextMetric; 
  AFontType: Integer; AData: LPARAM): Integer; stdcall;
begin
  with AnEnumLogFont.elfLogFont do
  begin
    Result := Integer(not (StrIComp(PChar(PSearchBuffer(AData)^.FontName), PChar(@lfFaceName[0])) = 0));
    if Result = 0 then
      PSearchBuffer(AData)^.IsTrueType := AFontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE;
  end;
end;

function dxIsTrueTypeFont(AFont: TFont): Boolean;

  function CalculateIsTrueTypeFont(AFont: TFont): Boolean;
  var
    DC: HDC;
    SearchBuffer: PSearchBuffer;
  begin
    DC := GetDC(0);
    try
      try
        New(SearchBuffer);
        try
          SearchBuffer^.FontName := AFont.Name;
          EnumFontFamilies(DC, nil, @EnumFontsProc, LPARAM(SearchBuffer));
          Result := SearchBuffer^.IsTrueType;
        finally
          Finalize(SearchBuffer^.FontName);
          Dispose(PSearchBuffer(SearchBuffer));
        end;
      except
        Result := False;
      end;
    finally
      ReleaseDC(0, DC);
    end;
  end;

begin
  Result := TrueTypeFonts.IndexOf(AFont.Name) <> -1; // found in TT Fonts
  if not Result then
  begin
    Result := NonTrueTypeFonts.IndexOf(AFont.Name) = -1; // not found in non TT Fonts
    if Result then
    begin
      Result := CalculateIsTrueTypeFont(AFont);
      if Result then 
        TrueTypeFonts.Add(AFont.Name)
      else  
        NonTrueTypeFonts.Add(AFont.Name);
    end;
  end;
end;
  
function FindNearestColor(AColor: TColor): TColor;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;

function InvertColor(AColor: TColor): TColor;
begin
  Result := $FFFFFF xor ColorToRGB(AColor);
end;

function OffsetColor(AColor: TColor; ARed, AGreen, ABlue: Byte): TColor;
var
  Red, Green, Blue: Integer;
begin
  AColor := ColorToRGB(AColor);
  Red := GetRValue(AColor) + ARed;
  if Red > High(Byte) then Red := High(Byte);
  if Red < Low(Byte) then Red := Low(Byte);  
  
  Green := GetGValue(AColor) + AGreen;  
  if Green > High(Byte) then Green := High(Byte);
  if Green < Low(Byte) then Green := Low(Byte);  
  
  Blue := GetBValue(AColor) + ABlue;  
  if Blue > High(Byte) then Blue := High(Byte);
  if Blue < Low(Byte) then Blue := Low(Byte);  
  
  Result := RGB(Red, Green, Blue);
end;

function IsDisplayDC(DC: HDC): Boolean;
begin
  Result := GetDeviceCaps(DC, TECHNOLOGY) = DT_RASDISPLAY;
end;

function IsMetafileDC(DC: HDC): Boolean;
begin
  Result := GetObjectType(DC) in [OBJ_METADC, OBJ_ENHMETADC];  
end;

function IsPrinterDC(DC: HDC): Boolean;
begin
  Result := GetDeviceCaps(DC, TECHNOLOGY) = DT_RASPRINTER;
end;

function CreatePatternBrush: HBRUSH;
var
  PatternBitmap: HBITMAP;
  DC: HDC;
  X, Y: Integer;
begin
  PatternBitmap := CreateBitmap(8, 8, 1, 1, nil);
  try
    DC := CreateCompatibleDC(0);
    PatternBitmap := SelectObject(DC, PatternBitmap);
    for X := 0 to 7 do
      for Y := 0 to 7 do
        SetPixel(DC, X, Y, $FFFFFF * Byte(Odd(X) = Odd(Y)));
    PatternBitmap := SelectObject(DC, PatternBitmap);
    DeleteDC(DC);

    Result := Windows.CreatePatternBrush(PatternBitmap);
  finally
    DeleteObject(PatternBitmap);
  end;
end;

function PatternBrush: HBRUSH;
begin
  if FPatternBrush = 0 then 
    FPatternBrush := CreatePatternBrush;
  Result := FPatternBrush;
end;

procedure SetFontAsNonAntialiased(AFont: TFont);
var
  LogFont: TLogFont;
begin
  cxGetFontData(AFont.Handle, LogFont);
  LogFont.lfQuality := {LogFont.lfQuality and not} NONANTIALIASED_QUALITY;
  AFont.Handle := CreateFontIndirect(LogFont);
end;
  
procedure ForcePictureToBitmap(APicture: TPicture);
var
  B: TBitmap;
begin
  with APicture do 
    if (Graphic <> nil) and not Graphic.InheritsFrom(TBitmap) then
      if not Graphic.InheritsFrom(TIcon) then
      begin
        B := TBitmap.Create;
        try
          B.Assign(Graphic);
          Bitmap := B;
        finally
          B.Free;
        end;
      end
      else
        Bitmap := IconToBitmap(TIcon(Graphic));
end;

function CreateGraphic(AGraphicClass: TGraphicClass): TGraphic;
begin
  {$IFDEF DELPHI6}
   Result := AGraphicClass.Create;
  {$ELSE}
   Result := TGraphicAccessClass(AGraphicClass).Create;
  {$ENDIF}
end;

function IconToBitmap(AnIcon: TIcon): TBitmap;
//var
//  IconInfo: TIconInfo;
begin
  Result := TBitmap.Create;
  with Result do 
  begin
    Height := AnIcon.Height;
    Width := AnIcon.Width;
    //GetIconInfo(AnIcon.Handle, IconInfo);
    //MaskHandle := IconInfo.hbmMask;
    Transparent := True;
    Canvas.Draw(0, 0, AnIcon);
  end;  
end;

function CreateArrowBitmap(AUpDownGlyph: TdxUpDownGlyph; AWidth: Integer = 16; 
  AHeight: Integer = 16; AFontSize: Integer = 12): TBitmap;
const
  GlyphIndexes: array[TdxUpDownGlyph] of Integer = (GLYPH_UPARROW, GLYPH_DOWNARROW);
begin
  Result := CreateGlyphBitmap(GlyphIndexes[AUpDownGlyph], AWidth, AHeight, AFontSize);
end;

function CreateDoubleArrowBitmap(AUpDownGlyph: TdxUpDownGlyph; AWidth: Integer  = 16;
  AHeight: Integer = 16; AFontSize: Integer = 8): TBitmap;
const
  GlyphIndexes: array[TdxUpDownGlyph] of Integer = (GLYPH_UPARROW, GLYPH_DOWNARROW);
  OffsetUp = 2;
  OffsetDown = -1;
var
  B1, B2: TBitmap;  
begin
  B1 := CreateGlyphBitmap(GlyphIndexes[AUpDownGlyph], AWidth, AHeight, AFontSize);
  try
    B1.Transparent := True;
    B2 := CreateGlyphBitmap(GlyphIndexes[AUpDownGlyph], AWidth, AHeight, AFontSize);
    try
      B2.Transparent := True;
      Result := TBitmap.Create;
      with Result do
      begin
        Width := AWidth;
        Height := AHeight;
        Canvas.Brush.Color := clBtnFace;
        Canvas.FillRect(Rect(0, 0, AWidth, AHeight));
        Canvas.Draw(0, OffsetUp, B1);
        Canvas.Draw(0, OffsetDown, B2);
      end;  
    finally
      B2.Free;
    end;  
  finally
    B1.Free;
  end;  
end;

function CreateGlyphBitmap(AGlyphIndex: Integer; AWidth: Integer = 16;
  AHeight: Integer = 16; AFontSize: Integer = 12): TBitmap;
var
  W, H, X, Y: Integer;
  Ch: Char;
begin
  W := AWidth;
  H := AHeight;
  if W = 0 then W := 16;
  if H = 0 then H := 16;
  
  Result := TBitmap.Create;
  with Result do
  begin
    Width := W;
    Height := H;
    
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(Rect(0, 0, Width, Height));

    Canvas.Font.Name := 'Marlett'; 
    Canvas.Font.Size := AFontSize;
    Canvas.Font.Color := clWindowText;
    Canvas.Font.Charset := SYMBOL_CHARSET;
    Ch := Chr(AGlyphIndex);
    X := 0;
    Y := 0;
    if (AWidth <> 0) and (AHeight <> 0) then 
    begin
      X := (Width - Canvas.TextWidth(Ch)) div 2;
      Y := (Height - Canvas.TextHeight(Ch)) div 2;
    end
    else
    begin
      Width := Canvas.TextWidth(Ch);
      Height := Canvas.TextHeight(Ch);
    end;
      
    Canvas.TextOut(X, Y, Ch);
  end;
end;

procedure DrawBlendedText(ACanvas: TCanvas; const R: TRect; const AText: string; AFont: TFont);
var
  MemDC: HDC;
  MemBitmap: HBITMAP;
  
  procedure PrepareOffScreenStructures(DC: HDC; ASize: TSize);
  begin
    MemBitmap := CreateCompatibleBitmap(DC, ASize.cX, ASize.cY);
    MemDC := CreateCompatibleDC(DC);
    MemBitmap := SelectObject(MemDC, MemBitmap);
  end;

  procedure CreateTextOutClipPath(const R: TRect; const AText: string; AFont: TFont);
  var
    F: HFONT;
    C: TColor;
    BkMode: Integer;
  begin
    FillRect(MemDC, R, GetStockObject(WHITE_BRUSH));

    F := SelectObject(MemDC, AFont.Handle);
    C := SetTextColor(MemDC, $FFFFFF);
    BkMode := SetBkMode(MemDC, Windows.TRANSPARENT);

    BeginPath(MemDC);
      TextOut(MemDC, 0, 0, PChar(AText), Length(AText));
    EndPath(MemDC);

    SetBkMode(MemDC, BkMode);
    SetTextColor(MemDC, C);
    SelectObject(MemDC, F);

    SelectClipPath(MemDC, RGN_COPY);
  end;
  
  procedure PatternTextOutClipPath(const R: TRect; ATextColor: TColor);
  var
    BkColor: COLORREF;
  begin
    ATextColor := SetTextColor(MemDC, ATextColor);
    BkColor := SetBkColor(MemDC, $FFFFFF);
    FillRect(MemDC, R, PatternBrush);
    SetTextColor(MemDC, ATextColor);
    SetBkColor(MemDC, BkColor);
  end; 
  
  procedure UnprepareOffScreenStructures;
  begin
    MemBitmap := SelectObject(MemDC, MemBitmap);
    DeleteDC(MemDC);
    DeleteObject(MemBitmap);
  end;

var
  DC: HDC;
  Size: TSize;
  MemRect: TRect;
  F: HFONT; 
  X, Y: Integer;
begin
  DC := ACanvas.Handle;
  F := SelectObject(DC, AFont.Handle);
  GetTextExtentPoint(DC, PChar(AText), Length(AText), Size);

  MemRect := MakeRect(0, 0, Size.cX, Size.cY);  

  PrepareOffScreenStructures(DC, Size);
  try
    CreateTextOutClipPath(MemRect, AText, AFont);
    PatternTextOutClipPath(MemRect, ColorToRGB(AFont.Color));
    SelectClipRgn(MemDC, 0);

    with R do 
    begin
      X := Left + (Right - Left - Size.cX) div 2;
      Y := Top + (Bottom - Top - Size.cY) div 2;
    end;
    BitBlt(DC, X, Y, Size.cX, Size.cY, MemDC, 0, 0, SRCAND);
  finally
    UnprepareOffScreenStructures;
  end;
  SelectObject(DC, F);
end;

procedure DrawGlyph(DC: HDC; const R: TRect; AGlyph: Byte);
var
  C: Char;
begin
  C := Chr(AGlyph);
  ExtTextOut(DC, R.Left, R.Top, 0, @R, @C, 1, nil);
end;

procedure DrawSizeGrip(DC: HDC; R: TRect);
var
  V: Integer;
begin
  V := GetSystemMetrics(SM_CXVSCROLL);
  R := MakeRect(R.Right - V, R.Bottom - V, R.Right, R.Bottom);
  DrawFrameControl(DC, R, DFC_SCROLL, DFCS_SCROLLSIZEGRIP); 
end;

procedure TransparentDraw(DrawDC: HDC; Brush: HBRUSH; const R: TRect; 
  ABitmap: TBitmap);
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

{.$WARN SYMBOL_DEPRECATED OFF}

function CopyDeviceMode(Src: HGLOBAL): HGLOBAL;
var
  Size: Integer;
  SrcPtr, DestPtr: PChar;
begin
  if Src <> 0 then
  begin
    Size := GlobalSize(Src);
    Result := GlobalAlloc(GHND, Size);
    if Result <> 0 then
    begin
      SrcPtr := GlobalLock(Src);
      if SrcPtr <> nil then
      try
        DestPtr := GlobalLock(Result);
        if DestPtr <> nil then
        try
          Move(SrcPtr^, DestPtr^, Size);       
        finally
          GlobalUnlock(Result);
        end;
      finally
        GlobalUnlock(Src);
      end;
    end;
  end
  else
    Result := 0;
end;

{.$WARN SYMBOL_DEPRECATED ON}

function GetDesktopWorkArea: TRect;

  function IntersectionArea(const ABounds: TRect; APoint: TPoint; var Area: TRect): Integer;
  var
    R: TRect;
  begin
    Area := GetDesktopWorkArea(APoint);
    if IntersectRect(R, ABounds, Area) then
      Result := Abs(R.Right - R.Left) * Abs(R.Bottom - R.Top)  
    else
      Result := 0;
  end;

var
  R, R1: TRect;
begin
  if Application.MainForm <> nil then
  begin
    Result := Application.MainForm.BoundsRect;
    if IntersectionArea(Result, Result.TopLeft, R) >
      IntersectionArea(Result, Result.BottomRight, R1) then
      Result := R
    else
      Result := R1;
  end
  else
    SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0);
end;

function GetDesktopWorkArea(const P: TPoint): TRect;
const
  MONITOR_DEFAULTTONEAREST = $2;
type
  HMONITOR = type Integer;
  PMonitorInfo = ^TMonitorInfo;
  TMonitorInfo = record
    cbSize: DWORD;
    rcMonitor: TRect;
    rcWork: TRect;
    dwFalgs: DWORD;
  end;
var
  AUser32DLL: THandle;
  Info: TMonitorInfo;
  GetMonitorInfo: function(hMonitor: HMONITOR; lpMonitorInfo: PMonitorInfo): Boolean; stdcall;
  MonitorFromPoint: function(ptScreenCoords: TPoint; dwFlags: DWORD): HMONITOR; stdcall;
begin
  AUser32DLL := LoadLibrary('USER32');
  if AUser32DLL > 32 then
  begin
    GetMonitorInfo := GetProcAddress(AUser32DLL, 'GetMonitorInfoA');
    MonitorFromPoint := GetProcAddress(AUser32DLL, 'MonitorFromPoint');
  end
  else
  begin
    GetMonitorInfo := nil;
    MonitorFromPoint := nil;
  end;

  if @GetMonitorInfo = nil then
    SystemParametersInfo(SPI_GETWORKAREA, 0, @Result, 0)
  else
  begin
    Info.cbSize := SizeOf(Info);
    GetMonitorInfo(MonitorFromPoint(P, MONITOR_DEFAULTTONEAREST), @Info);
    Result := Info.rcWork;
  end;
  FreeLibrary(AUser32DLL);
end;

function GetLongFileName(const Source: string): string;
var
  Handle: THandle;
  Proc: function(ShortPathName, LongPathName: PChar; cchBuffer: Integer): Integer; stdcall;
  Buffer: array[0..MAX_PATH] of Char;
begin
  Handle := GetModuleHandle(kernel32);
  if Handle <> 0 then
  begin
  {$IFDEF DELPHI12}
    @Proc := GetProcAddress(Handle, 'GetLongPathNameW');
  {$ELSE}
    @Proc := GetProcAddress(Handle, 'GetLongPathNameA');
  {$ENDIF}
    if (@Proc <> nil) and (Proc(PChar(Source), Buffer, SizeOf(Buffer)) <> 0) then
      Result := Buffer
    else
      Result := Source;
  end
  else
    Result := Source;
end;

function GetMachineName: string;
var
  BufferSize: DWORD;
  Buffer:  array[0..MAX_COMPUTERNAME_LENGTH + 1] of Char ;
begin
  BufferSize := MAX_COMPUTERNAME_LENGTH + 1;
  GetComputerName(Buffer, BufferSize);
  Result := Buffer;
end;

function GetUserName: string;
var
  BufferSize: DWORD;
  Buffer:  array[0..UNLEN + 1] of Char ;
begin
  BufferSize := UNLEN + 1;
  Windows.GetUserName(Buffer, BufferSize);
  Result := Buffer;
end;

function GetVolumeName(const APath: string): string;
var
  PrevErrorMode: UINT;
  Buffer: array[Byte] of Char;
  L, Flags: DWORD;
begin
  PrevErrorMode := Windows.SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    if GetVolumeInformation(PChar(APath), @Buffer, SizeOf(Buffer), nil, L, Flags, nil, 0) then
      Result := Buffer
    else
      Result := '';
  finally
    Windows.SetErrorMode(PrevErrorMode);
  end;
end;

function IsIntelliMousePresent: Boolean;
begin
  Result := Boolean(GetSystemMetrics(SM_MOUSEWHEELPRESENT));
end;

function IsNetworkPresent: Boolean;
begin
  Result := GetSystemMetrics(SM_NETWORK) and $01 = $01;
end;

function IsVolume(const APath: string): Boolean;
begin
  Result := ExtractFileDir(APath) = APath;
end;

function IsWin32Version(AMajor: Integer; AMinor: Integer = 0): Boolean;
begin
  Result := (Win32MajorVersion > AMajor) or 
            ((Win32MajorVersion = AMajor) and (Win32MinorVersion >= AMinor));
end;

function PopulateShellImages(FullInit: Boolean): Boolean;
var
  ShellDLLLoaded: Boolean;
  ShellDLL: HMODULE;
  Proc: function(FullInit: BOOL): BOOL; stdcall;
begin
  Result := False;
  if IsWinNT then
  begin
    ShellDLLLoaded := False;
    ShellDLL := GetModuleHandle(ShellAPI.Shell32);
    if ShellDLL = 0 then
    begin
      ShellDLL := LoadLibrary(ShellAPI.Shell32);
      if ShellDLL <= Windows.HINSTANCE_ERROR then 
        ShellDLL := 0;
      ShellDLLLoaded := ShellDLL <> 0;  
    end;
    if ShellDLL <> 0 then
    try
      Proc := GetProcAddress(ShellDll, PChar(660));
      Result := (@Proc <> nil) and Proc(FullInit);
    finally
      if ShellDLLLoaded then FreeLibrary(ShellDll);
    end;
  end;
end;

function ShellLargeImages: TImageList;
var
  FileInfo: TSHFileInfo;
begin
  if FShellLargeImages = nil then
  begin
    FShellLargeImages := TImageList.Create(nil);
    FShellLargeImages.ShareImages := True;
    try
      FillChar(FileInfo, SizeOf(FileInfo), 0);    
      FShellLargeImages.Handle := SHGetFileInfo('', 0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
    finally
      if FileInfo.hIcon <> 0 then Windows.DestroyIcon(FileInfo.hIcon);
    end;
  end;
  Result := FShellLargeImages;
end;
 
function ShellSmallImages: TImageList;
var
  FileInfo: TSHFileInfo;
begin
  if FShellSmallImages = nil then
  begin
    FShellSmallImages := TImageList.Create(nil);
    FShellSmallImages.ShareImages := True;
    try
      FillChar(FileInfo, SizeOf(FileInfo), 0);    
      FShellSmallImages.Handle := SHGetFileInfo('', 0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
    finally
      if FileInfo.hIcon <> 0 then Windows.DestroyIcon(FileInfo.hIcon);
    end;  
  end;
  Result := FShellSmallImages;
end;

function BFFCallBack(Wnd: HWND; uMsg: UINT; lParam, lpData: LPARAM): Integer; stdcall; 
var
  Path: PChar absolute lParam;
  B: Boolean;
  Buffer: array[0..MAX_PATH] of Char;
  S: string;
begin
  Result := 0;
  if uMsg = BFFM_INITIALIZED then 
  begin                                           
    B := not IsWin9X or (IsVolume(Path) and DirectoryExists(Path));
    if B then
      SendMessage(Wnd, BFFM_SETSELECTION, WPARAM(True), lpData);
  end;

  if uMsg = BFFM_SELCHANGED then
  begin  
      B := SHGetPathFromIDList(PItemIDList(lParam), @Buffer);
      if B then
      begin
        SetString(S, PChar(@Buffer), MAX_PATH); 
        B := DirectoryExists(S);
      end;  
    SendMessage(Wnd, BFFM_ENABLEOK, 0, Ord(B));
  end;
  
  if (uMsg = BFFM_VALIDATEFAILEDA) or (uMsg = BFFM_VALIDATEFAILEDW) then
  begin
    S := Format(cxGetResourceString(@sdxInvalidRootDirectory), [Path]);
    Result := Ord(MessageQuestion(S));
    if Result = 1 then
      SendMessage(Wnd, BFFM_ENABLEOK, 0, 0);
  end;
end;

function ShowSystemSelectFolderDlg(var ADirPath: string): Boolean;
const
  EditBoxFlags: array[Boolean] of UINT = (0, BIF_EDITBOX);
  NewDialogStyleFlags: array[Boolean] of UINT = (0, BIF_NEWDIALOGSTYLE);
  ValidateFlags: array[Boolean] of UINT = (0, BIF_VALIDATE);
var
  ShellMalloc: IMalloc;
  Buffer: PChar;
  BrowseInfo: TBrowseInfo;
  PrevErrorMode: Cardinal;
  WindowList:  Pointer ;
  IDList:  PItemIDList ;
begin
  if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
  begin
    Buffer := ShellMalloc.Alloc(MAX_PATH);
    try
      FillChar(BrowseInfo, SizeOf(TBrowseInfo), 0);
      BrowseInfo.hwndOwner := Application.Handle;
      BrowseInfo.pszDisplayName := Buffer;
      BrowseInfo.lpszTitle := PChar(cxGetResourceString(@sdxSelectNewRoot));

      BrowseInfo.ulFlags := BIF_RETURNONLYFSDIRS or EditBoxFlags[IsComCtrlVersion471] or
        NewDialogStyleFlags[IsComCtrlVersion500] or ValidateFlags[IsComCtrlVersion471];
        if IsVolume(ADirPath) then
          ADirPath := ADirPath + '\';
          BrowseInfo.lpfn := BFFCallBack;
          BrowseInfo.lParam := LPARAM(PChar(ADirPath));

          WindowList := DisableTaskWindows(0);
          try
            PrevErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
            try
              IDList := SHBrowseForFolder(BrowseInfo);
              Result := IDList <> nil;
              if Result then
              begin
                SHGetPathFromIDList(IDList, Buffer);
                ShellMalloc.Free(IDList);
                if StrLen(Buffer) > 0 then ADirPath := Buffer;
              end;  
            finally 
              SetErrorMode(PrevErrorMode);
            end;  
          finally  
            EnableTaskWindows(WindowList); 
          end;
    finally
      ShellMalloc.Free(Buffer);
    end;
  end
  else
    Result := False;
end;

function FormatFileSize(const AFileSize: Int64): string;
const
  FormatTemplate = '##0.#';
  KiloByte = 1024;
  MegaByte = KiloByte * KiloByte;
  GigaByte = KiloByte * MegaByte;
begin                     
  if AFileSize > GigaByte then
    Result := FormatFloat(FormatTemplate, AFileSize / GigaByte) + ' ' + cxGetResourceString(@sdxGigaBytes)
  else
    if AFileSize > MegaByte then
      Result := FormatFloat(FormatTemplate, AFileSize / MegaByte) + ' ' + cxGetResourceString(@sdxMegaBytes)
    else
      if AFileSize > KiloByte then
        Result := FormatFloat(FormatTemplate, AFileSize / KiloByte) + ' ' + cxGetResourceString(@sdxKiloBytes)
      else
        Result := FormatFloat(FormatTemplate, AFileSize) + ' ' + cxGetResourceString(@sdxBytes);
end;

function ValidateFileName(const FileName: string): Boolean;

  function HasChars(const Str, Substr: string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := 1 to Length(Substr) do
      if Pos(Substr[I], Str) > 0 then
      begin
        Result := True;
        Break;
      end;
  end;
  
begin
  Result := (Trim(FileName) <> '') and not HasChars(FileName, '<>"[]|');
  if Result then 
    Result := Pos('\', ExtractFileName(FileName)) = 0;
end;

procedure Delay(Value: DWORD); //milliseconds
var
  T: DWORD;
begin
  T := GetTickCount;
  while GetTickCount - T < Value do ;
end;

{ Strings management routines }

function ReplaceSubStr(const Source, OldChars, NewChars: string): string;
var
  L, P: Integer;
begin
  Result := Source;
  P := Pos(OldChars, Result);
  if P > 0 then
  begin
    L := Length(OldChars);
    while P > 0 do
    begin
      Delete(Result, P, L);
      if NewChars <> #0 then
        Insert(NewChars, Result, P);
      P := Pos(OldChars, Result);
    end;
  end;  
end;

function ReplicateChar(const S: string; ACount: Integer): string;
{$IFNDEF DELPHI6}
var
  I: Integer;
{$ENDIF}  
begin
 {$IFDEF DELPHI6}
  Result := DupeString(S, ACount);
 {$ElSE}
  Result := '';
  for I := 0 to ACount - 1 do
    Result := Result + S;
 {$ENDIF}   
end;

procedure SplitString(const ASource, ASeparator: string; AStrings: TStrings);
var
  P, L: Integer;
  Buffer: string;
begin
  Buffer := ASource;
  P := Pos(ASeparator, Buffer);
  if P > 0 then
  begin
    L := Length(ASeparator);
    while P > 0 do
    begin
      if P > 1 then
        AStrings.Add(Copy(Buffer, 1, P + L - 2));
      Delete(Buffer, 1, P + L - 1);
      P := Pos(ASeparator, Buffer);
    end;
  end;
  if Length(Buffer) > 0 then AStrings.Add(Buffer);
end;

function MakePageIndexes(const Source: string; out AnOutput: TIntegers): Boolean;

  function ProcessRange(const S: string; out AnArray: TIntegers): Boolean;
  var
    V1, V2, P, Code1, Code2, I: Integer;
    SLeft, SRight: string;
  begin
    V1 := 0;
    V2 := 0;
    P := Pos(dxPSGlbl.cPageRangeSeparator, S);
    Result := P <> 0;
    if Result then
    begin
      SLeft := Copy(S, 1, P - 1);
      SRight := Copy(S, P + 1, Length(S) - P);
      Val(SLeft, V1, Code1);
      Val(SRight, V2, Code2);
      Result := (Code1 = 0) and (Code2 = 0) and (V2 >= V1);
   end;
   
   if Result then
   begin
     SetLength(AnArray, V2 - V1 + 1);
     for I := V1 to V2 do 
       AnArray[I - V1] := I;
   end
   else
     SetLength(AnArray, 0);    
  end;
  
var
  Buffer: string;
  Strings: TStrings;
  S: string;
  I, V, Code, L, J: Integer;
  SubRange: TIntegers;
begin
  SetLength(AnOutput, 0);
  try
    Buffer := StringReplace(Source, ' ', '', [rfReplaceAll, rfIgnoreCase]);
    if Length(Buffer) > 0 then
    begin
      Strings := TStringList.Create;
      try
        SplitString(Buffer, dxPSGlbl.cPageSeparator, Strings);
        for I := 0 to Strings.Count - 1 do
        begin
          S := Strings[I];
          Val(S, V, Code);
          if (Code <> 0) or (V < 0) then
            if ProcessRange(S, SubRange) then
            begin
              L := Length(AnOutput);
              SetLength(AnOutput, L + Length(SubRange));
              for J := L to L + Length(SubRange) - 1 do 
                AnOutput[J] := SubRange[J - L];
            end
            else
              Abort
          else
          begin
            SetLength(AnOutput, Length(AnOutput) + 1);
            AnOutput[Length(AnOutput) - 1] := V;
          end;
        end;
      finally
        Strings.Free;
      end;
    end;  
  except
    SetLength(AnOutput, 0);
  end; 
  Result := Length(AnOutput) <> 0;  
end;

function Int2Roman(AValue: Integer; AnUpperCase: Boolean): string;
const
  Max = 13;
  RomanNumbers: array[1..Max] of Integer = 
    (1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000);
  RomanStrings: array[Boolean, 1..Max] of string =
    (('i', 'iv', 'v', 'ix', 'x', 'xl', 'l', 'xc', 'c', 'cd', 'd', 'cm', 'm'),
     ('I', 'IV', 'V', 'IX', 'X', 'XL', 'L', 'XC', 'C', 'CD', 'D', 'CM', 'M'));
var
  Index: Integer;
begin
  Result := '';
  Index := Max;
  while AValue > 0 do
  begin
    while AValue < RomanNumbers[Index] do
      Dec(Index);
    while AValue >= RomanNumbers[Index] do
    begin
      Dec(AValue, RomanNumbers[Index]);
      Result := Result + RomanStrings[AnUpperCase, Index];
    end;
  end;
end;

function Roman2Int(AText: string; AnUpperCase: Boolean): Integer;
type
  TdxNumberOrder = (noOnes, noTens, noHundreds);
  TdxRomanNumber = 1..9;
const
  RomanNumbers: array[TdxNumberOrder, TdxRomanNumber] of Integer =
    ((  1,   2,   3,   4,   5,   6,   7,   8,   9),
     ( 10,  20,  30,  40,  50,  60,  70,  80,  90),
     (100, 200, 300, 400, 500, 600, 700, 800, 900));
  RomanThousand: array[Boolean] of string = ('m', 'M');
  RomanStrings: array[Boolean, TdxNumberOrder, TdxRomanNumber] of string =
    ((('i', 'ii', 'iii', 'iv', 'v', 'vi', 'vii', 'viii', 'ix'),
      ('x', 'xx', 'xxx', 'xl', 'l', 'lx', 'lxx', 'lxxx', 'lc'),
      ('c', 'cc', 'ccc', 'cd', 'd', 'dc', 'dcc', 'dccc', 'dm')),
     (('I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX'),
      ('X', 'XX', 'XXX', 'XL', 'L', 'LX', 'LXX', 'LXXX', 'XC'),
      ('C', 'CC', 'CCC', 'CD', 'D', 'DC', 'DCC', 'DCCC', 'CM')));
var
  Number: TdxRomanNumber;
  Order: TdxNumberOrder;
begin
  Result := 0;
  while (Length(AText) > 0) and (AText[1] = RomanThousand[AnUpperCase]) do
  begin
    Delete(AText, 1, 1);
    Inc(Result, 1000);
  end;
  if AText <> '' then
    for Order := noHundreds downto noOnes do
    begin
      Number := High(TdxRomanNumber);
      while (Number > 0) and (Pos(RomanStrings[AnUpperCase, Order, Number], AText) <> 1) do
        Dec(Number);
      if Number > 0 then
      begin
        Inc(Result, RomanNumbers[Order, Number]);
        Delete(AText, 1, Length(RomanStrings[AnUpperCase, Order, Number]));
        if AText = '' then Exit;
      end;
    end;
  if AText <> '' then Result := -1;
end;

function Chars2Int(const AText: string; AnUpperCase: Boolean): Integer;
begin
  Result := CharCount * (Length(AText) - 1) + Pos(AText[1], dxShortStringToString(Chars[AnUpperCase]));
end;

function Int2Chars(AValue: Integer; AnUpperCase: Boolean): string;
var
  I, C: Integer;
begin
  I := AValue mod CharCount;
  if I = 0 then I := CharCount;
  C := AValue div CharCount;
  if I <> 0 then Inc(C);
  Result := ReplicateChar(dxShortStringToString(Chars[AnUpperCase][I]), C);
end;

function AddColon(const Source: string): string;
begin
  Result := Source;
  if Pos(':', Result) <> (Length(Result) - Length(':') + 1) then 
    Result := Result + ':';
end;
                        
function AddEndEllipsis(const Source: string): string;
begin
  Result := Source;
  if Pos('...', Result) <> (Length(Result) - Length('...') + 1) then 
    Result := Result + '...';
end;

function DropAmpersand(const Source: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Source) do
    if Source[I] <> '&' then
      Result := Result + Source[I];
end;

function DropColon(const Source: string): string;
begin
  Result := Source;
  if Result[Length(Result)] = ':' then 
    Delete(Result, Length(Result), 1);
end;

function DropEndEllipsis(const Source: string): string;
begin
  Result := Source;
  while (Length(Result) > 0) and (Result[Length(Result)] = '.') do 
    Delete(Result, Length(Result), 1);
end;

procedure MessageError(const AMessage: string);
begin
  MessageBeep(MB_ICONEXCLAMATION);
  Application.MessageBox(PChar(AMessage), PChar(Application.Title), MB_OK or MB_ICONERROR);
end;

procedure MessageWarning(const AMessage: string);
begin
  MessageBeep(MB_ICONEXCLAMATION);
  Application.MessageBox(PChar(AMessage), PChar(Application.Title), MB_OK or MB_ICONEXCLAMATION);
end;

function MessageQuestion(const AMessage: string): Boolean;
begin
  MessageBeep(MB_ICONQUESTION);
  Result := (ID_YES = Application.MessageBox(PChar(AMessage), PChar(Application.Title), 
    MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON1));
end;

function DropT(const Source: string): string;
begin
  Result := Source;
  if Result[1] = 'T' then Delete(Result, 1, 1);
end;

function HasPropertyEx(AClass: TClass; const AName: string; ATypeKinds: TTypeKinds): Boolean;
var
  PropList: PPropList;
  PropCount: Integer;
  I: Integer;
begin
  PropCount := GetPropList(AClass.ClassInfo, ATypeKinds, nil);
  if PropCount > 0 then
  begin
    PropList := AllocMem(PropCount * SizeOf(PPropInfo));
    try
      PropCount := GetPropList(AClass.ClassInfo, ATypeKinds, PropList);
      I := 0;
      while (I < PropCount) and (CompareText(dxShortStringToString(PropList^[I].Name), AName) <> 0) do
        Inc(I);
      Result := I < PropCount;
    finally
      FreeMem(PropList, PropCount * SizeOf(PPropInfo));
    end;
  end
  else
    Result := False;
end;

function HasPropertyEx(AnObject: TObject; const AName: string; ATypeKinds: TTypeKinds): Boolean;
begin
  Result := HasPropertyEx(AnObject.ClassType, AName, ATypeKinds);
end;

function HasProperty(AClass: TClass; const AName: string): Boolean;
begin
  Result := HasPropertyEx(AClass, AName, tkAny);
end;

function HasProperty(AnObject: TObject; const AName: string): Boolean;
begin
  Result := HasPropertyEx(AnObject, AName, tkAny);
end;

function GetProperty(AnObject: TObject; const AName: string): Variant;
{$IFNDEF DELPHI5}
var
  PropInfo: PPropInfo;
  TypeData: PTypeData;
{$ENDIF}  
begin
  Result := Null;
 {$IFNDEF DELPHI5}
  PropInfo := TypInfo.GetPropInfo(AnObject.ClassInfo, AName);
  if PropInfo <> nil then
  begin
    TypeData := TypInfo.GetTypeData(PropInfo^.PropType^);
    case PropInfo^.PropType^^.Kind of
      tkInteger, 
      tkChar, 
      tkWChar, 
      tkClass:
        Result := TypInfo.GetOrdProp(AnObject, PropInfo);
      tkEnumeration:
        if TypeData^.BaseType^ = TypeInfo(Boolean) then
          Result := Boolean(GetOrdProp(AnObject, PropInfo))
        else
          Result := TypInfo.GetOrdProp(AnObject, PropInfo);
      tkSet:
        Result := TypInfo.GetOrdProp(AnObject, PropInfo);
      tkFloat:
        Result := TypInfo.GetFloatProp(AnObject, PropInfo);
      tkMethod:
        Result := PropInfo^.PropType^.Name;
      tkString, tkLString, tkWString:
        Result := TypInfo.GetStrProp(AnObject, PropInfo);
      tkVariant:
        Result := TypInfo.GetVariantProp(AnObject, PropInfo);
      tkInt64:
        Result := TypInfo.GetInt64Prop(AnObject, PropInfo) + 0.0;
    end;
  end;
 {$ELSE}
   if HasProperty(AnObject, AName) then
     Result := TypInfo.GetPropValue(AnObject, AName , False);
 {$ENDIF}  
end;

procedure SetProperty(AnObject: TObject; const AName: string; const AValue: Variant);

{$IFNDEF DELPHI5}

  function RangedValue(const AMin, AMax: Int64): Int64;
  begin
    Result := Trunc(AValue);
    if Result < AMin then
      Result := AMin;
    if Result > AMax then
      Result := AMax;
  end;

  procedure SetEnumProp(AnObject: TObject; APropInfo: PPropInfo; const AValue: string);
  var
    Data: Longint;
  begin
    Data := TypInfo.GetEnumValue(APropInfo^.PropType^, AValue);
    if Data >= 0 then
      TypInfo.SetOrdProp(AnObject, APropInfo, Data);
  end;
  
var
  PropInfo: PPropInfo;
  TypeData: PTypeData;
{$ENDIF}  
begin
 {$IFNDEF DELPHI5}
  PropInfo := TypInfo.GetPropInfo(AnObject.ClassInfo, AName);
  if PropInfo <> nil then
  begin
    TypeData := TypInfo.GetTypeData(PropInfo^.PropType^);
    case PropInfo.PropType^^.Kind of
      tkInteger, 
      tkChar, 
      tkWChar:
        TypInfo.SetOrdProp(AnObject, PropInfo, RangedValue(TypeData^.MinValue, TypeData^.MaxValue));
      tkEnumeration:
        if VarIsStr(AValue) then
          SetEnumProp(AnObject, PropInfo, VarToStr(AValue))
        else
          TypInfo.SetOrdProp(AnObject, PropInfo, RangedValue(TypeData^.MinValue, TypeData^.MaxValue));
      tkSet:
        if VarType(AValue) = varInteger then
          TypInfo.SetOrdProp(AnObject, PropInfo, AValue);
      tkFloat:
        TypInfo.SetFloatProp(AnObject, PropInfo, AValue);
      tkString, 
      tkLString, 
      tkWString:
        TypInfo.SetStrProp(AnObject, PropInfo, VarToStr(AValue));
      tkVariant:
        TypInfo.SetVariantProp(AnObject, PropInfo, AValue);
      tkInt64:
        TypInfo.SetInt64Prop(AnObject, PropInfo, RangedValue(TypeData^.MinInt64Value, TypeData^.MaxInt64Value));
    end;
  end;
 {$ELSE}
  if HasProperty(AnObject, AName) then
    TypInfo.SetPropValue(AnObject, AName, AValue); 
 {$ENDIF} 
end;

procedure dxDrawComboBoxItem(ACanvas: TCanvas; const R: TRect; const AText: string; 
  AnImageList: TCustomImageList; AnImageIndex: Integer; AState: TOwnerDrawState);

  function IsImageDrawn: Boolean;
  begin
    Result := (AnImageList <> nil) and (AnImageIndex > -1) and (AnImageIndex < AnImageList.Count);
  end;

var
  X, Y: Integer;
begin  
  ACanvas.FillRect(R);
  if IsImageDrawn then
  begin
    with R do 
    begin
      X := Left + 1;
      Y := Top + (Bottom - Top - AnImageList.Height) div 2;
    end;
    AnImageList.Draw(ACanvas, X, Y, AnImageIndex);
  end;
  
  with R do
  begin
    X := Left + 1 + Ord(IsImageDrawn) * (AnImageList.Width + 2);
    Y := Top + (Bottom - Top - ACanvas.TextHeight(AText)) div 2;
  end;
  ACanvas.TextOut(X, Y, AText);
end;
  
procedure dxLoadStringsFromRegistry(const APath: string; AStrings: TStrings);
var
  Entries: TStringList;
  I: Integer;
begin
  with TRegistry.Create do 
  try
    try
      if OpenKey(APath, False) then
      begin
        AStrings.Clear;
        Entries := TStringList.Create;
        try
          GetValueNames(Entries);
          for I := 0 to Entries.Count - 1 do 
            if ValueExists(Entries[I]) then 
              AStrings.Add(ReadString(Entries[I]));
        finally
          Entries.Free;
        end;  
      end;    
    except
      on ERegistryException do 
        { ignore }
      else
        raise;
    end;
  finally
    Free;  
  end;  
end;

procedure dxSaveStringsToRegistry(const APath: string; AStrings: TStrings);
var
  I: Integer;
begin
  with TRegistry.Create do 
  try
    try  
      if KeyExists(APath) then 
        DeleteKey(APath);
      if OpenKey(APath, True) then 
        for I := 0 to AStrings.Count - 1 do 
          WriteString(IntToStr(I), AStrings[I]);
    except
      on ERegistryException do 
        { ignore }
      else
        raise;
    end;    
  finally
    Free;  
  end;  
end;

procedure dxLoadListViewColumnsFromRegistry(AListView: TListView; const APath: string);
var
  I: Integer;
  S: string;
begin  
  with TRegistry.Create do
  try
    try
      if OpenKey(APath + '\' + AListView.Name + ColumnPath, False) then 
      begin
        AListView.Columns.BeginUpdate;
        try
          for I := 0 to AListView.Columns.Count - 1 do 
          begin
            S := Format(ColumnPattern, [I]);
            if ValueExists(S) then 
              AListView.Columns[I].Width := ReadInteger(S);
          end;
        finally
          AListView.Columns.EndUpdate;
        end;  
      end;  
    except
      on ERegistryException do
        { ignore }
      else
        raise;
    end;  
  finally
    Free;
  end;   
end;

procedure dxSaveListViewColumnsToRegistry(AListView: TListView; const APath: string);
var
  I: Integer;
  S: string;
begin
  with TRegistry.Create do
  try
    try
      S := APath + '\' + AListView.Name + ColumnPath;
      if KeyExists(S) then 
        DeleteKey(S);
      if OpenKey(S, True) then 
        for I := 0 to AListView.Columns.Count - 1 do 
          WriteInteger(Format(ColumnPattern, [I]), AListView.Columns[I].Width);
    except
      on ERegistryException do
        { ignore }
      else
        raise;
    end;  
  finally
    Free;
  end;   
end;

procedure dxSaveListViewSelection(AListView: TListView; ASelection: TList);
var
  I: Integer;
  Item: TListItem;
begin
  for I := 0 to AListView.Items.Count - 1 do 
  begin
    Item := AListView.Items[I];
    if Item.Selected then ASelection.Add(Item.Data);
  end;    
end;

procedure dxRestoreListViewSelection(AListView: TListView; ASelection: TList);
var
  I: Integer;
  Item: TListItem;
begin
  for I := 0 to ASelection.Count - 1 do 
  begin
    Item := AListView.FindData(0, ASelection[I], True, True);
    if Item <> nil then 
    begin
      Item.Selected := True;
      if I = 0 then
        Item.MakeVisible(True);
    end;  
  end;  
end;      

procedure CopyImages(ASourceHandle: HIMAGELIST; ADest: TCustomImageList);
var
  ImageCount, ImageWidth, ImageHeight, I: Integer;
  Image, Mask: TBitmap;
  R: TRect;
begin
  ADest.Clear;
  ImageCount := ImageList_GetImageCount(ASourceHandle);
  if ImageCount = 0 then Exit;
  
  ImageList_GetIconSize(ASourceHandle, ImageWidth, ImageHeight);
  ADest.Width := ImageWidth;
  ADest.Height := ImageHeight;

  // we need to copy all color depth and alpha channel information
  ADest.Handle := ImageList_Duplicate(ASourceHandle); 
  ADest.Clear;
  {???}
  R := MakeRect(0, 0, ImageWidth, ImageHeight);
  Image := TBitmap.Create;
  try
    Image.Height := ImageHeight;
    Image.Width := ImageWidth;
    Mask := TBitmap.Create;
    try
      Mask.Monochrome := True;
      Mask.Height := ImageHeight;
      Mask.Width := ImageWidth;

      for I := 0 to ImageCount - 1 do
      begin
        with Image.Canvas do
        begin
          FillRect(R);
          ImageList_Draw(ASourceHandle, I, Handle, 0, 0, ILD_NORMAL);
        end;
        with Mask.Canvas do
        begin
          FillRect(R);
          ImageList_Draw(ASourceHandle, I, Handle, 0, 0, ILD_MASK);
        end;
        ADest.Add(Image, Mask);
      end;
    finally
      Mask.Free;
    end;
  finally
    Image.Free;
  end;
end;

procedure PlaceButtons(const AButtons: array of TButton; ABtnOffsetX, ARightOrigin, ATopOrigin: Integer);
var
  DWP: HDWP;

  procedure PlaceButton(AButton: TButton; AOriginX, AOriginY: Integer);
  begin
    DWP := DeferWindowPos(DWP, AButton.Handle, 0, AOriginX, AOriginY, 0, 0, 
      SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOSIZE or SWP_NOZORDER);
    Control_UpdateBoundsRect(AButton, AOriginX, AOriginY, AButton.Width, AButton.Height);
  end;

  procedure ShiftButtons(Index, Shift: Integer);
  var
    OriginX, OriginY, I: Integer;
  begin
    OriginY := ATopOrigin;
    for I := High(AButtons) downto Index + 1 do 
    begin
      OriginX := AButtons[I - Shift].Left;
      PlaceButton(AButtons[I], OriginX, OriginY);
    end;  
  end;

  procedure OriginalPlaceButtons;
  var
    OriginX, OriginY, I: Integer;
  begin
    OriginX := ARightOrigin;
    OriginY := ATopOrigin;
    for I := Low(AButtons) to High(AButtons) do 
    begin
      Dec(OriginX, AButtons[I].Width);
      if I > 0 then Dec(OriginX, ABtnOffsetX);
      PlaceButton(AButtons[I], OriginX, OriginY);
    end;  
  end;
  
  procedure ReplaceButtons;
  var
    Found: Boolean;
    I, Count, StartIndex: Integer;
  begin
    StartIndex := 0;
    Count := 1;
    repeat
      Found := False;
      for I := StartIndex to High(AButtons) do 
        if not AButtons[I].Visible then 
        begin
          Found := True;
          Count := 1;
          while not AButtons[I + Count].Visible do 
            Inc(Count);
        end;  
      if Found then 
      begin 
        ShiftButtons(StartIndex, Count);
        Inc(StartIndex, Count);
      end;      
    until not Found;
  end;

  procedure InvalidateButtons;
  var
    I: Integer;
  begin
    for I := Low(AButtons) to High(AButtons) do 
      AButtons[I].Invalidate;
  end;
  
begin
  DWP := BeginDeferWindowPos(High(AButtons) - Low(AButtons)+ 1);
  try
    OriginalPlaceButtons;
    ReplaceButtons;
  finally  
    EndDeferWindowPos(DWP);
    InvalidateButtons;
  end;
end;

procedure dxAppendList(ASource, ADest: TList);
var
  PrevCount: Integer;
  DestMem: PPointerList;
begin
  PrevCount := ADest.Count;
  ADest.Count := ADest.Count + ASource.Count;
  ADest.Count := ADest.Count + ASource.Count;
  if ADest.Count <> 0 then
  begin
    DestMem := Pointer(Integer(ADest.List) + SizeOf(Pointer) * PrevCount);
    Move(ASource.List^, DestMem^, SizeOf(Pointer) * ASource.Count);
  end; 
end;

procedure dxCopyList(ASource, ADest: TList);
begin
  ADest.Count := ASource.Count;
  Move(ASource.List^, ADest.List^, SizeOf(Pointer) * ADest.Count);
end;

procedure dxShiftIntegerListValues(AList: TList; AValue: Integer);
var
  I: Integer;
begin
  with AList do 
    for I := 0 to Count - 1 do
      List^[I] := Pointer(Integer(List^[I]) + AValue);
end;

function dxCheckStateImageIndexMap(AState: TCheckBoxState): Integer;
const
  CheckBoxStateMap: array[TCheckBoxState] of Integer = (0, 1, 2);
begin
  Result := 1 + CheckBoxStateMap[AState];
end;

procedure dxCreateCheckMarkImages(AnImageList: TCustomImageList);
const
  MaskColor: TColor = clFuchsia;
   
   procedure DrawCheckBox(ACanvas: TCanvas; const R: TRect; State: TCheckBoxState);
   const
     InteriorColors: array[Boolean] of TColor = (clWindow, clBtnFace);
   var
     C: TColor;
   begin
     with ACanvas do
     begin
       C := Font.Color;

       //frame
       Font.Color := clBtnShadow;
       DrawGlyph(Handle, R, CheckBottomRightArcInnerIndex);
       DrawGlyph(Handle, R, CheckTopLeftArcInnerIndex);

       //interior
       Font.Color := InteriorColors[State = cbGrayed];
       DrawGlyph(Handle, R, CheckInteriorIndex);

       //checkmark
       if State in [cbChecked, cbGrayed] then
       begin
         Font.Color := clWindowText;
         DrawGlyph(Handle, R, CheckMarkIndex);
       end;

       Font.Color := C;
     end;  
   end;

var
  Bitmap: TBitmap;
  State: TCheckBoxState;
  R, CheckRect: TRect;
  Ch: Char;
  Size: TSize;
begin
  Bitmap := TBitmap.Create;
  with Bitmap do 
  try
    Width := AnImageList.Width;
    Height := AnImageList.Height;
    
    Canvas.Font.Name := 'Marlett';
    Canvas.Font.Size := 10;
    Canvas.Font.Charset := SYMBOL_CHARSET;
        
    R := MakeRect(0, 0, Width, Height);
    Canvas.Brush.Color := MaskColor;
    Canvas.FillRect(R);
    AnImageList.AddMasked(Bitmap, clDefault);

    CheckRect := R;
    Ch := Chr(CheckBottomRightArcInnerIndex);
    Size := Canvas.TextExtent(Ch);
    InflateRect(CheckRect, -(R.Right - R.Left - Size.cX) div 2, -(R.Bottom - R.Top - Size.cY) div 2);
    
    for State := Low(TCheckBoxState) to High(TCheckBoxState) do 
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.FillRect(R);
      Canvas.Brush.Style := bsClear;
      DrawCheckBox(Canvas, CheckRect, State);
      
      AnImageList.AddMasked(Bitmap, clDefault);
    end;  
  finally
    Bitmap.Free;
  end;  
end;  

function dxPSDrawModeImages: TCustomImageList;

  procedure LoadImages;

    procedure LoadImage(B: TBitmap; const AResName: string);
    begin
      Bitmap_LoadFromResourceName(B, AResName);
      FDrawModeImages.AddMasked(B, clDefault);
    end;

  var
    B: TBitmap;
  begin
    B := TBitmap.Create;
    try
      LoadImage(B, IDB_DXPSDRAWMODE_STRICT);
      LoadImage(B, IDB_DXPSDRAWMODE_ODDEVEN);
      LoadImage(B, IDB_DXPSDRAWMODE_CHESS);
      LoadImage(B, IDB_DXPSDRAWMODE_BORROW);
    finally
      B.Free;
    end;
  end;
  
begin
  if FDrawModeImages = nil then               
  begin
    FDrawModeImages := TImageList.Create(nil);    
    LoadImages;
  end;  
  Result := FDrawModeImages;
end;

{$IFNDEF DELPHI5}
procedure FreeAndNil(var Obj);
var
  P: TObject;
begin
  P := TObject(Obj);
  TObject(Obj) := nil;
  P.Free;
end;
{$ENDIF}

function dxAllocatehWnd(AMethod: TWndMethod): HWND;
begin
   {$IFDEF DELPHI6}
    Result := Classes.AllocatehWnd(AMethod);
   {$ELSE}
    Result := Forms.AllocatehWnd(AMethod);
   {$ENDIF}
end;

procedure dxDeallocatehWnd(AWnd: HWND);
begin
  if IsWindow(AWnd) then
     {$IFDEF DELPHI6}
      Classes.DeallocatehWnd(AWnd);
     {$ELSE}
      Forms.DeallocatehWnd(AWnd);
     {$ENDIF}
end;

procedure dxRecreateWnd(AControl: TWinControl);
begin
  TWinControlAccess(AControl).RecreateWnd;
end;

function MakeBounds(ALeft, ATop, AWidth, AHeight: Integer): TRect;
begin
  with Result do
  begin
    Left := ALeft;
    Top := ATop;
    Right := ALeft + AWidth;
    Bottom := ATop + AHeight;
  end;
end;

function MakePoint(X, Y: Integer): TPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

function MakeRect(ALeft, ATop, ARight, ABottom: Integer): TRect;
begin
  with Result do
  begin
    Left := ALeft;
    Top := ATop;
    Right := ARight;
    Bottom := ABottom;
  end;
end;

function MakeRect(const ATopLeft, ABottomRight: TPoint): TRect;
begin
  with Result do 
  begin
    TopLeft := ATopLeft;
    BottomRight := ABottomRight;
  end;
end;

function TTagToInt(AValue:  Integer ): Integer;
begin
  Result := AValue;
end;

function TTagToObj(AValue:  Integer ): TObject;
begin
  Result := TObject(AValue);
end;

function TTagToClass(AValue:  Integer ): TClass;
begin
  Result := TClass(AValue);
end;

function MakeTTag(AValue: Integer):  Integer ;
begin
  Result := AValue;
end;

function MakeTTag(AValue: TObject):  Integer ;
begin
  Result := Integer(AValue);
end;

function MakeTTag(AValue: TClass):  Integer ;
begin
  Result := Integer(AValue);
end;

function Control_GetColor(AControl: TControl): TColor;
begin
  Result := TControlAccess(AControl).Color;
end;

function Control_GetControlStyle(AControl: TControl): TControlStyle;
begin
  Result := TControlAccess(AControl).ControlStyle;
end;

function Control_GetCtl3D(AControl: TWinControl): Boolean;
begin
  Result := TWinControlAccess(AControl).Ctl3D;
end;

function Control_GetFont(AControl: TControl): TFont;
begin
  Result := TControlAccess(AControl).Font;
end;

function Control_GetPopupMenu(AControl: TControl): TPopupMenu;
begin
  Result := TControlAccess(AControl).PopupMenu;
end;

function Control_GetText(AControl: TControl): string;
begin
  Result := TControlAccess(AControl).Text;
end;

procedure Control_SetParentBackground(AControl: TWinControl; Value: Boolean);
begin
{$IFDEF DELPHI7}
  TWinControlAccess(AControl).ParentBackground := Value;
{$ENDIF} 
end;  

procedure Control_DoContextPopup(AControl: TControl; const Pt: TPoint; var AHandled: Boolean);
begin
  AHandled := False;
   {$IFDEF DELPHI5}
    TControlAccess(AControl).DoContextPopup(Pt, AHandled);
   {$ENDIF} 
end;

procedure Control_PaintWindow(AControl: TWinControl; DC: HDC);
begin
  TWinControlAccess(AControl).PaintWindow(DC);
end;

procedure Control_SendCancelMode(AControl, ASender: TControl);
begin
  TControlAccess(AControl).SendCancelMode(ASender);
end;

procedure Control_UpdateBoundsRect(AControl: TControl; const R: TRect);
begin
  TControlAccess(AControl).UpdateBoundsRect(R);
end;

procedure Control_UpdateBoundsRect(AControl: TControl; ALeft, ARight, AWidth, AHeight: Integer);
begin
  Control_UpdateBoundsRect(AControl, MakeBounds(ALeft, ARight, AWidth, AHeight));
end;

procedure PopupMenu_DoPopup(APopupMenu: TPopupMenu);
begin
 {$IFDEF DELPHI5}              
    TPopupMenuAccess(APopupMenu).DoPopup(APopupMenu);
 {$ELSE}
  if Assigned(APopupMenu.OnPopup) then APopupMenu.OnPopup(APopupMenu);
 {$ENDIF}
end;

function RichEdit_GetBorderStyle(AControl: TCustomRichEdit): TBorderStyle;
begin
  Result := TCustomRichEditAccess(AControl).BorderStyle;
end;

function RichEdit_GetLines(AControl: TCustomRichEdit): TStrings;
begin
  Result := TCustomRichEditAccess(AControl).Lines;
end;

procedure Bitmap_LoadFromResourceName(ABitmap: TBitmap; const AResName: string; 
  ABaseName: string = 'dxPSImgs');
begin
  ABitmap.LoadFromResourceName(hInstance, AResName);
end;

procedure Icon_LoadFromResourceName(AIcon: TIcon; const AResName: string; 
  ABaseName: string = 'dxPSImgs');
var
  Bitmap: TBitmap;
  ImageList: TImageList;
begin
  Bitmap := TBitmap.Create;
  try
    Bitmap_LoadFromResourceName(Bitmap, AResName);
    ImageList := TImageList.CreateSize(Bitmap.Width, Bitmap.Height);
    try
      ImageList.AllocBy := 1;
      ImageList.AddMasked(Bitmap, clDefault);
      AIcon.Handle := ImageList_GetIcon(ImageList.Handle, 0, ILD_NORMAL);
    finally
      ImageList.Free;
    end;
  finally
    Bitmap.Free;
  end;
end;

{$IFNDEF DELPHI6}
type
  PPointer = ^Pointer;
{$ENDIF}

function IsDelphiObject(AData: DWORD): Boolean;
var
   P: Pointer;
   SelfPtr: Pointer;
begin
   Result := False;

   P := Pointer(AData);
   if IsBadReadPtr(P, SizeOf(Pointer)) then Exit;

   P := PPointer(P)^;
   if IsBadReadPtr(P, SizeOf(Pointer)) then Exit;

   SelfPtr := Pointer(Integer(P) + vmtSelfPtr);
   if IsBadReadPtr(SelfPtr, SizeOf(Pointer)) then Exit;
   SelfPtr := PPointer(SelfPtr)^;

   Result := P = SelfPtr;
end;

initialization
  CoInitialize(nil);
  PopulateShellImages(True);
  
finalization
  FreeAndNil(FDrawModeImages);
  if FPatternBrush <> 0 then 
    Windows.DeleteObject(FPatternBrush);

  FreeAndNil(FTrueTypeFonts);
  FreeAndNil(FNonTrueTypeFonts);
  FreeAndNil(FShellLargeImages);
  FreeAndNil(FShellSmallImages);

  CoUninitialize;
  
end.
