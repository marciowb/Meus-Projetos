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
unit ap_ShellAnimations;

interface

uses
  SysUtils,
  Classes,
  ShellAnimations,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatShellAnimationsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TShellResourcesClass = class of TShellResources;



implementation



procedure TatShellAnimationsLibrary.Init;
begin
  With Scripter.DefineClass(TShellResources) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatShellAnimationsLibrary.LibraryName: string;
begin
  result := 'ShellAnimations';
end;

initialization
  RegisterScripterLibrary(TatShellAnimationsLibrary, True);

{$WARNINGS ON}

end.

