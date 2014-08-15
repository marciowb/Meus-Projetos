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
unit ap_Clipbrd;

interface

uses
  Windows,
  Messages,
  Classes,
  Graphics,
  Clipbrd,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatClipbrdLibrary = class(TatScripterLibrary)
    procedure __TClipboardDestroy(AMachine: TatVirtualMachine);
    procedure __TClipboardAssign(AMachine: TatVirtualMachine);
    procedure __TClipboardClear(AMachine: TatVirtualMachine);
    procedure __TClipboardClose(AMachine: TatVirtualMachine);
    procedure __TClipboardGetComponent(AMachine: TatVirtualMachine);
    procedure __TClipboardGetAsHandle(AMachine: TatVirtualMachine);
    procedure __TClipboardGetTextBuf(AMachine: TatVirtualMachine);
    procedure __TClipboardHasFormat(AMachine: TatVirtualMachine);
    procedure __TClipboardOpen(AMachine: TatVirtualMachine);
    procedure __TClipboardSetComponent(AMachine: TatVirtualMachine);
    procedure __TClipboardSetAsHandle(AMachine: TatVirtualMachine);
    procedure __TClipboardSetTextBuf(AMachine: TatVirtualMachine);
    procedure __GetTClipboardAsText(AMachine: TatVirtualMachine);
    procedure __SetTClipboardAsText(AMachine: TatVirtualMachine);
    procedure __GetTClipboardFormatCount(AMachine: TatVirtualMachine);
    procedure __GetTClipboardFormats(AMachine: TatVirtualMachine);
    procedure __Clipboard(AMachine: TatVirtualMachine);
    procedure __SetClipboard(AMachine: TatVirtualMachine);
    procedure __GetCF_PICTURE(AMachine: TatVirtualMachine);
    procedure __SetCF_PICTURE(AMachine: TatVirtualMachine);
    procedure __GetCF_COMPONENT(AMachine: TatVirtualMachine);
    procedure __SetCF_COMPONENT(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TClipboardClass = class of TClipboard;



implementation



procedure TatClipbrdLibrary.__TClipboardDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).Destroy;
  end;
end;

procedure TatClipbrdLibrary.__TClipboardAssign(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).Assign(TPersistent(Integer(GetInputArg(0))));
  end;
end;

procedure TatClipbrdLibrary.__TClipboardClear(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).Clear;
  end;
end;

procedure TatClipbrdLibrary.__TClipboardClose(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).Close;
  end;
end;

procedure TatClipbrdLibrary.__TClipboardGetComponent(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClipboard(CurrentObject).GetComponent(TComponent(Integer(GetInputArg(0))),TComponent(Integer(GetInputArg(1)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__TClipboardGetAsHandle(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClipboard(CurrentObject).GetAsHandle(VarToInteger(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__TClipboardGetTextBuf(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TClipboard(CurrentObject).GetTextBuf(PChar(VarToStr(GetInputArg(0))),VarToInteger(GetInputArg(1))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__TClipboardHasFormat(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TClipboard(CurrentObject).HasFormat(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__TClipboardOpen(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).Open;
  end;
end;

procedure TatClipbrdLibrary.__TClipboardSetComponent(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).SetComponent(TComponent(Integer(GetInputArg(0))));
  end;
end;

procedure TatClipbrdLibrary.__TClipboardSetAsHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).SetAsHandle(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)));
  end;
end;

procedure TatClipbrdLibrary.__TClipboardSetTextBuf(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).SetTextBuf(PChar(VarToStr(GetInputArg(0))));
  end;
end;

procedure TatClipbrdLibrary.__GetTClipboardAsText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TClipboard(CurrentObject).AsText);
  end;
end;

procedure TatClipbrdLibrary.__SetTClipboardAsText(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TClipboard(CurrentObject).AsText:=GetInputArg(0);
  end;
end;

procedure TatClipbrdLibrary.__GetTClipboardFormatCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClipboard(CurrentObject).FormatCount));
  end;
end;

procedure TatClipbrdLibrary.__GetTClipboardFormats(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TClipboard(CurrentObject).Formats[VarToInteger(GetArrayIndex(0))]));
  end;
end;

procedure TatClipbrdLibrary.__Clipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Clipbrd.Clipboard);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__SetClipboard(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Clipbrd.SetClipboard(TClipboard(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatClipbrdLibrary.__GetCF_PICTURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Clipbrd.CF_PICTURE));
  end;
end;

procedure TatClipbrdLibrary.__SetCF_PICTURE(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Clipbrd.CF_PICTURE:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatClipbrdLibrary.__GetCF_COMPONENT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(Clipbrd.CF_COMPONENT));
  end;
end;

procedure TatClipbrdLibrary.__SetCF_COMPONENT(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Clipbrd.CF_COMPONENT:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatClipbrdLibrary.Init;
begin
  With Scripter.DefineClass(TClipboard) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TClipboardDestroy,false,0);
    DefineMethod('Assign',1,tkNone,nil,__TClipboardAssign,false,0);
    DefineMethod('Clear',0,tkNone,nil,__TClipboardClear,false,0);
    DefineMethod('Close',0,tkNone,nil,__TClipboardClose,false,0);
    DefineMethod('GetComponent',2,tkClass,TComponent,__TClipboardGetComponent,false,0);
    DefineMethod('GetAsHandle',1,tkInteger,nil,__TClipboardGetAsHandle,false,0);
    DefineMethod('GetTextBuf',2,tkInteger,nil,__TClipboardGetTextBuf,false,0);
    DefineMethod('HasFormat',1,tkVariant,nil,__TClipboardHasFormat,false,0);
    DefineMethod('Open',0,tkNone,nil,__TClipboardOpen,false,0);
    DefineMethod('SetComponent',1,tkNone,nil,__TClipboardSetComponent,false,0);
    DefineMethod('SetAsHandle',2,tkNone,nil,__TClipboardSetAsHandle,false,0);
    DefineMethod('SetTextBuf',1,tkNone,nil,__TClipboardSetTextBuf,false,0);
    DefineProp('AsText',tkVariant,__GetTClipboardAsText,__SetTClipboardAsText,nil,false,0);
    DefineProp('FormatCount',tkInteger,__GetTClipboardFormatCount,nil,nil,false,0);
    DefineProp('Formats',tkInteger,__GetTClipboardFormats,nil,nil,false,1);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Clipboard',0,tkClass,TClipboard,__Clipboard,false,0);
    DefineMethod('SetClipboard',1,tkClass,TClipboard,__SetClipboard,false,0);
    DefineProp('CF_PICTURE',tkInteger,__GetCF_PICTURE,__SetCF_PICTURE,nil,false,0);
    DefineProp('CF_COMPONENT',tkInteger,__GetCF_COMPONENT,__SetCF_COMPONENT,nil,false,0);
  end;
end;

class function TatClipbrdLibrary.LibraryName: string;
begin
  result := 'Clipbrd';
end;

initialization
  RegisterScripterLibrary(TatClipbrdLibrary, True);

{$WARNINGS ON}

end.

