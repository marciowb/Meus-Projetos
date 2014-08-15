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
unit ap_SimpleShareMem;

interface

uses
  SimpleShareMem,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatSimpleShareMemLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatSimpleShareMemLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatSimpleShareMemLibrary.LibraryName: string;
begin
  result := 'SimpleShareMem';
end;

initialization
  RegisterScripterLibrary(TatSimpleShareMemLibrary, True);

{$WARNINGS ON}

end.

