unit ifpiir_controls;

{$I ifps3_def.inc}
interface
uses
  ifps3, ifps3common, ifps3utl, ifpiclassruntime;

{
  Will register files from:
    System
    Controls

  Register the STD, Classes and Graphics libraries first
}


procedure RIRegisterTControl(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTWinControl(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTGraphicControl(cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTCustomControl(cl: TIFPSRuntimeClassImporter);

procedure RIRegister_Controls(Cl: TIFPSRuntimeClassImporter);

implementation
uses
  Classes{$IFDEF CLX}, QControls, QGraphics{$ELSE}, Controls, Graphics{$ENDIF};

procedure TControlAlignR(Self: TControl; var T: Byte); begin T := Byte(Self.Align); end;
procedure TControlAlignW(Self: TControl; T: Byte); begin Self.Align:= TAlign(T); end;

procedure TControlClientHeightR(Self: TControl; var T: Longint); begin T := Self.ClientHeight; end;
procedure TControlClientHeightW(Self: TControl; T: Longint); begin Self.ClientHeight := T; end;

procedure TControlClientWidthR(Self: TControl; var T: Longint); begin T := Self.ClientWidth; end;
procedure TControlClientWidthW(Self: TControl; T: Longint); begin Self.ClientWidth:= T; end;

procedure TControlShowHintR(Self: TControl; var T: Boolean); begin T := Self.ShowHint; end;
procedure TControlShowHintW(Self: TControl; T: Boolean); begin Self.ShowHint:= T; end;

procedure TControlVisibleR(Self: TControl; var T: Boolean); begin T := Self.Visible; end;
procedure TControlVisibleW(Self: TControl; T: Boolean); begin Self.Visible:= T; end;

procedure TControlParentR(Self: TControl; var T: TWinControl); begin T := Self.Parent; end;
procedure TControlParentW(Self: TControl; T: TWinControl); begin Self.Parent:= T; end;


procedure TCONTROLSHOWHINT_W(Self: TCONTROL; T: BOOLEAN); begin Self.SHOWHINT := T; end;
procedure TCONTROLSHOWHINT_R(Self: TCONTROL; var T: BOOLEAN); begin T := Self.SHOWHINT; end;
procedure TCONTROLENABLED_W(Self: TCONTROL; T: BOOLEAN); begin Self.ENABLED := T; end;
procedure TCONTROLENABLED_R(Self: TCONTROL; var T: BOOLEAN); begin T := Self.ENABLED; end;

procedure RIRegisterTControl(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TControl) do
  begin
    RegisterVirtualConstructor(@TControl.Create, 'CREATE');
    RegisterMethod(@TControl.BRingToFront, 'BRINGTOFRONT');
    RegisterMethod(@TControl.Hide, 'HIDE');
    RegisterVirtualMethod(@TControl.Invalidate, 'INVALIDATE');
    RegisterMethod(@TControl.Refresh, 'REFRESH');
    RegisterVirtualMethod(@TControl.Repaint, 'REPAINT');
    RegisterMethod(@TControl.SendToBack, 'SENDTOBACK');
    RegisterMethod(@TControl.Show, 'SHOW');
    RegisterMethod(@TControl.Update, 'UPDATE');
    RegisterVirtualMethod(@TControl.SetBounds, 'SETBOUNDS');
    RegisterPropertyHelper(@TControlAlignR, @TControlAlignW, 'ALIGN');
    RegisterPropertyHelper(@TControlClientHeightR, @TControlClientHeightW, 'CLIENTHEIGHT');
    RegisterPropertyHelper(@TControlClientWidthR, @TControlClientWidthW, 'CLIENTWIDTH');
    RegisterPropertyHelper(@TControlShowHintR, @TControlShowHintW, 'SHOWHINT');
    RegisterPropertyHelper(@TControlVisibleR, @TControlVisibleW, 'VISIBLE');
    RegisterPropertyHelper(@TCONTROLENABLED_R, @TCONTROLENABLED_W, 'ENABLED');

    RegisterPropertyHelper(@TControlParentR, @TControlParentW, 'PARENT');

    {$IFNDEF MINIVCL}
    RegisterMethod(@TControl.Dragging, 'DRAGGING');
    RegisterMethod(@TControl.HasParent, 'HASPARENT');
    RegisterMethod(@TCONTROL.BEGINDRAG, 'BEGINDRAG');
    RegisterMethod(@TCONTROL.CLIENTTOSCREEN, 'CLIENTTOSCREEN');
    RegisterMethod(@TCONTROL.DRAGGING, 'DRAGGING');
    RegisterMethod(@TCONTROL.ENDDRAG, 'ENDDRAG');
    {$IFNDEF CLX}
    RegisterMethod(@TCONTROL.GETTEXTBUF, 'GETTEXTBUF');
    RegisterMethod(@TCONTROL.GETTEXTLEN, 'GETTEXTLEN');
    RegisterMethod(@TCONTROL.PERFORM, 'PERFORM');
    RegisterMethod(@TCONTROL.SETTEXTBUF, 'SETTEXTBUF');
    {$ENDIF}
    RegisterMethod(@TCONTROL.SCREENTOCLIENT, 'SCREENTOCLIENT');
    {$ENDIF}
  end;
end;
{$IFNDEF CLX}
procedure TWinControlHandleR(Self: TWinControl; var T: Longint); begin T := Self.Handle; end;
{$ENDIF}
procedure TWinControlShowingR(Self: TWinControl; var T: Boolean); begin T := Self.Showing; end;


procedure TWinControlTabOrderR(Self: TWinControl; var T: Longint); begin T := Self.TabOrder; end;
procedure TWinControlTabOrderW(Self: TWinControl; T: Longint); begin Self.TabOrder:= T; end;

procedure TWinControlTabStopR(Self: TWinControl; var T: Boolean); begin T := Self.TabStop; end;
procedure TWinControlTabStopW(Self: TWinControl; T: Boolean); begin Self.TabStop:= T; end;
procedure TWINCONTROLBRUSH_R(Self: TWINCONTROL; var T: TBRUSH); begin T := Self.BRUSH; end;
procedure TWINCONTROLCONTROLS_R(Self: TWINCONTROL; var T: TCONTROL; t1: INTEGER); begin t := Self.CONTROLS[t1]; end;
procedure TWINCONTROLCONTROLCOUNT_R(Self: TWINCONTROL; var T: INTEGER); begin t := Self.CONTROLCOUNT; end;

procedure RIRegisterTWinControl(Cl: TIFPSRuntimeClassImporter); // requires TControl
begin
  with Cl.Add(TWinControl) do
  begin
    {$IFNDEF CLX}
    RegisterPropertyHelper(@TWinControlHandleR, nil, 'HANDLE');
    {$ENDIF}
    RegisterPropertyHelper(@TWinControlShowingR, nil, 'SHOWING');
    RegisterPropertyHelper(@TWinControlTabOrderR, @TWinControlTabOrderW, 'TABORDER');
    RegisterPropertyHelper(@TWinControlTabStopR, @TWinControlTabStopW, 'TABSTOP');
    RegisterMethod(@TWINCONTROL.CANFOCUS, 'CANFOCUS');
    RegisterMethod(@TWINCONTROL.FOCUSED, 'FOCUSED');
    RegisterPropertyHelper(@TWINCONTROLCONTROLS_R, nil, 'CONTROLS');
    RegisterPropertyHelper(@TWINCONTROLCONTROLCOUNT_R, nil, 'CONTROLCOUNT');

    {$IFNDEF MINIVCL}
    RegisterMethod(@TWinControl.HandleAllocated, 'HANDLEALLOCATED');
    RegisterMethod(@TWinControl.HandleNeeded, 'HANDLENEEDED');
    RegisterMethod(@TWinControl.EnableAlign, 'ENABLEALIGN');
    RegisterMethod(@TWinControl.RemoveControl, 'REMOVECONTROL');
    RegisterMethod(@TWinControl.InsertControl, 'INSERTCONTROL');
    RegisterMethod(@TWinControl.Realign, 'REALIGN');
    RegisterMethod(@TWinControl.ScaleBy, 'SCALEBY');
    RegisterMethod(@TWinControl.ScrollBy, 'SCROLLBY');
    RegisterVirtualMethod(@TWinControl.SetFocus, 'SETFOCUS');
    RegisterMethod(@TWINCONTROL.CONTAINSCONTROL, 'CONTAINSCONTROL');
    RegisterMethod(@TWINCONTROL.DISABLEALIGN, 'DISABLEALIGN');
    {$IFNDEF CLX}
    RegisterMethod(@TWINCONTROL.PAINTTO, 'PAINTTO');
    {$ENDIF}
    RegisterMethod(@TWINCONTROL.UPDATECONTROLSTATE, 'UPDATECONTROLSTATE');
    RegisterPropertyHelper(@TWINCONTROLBRUSH_R, nil, 'BRUSH');
    {$ENDIF}
  end;
end;

procedure RIRegisterTGraphicControl(cl: TIFPSRuntimeClassImporter); // requires TControl
begin
  Cl.Add(TGraphicControl);
end;
procedure RIRegisterTCustomControl(cl: TIFPSRuntimeClassImporter); // requires TControl
begin
  Cl.Add(TCustomControl);
end;

procedure RIRegister_Controls(Cl: TIFPSRuntimeClassImporter);
begin
  RIRegisterTControl(Cl);
  RIRegisterTWinControl(Cl);
  RIRegisterTGraphicControl(cl);
  RIRegisterTCustomControl(cl);
end;

// MiniVCL changes by Martijn Laan (mlaan at wintax _dot_ nl)


end.
