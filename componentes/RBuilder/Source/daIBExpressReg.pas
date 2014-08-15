{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit daIBExpressReg;

interface

{$I ppIfDef.pas}

uses
  Classes,
  DesignIntf,
  daIBExpress;

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
  {force BDS to load the package - disable demand package loading}
  ForceDemandLoadState(dlDisable);

 {IBX DataAccess Components}
  RegisterNoIcon([TdaChildIBXQuery, TdaChildIBXTable, TdaChildIBXStoredProc]);

  {IBX DataViews}
  RegisterNoIcon([TdaIBXQueryDataView]);

end;


end.
