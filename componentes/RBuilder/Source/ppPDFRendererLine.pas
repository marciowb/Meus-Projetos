{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2008                    BBBBB   }

unit ppPDFRendererLine;

interface

uses
  Classes,
  Graphics,
  SysUtils,
  ExtCtrls,
  ppDevice,
  ppDrwCmd,
  ppPDFRenderer;

type

  {@TppPDFLineRenderer

    Creates the instructions to render a line of specified style and width to the
    PDF File. }

  TppPDFRendererLine = class(TppPDFRenderer)
    private
      FDrawLine: TppDrawLine;

    protected
      procedure SetDrawCommand(const Value: TppDrawCommand); override;
    public
      class function DrawCommandClass: TppDrawCommandClass; override;
      procedure RenderToPDF; override;

  end;

implementation

uses
  Math,
  ppTypes,
  ppPDFUtils,
  ppPDFRendererManager;

class function TppPDFRendererLine.DrawCommandClass: TppDrawCommandClass;
begin
  Result := TppDrawLine;

end;

{TppPDFLine.RenderToPDF

  Creates the PDF instructions to draw a line/double line to a page.  Calculates
  the line width as well as the pen style (dashed or dotted line). }

procedure TppPDFRendererLine.RenderToPDF;
var
  ldBottom: Double;
  ldLeft: Double;
  ldTop: Double;
  ldRight: Double;
  ldWidth: Double;
  ldHeight: Double;
  ldOffset: Double;
begin

  {Dimentions}
  ldWidth := TppPDFUtils.MicronsToPoints(FDrawLine.Width);
  ldHeight := TppPDFUtils.MicronsToPoints(FDrawLine.Height);

  {Position}
  ldTop := TppPDFUtils.MicronsToPoints(FDrawLine.Top);
  ldLeft := TppPDFUtils.MicronsToPoints(FDrawLine.Left);
  ldBottom := ldTop + ldHeight;
  ldRight := ldLeft + ldWidth;

  {Weight Offset}
  ldOffset := FDrawLine.Weight / 2;

  PDFCanvas.SelectPen(FDrawLine.Pen, FDrawLine.Weight);

  {Draw Line}
  case FDrawLine.LinePosition of
    lpTop:
      begin
        PDFCanvas.MoveTo(ldLeft, (ldTop + ldOffset));
        PDFCanvas.LineTo(ldRight, (ldTop + ldOffset));
      end;
    lpBottom:
      begin
        PDFCanvas.MoveTo(ldLeft, (ldBottom - ldOffset));
        PDFCanvas.LineTo(ldRight, (ldBottom - ldOffset));
      end;
    lpLeft:
      begin
        PDFCanvas.MoveTo((ldLeft + ldOffset), ldBottom);
        PDFCanvas.LineTo((ldLeft + ldOffset), ldTop);
      end;
    lpRight:
      begin
        PDFCanvas.MoveTo((ldRight - ldOffset), ldBottom);
        PDFCanvas.LineTo((ldRight - ldOffset), ldTop);
      end;
  end;

  {Draw Double Line (if needed)}
  if FDrawLine.LineStyle = lsDouble then
    begin
      case FDrawLine.LinePosition of
        lpTop:
          begin
            PDFCanvas.MoveTo(ldLeft, (ldTop - FDrawLine.Weight * 2 - ldOffset));
            PDFCanvas.LineTo(ldRight, (ldTop - FDrawLine.Weight * 2 - ldOffset));
          end;
        lpBottom:
          begin
            PDFCanvas.MoveTo(ldLeft, (ldBottom + FDrawLine.Weight * 2 + ldOffset));
            PDFCanvas.LineTo(ldRight, (ldBottom + FDrawLine.Weight * 2 + ldOffset));
          end;
        lpLeft:
          begin
            PDFCanvas.MoveTo((ldLeft + FDrawLine.Weight * 2 + ldOffset), ldBottom);
            PDFCanvas.LineTo((ldLeft + FDrawLine.Weight * 2 + ldOffset), ldTop);
          end;
        lpRight:
          begin
            PDFCanvas.MoveTo((ldRight - FDrawLine.Weight * 2 - ldOffset), ldBottom);
            PDFCanvas.LineTo((ldRight - FDrawLine.Weight * 2 - ldOffset), ldTop);
          end;

      end;

    end;

  PDFCanvas.ExecuteStroke;

end;

procedure TppPDFRendererLine.SetDrawCommand(const Value: TppDrawCommand);
begin
  FDrawLine := TppDrawLine(Value);

end;

initialization

  TppPDFRendererManager.RegisterRenderer(TppPDFRendererLine);

finalization

  TppPDFRendererManager.UnregisterRenderer(TppPDFRendererLine);

end.
