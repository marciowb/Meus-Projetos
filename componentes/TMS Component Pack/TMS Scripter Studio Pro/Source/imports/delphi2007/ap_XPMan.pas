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
unit ap_XPMan;

interface

uses
  SysUtils,
  Classes,
  XPMan,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatXPManLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TXPManifestClass = class of TXPManifest;



implementation



procedure TatXPManLibrary.Init;
begin
  With Scripter.DefineClass(TXPManifest) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatXPManLibrary.LibraryName: string;
begin
  result := 'XPMan';
end;

initialization
  RegisterScripterLibrary(TatXPManLibrary, True);

{$WARNINGS ON}

end.

