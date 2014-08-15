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

unit ppTBXToolPals;

// TBX Package
// Copyright 2001-2004 Alex A. Denisov. All Rights Reserved
// See TBX.chm for license and installation instructions
//
// $Id: TBXToolPals.pas 7 2004-02-21 06:07:53Z  $

interface

uses
  Windows, Messages, Classes, SysUtils, Controls, Forms, Graphics,

  ppTB2Item,

  ppTBX,
  ppTBXThemes;

{$I ppTB2Ver.inc}
{$I ppTBX.inc}

type
  TRowColCount = 1..100;
  TppTBXCustomToolPalette = class;

  TTPCalcSize = procedure(Sender: TppTBXCustomToolPalette; Canvas: TCanvas;
    var AWidth, AHeight: Integer) of object;
  TTPGetCellVisible = procedure(Sender: TppTBXCustomToolPalette;
    ACol, ARow: Integer; var Visible: Boolean) of object;
  TTPGetCellHint = procedure(Sender: TppTBXCustomToolPalette;
    ACol, ARow: Integer; var HintText: string) of object;
  TTPDrawCellImage = procedure(Sender: TppTBXCustomToolPalette; Canvas: TCanvas;
    ARect: TRect; ACol, ARow: Integer; Selected, Hot, Enabled: Boolean) of object;
  TTPCellClick = procedure(Sender: TppTBXCustomToolPalette;
    var ACol, ARow: Integer; var AllowChange: Boolean) of object;
  TppTBXToolPaletteOptions = set of (tpoCustomImages, tpoNoAutoSelect);

  TppTBXCustomToolPalette = class(TppTBXCustomItem)
  private
    FColCount: TRowColCount;
    FPaletteOptions: TppTBXToolPaletteOptions;
    FRowCount: TRowColCount;
    FSelectedCell: TPoint;
    FOnCalcImageSize: TTPCalcSize;
    FOnChange: TNotifyEvent;
    FOnCellClick: TTPCellClick;
    FOnDrawCellImage: TTPDrawCellImage;
    FOnGetCellVisible: TTPGetCellVisible;
    FOnGetCellHint: TTPGetCellHint;
    procedure SetPaletteOptions(Value: TppTBXToolPaletteOptions);
    procedure SetSelectedCell(Value: TPoint);
  protected
    procedure DoCalcCellSize(Canvas: TCanvas; var AWidth, AHeight: Integer); virtual;
    procedure DoCalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer); virtual;
    function  DoCellClick(var ACol, ARow: Integer): Boolean; virtual;
    procedure DoChange; virtual;
    procedure DoDrawCellImage(Canvas: TCanvas; const ARect: TRect; ACol, ARow: Integer; ItemInfo: TppTBXItemInfo); virtual;
    procedure DoGetCellVisible(ACol, ARow: Integer; var Visible: Boolean); virtual;
    procedure DoGetHint(ACell: TPoint; var HintText: string); virtual;
    function  GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass; override;
    procedure HandleClickCell(ACol, ARow: Integer); virtual;
    procedure SetColCount(Value: TRowColCount); virtual;
    procedure SetRowCount(Value: TRowColCount); virtual;
    property ColCount: TRowColCount read FColCount write SetColCount default 1;
    property PaletteOptions: TppTBXToolPaletteOptions read FPaletteOptions write SetPaletteOptions;
    property RowCount: TRowColCount read FRowCount write SetRowCount default 1;
    property SelectedCell: TPoint read FSelectedCell write SetSelectedCell;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnCalcImageSize: TTPCalcSize read FOnCalcImageSize write FOnCalcImageSize;
    property OnCellClick: TTPCellClick read FOnCellClick write FOnCellClick;
    property OnDrawCellImage: TTPDrawCellImage read FOnDrawCellImage write FOnDrawCellImage;
    property OnGetCellVisible: TTPGetCellVisible read FOnGetCellVisible write FOnGetCellVisible;
    property OnGetCellHint: TTPGetCellHint read FOnGetCellHint write FOnGetCellHint;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TppTBXToolPalette = class(TppTBXCustomToolPalette)
  public
    property SelectedCell;
  published
    property ColCount;
    property HelpContext;
    property Images;
    property Options;
    property PaletteOptions;
    property RowCount;
    property Stretch;
    property Visible;
    property OnChange;
    property OnCalcImageSize;
    property OnCellClick;
    property OnDrawCellImage;
    property OnGetCellHint;
    property OnGetCellVisible;
  end;

  TppTBXToolViewer = class(TppTBXItemViewer)
  private
    FCellHeight: Integer;
    FCellWidth: Integer;
    FColCount: Integer;
    FRowCount: Integer;
    FHotCell: TPoint;
  protected
    Indent: Integer;
    MouseIsDown: Boolean;
    procedure CalcCellSize(Canvas: TCanvas; var AWidth, AHeight: Integer); virtual;
    procedure CalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer); virtual;
    procedure CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    function  GetImageIndex(Col, Row: Integer): Integer;
    function  GetCellAt(X, Y: Integer; out Col, Row: Integer): Boolean;
    function  GetCellRect(ClientAreaRect: TRect; Col, Row: Integer): TRect; virtual;
    function  GetHint(Col, Row: Integer): string;
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure DrawCell(Canvas: TCanvas; const CellRect: TRect; Col, Row: Integer; var ItemInfo: TppTBXItemInfo);
    procedure DrawCellImage(Canvas: TCanvas; const ARect: TRect; Col, Row: Integer; ItemInfo: TppTBXItemInfo); virtual;
    procedure Entering(OldSelected: TppTBItemViewer); override;
    procedure InvalidateCell(ACol, ARow: Integer);
    function  IsCellVisible(Cell: TPoint): Boolean; virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Shift: TShiftState; X, Y: Integer;var MouseDownOnMenu: Boolean); override;
    procedure MouseMove(X, Y: Integer); override;
    procedure MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean); override;
    procedure Paint(const Canvas: TCanvas; const ClientAreaRect: TRect; IsHoverItem, IsPushed, UseDisabledShadow: Boolean); override;
    property CellHeight: Integer read FCellHeight write FCellHeight;
    property CellWidth: Integer read FCellWidth write FCellWidth;
    property ColCount: Integer read FColCount;
    property HotCell: TPoint read FHotCell;
    property RowCount: Integer read FRowCount;
  public
    constructor Create(AView: TppTBView; AItem: TppTBCustomItem; AGroupLevel: Integer); override;
  end;

  { TppTBXCustomColorSet }
  TppTBXCustomColorSet = class;
  TCSGetColorInfo = procedure(Sender: TppTBXCustomColorSet; Col, Row: Integer;
    var Color: TColor; var Name: string) of object;

  TppTBXCustomColorSet = class(TComponent)
  private
    FPalettes: TList;
    FColCount: Integer;
    FRowCount: Integer;
    FOnGetColorInfo: TCSGetColorInfo;
    procedure SetColCount(Value: Integer);
    procedure SetRowCount(Value: Integer);
  protected
    procedure UpdateSize(NewColCount, NewRowCount: Integer); virtual;
    function  ColorToString(Color: TColor): string; virtual;
    procedure GetColorInfo(Col, Row: Integer; out Color: TColor; out ColorName: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetColor(Col, Row: Integer): TColor;
    function GetName(Col, Row: Integer): string;
    property ColCount: Integer read FColCount write SetColCount;
    property RowCount: Integer read FRowCount write SetRowCount;
    property OnGetColorInfo: TCSGetColorInfo read FOnGetColorInfo write FOnGetColorInfo;
  end;

  TppTBXColorSet = class(TppTBXCustomColorSet)
  published
    property ColCount;
    property RowCount;
    property OnGetColorInfo;
  end;

  TppTBXColorPalette = class(TppTBXCustomToolPalette)
  private
    FColor: TColor;
    FColorSet: TppTBXCustomColorSet;
    procedure SetColorSet(Value: TppTBXCustomColorSet);
    procedure SetColor(Value: TColor);
  protected
    procedure DoCalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer); override;
    procedure DoChange; override;
    procedure DoGetCellVisible(ACol, ARow: Integer; var Visible: Boolean); override;
    procedure DoGetHint(ACell: TPoint; var HintText: string); override;
    procedure DoDrawCellImage(Canvas: TCanvas; const ARect: TRect; ACol, ARow: Integer; ItemInfo: TppTBXItemInfo); override;
    function  GetColorSet: TppTBXCustomColorSet;
    function  GetCellColor(ACol, ARow: Integer): TColor; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function  FindCell(AColor: TColor): TPoint;
    function  ColorToString(AColor: TColor): string;
  published
    property Color: TColor read FColor write SetColor default clNone;
    property ColorSet: TppTBXCustomColorSet read FColorSet write SetColorSet;
    property HelpContext;
    property InheritOptions;
    property MaskOptions;
    property Options default [tboShowHint];
    property PaletteOptions;
    property Stretch;
    property Visible;
    property OnChange;
    property OnCellClick;
    property OnGetCellHint;
  end;

implementation

uses
  ImgList,
  ppTBXUxThemes;

var
  DefaultColorSet: TppTBXCustomColorSet;

type
  TppTBViewAccess = class(TppTBView);

{ TppTBXCustomToolPalette }

constructor TppTBXCustomToolPalette.Create(AOwner: TComponent);
begin
  inherited;
  FColCount := 1;
  FRowCount := 1;
  FSelectedCell.X := -1;
//  Options := Options + [tboToolbarStyle];
end;

procedure TppTBXCustomToolPalette.DoCalcCellSize(Canvas: TCanvas; var AWidth, AHeight: Integer);
begin
end;

procedure TppTBXCustomToolPalette.DoCalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer);
begin
  if Assigned(FOnCalcImageSize) then FOnCalcImageSize(Self, Canvas, AWidth, AHeight);
end;

function TppTBXCustomToolPalette.DoCellClick(var ACol, ARow: Integer): Boolean;
begin
  Result := True;
  if Assigned(FOnCellClick) then FOnCellClick(Self, ACol, ARow, Result);
end;

procedure TppTBXCustomToolPalette.DoChange;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TppTBXCustomToolPalette.DoDrawCellImage(Canvas: TCanvas;
  const ARect: TRect; ACol, ARow: Integer; ItemInfo: TppTBXItemInfo);
begin
  if Assigned(FOnDrawCellImage) then
  begin
    FOnDrawCellImage(Self, Canvas, ARect, ACol, ARow, ItemInfo.Selected,
      ItemInfo.HoverKind <> hkNone, ItemInfo.Enabled);
  end;
end;

procedure TppTBXCustomToolPalette.DoGetCellVisible(ACol, ARow: Integer; var Visible: Boolean);
begin
  if Assigned(FOnGetCellVisible) then FOnGetCellVisible(Self, ACol, ARow, Visible);
end;

procedure TppTBXCustomToolPalette.DoGetHint(ACell: TPoint; var HintText: string);
begin
  if Assigned(FOnGetCellHint) then FOnGetCellHint(Self, ACell.X, ACell.Y, HintText);
end;

function TppTBXCustomToolPalette.GetItemViewerClass(AView: TppTBView): TppTBItemViewerClass;
begin
  Result := TppTBXToolViewer;
end;

procedure TppTBXCustomToolPalette.HandleClickCell(ACol, ARow: Integer);
begin
  if DoCellClick(ACol, ARow) and not (tpoNoAutoSelect in PaletteOptions) then
    SelectedCell := Point(ACol, ARow);
end;

procedure TppTBXCustomToolPalette.SetColCount(Value: TRowColCount);
begin
  if FColCount <> Value then
  begin
    FColCount := Value;
    Change(True);
  end;
end;

procedure TppTBXCustomToolPalette.SetPaletteOptions(Value: TppTBXToolPaletteOptions);
begin
  if FPaletteOptions <> Value then
  begin
    FPaletteOptions := Value;
    Change(True);
  end;
end;

procedure TppTBXCustomToolPalette.SetRowCount(Value: TRowColCount);
begin
  if FRowCount <> Value then
  begin
    FRowCount := Value;
    Change(True);
  end;
end;

procedure TppTBXCustomToolPalette.SetSelectedCell(Value: TPoint);
begin
  FSelectedCell := Value;
  Change(True);
  DoChange;
end;

{ TppTBXToolViewer }

procedure TppTBXToolViewer.CalcCellSize(Canvas: TCanvas; var AWidth, AHeight: Integer);
begin
  CalcImageSize(Canvas, AWidth, AHeight);
  TppTBXCustomToolPalette(Item).DoCalcCellSize(Canvas, AWidth, AHeight);
  Inc(AWidth, 6);
  Inc(AHeight, 6);
end;

procedure TppTBXToolViewer.CalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer);
var
  ImgList: TCustomImageList;
begin
  ImgList := GetImageList;
  if ImgList <> nil then
  begin
    AWidth := ImgList.Width;
    AHeight := ImgList.Height;
  end
  else
  begin
    AWidth := 16;
    AHeight := 16;
  end;
  TppTBXCustomToolPalette(Item).DoCalcImageSize(Canvas, AWidth, AHeight);
end;

procedure TppTBXToolViewer.CalcSize(const Canvas: TCanvas; var AWidth, AHeight: Integer);
var
  CellWidth, CellHeight: Integer;
begin
  if not IsToolbarStyle then with CurrentTheme do
    Indent := GetPopupMargin(Self) + MenuImageTextSpace + MenuLeftCaptionMargin - 3
  else
    Indent := 0;
  FColCount := TppTBXCustomToolPalette(Item).ColCount;
  FRowCount := TppTBXCustomToolPalette(Item).RowCount;
  CalcCellSize(Canvas, CellWidth, CellHeight);
  AWidth := Indent + CellWidth * ColCount;
  if not IsToolbarStyle then Inc(AWidth, CurrentTheme.MenuRightCaptionMargin);
  AHeight := CellHeight * RowCount;
  if AWidth < 8 then AWidth := 8;
  if AHeight < 8 then AHeight := 8;
end;

procedure TppTBXToolViewer.CMHintShow(var Message: TCMHintShow);
var
  Col, Row: Integer;
begin
  with Message.HintInfo^ do
  begin
    if GetCellAt(CursorPos.X - BoundsRect.Left, CursorPos.Y - BoundsRect.Top, Col, Row) then
    begin
      CursorRect := GetCellRect(CursorRect, Col, Row);
      HintStr := GetHint(Col, Row);
    end
    else HintStr := '';
  end;
end;

constructor TppTBXToolViewer.Create(AView: TppTBView; AItem: TppTBCustomItem; AGroupLevel: Integer);
begin
  inherited;
  FColCount := TppTBXCustomToolPalette(AItem).ColCount;
  FRowCount := TppTBXCustomToolPalette(AItem).RowCount;
end;

procedure TppTBXToolViewer.DrawCell(Canvas: TCanvas; const CellRect: TRect;
  Col, Row: Integer; var ItemInfo: TppTBXItemInfo);
var
  ImageWidth, ImageHeight: Integer;
  R: TRect;
begin
  CurrentTheme.PaintButton(Canvas, CellRect, ItemInfo);
  CalcImageSize(Canvas, ImageWidth, ImageHeight);
  R := Bounds((CellRect.Right + CellRect.Left - ImageWidth) div 2,
    (CellRect.Top + CellRect.Bottom - ImageHeight) div 2, ImageWidth, ImageHeight);
  DrawCellImage(Canvas, R, Col, Row,  ItemInfo);
end;

procedure TppTBXToolViewer.DrawCellImage(Canvas: TCanvas; const ARect: TRect;
  Col, Row: Integer; ItemInfo: TppTBXItemInfo);
var
  ImgIndex: Integer;
  ImgList: TCustomImageList;
begin
  if not (tpoCustomImages in  TppTBXCustomToolPalette(Item).PaletteOptions) then
  begin
    ImgIndex := GetImageIndex(Col, Row);
    ImgList := GetImageList;
    if (ImgList <> nil) and (ImgIndex >= 0) and (ImgIndex < ImgList.Count) then
      CurrentTheme.PaintImage(Canvas, ARect, ItemInfo, ImgList, ImgIndex);
  end;
  TppTBXCustomToolPalette(Item).DoDrawCellImage(Canvas, ARect, Col, Row, ItemInfo);
end;

procedure TppTBXToolViewer.Entering(OldSelected: TppTBItemViewer);
begin
  FHotCell := Point(-1, 0);
  if (View is TppTBXPopupView) and (OldSelected <> nil) then
  begin
    if OldSelected.Index > Index then
    begin
      FHotCell := Point(ColCount - 1, RowCount - 1);
      while (FHotCell.X > 0) and not IsCellVisible(FHotCell) do Dec(FHotCell.X);
    end
    else if OldSelected.Index < Index then
      FHotCell := Point(0, 0);
  end;
  inherited Entering(OldSelected);
end;

function TppTBXToolViewer.GetCellAt(X, Y: Integer; out Col, Row: Integer): Boolean;
begin
  { Returns true if there is a cell at (X,Y) point }
  if (CellWidth = 0) or (CellHeight = 0) then
  begin
    Col := 0;
    Row := 0;
  end
  else if not TppTBXCustomToolPalette(Item).Stretch then
  begin
    Col := (X - Indent) div CellWidth;
    Row := Y div CellHeight;
  end
  else
  begin
    Col := (X - Indent) * ColCount div (BoundsRect.Right - BoundsRect.Left);
    Row := Y * RowCount div (BoundsRect.Bottom - BoundsRect.Top);
  end;
  Result := IsCellVisible(Point(Col, Row));
end;

function TppTBXToolViewer.GetCellRect(ClientAreaRect: TRect; Col, Row: Integer): TRect;
var
  W, H: Integer;
begin
  with ClientAreaRect do
    if not TppTBXCustomToolPalette(Item).Stretch then
    begin
      Result := Bounds(Left + Indent + Col * CellWidth, Top + Row * CellHeight, CellWidth, CellHeight)
    end
    else
    begin
      W := Right - Left;
      H := Bottom - Top;
      Result.Left := Left + Indent + W * Col div ColCount;
      Result.Top := Top + H * Row div RowCount;
      Result.Right := Left + W * (Col + 1) div ColCount;
      Result.Bottom := Top + H * (Row + 1) div RowCount;
    end;
end;

function TppTBXToolViewer.GetHint(Col, Row: Integer): string;
begin
  Result := '';
  TppTBXCustomToolPalette(Item).DoGetHint(Point(Col, Row), Result);
end;

function TppTBXToolViewer.GetImageIndex(Col, Row: Integer): Integer;
begin
  Result := Col + Row * ColCount;
end;

procedure TppTBXToolViewer.InvalidateCell(ACol, ARow: Integer);
var
  R: TRect;
begin
  R := GetCellRect(BoundsRect, ACol, ARow);
  InvalidateRect(View.Window.Handle, @R, False);
end;

function TppTBXToolViewer.IsCellVisible(Cell: TPoint): Boolean;
var
  ImgList: TCustomImageList;
begin
  Result := (Cell.X >= 0) and (Cell.Y >= 0) and (Cell.X < ColCount) and (Cell.Y < RowCount);
  if Result then
  begin
    if not (tpoCustomImages in TppTBXCustomToolPalette(Item).PaletteOptions) then
    begin
      ImgList := GetImageList;
      if ImgList <> nil then Result := (Cell.X + Cell.Y * ColCount) < ImgList.Count;
    end;
    TppTBXCustomToolPalette(Item).DoGetCellVisible(Cell.X, Cell.Y, Result);
  end;
end;

procedure TppTBXToolViewer.KeyDown(var Key: Word; Shift: TShiftState);
var
  OldPos, Pos: TPoint;
begin
  if IsCellVisible(HotCell) then OldPos := HotCell
  else if IsCellVisible(TppTBXCustomToolPalette(Item).SelectedCell) then
    OldPos := TppTBXCustomToolPalette(Item).SelectedCell
  else OldPos.X := -1;

  if OldPos.X >= 0 then
  begin
    Pos := OldPos;
    case Key of
      VK_LEFT:
        begin
          Dec(Pos.X);
          if Pos.X < 0 then
          begin
            Pos.X := ColCount - 1;
            Dec(Pos.Y);
          end;
        end;
      VK_UP: Dec(Pos.Y);
      VK_RIGHT:
        begin
          Inc(Pos.X);
          if Pos.X >= ColCount then
          begin
            Pos.X := 0;
            Inc(Pos.Y);
          end;
        end;
      VK_DOWN: Inc(Pos.Y);
      VK_PRIOR: Pos.Y := 0;
      VK_NEXT: Pos.Y := RowCount - 1;
      VK_HOME: Pos.X := 0;
      VK_END: Pos.Y := ColCount - 1;
      VK_RETURN:
        if IsCellVisible(HotCell) then
        begin
          TppTBXCustomToolPalette(Item).HandleClickCell(HotCell.X, HotCell.Y);
          Exit;
        end;
    else
      inherited;
      Exit;
    end;
  end
  else
  begin
    OldPos := Point(-1, 0);
    Pos := Point(0, 0);
  end;

  if ((OldPos.X <> Pos.X) or (OldPos.Y <> Pos.Y)) and IsCellVisible(Pos) then
  begin
    Key := 0;
    FHotCell := Pos;
    TppTBXCustomToolPalette(Item).Change(False);
  end;
end;

procedure TppTBXToolViewer.MouseDown(Shift: TShiftState; X, Y: Integer; var MouseDownOnMenu: Boolean);
begin
  MouseIsDown := True;
  MouseMove(X, Y);
  inherited;
  View.SetCapture;
end;

procedure TppTBXToolViewer.MouseMove(X, Y: Integer);
var
  OldHotCell: TPoint;
begin
  OldHotCell := HotCell;
  if not GetCellAt(X, Y, FHotCell.X, FHotCell.Y) then FHotCell := Point(-1, 0);
  if (HotCell.X <> OldHotCell.X) or (HotCell.Y <> OldHotCell.Y) then
  begin
    with TppTBXCustomToolPalette(Item) do
    begin
      if Show and not IsRectEmpty(BoundsRect) and
         not (Item is TppTBControlItem) then
      begin
        Include(State, tbisInvalidated);
        InvalidateCell(OldHotCell.X, OldHotCell.Y);
        InvalidateCell(HotCell.X, HotCell.Y);
      end;
    end;
  end;
end;

procedure TppTBXToolViewer.MouseUp(X, Y: Integer; MouseWasDownOnMenu: Boolean);
var
  Col, Row: Integer;
  DAD: TppTBDoneActionData;
begin
  MouseIsDown := False;
  if GetCellAt(X, Y, Col, Row) then
    TppTBXCustomToolPalette(Item).HandleClickCell(Col, Row);
  DAD := TppTBViewAccess(TppTBViewAccess(View).GetRootView).DoneActionData;
  DAD.ClickItem := Item;
  DAD.DoneAction := tbdaClickItem;
  DAD.Sound := True;
  TppTBViewAccess(TppTBViewAccess(View).GetRootView).DoneActionData := DAD;
  inherited;
end;

procedure TppTBXToolViewer.Paint(const Canvas: TCanvas; const ClientAreaRect: TRect;
  IsHoverItem, IsPushed, UseDisabledShadow: Boolean);
const
  CDesigning: array [Boolean] of Integer = (0, IO_DESIGNING);
var
  I, J: Integer;
  ItemInfo: TppTBXItemInfo;
  Hover: TppTBXHoverKind;
  R, CellRect: TRect;
begin
  FillChar(ItemInfo, SizeOf(TppTBXItemInfo), 0);
  ItemInfo.ViewType := GetViewType(View);
  ItemInfo.ItemOptions := CDesigning[csDesigning in Item.ComponentState];
  ItemInfo.Enabled := Item.Enabled or View.Customizing;
  ItemInfo.Pushed := False;
  ItemInfo.Selected := False;
  ItemInfo.ImageShown := True;
  with ItemInfo do CalcImageSize(Canvas, ImageWidth, ImageHeight);
  ItemInfo.HoverKind := hkNone;
  if not IsToolbarStyle then ItemInfo.PopupMargin := GetPopupMargin(Self);

  if not IsToolbarStyle then with CurrentTheme do
  begin
    R := ClientAreaRect;
    CurrentTheme.PaintMenuItemFrame(Canvas, R, ItemInfo);
  end;

  CalcCellSize(Canvas, FCellWidth, FCellHeight);
  if IsHoverItem then
  begin
    if not ItemInfo.Enabled and not View.MouseOverSelected then Hover := hkKeyboardHover
    else if ItemInfo.Enabled then Hover := hkMouseHover
    else Hover := hkNone;
  end
  else
    Hover := hkNone;

  for J := 0 to RowCount - 1 do
    for I := 0 to ColCount - 1 do
    begin
      if IsCellVisible(Point(I, J)) then
      begin
        if (Hover <> hkNone) and (HotCell.X = I) and (HotCell.Y = J) then
        begin
          ItemInfo.HoverKind := Hover;
          if IsPushed then ItemInfo.Pushed := True
        end
        else
        begin
          ItemInfo.HoverKind := hkNone;
          ItemInfo.Pushed := False;
        end;
        with TppTBXCustomToolPalette(Item) do
          if (SelectedCell.X = I) and (SelectedCell.Y = J) then
            ItemInfo.Selected := True
          else
            ItemInfo.Selected := False;
        CellRect := GetCellRect(ClientAreaRect, I, J);
        DrawCell(Canvas, CellRect, I, J, ItemInfo);
      end;
    end;
end;

//----------------------------------------------------------------------------//

{ TppTBXCustomColorSet }

constructor TppTBXCustomColorSet.Create(AOwner: TComponent);
begin
  inherited;
  FPalettes := TList.Create;
end;

destructor TppTBXCustomColorSet.Destroy;
begin
  FPalettes.Free;
  inherited;
end;

function TppTBXCustomColorSet.GetColor(Col, Row: Integer): TColor;
var
  Dummy: string;
begin
  GetColorInfo(Col, Row, Result, Dummy);
end;

procedure TppTBXCustomColorSet.GetColorInfo(Col, Row: Integer; out Color: TColor; out ColorName: string);
begin
  Color := clNone;
  SetLength(ColorName, 0);
  if Assigned(FOnGetColorInfo) then FOnGetColorInfo(Self, Col, Row, Color, ColorName);
end;

function TppTBXCustomColorSet.ColorToString(Color: TColor): string;
var
  I, J: Integer;
  C: TColor;
  N: string;

  function GetRGB(C: TColor): TColor;
  begin
    Result := (C and $FF00) + C shr 16 + (C and $FF shl 16);
  end;

begin
  if Color = clNone then Result := 'None'
  else
  begin
    if Color < 0 then Color := GetSysColor(Color and $000000FF);
    Color := Color and $00FFFFFF;

    for J := 0 to RowCount - 1 do
      for I := 0 to ColCount - 1 do
      begin
        GetColorInfo(I, J, C, N);
        if C <> clNone then
        begin
          if C < 0 then C := GetSysColor(C and $000000FF);
          C := C and $00FFFFFF;
          if C = Color then
          begin
            Result := N;
            if Length(N) = 0 then Result := '#' + IntToHex(GetRGB(Color), 6);
            Exit;
          end
        end;
      end;

    Result := '#' + IntToHex(GetRGB(Color), 6);
  end;
end;

function TppTBXCustomColorSet.GetName(Col, Row: Integer): string;
var
  Dummy: TColor;
begin
  GetColorInfo(Col, Row, Dummy, Result);
end;

procedure TppTBXCustomColorSet.SetColCount(Value: Integer);
begin
  UpdateSize(Value, RowCount);
end;

procedure TppTBXCustomColorSet.SetRowCount(Value: Integer);
begin
  UpdateSize(ColCount, Value);
end;

procedure TppTBXCustomColorSet.UpdateSize(NewColCount, NewRowCount: Integer);
var
  I: Integer;
begin
  FColCount := NewColCount;
  FRowCount := NewRowCount;
  for I := 0 to FPalettes.Count - 1 do
    with TppTBXColorPalette(FPalettes[I]) do
    begin
      ColCount := Self.ColCount;
      RowCount := Self.RowCount;
    end;
end;

//----------------------------------------------------------------------------//

{ TppTBXColorPalette }

function TppTBXColorPalette.ColorToString(AColor: TColor): string;
begin
  Result := GetColorSet.ColorToString(AColor);
end;

constructor TppTBXColorPalette.Create(AOwner: TComponent);
begin
  inherited;
  ColCount := DefaultColorSet.ColCount;
  RowCount := DefaultColorSet.RowCount;
  Options := Options + [tboShowHint];
  FColor := clNone;
  PaletteOptions := PaletteOptions + [tpoCustomImages];
end;

procedure TppTBXColorPalette.DoCalcImageSize(Canvas: TCanvas; var AWidth, AHeight: Integer);
begin
  AWidth := 12;
  AHeight := 12;
end;

procedure TppTBXColorPalette.DoChange;
begin
  if SelectedCell.X >= 0 then
    FColor := GetCellColor(SelectedCell.X, SelectedCell.Y);
  inherited;
end;

procedure TppTBXColorPalette.DoDrawCellImage(Canvas: TCanvas;
  const ARect: TRect; ACol, ARow: Integer; ItemInfo: TppTBXItemInfo);
var
  R: TRect;
begin
  R := ARect;
  Canvas.Brush.Color := clBtnShadow;
  Canvas.FrameRect(R);
  InflateRect(R, -1, -1);
  if ItemInfo.Enabled then
  begin
    Canvas.Brush.Color := GetCellColor(ACol, ARow);
    Canvas.FillRect(R);
  end;
end;

procedure TppTBXColorPalette.DoGetCellVisible(ACol, ARow: Integer; var Visible: Boolean);
begin
  Visible := GetCellColor(ACol, ARow) <> clNone;
end;

procedure TppTBXColorPalette.DoGetHint(ACell: TPoint; var HintText: string);
begin
  HintText := GetColorSet.GetName(ACell.X, ACell.Y);
end;

function TppTBXColorPalette.FindCell(AColor: TColor): TPoint;
var
  I, J: Integer;
  C: TColor;
begin
  if AColor <> clNone then AColor := ColorToRGB(AColor);
  for J := 0 to RowCount - 1 do
    for I := 0 to ColCount - 1 do
    begin
      C := GetCellColor(I, J);
      if C <> clNone then C := ColorToRGB(C);
      if C = AColor then
      begin
        Result.X := I;
        Result.Y := J;
        Exit;
      end;
    end;
  Result.X := -1;
  Result.Y := 0;
end;

function TppTBXColorPalette.GetCellColor(ACol, ARow: Integer): TColor;
begin
  Result := GetColorSet.GetColor(ACol, ARow);
end;

function TppTBXColorPalette.GetColorSet: TppTBXCustomColorSet;
begin
  if FColorSet = nil then Result := DefaultColorSet
  else Result := FColorSet;
end;

procedure TppTBXColorPalette.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FColorSet) and (Operation = opRemove) then ColorSet := nil;
end;

procedure TppTBXColorPalette.SetColor(Value: TColor);
begin
  FColor := Value;
  SelectedCell := FindCell(Value);
end;

procedure TppTBXColorPalette.SetColorSet(Value: TppTBXCustomColorSet);
begin
  if FColorSet <> Value then
  begin
    if Assigned(FColorSet) then FColorSet.FPalettes.Remove(Self);
    FColorSet := Value;
    if Assigned(Value) then
    begin
      Value.FreeNotification(Self);
      Value.FPalettes.Add(Self);
      ColCount := Value.ColCount;
      RowCount := Value.RowCount;
    end
    else
    begin
      ColCount := DefaultColorSet.ColCount;
      RowCount := DefaultColorSet.RowCount;
    end;
    Change(True);
  end;
end;

{ TppTBXDefaultColorSet }

type
  TppTBXDefaultColorSet = class (TppTBXCustomColorSet)
  protected
    procedure GetColorInfo(Col, Row: Integer; out Color: TColor; out ColorName: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure TppTBXDefaultColorSet.GetColorInfo(Col, Row: Integer; out Color: TColor; out ColorName: string);

  procedure Clr(const AName: string; AColor: TColor);
  begin
    Color := AColor;
    ColorName := AName;
  end;

begin
  Color := clNone;
  Name := '';
  case Row of
    0:
      case Col of
        0: Clr('Black', $000000);
        1: Clr('Brown', $003399);
        2: Clr('Olive Green', $003333);
        3: Clr('Dark Green', $003300);
        4: Clr('Dark Teal', $663300);
        5: Clr('Dark blue', $800000);
        6: Clr('Indigo', $993333);
        7: Clr('Gray-80%', $333333);
      end;

    1:
      case Col of
        0: Clr('Dark Red', $000080);
        1: Clr('Orange', $0066FF);
        2: Clr('Dark Yellow', $008080);
        3: Clr('Green', $008000);
        4: Clr('Teal', $808000);
        5: Clr('Blue', $FF0000);
        6: Clr('Blue-Gray', $996666);
        7: Clr('Gray-50%', $808080);
      end;

    2:
      case Col of
        0: Clr('Red', $0000FF);
        1: Clr('Light Orange', $0099FF);
        2: Clr('Lime', $00CC99);
        3: Clr('Sea Green', $669933);
        4: Clr('Aqua', $CCCC33);
        5: Clr('Light Blue', $FF6633);
        6: Clr('Violet', $800080);
        7: Clr('Gray-40%', $969696);
      end;

    3:
      case Col of
        0: Clr('Pink', $FF00FF);
        1: Clr('Gold', $00CCFF);
        2: Clr('Yellow', $00FFFF);
        3: Clr('Bright Green', $00FF00);
        4: Clr('Turquoise', $FFFF00);
        5: Clr('Sky Blue', $FFCC00);
        6: Clr('Plum', $663399);
        7: Clr('Gray-25%', $C0C0C0);
      end;

    4:
      case Col of
        0: Clr('Rose', $CC99FF);
        1: Clr('Tan', $99CCFF);
        2: Clr('Light Yellow', $99FFFF);
        3: Clr('Light Green', $CCFFCC);
        4: Clr('Light Turquoise', $FFFFCC);
        5: Clr('Pale Blue', $FFCC99);
        6: Clr('Lavender', $FF99CC);
        7: Clr('White', $FFFFFF);
      end;
  end;
end;

constructor TppTBXDefaultColorSet.Create(AOwner: TComponent);
begin
  inherited;
  FColCount := 8;
  FRowCount := 5;
end;

initialization
  DefaultColorSet := TppTBXDefaultColorSet.Create(nil);

finalization
  DefaultColorSet.Free;

end.
