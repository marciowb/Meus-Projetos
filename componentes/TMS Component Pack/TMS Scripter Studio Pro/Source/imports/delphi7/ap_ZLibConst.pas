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
unit ap_ZLibConst;

interface

uses
  ZLibConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatZLibConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatZLibConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('sTargetBufferTooSmall',sTargetBufferTooSmall);
    AddConstant('sInvalidStreamOp',sInvalidStreamOp);
    AddConstant('sError',sError);
  end;
end;

class function TatZLibConstLibrary.LibraryName: string;
begin
  result := 'ZLibConst';
end;

initialization
  RegisterScripterLibrary(TatZLibConstLibrary, True);

{$WARNINGS ON}

end.

