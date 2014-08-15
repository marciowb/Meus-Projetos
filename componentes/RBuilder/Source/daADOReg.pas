{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit daADOReg;

interface

{$I ppIfDef.pas}

uses
  Classes,
  DesignIntf,
  daADO;

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
 
  {ADO DataAccess Components}
  RegisterNoIcon([TdaChildADOQuery, TdaChildADOTable, TdaChildADOStoredProc]);

  {ADO DataViews}
  RegisterNoIcon([TdaADOQueryDataView]);

end;


end.
