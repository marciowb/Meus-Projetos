unit ifpii_buttons;
{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;

{
  Will register files from:
    Buttons

  Requires
      STD, classes, controls and graphics and StdCtrls
}
procedure SIRegister_Buttons_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegisterTSPEEDBUTTON(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTBITBTN(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegister_Buttons(Cl: TIFPSCompileTimeClassesImporter);

implementation

procedure SIRegisterTSPEEDBUTTON(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICCONTROL'), 'TSPEEDBUTTON') do
  begin
    RegisterProperty('ALLOWALLUP', 'BOOLEAN', iptrw);
    RegisterProperty('GROUPINDEX', 'INTEGER', iptrw);
    RegisterProperty('DOWN', 'BOOLEAN', iptrw);
    RegisterProperty('CAPTION', 'String', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('GLYPH', 'TBITMAP', iptrw);
    RegisterProperty('LAYOUT', 'TBUTTONLAYOUT', iptrw);
    RegisterProperty('MARGIN', 'INTEGER', iptrw);
    RegisterProperty('NUMGLYPHS', 'BYTE', iptrw);
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('SPACING', 'INTEGER', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
  end;
end;

procedure SIRegisterTBITBTN(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TBUTTON'), 'TBITBTN') do
  begin
    RegisterProperty('GLYPH', 'TBITMAP', iptrw);
    RegisterProperty('KIND', 'TBITBTNKIND', iptrw);
    RegisterProperty('LAYOUT', 'TBUTTONLAYOUT', iptrw);
    RegisterProperty('MARGIN', 'INTEGER', iptrw);
    RegisterProperty('NUMGLYPHS', 'BYTE', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('STYLE', 'TBUTTONSTYLE', iptrw);
    RegisterProperty('SPACING', 'INTEGER', iptrw);
    RegisterProperty('ONENTER', 'TNotifyEvent', iptrw);
    RegisterProperty('ONEXIT', 'TNotifyEvent', iptrw);
  end;
end;



procedure SIRegister_Buttons_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
  Cl.Se.AddTypeS('TButtonLayout', '(blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom)');
  Cl.Se.AddTypeS('TButtonState', '(bsUp, bsDisabled, bsDown, bsExclusive)');
  Cl.Se.AddTypeS('TButtonStyle', '(bsAutoDetect, bsWin31, bsNew)');
  Cl.Se.AddTypeS('TBitBtnKind', '(bkCustom, bkOK, bkCancel, bkHelp, bkYes, bkNo, bkClose, bkAbort, bkRetry, bkIgnore, bkAll)');

end;

procedure SIRegister_Buttons(Cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_Buttons_TypesAndConsts(cl);
  SIRegisterTSPEEDBUTTON(cl);
  SIRegisterTBITBTN(cl);
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


end.




