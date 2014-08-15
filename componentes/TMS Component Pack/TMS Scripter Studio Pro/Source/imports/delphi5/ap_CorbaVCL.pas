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
unit ap_CorbaVCL;

interface

uses
  Classes,
  CorbaObj,
  CorbaVCL,
  atScript;

{$WARNINGS OFF}

type
  TatCorbaVCLLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCorbaVclComponentFactoryClass = class of TCorbaVclComponentFactory;



implementation



procedure TatCorbaVCLLibrary.Init;
begin
  With Scripter.DefineClass(TCorbaVclComponentFactory) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCorbaVCLLibrary.LibraryName: string;
begin
  result := 'CorbaVCL';
end;

initialization
  RegisterScripterLibrary(TatCorbaVCLLibrary, True);

{$WARNINGS ON}

end.

