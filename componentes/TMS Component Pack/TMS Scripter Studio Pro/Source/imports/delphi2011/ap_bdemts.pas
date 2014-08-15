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
unit ap_bdemts;

interface

uses
  bdemts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatbdemtsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatbdemtsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatbdemtsLibrary.LibraryName: string;
begin
  result := 'bdemts';
end;

initialization
  RegisterScripterLibrary(TatbdemtsLibrary, True);

{$WARNINGS ON}

end.

