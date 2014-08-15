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
unit ap_BdeMts;

interface

uses
  BdeMts,
  atScript;

{$WARNINGS OFF}

type
  TatBdeMtsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatBdeMtsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatBdeMtsLibrary.LibraryName: string;
begin
  result := 'BdeMts';
end;

initialization
  RegisterScripterLibrary(TatBdeMtsLibrary, True);

{$WARNINGS ON}

end.

