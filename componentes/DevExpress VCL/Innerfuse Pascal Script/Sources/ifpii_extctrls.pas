unit ifpii_extctrls;

{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;
(*
   Will register files from:
     ExtCtrls

Requires:
  STD, classes, controls, graphics {$IFNDEF MINIVCL}, stdctrls {$ENDIF}
*)

procedure SIRegister_ExtCtrls_TypesAndConsts(cl: TIFPSCompileTimeClassesImporter);

procedure SIRegisterTSHAPE(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTPAINTBOX(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTIMAGE(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTBEVEL(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTTIMER(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTCUSTOMPANEL(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTPANEL(Cl: TIFPSCompileTimeClassesImporter);
{$IFNDEF CLX}
procedure SIRegisterTPAGE(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTNOTEBOOK(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTHEADER(Cl: TIFPSCompileTimeClassesImporter);
{$ENDIF}
procedure SIRegisterTCUSTOMRADIOGROUP(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTRADIOGROUP(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegister_ExtCtrls(cl: TIFPSCompileTimeClassesImporter);

implementation
procedure SIRegisterTSHAPE(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICCONTROL'), 'TSHAPE') do
  begin
    RegisterProperty('BRUSH', 'TBRUSH', iptrw);
    RegisterProperty('PEN', 'TPEN', iptrw);
    RegisterProperty('SHAPE', 'TSHAPETYPE', iptrw);

    {$IFNDEF MINIVCL}
    RegisterMethod('procedure STYLECHANGED(SENDER:TOBJECT)');
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTPAINTBOX(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICCONTROL'), 'TPAINTBOX') do
  begin
    RegisterProperty('CANVAS', 'TCanvas', iptr);
    RegisterProperty('COLOR', 'Longint', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONPAINT', 'TNOTIFYEVENT', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('PARENTCOLOR', 'Boolean', iptrw);
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTIMAGE(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICCONTROL'), 'TIMAGE') do
  begin
    RegisterProperty('CANVAS', 'TCANVAS', iptr);
    RegisterProperty('AUTOSIZE', 'BOOLEAN', iptrw);
    RegisterProperty('CENTER', 'BOOLEAN', iptrw);
    RegisterProperty('PICTURE', 'TPICTURE', iptrw);
    RegisterProperty('STRETCH', 'BOOLEAN', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNotifyEvent', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTBEVEL(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TGRAPHICCONTROL'), 'TBEVEL') do
  begin
    RegisterProperty('SHAPE', 'TBEVELSHAPE', iptrw);
    RegisterProperty('STYLE', 'TBEVELSTYLE', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTTIMER(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCOMPONENT'), 'TTIMER') do
  begin
    RegisterProperty('ENABLED', 'BOOLEAN', iptrw);
    RegisterProperty('INTERVAL', 'CARDINAL', iptrw);
    RegisterProperty('ONTIMER', 'TNOTIFYEVENT', iptrw);
  end;
end;

procedure SIRegisterTCUSTOMPANEL(Cl: TIFPSCompileTimeClassesImporter);
begin
  Cl.Add2(cl.FindClass('TCUSTOMCONTROL'), 'TCUSTOMPANEL');
end;

procedure SIRegisterTPANEL(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMPANEL'), 'TPANEL') do
  begin
    RegisterProperty('ALIGNMENT', 'TAlignment', iptrw);
    RegisterProperty('BEVELINNER', 'TPanelBevel', iptrw);
    RegisterProperty('BEVELOUTER', 'TPanelBevel', iptrw);
    RegisterProperty('BEVELWIDTH', 'TBevelWidth', iptrw);
    RegisterProperty('BORDERWIDTH', 'TBorderWidth', iptrw);
    RegisterProperty('BORDERSTYLE', 'TBorderStyle', iptrw);
    RegisterProperty('CAPTION', 'String', iptrw);
    RegisterProperty('COLOR', 'Longint', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNotifyEvent', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('CTL3D', 'Boolean', iptrw);
    RegisterProperty('LOCKED', 'Boolean', iptrw);
    RegisterProperty('PARENTCOLOR', 'Boolean', iptrw);
    RegisterProperty('PARENTCTL3D', 'Boolean', iptrw);
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONENTER', 'TNotifyEvent', iptrw);
    RegisterProperty('ONEXIT', 'TNotifyEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
    RegisterProperty('ONRESIZE', 'TNotifyEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;
{$IFNDEF CLX}
procedure SIRegisterTPAGE(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMCONTROL'), 'TPAGE') do
  begin
    RegisterProperty('CAPTION', 'String', iptrw);
  end;
end;
procedure SIRegisterTNOTEBOOK(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMCONTROL'),  'TNOTEBOOK') do
  begin
    RegisterProperty('ACTIVEPAGE', 'STRING', iptrw);
    RegisterProperty('COLOR', 'Longint', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('PAGEINDEX', 'INTEGER', iptrw);
    RegisterProperty('PAGES', 'TSTRINGS', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNotifyEvent', iptrw);
    RegisterProperty('ONPAGECHANGED', 'TNOTIFYEVENT', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('CTL3D', 'Boolean', iptrw);
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('PARENTCOLOR', 'Boolean', iptrw);
    RegisterProperty('PARENTCTL3D', 'Boolean', iptrw);
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONENTER', 'TNotifyEvent', iptrw);
    RegisterProperty('ONEXIT', 'TNotifyEvent', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMouseEvent', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMouseMoveEvent', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMouseEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTHEADER(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMCONTROL'), 'THEADER') do
  begin
    RegisterProperty('SECTIONWIDTH', 'INTEGER INTEGER', iptrw);
    RegisterProperty('ALLOWRESIZE', 'BOOLEAN', iptrw);
    RegisterProperty('BORDERSTYLE', 'TBORDERSTYLE', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('SECTIONS', 'TSTRINGS', iptrw);
    RegisterProperty('ONSIZING', 'TSECTIONEVENT', iptrw);
    RegisterProperty('ONSIZED', 'TSECTIONEVENT', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    {$ENDIF}
  end;
end;
{$ENDIF}

procedure SIRegisterTCUSTOMRADIOGROUP(Cl: TIFPSCompileTimeClassesImporter);
begin
  Cl.Add2(cl.FindClass('TCUSTOMGROUPBOX'), 'TCUSTOMRADIOGROUP');
end;

procedure SIRegisterTRADIOGROUP(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCUSTOMRADIOGROUP'), 'TRADIOGROUP') do
  begin
    RegisterProperty('CAPTION', 'String', iptrw);
    RegisterProperty('COLOR', 'Longint', iptrw);
    RegisterProperty('COLUMNS', 'Integer', iptrw);
    RegisterProperty('FONT', 'TFont', iptrw);
    RegisterProperty('ITEMINDEX', 'Integer', iptrw);
    RegisterProperty('ITEMS', 'TStrings', iptrw);
    RegisterProperty('ONCLICK', 'TNotifyEvent', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('CTL3D', 'Boolean', iptrw);
    RegisterProperty('DRAGCURSOR', 'Longint', iptrw);
    RegisterProperty('DRAGMODE', 'TDragMode', iptrw);
    RegisterProperty('PARENTCOLOR', 'Boolean', iptrw);
    RegisterProperty('PARENTCTL3D', 'Boolean', iptrw);
    RegisterProperty('PARENTFONT', 'Boolean', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'Boolean', iptrw);
    RegisterProperty('POPUPMENU', 'TPopupMenu', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDragDropEvent', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDragOverEvent', iptrw);
    RegisterProperty('ONENDDRAG', 'TEndDragEvent', iptrw);
    RegisterProperty('ONENTER', 'TNotifyEvent', iptrw);
    RegisterProperty('ONEXIT', 'TNotifyEvent', iptrw);
    RegisterProperty('ONSTARTDRAG', 'TStartDragEvent', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegister_ExtCtrls_TypesAndConsts(cl: TIFPSCompileTimeClassesImporter);
begin
  cl.se.AddTypeS('TShapeType', '(stRectangle, stSquare, stRoundRect, stRoundSquare, stEllipse, stCircle)');
  cl.se.AddTypeS('TBevelStyle', '(bsLowered, bsRaised)');
  cl.se.AddTypeS('TBevelShape', '(bsBox, bsFrame, bsTopLine, bsBottomLine, bsLeftLine, bsRightLine)');
  cl.se.AddTypeS('TPanelBevel', '(bvNone, bvLowered, bvRaised)');
  cl.se.AddTypeS('TBevelWidth', 'Longint');
  cl.se.AddTypeS('TBorderWidth', 'Longint');
  cl.se.AddTypeS('TSectionEvent', 'procedure(Sender: TObject; ASection, AWidth: Integer)');
end;

procedure SIRegister_ExtCtrls(cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_ExtCtrls_TypesAndConsts(cl);

  {$IFNDEF MINIVCL}
  SIRegisterTSHAPE(Cl);
  SIRegisterTPAINTBOX(Cl);
  SIRegisterTIMAGE(Cl);
  {$ENDIF}
  SIRegisterTBEVEL(Cl);
  {$IFNDEF MINIVCL}
  SIRegisterTTIMER(Cl);
  {$ENDIF}
  SIRegisterTCUSTOMPANEL(Cl);
  SIRegisterTPANEL(Cl);
  {$IFNDEF CLX}
  SIRegisterTPAGE(Cl);
  SIRegisterTNOTEBOOK(Cl);
  {$ENDIF}
  {$IFNDEF MINIVCL}
  {$IFNDEF CLX}
  SIRegisterTHEADER(Cl);
  {$ENDIF}
  SIRegisterTCUSTOMRADIOGROUP(Cl);
  SIRegisterTRADIOGROUP(Cl);
  {$ENDIF}
end;

end.





