unit ap_Windows;

{$I AScript.inc}

interface

uses
  Windows,
  atScript
  {$IFDEF DELPHI6_LVL}
  , Variants
  {$ENDIF}
  ;

type
  TatWindowsLibrary = class(TatScripterLibrary)
    procedure __FreeLibrary(AMachine: TatVirtualMachine);
    procedure __LoadLibrary(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

implementation

procedure TatWindowsLibrary.__FreeLibrary(AMachine: TatVirtualMachine);
var AResult: variant;
begin
  with AMachine do
  begin
    AResult := Windows.FreeLibrary(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWindowsLibrary.__LoadLibrary(AMachine: TatVirtualMachine);
var AResult: variant;
begin
  with AMachine do
  begin
    AResult := Integer(Windows.LoadLibrary(PChar(VarToStr(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

class function TatWindowsLibrary.LibraryName: string;
begin
  result := 'Windows';
end;

procedure TatWindowsLibrary.Init;
begin
  with Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('FreeLibrary',1,tkVariant,nil,__FreeLibrary,false);
    DefineMethod('LoadLibrary',1,tkInteger,nil,__LoadLibrary,false);
  end;                         
end;

initialization
  RegisterScripterLibrary(TatWindowsLibrary, True);

end.

