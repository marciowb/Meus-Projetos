{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daVisualLink;

interface

{$I ppIfDef.pas}

uses
  Classes, Graphics, Forms, Windows, ExtCtrls,
  ppComm, ppDB, daDataViewToolWin, ppTypes, ppRTTI;

type
  TdaVisualLinkNub = class;

  { TdaVisualLink

    Visual representation of a link which is drawn between two dataviews.  The
    link can be double-clicked in order to access the link dialog. }

  TdaVisualLink = class(TppCommunicator)
    private
      FArea: TRect;
      FCanvas: TCanvas;
      FColor: TColor;
      FDetail: TdaDataViewToolWin;
      FDetailFieldName: String;
      FDetailFieldPosition: TRect;
      FDetailIndex: Integer;
      FDetailNub: TdaVisualLinkNub;
      FDrawColor: TColor;
      FDrawHighlightColor: TColor;
      FHighlightColor: TColor;
      FMaster: TdaDataViewToolWin;
      FMasterFieldName: String;
      FMasterFieldPosition: TRect;
      FMasterNub: TdaVisualLinkNub;
      FOnPaintSelf: TNotifyEvent;
      FPaintBox: TPaintBox;
      FSelected: Boolean;
      FVisible: Boolean;
      FWorkSpace: TScrollBox;

      procedure CalcArea;
      procedure CalcNubPosition(aNub: TdaVisualLinkNub; aRect: TRect; aRightSide: Boolean);
      procedure CalcPosition;
      procedure Draw;
      procedure DrawDetailSymbol;
      procedure DrawHighlight;
      procedure DrawLink;
      procedure DrawMasterSymbol;
      procedure DrawNub(aNub: TdaVisualLinkNub);
      procedure DrawNubHighlight(aNub: TdaVisualLinkNub);
      procedure Erase;
      function NeedToPaint: Boolean;
      procedure PaintSelf;
      function PointInRect(aRect: TRect; aX, aY: Integer; aThreshold: Integer): Boolean;
      function PointOnLine(aStartPoint, aEndPoint: TPoint; aX, aY: Integer; aThreshold: Integer): Boolean;
      procedure SetColor(aColor: TColor);
      procedure SetDetail(aToolWin: TdaDataViewToolWin);
      procedure SetMaster(aToolWin: TdaDataViewToolWin);
      procedure SetSelected(aValue: Boolean);
      procedure SetVisible(aValue: Boolean);

    public
      constructor CreateLink(aPaintBox: TPaintBox; aWorkSpace: TScrollBox);
      destructor Destroy; override;

      procedure EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList); override;

      function IsHotPoint(aX, aY: Integer): Boolean;
      procedure Paint;
      function Overlaps(aVisualLink: TdaVisualLink): Boolean;

      property Color: TColor read FColor write SetColor;
      property Detail: TdaDataViewToolWin read FDetail write SetDetail;
      property DetailFieldName: String read FDetailFieldName write FDetailFieldName;
      property DetailIndex: Integer read FDetailIndex write FDetailIndex;
      property Master: TdaDataViewToolWin read FMaster write SetMaster;
      property MasterFieldName: String read FMasterFieldName write FMasterFieldName;
      property OnPaintSelf: TNotifyEvent read FOnPaintSelf write FOnPaintSelf;
      property Selected: Boolean read FSelected write SetSelected;
      property Visible: Boolean read FVisible write SetVisible;

  end; {class, TdaVisualLink}


  { TdaVisualLinkNub

    The link is draw as a line between individual fields of two different dataviews.
    At the end of each line is a small rectangle - the nub.  The VisualLinkNub class
    is stores the exact position of these nubs and computes the postion of the symbol
    which appears above them. }

  TdaVisualLinkNub = class(TObject)
    private
      FMaster: Boolean;
      FPosition: TRect;
      FTip: TPoint;

      function GetSymbolPosition: TRect;

      function GetLeft: Integer;
      function GetTop: Integer;
      function GetRight: Integer;
      function GetBottom: Integer;

      procedure SetLeft(aValue: Integer);
      procedure SetTop(aValue: Integer);
      procedure SetRight(aValue: Integer);
      procedure SetBottom(aValue: Integer);

    public
      constructor CreateNub(aMaster: Boolean);

      property Left: Integer read GetLeft write SetLeft;
      property Top: Integer read GetTop write SetTop;
      property Right: Integer read GetRight write SetRight;
      property Bottom: Integer read GetBottom write SetBottom;

      property Master: Boolean read FMaster write FMaster;
      property SymbolPosition: TRect read GetSymbolPosition;
      property Position: TRect read FPosition write FPosition;
      property Tip: TPoint read FTip write FTip;

  end; {class, TdaVisualLinkNub}

implementation

uses
  SysUtils;

{******************************************************************************
 *
 ** V I S U A L   L I N K
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CreateLink }

constructor TdaVisualLink.CreateLink(aPaintBox: TPaintBox; aWorkSpace: TScrollBox);
begin

  inherited Create(nil);

  EventNotifies := [ciWindowPosChanged, ciWindowResized, ciListViewScroll, ciListViewSort];

  FArea := Rect(-1,-1,-1,-1);
  FColor := 0;
  FDetail := nil;
  FDetailFieldName := '';
  FDetailFieldPosition := Rect(-1,-1,-1,-1);
  FDetailIndex := -1;
  FDetailNub := TdaVisualLinkNub.CreateNub(False);
  FDrawColor := 0;
  FMaster := nil;
  FMasterFieldName := '';
  FMasterFieldPosition := Rect(-1,-1,-1,-1);
  FMasterNub := TdaVisualLinkNub.CreateNub(True);
  FOnPaintSelf := nil;
  FSelected := False;
  FVisible := True;
  FWorkSpace := aWorkSpace;

  FPaintBox := aPaintBox;
  FCanvas := aPaintBox.Canvas;

end; {constructor, CreateLink}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CreateLink }

destructor TdaVisualLink.Destroy;
begin

  FMasterNub.Free;
  FDetailNub.Free;

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetMaster }

procedure TdaVisualLink.SetMaster(aToolWin: TdaDataViewToolWin);
begin
  FMaster := aToolWin;
  FMaster.AddEventNotify(Self);
end; {procedure, SetMaster}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetDetail }

procedure TdaVisualLink.SetDetail(aToolWin: TdaDataViewToolWin);
begin
  FDetail := aToolWin;
  FDetail.AddEventNotify(Self);
end; {procedure, SetDetail}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetSelected }

procedure TdaVisualLink.SetSelected(aValue: Boolean);
begin

  if (FVisible) then
    Erase;

  FSelected := aValue;

  if (FVisible) then
    Draw;

end; {procedure, SetSelected}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetVisible }

procedure TdaVisualLink.SetVisible(aValue: Boolean);
begin

  if (FVisible) and not(aValue) then
    Erase;

  FVisible := aValue;

  if (FVisible) then
    Draw;

end; {procedure, SetVisible}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetColor }

procedure TdaVisualLink.SetColor(aColor: TColor);
begin

  FColor := aColor;

  case FColor of
    clMaroon: FHighlightColor := clRed;
    clNavy: FHighlightColor := clAqua;
    clGreen: FHighlightColor := clLime;
    clPurple: FHighlightColor := clFuchsia;
  end;

end; {procedure, SetColor}

{------------------------------------------------------------------------------}
{ TdaVisualLink.IsHotPoint }

function TdaVisualLink.IsHotPoint(aX, aY: Integer): Boolean;
var
  lPoint: TPoint;
begin

  lPoint := FPaintBox.ScreenToClient(Point(aX, aY));

  if (PointInRect(FArea, lPoint.X, lPoint.Y, 3)) then
    begin
      Result := PointInRect(FMasterNub.Position, lPoint.X, lPoint.Y, 3) or
                PointInRect(FMasterNub.SymbolPosition, lPoint.X, lPoint.Y, 3) or
                PointInRect(FDetailNub.Position, lPoint.X, lPoint.Y, 3) or
                PointInRect(FDetailNub.SymbolPosition, lPoint.X, lPoint.Y, 3) or
                PointOnLine(FMasterNub.Tip, FDetailNub.Tip, lPoint.X, lPoint.Y, 5);
    end
  else
    Result := False;

end; {procedure, IsHotPoint}

{------------------------------------------------------------------------------}
{ TdaVisualLink.EventNotify }

procedure TdaVisualLink.EventNotify(aCommunicator: TppCommunicator; aEventID: Integer; aParams: TraParamList);
begin

  if (aEventID in [ciWindowPosChanged, ciWindowResized, ciListViewScroll, ciListViewSort]) and (NeedToPaint) then
    PaintSelf;

end; {procedure, EventNotify}

{------------------------------------------------------------------------------}
{ TdaVisualLink.PaintSelf }

procedure TdaVisualLink.PaintSelf;
begin

  Paint;

  if Assigned(FOnPaintSelf) then FOnPaintSelf(Self);

end; {procedure, PaintSelf}

{------------------------------------------------------------------------------}
{ TdaVisualLink.Overlaps }

function TdaVisualLink.Overlaps(aVisualLink: TdaVisualLink): Boolean;
var
  lIntersection: TRect;
begin

  if IntersectRect(lIntersection, FArea, aVisualLink.FArea) then
    Result := True
  else
    Result := False;

end; {function, Overlaps}

{------------------------------------------------------------------------------}
{ TdaVisualLink.Paint }

procedure TdaVisualLink.Paint;
begin

  Erase;

  Draw;

end; {procedure, Paint}

{------------------------------------------------------------------------------}
{ TdaVisualLink.NeedToPaint }

function TdaVisualLink.NeedToPaint: Boolean;
var
  lMasterFieldPosition: TRect;
  lDetailFieldPosition: TRect;
begin

  lMasterFieldPosition := FMasterFieldPosition;
  lDetailFieldPosition := FDetailFieldPosition;

  FMasterFieldPosition := FMaster.GetFieldPosition(FMasterFieldName);
  FDetailFieldPosition := FDetail.GetFieldPosition(FDetailFieldName);

  if (lMasterFieldPosition.Left <> FMasterFieldPosition.Left) or
     (lMasterFieldPosition.Top <> FMasterFieldPosition.Top) or
     (lMasterFieldPosition.Right <> FMasterFieldPosition.Right) or
     (lMasterFieldPosition.Bottom <> FMasterFieldPosition.Bottom) then
    Result := True

  else if (lDetailFieldPosition.Left <> FDetailFieldPosition.Left) or
          (lDetailFieldPosition.Top <> FDetailFieldPosition.Top) or
          (lDetailFieldPosition.Right <> FDetailFieldPosition.Right) or
          (lDetailFieldPosition.Bottom <> FDetailFieldPosition.Bottom) then
    Result := True

  else
    Result := False;

end; {function, NeedToPaint}

{------------------------------------------------------------------------------}
{ TdaVisualLink.Erase }

procedure TdaVisualLink.Erase;
begin

  FDrawColor := FPaintBox.Color;
  FDrawHighlightColor := FPaintBox.Color;

  DrawLink;

  if FSelected then
    DrawHighlight;

end; {procedure, Erase}

{------------------------------------------------------------------------------}
{ TdaVisualLink.Draw }

procedure TdaVisualLink.Draw;
begin

  FDrawColor := FColor;
  FDrawHighlightColor := FHighlightColor;

  CalcPosition;

  DrawLink;

end; {procedure, Draw}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawLink }

procedure TdaVisualLink.DrawLink;
begin

  FCanvas.Brush.Color := FDrawColor;
  FCanvas.Pen.Color := FDrawColor;

  DrawNub(FMasterNub);
  DrawNub(FDetailNub);

  {draw line}
  FCanvas.MoveTo(FMasterNub.Tip.X, FMasterNub.Tip.Y);
  FCanvas.LineTo(FDetailNub.Tip.X, FDetailNub.Tip.Y);

  if FSelected then
    DrawHighlight;

end; {procedure, DrawLink}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawHighlight }

procedure TdaVisualLink.DrawHighlight;
begin

  FCanvas.Brush.Color := FDrawHighlightColor;
  FCanvas.Pen.Color := FDrawHighlightColor;

  FCanvas.MoveTo(FMasterNub.Tip.X, FMasterNub.Tip.Y - 1);
  FCanvas.LineTo(FDetailNub.Tip.X, FDetailNub.Tip.Y - 1);

  FCanvas.MoveTo(FMasterNub.Tip.X, FMasterNub.Tip.Y);
  FCanvas.LineTo(FDetailNub.Tip.X, FDetailNub.Tip.Y);

  FCanvas.MoveTo(FMasterNub.Tip.X, FMasterNub.Tip.Y + 1);
  FCanvas.LineTo(FDetailNub.Tip.X, FDetailNub.Tip.Y + 1);

  DrawNubHighlight(FMasterNub);
  DrawNubHighlight(FDetailNub);

end; {procedure, DrawHighlight}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawNub }

procedure TdaVisualLink.DrawNub(aNub: TdaVisualLinkNub);
begin

{$IFDEF Delphi5}
  FCanvas.Rectangle(aNub.Position);
{$ELSE}
  FCanvas.Rectangle(aNub.Left, aNub.Top, aNub.Right, aNub.Bottom);
{$ENDIF}

  if (aNub = FMasterNub) then
    DrawMasterSymbol
  else
    DrawDetailSymbol;

end; {procedure, DrawNub}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawNubHighlight }

procedure TdaVisualLink.DrawNubHighlight(aNub: TdaVisualLinkNub);
begin

  FCanvas.MoveTo(aNub.Position.Left, aNub.Position.Top - 1);
  FCanvas.LineTo(aNub.Position.Right, aNub.Position.Top - 1);

  FCanvas.MoveTo(aNub.Position.Left, aNub.Position.Bottom);
  FCanvas.LineTo(aNub.Position.Right, aNub.Position.Bottom);

end; {procedure, DrawNubHighlight}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawMasterSymbol }

procedure TdaVisualLink.DrawMasterSymbol;
var
  liTop: Integer;
  liLeft: Integer;
  lRect: TRect;
begin

  lRect := FMasterNub.SymbolPosition;

  liLeft := lRect.Left;
  liTop := lRect.Top;

  FCanvas.MoveTo(liLeft + 1, liTop);
  FCanvas.LineTo(liLeft + 1, liTop + 6);

  FCanvas.MoveTo(liLeft + 2, liTop);
  FCanvas.LineTo(liLeft + 2, liTop + 6);

  FCanvas.MoveTo(liLeft, liTop + 6);
  FCanvas.LineTo(liLeft + 4, liTop + 6);

  FCanvas.MoveTo(liLeft, liTop + 2);
  FCanvas.LineTo(liLeft, liTop + 3);

end; {procedure, DrawMasterSymbol}

{------------------------------------------------------------------------------}
{ TdaVisualLink.DrawDetailSymbol }

procedure TdaVisualLink.DrawDetailSymbol;
var
  liTop: Integer;
  liLeft: Integer;
  lRect: TRect;
begin

  lRect := FDetailNub.SymbolPosition;

  liLeft := lRect.Left;
  liTop := lRect.Top;

  FCanvas.Rectangle(liLeft, liTop + 1, liLeft + 2, liTop + 4);
  FCanvas.Rectangle(liLeft + 5, liTop + 1, liLeft + 9, liTop + 4);
  FCanvas.Rectangle(liLeft + 12, liTop + 1, liLeft + 14, liTop + 4);

  FCanvas.MoveTo(liLeft + 1, liTop);
  FCanvas.LineTo(liLeft + 6, liTop);

  FCanvas.MoveTo(liLeft + 1, liTop + 4);
  FCanvas.LineTo(liLeft + 6, liTop + 4);

  FCanvas.MoveTo(liLeft + 8, liTop);
  FCanvas.LineTo(liLeft + 13, liTop);

  FCanvas.MoveTo(liLeft + 8, liTop + 4);
  FCanvas.LineTo(liLeft + 13, liTop + 4);

end; {procedure, DrawDetailSymbol}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CalcPosition }

procedure TdaVisualLink.CalcPosition;
var
  liXOffset: Integer;
  liYOffset: Integer;
begin

  FMasterFieldPosition := FMaster.GetFieldPosition(FMasterFieldName);
  FDetailFieldPosition := FDetail.GetFieldPosition(FDetailFieldName);

  liXOffset := FWorkspace.HorzScrollBar.ScrollPos;
  liYOffset := FWorkspace.VertScrollBar.ScrollPos;

  FMasterFieldPosition.Left := FMasterFieldPosition.Left + liXOffset;
  FMasterFieldPosition.Right := FMasterFieldPosition.Right + liXOffset;
  FDetailFieldPosition.Left := FDetailFieldPosition.Left + liXOffset;
  FDetailFieldPosition.Right := FDetailFieldPosition.Right + liXOffset;

  FMasterFieldPosition.Top := FMasterFieldPosition.Top + liYOffset;
  FMasterFieldPosition.Bottom := FMasterFieldPosition.Bottom + liYOffset;
  FDetailFieldPosition.Top := FDetailFieldPosition.Top + liYOffset;
  FDetailFieldPosition.Bottom := FDetailFieldPosition.Bottom + liYOffset;

  CalcNubPosition(FMasterNub, FMasterFieldPosition, (FMaster.Left < FDetail.Left));
  CalcNubPosition(FDetailNub, FDetailFieldPosition, (FDetail.Left < FMaster.Left));

  {calc overall position of link}
  CalcArea;

end; {procedure, CalcPosition}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CalcNubPosition }

procedure TdaVisualLink.CalcNubPosition(aNub: TdaVisualLinkNub; aRect: TRect; aRightSide: Boolean);
var
  liHeight: Integer;
  lNubRect: TRect;
  lNubTip: TPoint;
begin

  if (aRightSide) then
    begin
      lNubRect.Left := aRect.Right + 1;
      lNubRect.Right := lNubRect.Left + 15;

      lNubTip.X := lNubRect.Right - 1;
    end
  else
    begin
      lNubRect.Right := aRect.Left;
      lNubRect.Left := lNubRect.Right - 15;

      lNubTip.X := lNubRect.Left - 1;
    end;

  liHeight := aRect.Bottom - aRect.Top;

  lNubRect.Top := aRect.Top + (liHeight - 3) div 2;
  lNubRect.Bottom := lNubRect.Top + 3;

  lNubTip.Y := lNubRect.Top + 1;

  aNub.Position := lNubRect;
  aNub.Tip := lNubTip;

end; {procedure, CalcNubPosition}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CalcArea }

procedure TdaVisualLink.CalcArea;
begin

  if (FMasterNub.Left < FDetailNub.Left) then
    begin
      FArea.Left := FMasterNub.Left;
      FArea.Right := FDetailNub.Right;
    end
  else
    begin
      FArea.Left := FDetailNub.Left;
      FArea.Right := FMasterNub.Right;
    end;

  if (FMasterNub.Top < FDetailNub.Top) then
    begin
      FArea.Top := FMasterNub.Bottom - 12;
      FArea.Bottom := FDetailNub.Bottom;
    end
  else
    begin
      FArea.Top := FDetailNub.Bottom - 11;
      FArea.Bottom := FMasterNub.Bottom
    end;
end; {procedure, CalcArea}

{------------------------------------------------------------------------------}
{ TdaVisualLink.PointInRect }

function TdaVisualLink.PointInRect(aRect: TRect; aX, aY: Integer; aThreshold: Integer): Boolean;
var
  lPoint: TPoint;
begin

  InflateRect(aRect, aThreshold, aThreshold);

  lPoint := Point(aX, aY);

  if PtInRect(aRect, lPoint) then
    Result := True
  else
    Result := False;

end; {function, PointInRect}

{------------------------------------------------------------------------------}
{ TdaVisualLink.PointOnLine }

function TdaVisualLink.PointOnLine(aStartPoint, aEndPoint: TPoint; aX, aY: Integer; aThreshold: Integer): Boolean;
var
  liAcross: Integer;
  liDown: Integer;
  ldSlope: Double;
  liX: Integer;
  liY: Integer;
  liLastY: Integer;
  liEndY: Integer;
  liXStep: Integer;
  lStartPoint: TPoint;
  lEndPoint: TPoint;
begin

  {make sure we are moving from left to right on the x-axis}
  if (aEndPoint.X < aStartPoint.X) then
    begin
      lStartPoint := aEndPoint;
      lEndPoint := aStartPoint;
    end
  else
    begin
      lStartPoint := aStartPoint;
      lEndPoint := aEndPoint;
    end;

  { calculate the height to width ratio }
  liAcross := lEndPoint.X - lStartPoint.X;
  liDown := lEndPoint.Y - lStartPoint.Y;

  if (liAcross = 0) then
    ldSlope := liDown
  else if (liDown = 0) then
    ldSlope := 0
  else
    ldSlope := liDown / liAcross;

  liX := lStartPoint.X;
  liY := lStartPoint.Y;

  Result := (aX <= liX + aThreshold) and (aX >= liX - aThreshold) and
            (aY <= liY + aThreshold) and (aY >= liY - aThreshold);

  while not(Result) and (liX <= lEndPoint.X) do
    begin
      {save the last vertical position}
      liLastY := liY;

      {calculate how far across we are}
      liXStep := liX - lStartPoint.X + 1;

      {calculate how far down we should go, given how far are across we are}
      liY := lStartPoint.Y + Round(ldSlope * liXStep);

      {if we have to go down more than one pixel we have a vertical line segment,
       check all of the points in this segment}
      if (liY > liLastY + 1) then
        begin
          liEndY := liY;
          liY := liLastY;

          while not(Result) and (liY <= liEndY) do
            begin
              Result := (aX <= liX + aThreshold) and (aX >= liX - aThreshold) and
                        (aY <= liY + aThreshold) and (aY >= liY - aThreshold);

              Inc(liY);
            end;
        end

      else
        Result := (aX <= liX + aThreshold) and (aX >= liX - aThreshold) and
                  (aY <= liY + aThreshold) and (aY >= liY - aThreshold);

      Inc(liX);
    end;

end; {function, PointOnLine}

{******************************************************************************
 *
 ** V I S U A L   L I N K   N U B
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TdaVisualLink.CreateNub }

constructor TdaVisualLinkNub.CreateNub(aMaster: Boolean);
begin

  inherited Create;

  FMaster := aMaster;

end; {constructor, CreateNub}

{------------------------------------------------------------------------------}
{ TdaVisualLink.GetSymbolPosition }

function TdaVisualLinkNub.GetSymbolPosition: TRect;
var
  liMargin: Integer;
begin

  if (FMaster) then
    begin
      liMargin := ((FPosition.Right - FPosition.Left) - 4) div 2;

      Result.Left := FPosition.Left + liMargin;
      Result.Top := FPosition.Bottom - 12;
      Result.Right := FPosition.Right - liMargin;
      Result.Bottom := FPosition.Bottom - 3;
    end
  else
    begin
      Result.Left := FPosition.Left;
      Result.Top := FPosition.Bottom - 11;
      Result.Right := FPosition.Right;
      Result.Bottom := FPosition.Bottom - 3;
    end;

end; {function, GetSymbolPosition}

{------------------------------------------------------------------------------}
{ TdaVisualLink.GetLeft }

function TdaVisualLinkNub.GetLeft: Integer;
begin
  Result := FPosition.Left;
end; {function, GetLeft}

{------------------------------------------------------------------------------}
{ TdaVisualLink.GetTop }

function TdaVisualLinkNub.GetTop: Integer;
begin
  Result := FPosition.Top;
end; {function, GetTop}

{------------------------------------------------------------------------------}
{ TdaVisualLink.GetRight }

function TdaVisualLinkNub.GetRight: Integer;
begin
  Result := FPosition.Right;
end; {function, GetRight}

{------------------------------------------------------------------------------}
{ TdaVisualLink.GetBottom }

function TdaVisualLinkNub.GetBottom: Integer;
begin
  Result := FPosition.Bottom;
end; {function, GetBottom}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetLeft }

procedure TdaVisualLinkNub.SetLeft(aValue: Integer);
begin
  FPosition.Left := aValue;
end; {procedure, SetLeft}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetTop }

procedure TdaVisualLinkNub.SetTop(aValue: Integer);
begin
  FPosition.Top := aValue;
end; {procedure, SetTop}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetRight }

procedure TdaVisualLinkNub.SetRight(aValue: Integer);
begin
  FPosition.Right := aValue;
end; {procedure, SetRight}

{------------------------------------------------------------------------------}
{ TdaVisualLink.SetBottom }

procedure TdaVisualLinkNub.SetBottom(aValue: Integer);
begin
  FPosition.Bottom := aValue;
end; {procedure, SetBottom}

end.
