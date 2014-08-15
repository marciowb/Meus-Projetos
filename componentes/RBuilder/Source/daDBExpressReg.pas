{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2004                    BBBBB   }

unit daDBExpressReg;

interface

{$I ppIfDef.pas}

uses
  Classes,
  DesignIntf,
  daDBExpress;

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

  {SQL DataAccess Components}
  RegisterNoIcon([TdaChildSQLClientDataSet]);

  {SQL DataViews}
  RegisterNoIcon([TdaSQLQueryDataView]);

end;


end.
