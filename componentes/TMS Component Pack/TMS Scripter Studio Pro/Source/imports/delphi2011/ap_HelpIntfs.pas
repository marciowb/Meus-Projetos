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
unit ap_HelpIntfs;

interface

uses
  SysUtils,
  Classes,
  HelpIntfs,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatHelpIntfsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EHelpSystemExceptionClass = class of EHelpSystemException;



implementation



procedure TatHelpIntfsLibrary.Init;
begin
  With Scripter.DefineClass(EHelpSystemException) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatHelpIntfsLibrary.LibraryName: string;
begin
  result := 'HelpIntfs';
end;

initialization
  RegisterScripterLibrary(TatHelpIntfsLibrary, True);

{$WARNINGS ON}

end.

