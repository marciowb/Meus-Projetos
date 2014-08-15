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
unit ap_Printers;

interface

uses
  Windows,
  WinSpool,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Printers,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatPrintersLibrary = class(TatScripterLibrary)
    procedure __TPrinterCreate(AMachine: TatVirtualMachine);
    procedure __TPrinterDestroy(AMachine: TatVirtualMachine);
    procedure __TPrinterAbort(AMachine: TatVirtualMachine);
    procedure __TPrinterBeginDoc(AMachine: TatVirtualMachine);
    procedure __TPrinterEndDoc(AMachine: TatVirtualMachine);
    procedure __TPrinterNewPage(AMachine: TatVirtualMachine);
    procedure __TPrinterRefresh(AMachine: TatVirtualMachine);
    procedure __TPrinterGetPrinter(AMachine: TatVirtualMachine);
    procedure __TPrinterSetPrinter(AMachine: TatVirtualMachine);
    procedure __GetTPrinterAborted(AMachine: TatVirtualMachine);
    procedure __GetTPrinterCanvas(AMachine: TatVirtualMachine);
    procedure __GetTPrinterCapabilities(AMachine: TatVirtualMachine);
    procedure __GetTPrinterCopies(AMachine: TatVirtualMachine);
    procedure __SetTPrinterCopies(AMachine: TatVirtualMachine);
    procedure __GetTPrinterFonts(AMachine: TatVirtualMachine);
    procedure __GetTPrinterHandle(AMachine: TatVirtualMachine);
    procedure __GetTPrinterOrientation(AMachine: TatVirtualMachine);
    procedure __SetTPrinterOrientation(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPageHeight(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPageWidth(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPageNumber(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPrinterIndex(AMachine: TatVirtualMachine);
    procedure __SetTPrinterPrinterIndex(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPrinting(AMachine: TatVirtualMachine);
    procedure __GetTPrinterPrinters(AMachine: TatVirtualMachine);
    procedure __GetTPrinterTitle(AMachine: TatVirtualMachine);
    procedure __SetTPrinterTitle(AMachine: TatVirtualMachine);
    procedure __Printer(AMachine: TatVirtualMachine);
    procedure __SetPrinter(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  EPrinterClass = class of EPrinter;
  TPrinterClass = class of TPrinter;



implementation



procedure TatPrintersLibrary.__TPrinterCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TPrinterClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPrintersLibrary.__TPrinterDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Destroy;
  end;
end;

procedure TatPrintersLibrary.__TPrinterAbort(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Abort;
  end;
end;

procedure TatPrintersLibrary.__TPrinterBeginDoc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).BeginDoc;
  end;
end;

procedure TatPrintersLibrary.__TPrinterEndDoc(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).EndDoc;
  end;
end;

procedure TatPrintersLibrary.__TPrinterNewPage(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).NewPage;
  end;
end;

procedure TatPrintersLibrary.__TPrinterRefresh(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Refresh;
  end;
end;

procedure TatPrintersLibrary.__TPrinterGetPrinter(AMachine: TatVirtualMachine);
  var
  Param3: THandle;
begin
  with AMachine do
  begin
Param3 := GetInputArg(3);
    TPrinter(CurrentObject).GetPrinter(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),Param3);
    SetInputArg(3,Param3);
  end;
end;

procedure TatPrintersLibrary.__TPrinterSetPrinter(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).SetPrinter(PChar(VarToStr(GetInputArg(0))),PChar(VarToStr(GetInputArg(1))),PChar(VarToStr(GetInputArg(2))),GetInputArg(3));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterAborted(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPrinter(CurrentObject).Aborted);
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterCanvas(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).Canvas));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterCapabilities(AMachine: TatVirtualMachine);
var
PropValueSet: TPrinterCapabilities;
begin
  with AMachine do
  begin
    PropValueSet := TPrinter(CurrentObject).Capabilities;
    ReturnOutputArg(IntFromSet(PropValueSet, SizeOf(PropValueSet)));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterCopies(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).Copies));
  end;
end;

procedure TatPrintersLibrary.__SetTPrinterCopies(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Copies:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterFonts(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).Fonts));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterHandle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).Handle));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPrinter(CurrentObject).Orientation);
  end;
end;

procedure TatPrintersLibrary.__SetTPrinterOrientation(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Orientation:=GetInputArg(0);
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPageHeight(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).PageHeight));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPageWidth(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).PageWidth));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPageNumber(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).PageNumber));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPrinterIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).PrinterIndex));
  end;
end;

procedure TatPrintersLibrary.__SetTPrinterPrinterIndex(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).PrinterIndex:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPrinting(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPrinter(CurrentObject).Printing);
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterPrinters(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TPrinter(CurrentObject).Printers));
  end;
end;

procedure TatPrintersLibrary.__GetTPrinterTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TPrinter(CurrentObject).Title);
  end;
end;

procedure TatPrintersLibrary.__SetTPrinterTitle(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TPrinter(CurrentObject).Title:=GetInputArg(0);
  end;
end;

procedure TatPrintersLibrary.__Printer(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Printers.Printer);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPrintersLibrary.__SetPrinter(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(Printers.SetPrinter(TPrinter(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatPrintersLibrary.Init;
begin
  With Scripter.DefineClass(EPrinter) do
  begin
  end;
  With Scripter.DefineClass(TPrinter) do
  begin
    DefineMethod('Create',0,tkClass,TPrinter,__TPrinterCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TPrinterDestroy,false,0);
    DefineMethod('Abort',0,tkNone,nil,__TPrinterAbort,false,0);
    DefineMethod('BeginDoc',0,tkNone,nil,__TPrinterBeginDoc,false,0);
    DefineMethod('EndDoc',0,tkNone,nil,__TPrinterEndDoc,false,0);
    DefineMethod('NewPage',0,tkNone,nil,__TPrinterNewPage,false,0);
    DefineMethod('Refresh',0,tkNone,nil,__TPrinterRefresh,false,0);
    DefineMethod('GetPrinter',4,tkNone,nil,__TPrinterGetPrinter,false,0).SetVarArgs([3]);
    DefineMethod('SetPrinter',4,tkNone,nil,__TPrinterSetPrinter,false,0);
    DefineProp('Aborted',tkVariant,__GetTPrinterAborted,nil,nil,false,0);
    DefineProp('Canvas',tkClass,__GetTPrinterCanvas,nil,TCanvas,false,0);
    DefineProp('Capabilities',tkInteger,__GetTPrinterCapabilities,nil,nil,false,0);
    DefineProp('Copies',tkInteger,__GetTPrinterCopies,__SetTPrinterCopies,nil,false,0);
    DefineProp('Fonts',tkClass,__GetTPrinterFonts,nil,TStrings,false,0);
    DefineProp('Handle',tkInteger,__GetTPrinterHandle,nil,nil,false,0);
    DefineProp('Orientation',tkEnumeration,__GetTPrinterOrientation,__SetTPrinterOrientation,nil,false,0);
    DefineProp('PageHeight',tkInteger,__GetTPrinterPageHeight,nil,nil,false,0);
    DefineProp('PageWidth',tkInteger,__GetTPrinterPageWidth,nil,nil,false,0);
    DefineProp('PageNumber',tkInteger,__GetTPrinterPageNumber,nil,nil,false,0);
    DefineProp('PrinterIndex',tkInteger,__GetTPrinterPrinterIndex,__SetTPrinterPrinterIndex,nil,false,0);
    DefineProp('Printing',tkVariant,__GetTPrinterPrinting,nil,nil,false,0);
    DefineProp('Printers',tkClass,__GetTPrinterPrinters,nil,TStrings,false,0);
    DefineProp('Title',tkVariant,__GetTPrinterTitle,__SetTPrinterTitle,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('Printer',0,tkClass,TPrinter,__Printer,false,0);
    DefineMethod('SetPrinter',1,tkClass,TPrinter,__SetPrinter,false,0);
    AddConstant('psNoHandle',psNoHandle);
    AddConstant('psHandleIC',psHandleIC);
    AddConstant('psHandleDC',psHandleDC);
    AddConstant('poPortrait',poPortrait);
    AddConstant('poLandscape',poLandscape);
    AddConstant('pcCopies',pcCopies);
    AddConstant('pcOrientation',pcOrientation);
    AddConstant('pcCollation',pcCollation);
  end;
end;

class function TatPrintersLibrary.LibraryName: string;
begin
  result := 'Printers';
end;

initialization
  RegisterScripterLibrary(TatPrintersLibrary, True);

{$WARNINGS ON}

end.

