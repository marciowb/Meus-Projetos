unit ifpii_forms;
{$I ifps3_def.inc}

interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;

procedure SIRegister_Forms_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);


procedure SIRegisterTCONTROLSCROLLBAR(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTSCROLLINGWINCONTROL(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTSCROLLBOX(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTFORM(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTAPPLICATION(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegister_Forms(Cl: TIFPSCompileTimeClassesImporter);

implementation

procedure SIRegisterTCONTROLSCROLLBAR(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TPERSISTENT'), 'TCONTROLSCROLLBAR') do
  begin
    RegisterProperty('KIND', 'TSCROLLBARKIND', iptr);
    RegisterProperty('SCROLLPOS', 'INTEGER', iptr);
    RegisterProperty('MARGIN', 'WORD', iptrw);
    RegisterProperty('INCREMENT', 'TSCROLLBARINC', iptrw);
    RegisterProperty('RANGE', 'INTEGER', iptrw);
    RegisterProperty('POSITION', 'INTEGER', iptrw);
    RegisterProperty('TRACKING', 'BOOLEAN', iptrw);
    RegisterProperty('VISIBLE', 'BOOLEAN', iptrw);
  end;
end;

procedure SIRegisterTSCROLLINGWINCONTROL(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TWINCONTROL'), 'TSCROLLINGWINCONTROL') do
  begin
    RegisterMethod('procedure SCROLLINVIEW(ACONTROL:TCONTROL)');
    RegisterProperty('HORZSCROLLBAR', 'TCONTROLSCROLLBAR', iptrw);
    RegisterProperty('VERTSCROLLBAR', 'TCONTROLSCROLLBAR', iptrw);
  end;
end;

procedure SIRegisterTSCROLLBOX(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TSCROLLINGWINCONTROL'), 'TSCROLLBOX') do
  begin
    RegisterProperty('BORDERSTYLE', 'TBORDERSTYLE', iptrw);
    RegisterProperty('COLOR', 'TCOLOR', iptrw);
    RegisterProperty('FONT', 'TFONT', iptrw);
    RegisterProperty('AUTOSCROLL', 'BOOLEAN', iptrw);
    RegisterProperty('ONCLICK', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNOTIFYEVENT', iptrw);

    {$IFNDEF MINIVCL}
    RegisterProperty('ONRESIZE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('DRAGCURSOR', 'TCURSOR', iptrw);
    RegisterProperty('DRAGMODE', 'TDRAGMODE', iptrw);
    RegisterProperty('PARENTCOLOR', 'BOOLEAN', iptrw);
    RegisterProperty('PARENTFONT', 'BOOLEAN', iptrw);
    RegisterProperty('PARENTSHOWHINT', 'BOOLEAN', iptrw);
    RegisterProperty('POPUPMENU', 'TPOPUPMENU', iptrw);
    RegisterProperty('CTL3D', 'BOOLEAN', iptrw);
    RegisterProperty('PARENTCTL3D', 'BOOLEAN', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDRAGDROPEVENT', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDRAGOVEREVENT', iptrw);
    RegisterProperty('ONENDDRAG', 'TENDDRAGEVENT', iptrw);
    RegisterProperty('ONENTER', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONEXIT', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMOUSEEVENT', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMOUSEMOVEEVENT', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMOUSEEVENT', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTFORM(Cl: TIFPSCompileTimeClassesImporter);
begin
 with Cl.Add2(cl.FindClass('TSCROLLINGWINCONTROL'), 'TFORM') do
  begin
    RegisterMethod('constructor CREATENEW(AOWNER:TCOMPONENT; Dummy: Longint)');
    RegisterMethod('procedure CLOSE');
    RegisterMethod('procedure HIDE');
    RegisterMethod('procedure SHOW');
    RegisterMethod('function SHOWMODAL:INTEGER');
    RegisterMethod('procedure RELEASE');
    RegisterProperty('ACTIVE', 'BOOLEAN', iptr);
    RegisterProperty('ACTIVECONTROL', 'TWINCONTROL', iptrw);
    RegisterProperty('BORDERICONS', 'Longint', iptrw);
    RegisterProperty('BORDERSTYLE', 'TFORMBORDERSTYLE', iptrw);
    RegisterProperty('CAPTION', 'STRING', iptrw);
    RegisterProperty('AUTOSCROLL', 'BOOLEAN', iptrw);
    RegisterProperty('COLOR', 'TCOLOR', iptrw);
    RegisterProperty('FONT', 'TFONT', iptrw);
    RegisterProperty('FORMSTYLE', 'TFORMSTYLE', iptrw);
    RegisterProperty('KEYPREVIEW', 'BOOLEAN', iptrw);
    RegisterProperty('POSITION', 'TPOSITION', iptrw);
    RegisterProperty('ONACTIVATE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONCLICK', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONDBLCLICK', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONCLOSE', 'TCLOSEEVENT', iptrw);
    RegisterProperty('ONCLOSEQUERY', 'TCLOSEQUERYEVENT', iptrw);
    RegisterProperty('ONCREATE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONDESTROY', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONDEACTIVATE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONHIDE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONKEYDOWN', 'TKEYEVENT', iptrw);
    RegisterProperty('ONKEYPRESS', 'TKEYPRESSEVENT', iptrw);
    RegisterProperty('ONKEYUP', 'TKEYEVENT', iptrw);
    RegisterProperty('ONRESIZE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONSHOW', 'TNOTIFYEVENT', iptrw);


    {$IFNDEF MINIVCL}
    {$IFNDEF CLX}
    RegisterMethod('procedure ARRANGEICONS');
    RegisterMethod('function GETFORMIMAGE:TBITMAP');
    RegisterMethod('procedure PRINT');
    RegisterMethod('procedure SENDCANCELMODE(SENDER:TCONTROL)');
    RegisterProperty('ACTIVEOLECONTROL', 'TWINCONTROL', iptrw);
    RegisterProperty('OLEFORMOBJECT', 'TOLEFORMOBJECT', iptrw);
    RegisterProperty('CLIENTHANDLE', 'LONGINT', iptr);
    RegisterProperty('TILEMODE', 'TTILEMODE', iptrw);
    {$ENDIF}
    RegisterMethod('procedure CASCADE');
    RegisterMethod('function CLOSEQUERY:BOOLEAN');
    RegisterMethod('procedure DEFOCUSCONTROL(CONTROL:TWINCONTROL;REMOVING:BOOLEAN)');
    RegisterMethod('procedure FOCUSCONTROL(CONTROL:TWINCONTROL)');
    RegisterMethod('procedure NEXT');
    RegisterMethod('procedure PREVIOUS');
    RegisterMethod('function SETFOCUSEDCONTROL(CONTROL:TWINCONTROL):BOOLEAN');
    RegisterMethod('procedure TILE');
    RegisterProperty('ACTIVEMDICHILD', 'TFORM', iptr);
    RegisterProperty('CANVAS', 'TCANVAS', iptr);
    RegisterProperty('DROPTARGET', 'BOOLEAN', iptrw);
    RegisterProperty('MODALRESULT', 'Longint', iptrw);
    RegisterProperty('MDICHILDCOUNT', 'INTEGER', iptr);
    RegisterProperty('MDICHILDREN:INTEGER', 'TFORM INTEGER', iptr);
    RegisterProperty('ICON', 'TICON', iptrw);
    RegisterProperty('MENU', 'TMAINMENU', iptrw);
    RegisterProperty('OBJECTMENUITEM', 'TMENUITEM', iptrw);
    RegisterProperty('PIXELSPERINCH', 'INTEGER', iptrw);
    RegisterProperty('PRINTSCALE', 'TPRINTSCALE', iptrw);
    RegisterProperty('SCALED', 'BOOLEAN', iptrw);
    RegisterProperty('WINDOWSTATE', 'TWINDOWSTATE', iptrw);
    RegisterProperty('WINDOWMENU', 'TMENUITEM', iptrw);
    RegisterProperty('CTL3D', 'BOOLEAN', iptrw);
    RegisterProperty('POPUPMENU', 'TPOPUPMENU', iptrw);
    RegisterProperty('ONDRAGDROP', 'TDRAGDROPEVENT', iptrw);
    RegisterProperty('ONDRAGOVER', 'TDRAGOVEREVENT', iptrw);
    RegisterProperty('ONMOUSEDOWN', 'TMOUSEEVENT', iptrw);
    RegisterProperty('ONMOUSEMOVE', 'TMOUSEMOVEEVENT', iptrw);
    RegisterProperty('ONMOUSEUP', 'TMOUSEEVENT', iptrw);
    RegisterProperty('ONPAINT', 'TNOTIFYEVENT', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTAPPLICATION(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TCOMPONENT'), 'TAPPLICATION') do
  begin
    RegisterMethod('procedure BRINGTOFRONT');
    RegisterMethod('function MESSAGEBOX(TEXT,CAPTION:PCHAR;FLAGS:WORD):INTEGER');
    RegisterMethod('procedure MINIMIZE');
    RegisterMethod('procedure PROCESSMESSAGES');
    RegisterMethod('procedure RESTORE');
    RegisterMethod('procedure TERMINATE');
    RegisterProperty('ACTIVE', 'BOOLEAN', iptr);
    RegisterProperty('EXENAME', 'STRING', iptr);
    {$IFNDEF CLX}
    RegisterProperty('HANDLE', 'LONGINT', iptrw);
    RegisterProperty('UPDATEFORMATSETTINGS', 'BOOLEAN', iptrw);
    {$ENDIF}
    RegisterProperty('HINT', 'STRING', iptrw);
    RegisterProperty('MAINFORM', 'TFORM', iptr);
    RegisterProperty('SHOWHINT', 'BOOLEAN', iptrw);
    RegisterProperty('SHOWMAINFORM', 'BOOLEAN', iptrw);
    RegisterProperty('TERMINATED', 'BOOLEAN', iptr);
    RegisterProperty('TITLE', 'STRING', iptrw);
    RegisterProperty('ONACTIVATE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONDEACTIVATE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONIDLE', 'TIDLEEVENT', iptrw);
    RegisterProperty('ONHINT', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONMINIMIZE', 'TNOTIFYEVENT', iptrw);
    RegisterProperty('ONRESTORE', 'TNOTIFYEVENT', iptrw);

    {$IFNDEF MINIVCL}
    RegisterMethod('procedure CONTROLDESTROYED(CONTROL:TCONTROL)');
    RegisterMethod('procedure CANCELHINT');
    RegisterMethod('procedure HANDLEEXCEPTION(SENDER:TOBJECT)');
    RegisterMethod('procedure HANDLEMESSAGE');
    RegisterMethod('procedure HIDEHINT');
    RegisterMethod('procedure HINTMOUSEMESSAGE(CONTROL:TCONTROL;var MESSAGE:TMESSAGE)');
    RegisterMethod('procedure INITIALIZE');
    RegisterMethod('procedure NORMALIZETOPMOSTS');
    RegisterMethod('procedure RESTORETOPMOSTS');
    RegisterMethod('procedure RUN');
    RegisterMethod('procedure SHOWEXCEPTION(E:EXCEPTION)');
    {$IFNDEF CLX}
    RegisterMethod('function HELPCOMMAND(COMMAND:INTEGER;DATA:LONGINT):BOOLEAN');
    RegisterMethod('function HELPCONTEXT(CONTEXT:THELPCONTEXT):BOOLEAN');
    RegisterMethod('function HELPJUMP(JUMPID:STRING):BOOLEAN');
    RegisterProperty('DIALOGHANDLE', 'LONGINT', iptrw);
    RegisterMethod('procedure CREATEHANDLE');
    RegisterMethod('procedure HOOKMAINWINDOW(HOOK:TWINDOWHOOK)');
    RegisterMethod('procedure UNHOOKMAINWINDOW(HOOK:TWINDOWHOOK)');
    {$ENDIF}
    RegisterProperty('HELPFILE', 'STRING', iptrw);
    RegisterProperty('HINTCOLOR', 'TCOLOR', iptrw);
    RegisterProperty('HINTPAUSE', 'INTEGER', iptrw);
    RegisterProperty('HINTSHORTPAUSE', 'INTEGER', iptrw);
    RegisterProperty('HINTHIDEPAUSE', 'INTEGER', iptrw);
    RegisterProperty('ICON', 'TICON', iptrw);
    RegisterProperty('ONHELP', 'THELPEVENT', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegister_Forms_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
  Cl.Se.AddTypeS('TIdleEvent', 'procedure (Sender: TObject; var Done: Boolean)');
  Cl.SE.AddTypeS('TScrollBarKind', '(sbHorizontal, sbVertical)');
  Cl.SE.AddTypeS('TFormBorderStyle', '(bsNone, bsSingle, bsSizeable, bsDialog, bsToolWindow, bsSizeToolWin)');
  Cl.Se.AddTypeS('TBorderStyle', 'TFormBorderStyle');
  Cl.SE.AddTypeS('TWindowState', '(wsNormal, wsMinimized, wsMaximized)');
  Cl.SE.AddTypeS('TFormStyle', '(fsNormal, fsMDIChild, fsMDIForm, fsStayOnTop)');
  Cl.SE.AddTypeS('TPosition', '(poDesigned, poDefault, poDefaultPosOnly, poDefaultSizeOnly, poScreenCenter)');
  Cl.SE.AddTypeS('TPrintScale', '(poNone, poProportional, poPrintToFit)');
  Cl.SE.AddTypeS('TCloseAction', '(caNone, caHide, caFree, caMinimize)');
  Cl.SE.AddTypeS('TCloseEvent' ,'procedure(Sender: TObject; var Action: TCloseAction)');
  Cl.SE.AddTypeS('TCloseQueryEvent' ,'procedure(Sender: TObject; var CanClose: Boolean)');
  Cl.SE.AddConstantN('biSystemMenu', 'Byte')^.Value.tu8 := 1;
  Cl.SE.AddConstantN('biMinimize', 'Byte')^.Value.tu8 := 2;
  Cl.SE.AddConstantN('biMaximize', 'Byte')^.Value.tu8 := 4;
  Cl.SE.AddConstantN('biHelp', 'Byte')^.Value.tu8 := 8;
end;

procedure SIRegister_Forms(Cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_Forms_TypesAndConsts(cl);

  {$IFNDEF MINIVCL}
  SIRegisterTCONTROLSCROLLBAR(cl);
  {$ENDIF}
  SIRegisterTScrollingWinControl(cl);
  {$IFNDEF MINIVCL}
  SIRegisterTSCROLLBOX(cl);
  {$ENDIF}
  SIRegisterTForm(Cl);
  {$IFNDEF MINIVCL}
  SIRegisterTApplication(Cl);
  {$ENDIF}
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


end.

