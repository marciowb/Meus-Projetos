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

unit cxSSCtrls;

{$I cxVer.inc}

interface
uses
  Classes, Math, cxClasses, cxGraphics,
  Windows, Controls, StdCtrls, ExtCtrls, Graphics, cxSSColorBox;

type
  TcxPaintPanel = class;
  TcxPaintEvent = procedure(Sender: TcxPaintPanel) of object;

  { TcxLabelBevel }
  TcxLabelBevel = class(TCustomControl)
  private
    FCaptionText: WideString;
    procedure SetCaption(const Value: WideString);
    procedure SetComponentCaption(const Value: TCaption);
  protected
    procedure Paint; override;
    property Caption write SetComponentCaption;
  published
    property CaptionText: WideString read FCaptionText write SetCaption;
    property Font;
  end;

  { TcxPaintPanel }
  TcxPaintPanel = class(TCustomControl)
  private
    FOnPaint: TcxPaintEvent;
  protected
    procedure Paint; override;
  public
    property Canvas;
  published
    constructor Create(AOwner: TComponent); override;
    procedure InvalidateRect(const ARect: TRect; EraseBackground: Boolean);
    property OnPaint: TcxPaintEvent read FOnPaint write FOnPaint;
    property Align;
    property Font;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  { TcxSSStyleListBoxItem }
  TcxSSStyleListBoxItem = record
    Value: string;
    Color: TColor;
    ValueType: Integer;
  end;

  TcxStyleChangeEvent = procedure(Sender: TObject; StyleValue: Integer) of object;

  { TcxStyleListBox }
  TcxSSStyleListBox = class(TListBox)
  private
    FIndex: Integer;
    FItems: array of TcxSSStyleListBoxItem;
    FOnStyleChanged: TcxStyleChangeEvent;
    procedure SetItemIdx(AIndex: Integer);
  protected
    procedure OnChange(Sender: TObject); virtual;
    procedure OnDrawStyleItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
  public
    constructor Create(AOwner: TComponent); override;
    procedure AssignItems(const AItems: array of TcxSSStyleListBoxItem);
    property OnStyleChanged: TcxStyleChangeEvent read FOnStyleChanged write FOnStyleChanged;
    property ItemIndex write SetItemIdx;
  end;

  { Assign resource strings for any TControl.Caption and TStrings items}
  procedure SetCaptions(const AControls: array of TControl;
    const ACaptions: array of string);
  procedure SetItems(AControl: TComboBox; const AStringItems: array of string);

implementation
type
  TControlAccess = class(TControl);

{ TcxLabelBevel }

procedure TcxLabelBevel.Paint;
var
  ATextExtent: TSize;
  ARect: TRect;
begin
  cxDrawThemeParentBackground(Self, Canvas, ClientRect);
  if FCaptionText <> '' then
  begin
    ATextExtent := Canvas.TextExtent(FCaptionText);
    Canvas.Font.Assign(Font);
    Canvas.Brush.Style := bsClear;
    with ATextExtent do
      Canvas.TextRect(Rect(0, 0, CX, ClientHeight), 0, 0, FCaptionText);
    Inc(ATextExtent.CX, 3);
    Dec(ATextExtent.CY, 3);
  end
  else
    ATextExtent := TSize(Point(0, ClientHeight));
  ARect := Rect(ATextExtent.CX, ClientHeight - 2, ClientWidth, ClientHeight - 3);
  Canvas.Brush.Color := clBtnHighLight;
  Canvas.FillRect(ARect);
  Canvas.Brush.Color := clBtnShadow;
  OffsetRect(ARect, 0, -1);
  Canvas.FillRect(ARect);
end;

procedure TcxLabelBevel.SetCaption(const Value: WideString);
begin
  FCaptionText := Value;
  Invalidate;
end;

procedure TcxLabelBevel.SetComponentCaption(const Value: TCaption);
begin
  FCaptionText := Value;
end;

{ TcxPaintPanel }
constructor TcxPaintPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  TabStop := False;
end;

procedure TcxPaintPanel.InvalidateRect(const ARect: TRect; EraseBackground: Boolean);
begin
  if HandleAllocated then
    Windows.InvalidateRect(Handle, @ARect, EraseBackground);
end;

procedure TcxPaintPanel.Paint;
begin
  if Assigned(FOnPaint) then
    FOnPaint(Self)
  else
    with Canvas do
    begin
      Brush.Color := clBtnFace;
      Pen.Color := clBtnShadow;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;
  inherited;
end;

procedure SetCaptions(const AControls: array of TControl;
  const ACaptions: array of string);
var
  I: Integer;
begin
  for I := Low(AControls) to High(AControls) do
    if (I >= Low(ACaptions)) and (I <= High(ACaptions)) then
      if AControls[I] is TcxLabelBevel then
        (AControls[I] as TcxLabelBevel).CaptionText := ACaptions[I]
      else
        TControlAccess(AControls[I]).Caption := ACaptions[I];
end;

procedure SetItems(AControl: TComboBox; const AStringItems: array of string);
var
  I: Integer;
begin
  for I := Low(AStringItems) to High(AStringItems) do
    AControl.Items.Add(AStringItems[I]);
  AControl.ItemIndex := 0;
end;

  { TcxStyleListBox }
constructor TcxSSStyleListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  OnClick := OnChange;
  OnDrawItem := OnDrawStyleItem;
end;

procedure TcxSSStyleListBox.AssignItems(const AItems: array of TcxSSStyleListBoxItem);
var
  I: Integer;
begin
  if Length(AItems) = 0 then
  begin
    SetLength(FItems, 0);
    Visible := False
  end
  else
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      ItemIndex := 0;
      SetLength(FItems, Length(AItems));
      for I := 0 to Length(AItems) - 1 do
      begin
        Items.Add(AItems[I].Value);
        FItems[I] := AItems[I];
      end
    finally
      Visible := True;
      ItemIndex := 0;
      OnChange(Self);
      FIndex := -1; 
      Items.EndUpdate;
    end;
  end;
end;

procedure TcxSSStyleListBox.OnChange(Sender: TObject);
begin
  if Assigned(FOnStyleChanged) and (ItemIndex >= 0) and (Length(FItems) > 0) then
    FOnStyleChanged(Self, FItems[Max(ItemIndex, 0)].ValueType);
end;
                          
procedure TcxSSStyleListBox.OnDrawStyleItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);

  function GetColor(const AColor: TColor; IsSelected: Boolean): Integer;
  begin
    Result := ColorToRgb(AColor);
    if IsSelected then
      Result := $FFFFFF xor Result;
  end;

var
  IsSelected: Boolean;
begin
  IsSelected := (not Focused and (FIndex <= 0) and (Index = 0)) or (odSelected in State) or (odFocused in State);
  if IsSelected then
    Canvas.Brush.Color := clHighLight
  else
    Canvas.Brush.Color := clWindow;
  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Color := clBtnFace;
  Canvas.Pen.Style := psSolid;
  Canvas.Rectangle(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom);
  if Index < Length(FItems) then
  begin
    Canvas.Font.Color := GetColor(FItems[Index].Color, IsSelected);
    Canvas.TextRect(Rect, Rect.Left + 10, Rect.Top, Items[Index]);
  end
  else
  begin
    Canvas.Font.Color := GetColor(Color, not IsSelected);
    Canvas.TextRect(Rect, Rect.Left + 10, Rect.Top, Items[Index]);
  end;
end;

procedure TcxSSStyleListBox.SetItemIdx(AIndex: Integer);
begin
  FIndex := AIndex;
  inherited ItemIndex := AIndex;
end;

end.
