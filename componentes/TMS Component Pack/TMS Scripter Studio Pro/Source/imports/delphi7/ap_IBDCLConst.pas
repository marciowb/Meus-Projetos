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
unit ap_IBDCLConst;

interface

uses
  IBDCLConst,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBDCLConstLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatIBDCLConstLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('SBackupCaption',SBackupCaption);
    AddConstant('SRestoreSize',SRestoreSize);
    AddConstant('SFileNames',SFileNames);
    AddConstant('SPages',SPages);
    AddConstant('SDatabasefiles',SDatabasefiles);
  end;
end;

class function TatIBDCLConstLibrary.LibraryName: string;
begin
  result := 'IBDCLConst';
end;

initialization
  RegisterScripterLibrary(TatIBDCLConstLibrary, True);

{$WARNINGS ON}

end.

