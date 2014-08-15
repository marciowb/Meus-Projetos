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
unit ap_WinHelpViewer;

interface

uses
  Classes,
  WinHelpViewer,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatWinHelpViewerLibrary = class(TatScripterLibrary)
    procedure __GetViewerName(AMachine: TatVirtualMachine);
    procedure __SetViewerName(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatWinHelpViewerLibrary.__GetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(WinHelpViewer.ViewerName);
  end;
end;

procedure TatWinHelpViewerLibrary.__SetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    WinHelpViewer.ViewerName:=GetInputArg(0);
  end;
end;

procedure TatWinHelpViewerLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('ViewerName',tkVariant,__GetViewerName,__SetViewerName,nil,false,0);
  end;
end;

class function TatWinHelpViewerLibrary.LibraryName: string;
begin
  result := 'WinHelpViewer';
end;

initialization
  RegisterScripterLibrary(TatWinHelpViewerLibrary, True);

{$WARNINGS ON}

end.

