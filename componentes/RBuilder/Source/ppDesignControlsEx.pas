{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                    BBBBB   }

unit ppDesignControlsEx;

interface

{$I ppIfDef.pas}


uses
  Types,
  Messages,
  Graphics,
  Classes,
  Controls,
  ExtCtrls,
  StdCtrls,

  ppDrwCmd,
  ppPlainText,
  ppClass,
  ppDesignControls,
  ppTypes,
  ppPrnDev,
  ppPrintr,
  ppUtils,
  ppDesignEventHub;

type

  {@RBuilder.Vcl.DesignControlsEx.TppPrintableControl}
  TppPrintableControl = class(TppDesignControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppCustomComponentControl}
  TppCustomComponentControl = class(TppPrintableControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;

  end;


  {@RBuilder.Vcl.DesignControlsEx.TppCustomImageControl}
  TppCustomImageControl = class(TppCustomComponentControl)
    private
      procedure DrawBorder(aCanvas: TCanvas; aBorder: TppBorder; aRect: TRect);
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppShapeControl}
  TppShapeControl = class(TppCustomComponentControl)
    private
{$IFDEF NewRect}
      procedure RenderRectangle(aCanvas: TCanvas; aRect: TRect);
{$ENDIF}
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppLineControl}
  TppLineControl = class(TppCustomComponentControl)
    protected
      function CanOptimizeDesignPainting: Boolean; override;
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppImageControl}
  TppImageControl = class(TppCustomImageControl)
    public
      constructor Create(AOwner: TComponent); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppDBImageControl}
  TppDBImageControl = class(TppCustomImageControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppCustomMemoControl}
  TppCustomMemoControl = class(TppPrintableControl)
    private
      function FitLinesToHeight(aLines: TStrings; aLineHeight: Integer; aHeight: Integer): Integer;
      function RetrieveMMRectangle: TppRect;

    protected
      function CanOptimizeDesignPainting: Boolean; override;
      procedure PaintDesignControl(aCanvas: TCanvas); override;

  end;

  {@RBuilder.Vcl.DesignControlsEx.TppCustomTextControl}
  TppCustomTextControl = class(TppCustomComponentControl)
    private
      procedure DrawRotatedText(aCanvas: TCanvas);

    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;

      function CanOptimizeDesignPainting: Boolean; override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppLabelControl}
  TppLabelControl = class(TppCustomTextControl)
  protected
    procedure DblClick; override;
    procedure Edit;
  end;


  {TppDBTextControl}
  TppDBTextControl = class(TppCustomTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppVariableControl}
  TppVariableControl = class(TppCustomTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppSystemVariableControl}
  TppSystemVariableControl = class(TppCustomTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppDBCalcControl}
  TppDBCalcControl = class(TppCustomTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppMemoControl}
  TppMemoControl = class(TppCustomMemoControl)
  protected
    procedure DblClick; override;
    procedure Edit;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppDBMemoControl}
  TppDBMemoControl = class(TppCustomMemoControl)
  end;

  {@RBuilder.Vcl.DesignControlsEx.TppPageBreakControl}
  TppPageBreakControl = class(TppDesignControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
      procedure SetComponent(aComponent: TppComponent); override;

    public
      constructor Create(AOwner: TComponent); override;

    end;


  {@RBuilder.Vcl.DesignControlsEx.TppCustomRegionControl}
  TppCustomRegionControl = class(TppPrintableControl)
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;

  end;


  {@RBuilder.Vcl.DesignControlsEx.TppRegionControl}
  TppRegionControl = class(TppCustomRegionControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppCustomRichTextControl}
  TppCustomRichTextControl = class(TppPrintableControl)
    private
      FMetaFile: TMetaFile;
      FSaveWidth: Integer;
      FSaveHeight: Integer;

      procedure DrawToMetaFile;
      procedure SetMetaFileSize(aWidth, aHeight: Integer; aPrinter: TppPrinter);
      
    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;

    public
      constructor Create(aOwner: TComponent); override;
      destructor Destroy; override;
      
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppRichTextControl}
  TppRichTextControl = class(TppCustomRichTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppDBRichTextControl}
  TppDBRichTextControl = class(TppCustomRichTextControl)
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppSubreportControl}
  TppSubreportControl = class(TppCustomComponentControl)
  end;

  {TppCustomBarCodeControl}
  TppCustomBarCodeControl = class(TppCustomComponentControl)
    private
      procedure DrawBarCode(aCanvas: TCanvas);

    protected
      procedure PaintDesignControl(aCanvas: TCanvas); override;
  end;


  {@RBuilder.Vcl.DesignControlsEx.TppBarCodeControl}
  TppBarCodeControl = class(TppCustomBarCodeControl)
    protected
      function CanOptimizeDesignPainting: Boolean; override;

  end;


  {@RBuilder.Vcl.DesignControlsEx.TppDBBarCodeControl}
  TppDBBarCodeControl = class(TppCustomBarCodeControl)
  end;


  {TppInPlaceEditorText}
  TppInPlaceEditorText = class
  private
    FDesignControl: TppDesignControl;
    FEdit: TMemo;
    FComponent: TppComponent;
    FTextWrapper: TppPlainTextWrapper;
    FUpdateCounter: Integer;
    
    function GetEventHub: TppDesignEventHub;
    function GetUpdating: Boolean;
    procedure ehComponent_AfterProperyChange(aSender, aEventParams: TObject);
    procedure FreeEditControl;

  protected
    procedure ehEdit_Exit(Sender: TObject); virtual;
    procedure ehEdit_KeyPress(Sender: TObject; var Key: Char); virtual;
    procedure ehEdit_KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure ehEdit_MouseLeave(Sender: TObject); virtual;
    procedure ehEdit_Change(Sender: TObject); virtual;
    procedure ehEdit_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;

    procedure BeginEdit(aControl: TppDesignControl); virtual;
    function CalcNearestWordBreak(aCharPos: Integer): Integer;  virtual;
    procedure CreateEditControl; virtual;
    procedure EndEdit; virtual;
    function GetComponentText: String; virtual;
    procedure InitializeTextWrapper; virtual;
    procedure SetComponentText(aText: String); virtual;
    procedure ShowEditControl; virtual;
    procedure SyncEditProps; virtual;
    procedure UpdateBounds; virtual;

    property EventHub: TppDesignEventHub read GetEventHub;
    property Updating: Boolean read GetUpdating;

  public
    constructor Create;
    destructor Destroy; override;

    procedure BeginUpdate;
    procedure EndUpdate;

    class procedure Execute(aDesignControl: TppDesignControl);
  end;


implementation

uses
  Windows,
  Forms,
  ComCtrls,
  RichEdit,
  SysUtils,

  ppBarCod,
  ppBarCodDrwCmd,
  ppCtrls,
  ppRTTI,
  ppMemo,
  ppPrnabl,
  ppRegion,
  ppSubRpt,
  ppRichTx,
  ppRichTxDrwCmd,
  ppRotatedText,
  ppVar,
  ppViewr;


{******************************************************************************
 *
 ** P R I N T A B L E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

{@RBuilder.Vcl.DesignControlsEx.TppPrintableControl.PaintDesignControl

 Called each time the DesignControl for the component needs to be painted.  This
 method is overriden by the descendant so that the appropriate visual
 representation of the component can be made in the Report Designer.}

procedure TppPrintableControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lbTransparent: Boolean;
  lsCaption : String;
  lFont: TFont;
  lAlignment: TAlignment;
  lTextAlignment: TppTextAlignment;
  lBorder: TppBorder;
begin

  lBorder := nil; //Initialize component reference.

  GetPropValue('Alignment', lAlignment);
  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Caption', lsCaption);
  GetPropValue('Font', lFont);
  GetPropValue('Border', lBorder);

  lClientRect := ClientRect;

  {draw the background}
  if not(lbTransparent) then
    PaintBackground(aCanvas, lClientRect, lBorder, GetColor);

  aCanvas.Font := lFont;

  lTextAlignment := AlignmentToTextAlignment(lAlignment);

  if (lBorder <> nil) and (lBorder.Visible) then
      lClientRect := AdjustObject(lBorder, lClientRect, lTextAlignment);

  {draw the caption}
  aCanvas.TextRect(lClientRect, lClientRect.Left, lClientRect.Top, lsCaption);

  {draw a framerect}
  PaintFrame(aCanvas);

end;


{******************************************************************************
 *
 ** C U S T O M  C O M P O N E N T  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppCustomComponentControl.PaintDesignControl(aCanvas: TCanvas);
  const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps:  array[Boolean] of Word = (0, DT_WORDBREAK);

 var
  lClientRect : TRect;
  lFlags: Word;
  lCanvas: TCanvas;
  lbTransparent: Boolean;
  lAlignment: TAlignment;
  lTextAlignment: TppTextAlignment;
  lBorder: TppBorder;
  lbWordWrap: Boolean;
  lsCaption: String;
  lFont: TFont;
begin

  if not (pppcDesigning in Component.DesignState) or (Component.Printing) then Exit;

  if IsValidPropName('Transparent') then
    GetPropValue('Transparent', lbTransparent)
  else
    lbTransparent := False;

  lBorder := nil; // initialize object reference

  GetPropValue('Alignment', lAlignment);
  GetPropValue('WordWrap', lbWordWrap);
  GetPropValue('Caption', lsCaption);
  GetPropValue('Font', lFont);
  GetPropValue('Border', lBorder);

  lCanvas := aCanvas;
  lClientRect := ClientRect;

  {draw background}
  if not lbTransparent then
    PaintBackground(lCanvas, lClientRect, lBorder, GetColor);

  lCanvas.Brush.Style := bsClear;
  lCanvas.Font := lFont;

  lTextAlignment := AlignmentToTextAlignment(lAlignment);

  if (lBorder <> nil) and (lBorder.Visible) then
    lClientRect := AdjustObject(lBorder, lClientRect, lTextAlignment);

  {draw text}
  lFlags := DT_EXPANDTABS or Alignments[lAlignment] or WordWraps[lbWordWrap] or DT_NOPREFIX or DT_TOP or DT_EXTERNALLEADING;

  if (lsCaption <> '') then
    DrawText(lCanvas.Handle, PChar(lsCaption), Length(lsCaption), lClientRect, lFlags);

  {draw a framerect}
  PaintFrame(aCanvas);

end;


{******************************************************************************
 *
 ** C U S T O M  I M A G E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppCustomImageControl.DrawBorder(aCanvas: TCanvas; aBorder: TppBorder; aRect: TRect);
var
  liOffset: Integer;
  liLineWidth: Integer;
  lBorderPositions: TppBorderPositions;
  liBuffer: Integer;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
begin

  liLineWidth := aBorder.SPWeight;
  liBuffer := 1;
  lBorderPositions := aBorder.BorderPositions;

  liLeft := aRect.Left + liBuffer;
  liTop := aRect.Top + liBuffer;
  liRight := aRect.Right - liBuffer;
  liBottom := aRect.Bottom - liBuffer;

  aCanvas.Pen.Style := aBorder.Style;
  aCanvas.Pen.Width := 1;
  aCanvas.Pen.Color := aBorder.Color;

  for liOffset := 0 to liLineWidth - 1 do
    begin
      if bpLeft in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft + liOffset, liTop);
          aCanvas.LineTo(liLeft + liOffset, liBottom);
        end;

      if bpTop in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft, liTop + liOffset);
          aCanvas.LineTo(liRight, liTop + liOffset);
        end;

      if bpRight in lBorderPositions then
        begin
          aCanvas.MoveTo(liRight - liOffset, liTop);
          aCanvas.LineTo(liRight - liOffset, liBottom + 1);
        end;

      if bpBottom in lBorderPositions then
        begin
          aCanvas.MoveTo(liLeft, liBottom - liOffset);
          aCanvas.LineTo(liRight, liBottom - liOffset);
        end;

    end;
end;

procedure TppCustomImageControl.PaintDesignControl(aCanvas: TCanvas);
var
  lRect: TRect;
  lPicture: TPicture;
  lsCaption: String;
  lbTransparent: Boolean;
  lbStretch: Boolean;
  lbMaintainAspectRatio: Boolean;
  lBorder: TppBorder;
  liX: Integer;
  liY: Integer;
  liHeight: Integer;
  liWidth: Integer;
  lClientRect: TRect;
  lfScale: Single;
  liScaledWidth: Integer;
  liScaledHeight: Integer;
  lAlignHorizontal: TppAlignHorizontalType;
  lAlignVertical: TppAlignVerticalType;
  lSaveClipRgn: HRGN;
  lNewClipRgn: HRGN;
begin

  lBorder := nil; //Initialize component reference.

  GetPropValue('Picture', lPicture);
  GetPropValue('Caption', lsCaption);
  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Stretch', lbStretch);
  GetPropValue('MaintainAspectRatio', lbMaintainAspectRatio);
  GetPropValue('Border', lBorder);
  GetPropValue('AlignHorizontal', lAlignHorizontal);
  GetPropValue('AlignVertical', lAlignVertical);

  lClientRect := ClientRect;

  if (lPicture.Graphic = nil) or (lPicture.Graphic.Empty) then
    begin

      {draw the background}
      if not lbTransparent then
        PaintBackground(aCanvas, lClientRect, lBorder, GetColor);

      {draw frame rect}
      if FrameStyle = fsDashed then
        aCanvas.Pen.Style := psDash
      else
        aCanvas.Pen.Style := psDot;

      aCanvas.Pen.Color   := clDkGray;
      aCanvas.Brush.Style := bsClear;
      aCanvas.Rectangle(0, 0, Width, Height);

      {center caption within frame}
      aCanvas.Font := Component.Font;
      lsCaption := '(' + lsCaption + ')';
      liWidth  := aCanvas.TextWidth(lsCaption);
      liHeight := aCanvas.TextHeight(lsCaption);
      liX      := (ClientRect.Right - liWidth) div 2;
      liY      := (ClientRect.Bottom - liHeight) div 2;
      aCanvas.TextRect(ClientRect, liX, liY, lsCaption);

    end
  else

    begin

      {create workspace}
      lSaveClipRgn := 0;
      GetClipRgn (aCanvas.Handle, lSaveClipRgn);

      {set clipping region}
      lNewClipRgn  := CreateRectRgnIndirect(lClientRect);
      SelectClipRgn (aCanvas.Handle, lNewClipRgn);

      {draw image}

      if lbStretch and lbMaintainAspectRatio then
        begin
          lRect := ClientRect;

          lfScale := ppCalcAspectRatio(lPicture.Width, lPicture.Height, Width, Height);

          { Calc scaled width and scaled height }
          liScaledWidth  := Trunc(lPicture.Width  * lfScale);
          liScaledHeight := Trunc(lPicture.Height * lfScale);

          case lAlignHorizontal of
            ahCenter: lRect.Left := lRect.Left + ((Width  - liScaledWidth)  div 2);
            ahRight: lRect.Left := lRect.Left + (Width  - liScaledWidth);
          end;

          case lAlignVertical of
            avCenter: lRect.Top  := lRect.Top  + ((Height - liScaledHeight) div 2);
            avBottom: lRect.Top  := lRect.Top  + (Height - liScaledHeight);
          end;

          lRect.Right   := lRect.Left   + liScaledWidth;
          lRect.Bottom  := lRect.Top    + liScaledHeight;

        end
      else if lbStretch then
        lRect := ClientRect
      else if (lAlignHorizontal <> ahLeft) or (lAlignVertical <> avTop) then
        begin
          case lAlignHorizontal of
            ahLeft: lRect.Left := 0;
            ahCenter: lRect.Left := (Width - lPicture.Width) div 2;
            ahRight: lRect.Left := (Width - lPicture.Width);
          end;

          case lAlignVertical of
            avTop: lRect.Top := 0;
            avCenter: lRect.Top  := (Height - lPicture.Height) div 2;
            avBottom: lRect.Top  := (Height - lPicture.Height);
          end;

          lRect.Right := lRect.Left + lPicture.Width;
          lRect.Bottom := lRect.Top + lPicture.Height;

        end
      else
        lRect := Rect(0, 0, lPicture.Width, lPicture.Height);

      if lbTransparent then
        aCanvas.CopyMode := cmSrcAnd
      else
        aCanvas.CopyMode := cmSrcCopy;

      aCanvas.StretchDraw(lRect, lPicture.Graphic);


      {restore clipping region}
      SelectClipRgn(aCanvas.Handle, lSaveClipRgn);

      DeleteObject(lNewClipRgn);

  end;

  if (lBorder <> nil) and (lBorder.Visible) then
    DrawBorder(aCanvas, lBorder, lRect);

end;

{******************************************************************************
 *
 ** S H A P E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppShapeControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  llXCornerRound: Longint;
  llYCornerRound: Longint;
  liLeft: Integer;
  liTop: Integer;
  liRight: Integer;
  liBottom: Integer;
  lBrush: TBrush;
  lPen: TPen;
  lGradient: TppGradient;
  lShapeType: TShapeType;
  lLogBrush: TLogBrush;
  lRect: TRect;
  lCorner: TPoint;
begin

  GetPropValue('Pen', lPen);
  GetPropValue('Brush', lBrush);
  GetPropValue('Shape', lShapeType);
  GetPropValue('Gradient', lGradient);

  lClientRect := ClientRect;

  {assign pen and brush}
  aCanvas.Pen   := lPen;
  aCanvas.Brush := lBrush;

   if (aCanvas.Pen.Style <> psSolid) and (aCanvas.Pen.Width > 1) then
     begin
       lLogBrush.lbStyle := Ord(bsSolid);
       lLogBrush.lbColor := aCanvas.Pen.Color;
       lLogBrush.lbHatch := 0;
       aCanvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or Ord(aCanvas.Pen.Style), aCanvas.Pen.Width, lLogBrush, 0, nil);
     end;


  TppShape(Component).CalcDimensions(liLeft, liTop, liRight, liBottom, llXCornerRound, llYCornerRound);
  lRect := Rect(liLeft, liTop, liRight, liBottom);
  lCorner := Point(llXCornerRound, llYCornerRound);

  if lGradient.Style <> gsNone then
    TppGradient.FillGradient(aCanvas, lGradient, lShapeType, lRect, lCorner);

  {draw shape}
  case lShapeType of

    stRectangle, stSquare:
{$IFDEF NewRect}
      if TppShape(Component).OldStyle then
        aCanvas.Rectangle(liLeft, liTop, liRight, liBottom)
      else
        RenderRectangle(aCanvas, lRect);
{$ELSE}
        aCanvas.Rectangle(liLeft, liTop, liRight, liBottom);

{$ENDIF}

    stCircle, stEllipse:
      aCanvas.Ellipse(liLeft, liTop, liRight, liBottom);

    stRoundRect, stRoundSquare:
      aCanvas.RoundRect(liLeft, liTop, liRight, liBottom, llXCornerRound, llYCornerRound);

  end; {case, ShapeType}

end;

{$IFDEF NewRect}

{------------------------------------------------------------------------------}
{ TppShapeControl.RenderRectangle }

procedure TppShapeControl.RenderRectangle(aCanvas: TCanvas; aRect: TRect);
var
  liSize: Integer;
  liPosition: Integer;
begin

  aRect.Bottom := aRect.Bottom - 1;
  aRect.Right := aRect.Right - 1;

  if aCanvas.Pen.Width = 0 then
    liSize := 1
  else
    liSize := aCanvas.Pen.Width;

  aCanvas.Pen.Width := 1;

 if (aCanvas.Brush.Style <> bsClear) then
   begin
     {Assign background color behind brush pattern}
     SetBkMode(aCanvas.Handle, OPAQUE);
     SetBkColor(aCanvas.Handle, $00FFFFFF);

     aCanvas.FillRect(aRect);
   end;

  for liPosition := 0 to liSize - 1 do
    begin
      aCanvas.MoveTo(aRect.Left, aRect.Top + liPosition);
      aCanvas.LineTo(aRect.Right, aRect.Top + liPosition);

      aCanvas.MoveTo(aRect.Right - liPosition, aRect.Top);
      aCanvas.LineTo(aRect.Right - liPosition, aRect.Bottom);

      aCanvas.MoveTo(aRect.Left, aRect.Bottom - liPosition);
      aCanvas.LineTo(aRect.Right, aRect.Bottom - liPosition);

      aCanvas.MoveTo(aRect.Left + liPosition, aRect.Top);
      aCanvas.LineTo(aRect.Left + liPosition, aRect.Bottom);

    end;

end; {procedure, RenderRectangle}
{$ENDIF}

{******************************************************************************
 *
 ** L I N E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

function TppLineControl.CanOptimizeDesignPainting: Boolean;
var
  lPen: TPen;
begin

  GetPropValue('Pen', lPen);

  {when pen color is white, cannot optimize design control painting}
  Result := (lPen.Color <> clWhite);

end;

procedure TppLineControl.PaintDesignControl(aCanvas: TCanvas);
var
  liLine: Integer;
  liLines: Integer;
  liOffset: Integer;
  liSize: Integer;
  liPosition: Integer;
  liPenWidth: Integer;
  liWidth: Integer;
  liHeight: Integer;
  lWeight: Single;
  lPosition: TppLinePositionType;
  lStyle: TppLineStyleType;
  lPen: TPen;
begin

  GetPropValue('Weight', lWeight);
  GetPropValue('Position', lPosition);
  GetPropValue('Style', lStyle);
  GetPropValue('Pen', lPen);

  liPenWidth := Round(lWeight * Screen.PixelsPerInch / 72);

  {get pen width}
  if (liPenWidth = 0) then
    liSize := 1
  else
    liSize := liPenWidth;

  liHeight := Height;
  liWidth  := Width;

  {when draiwing bottom line, decrease the height by one pixel, otherwise
   the line is drawn outside the bounds of the control}
  if lPosition = TppLinePositionType(lpBottom) then
    Dec(liHeight);

  {when draiwing right line, decrease the width by one pixel, otherwise
  the line is drawn outside the bounds of the control}
  if lPosition = TppLinePositionType(lpRight) then
    Dec(liWidth);

  {how many lines to draw?}
  if lStyle = lsSingle then
    liLines := 1
  else
    liLines := 2;

  {setting brush to cross causes LineTo to honor the penstyle}
  aCanvas.Brush.Style := bsCross;

  {set pen width to 1 for drawing - need to honor the penstyle}
  aCanvas.Pen := lPen;
  aCanvas.Pen.Width := 1;

  for liLine := 1 to liLines do

    begin

      if (liLine = 1) then
        liOffset := 0
      else
        liOffset := liSize * 2;

      for liPosition := 0 to liSize - 1 do

      {set print object moveto/lineto positions}
      case lPosition of
        lpTop:
          begin
            aCanvas.MoveTo(0, 0 + liOffset + liPosition);
            aCanvas.LineTo(liWidth, 0 + liOffset + liPosition);
          end;

        lpBottom:
          begin
            aCanvas.MoveTo(0, liHeight - liOffset - liPosition);
            aCanvas.LineTo(liWidth, liHeight - liOffset - liPosition);
          end;

        TppLinePositionType(lpLeft):
          begin
            aCanvas.MoveTo(0 + liOffset + liPosition, 0);
            aCanvas.LineTo(0 + liOffset + liPosition, liHeight);
          end;

        TppLinePositionType(lpRight):
          begin
            aCanvas.MoveTo(liWidth - liOffset - liPosition, 0);
            aCanvas.LineTo(liWidth - liOffset - liPosition, liHeight);
          end;

        TppLinePositionType(lpDiagLeft):
          begin
            aCanvas.MoveTo(0 + liOffset + liPosition, 0);
            aCanvas.LineTo(liWidth + liOffset + liPosition, liHeight);
          end;

        TppLinePositionType(lpDiagRight):
          begin
            aCanvas.MoveTo(liWidth - liOffset - liPosition, 0);
            aCanvas.LineTo(0 - liOffset - liPosition, liHeight);
          end;

      end; {case, line style}

   end; {for, each line}

end;


{******************************************************************************
 *
 ** D B I M A G E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppDBImageControl.PaintDesignControl(aCanvas: TCanvas);
begin
  TraRTTI.CallMethod(Component, 'LoadPicture', nil, True);

  inherited;

end;


{******************************************************************************
 *
 ** C U S T O M  M E M O  D E S I G N  C O N T R O L
 *
{******************************************************************************}

function TppCustomMemoControl.CanOptimizeDesignPainting: Boolean;
var
  lbTransparent: Boolean;
  lFont: TFont;
begin

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Font', lFont);

  {when transparent and font color is white, cannot optimize design control painting}
  Result := not(lbTransparent and (lFont.Color = clWhite));

end;


procedure TppCustomMemoControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lRect: TRect;
  lsLine: String;
  liLine: Integer;
  liLines: Integer;
  liLineSpaceUsed: Integer;
  liLineHeight: Integer;
  liLeading: Integer;
  lTextMetric: TTextMetric;
  liTabStopCount : Integer;
  lTabStopArray : TppTabStopPos;
  liLeft: Integer;
  liTop: Integer;
  lDrawLines: TStrings;
  lBorder: TppBorder;
  liMmWidth: Integer;
  lmmRect: TppRect;
  liTextWidth: Integer;
  liRowOffset: Integer;
  liCharPos: Integer;
  lbFullJustification: Boolean;
  lbTransparent: Boolean;
  lFont: TFont;
  lMemoStream: TMemoryStream;
  lsCaption: String;
  lLines: TStrings;
  lTextAlignment: TppTextAlignment;
  lbCharWrap: Boolean;
  lLeading: Integer;
  lTabStopPositions: TStrings;
  lbForceJustifyLastLine: Boolean;
begin

  lBorder := nil; //Initialize component reference.

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Font', lFont);
  GetPropValue('MemoStream', lMemoStream);
  GetPropValue('Caption', lsCaption);
  GetPropValue('Lines', lLines);
  GetPropValue('TextAlignment', lTextAlignment);
  GetPropValue('CharWrap', lbCharWrap);
  GetPropValue('mmLeading', lLeading);
  GetPropValue('TabStopPositions', lTabStopPositions);
  GetPropValue('mmWidth', liMmWidth);
  GetPropValue('ForceJustifyLastLine', lbForceJustifyLastLine);
  GetPropValue('Border', lBorder);

  lClientRect := ClientRect;
  
  lDrawLines := TStringList.Create;

  {fill rectangle with background color, do this after calcrect has been calculated}
  if not(lbTransparent) then
    PaintBackground(aCanvas, lClientRect, lBorder, GetColor);

  aCanvas.Brush.Style := bsClear;
  aCanvas.Font := lFont;

  {get text metrics}
  GetTextMetrics(aCanvas.Handle, lTextMetric);

  {Adjust client rectangle for borders}
  if (lBorder <> nil) and (lBorder.Visible) then
    lClientRect := AdjustObject(lBorder, lClientRect, lTextAlignment);


  {draw text}
  if (lMemoStream.Size = 0) then
    aCanvas.TextRect(lClientRect, lClientRect.Left, lClientRect.Top, lsCaption)

  else
    begin
      lmmRect := RetrieveMMRectangle;

      liCharPos := 0;

      TppPlainText.WordWrap(lLines.Text, lmmRect, lTextAlignment, False, lFont, lbCharWrap, lLeading, lTabStopPositions, Component.Report.Printer, liCharPos, lDrawLines);

      liTabStopCount := lTabStopPositions.Count;

      {convert memo tab stop positions to screen units, if needed }
      if (lTabStopPositions.Count > 0) then
        TppPlainText.ConvertTabStopPos(utScreenPixels, lTabStopPositions, lTabStopArray, liTabStopCount, nil);

      {use default leading for this font}
      liLeading := Trunc(ppFromMMThousandths(lLeading, utScreenPixels, pprtVertical, nil));

      liLineHeight := lTextMetric.tmHeight + liLeading;

      liRowOffset := FitLinesToHeight(lDrawLines, liLineHeight, Height);

      liLineSpaceUsed := 0;
      liLines := lDrawLines.Count - 1;
      lbFullJustification := False;

      for liLine := 0 to liLines do
        begin
          lsLine := lDrawLines[liLine];

          {reset rectangle to original value}
          lRect := lClientRect;

          lRect.Top := lRect.Top + liLineSpaceUsed;

          {justify text}
          if (lTextAlignment = taFullJustified) then
            begin
              liLeft := lRect.Left;

              if lbForceJustifyLastLine or (Pos(TppTextMarkups.EOP, lsLine) = 0) then
                begin
                  if (Pos(TppTextMarkups.EOP, lsLine) <> 0) and (Pos(TppTextMarkups.Space, Trim(lsLine)) = 0) then
                    begin
                      lbFullJustification := False;
                      SetTextJustification(aCanvas.Handle, 0, 0);
                      lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
                    end
                  else
                    begin
                      lbFullJustification := True;
                      TppPlainText.SetCanvasToJustify(aCanvas, lRect, lsLine, liTabStopCount, lTabStopArray);
                      lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
                    end;
                end

              else
                begin
                  lbFullJustification := False;
                  SetTextJustification(aCanvas.Handle, 0, 0);
                  lsLine := TppPlainText.StringStrip(lsLine, TppTextMarkups.EOP);
                end;
            end

         else
           begin
              liTextWidth := TppPlainText.GetTabbedTextWidth(aCanvas, lsLine, liTabStopCount, lTabStopArray);

              if lTextAlignment = taLeftJustified then
                liLeft := lRect.Left

              else if lTextAlignment = taRightJustified then
                liLeft := lRect.Right - liTextWidth

              else if lTextAlignment = taCentered then
                liLeft := lRect.Left + Round((Width - liTextWidth) / 2)

              else
                liLeft := 0;
           end;

          liTop := lRect.Top;

          liTextWidth := TppPlainText.GetTabbedTextWidth(aCanvas, lsLine, liTabStopCount, lTabStopArray);

          if (liTextWidth <= liMmWidth) then
            TabbedTextOut(aCanvas.Handle, liLeft, liTop, PChar(lsLine), Length(lsLine), liTabStopCount, lTabStopArray, liLeft)
          else
            aCanvas.TextRect(lRect, liLeft, liTop, lsLine);

          {goto next line}
          Inc(liLineSpaceUsed, liLineHeight - liRowOffset);

        end; {for, each line of text}

      {must clear full justification mode or GetTabbedTextWidth will fail next time.}
      if (lbFullJustification) then
        SetTextJustification(aCanvas.Handle, 0, 0);
    end;

  lDrawLines.Free;


  {draw a framerect}
  PaintFrame(aCanvas);

end;

function TppCustomMemoControl.RetrieveMMRectangle: TppRect;
var
  liMmWidth: Integer;
  liMmHeight: Integer;
begin

  GetPropValue('mmWidth', liMmWidth);
  GetPropValue('mmHeight', liMmHeight);

  Result := ppRect(0, 0, liMmWidth, liMmHeight);

end;

function TppCustomMemoControl.FitLinesToHeight(aLines: TStrings; aLineHeight: Integer; aHeight: Integer): Integer;
var
  liMaxLines: Integer;
begin

  liMaxLines := Trunc(aHeight/aLineHeight);

  if (aLines.Count > liMaxLines) then
    Result := Round(((aLines.Count * aLineHeight) - aHeight) / aLines.Count)
  else
    Result := 0;

end; {procedure, FitLinesToHeight}


{******************************************************************************
 *
 ** C U S T O M  R E G I O N  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppCustomRegionControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  liCount: Integer;
  lPen: TPen;
  lBrush: TBrush;
  lsCaption: String;
begin

  GetPropValue('Pen', lPen);
  GetPropValue('Brush', lBrush);
  GetPropValue('Caption', lsCaption);

  lClientRect := ClientRect;

  {assign pen and brush}
  aCanvas.Pen   := lPen;
  aCanvas.Brush := lBrush;

  aCanvas.Rectangle(lClientRect.Left, lClientRect.Top, lClientRect.Right, lClientRect.Bottom);

  aCanvas.Pen.Style := psSolid;

  for liCount := 0 to 1 do
    begin
      InflateRect(lClientRect, -1, -1);

      aCanvas.Pen.Color := clGray;
      aCanvas.MoveTo(lClientRect.Left, lClientRect.Bottom-2);
      aCanvas.LineTo(lClientRect.Left, lClientRect.Top);
      aCanvas.LineTo(lClientRect.Right-1, lClientRect.Top);

      aCanvas.Pen.Color := clSilver;
      aCanvas.LineTo(lClientRect.Right-1, lClientRect.Bottom-1);
      aCanvas.LineTo(lClientRect.Left-1, lClientRect.Bottom-1);

    end;

  {draw the caption}
  InflateRect(lClientRect, -1, -1);
  aCanvas.TextRect(lClientRect, lClientRect.Left, lClientRect.Top, lsCaption);

end;


{******************************************************************************
 *
 ** C U S T O M  R I C H T E X T  D E S I G N  C O N T R O L
 *
{******************************************************************************}

constructor TppCustomRichTextControl.Create(aOwner: TComponent);
begin
  inherited;

  FMetaFile := TMetaFile.Create;

end;

destructor TppCustomRichTextControl.Destroy;
begin
  FMetaFile.Free;

  inherited;
end;

procedure TppCustomRichTextControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lbTransparent: Boolean;
  lsRichText: String;
  lsCaption: String;
  lBorder: TppBorder;
begin

  lBorder := nil; //Initialize component reference.

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('RichText', lsRichText);
  GetPropValue('Caption', lsCaption);
  GetPropValue('Border', lBorder);

  lClientRect := ClientRect;

  if lbTransparent then
    aCanvas.CopyMode := cmSrcAnd
  else
    aCanvas.CopyMode := cmSrcCopy;

  if (lBorder <> nil) and (lBorder.Visible) then
    lClientRect := AdjustObject(lBorder, lClientRect, taLeftJustified);


  if lsRichText <> '' then
    begin
      DrawToMetafile;


      {draw the metafile to the screen canvas}
      aCanvas.StretchDraw(Rect(lClientRect.Left, lClientRect.Top, lClientRect.Right, lClientRect.Bottom), FMetaFile);
    end
  else
    begin
      if not lbTransparent then
        PaintBackground(aCanvas, lClientRect, lBorder, GetColor);

      if (lBorder <> nil) and (lBorder.Visible) then
        lClientRect := AdjustObject(lBorder, lClientRect, taLeftJustified);

      {draw caption}
      aCanvas.Brush.Style := bsClear;
      aCanvas.TextRect(lClientRect, lClientRect.Left, lClientRect.Top, lsCaption);

    end;

  {draw a framerect}
  PaintFrame(aCanvas);

end;

procedure TppCustomRichTextControl.DrawToMetaFile;
var
  lCharRange: TCharRange;
  lMetaFileCanvas: TMetaFileCanvas;
  liControlWidth, liControlHeight: Integer;
  lCanvasRect: TRect;
  lPrinter: TppPrinter;
  lDC: HDC;
  liMmWidth: Integer;
  liMmHeight: Integer;
  lbTransparent: Boolean;
  lRichEdit: TCustomRichEdit;
  lRichTextStream: TMemoryStream;
  lBorder: TppBorder;
  liXBorderOffset: Integer;
  liYBorderOffset: Integer;
  liMmLeftMargin: Integer;
  liSize: Int64;
begin

  if not (pppcDesigning in Component.DesignState) or (Component.Printing) then Exit;

  if (csReading in Component.ComponentState) or (csLoading in Component.ComponentState) then Exit;

  lBorder := nil; //Initialize component reference.

  GetPropValue('mmWidth', liMmWidth);
  GetPropValue('mmHeight', liMmHeight);
  GetPropValue('Transparent', lbTransparent);
  GetPropValue('RichTextStream', lRichTextStream);
  GetPropValue('Border', lBorder);

  liMmLeftMargin := TppCustomRichText(Component).mmLeftMargin;

  lRichEdit := ppCreateRichEdit(nil);

  if (lRichTextStream.Size > 0) then
    begin
      liSize := lRichTextStream.Size;
      TraRTTI.SetPropValue(lRichEdit, 'MaxLength', liSize);
    end;

  lRichTextStream.Position := 0;
  ppGetRichEditLines(lRichEdit).LoadFromStream(lRichTextStream);

  lCharRange.cpMin := 0;
  lCharRange.cpMax := -1;

  lPrinter := Component.Report.Printer;

  liControlWidth  := Trunc(ppFromMMThousandths(liMmWidth,  utPrinterPixels, pprtHorizontal, lPrinter));
  liControlHeight := Trunc(ppFromMMThousandths(liMmHeight, utPrinterPixels, pprtVertical, lPrinter));

  lCanvasRect := Rect(0, 0, liControlWidth, liControlHeight);

  if (lPrinter <> nil) and (lPrinter.DC <> 0) then
    lDC := lPrinter.DC
  else
    lDC := GetDC(0);

  SetMetaFileSize(liMmWidth, liMmHeight, lPrinter);

  lMetaFileCanvas := TMetaFileCanvas.Create(FMetaFile, lDC);

  if not lbTransparent then
    begin
      {draw background color}
      lMetaFileCanvas.Brush.Style := bsSolid;
      lMetaFileCanvas.Brush.Color := Color;
      lMetaFileCanvas.FillRect(lCanvasRect);
    end;

    if (lBorder <> nil) and (lBorder.Visible) then
      begin
        liXBorderOffset := Round(lBorder.Weight * lPrinter.PixelsPerInch.X / 72);
        liYBorderOffset := Round(lBorder.Weight * lPrinter.PixelsPerInch.Y / 72);

        if (bpTop in lBorder.BorderPositions) then
          lCanvasRect.Top := lCanvasRect.Top + liYBorderOffset;

        if (bpLeft in lBorder.BorderPositions) then
          lCanvasRect.Left := lCanvasRect.Left + liXBorderOffset;

        if (bpRight in lBorder.BorderPositions) then
          lCanvasRect.Right := lCanvasRect.Right - liXBorderOffset;

        if (bpBottom in lBorder.BorderPositions) then
          lCanvasRect.Bottom := lCanvasRect.Bottom - liYBorderOffset;
      end;

  if (liMmLeftMargin > 0) then
    lCanvasRect.Left := lCanvasRect.Left + Trunc(ppFromMMThousandths(liMmLeftMargin,  utPrinterPixels, pprtHorizontal, lPrinter));

  {draw the RichText to the metafile}
  TppRTFEngine.DrawRichText(lRichEdit, lMetaFileCanvas.Handle, lDC, lCanvasRect, lCharRange);


  lMetaFileCanvas.Free;
  lRichEdit.Free;

  if (lPrinter = nil) or (lPrinter.DC = 0) then
    ReleaseDC(0,lDC);

end;

procedure TppCustomRichTextControl.SetMetaFileSize(aWidth, aHeight: Integer; aPrinter: TppPrinter);
begin
  if (FMetaFile <> nil) and (FSaveHeight <> aHeight) or (FSaveWidth <> aWidth) then
    begin
      FSaveWidth  := aWidth;
      FSaveHeight := aHeight;

      FMetaFile.Width  := Trunc(ppFromMMThousandths(aWidth,  utPrinterPixels, pprtHorizontal, aPrinter));
      FMetaFile.Height := Trunc(ppFromMMThousandths(aHeight, utPrinterPixels, pprtVertical, aPrinter));

    end;

end;


{******************************************************************************
 *
 ** C U S T O M  B A R C O D E  D E S I G N  C O N T R O L
 *
{******************************************************************************}

procedure TppCustomBarCodeControl.DrawBarCode(aCanvas: TCanvas);
var
  lPixelsPerInch: TPoint;
  lClientRect: TRect;
  lPrinter: TppPrinter;
  liWidth: Integer;
  liHeight: Integer;
  lOrientation: TppBarCodeOrientation;
  lBarCodeImage: Graphics.TBitmap;
  lDrawCommand: TppDrawBarCode;
  lBorder: TppBorder;
  lAlignBarCode: TppAlignHorizontalType;
begin

  lBorder := nil; //Initialize component reference.

  GetPropValue('spWidth', liWidth);
  GetPropValue('spHeight', liHeight);
  GetPropValue('Orientation', lOrientation);
  GetPropValue('Border', lBorder);
  GetPropValue('AlignBarCode', lAlignBarCode);

  lClientRect.TopLeft := Point(0,0);

  lPrinter := Component.Report.Printer;

  lDrawCommand := TppDrawBarCode.Create(nil);
  lBarCodeImage := Graphics.TBitmap.Create;

  TppCustomBarCode(Component).CalcSize(TppPrinterDevice, lDrawCommand);

  try
    {adjust size}
    if lOrientation in [orLeftToRight, orRightToLeft] then
      begin
        lClientRect.Right := ppToScreenPixels(lDrawCommand.PortraitWidth, utPrinterPixels, pprtHorizontal, lPrinter);
        lClientRect.Bottom := liHeight;
      end
    else
      begin
        lClientRect.Right := liWidth;

        lClientRect.Bottom := ppToScreenPixels(lDrawCommand.PortraitWidth, utPrinterPixels, pprtVertical, lPrinter);
      end;

    if (lBorder <> nil) and (lBorder.Visible) then
      lClientRect := AdjustObject(lBorder, lClientRect, taLeftJustified);

    {calc size of a screen based barcode}
    TppCustomBarCode(Component).CalcSize(TppScreenDevice, lDrawCommand);

    {size the offscreen bitmap}
    if lOrientation in [orLeftToRight, orRightToLeft] then
      begin
        lBarCodeImage.Width  := lDrawCommand.PortraitWidth;
        lBarCodeImage.Height := lDrawCommand.PortraitHeight;

        case lAlignBarCode of
          ahLeft: lClientRect.Left := lClientRect.Left;
          ahCenter:
            begin
              lClientRect.Left := (liWidth div 2) - (lBarCodeImage.Width div 2);
              lClientRect.Right := (liWidth div 2) + (lBarCodeImage.Width div 2);
            end;
          ahRight:
            begin
              lClientRect.Left := (liWidth - lBarCodeImage.Width);
              lClientRect.Right := liWidth;
            end;
        end;
      end
    else
      begin
        lBarCodeImage.Width  := lDrawCommand.PortraitHeight;
        lBarCodeImage.Height := lDrawCommand.PortraitWidth;

        case lAlignBarCode of
          ahLeft: lClientRect.Top := lClientRect.Top;
          ahCenter:
            begin
              lClientRect.Top := (liHeight div 2) - (lBarCodeImage.Height div 2);
              lClientRect.Bottom := (liHeight div 2) + (lBarCodeImage.Height div 2);
            end;
          ahRight:
            begin
              lClientRect.Top := (liHeight - lBarCodeImage.Height);
              lClientRect.Bottom := liHeight;
            end;
        end;
      end;

    {stretchdraw the offscreen image to the design canvas}
    lPixelsPerInch := Point(Screen.PixelsPerInch, Screen.PixelsPerInch);

    PatBlt(lBarCodeImage.Canvas.Handle, 0, 0, lBarCodeImage.Width, lBarCodeImage.Height, WHITENESS);
    lDrawCommand.DrawBarcode(lBarCodeImage.Canvas, 0, 0, lPixelsPerInch, True);

    aCanvas.StretchDraw(lClientRect, lBarCodeImage);

  finally
    lDrawCommand.Free;
    lBarCodeImage.Free;
  end;

end;

procedure TppCustomBarCodeControl.PaintDesignControl(aCanvas: TCanvas);
var
  lHeight: Integer;
  lWidth: Integer;
  lBorder: TppBorder;
begin

  if TppCustomBarCode(Component).IsUpdating > 0 then Exit;

  lBorder := nil; //Initialize component reference.

  GetPropValue('spWidth', lWidth);
  GetPropValue('spHeight', lHeight);
  GetPropValue('Border', lBorder);

  DrawBarCode(aCanvas);

  if (pppcDesigning in Component.DesignState) and not TppCustomBarCode(Component).CodeOk  then
    begin
      aCanvas.Pen.Style   := psDash;
      aCanvas.Brush.Style := bsClear;
      aCanvas.Rectangle(0, 0, lWidth, lHeight);
    end;

  if (lBorder <> nil) and (lBorder.Visible) then
    PaintBorder(aCanvas, lBorder);

end;

{ TppBarCodeControl }

function TppBarCodeControl.CanOptimizeDesignPainting: Boolean;
var
  lbTransparent: Boolean;
  lFont: TFont;
begin

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Font', lFont);

  {when transparent and font color is white, cannot optimize design control painting}
  Result := not (lbTransparent and (lFont.Color = clWhite));

end;

{ TppCustomTextControl }

procedure TppCustomTextControl.PaintDesignControl(aCanvas: TCanvas);
var
  liAngle: Integer;
begin

  GetPropValue('Angle', liAngle);

  if liAngle = 0 then
    inherited
  else
    DrawRotatedText(aCanvas);

end;

function TppCustomTextControl.CanOptimizeDesignPainting: Boolean;
var
  lbTransparent: Boolean;
  lFont: TFont;
begin

  GetPropValue('Transparent', lbTransparent);
  GetPropValue('Font', lFont);

  {when transparent and font color is white, cannot optimize design control painting}
  Result := not(lbTransparent and (lFont.Color = clWhite));

end;

procedure TppCustomTextControl.DrawRotatedText(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lbTransparent: Boolean;
  lFont: TFont;
  lOrigin: TPoint;
  lsText: String;
  liAngle: Integer;
  lBorder: TppBorder;
begin

  lBorder := nil;
  
  GetPropValue('Transparent', lbTransparent);
  GetPropValue('RotatedOriginLeft', lOrigin.X);
  GetPropValue('RotatedOriginTop', lOrigin.Y);
  GetPropValue('Font', lFont);
  GetPropValue('Text', lsText);
  GetPropValue('Angle', liAngle);
  GetPropValue('Border', lBorder);

  lOrigin.X := Trunc(ppFromMMThousandths(lOrigin.X, utScreenPixels, pprtHorizontal, nil));
  lOrigin.Y := Trunc(ppFromMMThousandths(lOrigin.Y, utScreenPixels, pprtHorizontal, nil));

  lClientRect := ClientRect;

  {draw background}
  if not lbTransparent then
    begin
      aCanvas.Brush.Color := GetColor;
      aCanvas.Brush.Style := bsSolid;
      aCanvas.FillRect(lClientRect);
    end;

  aCanvas.Brush.Style := bsClear;
  aCanvas.Font := lFont;

  if (lBorder <> nil) and lBorder.Visible then
    lOrigin := TppBorder.AdjustRotatedText(lBorder, liAngle, lOrigin.X, lOrigin.Y, nil);

  TppRotatedText.TextOutRotate(aCanvas, lFont, lClientRect, lOrigin.X, lOrigin.Y, liAngle, lsText);

  {draw a framerect}
  PaintFrame(aCanvas);

end;


{ TppImageControl }

constructor TppImageControl.Create(AOwner: TComponent);
begin

  inherited;

  FrameStyle := fsDashed;

end;


{ TppPageBreakControl }

constructor TppPageBreakControl.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);

end;

procedure TppPageBreakControl.PaintDesignControl(aCanvas: TCanvas);
var
  lClientRect: TRect;
  lSaveColor: TColor;
  lsCaption: String;
begin
  //inherited PaintDesignControl(aCanvas);

  GetPropValue('Caption', lsCaption);

  lClientRect := ClientRect;

  aCanvas.Brush.Color := clGray;
  aCanvas.Brush.Style := bsBDiagonal;
  SetBKColor(aCanvas.Handle, clWhite);
  aCanvas.FillRect(lClientRect);

  {draw a framerect}
  lSaveColor := aCanvas.Brush.Color;
  aCanvas.Brush.Style := bsSolid;
  aCanvas.Brush.Color := clBlack;
  aCanvas.FrameRect(lClientRect);
  aCanvas.Brush.Color := lSaveColor;

end;

procedure TppPageBreakControl.SetComponent(aComponent: TppComponent);
begin
  inherited SetComponent(aComponent);

  BoundsLocks := BoundsLocks + [ppblHeight];

end;

procedure TppLabelControl.DblClick;
begin
 inherited;

 Edit;
end;


procedure TppLabelControl.Edit;
begin

  TppInPlaceEditorText.Execute(Self);

end;

procedure TppMemoControl.DblClick;
begin
 inherited;

 Edit;
end;

procedure TppMemoControl.Edit;
begin

  TppInPlaceEditorText.Execute(Self);

end;


{******************************************************************************
 *
 ** I n   P l a c e   T e x t   E d i t o r
 *
{******************************************************************************}


type
  {TMemoEx}
  TMemoEx = class(TMemo)
  private
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
  end;

// global variable used by the CustomWordBreakProc
var
  uEditor: TppInPlaceEditorText;


// uCustomWordBreakProc - windows callback function to do custom word breaking
function uCustomWordBreakProc(lpch : LPTSTR; ichCurrent : integer; cch : integer; code : integer) : integer stdcall;
begin

 if (code = WB_ISDELIMITER) then
   result := 0 // return false
 else if (code = WB_LEFT) and (uEditor <> nil) then
   Result := uEditor.CalcNearestWordBreak(ichCurrent)
 else if (code = WB_RIGHT) and (uEditor <> nil) then
   Result := uEditor.CalcNearestWordBreak(ichCurrent)
 else
   Result := 0;

end;



constructor TppInPlaceEditorText.Create;
begin

  inherited;

  CreateEditControl;

end;

destructor TppInPlaceEditorText.Destroy;
begin

  FreeEditControl;

  inherited;

end;

procedure TppInPlaceEditorText.BeginEdit(aControl: TppDesignControl);
begin

  // initialize references
  FTextWrapper := TppPlainTextWrapper.Create;
  FDesignControl := aControl;
  FComponent := FDesignControl.Component;

  // need to know if component props change while editing
  if (EventHub <> nil) then
    EventHub.ComponentEvents.mcAfterPropertyChange.AddNotify(ehComponent_AfterProperyChange);

  // install windows custom word break proc,
  // note: must do this after assigning FEdit.Parent
  uEditor := Self;
  FEdit.Parent := FDesignControl.Parent;
  SendMessage(FEdit.Handle, EM_SETWORDBREAKPROC, 0, Integer(@uCustomWordBreakProc));


  // show the edit control
  ShowEditControl;

end;


procedure TMemoEx.WMKillFocus(var Message: TWMSetFocus);
begin
  inherited;
  DoExit;
end;

procedure TppInPlaceEditorText.BeginUpdate;
begin
  Inc(FUpdateCounter);
end;

function TppInPlaceEditorText.CalcNearestWordBreak(aCharPos: Integer): Integer;
var
  liCharPos: Integer;
  liIndex: Integer;
  liLineLength: Integer;
begin

  InitializeTextWrapper;

  // wrap text
  FTextWrapper.Wrap;

  // calc char pos of nearest word break
  liCharPos := 0;
  liIndex := 0;

  while (liCharPos < aCharPos) and (liIndex < FTextWrapper.WrappedText.Count) do
    begin

      // increment CharPos for space at end of previous line
      if (liIndex > 0) and not(FTextWrapper.CharWrap) then
        Inc(liCharPos);

      liLineLength := Length(FTextWrapper.WrappedText[liIndex]);

      if (liCharPos + liLineLength-1) <= (aCharPos) then
        liCharPos := liCharPos + liLineLength
      else
        Break;

      Inc(liIndex);

    end;

   Result := liCharPos;

end;

procedure TppInPlaceEditorText.CreateEditControl;
begin

  FEdit := TMemoEx.Create(nil);
  FEdit.BevelInner := bvNone;
  FEdit.BevelOuter := bvNone;
  FEdit.Visible := False;

  FEdit.OnChange := ehEdit_Change;
  FEdit.OnExit := ehEdit_Exit;
  FEdit.OnKeyDown := ehEdit_KeyDown;
  FEdit.OnKeyPress := ehEdit_KeyPress;
  FEdit.OnKeyUp := ehEdit_KeyUp;
//  FEdit.OnMouseLeave := ehEdit_MouseLeave;

end;

procedure TppInPlaceEditorText.ehComponent_AfterProperyChange(aSender, aEventParams: TObject);
begin

  SyncEditProps;
  
end;

procedure TppInPlaceEditorText.ehEdit_Exit(Sender: TObject);
begin

  if Updating then Exit;
  
  if (csDestroying in FEdit.ComponentState) then Exit;

  EndEdit;

end;

procedure TppInPlaceEditorText.ehEdit_Change(Sender: TObject);
begin
  if FUpdateCounter > 0 then Exit;

  BeginUpdate;

  if FComponent.AutoSize then
    begin
      SetComponentText(FEdit.Text);
      UpdateBounds();
    end;

  EndUpdate;

end;

procedure TppInPlaceEditorText.ehEdit_KeyPress(Sender: TObject; var Key: Char);
begin

  if (Key = chEnterKey) and not(FComponent is TppMemo) then
    begin
      Key := #0;
      EndEdit;
    end;

end;

procedure TppInPlaceEditorText.ehEdit_KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

end;

procedure TppInPlaceEditorText.ehEdit_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

end;

procedure TppInPlaceEditorText.ehEdit_MouseLeave(Sender: TObject);
begin
  EndEdit;
end;

procedure TppInPlaceEditorText.EndEdit;
begin

  FTextWrapper.Free;
  FTextWrapper := nil;

  uEditor := nil;
  
  if (EventHub <> nil) then
   EventHub.ComponentEvents.mcAfterPropertyChange.RemoveNotify(ehComponent_AfterProperyChange);

  SetComponentText(FEdit.Text);

  Free;
end;

procedure TppInPlaceEditorText.EndUpdate;
begin
  if FUpdateCounter > 0 then
    Dec(FUpdateCounter);
end;

class procedure TppInPlaceEditorText.Execute(aDesignControl: TppDesignControl);
var
  lEditor: TppInPlaceEditorText;
begin

  lEditor := TppInPlaceEditorText.Create;
  lEditor.BeginEdit(aDesignControl);

end;

procedure TppInPlaceEditorText.FreeEditControl;
begin
  FEdit.Free;
  FEdit := nil;
end;

function TppInPlaceEditorText.GetComponentText: String;
begin
  if FComponent is TppLabel then
    Result := FComponent.Caption
  else
    Result := Copy(FComponent.Text, 1, Length(FComponent.Text)-2);
end;

function TppInPlaceEditorText.GetEventHub: TppDesignEventHub;
begin
  if (FComponent <> nil) and (FComponent.DesignEventHub is TppDesignEventHub)  then
    Result := TppDesignEventHub(FComponent.DesignEventHub)
  else
    Result := nil;
end;

function TppInPlaceEditorText.GetUpdating: Boolean;
begin
  Result := FUpdateCounter > 0;
end;

procedure TppInPlaceEditorText.InitializeTextWrapper;
var
  lMemo: TppCustomMemo;
begin

  // configure text wrapper
  FTextWrapper.Text := FEdit.Text;
  FTextWrapper.CharPos := 0;

  FTextWrapper.Bottomless := True;
//  FTextWrapper.WantReturns := True;

  FTextWrapper.Font := FComponent.Font;
  FTextWrapper.AutoSize := FComponent.AutoSize;
  FTextWrapper.Alignment := FComponent.TextAlignment;
  FTextWrapper.Printer := ppPrinter;

  if (FComponent is TppCustomMemo) then
    begin
      lMemo := TppCustomMemo(FComponent);

      FTextWrapper.CharWrap := lMemo.CharWrap;
      FTextWrapper.Leading := lMemo.mmLeading;
      FTextWrapper.Tabs := lMemo.TabStopPositions;
    end;

  FTextWrapper.AreaAvailable :=  ppRect(0, 0, FComponent.mmWidth, FComponent.mmHeight);

end;

procedure TppInPlaceEditorText.SetComponentText(aText: String);
begin

  if FComponent is TppLabel then
    FComponent.Caption := aText
  else
    FComponent.Text := aText;

end;

procedure TppInPlaceEditorText.ShowEditControl;
begin

  FEdit.Text := GetComponentText;

  SyncEditProps;

  FEdit.Visible := True;
  FEdit.SetFocus;

  if FComponent.Text = FComponent.UserName then
   FEdit.SelectAll
  else
    FEdit.SelStart := Length(FComponent.Text);

end;

procedure TppInPlaceEditorText.SyncEditProps;
begin


  BeginUpdate;

  FEdit.Alignment := FComponent.Alignment;
  FEdit.Font := FComponent.Font;

  // always use winow text color
  FEdit.Font.Color := clWindowText;

  if FComponent is TppMemo then
    begin
      FEdit.WordWrap := True;
      FEdit.WantReturns := True;
      FEdit.WantTabs := True;
    end
  else
    begin
      FEdit.WordWrap := FComponent.Wordwrap;
      FEdit.WantReturns := False;
      FEdit.WantTabs := False;
    end;

  UpdateBounds();

  EndUpdate;


end;

procedure TppInPlaceEditorText.UpdateBounds;
var
  lTextRect: TRect;
//  liCharWidth: Integer;
begin

//  liCharWidth := ppGetSpTextWidth(FEdit.Font, 'W');

  // sync edit control bounds with design control bounds
//  FEdit.SetBounds(FDesignControl.Left-2, FDesignControl.Top-2, FComponent.spWidth+(liCharWidth div 2), FComponent.spHeight+2);
  FEdit.SetBounds(FDesignControl.Left-2, FDesignControl.Top-2, FComponent.spWidth+2, FComponent.spHeight+4);

  // send windows message to define the drawing rectangle (remove inner margin)
  lTextRect := Rect(-1, -1, FEdit.Width, FEdit.Height);
  SendMessage(FEdit.Handle, EM_SETRECT, 0, Integer(@lTextRect));

  FEdit.Repaint;

end;




end.
