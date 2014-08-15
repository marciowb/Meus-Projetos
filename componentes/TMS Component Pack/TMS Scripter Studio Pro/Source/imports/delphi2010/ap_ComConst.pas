{***************************************************************************}
{ This source code was generated automatically by                           }
{ Pas file import tool for Scripter Studio (Pro)                            }
{                                                                           }
{ Scripter Studio and Pas file import tool for Scripter Studio              }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{***************************************************************************}
unit ap_ComConst;

interface

uses
  ComConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatComConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatComConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SCreateRegKeyError',SCreateRegKeyError);
    AddConstant('SOleError',SOleError);
    AddConstant('SObjectFactoryMissing',SObjectFactoryMissing);
    AddConstant('STypeInfoMissing',STypeInfoMissing);
    AddConstant('SBadTypeInfo',SBadTypeInfo);
    AddConstant('SDispIntfMissing',SDispIntfMissing);
    AddConstant('SNoMethod',SNoMethod);
    AddConstant('SVarNotObject',SVarNotObject);
    AddConstant('STooManyParams',STooManyParams);
    AddConstant('SDCOMNotInstalled',SDCOMNotInstalled);
    AddConstant('SDAXError',SDAXError);
    AddConstant('SAutomationWarning',SAutomationWarning);
    AddConstant('SNoCloseActiveServer1',SNoCloseActiveServer1);
    AddConstant('SNoCloseActiveServer2',SNoCloseActiveServer2);
  end;
end;

class function TatComConstLibrary.LibraryName: string;
begin
  result := 'ComConst';
end;

initialization
  RegisterScripterLibrary(TatComConstLibrary, True);

{$WARNINGS ON}

end.

