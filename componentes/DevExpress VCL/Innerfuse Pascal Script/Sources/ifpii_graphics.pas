unit ifpii_graphics;

{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;

{
  Will register files from:
    Graphics


Register the STD library first

}

procedure SIRegister_Graphics_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTGRAPHICSOBJECT(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTFont(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTPEN(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTBRUSH(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTCanvas(cl: TIFPSCompileTimeClassesImporter);


procedure SIRegister_Graphics(Cl: TIFPSCompileTimeClassesImporter);

implementation
{$IFNDEF NOGRAPHCONST}
uses
  {$IFDEF CLX}QGraphics{$ELSE}Graphics{$ENDIF};
{$ENDIF}

procedure SIRegisterTGRAPHICSOBJECT(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TPERSISTENT'), 'TGRAPHICSOBJECT') do
  begin
    RegisterProperty('ONCHANGE', 'TNOTIFYEVENT', iptrw);
  end;
end;

procedure SIRegisterTFont(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGraphicsObject'), 'TFONT') do
  begin
    RegisterMethod('constructor Create;');
{$IFNDEF CLX}
    RegisterProperty('Handle', 'Integer', iptR);
{$ENDIF}
    RegisterProperty('PixelsPerInch', 'Integer', iptRW);
    RegisterProperty('Color', 'Integer', iptRW);
    RegisterProperty('Height', 'Integer', iptRW);
    RegisterProperty('Name', 'string', iptRW);
    RegisterProperty('Pitch', 'Byte', iptRW);
    RegisterProperty('Size', 'Integer', iptRW);
    RegisterProperty('Handle', 'Integer', iptRW);
    RegisterProperty('PixelsPerInch', 'Integer', iptRW);
  end;
end;

procedure SIRegisterTCanvas(cl: TIFPSCompileTimeClassesImporter); // requires TPersistent
begin
  with Cl.Add2(cl.FindClass('TPersistent'), 'TCANVAS') do
  begin
    RegisterMethod('procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);');
    RegisterMethod('procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);');
    RegisterMethod('procedure Draw(X, Y: Integer; Graphic: TGraphic);');
    RegisterMethod('procedure Ellipse(X1, Y1, X2, Y2: Integer);');
{$IFNDEF CLX}
    RegisterMethod('procedure FloodFill(X, Y: Integer; Color: TColor; FillStyle: Byte);');
{$ENDIF}
    RegisterMethod('procedure LineTo(X, Y: Integer);');
    RegisterMethod('procedure MoveTo(X, Y: Integer);');
    RegisterMethod('procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Integer);');
    RegisterMethod('procedure Rectangle(X1, Y1, X2, Y2: Integer);');
    RegisterMethod('procedure Refresh;');
    RegisterMethod('procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Integer);');
    RegisterMethod('function TextHeight(Text: string): Integer;');
    RegisterMethod('procedure TextOut(X, Y: Integer; Text: string);');
    RegisterMethod('function TextWidth(Text: string): Integer;');
{$IFNDEF CLX}
    RegisterProperty('Handle', 'Integer', iptRw);
{$ENDIF}
    RegisterProperty('Pixels', 'Integer Integer Integer', iptRW);
    RegisterProperty('Brush', 'TBrush', iptR);
    RegisterProperty('CopyMode', 'Byte', iptRw);
    RegisterProperty('Font', 'TFont', iptR);
    RegisterProperty('Pen', 'TPen', iptR);
  end;
end;

procedure SIRegisterTPEN(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICSOBJECT'), 'TPEN') do
  begin
    RegisterMethod('constructor CREATE');
    RegisterProperty('COLOR', 'TCOLOR', iptrw);
    RegisterProperty('MODE', 'TPENMODE', iptrw);
    RegisterProperty('STYLE', 'TPENSTYLE', iptrw);
    RegisterProperty('WIDTH', 'INTEGER', iptrw);
  end;
end;

procedure SIRegisterTBRUSH(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICSOBJECT'), 'TBRUSH') do
  begin
    RegisterMethod('constructor CREATE');
    RegisterProperty('COLOR', 'TCOLOR', iptrw);
    RegisterProperty('STYLE', 'TBRUSHSTYLE', iptrw);
  end;
end;

procedure SIRegister_Graphics_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
{$IFNDEF NOGRAPHCONST}
  cl.se.AddConstantN('clScrollBar', 'Integer')^.Value.ts32 := clScrollBar;
  cl.se.AddConstantN('clBackground', 'Integer')^.Value.ts32 := clBackground;
  cl.se.AddConstantN('clActiveCaption', 'Integer')^.Value.ts32 := clActiveCaption;
  cl.se.AddConstantN('clInactiveCaption', 'Integer')^.Value.ts32 := clInactiveCaption;
  cl.se.AddConstantN('clMenu', 'Integer')^.Value.ts32 := clMenu;
  cl.se.AddConstantN('clWindow', 'Integer')^.Value.ts32 := clWindow;
  cl.se.AddConstantN('clWindowFrame', 'Integer')^.Value.ts32 := clWindowFrame;
  cl.se.AddConstantN('clMenuText', 'Integer')^.Value.ts32 := clMenuText;
  cl.se.AddConstantN('clWindowText', 'Integer')^.Value.ts32 := clWindowText;
  cl.se.AddConstantN('clCaptionText', 'Integer')^.Value.ts32 := clCaptionText;
  cl.se.AddConstantN('clActiveBorder', 'Integer')^.Value.ts32 := clActiveBorder;
  cl.se.AddConstantN('clInactiveBorder', 'Integer')^.Value.ts32 := clInactiveCaption;
  cl.se.AddConstantN('clAppWorkSpace', 'Integer')^.Value.ts32 := clAppWorkSpace;
  cl.se.AddConstantN('clHighlight', 'Integer')^.Value.ts32 := clHighlight;
  cl.se.AddConstantN('clHighlightText', 'Integer')^.Value.ts32 := clHighlightText;
  cl.se.AddConstantN('clBtnFace', 'Integer')^.Value.ts32 := clBtnFace;
  cl.se.AddConstantN('clBtnShadow', 'Integer')^.Value.ts32 := clBtnShadow;
  cl.se.AddConstantN('clGrayText', 'Integer')^.Value.ts32 := clGrayText;
  cl.se.AddConstantN('clBtnText', 'Integer')^.Value.ts32 := clBtnText;
  cl.se.AddConstantN('clInactiveCaptionText', 'Integer')^.Value.ts32 := clInactiveCaptionText;
  cl.se.AddConstantN('clBtnHighlight', 'Integer')^.Value.ts32 := clBtnHighlight;
  cl.se.AddConstantN('cl3DDkShadow', 'Integer')^.Value.ts32 := cl3DDkShadow;
  cl.se.AddConstantN('cl3DLight', 'Integer')^.Value.ts32 := cl3DLight;
  cl.se.AddConstantN('clInfoText', 'Integer')^.Value.ts32 := clInfoText;
  cl.se.AddConstantN('clInfoBk', 'Integer')^.Value.ts32 := clInfoBk;
{$ENDIF}
  cl.se.AddConstantN('clBlack', 'Integer')^.Value.ts32 := $000000;
  cl.se.AddConstantN('clMaroon', 'Integer')^.Value.ts32 := $000080;
  cl.se.AddConstantN('clGreen', 'Integer')^.Value.ts32 := $008000;
  cl.se.AddConstantN('clOlive', 'Integer')^.Value.ts32 := $008080;
  cl.se.AddConstantN('clNavy', 'Integer')^.Value.ts32 := $800000;
  cl.se.AddConstantN('clPurple', 'Integer')^.Value.ts32 := $800080;
  cl.se.AddConstantN('clTeal', 'Integer')^.Value.ts32 := $808000;
  cl.se.AddConstantN('clGray', 'Integer')^.Value.ts32 := $808080;
  cl.se.AddConstantN('clSilver', 'Integer')^.Value.ts32 := $C0C0C0;
  cl.se.AddConstantN('clRed', 'Integer')^.Value.ts32 := $0000FF;
  cl.se.AddConstantN('clLime', 'Integer')^.Value.ts32 := $00FF00;
  cl.se.AddConstantN('clYellow', 'Integer')^.Value.ts32 := $00FFFF;
  cl.se.AddConstantN('clBlue', 'Integer')^.Value.ts32 := $FF0000;
  cl.se.AddConstantN('clFuchsia', 'Integer')^.Value.ts32 := $FF00FF;
  cl.se.AddConstantN('clAqua', 'Integer')^.Value.ts32 := $FFFF00;
  cl.se.AddConstantN('clLtGray', 'Integer')^.Value.ts32 := $C0C0C0;
  cl.se.AddConstantN('clDkGray', 'Integer')^.Value.ts32 := $808080;
  cl.se.AddConstantN('clWhite', 'Integer')^.Value.ts32 := $FFFFFF;
  cl.se.AddConstantN('clNone', 'Integer')^.Value.ts32 := $1FFFFFFF;
  cl.se.AddConstantN('clDefault', 'Integer')^.Value.ts32 := $20000000;
  cl.se.AddConstantN('fsBold', 'Integer')^.Value.ts32 := 1;
  cl.se.AddConstantN('fsItalic', 'Integer')^.Value.ts32 := 2;
  cl.se.AddConstantN('fsUnderline', 'Integer')^.Value.ts32 := 4;
  cl.se.AddConstantN('fsStrikeout', 'Integer')^.Value.ts32 := 8;

  cl.se.AddTypeS('TFontPitch', '(fpDefault, fpVariable, fpFixed)');
  cl.se.AddTypeS('TPenStyle', '(psSolid, psDash, psDot, psDashDot, psDashDotDot, psClear, psInsideFrame)');
  cl.se.AddTypeS('TPenMode', '(pmBlack, pmWhite, pmNop, pmNot, pmCopy, pmNotCopy, pmMergePenNot, pmMaskPenNot, pmMergeNotPen, pmMaskNotPen, pmMerge, pmNotMerge, pmMask, pmNotMask, pmXor, pmNotXor)');
  cl.se.AddTypeS('TBrushStyle', '(bsSolid, bsClear, bsHorizontal, bsVertical, bsFDiagonal, bsBDiagonal, bsCross, bsDiagCross)');
  cl.se.addTypeS('TColor', 'integer');
end;


procedure SIRegister_Graphics(Cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_Graphics_TypesAndConsts(Cl);
  SIRegisterTGRAPHICSOBJECT(Cl);
  SIRegisterTFont(Cl);
  SIRegisterTPEN(cl);
  SIRegisterTBRUSH(cl);
  SIRegisterTCanvas(cl);
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


End.








