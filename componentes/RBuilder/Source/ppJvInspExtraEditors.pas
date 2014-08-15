{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                                                              BBBBB   }

{**************************************************************************************************}
{ This unit is a adapted from the JEDI Visible Component Library (J-VCL).                          }
{ The original header appears in the box below.                                                    }
{                                                                                                  }
{ original unit: JvInspExtraEditors.pas                                                                }
{                                                                                                  }
{ This unit is a subset of the original. It contains only types, classes and methods,              }
{ required to support the JvInspector and related classes. A prefix of pp has been added           }
{ to all classes and methods to differentiate them from the original. This has been done to        }
{ avoid conflicts for users that install ReportBuilder and the J-VCL.                              }
{                                                                                                  }
{**************************************************************************************************}

{-----------------------------------------------------------------------------
Project JEDI Visible Component Library (J-VCL)

The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: JvInspExtraEditors.pas, released on 2001-02-28.

The Initial Developer of the Original Code is Marcel Bestebroer
 <marcelb@zeelandnet.nl>.
Portions created by Marcel Bestebroer are Copyright (C) 2000 - 2001 mbeSoft.
All Rights Reserved.

Contributor(s): Michael Beck [mbeck@bigfoot.com].

Last Modified: 2000-02-28

You may retrieve the latest version of this file at the Project JEDI's JVCL home page,
located at http://jvcl.sourceforge.net

-----------------------------------------------------------------------------}

unit ppJvInspExtraEditors;

interface

uses
  SysUtils,
  Windows,
  Classes,
  Graphics,
  Types,
  Controls,
  StdCtrls,
  ppJvInspector,
  ppJclRTTI;

type

  { TColor item editor. Will render the color in a box, together with the name/value }
  TppJvInspectorColorItem = class(TppJvCustomInspectorItem)
  private
    FColors: TStrings;
    FStdColors: TStrings;
    FIncludeStdColors: Boolean;
  protected
    procedure AddStdColor(const S: string);
    function BorderColor(const ABackgroundColor, AInternalColor: TColor): TColor;
    function NameForColor(const Color: TColor): string;
    procedure PaintValue(const Color: TColor; const ColorName: string; const ACanvas: TCanvas;
      const ARect: TRect);
    procedure DoDrawListItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure DoMeasureListItem(Control: TWinControl; Index: Integer; var Height: Integer); override;
    procedure DoMeasureListItemWidth(Control: TWinControl; Index: Integer; var Width: Integer); override;
    function GetDisplayValue: string; override;
    procedure GetValueList(const Strings: TStrings); override;
    procedure SetDisplayValue(const Value: string); override;
    procedure SetFlags(const Value: TInspectorItemFlags); override;
    procedure SetRects(const RectKind: TInspectorPaintRect; Value: TRect); override;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure DrawValue(const ACanvas: TCanvas); override;
    class procedure RegisterAsDefaultItem;
    class procedure UnregisterAsDefaultItem;
    property IncludeStdColors: Boolean read FIncludeStdColors write FIncludeStdColors;
  end;

implementation


type
  TColorQuad = packed record
    Red: Byte;
    Green: Byte;
    Blue: Byte;
    Alpha: Byte;
  end;


//=== TppJvInspectorColorItem ==================================================

procedure TppJvInspectorColorItem.AddStdColor(const S: string);
begin
  FStdColors.AddObject(S, TObject(ppJclStrToTypedInt(S, TypeInfo(TColor))));
end;

function TppJvInspectorColorItem.BorderColor(const ABackgroundColor, AInternalColor: TColor): TColor;
var
  BckRGB: TColor;
  ColRGB: TColor;

  function IsLightColor(const RGB: TColor): Boolean;
  begin
    with TColorQuad(RGB) do
      Result := (Red > 192) or (Green > 192) or (Blue > 192);
  end;

begin
  BckRGB := ColorToRGB(ABackgroundColor);
  ColRGB := ColorToRGB(AInternalColor);
  if IsLightColor(BckRGB) and IsLightColor(ColRGB) then
    Result := clBlack
  else
  if not IsLightColor(BckRGB) and not IsLightColor(ColRGB) then
    Result := clWhite
  else
    Result := AInternalColor;
end;

function TppJvInspectorColorItem.NameForColor(const Color: TColor): string;
begin
  Result := ppJclTypedIntToStr(Color, TypeInfo(TColor));
end;

procedure TppJvInspectorColorItem.PaintValue(const Color: TColor; const ColorName: string;
  const ACanvas: TCanvas; const ARect: TRect);
var
  TH: Integer;
  BoxRect: TRect;
  bc: TColor;
  pc: TColor;
begin
  TH := Rects[iprValue].Bottom - Rects[iprValue].Top - 2;
  BoxRect.Left := ARect.Left + (ARect.Bottom - ARect.Top - TH) div 2;
  BoxRect.Top := ARect.Top + BoxRect.Left - ARect.Left;
  BoxRect.Right := BoxRect.Left + TH;
  BoxRect.Bottom := BoxRect.Top + TH;
  with ACanvas do
  begin
    if Color <> clNone then
    begin
      bc := Brush.Color;
      pc := Pen.Color;
      try
        Brush.Color := Color;
        Pen.Color := BorderColor(bc, Color);
        Rectangle(BoxRect);
      finally
        Pen.Color := pc;
        Brush.Color := bc;
      end;
    end;
    TextOut(ARect.Left + (ARect.Bottom - ARect.Top) + 1, BoxRect.Top, ColorName);
  end;
end;

procedure TppJvInspectorColorItem.DoDrawListItem(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  with TListBox(Control) do
  begin
    if odSelected in State then
      Canvas.Brush.Color := clHighlight;
    Canvas.FillRect(Rect);
    Rect.Top := Rect.Top + 1;
    Rect.Bottom := Rect.Bottom - 1;
    PaintValue(TColor(Items.Objects[Index]), Items[Index], Canvas, Rect);
  end;
end;

procedure TppJvInspectorColorItem.DoMeasureListItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  with Rects[iprValueArea] do
    Height := Bottom - Top + 2;
end;

procedure TppJvInspectorColorItem.DoMeasureListItemWidth(Control: TWinControl; Index: Integer;
  var Width: Integer);
begin
  with Rects[iprValueArea] do
    Width := Width + Bottom - Top + 2;
end;

function TppJvInspectorColorItem.GetDisplayValue: string;
var
  TempSL: TStrings;
  I: Integer;
begin
  TempSL := TStringList.Create;
  try
    GetValueList(TempSL);
    I := TempSL.IndexOfObject(TObject(Data.AsOrdinal));
    if I = -1 then
      Result := ppJclTypedIntToStr(Data.AsOrdinal, TypeInfo(TColor))
    else
      Result := TempSL[I];
  finally
    TempSL.Free;
  end;
end;

procedure TppJvInspectorColorItem.GetValueList(const Strings: TStrings);
var
  TempSL: TStringList;
begin
  TempSL := TStringList.Create;
  try
    if IncludeStdColors then
      TempSL.AddStrings(FStdColors);
    TempSL.AddStrings(FColors);
    DoGetValueList(Strings);
    TempSL.AddStrings(Strings);
    TempSL.Sort;
    Strings.Assign(TempSL);
  finally
    TempSL.Free;
  end;
end;

procedure TppJvInspectorColorItem.SetDisplayValue(const Value: string);
var
  SL: TStrings;
  I: Integer;
begin
  SL := TStringList.Create;
  try
    GetValueList(SL);
    I := SL.IndexOf(Value);
    if I > -1 then
      I := Integer(SL.Objects[I])
    else
      I := ppJclStrToTypedInt(Value, TypeInfo(TColor));
    Data.AsOrdinal := I;
  finally
    SL.Free;
  end;
end;

procedure TppJvInspectorColorItem.SetFlags(const Value: TInspectorItemFlags);
begin
  inherited SetFlags(Value + [iifValueList, iifAllowNonListValues, iifOwnerDrawListVariable] -
    [iifOwnerDrawListFixed]);
end;

procedure TppJvInspectorColorItem.SetRects(const RectKind: TInspectorPaintRect; Value: TRect);
begin
  if RectKind = iprValue then
    Value.Left := Value.Left + (Value.Bottom - Value.Top) + 2;
  inherited SetRects(RectKind, Value);
end;

procedure TppJvInspectorColorItem.AfterConstruction;
begin
  inherited AfterConstruction;
  FColors := TStringList.Create;
  FStdColors := TStringList.Create;
  GetColorValues(AddStdColor);
  TStringList(FStdColors).Sort;
  IncludeStdColors := True;
  Flags := [iifValueList, iifAllowNonListValues, iifOwnerDrawListVariable];
end;

procedure TppJvInspectorColorItem.BeforeDestruction;
begin
  FStdColors.Free;
  FColors.Free;
  inherited BeforeDestruction;
end;

procedure TppJvInspectorColorItem.DrawValue(const ACanvas: TCanvas);
var
  Color: TColor;
  S: string;
  ARect: TRect;
  SafeColor: TColor;
begin
  Color := clNone;
  if Data = nil then
    S := sppJvInspItemUnInitialized
  else
  try
    if not Data.IsInitialized then
      S := sppJvInspItemUnInitialized
    else
    if not Data.HasValue then
      S := sppJvInspItemNoValue
    else
    if not Data.IsAssigned then
      S := sppJvInspItemUnassigned
    else
    begin
      S := DisplayValue;
      Color := Data.AsOrdinal;
    end;
  except
    S := sppJvInspItemValueException + ExceptObject.ClassName + ': ' +
      Exception(ExceptObject).Message;
  end;
  ARect := Rects[iprValueArea];
  SafeColor := ACanvas.Brush.Color;
  if Editing then
    ACanvas.Brush.Color := clWindow;
  try
    ACanvas.FillRect(ARect);
    PaintValue(Color, S, ACanvas, ARect);
    if Editing then
      DrawEditor(ACanvas);
  finally
    if Editing then
      ACanvas.Brush.Color := SafeColor;
  end;
end;

class procedure TppJvInspectorColorItem.RegisterAsDefaultItem;
begin
  with TppJvCustomInspectorData.ItemRegister do
    if IndexOf(Self) = -1 then
      Add(TppJvInspectorTypeInfoRegItem.Create(Self, TypeInfo(TColor)));
end;

class procedure TppJvInspectorColorItem.UnregisterAsDefaultItem;
begin
  TppJvCustomInspectorData.ItemRegister.Delete(Self);
end;

initialization
  TppJvInspectorColorItem.RegisterAsDefaultItem;

finalization
  TppJvInspectorColorItem.UnRegisterAsDefaultItem;


end.
