{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2009                    BBBBB   }


unit ppGraphicsDevice;

interface

uses
  Classes,
  Windows,
  Graphics,
  Types,

  ppComm,
  ppDevice,
  ppDrwCmd,
  ppRTTI;

type

  {@TppGraphicsDevice

    Base device for rendering to a graphics Canvas.

    TppGraphicsDevice is the ancestor of TppScreenDevice and is used by TppImageDevice
    as a helper class.}

  TppGraphicsDevice = class(TppRasterDevice)
    private
{$IFDEF NewGraphics}
      FGraphicsContext: TppGraphicsContextPrinter;
{$ENDIF}
      FCalculatedZoom: Integer;
      FCanvas: TCanvas;
      FPage: TppPage;
      FPageColor: TColor;
      FPageImage: TBitmap;
      FOffsetX: Integer;
      FOffsetY: Integer;
      FOnPageRendered: TNotifyEvent;
      FScaledPageHeight: Integer;
      FScaledPageWidth: Integer;
      FScale: Double;

      function GetAbsolutePageCount: Longint;
      function GetAbsolutePageNo: Longint;
      function GetPage: TppPage;
      procedure SetScale(const Value: Double);

    protected
      procedure AfterReceivePage(aPage: TppPage); virtual;
      procedure CalculateScaledPageSize; virtual;
      procedure CreateNewPageImage;
      procedure UpdateCanvas;
      procedure DrawShape(aDrawShape: TppDrawShape); virtual;
      procedure DrawLine(aDrawLine: TppDrawLine); virtual;
      procedure DrawImage(aDrawImage: TppDrawImage); virtual;
      procedure DrawText(aDrawText: TppDrawText); virtual;
      procedure DirectDrawImage(aDrawImage: TppDrawImage); virtual;
      procedure AddWaterMark(aPage: TppPage); virtual;
      procedure AfterRenderpage; virtual;
      procedure BeforeRenderPage; virtual;
      procedure DoOnPageRendered; virtual;
      procedure DrawRotatedText(aDrawText: TppDrawText); virtual;
      procedure DrawStandardText(aDrawText: TppDrawText); virtual;
      procedure FillGradient(aDrawShape: TppDrawShape); virtual;
      procedure SetCanvas(aCanvas: TCanvas);
{$IFDEF NewRect}
      procedure RenderRectangle(aDrawShape: TppDrawShape);
{$ENDIF}
{$IFDEF NewGraphics}
      function GetGraphicsContext: TppGraphicsContext; override;
{$ENDIF}
    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;

      class function DeviceName: String; override;

      procedure CancelJob; override;
      function  Draw(aDrawCommand: TppDrawCommand): Boolean; override;
      procedure DrawBorder(aDrawCommand: TppDrawCommand; aDrawRect: TRect);
      procedure EndJob; override;
      procedure FirstPage;
      procedure GotoPage(aAbsolutePageNo: Longint);
      procedure LastPage;
      procedure ReceivePage(aPage: TppPage); override;
      procedure RenderPage;
      procedure Reset; override;
      procedure ScaleVertices(aDrawCommand: TppDrawCommand);
      procedure StartJob; override;

      property AbsolutePageNo: Longint read GetAbsolutePageNo;
      property AbsolutePageCount: Longint read GetAbsolutePageCount;
      property CalculatedZoom: Integer read FCalculatedZoom write FCalculatedZoom;
      property Canvas: TCanvas read FCanvas write FCanvas;
      property OffsetX: Integer read FOffsetX;
      property OffsetY: Integer read FOffsetY;
      property OnPageRendered: TNotifyEvent read FOnPageRendered write FOnPageRendered;
      property Page: TppPage read GetPage;
      property PageColor: TColor read FPageColor write FPageColor;
      property PageImage: TBitmap read FPageImage;
      property ScaledPageHeight: Integer read FScaledPageHeight write FScaledPageHeight;
      property ScaledPageWidth: Integer read FScaledPageWidth write FScaledPageWidth;
      property Scale: Double read FScale write SetScale;
  end; {class, TppGraphicsDevice}

implementation

uses
  SysUtils,
  Forms,
  ExtCtrls,
  ppPrintr,
  ppTypes,
  ppUtils,
  ppRotatedText,
  ppPlainText;

{******************************************************************************
 *
 ** G R A P H I C S   D E V I C E
 *
{******************************************************************************}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.Create }

constructor TppGraphicsDevice.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FPageImage := TBitMap.Create;
  FPage := TppPage.Create(nil);
  FScale := 1;
  FPageColor := clWhite;

  FOnPageRendered := nil;

  {tell publisher we just want the first page}
  PageRequest.PageSetting := psFirstPage;
  PageRequest.PageRequested := 1;

end;

procedure TppGraphicsDevice.CreateNewPageImage;
begin
  FPageImage.Free;
  FPageImage := TBitmap.Create;

end;

{constructor, Create}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.Destroy }

destructor TppGraphicsDevice.Destroy;
begin

  FPageImage.Free;
  FPageImage := nil;

  FPage.Free;
  FPage := nil;

{$IFDEF NewGraphics}
  FGraphicsContext.Free;
  FGraphicsContext := nil;
{$ENDIF}

  inherited Destroy;

end; {destructor, Destroy}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DoOnPageRendered }

procedure TppGraphicsDevice.DoOnPageRendered;
begin
  if Assigned(FOnPageRendered) then FOnPageRendered(Self);
end; {procedure, DoOnPageRendered}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DeviceName }

class function TppGraphicsDevice.DeviceName: String;
begin
  Result := 'Graphics';
end; {class function, DeviceName}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.StartJob }

procedure TppGraphicsDevice.StartJob;
begin

  inherited StartJob;

  SetStatus(ppLoadStr(2)); {'Accessing data...'}

  FPage.Clear;

end;

procedure TppGraphicsDevice.UpdateCanvas;
begin
  if FPageImage <> nil then
    FCanvas := FPageImage.Canvas;
end;

{procedure, StartJob}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.CancelJob }

procedure TppGraphicsDevice.CancelJob;
begin

  SetStatus(FPage.PageNoDescription);

  inherited CancelJob;

end; {procedure, CancelJob}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.EndJob }

procedure TppGraphicsDevice.EndJob;
begin

  if (Publisher <> nil) and (Publisher.ReportCompleted) then
    SetStatus(FPage.PageSetDescription)
  else
    SetStatus(FPage.PageNoDescription);

  inherited EndJob;

end; {procedure, EndJob}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.Reset }

procedure TppGraphicsDevice.Reset;
begin

  inherited Reset;

  PageRequest.PageSetting := psFirstPage;
  PageRequest.PageRequested := 1;

end;  {procedure, Reset}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.GetAbsolutePageNo }

function TppGraphicsDevice.GetAbsolutePageNo: Longint;
begin
  Result := FPage.AbsolutePageNo;
end; {function, GetPageDef}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.GetAbsolutePageCount }

function TppGraphicsDevice.GetAbsolutePageCount;
begin
  Result := FPage.AbsolutePageCount;
end; {function, GetPageDef}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.GetPageDef }

function TppGraphicsDevice.GetPage: TppPage;
begin
  Result := FPage;
end; {function, GetPageDef}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.ReceivePage }

procedure TppGraphicsDevice.ReceivePage(aPage: TppPage);
var
  lsMessage: String;
begin

  inherited ReceivePage(aPage);

  if (csDesigning in ComponentState) then Exit;

  if IsRequestedPage  then
    begin

      if IsMessagePage then
        begin

          if (Publisher <> nil) and Publisher.ReportCompleted then
            begin
              lsMessage := ppLoadStr(10); {'Drawing page 1 of 15 for <documentname>'}
              lsMessage := ppSetMessageParameters(lsMessage);
              lsMessage := Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), IntToStr(aPage.AbsolutePageCount), aPage.DocumentName]);
            end
          else
            begin
              lsMessage := ppLoadStr(4); {'Calculating page 1 for <documentname>'}
              lsMessage := ppSetMessageParameters(lsMessage);
              lsMessage := Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), aPage.DocumentName]);
            end;

          SetStatus(lsMessage);
        end

      else {if not(IsMessagePage) then}
        begin
          FPage.Assign(aPage);

          AddWaterMark(FPage);

          RenderPage;

          AfterReceivePage(FPage);  //Implemented in the descendent

        end;

    end

  else if (aPage.Calculation) then
    begin
      lsMessage := ppLoadStr(4); {'Calculating Page 1 of 15 for <documentname>'}
      lsMessage := ppSetMessageParameters(lsMessage);
      lsMessage := Format(lsMessage, [IntToStr(aPage.AbsolutePageNo), aPage.DocumentName]);

      SetStatus(lsMessage);

      {update current page}
      if (FPage.AbsolutePageCount <> aPage.AbsolutePageCount) then
        begin
          FPage.AbsolutePageCount := aPage.AbsolutePageCount;

          if (FPage.ControlGroupBreakNo = aPage.ControlGroupBreakNo) then
            FPage.PageCount := aPage.PageCount;

          if FPage.HasUpdateables then
            begin
              FPage.Update(Self);
              {allow page canvas to painted}
              Application.ProcessMessages;
            end;
        end;
    end;


end; {procedure, ReceivePage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.FirstPage }

procedure TppGraphicsDevice.FirstPage;
begin
  if Busy then Exit;

  if Cancelled then Exit;

  if (FPage.AbsolutePageNo = 1) then Exit;

  {tell publisher we just want a single page}
  PageRequest.PageSetting := psFirstPage;

  MakePageRequest;

end; {function, FirstPage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.LastPage }

procedure TppGraphicsDevice.LastPage;
begin

  if Busy then Exit;

  if Cancelled then Exit;

  if FPage.LastPage then Exit;

  {tell publisher we just want a single page}
  PageRequest.PageSetting := psLastPage;

  MakePageRequest;

end; {function, LastPage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.GotoPage }

procedure TppGraphicsDevice.GotoPage(aAbsolutePageNo: Longint);
begin
  if Busy then Exit;

  if (FPage.AbsolutePageNo = aAbsolutePageNo) then Exit;

  {tell publisher we just want a single page}
  PageRequest.PageSetting := psSinglePage;
  PageRequest.PageRequested := aAbsolutePageNo;

  MakePageRequest;
end; {function, GotoPage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.RenderPage }

procedure TppGraphicsDevice.RenderPage;
var
 lRect: TRect;
 lPageDef: TppPageDef;

begin

  lPageDef := FPage.PageDef;

  if (lPageDef.mmWidth = 0) or (lPageDef.mmHeight = 0) then Exit;

  BeforeRenderPage;

  {calculate scaled page boundaries}
  lRect.Left   := (FPageImage.Width - FScaledPageWidth) div 2;
  lRect.Top    := (FPageImage.Height - FScaledPageHeight) div 2;
  lRect.Right  := lRect.Left + FScaledPageWidth;
  lRect.Bottom := lRect.Top + FScaledPageHeight;

  {draw page background}
  FCanvas.Pen.Style := psClear;
  FCanvas.Brush.Style := bsSolid;

  FCanvas.Brush.Color := FPageColor;

  FCanvas.Rectangle(lRect.Left, lRect.Top, lRect.Right, lRect.Bottom);

  {calculate offsets for each printing rect}
  FOffsetY := lRect.Top;
  FOffsetX := lRect.Left;

  SendEventNotify(Self, ciScreenDeviceBeforeDrawPage, nil);

  // render drawcommands
  DrawPage(FPage);

  SendEventNotify(Self, ciScreenDeviceAfterDrawPage, nil);

  AfterRenderPage;

  DoOnPageRendered;

end;

procedure TppGraphicsDevice.AfterReceivePage(aPage: TppPage);
begin
  //Implemented in the descendent
end;

procedure TppGraphicsDevice.AfterRenderpage;
begin
  //Implemented in the descendent
end;

procedure TppGraphicsDevice.BeforeRenderPage;
begin
  //Implemented in the descendent
end;

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.CalculateScaledPageSize}

procedure TppGraphicsDevice.CalculateScaledPageSize;
var
 lPageDef: TppPageDef;
begin

  FCalculatedZoom := -1;

  lPageDef := FPage.PageDef;

  {compute page rectangle size}
  FScaledPageHeight := Round(lPageDef.spHeight * FScale);
  FScaledPageWidth := Round(lPageDef.spWidth * FScale);

  {set area around page border}
  //liDeadArea := liEighthInch; //property of Screen Device  TODO

  FPageImage.Height := FScaledPageHeight;
  FPageImage.Width  := FScaledPageWidth;

  if FCalculatedZoom = -1 then
    FCalculatedZoom := Round((FScaledPageHeight / lPageDef.spHeight) * 100);

end; {procedure, CalculateScaledPageSize}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.ScaleVertices}

procedure TppGraphicsDevice.ScaleVertices(aDrawCommand: TppDrawCommand);
var
  liLeft: Integer;
  liTop: Integer;
  liWidth: Integer;
  liHeight: Integer;
begin

  liLeft   := Trunc(ppFromMMThousandths(aDrawCommand.Left,   utScreenPixels, pprtHorizontal, nil));
  liTop    := Trunc(ppFromMMThousandths(aDrawCommand.Top,    utScreenPixels, pprtVertical,   nil));
  liWidth  := Trunc(ppFromMMThousandths(aDrawCommand.Width,  utScreenPixels, pprtHorizontal, nil));
  liHeight := Trunc(ppFromMMThousandths(aDrawCommand.Height, utScreenPixels, pprtVertical,   nil));

  {scale the bounding rectangle}
  aDrawCommand.DrawLeft   := FOffsetX + Round(liLeft * FScale);
  aDrawCommand.DrawTop    := FOffsetY + Round(liTop * FScale);
  aDrawCommand.DrawRight  := FOffsetX + Round((liLeft + liWidth) * FScale);
  aDrawCommand.DrawBottom := FOffsetY + Round((liTop + liHeight) * FScale);

end; {procedure, ScaleVertices}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.Draw }

function TppGraphicsDevice.Draw(aDrawCommand: TppDrawCommand): Boolean;
begin

{$IFDEF NewGraphics}
  Result := inherited Draw(aDrawCommand);

  if Result then Exit;
{$ENDIF}

  Result := True;

  ScaleVertices(aDrawCommand);

  if (aDrawCommand is TppDrawText) then
    DrawText(TppDrawText(aDrawCommand))

  else if (aDrawCommand is TppDrawCalc) then
    DrawText(TppDrawText(aDrawCommand))

  else if (aDrawCommand is TppDrawShape) then
    DrawShape(TppDrawShape(aDrawCommand))

  else if (aDrawCommand is TppDrawLine) then
    DrawLine(TppDrawLine(aDrawCommand))

  else if (aDrawCommand is TppDrawImage) then
    DrawImage(TppDrawImage(aDrawCommand))

  else
    Result := False;

end; {function, Draw}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawShape }

procedure TppGraphicsDevice.DrawShape(aDrawShape: TppDrawShape);
var
  liXCornerRound: Integer;
  liYCornerRound: Integer;
  lLogBrush: TLogBrush;
begin


  {assign pen and brush}
  FCanvas.Pen   := aDrawShape.Pen;
  FCanvas.Brush := aDrawShape.Brush;

  {scale pen width}
  FCanvas.Pen.Width := Round(aDrawShape.Pen.Width * FScale);

 if (FCanvas.Pen.Style <> psSolid) and (FCanvas.Pen.Width > 1) then
   begin
     lLogBrush.lbStyle := Ord(bsSolid);
     lLogBrush.lbColor := ColorToRGB(FCanvas.Pen.Color);
     lLogBrush.lbHatch := 0;
     FCanvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or Ord(FCanvas.Pen.Style), FCanvas.Pen.Width, lLogBrush, 0, nil);
   end;

  if aDrawShape.Gradient.Style <> gsNone then
    FillGradient(aDrawShape);

  {draw shape}
  case aDrawShape.ShapeType of

    stRectangle:
{$IFDEF NewRect}
      if aDrawShape.OldStyle then
        FCanvas.Rectangle(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom)
      else
        RenderRectangle(aDrawShape);
{$ELSE}
        FCanvas.Rectangle(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom);
{$ENDIF}

    stEllipse:
      FCanvas.Ellipse(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom);

    stRoundRect:
      begin
        liXCornerRound := Trunc(ppFromMMThousandths(aDrawShape.XCornerRound, utScreenPixels, pprtHorizontal, nil));
        liYCornerRound := Trunc(ppFromMMThousandths(aDrawShape.YCornerRound, utScreenPixels, pprtVertical, nil));

        liXCornerRound := Round(liXCornerRound * FScale);
        liYCornerRound := Round(liYCornerRound * FScale);

        FCanvas.RoundRect(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom,
                          liXCornerRound, liYCornerRound);

      end; {case, RoundRect}

  end; {case, ShapeType}

end; {procedure, DrawShape}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawLine }

procedure TppGraphicsDevice.DrawLine(aDrawLine: TppDrawLine);
var
  liPenWidth: Integer;
  liSize: Integer;
  liOffset: Integer;
  liLines: Integer;
  liLine: Integer;
  liPosition: Integer;
begin

  {get pen width}
  liPenWidth := Round( (aDrawLine.Weight * Screen.PixelsPerInch / 72) * FScale);

  if (liPenWidth = 0) then
    liSize := 1
  else
    liSize := liPenWidth;

  {how many lines to draw?}
  if aDrawLine.LineStyle = lsSingle then
    liLines := 1
  else
    liLines := 2;

   {when draiwing bottom line, descrease the height by one pixel, otherwise
   the line is drawn outside the bounds of the control}
  if aDrawLine.LinePosition = lpBottom then
    aDrawLine.DrawBottom := aDrawLine.DrawBottom - 1;

  {when draiwing right line, descrease the width by one pixel, otherwise
  the line is drawn outside the bounds of the control}
  if aDrawLine.LinePosition = lpRight then
    aDrawLine.DrawRight := aDrawLine.DrawRight - 1;


  {setting brush to cross causes LineTo to honor the penstyle}
  FCanvas.Brush.Style := bsCross;

  {we're going to draw rectangles, because the pen doesn't work for large pen widths}
  FCanvas.Pen := aDrawLine.Pen;
  FCanvas.Pen.Width := 1;

  for liLine := 1 to liLines do
    begin

      if (liLine = 1) then
        liOffset := 0
      else
        liOffset := liSize * 2;

      for liPosition := 0 to liSize - 1 do

      {set print object moveto/lineto positions}
      case aDrawLine.LinePosition of
        lpTop:
          begin
            FCanvas.MoveTo(aDrawLine.DrawLeft, aDrawLine.DrawTop + liOffset + liPosition);
            FCanvas.LineTo(aDrawLine.DrawRight, aDrawLine.DrawTop + liOffset + liPosition);
          end;

        lpBottom:
          begin
            FCanvas.MoveTo(aDrawLine.DrawLeft, aDrawLine.DrawBottom - liOffset - liPosition);
            FCanvas.LineTo(aDrawLine.DrawRight, aDrawLine.DrawBottom - liOffset - liPosition);
          end;

        lpLeft:
          begin
            FCanvas.MoveTo(aDrawLine.DrawLeft + liOffset + liPosition, aDrawLine.DrawTop);
            FCanvas.LineTo(aDrawLine.DrawLeft + liOffset + liPosition, aDrawLine.DrawBottom);
          end;

        lpRight:
          begin
            FCanvas.MoveTo(aDrawLine.DrawRight - liOffset - liPosition, aDrawLine.DrawTop);
            FCanvas.LineTo(aDrawLine.DrawRight - liOffset - liPosition, aDrawLine.DrawBottom);
          end;

        lpDiagLeft:
          begin
            FCanvas.MoveTo(aDrawLine.DrawLeft - liOffset - liPosition, aDrawLine.DrawTop);
            FCanvas.LineTo(aDrawLine.DrawRight - liOffset - liPosition, aDrawLine.DrawBottom);
          end;

        lpDiagRight:
          begin
            FCanvas.MoveTo(aDrawLine.DrawRight - liOffset - liPosition, aDrawLine.DrawTop);
            FCanvas.LineTo(aDrawLine.DrawLeft - liOffset - liPosition, aDrawLine.DrawBottom);
          end;

      end; {case, line style}

   end; {for, each line}

end; {procedure, DrawLine}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawImage }

procedure TppGraphicsDevice.DrawImage(aDrawImage: TppDrawImage);
begin

  if (aDrawImage = nil) or (aDrawImage.Picture = nil) or
     (aDrawImage.Picture.Graphic = nil) then Exit;

  // draw image to screen
  DirectDrawImage(aDrawImage);

end; {procedure, DrawImage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DirectDrawImage }

procedure TppGraphicsDevice.DirectDrawImage(aDrawImage: TppDrawImage);
var
  lSaveClipRgn: HRGN;
  lNewClipRgn: HRGN;
  lDrawRect: TRect;
  liImageWidth: Integer;
  liImageHeight: Integer;
  liControlWidth: Integer;
  liControlHeight: Integer;
  lfScale: Single;
  liScaledWidth: Integer;
  liScaledHeight: Integer;

begin

  if aDrawImage.Transparent then
    FCanvas.CopyMode := cmSrcAnd
  else
    FCanvas.CopyMode := cmSrcCopy;

  {initialize}
  lDrawRect := aDrawImage.DrawRect;

  {compute image dimensions in screen pixels}
  liImageWidth    := aDrawImage.Picture.Graphic.Width;
  liImageHeight   := aDrawImage.Picture.Graphic.Height;

  if (liImageWidth = 0) or (liImageHeight = 0)  then
    // do nothing
  else if aDrawImage.Stretch then
    begin

      {scale the draw rect to maintain aspect ration, if needed }
      if aDrawImage.MaintainAspectRatio then
        begin
          liControlWidth  := lDrawRect.Right  - lDrawRect.Left;
          liControlHeight := lDrawRect.Bottom - lDrawRect.Top;

          lfScale := ppCalcAspectRatio(liImageWidth, liImageHeight, liControlWidth, liControlHeight);

          liScaledWidth  := Trunc(liImageWidth  * lfScale);
          liScaledHeight := Trunc(liImageHeight * lfScale);

          case aDrawImage.AlignHorizontal of
            ahLeft: lDrawRect.Left := lDrawRect.Left;
            ahCenter: lDrawRect.Left := lDrawRect.Left + (liControlWidth  - liScaledWidth)  div 2;
            ahRight: lDrawRect.Left := lDrawRect.Left + (liControlWidth  - liScaledWidth);
          end;

          case aDrawImage.AlignVertical of
            avTop: lDrawRect.Top := lDrawRect.Top;
            avCenter: lDrawRect.Top := lDrawRect.Top  + (liControlHeight - liScaledHeight) div 2;
            avBottom: lDrawRect.Top := lDrawRect.Top  + (liControlHeight - liScaledHeight);
          end;

          lDrawRect.Right  := lDrawRect.Left + liScaledWidth;
          lDrawRect.Bottom := lDrawRect.Top  + liScaledHeight;

        end;

      {draw image}
      FCanvas.StretchDraw(lDrawRect, aDrawImage.Picture.Graphic);

      {Add borders if needed - use original draw rect}
      if aDrawImage.Border.Visible then
        DrawBorder(aDrawImage, aDrawImage.DrawRect);

    end

  else
    begin
      lSaveClipRgn := 0;
      GetClipRgn (FCanvas.Handle, lSaveClipRgn);

      {set clipping region}
      lNewClipRgn  := CreateRectRgnIndirect(aDrawImage.DrawRect);
      SelectClipRgn (FCanvas.Handle, lNewClipRgn);

      {compute control dimensions in screen pixels}
      liControlWidth  := Trunc(ppFromMMThousandths(aDrawImage.Width,  utScreenPixels, pprtHorizontal, nil));
      liControlHeight := Trunc(ppFromMMThousandths(aDrawImage.Height, utScreenPixels, pprtVertical,   nil));

      case aDrawImage.AlignHorizontal of
        ahLeft: lDrawRect.Left := lDrawRect.Left;
        ahCenter: lDrawRect.Left := lDrawRect.Left + Trunc( ((liControlWidth  - liImageWidth)  div 2) * FScale);
        ahRight: lDrawRect.Left := lDrawRect.Left + Trunc( (liControlWidth  - liImageWidth) * FScale);
      end;

      case aDrawImage.AlignVertical of
        avTop: lDrawRect.Top := lDrawRect.Top;
        avCenter: lDrawRect.Top := lDrawRect.Top  + Trunc( ((liControlHeight - liImageHeight) div 2) * FScale);
        avBottom: lDrawRect.Top := lDrawRect.Top  + Trunc( (liControlHeight - liImageHeight) * FScale);
      end;

      {compute right and bottom}
      lDrawRect.Right  := lDrawRect.Left + Trunc(liImageWidth  * FScale);
      lDrawRect.Bottom := lDrawRect.Top  + Trunc(liImageHeight * FScale);

      FCanvas.StretchDraw(lDrawRect, aDrawImage.Picture.Graphic);

      {restore clipping region}
      SelectClipRgn(FCanvas.Handle, lSaveClipRgn);

      DeleteObject(lNewClipRgn);

      {Add borders if needed - use original draw rect}
      if aDrawImage.Border.Visible then
        DrawBorder(aDrawImage, aDrawImage.DrawRect);

  end

end; {procedure, DirectDrawImage}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawBorder }

procedure TppGraphicsDevice.DrawBorder(aDrawCommand: TppDrawCommand; aDrawRect: TRect);
var
  lBorderPositions: TppBorderPositions;
  lPenWidth: Integer;
  liOffset: Integer;
begin

  FCanvas.Pen.Style := aDrawCommand.Border.Style;
  FCanvas.Pen.Color := aDrawCommand.Border.Color;
  lPenWidth := Round((aDrawCommand.Border.Weight * Screen.PixelsPerInch / 72) * FScale);

  if lPenWidth = 0 then
    lPenWidth := 1;

  FCanvas.Pen.Width := 1;

  lBorderPositions := aDrawCommand.Border.BorderPositions;

  for liOffset := 0 to lPenWidth - 1 do
    begin

      if bpLeft in lBorderPositions then
        begin
          FCanvas.MoveTo(aDrawRect.Left + liOffset, aDrawRect.Top);
          FCanvas.LineTo(aDrawRect.Left + liOffset, aDrawRect.Bottom);
        end;

      if bpTop in lBorderPositions then
        begin
          FCanvas.MoveTo(aDrawRect.Left, aDrawRect.Top + liOffset);
          FCanvas.LineTo(aDrawRect.Right, aDrawRect.Top + liOffset);
        end;

      if bpRight in lBorderPositions then
        begin
          FCanvas.MoveTo(aDrawRect.Right - liOffset, aDrawRect.Top);
          FCanvas.LineTo(aDrawRect.Right - liOffset, aDrawRect.Bottom + 1);
        end;

      if bpBottom in lBorderPositions then
        begin
          FCanvas.MoveTo(aDrawRect.Left, aDrawRect.Bottom - liOffset);
          FCanvas.LineTo(aDrawRect.Right, aDrawRect.Bottom - liOffset);
        end;

    end;

end; {procedure, DrawBorder}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawText }

procedure TppGraphicsDevice.DrawText(aDrawText: TppDrawText);
begin
  if aDrawText.Angle = 0 then
    DrawStandardText(aDrawText)
  else
    DrawRotatedText(aDrawText);

end; {procedure, DrawText}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawRotatedText }

procedure TppGraphicsDevice.DrawRotatedText(aDrawText: TppDrawText);
var
  liTextBoxLeft: Integer;
  liTextBoxTop: Integer;
  lRotatedOrigin: TPoint;
  lCanvasTextOrigin: TPoint;
  lDrawRect: TRect;
  lDrawMMRect: TRect;
  liWidth: Integer;
  liHeight: Integer;
  liOriginalWidth: Integer;
  liOriginalHeight: Integer;
  liWidthChange: Integer;
  liHeightChange: Integer;
begin

  if aDrawText.Text = '' then Exit;

  FCanvas.Font := aDrawText.Font;
  FCanvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(aDrawText.Font.Name);
  FCanvas.Font.Height := Round(aDrawText.Font.Height * FScale);

  lDrawRect := Rect(aDrawText.DrawLeft, aDrawText.DrawTop, aDrawText.DrawRight, aDrawText.DrawBottom);

  //Calc new rotated origin in case text was changed in the OnGetText event.
  if aDrawText.AutoSize then
    lRotatedOrigin := aDrawText.RotatedOrigin
  else
    lRotatedOrigin := TppRotatedText.CalcRotatedOrigin(FCanvas, aDrawText.Text, aDrawText.Font, aDrawText.Width, aDrawText.Height, aDrawText.Angle, aDrawText.AutoSize, aDrawText.Alignment, aDrawText.Border);

  liTextBoxLeft := Trunc(ppFromMMThousandths(lRotatedOrigin.X, utScreenPixels, pprtHorizontal, nil));
  liTextBoxTop  := Trunc(ppFromMMThousandths(lRotatedOrigin.Y, utScreenPixels, pprtHorizontal, nil));

  lCanvasTextOrigin.X := aDrawText.DrawLeft + Round(liTextBoxLeft * FScale);
  lCanvasTextOrigin.Y := aDrawText.DrawTop + Round(liTextBoxTop * FScale);

  {Handle AutoSize issues}
  if aDrawText.AutoSize then
    begin
      lDrawMMRect := TppRotatedText.CalcRotatedTextBounds(FCanvas, aDrawText.Text, aDrawText.Font, 0, 0, aDrawText.Width, aDrawText.Height, aDrawText.Angle, aDrawText.AutoSize, aDrawText.Alignment, nil);

      liWidth := Round((Trunc(ppFromMMThousandths(lDrawMMRect.Right, utScreenPixels, pprtHorizontal, nil))) * FScale);
      liHeight := Round((Trunc(ppFromMMThousandths(lDrawMMRect.Bottom, utScreenPixels, pprtHorizontal, nil))) * FScale);
      liOriginalWidth := aDrawText.DrawRight - aDrawText.DrawLeft;
      liOriginalHeight := aDrawText.DrawBottom - aDrawText.DrawTop;
      liWidthChange := liWidth - liOriginalWidth;
      liHeightChange := liHeight - liOriginalHeight;

      if (liWidthChange <> 0) or (liHeightChange <> 0) then
        lDrawRect := TppRotatedText.AdjustAutoRect(aDrawText, aDrawText.DrawLeft, aDrawText.DrawTop, liWidth, liHeight, liOriginalWidth, liOriginalHeight);

      if (aDrawText.Alignment <> taLeftJustify) then
        lCanvasTextOrigin := TppRotatedText.AdjustRotatedText(lCanvasTextOrigin, aDrawText, liWidthChange, liHeightChange);
    end;

  {fill rectangle with background color}
  if not(aDrawText.Transparent) then
    begin
      FCanvas.Brush.Color := aDrawText.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.FillRect(lDrawRect);
    end;

  {Adjust text for borders}
  if aDrawText.Border.Visible then
    lCanvasTextOrigin := TppBorder.AdjustRotatedText(aDrawText.Border, aDrawText.Angle, lCanvasTextOrigin.X, lCanvasTextOrigin.Y, nil);

  TppRotatedText.TextOutRotate(FCanvas, FCanvas.Font, lDrawRect, lCanvasTextOrigin.X, lCanvasTextOrigin.Y, aDrawText.Angle, aDrawText.Text);

  {used to support preview form searching}
  aDrawText.DeviceFontHeight := FCanvas.Font.Height;
  aDrawText.DeviceLineHeight := aDrawText.Height;
  aDrawText.DeviceLineWidth :=  aDrawText.Width;

  {Add borders if needed}
  if aDrawText.Border.Visible then
    DrawBorder(aDrawText, lDrawRect);

end; {procedure, DrawRotatedText}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.DrawStandardText }

procedure TppGraphicsDevice.DrawStandardText(aDrawText: TppDrawText);
var
  liFontHeight: Integer;
  lParams: TraParamList;
  liLineHeight: Integer;
  liCalcHeight: Integer;
  liBorderOffset: Integer;
  liBorderBuffer: Integer;
  liDescent: Integer;
  lbLinesFit: Boolean;
  liLineSpaceUsed: Integer;
  liLines: Integer;
  liLine: Integer;
  lDrawRect: TRect;
  lRect: TRect;
  lCalcRect: TRect;
  liWidthAvailable: Integer;
  liTextWidth: Integer;
  lSourceText: TStringList;
  lsLine: String;
  liStart: Integer;
  liLeading: Integer;

  lLineBuf: PChar;
  lTextMetric: TTextMetric;
  lbTruncTheText: Boolean;

  llCalcHeight: Longint;

  liTabStopCount: Integer;
  liTabStop: Integer;
  lTabStopArray: TppTabStopPos;
  liTop: Integer;
  liMaxWidth: Integer;
  liPos: Integer;
  lbFullJustification: Boolean;

begin

  liTabStopCount := aDrawText.TabStopPositions.Count;
  liBorderOffset := Round(aDrawText.Border.SPWeight * FScale);
  liBorderBuffer := 0;

  {convert memo tab stop positions to screen units, if needed }
  if aDrawText.IsMemo and (aDrawText.TabStopPositions.Count > 0) then
    begin
      TppPlainText.ConvertTabStopPos(utScreenPixels, aDrawText.TabStopPositions, lTabStopArray, liTabStopCount, nil);

      for liTabStop := 0 to liTabStopCount - 1 do
        lTabStopArray[liTabStop] := Round(lTabStopArray[liTabStop] * FScale);
    end;


  if (FCanvas.Font.CharSet <> aDrawText.Font.CharSet) or
     (FCanvas.Font.Color   <> aDrawText.Font.Color)   or
     (FCanvas.Font.Pitch   <> aDrawText.Font.Pitch)   or
     (FCanvas.Font.Size    <> aDrawText.Font.Size)    or
     (FCanvas.Font.Style   <> aDrawText.Font.Style)   or
     (FCanvas.Font.Name    <> aDrawText.Font.Name) then

    FCanvas.Font := aDrawText.Font;


  {maybe we can't use the selected font}
  FCanvas.Font.Name := TppDeviceSubstitutions.SubstituteFont(aDrawText.Font.Name);

  {set font height}
  FCanvas.Font.Height := Round(aDrawText.Font.Height * FScale);

  lbTruncTheText := False;

  {font size must at least be one}
  if (FCanvas.Font.Height = 0) then
    FCanvas.Font.Height := -1;

  GetTextMetrics(FCanvas.Handle, lTextMetric);

  {use default leading for this font}
  if not(aDrawText.IsMemo) then
    liLeading := lTextMetric.tmExternalLeading
  else
    liLeading := Trunc(ppFromMMThousandths(aDrawText.Leading, utScreenPixels, pprtVertical, nil));

  liLineHeight := lTextMetric.tmHeight + liLeading;

  lDrawRect := Rect(aDrawText.DrawLeft, aDrawText.DrawTop, aDrawText.DrawRight, aDrawText.DrawBottom);

  {adjust bounding rect height}
  if aDrawText.AutoSize and not(aDrawText.WordWrap) and (Length(aDrawText.Text) > 0) then
    begin
      llCalcHeight := liLineHeight;

      lDrawRect.Bottom := lDrawRect.Top + llCalcHeight;
    end;

  lbLinesFit := True;
  liLine := 0;
  liLines := aDrawText.WrappedText.Count - 1;
  liWidthAvailable := (lDrawRect.Right - lDrawRect.Left);

  if (aDrawText.IsMemo) then
    begin

      // check width of each wrapped line versus width available and shrink font height as needed
      while (liLine <= liLines) do
        begin
          lsLine := aDrawText.WrappedText[liLine];

          liPos := Pos(TppTextMarkups.EOP, lsLine);

          if (liPos <> 0) then
            lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);

          liTextWidth := TppPlainText.GetTabbedTextWidth(FCanvas, lsLine, liTabStopCount, lTabStopArray);

          if (liPos <> 0) then
            lsLine := lsLine + TppTextMarkups.EOP;

          if (liTextWidth > liWidthAvailable) and (Abs(FCanvas.Font.Height) > 1) then
            begin
              if (FCanvas.Font.Height > 0) then
                FCanvas.Font.Height := FCanvas.Font.Height - 1
              else
                FCanvas.Font.Height := FCanvas.Font.Height + 1;

              if (Abs(FCanvas.Font.Height) > 1) then
                Inc(liLine)
              else
                liLine := liLines + 1;
            end

          else
            Inc(liLine);

        end;

      // update calculated line height
      GetTextMetrics(FCanvas.Handle, lTextMetric);

      {get leading for this font}
      if not(aDrawText.IsMemo) then
        liLeading := lTextMetric.tmExternalLeading
      else
        liLeading := Trunc(ppFromMMThousandths(aDrawText.Leading, utScreenPixels, pprtVertical, nil));

      liLineHeight := lTextMetric.tmHeight + liLeading;

      if (liLineHeight <= 0) then
        liLineHeight := 1;

      if (aDrawText.WrappedText.Count > 0) then
        liCalcHeight := Round((lDrawRect.Bottom - lDrawRect.Top) / aDrawText.WrappedText.Count)
      else
        liCalcHeight := 0;

      // check whether lines fit vertically - compare available line height to calculated line height
      if ((Abs(liCalcHeight - liLineHeight) / liLineHeight) <= 0.10) then
        liLineHeight := liCalcHeight

      else // adjust leading and line height to make lines fit vertically
        begin
          if (aDrawText.WrappedText.Count > 0) then
            lbLinesFit := liLineHeight <= Trunc((lDrawRect.Bottom - lDrawRect.Top) / aDrawText.WrappedText.Count)
          else
            lbLinesFit := True;

          while not(lbLinesFit) and (Abs(FCanvas.Font.Height) > 1) do
            begin
              if liLeading > 0 then
                Dec(liLeading)

              else
                begin
                  {decrease height of font by one pixel }
                  if FCanvas.Font.Height > 0 then

                    FCanvas.Font.Height := FCanvas.Font.Height - 1
                  else
                    FCanvas.Font.Height := FCanvas.Font.Height + 1;

                  GetTextMetrics(FCanvas.Handle, lTextMetric);
                end;

              liLineHeight := lTextMetric.tmHeight + liLeading;

              if (liLineHeight <= 0) then
                liLineHeight := 1;

              lbLinesFit := liLineHeight <= Trunc((lDrawRect.Bottom - lDrawRect.Top) / aDrawText.WrappedText.Count);
           end; {while, lines don't fit}

        end; {check to see if lines fit}

    end; {if, memo & linecound > 1) }

  if (liLineHeight <= 0) then
    liLineHeight := 1;

  if not(lbLinesFit) then
    liLines := Trunc((lDrawRect.Bottom - lDrawRect.Top) / liLineHeight);


  if Abs(FCanvas.Font.Height) < 1 then
    begin
      if FCanvas.Font.Height > 0 then
        FCanvas.Font.Height := 1

      else
        FCanvas.Font.Height := -1;

      lbTruncTheText := True;
    end;

  lSourceText := TStringList.Create;

  if aDrawText.WordWrap then
    lSourceText.Assign(aDrawText.WrappedText)

  else if (Length(aDrawText.Text) > 0) then
    begin
      lSourceText.Add(aDrawText.Text);

      liLines := 0;
    end;

  {set rectangle to original value}
  lCalcRect := lDrawRect;


  {calculate rectangle width based on longest text}
  if aDrawText.AutoSize then
    begin
      liMaxWidth := 0;

      {calc max line width}
      for liLine := 0 to liLines do
        begin
          lsLine := lSourceText[liLine];

          liPos := Pos(TppTextMarkups.EOP, lsLine);

          if (liPos <> 0) then
            lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);

          liTextWidth  := TppPlainText.GetTabbedTextWidth(FCanvas, lsLine, liTabStopCount, lTabStopArray);

          if (liPos <> 0) then
            lsLine := lsLine + TppTextMarkups.EOP;

          if liTextWidth > liMaxWidth then
            liMaxWidth := liTextWidth;
        end;

      if aDrawText.Border.Visible then
        begin
          if [bpLeft, bpRight] <= aDrawText.Border.BorderPositions then
            liMaxWidth := liMaxWidth + (2 * liBorderOffset)
          else if (bpLeft in aDrawText.Border.BorderPositions) or (bpRight in aDrawText.Border.BorderPositions) then
            liMaxWidth := liMaxWidth + liBorderOffset;
        end;

      liWidthAvailable := (lCalcRect.Right - lCalcRect.Left);

      {if text wider than rectangle, adjust rectangle}
      if (liMaxWidth <> liWidthAvailable) then
        begin

          {adjust rectangle}
          if aDrawText.Alignment = taLeftJustify then
            lCalcRect.Right := lCalcRect.Left + liMaxWidth

          else if aDrawText.Alignment = taRightJustify then
            lCalcRect.Left := lCalcRect.Right - liMaxWidth

          else if aDrawText.Alignment = taCenter then
            begin
              lCalcRect.Left  := lCalcRect.Left + Round((liWidthAvailable - liMaxWidth) / 2);
              lCalcRect.Right := lCalcRect.Left + liMaxWidth;
            end;

        end; {text wider than rectangle}

    end; {if, AutoSize}


  {fill rectangle with background color}
  if not(aDrawText.Transparent) then
    begin
      FCanvas.Brush.Color := aDrawText.Color;
      FCanvas.Brush.Style := bsSolid;
      FCanvas.FillRect(lCalcRect);
    end;

  FCanvas.Brush.Style := bsClear;

  liLineSpaceUsed := 0;

  lbFullJustification := False;

  for liLine := 0 to liLines do
    begin
      lsLine := lSourceText[liLine];

      liWidthAvailable := (lCalcRect.Right - lCalcRect.Left);

      {reset rectangle to original value}
      lRect := lCalcRect;

      lRect.Top := lRect.Top + liLineSpaceUsed;

      liTop := lRect.Top;

      {justify text}
      if (aDrawText.TextAlignment = taFullJustified) then
        begin
          liStart := lRect.Left;

          if aDrawText.ForceJustifyLastLine or (Pos(TppTextMarkups.EOP, lsLine) = 0) then
            begin
              if (Pos(TppTextMarkups.EOP, lsLine) <> 0) and (Pos(TppTextMarkups.Space, Trim(lsLine)) = 0) then
                begin
                  lbFullJustification := False;
                  SetTextJustification(FCanvas.Handle, 0, 0);
                  lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
                end
              else
                begin
                  if (aDrawText.Border.Visible) then
                    begin
                      if (bpLeft in aDrawText.Border.BorderPositions) then
                        lRect.Left := lRect.Left + liBorderOffset;
                      if (bpRight in aDrawText.Border.BorderPositions) then
                        lRect.Right := lRect.Right - liBorderOffset;
                    end;

                  lbFullJustification := True;
                  TppPlainText.SetCanvasToJustify(FCanvas, lRect, lsLine, liTabStopCount, lTabStopArray);
                  lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
                end;
            end

          else
            begin
              lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
              SetTextJustification(FCanvas.Handle, 0, 0);
            end;
        end

      else
        begin
          liTextWidth := TppPlainText.GetTabbedTextWidth(FCanvas, lsLine, liTabStopCount, lTabStopArray);

          if aDrawText.TextAlignment = taLeftJustified then
            liStart := lRect.Left

          else if aDrawText.TextAlignment = taRightJustified then
            liStart := lRect.Right - liTextWidth

          else if aDrawText.TextAlignment = taCentered then
            liStart := lRect.Left + Round( ( (liWidthAvailable - liTextWidth) / 2) - 0.5)

          else
            liStart := 0;

        end;

      {Adjust for borders}
      if aDrawText.Border.Visible then
        begin
          if aDrawText.IsMemo then
            liBorderBuffer := Round(ppToScreenPixels(0.5, utMillimeters, pprtHorizontal, nil) * FScale);

          if (bpTop in aDrawText.Border.BorderPositions) then
            liTop := liTop + liBorderOffset;

          if (bpLeft in aDrawText.Border.BorderPositions) and (aDrawText.TextAlignment = taLeftJustified) or
             (aDrawText.TextAlignment = taFullJustified) then
            liStart := liStart + liBorderOffset + liBorderBuffer;

          if (bpRight in aDrawText.Border.BorderPositions) and (aDrawText.TextAlignment = taRightJustified) then
            liStart := liStart - liBorderOffset - liBorderBuffer;

        end;

      {draw the text}
      if aDrawText.IsMemo and not(lbTruncTheText) then
        begin
          lLineBuf := StrAlloc(Length(lsLine) + 1);
          StrPCopy(lLineBuf, lsLine);
          TabbedTextOut(FCanvas.Handle, liStart, liTop, lLineBuf, StrLen(lLineBuf), liTabStopCount, lTabStopArray, liStart);
          StrDispose(lLineBuf);
        end

      else
        begin
          if aDrawText.AutoSize and not(aDrawText.IsMemo) then
            FCanvas.TextOut(liStart, liTop, lsLine)
          else
            FCanvas.TextRect(lRect, liStart, liTop, lsLine);
        end;

      {goto next line}
      Inc(liLineSpaceUsed, liLineHeight);

    end; {for, each line of text}

  {must clear full justification mode or GetTabbedTextWidth will fail next time.}
  if (lbFullJustification) then
    SetTextJustification(FCanvas.Handle, 0, 0);

  lSourceText.Free;

  {update size of draw rect}
  if aDrawText.AutoSize then
    begin
      aDrawText.DrawLeft   := lCalcRect.Left;
      aDrawText.DrawRight  := lCalcRect.Right;
      if aDrawText.Border.Visible then
        begin
          if [bpTop, bpBottom] <= aDrawText.Border.BorderPositions then
            aDrawText.DrawBottom := aDrawText.DrawTop + liLineSpaceUsed + (2 * liBorderOffset)
          else if (bpTop in aDrawText.Border.BorderPositions) or (bpBottom in aDrawText.Border.BorderPositions) then
            aDrawText.DrawBottom := aDrawText.DrawTop + liLineSpaceUsed + liBorderOffset;
        end
      else
        aDrawText.DrawBottom := aDrawText.DrawTop + liLineSpaceUsed;
    end;

  {used to support preview form searching}
  aDrawText.DeviceFontHeight := FCanvas.Font.Height;
  aDrawText.DeviceLineHeight := ppToMMThousandths(liLineHeight, utScreenPixels, pprtVertical, nil);
  aDrawText.DeviceLineWidth :=  ppToMMThousandths(liWidthAvailable, utScreenPixels, pprtHorizontal, nil);

  if aDrawText.IsMemo then
    liDescent := lTextMetric.tmDescent
  else
    liDescent := 0;

  {Add borders if needed}
  if aDrawText.Border.Visible then
    DrawBorder(aDrawText, Rect(aDrawText.DrawLeft, aDrawText.DrawTop, aDrawText.DrawRight, aDrawText.DrawBottom + liDescent));

end; {procedure, DrawStandardText}

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.AddWaterMark }

procedure TppGraphicsDevice.AddWaterMark(aPage: TppPage);
var
  lWaterMark: TppDrawText;
begin

  if not(ppValidDate) then
    begin
      lWaterMark := TppDrawText.Create(aPage);
      lWaterMark.WrappedText.Add('** ReportBuilder ' + ppEdition + ' ' + ppVersion + #153 + ' ** Demo Copy  ** www.digital-metaphors.com **');
      lWaterMark.Transparent := False;
      lWaterMark.IsMemo      := False;
      lWaterMark.WordWrap    := True;
      lWaterMark.Font.Name   := 'Arial';
      lWaterMark.Font.Size   := 12;
      lWaterMark.Font.Style  := [fsBold];
      lWaterMark.Autosize    := False;
      lWaterMark.TextAlignment := taLeftJustified;

      lWaterMark.Color := clYellow;
      lWaterMark.Font.Color  := clRed;

      lWaterMark.Top  := ppToMMThousandths(1, utScreenPixels, pprtHorizontal, nil);
      lWaterMark.Left := ppToMMThousandths(2, utScreenPixels, pprtHorizontal, nil);

      lWaterMark.Height := ppToMMThousandths(20, utScreenPixels, pprtHorizontal, nil);
      lWaterMark.Width  := aPage.PageDef.mmWidth - ppToMMThousandths(4, utScreenPixels, pprtHorizontal, nil);

      lWaterMark.Page := aPage;

    end;

end; {procedure, AddWaterMark}

procedure TppGraphicsDevice.FillGradient(aDrawShape: TppDrawShape);
var
  lRect: TRect;
  lCorner: TPoint;
  liXCornerRound: Integer;
  liYCornerRound: Integer;
begin

  lRect := Rect(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom);

  liXCornerRound := Trunc(ppFromMMThousandths(aDrawShape.XCornerRound, utScreenPixels, pprtHorizontal, nil));
  liYCornerRound := Trunc(ppFromMMThousandths(aDrawShape.YCornerRound, utScreenPixels, pprtVertical, nil));

  liXCornerRound := Round(liXCornerRound * FScale);
  liYCornerRound := Round(liYCornerRound * FScale);

  lCorner := Point(liXCornerRound, liYCornerRound);

  TppGradient.FillGradient(FCanvas, aDrawShape.Gradient, aDrawShape.ShapeType, lRect, lCorner);

end;

procedure TppGraphicsDevice.SetCanvas(aCanvas: TCanvas);
begin
  FCanvas.Assign(aCanvas);

end;

procedure TppGraphicsDevice.SetScale(const Value: Double);
begin
  FScale := Value;
  CalculateScaledPageSize;
end;

{------------------------------------------------------------------------------}
{ TppGraphicsDevice.RenderRectangle }

{procedure TppGraphicsDevice.RenderRectangle(aDrawShape: TppDrawShape);
var
  liSize: Integer;
  liPosition: Integer;
begin

  aDrawShape.DrawBottom := aDrawShape.DrawBottom - 1;
  aDrawShape.DrawRight := aDrawShape.DrawRight - 1;

  if FCanvas.Pen.Width = 0 then
    liSize := 1
  else
    liSize := FCanvas.Pen.Width;

  FCanvas.Pen := aDrawShape.Pen;
  FCanvas.Pen.Width := 1;

 if not(aDrawShape.Brush.Style = bsClear) then
   begin
     {Assign background color behind brush pattern}
     {SetBkMode(FCanvas.Handle, OPAQUE);
     SetBkColor(FCanvas.Handle, $00FFFFFF);

     FCanvas.FillRect(Rect(aDrawShape.DrawLeft, aDrawShape.DrawTop, aDrawShape.DrawRight, aDrawShape.DrawBottom));
   end;

  for liPosition := 0 to liSize - 1 do
    begin
      FCanvas.MoveTo(aDrawShape.DrawLeft, aDrawShape.DrawTop + liPosition);
      FCanvas.LineTo(aDrawShape.DrawRight, aDrawShape.DrawTop + liPosition);

      FCanvas.MoveTo(aDrawShape.DrawRight - liPosition, aDrawShape.DrawTop);
      FCanvas.LineTo(aDrawShape.DrawRight - liPosition, aDrawShape.DrawBottom);

      FCanvas.MoveTo(aDrawShape.DrawLeft, aDrawShape.DrawBottom - liPosition);
      FCanvas.LineTo(aDrawShape.DrawRight, aDrawShape.DrawBottom - liPosition);

      FCanvas.MoveTo(aDrawShape.DrawLeft + liPosition, aDrawShape.DrawTop);
      FCanvas.LineTo(aDrawShape.DrawLeft + liPosition, aDrawShape.DrawBottom);

    end;

end; {procedure, RenderRectangle}

end.
