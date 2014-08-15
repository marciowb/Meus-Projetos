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
unit ap_CorbaRdm;

interface

uses
  DataBkr,
  CorbaRdm,
  atScript;

{$WARNINGS OFF}

type
  TatCorbaRdmLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TCorbaDataModuleClass = class of TCorbaDataModule;



implementation



procedure TatCorbaRdmLibrary.Init;
begin
  With Scripter.DefineClass(TCorbaDataModule) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatCorbaRdmLibrary.LibraryName: string;
begin
  result := 'CorbaRdm';
end;

initialization
  RegisterScripterLibrary(TatCorbaRdmLibrary, True);

{$WARNINGS ON}

end.

