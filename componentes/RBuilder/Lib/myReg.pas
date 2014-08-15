{******************************************************************************}
{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2006                    BBBBB   }

unit myReg;

interface

{$I ppIfDef.pas}

uses
  DesignIntf,
  Classes,  {contains RegisterNoIcon, which allows the design-time registration of the component}
  myChkBox,
  myChkBoxDesign; {contains TmyCheckBox and TmyDBCheckBox, the components being registered}


{declare Register procedure so component can be used at design-time}
procedure Register;

implementation

{******************************************************************************
 *
 ** R E G I S T E R
 *
{******************************************************************************}


procedure Register;
begin

{$IFDEF Delphi9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  {register the component for use in the Delphi design-time report designer}
  RegisterNoIcon([TmyCheckBox]);
  RegisterNoIcon([TmyDBCheckBox]);

end;


end.
