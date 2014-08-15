unit ifpii_controls;
{$I ifps3_def.inc}
interface
uses
  ifpscomp, ifps3common, ifps3utl, ifpiclass;
{
  Will register files from:
    Controls

  Register the STD, Classes (at least the types&consts) and Graphics libraries first

}

procedure SIRegister_Controls_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);

procedure SIRegisterTControl(Cl: TIFPSCompileTimeClassesImporter);
procedure SIRegisterTWinControl(Cl: TIFPSCompileTimeClassesImporter); // requires TControl
procedure SIRegisterTGraphicControl(cl: TIFPSCompileTimeClassesImporter); // requires TControl
procedure SIRegisterTCustomControl(cl: TIFPSCompileTimeClassesImporter); // requires TWinControl


procedure SIRegister_Controls(Cl: TIFPSCompileTimeClassesImporter);


implementation

procedure SIRegisterTControl(Cl: TIFPSCompileTimeClassesImporter);
begin
  with Cl.Add2(cl.FindClass('TComponent'), 'TCONTROL') do
  begin
    RegisterMethod('constructor Create(AOwner: TComponent);');
    RegisterMethod('procedure BringToFront;');
    RegisterMethod('procedure Hide;');
    RegisterMethod('procedure Invalidate;virtual;');
    RegisterMethod('procedure refresh;');
    RegisterMethod('procedure Repaint;virtual;');
    RegisterMethod('procedure SendToBack;');
    RegisterMethod('procedure Show;');
    RegisterMethod('procedure Update;');
    RegisterMethod('procedure SetBounds(x,y,w,h: Integer);virtual;');
    RegisterProperty('Left', 'Integer', iptRW);
    RegisterProperty('Top', 'Integer', iptRW);
    RegisterProperty('Width', 'Integer', iptRW);
    RegisterProperty('Height', 'Integer', iptRW);
    RegisterProperty('Hint', 'String', iptRW);
    RegisterProperty('Align', 'TAlign', iptRW);
    RegisterProperty('ClientHeight', 'Longint', iptRW);
    RegisterProperty('ClientWidth', 'Longint', iptRW);
    RegisterProperty('ShowHint', 'Boolean', iptRW);
    RegisterProperty('Visible', 'Boolean', iptRW);
    RegisterProperty('ENABLED', 'BOOLEAN', iptrw);
    RegisterProperty('HINT', 'STRING', iptrw);

    {$IFNDEF MINIVCL}
    RegisterMethod('function Dragging: Boolean;');
    RegisterProperty('HasParent', 'Boolean', iptr);
    RegisterMethod('procedure BEGINDRAG(IMMEDIATE:BOOLEAN)');
    RegisterMethod('function CLIENTTOSCREEN(POINT:TPOINT):TPOINT');
    RegisterMethod('procedure ENDDRAG(DROP:BOOLEAN)');
    {$IFNDEF CLX}
    RegisterMethod('function GETTEXTBUF(BUFFER:PCHAR;BUFSIZE:INTEGER):INTEGER');
    RegisterMethod('function GETTEXTLEN:INTEGER');
    RegisterMethod('procedure SETTEXTBUF(BUFFER:PCHAR)');
    RegisterMethod('function PERFORM(MSG:CARDINAL;WPARAM,LPARAM:LONGINT):LONGINT');
    {$ENDIF}
    RegisterMethod('function SCREENTOCLIENT(POINT:TPOINT):TPOINT');
    RegisterProperty('CURSOR', 'TCURSOR', iptrw);
    {$ENDIF}
  end;
end;

procedure SIRegisterTWinControl(Cl: TIFPSCompileTimeClassesImporter); // requires TControl
begin
  with Cl.Add2(cl.FindClass('TControl'), 'TWINCONTROL') do
  begin

    with Cl.FindClass('TControl') do
    begin
      RegisterProperty('Parent', 'TWinControl', iptRW);
    end;

    {$IFNDEF CLX}
    RegisterProperty('Handle', 'Longint', iptRW);
    {$ENDIF}
    RegisterProperty('Showing', 'Boolean', iptR);
    RegisterProperty('TabOrder', 'Integer', iptRW);
    RegisterProperty('TabStop', 'Boolean', iptRW);
    RegisterMethod('function CANFOCUS:BOOLEAN');
    RegisterMethod('function FOCUSED:BOOLEAN');
    RegisterProperty('CONTROLS', 'TCONTROL INTEGER', iptr);
    RegisterProperty('CONTROLCOUNT', 'INTEGER', iptr);

    {$IFNDEF MINIVCL}
    RegisterMethod('function HandleAllocated: Boolean;');
    RegisterMethod('procedure HandleNeeded;');
    RegisterMethod('procedure EnableAlign;');
    RegisterMethod('procedure RemoveControl(AControl: TControl);');
    RegisterMethod('procedure InsertControl(AControl: TControl);');
    RegisterMethod('procedure Realign;');
    RegisterMethod('procedure ScaleBy(M, D: Integer);');
    RegisterMethod('procedure ScrollBy(DeltaX, DeltaY: Integer);');
    RegisterMethod('procedure SetFocus; virtual;');
    {$IFNDEF CLX}
    RegisterMethod('procedure PAINTTO(DC:Longint;X,Y:INTEGER)');
    {$ENDIF}
    RegisterMethod('function CONTAINSCONTROL(CONTROL:TCONTROL):BOOLEAN');
    RegisterMethod('procedure DISABLEALIGN');
    RegisterMethod('procedure UPDATECONTROLSTATE');
    RegisterProperty('BRUSH', 'TBRUSH', iptr);
    RegisterProperty('HELPCONTEXT', 'LONGINT', iptrw);
    {$ENDIF}
  end;
end;
procedure SIRegisterTGraphicControl(cl: TIFPSCompileTimeClassesImporter); // requires TControl
begin
  Cl.Add2(cl.FindClass('TControl'), 'TGRAPHICCONTROL');
end;

procedure SIRegisterTCustomControl(cl: TIFPSCompileTimeClassesImporter); // requires TWinControl
begin
  Cl.Add2(cl.FindClass('TWinControl'), 'TCUSTOMCONTROL');
end;

procedure SIRegister_Controls_TypesAndConsts(Cl: TIFPSCompileTimeClassesImporter);
begin
 Cl.se.AddTypeS('TMouseEvent', 'procedure(Sender: TObject; Button: Byte; Shift: Byte; X, Y: Integer);');
  cl.se.AddTypeS('TMouseMoveEvent', 'procedure(Sender: TObject; Shift: Byte; X, Y: Integer);');
  cl.se.AddTypeS('TKeyEvent', 'procedure(Sender: TObject; var Key: Word; Shift: Byte);');
  cl.se.AddTypeS('TKeyPressEvent', 'procedure(Sender: TObject; var Key: Char);');
  cl.se.AddTypeS('TMouseButton', '(mbLeft, mbRight, mbMiddle)');
  cl.se.AddTypeS('TDragMode', '(dmManual, dmAutomatic)');
  cl.se.AddTypeS('TDragState', '(dsDragEnter, dsDragLeave, dsDragMove)');
  cl.se.AddTypeS('TDragKind', '(dkDrag, dkDock)');
  cl.se.AddTypeS('TDragOverEvent', 'procedure(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean)');
  cl.se.AddTypeS('TDragDropEvent', 'procedure(Sender, Source: TObject;X, Y: Integer)');
  cl.se.AddTypeS('TEndDragEvent', 'procedure(Sender, Target: TObject; X, Y: Integer)');

  cl.se.addTypeS('TAlign', '(alNone, alTop, alBottom, alLeft, alRight, alClient)');

  cl.se.AddConstantN('akLeft', 'Byte')^.Value.tu8 := 1;
  cl.se.AddConstantN('akTop', 'Byte')^.Value.tu8 := 2;
  cl.se.AddConstantN('akRight', 'Byte')^.Value.tu8 := 4;
  cl.se.AddConstantN('akbottom', 'Byte')^.Value.tu8 := 8;
  cl.se.AddConstantN('mrNone', 'Integer')^.Value.ts32 := 0;
  cl.se.AddConstantN('mrOk', 'Integer')^.Value.ts32 := 1;
  cl.se.AddConstantN('mrCancel', 'Integer')^.Value.ts32 := 2;
  cl.se.AddConstantN('mrAbort', 'Integer')^.Value.ts32 := 3;
  cl.se.AddConstantN('mrRetry', 'Integer')^.Value.ts32 := 4;
  cl.se.AddConstantN('mrIgnore', 'Integer')^.Value.ts32 := 5;
  cl.se.AddConstantN('mrYes', 'Integer')^.Value.ts32 := 6;
  cl.se.AddConstantN('mrNo', 'Integer')^.Value.ts32 := 7;
  cl.se.AddConstantN('mrAll', 'Integer')^.Value.ts32 := 8;
  cl.se.AddConstantN('mrNoToAll', 'Integer')^.Value.ts32 := 9;
  cl.se.AddConstantN('mrYesToAll', 'Integer')^.Value.ts32 := 10;
  cl.se.AddConstantN('crDefault', 'Integer')^.Value.ts32 := 0;
  cl.se.AddConstantN('crNone', 'Integer')^.Value.ts32 := -1;
  cl.se.AddConstantN('crArrow', 'Integer')^.Value.ts32 := -2;
  cl.se.AddConstantN('crCross', 'Integer')^.Value.ts32 := -3;
  cl.se.AddConstantN('crIBeam', 'Integer')^.Value.ts32 := -4;
  cl.se.AddConstantN('crSize', 'Integer')^.Value.ts32 := -22;
  cl.se.AddConstantN('crSizeNESW', 'Integer')^.Value.ts32 := -6;
  cl.se.AddConstantN('crSizeNS', 'Integer')^.Value.ts32 := -7;
  cl.se.AddConstantN('crSizeNWSE', 'Integer')^.Value.ts32 := -8;
  cl.se.AddConstantN('crSizeWE', 'Integer')^.Value.ts32 := -9;
  cl.se.AddConstantN('crUpArrow', 'Integer')^.Value.ts32 := -10;
  cl.se.AddConstantN('crHourGlass', 'Integer')^.Value.ts32 := -11;
  cl.se.AddConstantN('crDrag', 'Integer')^.Value.ts32 := -12;
  cl.se.AddConstantN('crNoDrop', 'Integer')^.Value.ts32 := -13;
  cl.se.AddConstantN('crHSplit', 'Integer')^.Value.ts32 := -14;
  cl.se.AddConstantN('crVSplit', 'Integer')^.Value.ts32 := -15;
  cl.se.AddConstantN('crMultiDrag', 'Integer')^.Value.ts32 := -16;
  cl.se.AddConstantN('crSQLWait', 'Integer')^.Value.ts32 := -17;
  cl.se.AddConstantN('crNo', 'Integer')^.Value.ts32 := -18;
  cl.se.AddConstantN('crAppStart', 'Integer')^.Value.ts32 := -19;
  cl.se.AddConstantN('crHelp', 'Integer')^.Value.ts32 := -20;
end;

procedure SIRegister_Controls(Cl: TIFPSCompileTimeClassesImporter);
begin
  SIRegister_Controls_TypesAndConsts(cl);

  SIRegisterTControl(Cl);
  SIRegisterTWinControl(Cl);
  SIRegisterTGraphicControl(cl);
  SIRegisterTCustomControl(cl);
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)

end.
