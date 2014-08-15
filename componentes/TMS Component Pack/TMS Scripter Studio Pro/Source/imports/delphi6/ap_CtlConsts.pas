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
unit ap_CtlConsts;

interface

uses
  CtlConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatCtlConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatCtlConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sInvalidClassReference',sInvalidClassReference);
  end;
end;

class function TatCtlConstsLibrary.LibraryName: string;
begin
  result := 'CtlConsts';
end;

initialization
  RegisterScripterLibrary(TatCtlConstsLibrary, True);

{$WARNINGS ON}

end.

