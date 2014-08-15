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
unit ap_HTMLHelpViewer;

interface

uses
  Classes,
  HTMLHelpViewer,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatHTMLHelpViewerLibrary = class(TatScripterLibrary)
    procedure __GetViewerName(AMachine: TatVirtualMachine);
    procedure __SetViewerName(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatHTMLHelpViewerLibrary.__GetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(HTMLHelpViewer.ViewerName);
  end;
end;

procedure TatHTMLHelpViewerLibrary.__SetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    HTMLHelpViewer.ViewerName:=GetInputArg(0);
  end;
end;

procedure TatHTMLHelpViewerLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('ViewerName',tkVariant,__GetViewerName,__SetViewerName,nil,false,0);
  end;
end;

class function TatHTMLHelpViewerLibrary.LibraryName: string;
begin
  result := 'HTMLHelpViewer';
end;

initialization
  RegisterScripterLibrary(TatHTMLHelpViewerLibrary, True);

{$WARNINGS ON}

end.

