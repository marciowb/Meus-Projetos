{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2007                   BBBBB   }

unit daDBISAMReg;

interface

{$I ppIfDef.pas}

uses
  Classes,
  DesignIntf,
  daDBISAM;

  {Delphi design time registration}
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
   {force BDS to load the package - disable demand package loading}
   ForceDemandLoadState(dlDisable);
{$ENDIF}

 
  {DataAccess Components}
  RegisterNoIcon([TdaChildDBISAMQuery, TdaChildDBISAMTable]);

  {DataViews}
  RegisterNoIcon([TdaDBISAMQueryDataView]);

end;


end.
