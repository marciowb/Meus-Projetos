{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit USecCoreReg;

{$R uSecCoreReg.res}

interface

uses
  Classes,
  uSecControl,
  uFormPolicy,
  uProxy;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TMS Security', [TuilSecurityManager, TuilFormPolicy, TuilProxy]);
end;
end.
