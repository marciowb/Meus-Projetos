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
unit ap_JConsts;

interface

uses
  JConsts,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatJConstsLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatJConstsLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sChangeJPGSize',sChangeJPGSize);
    AddConstant('sJPEGError',sJPEGError);
    AddConstant('sJPEGImageFile',sJPEGImageFile);
  end;
end;

class function TatJConstsLibrary.LibraryName: string;
begin
  result := 'JConsts';
end;

initialization
  RegisterScripterLibrary(TatJConstsLibrary, True);

{$WARNINGS ON}

end.

