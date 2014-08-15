unit ifpiir_extctrls;

{$I ifps3_def.inc}
interface
uses
  ifps3, ifps3common, ifps3utl, ifpiclassruntime;
(*
   Will register files from:
     ExtCtrls

Requires:
  STD, classes, controls, graphics {$IFNDEF MINIVCL}, stdctrls {$ENDIF}
*)

procedure RIRegister_ExtCtrls(cl: TIFPSRuntimeClassImporter);

procedure RIRegisterTSHAPE(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTPAINTBOX(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTIMAGE(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTBEVEL(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTTIMER(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTCUSTOMPANEL(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTPANEL(Cl: TIFPSRuntimeClassImporter);
{$IFNDEF CLX}
procedure RIRegisterTPAGE(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTNOTEBOOK(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTHEADER(Cl: TIFPSRuntimeClassImporter);
{$ENDIF}
procedure RIRegisterTCUSTOMRADIOGROUP(Cl: TIFPSRuntimeClassImporter);
procedure RIRegisterTRADIOGROUP(Cl: TIFPSRuntimeClassImporter);

implementation

uses
  {$IFDEF CLX}
  QExtCtrls, QGraphics;
  {$ELSE}
  ExtCtrls, Graphics;
  {$ENDIF}

procedure RIRegisterTSHAPE(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TSHAPE) do
  begin
    {$IFNDEF MINIVCL}
    RegisterMethod(@TSHAPE.STYLECHANGED, 'STYLECHANGED');
    {$ENDIF}
  end;
end;

procedure TPAINTBOXCANVAS_R(Self: TPAINTBOX; var T: TCanvas); begin T := Self.CANVAS; end;

procedure RIRegisterTPAINTBOX(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TPAINTBOX) do
  begin
    RegisterPropertyHelper(@TPAINTBOXCANVAS_R, nil, 'CANVAS');
  end;
end;

procedure TIMAGECANVAS_R(Self: TIMAGE; var T: TCANVAS); begin T := Self.CANVAS; end;

procedure RIRegisterTIMAGE(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(TIMAGE) do
  begin
    RegisterPropertyHelper(@TIMAGECANVAS_R, nil, 'CANVAS');
  end;
end;

procedure RIRegisterTBEVEL(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TBEVEL);
end;

procedure RIRegisterTTIMER(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TTIMER);
end;

procedure RIRegisterTCUSTOMPANEL(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TCUSTOMPANEL);
end;

procedure RIRegisterTPANEL(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TPANEL);
end;
{$IFNDEF CLX}
procedure RIRegisterTPAGE(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TPAGE);
end;

procedure RIRegisterTNOTEBOOK(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TNOTEBOOK);
end;

procedure THEADERSECTIONWIDTH_R(Self: THEADER; var T: INTEGER; t1: INTEGER); begin T := Self.SECTIONWIDTH[t1]; end;
procedure THEADERSECTIONWIDTH_W(Self: THEADER; T: INTEGER; t1: INTEGER); begin Self.SECTIONWIDTH[t1] := T; end;

procedure RIRegisterTHEADER(Cl: TIFPSRuntimeClassImporter);
begin
  with Cl.Add(THEADER) do
  begin
    RegisterPropertyHelper(@THEADERSECTIONWIDTH_R, @THEADERSECTIONWIDTH_W, 'SECTIONWIDTH');
  end;
end;
{$ENDIF}

procedure RIRegisterTCUSTOMRADIOGROUP(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TCUSTOMRADIOGROUP);
end;

procedure RIRegisterTRADIOGROUP(Cl: TIFPSRuntimeClassImporter);
begin
  Cl.Add(TRADIOGROUP);
end;

procedure RIRegister_ExtCtrls(cl: TIFPSRuntimeClassImporter);
begin
  {$IFNDEF MINIVCL}
  RIRegisterTSHAPE(Cl);
  RIRegisterTPAINTBOX(Cl);
  RIRegisterTIMAGE(Cl);
  {$ENDIF}
  RIRegisterTBEVEL(Cl);
  {$IFNDEF MINIVCL}
  RIRegisterTTIMER(Cl);
  {$ENDIF}
  RIRegisterTCUSTOMPANEL(Cl);
{$IFNDEF CLX}
  RIRegisterTPANEL(Cl);
  RIRegisterTPAGE(Cl);
  RIRegisterTNOTEBOOK(Cl);
{$ENDIF}
  {$IFNDEF MINIVCL}
{$IFNDEF CLX}
  RIRegisterTHEADER(Cl);
{$ENDIF}
  RIRegisterTCUSTOMRADIOGROUP(Cl);
  RIRegisterTRADIOGROUP(Cl);
  {$ENDIF}
end;

end.


