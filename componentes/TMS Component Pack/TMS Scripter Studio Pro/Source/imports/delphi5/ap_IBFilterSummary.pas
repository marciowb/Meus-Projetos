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
unit ap_IBFilterSummary;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ComCtrls,
  IBFilterSummary,
  atScript;

{$WARNINGS OFF}

type
  TatIBFilterSummaryLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TfrmIBFilterSummaryClass = class of TfrmIBFilterSummary;



implementation



procedure TatIBFilterSummaryLibrary.Init;
begin
  With Scripter.DefineClass(TfrmIBFilterSummary) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatIBFilterSummaryLibrary.LibraryName: string;
begin
  result := 'IBFilterSummary';
end;

initialization
  RegisterScripterLibrary(TatIBFilterSummaryLibrary, True);

{$WARNINGS ON}

end.

