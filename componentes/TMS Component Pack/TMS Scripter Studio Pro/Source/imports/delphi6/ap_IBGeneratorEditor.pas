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
unit ap_IBGeneratorEditor;

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
  ExtCtrls,
  IBGeneratorEditor,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatIBGeneratorEditorLibrary = class(TatScripterLibrary)
    procedure __GetfrmGeneratorEditor(AMachine: TatVirtualMachine);
    procedure __SetfrmGeneratorEditor(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TfrmGeneratorEditorClass = class of TfrmGeneratorEditor;



implementation



procedure TatIBGeneratorEditorLibrary.__GetfrmGeneratorEditor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(IBGeneratorEditor.frmGeneratorEditor));
  end;
end;

procedure TatIBGeneratorEditorLibrary.__SetfrmGeneratorEditor(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    IBGeneratorEditor.frmGeneratorEditor:=TfrmGeneratorEditor(Integer(GetInputArg(0)));
  end;
end;

procedure TatIBGeneratorEditorLibrary.Init;
begin
  With Scripter.DefineClass(TfrmGeneratorEditor) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineProp('frmGeneratorEditor',tkClass,__GetfrmGeneratorEditor,__SetfrmGeneratorEditor,TfrmGeneratorEditor,false,0);
  end;
end;

class function TatIBGeneratorEditorLibrary.LibraryName: string;
begin
  result := 'IBGeneratorEditor';
end;

initialization
  RegisterScripterLibrary(TatIBGeneratorEditorLibrary, True);

{$WARNINGS ON}

end.

