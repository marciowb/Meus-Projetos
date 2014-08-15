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
unit ap_ExtDlgs;

interface

uses
  Messages,
  Windows,
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  Graphics,
  ExtCtrls,
  Buttons,
  Dialogs,
  Consts,
  ExtDlgs,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatExtDlgsLibrary = class(TatScripterLibrary)
    procedure __TOpenPictureDialogCreate(AMachine: TatVirtualMachine);
    procedure __TOpenPictureDialogExecute(AMachine: TatVirtualMachine);
    procedure __TSavePictureDialogExecute(AMachine: TatVirtualMachine);
    procedure __TOpenTextFileDialogCreate(AMachine: TatVirtualMachine);
    procedure __TOpenTextFileDialogDestroy(AMachine: TatVirtualMachine);
    procedure __TOpenTextFileDialogExecute(AMachine: TatVirtualMachine);
    procedure __TSaveTextFileDialogExecute(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TOpenPictureDialogClass = class of TOpenPictureDialog;
  TSavePictureDialogClass = class of TSavePictureDialog;
  TOpenTextFileDialogClass = class of TOpenTextFileDialog;
  TSaveTextFileDialogClass = class of TSaveTextFileDialog;



implementation



procedure TatExtDlgsLibrary.__TOpenPictureDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOpenPictureDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.__TOpenPictureDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOpenPictureDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.__TSavePictureDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSavePictureDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.__TOpenTextFileDialogCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOpenTextFileDialogClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.__TOpenTextFileDialogDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOpenTextFileDialog(CurrentObject).Destroy;
  end;
end;

procedure TatExtDlgsLibrary.__TOpenTextFileDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TOpenTextFileDialog(CurrentObject).Execute(VarToInteger(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.__TSaveTextFileDialogExecute(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TSaveTextFileDialog(CurrentObject).Execute;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatExtDlgsLibrary.Init;
begin
  With Scripter.DefineClass(TOpenPictureDialog) do
  begin
    DefineMethod('Create',1,tkClass,TOpenPictureDialog,__TOpenPictureDialogCreate,true,0);
    DefineMethod('Execute',1,tkVariant,nil,__TOpenPictureDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TSavePictureDialog) do
  begin
    DefineMethod('Execute',0,tkVariant,nil,__TSavePictureDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TOpenTextFileDialog) do
  begin
    DefineMethod('Create',1,tkClass,TOpenTextFileDialog,__TOpenTextFileDialogCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOpenTextFileDialogDestroy,false,0);
    DefineMethod('Execute',1,tkVariant,nil,__TOpenTextFileDialogExecute,false,0);
  end;
  With Scripter.DefineClass(TSaveTextFileDialog) do
  begin
    DefineMethod('Execute',0,tkVariant,nil,__TSaveTextFileDialogExecute,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
  end;
end;

class function TatExtDlgsLibrary.LibraryName: string;
begin
  result := 'ExtDlgs';
end;

initialization
  RegisterScripterLibrary(TatExtDlgsLibrary, True);

{$WARNINGS ON}

end.

