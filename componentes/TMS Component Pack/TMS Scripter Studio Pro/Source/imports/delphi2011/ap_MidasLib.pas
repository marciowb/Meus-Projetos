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
unit ap_MidasLib;

interface

uses
  MidasLib,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatMidasLibLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatMidasLibLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatMidasLibLibrary.LibraryName: string;
begin
  result := 'MidasLib';
end;

initialization
  RegisterScripterLibrary(TatMidasLibLibrary, True);

{$WARNINGS ON}

end.

