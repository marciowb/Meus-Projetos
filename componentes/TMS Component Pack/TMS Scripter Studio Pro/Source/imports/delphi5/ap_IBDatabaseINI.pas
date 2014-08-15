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
unit ap_IBDatabaseINI;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  IBDatabase,
  IBDatabaseINI,
  atScript;

{$WARNINGS OFF}

type
  TatIBDatabaseINILibrary = class(TatScripterLibrary)
    procedure __TIBDatabaseINICreate(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseINISaveToINI(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseINIReadFromINI(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseINIWriteToDatabase(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseINIReadFromDatabase(AMachine: TatVirtualMachine);
    procedure __TIBDatabaseINIIniFileName(AMachine: TatVirtualMachine);
    procedure __SlashPath(AMachine: TatVirtualMachine);
    procedure __LocalServerPath(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBDatabaseINIClass = class of TIBDatabaseINI;



implementation



procedure TatIBDatabaseINILibrary.__TIBDatabaseINICreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBDatabaseINIClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseINILibrary.__TIBDatabaseINISaveToINI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabaseINI(CurrentObject).SaveToINI;
  end;
end;

procedure TatIBDatabaseINILibrary.__TIBDatabaseINIReadFromINI(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabaseINI(CurrentObject).ReadFromINI;
  end;
end;

procedure TatIBDatabaseINILibrary.__TIBDatabaseINIWriteToDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabaseINI(CurrentObject).WriteToDatabase(TIBDatabase(Integer(GetInputArg(0))));
  end;
end;

procedure TatIBDatabaseINILibrary.__TIBDatabaseINIReadFromDatabase(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBDatabaseINI(CurrentObject).ReadFromDatabase;
  end;
end;

procedure TatIBDatabaseINILibrary.__TIBDatabaseINIIniFileName(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TIBDatabaseINI(CurrentObject).IniFileName;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseINILibrary.__SlashPath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := IBDatabaseINI.SlashPath(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseINILibrary.__LocalServerPath(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
0: AResult := IBDatabaseINI.LocalServerPath;
1: AResult := IBDatabaseINI.LocalServerPath(GetInputArg(0));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBDatabaseINILibrary.Init;
begin
  With Scripter.DefineClass(TIBDatabaseINI) do
  begin
    DefineMethod('Create',1,tkClass,TIBDatabaseINI,__TIBDatabaseINICreate,true,0);
    DefineMethod('SaveToINI',0,tkNone,nil,__TIBDatabaseINISaveToINI,false,0);
    DefineMethod('ReadFromINI',0,tkNone,nil,__TIBDatabaseINIReadFromINI,false,0);
    DefineMethod('WriteToDatabase',1,tkNone,nil,__TIBDatabaseINIWriteToDatabase,false,0);
    DefineMethod('ReadFromDatabase',0,tkNone,nil,__TIBDatabaseINIReadFromDatabase,false,0);
    DefineMethod('IniFileName',0,tkVariant,nil,__TIBDatabaseINIIniFileName,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SlashPath',1,tkVariant,nil,__SlashPath,false,0);
    DefineMethod('LocalServerPath',1,tkVariant,nil,__LocalServerPath,false,1);
    AddConstant('ipoPathNone',ipoPathNone);
    AddConstant('ipoPathToServer',ipoPathToServer);
    AddConstant('ipoPathRelative',ipoPathRelative);
    AddConstant('PathSeparator',PathSeparator);
    AddConstant('NL',NL);
    AddConstant('SWrapLine',SWrapLine);
  end;
end;

class function TatIBDatabaseINILibrary.LibraryName: string;
begin
  result := 'IBDatabaseINI';
end;

initialization
  RegisterScripterLibrary(TatIBDatabaseINILibrary, True);

{$WARNINGS ON}

end.

