{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit ppRuler;

interface

{$I ppIfDef.pas}

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Graphics,
  Contnrs,
  Forms,
  Menus,

  ppCollectionBase,
  ppClass,
  ppTypes,
  ppUtils,
  ppPrintr;

type

  TppRulerOrientationType = (roHorizontal, roVertical);

  {@TppRuler }
  TppRuler = class(TGraphicControl)
  private
    FBorderStyle: TBorderStyle;
    FCtl3D: Boolean;
    FDualGuides: Boolean;
    FDrawRect: TRect;
    FGuide1X: Integer;
    FGuide1Y: Integer;
    FGuide2X: Integer;
    FGuide2Y: Integer;
    FGuideHeight: Integer;
    FGuideWidth: Integer;
    FHalfTicks: Boolean;
    FMargin: Integer;
    FPopupMenu: TPopupMenu;
    FOnGetPrinter: TppGetPrinterEvent;
    FOnPaint: TNotifyEvent;
    FOrientation: TppRulerOrientationType;
    FPixelIncrement: Double;
    FScrollOffset: Integer;
    FThickness: Integer;
    FTicksPerUnit: Integer;
    FTickFactor: Single;
    FUnits: TppUnitType;

    function  UpdateGuidePosition(aNewPosition: Integer; var aGuideX, aGuideY: Integer): Boolean;
    procedure DrawGuide(aGuideX, aGuideY: Integer);
    procedure InitGuides;
    procedure PaintRuler;
    procedure SetBorderStyle(aBorderStyle: TBorderStyle);
    procedure SetCtl3D(Value: Boolean);
    procedure SetDualGuides(Value: Boolean);
    procedure SetOrientation(aOrientation: TppRulerOrientationType);
    procedure SetUnits(aUnit: TppUnitType);

  protected
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure ChangeUnits(aUnit: TppUnitType);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure ClearGuides;
    procedure ResetScroll;
    procedure Scroll(Value: Integer);
    procedure SetGuides(aPosition1, aPosition2: Integer);

    property Canvas;

  published
    property Align;
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle;
    property Color;
    property Ctl3D : Boolean read FCtl3D write SetCtl3D;
    property DualGuides : Boolean read FDualGuides write SetDualGuides;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnGetPrinter: TppGetPrinterEvent read FOnGetPrinter write FOnGetPrinter;
    property OnMouseDown;
    {property OnMouseMove;}
    property OnMouseUp;
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
    property Orientation : TppRulerOrientationType read FOrientation write SetOrientation;
    property Units : TppUnitType read FUnits write SetUnits;
  end; {class, TppRuler}


  {TppRulerCollection}
  TppRulerCollection = class(TppComponentCollectionBase)
  private

    function GetItemForIndex(Index: Integer): TppRuler;

  public
    procedure Add(aRuler: TppRuler);
    procedure ClearGuides;
    procedure SetDualGuides(aValue: Boolean);
    procedure SetUnits(aUnits: TppUnitType);

    property Items[Index: Integer]: TppRuler read GetItemForIndex; default;

  end;


  function PixelsPerCentimeter: Double;

implementation

function PixelsPerCentimeter: Double;
begin
  Result := Screen.PixelsPerInch / 2.54;
end;

{******************************************************************************
 *
 ** R U L E R
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRuler.Create }

constructor TppRuler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Color := clBtnFace; {set default color for background}
  Font.Color := clBtnText; {set default color for ticks and tick labels}

  FBorderStyle := bsSingle;
  FCtl3D := True;
  FDualGuides := False;
  FGuide1X := -1;
  FGuide1Y := -1;
  FGuide2X := -1;
  FGuide2Y := -1;
  FGuideHeight := 0;
  FGuideWidth := 0;
  FHalfTicks := True;
  FMargin := 0;
  FPixelIncrement := Round(Screen.PixelsPerInch / 8);
  FOnGetPrinter := nil;
  FOrientation := roHorizontal;
  FScrollOffset := 0;
  FThickness := 1;
  FTicksPerUnit := 8;
  FTickFactor := 0.125;
  FUnits := utInches;

end; {procedure, Create}

{------------------------------------------------------------------------------}
{ TppRuler.Destroy }

destructor TppRuler.Destroy;
begin

  FPopupMenu.Free;

  PopupMenu := nil;

 inherited Destroy;

end; {procedure, Destroy}

{------------------------------------------------------------------------------}
{ TppRuler.Paint }

procedure TppRuler.Paint;
begin

  if Visible and Enabled then
    begin
      PaintRuler;

      if Assigned(FOnPaint) then FOnPaint(Self);
    end;

end; {procedure, Paint}

{------------------------------------------------------------------------------}
{ TppRuler.CMMouseLeave }

procedure TppRuler.CMMouseLeave(var Message: TMessage);
begin

  ClearGuides();

end;

{------------------------------------------------------------------------------}
{ TppRuler.MouseMove }

procedure TppRuler.MouseMove(Shift: TShiftState; X, Y: Integer);
begin

  if not(FDualGuides) then
    if FOrientation = roHorizontal then
      SetGuides(X, 0)
    else
      SetGuides(Y, 0);

  inherited MouseMove(Shift, X, Y);

end; {procedure, MouseMove}


{------------------------------------------------------------------------------}
{ TppRuler.SetDualGuides  }

procedure TppRuler.SetDualGuides(Value: Boolean);
begin

  if FDualGuides = Value then Exit;

  FDualGuides := Value;

  Invalidate;

end; {procedure, SetDualGuides}

{------------------------------------------------------------------------------}
{ TppRuler.SetBorderStyle }

procedure TppRuler.SetBorderStyle(aBorderStyle: TBorderStyle);
begin

  if FBorderStyle = aBorderStyle then Exit;

  FBorderStyle := aBorderStyle;

  Invalidate;

end; {procedure, SetBorderStyle}

{------------------------------------------------------------------------------}
{ TppRuler.SetCtl3D  }

procedure TppRuler.SetCtl3D(Value: Boolean);
begin

  if (FCtl3D = Value) then Exit;

  FCtl3D := Value;

  Invalidate;

end; {procedure, SetBorderStyle}

{------------------------------------------------------------------------------}
{ TppRuler.SetUnits  }

procedure TppRuler.SetUnits(aUnit: TppUnitType);
begin

  {change units}
  if FUnits <> aUnit then
    ChangeUnits(aUnit);

end; {procedure, SetUnits}

{------------------------------------------------------------------------------}
{ TppRuler.SetOrientation }

procedure TppRuler.SetOrientation(aOrientation: TppRulerOrientationType);
begin

  if FOrientation = aOrientation then Exit;

  FOrientation := aOrientation;

  Invalidate;

end; {procedure, SetOrientation}

{------------------------------------------------------------------------------}
{ TppRuler.ResetScroll }

procedure TppRuler.ResetScroll;
begin
  FScrollOffset := 0;

  Invalidate;
end; {procedure, ResetScroll}

{------------------------------------------------------------------------------}
{ TppRuler.Scroll }

procedure TppRuler.Scroll(Value: Integer);
var
  liOldOffset : Integer;
begin

  {save current offset}
  liOldOffset := FScrollOffset;

  {calculate new offset}
  FScrollOffset := Value;

  {don't allow scrolling beyond start of ruler}
  if (FScrollOffset < 0) then
    FScrollOffset := 0;

  {if scroll offset changed, repaint ruler}
  if (FScrollOffset <> liOldOffset) then
    Invalidate;

end; {procedure, Scroll}

{------------------------------------------------------------------------------}
{ TppRuler.PaintRuler }

procedure TppRuler.PaintRuler;
var
  liTickLength: Integer;
  liFullTickLength: Integer;
  liTick: Integer;
  liPosition: Integer;
  liMaxLength: Integer;
  liTextHeight: Integer;
  liTextWidth: Integer;
  liDrawPosition: Integer;
  ldPosition: Double;

  { DrawTick }
  procedure DrawTick;
  begin
    {draw tick}
    if FOrientation = roHorizontal then
      begin
        Canvas.MoveTo(liDrawPosition, FMargin);
        Canvas.LineTo(liDrawPosition, FMargin + liTickLength);
      end
    else
      begin
        Canvas.MoveTo(FMargin, liDrawPosition);
        Canvas.LineTo(FMargin + liTickLength, liDrawPosition);
      end;
  end; {procedure, DrawTick}

  { DrawLabel }
  procedure DrawLabel;
  var
    liSpacing: Integer;
    liChar: Integer;
    liLeft: Integer;
    liTop: Integer;
    lRect: TRect;
    lsText: String;
  begin

    {calculate text label value}
    if ((liTick * FTickFactor) >= 10000) then
      lsText := IntToStr( Round((liTick * FTickFactor) / 1000) ) + 'k'
    else
      lsText := IntToStr(Round(liTick * FTickFactor));

    {draw label next to full tick}
    if (FOrientation = roHorizontal) then
      begin
        liTop := FMargin + (FDrawRect.Bottom - FDrawRect.Top) - liTextHeight;
        Canvas.TextOut(liDrawPosition + 2, liTop, lsText);
      end

    else {draw label vertically}
      begin
        liSpacing := liDrawPosition + 2;

        for liChar := 1 to Length(lsText) do
          begin
            liLeft := FMargin + (FDrawRect.Right - FDrawRect.Left) - liTextWidth - 2;

            lRect.Left := liLeft;
            lRect.Top := liSpacing;
            lRect.Right := liLeft + liTextWidth;
            lRect.Bottom := liSpacing + liTextHeight;

            Canvas.TextRect(lRect, liLeft, liSpacing, lsText[liChar]);

            liSpacing := liSpacing + liTextHeight - 2;
          end;
      end;

  end; {procedure, DrawLabel}


begin
  liPosition := 0;
  liMaxLength := 0;

  InitGuides;

  {set boundaries for drawing ruler}
  FDrawRect.Top    := 0;
  FDrawRect.Left   := 0;
  FDrawRect.Bottom := Self.Height;
  FDrawRect.Right  := Self.Width;

  {fill ruler background with current color}
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(FDrawRect);

  {set starting draw position and max length}
  if FOrientation = roHorizontal then
    begin
      {set boundaries for drawing ruler}
      FDrawRect.Top    := 0;
      FDrawRect.Left   := 0;
      FDrawRect.Bottom := Self.Height;
      FDrawRect.Right  := Self.Width;

      FDrawRect.Top := FMargin;
      FDrawRect.Bottom := Self.Height - FMargin;

      {set looping variables}
      liMaxLength := FDrawRect.Right;
      liPosition  := FDrawRect.Left;
    end
  else if FOrientation = roVertical then
    begin
      {set boundaries for drawing ruler}
      FDrawRect.Top    := 0;
      FDrawRect.Left   := 0;
      FDrawRect.Bottom := Self.Height;
      FDrawRect.Right  := Self.Width;

      FDrawRect.Left := FMargin;
      FDrawRect.Right := Self.Width - FMargin;

      {set looping variables}
      liMaxLength := FDrawRect.Bottom;
      liPosition  := FDrawRect.Top;
   end;

  {fill ruler background with current color}
  Canvas.Brush.Color := clWindow;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(FDrawRect);

  {set font}
  Canvas.Font.Name := 'Small Fonts';
  Canvas.Font.Style := [];
  Canvas.Font.Size := 6;
  Canvas.Font.Color := Self.Font.Color;

  {init tick and tick label drawing variables}
  liTextHeight := Canvas.TextHeight('0');
  liTextWidth := Canvas.TextWidth('0');

  if FOrientation = roHorizontal then
    liFullTickLength := FDrawRect.Bottom - FDrawRect.Top
  else
    liFullTickLength := FDrawRect.Right - FDrawRect.Left;

  {draw ruler ticks and tick labels with current font color}
  Canvas.Pen.Color := Font.Color;
  Canvas.Pen.Width := 1;

  liTick := 0;
  ldPosition := 0;

  while liPosition < (liMaxLength + FScrollOffset) do
    begin

      {determine tick length}
      if ((liTick mod FTicksPerUnit) = 0) or (liTick = 0) then
        liTickLength := liFullTickLength

      else if ((liTick mod (FTicksPerUnit div 2)) = 0) and FHalfTicks then
        liTickLength := liFullTickLength div 2

      else
        liTickLength := liFullTickLength div 4;

      {if currently in a valid drawing position, draw the ruler}
      liDrawPosition := liPosition - FScrollOffset;

      {draw label on full ticks only}
      if (liTickLength = liFullTickLength) then
        DrawLabel;

      {draw tick}
      if (liDrawPosition >= 0) and (liTick > 0) then
        DrawTick;

      {goto next tick}
      ldPosition := ldPosition +  FPixelIncrement;

      liPosition := Round(ldPosition);

      Inc(liTick);

    end; {while, drawing area not exhausted}

end; {procedure, PaintRuler}

{------------------------------------------------------------------------------}
{ TppRuler.SetGuides }

procedure TppRuler.SetGuides(aPosition1, aPosition2: Integer);
begin

  {if ruler is not visible or enabled, do nothing}
  if not(Visible and Enabled) then Exit;

  {erase current guide}
  DrawGuide(FGuide1X, FGuide1Y);

  UpdateGuidePosition(aPosition1, FGuide1X, FGuide1Y);

  {draw new guide}
  DrawGuide(FGuide1X, FGuide1Y);


  {if dual guides on, and position changed, draw second guide}
  if FDualGuides then
    begin
      {erase current guide}
      DrawGuide(FGuide2X, FGuide2Y);

      UpdateGuidePosition(aPosition2, FGuide2X, FGuide2Y);

      {draw new guide}
      DrawGuide(FGuide2X, FGuide2Y);
    end;

end; {procedure, SetGuides}

{------------------------------------------------------------------------------}
{ TppRuler.InitGuides }

procedure TppRuler.InitGuides;
begin

  if FOrientation = roHorizontal then
    begin
      FMargin := (Height - Round(0.1354 * Screen.PixelsPerInch)) div 2;

      {initialze guide position variables}
      FGuideWidth := 1;
      FGuideHeight := Round(0.1354 * Screen.PixelsPerInch);
    end
  else
    begin
      FMargin := (Width - Round(0.1354 * Screen.PixelsPerInch)) div 2;

      {initialze guide position variables}
      FGuideWidth := Round(0.1458 * Screen.PixelsPerInch);
      FGuideHeight := 1;
    end;

  FGuide1X := -1;
  FGuide1Y := -1;
  FGuide2X := -1;
  FGuide2Y := -1;

end; {procedure, InitGuides}

{------------------------------------------------------------------------------}
{ TppRuler.UpdateGuidePosition }

function TppRuler.UpdateGuidePosition(aNewPosition: Integer; var aGuideX, aGuideY: Integer): Boolean;
var
  liNewPosition: Integer;
begin

  Result := False;

  {if position unchanged, exit}
  if ((FOrientation = roHorizontal) and (aNewPosition = aGuideX)) or
     ((FOrientation = roVertical)   and (aNewPosition = aGuideY)) then Exit;

  {if position is beyond ruler boundary, set position to beginning of ruler}
  if (FOrientation = roHorizontal) and (aNewPosition < FDrawRect.Left) then
    liNewPosition := FDrawRect.Left

  else if (FOrientation = roVertical) and (aNewPosition > FDrawRect.Bottom) then
    liNewPosition := FDrawRect.Bottom

  else
    liNewPosition := aNewPosition;


  {calculate new guide position}
  if FOrientation = roHorizontal then
    aGuideX := liNewPosition
  else
    aGuideY := liNewPosition;

  Result := True;

end; {procedure, UpdateGuidePosition}

{------------------------------------------------------------------------------}
{ TppRuler.DrawGuide }

procedure TppRuler.DrawGuide(aGuideX, aGuideY: Integer);
begin

  if (FOrientation = roHorizontal) then
    begin
      if (aGuideX = -1) then Exit;

      Canvas.Pen.Mode := pmNot;
      Canvas.MoveTo(aGuideX, FMargin);
      Canvas.LineTo(aGuideX, FGuideHeight + FMargin);
    end
  else
    begin
      if (aGuideY = -1) then Exit;

      Canvas.Pen.Mode := pmNot;
      Canvas.MoveTo(FMargin, aGuideY);
      Canvas.LineTo(FGuideWidth + FMargin, aGuideY);
    end;

end; {procedure, DrawGuide}

{------------------------------------------------------------------------------}
{ TppRuler.ClearGuides  }

procedure TppRuler.ClearGuides;
begin

  {erase current guide}
  DrawGuide(FGuide1X, FGuide1Y);

  FGuide1X := -1;
  FGuide1Y := -1;

  {if dual guides already exist, erase second guide}
  if FDualGuides then
    begin
      DrawGuide(FGuide2X, FGuide2Y);

      FGuide2X := -1;
      FGuide2Y := -1;
    end;

end; {procedure, ClearGuides}

{------------------------------------------------------------------------------}
{ TppRuler.ChangeUnits  }

procedure TppRuler.ChangeUnits(aUnit: TppUnitType);
var
  liUnitLabel: Integer;
  ldScreenPixelsPerUnit: Double;
  lPrinter: TppPrinter;
begin

  {change units only, do not call OnSetUnits event handler }
  if FUnits <> aUnit then
    begin

      FUnits := aUnit;

      {compute tick & tick label drawing variables}
      case FUnits of

        utScreenPixels:
          begin
            liUnitLabel := Screen.PixelsPerInch;

            ldScreenPixelsPerUnit := Screen.PixelsPerInch;

            {determines ticks per unit of measure}
            FTicksPerUnit := Round(Screen.PixelsPerInch / 10);
            {pixels between ticks}
            FPixelIncrement := ldScreenPixelsPerUnit / FTicksPerUnit;{Round(Screen.PixelsPerInch * 0.0520833);}
            {factor used to create full tick labels from tick counter,
             i.e., 50 is first full tick label for the pixel unit ruler}
            FTickFactor := liUnitLabel / FTicksPerUnit;
            {determines whether half-height ticks draw midway through unit of measure}
            FHalfTicks := True;
          end;

      utPrinterPixels:
        begin
          lPrinter := nil;

          if Assigned(FOnGetPrinter) then FOnGetPrinter(Self, lPrinter);

          if (lPrinter = nil) then
            liUnitlabel := Screen.PixelsPerInch

          else if (FOrientation = roHorizontal) then
            liUnitLabel := lPrinter.PixelsPerInch.X

          else
            liUnitLabel := lPrinter.PixelsPerInch.Y;

          ldScreenPixelsPerUnit := Screen.PixelsPerInch;

          FTicksPerUnit := 10;
          FPixelIncrement := ldScreenPixelsPerUnit / FTicksPerUnit;
          FTickFactor := liUnitLabel / FTicksPerUnit;
          FHalfTicks := True;
        end;

      utInches:
        begin
          liUnitLabel := 1;

          ldScreenPixelsPerUnit := Screen.PixelsPerInch;

          FTicksPerUnit := 8;
          FPixelIncrement :=  ldScreenPixelsPerUnit / FTicksPerUnit;
          FTickFactor := liUnitLabel/FTicksPerUnit;
          FHalfTicks := True;
        end;

      utMillimeters:
        begin
          liUnitLabel := 10;
          ldScreenPixelsPerUnit := PixelsPerCentimeter;

          FTicksPerUnit := 4;
          FPixelIncrement := ldScreenPixelsPerUnit / FTicksPerUnit;
          FTickFactor := liUnitLabel / FTicksPerUnit;
          FHalfTicks := False;
        end;

      utMMThousandths:
        begin
          liUnitLabel := 10000;
          ldScreenPixelsPerUnit := PixelsPerCentimeter;

          FTicksPerUnit := 5;
          FPixelIncrement := ldScreenPixelsPerUnit / FTicksPerUnit;
          FTickFactor := liUnitLabel / FTicksPerUnit;
          FHalfTicks := False;
        end;

      end; {case, unit type}

      Invalidate;

    end; {if, units changed}

end; {procedure, ChangeUnits}




{******************************************************************************
 *
 ** R U L E R   C o l l e c t i o n
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppRulerCollection.Add  }

procedure TppRulerCollection.Add(aRuler: TppRuler);
begin
  InnerList.Add(aRuler);
end;

{------------------------------------------------------------------------------}
{ TppRulerCollection.ClearGuides  }

procedure TppRulerCollection.ClearGuides;
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    Items[liIndex].ClearGuides();

end;

{------------------------------------------------------------------------------}
{ TppRulerCollection.GetRulerForIndex  }

function TppRulerCollection.GetItemForIndex(Index: Integer): TppRuler;
begin
  Result := TppRuler(InnerList[Index]);
end;

{------------------------------------------------------------------------------}
{ TppRulerCollection.SetDualGuides  }

procedure TppRulerCollection.SetDualGuides(aValue: Boolean);
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    Items[liIndex].DualGuides := aValue;
    
end;

{------------------------------------------------------------------------------}
{ TppRulerCollection.SetUnits  }

procedure TppRulerCollection.SetUnits(aUnits: TppUnitType);
var
  liIndex: Integer;
begin

  for liIndex := 0 to Count-1 do
    Items[liIndex].Units := aUnits;
    
end;





end.
