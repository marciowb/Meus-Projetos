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
unit ap_HtmlHelpViewer;

interface

uses
  Classes,
  HtmlHelpViewer,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatHtmlHelpViewerLibrary = class(TatScripterLibrary)
    procedure __GetViewerName(AMachine: TatVirtualMachine);
    procedure __SetViewerName(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatHtmlHelpViewerLibrary.__GetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(HtmlHelpViewer.ViewerName);
  end;
end;

procedure TatHtmlHelpViewerLibrary.__SetViewerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    HtmlHelpViewer.ViewerName:=GetInputArg(0);
  end;
end;

procedure TatHtmlHelpViewerLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('ViewerName',tkVariant,__GetViewerName,__SetViewerName,nil,false,0);
  end;
end;

class function TatHtmlHelpViewerLibrary.LibraryName: string;
begin
  result := 'HtmlHelpViewer';
end;

initialization
  RegisterScripterLibrary(TatHtmlHelpViewerLibrary, True);

{$WARNINGS ON}

end.

