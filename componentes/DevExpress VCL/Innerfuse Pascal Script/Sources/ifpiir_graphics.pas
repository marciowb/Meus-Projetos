unit ifpiir_graphics;
{$I ifps3_def.inc}
interface
uses
  ifps3, ifps3common, ifps3utl, ifpiclassruntime;

{
  Will register files from:
    Graphics


Register the STD library first

}

procedure RIRegisterTGRAPHICSOBJECT(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTFont(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTPEN(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTBRUSH(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTCanvas(cl: TIFPSRuntimeClassImporter);


procedure RIRegister_Graphics(Cl: TIFPSRuntimeClassImporter);


implementation
uses
  Classes{$IFDEF CLX}, QGraphics{$ELSE}, Graphics{$ENDIF};
{$IFNDEF CLX}
procedure TFontHandleR(Self: TFont; var T: Longint); begin T := Self.Handle; end;
procedure TFontHandleW(Self: TFont; T: Longint); begin Self.Handle := T; end;
{$ENDIF}
procedure TFontPixelsPerInchR(Self: TFont; var T: Longint); begin T := Self.PixelsPerInch; end;
procedure TFontPixelsPerInchW(Self: TFont; T: Longint); begin Self.PixelsPerInch:= T; end;

procedure RIRegisterTFont(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TFont) do
  begin
    RegisterConstructor(@TFont.Create, 'CREATE');
{$IFNDEF CLX}
    RegisterPropertyHelper(@TFontHandleR, @TFontHandleW, 'HANDLE');
{$ENDIF}
    RegisterPropertyHelper(@TFontPixelsPerInchR, @TFontPixelsPerInchW, 'PIXELSPERINCH');
  end;
end;
{$IFNDEF CLX}
procedure TCanvasHandleR(Self: TCanvas; var T: Longint); begin T := Self.Handle; end;
procedure TCanvasHandleW(Self: TCanvas; T: Longint); begin Self.Handle:= T; end;
{$ENDIF}

procedure TCanvasPixelsR(Self: TCanvas; var T: Longint; X,Y: Longint); begin T := Self.Pixels[X,Y]; end;
procedure TCanvasPixelsW(Self: TCanvas; T, X, Y: Longint); begin Self.Pixels[X,Y]:= T; end;

procedure RIRegisterTCanvas(cl: TIFPSRuntimeClassImporter); // requires TPersistent
begin
  with Cl.Add(TCanvas) do
  begin
    RegisterMethod(@TCanvas.Arc, 'ARC');
    RegisterMethod(@TCanvas.Chord, 'CHORD');
    RegisterMethod(@TCanvas.Draw, 'DRAW');
    RegisterMethod(@TCanvas.Ellipse, 'ELLIPSE');
{$IFNDEF CLX}
    RegisterMethod(@TCanvas.FloodFill, 'FLOODFILL');
{$ENDIF}
    RegisterMethod(@TCanvas.Lineto, 'LINETO');
    RegisterMethod(@TCanvas.Moveto, 'MOVETO');
    RegisterMethod(@TCanvas.Pie, 'PIE');
    RegisterMethod(@TCanvas.Rectangle, 'RECTANGLE');
    RegisterMethod(@TCanvas.Refresh, 'REFRESH');
    RegisterMethod(@TCanvas.RoundRect, 'ROUNDRECT');
    RegisterMethod(@TCanvas.TextHeight, 'TEXTHEIGHT');
    RegisterMethod(@TCanvas.TextOut, 'TEXTOUT');
    RegisterMethod(@TCanvas.TextWidth, 'TEXTWIDTH');
{$IFNDEF CLX}
    RegisterPropertyHelper(@TCanvasHandleR, @TCanvasHandleW, 'HANDLE');
{$ENDIF}
    RegisterPropertyHelper(@TCanvasPixelsR, @TCanvasPixelsW, 'PIXELS');
  end;
end;


procedure TGRAPHICSOBJECTONCHANGE_W(Self: TGraphicsObject; T: TNotifyEvent); begin Self.OnChange := t; end;
procedure TGRAPHICSOBJECTONCHANGE_R(Self: TGraphicsObject; var T: TNotifyEvent); begin T :=Self.OnChange; end;


procedure RIRegisterTGRAPHICSOBJECT(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TGRAPHICSOBJECT) do
  begin
    RegisterPropertyHelper(@TGRAPHICSOBJECTONCHANGE_R, @TGRAPHICSOBJECTONCHANGE_W, 'ONCHANGE');
  end;
end;

procedure RIRegisterTPEN(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TPEN) do
  begin
    RegisterConstructor(@TPEN.CREATE, 'CREATE');
  end;
end;

procedure RIRegisterTBRUSH(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TBRUSH) do
  begin
    RegisterConstructor(@TBRUSH.CREATE, 'CREATE');
  end;
end;



procedure RIRegister_Graphics(Cl: TIFPSRuntimeClassImporter);
begin
  RIRegisterTGRAPHICSOBJECT(cl);
  RIRegisterTFont(Cl);
  RIRegisterTCanvas(cl);
  RIRegisterTPEN(cl);
  RIRegisterTBRUSH(cl);
end;
// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)

end.





