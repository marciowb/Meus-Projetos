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
unit ap_IBBatchMove;

interface

uses
  SysUtils,
  Classes,
  DB,
  IB,
  IBDatabase,
  IBCustomDataSet,
  IBTable,
  IBBatchMove,
  atScript;

{$WARNINGS OFF}

type
  TatIBBatchMoveLibrary = class(TatScripterLibrary)
    procedure __TIBBatchMoveCreate(AMachine: TatVirtualMachine);
    procedure __TIBBatchMoveDestroy(AMachine: TatVirtualMachine);
    procedure __TIBBatchMoveExecute(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchMoveChangedCount(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchMoveKeyViolCount(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchMoveMovedCount(AMachine: TatVirtualMachine);
    procedure __GetTIBBatchMoveProblemCount(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TIBBatchMoveClass = class of TIBBatchMove;



implementation



procedure TatIBBatchMoveLibrary.__TIBBatchMoveCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TIBBatchMoveClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatIBBatchMoveLibrary.__TIBBatchMoveDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatchMove(CurrentObject).Destroy;
  end;
end;

procedure TatIBBatchMoveLibrary.__TIBBatchMoveExecute(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TIBBatchMove(CurrentObject).Execute;
  end;
end;

procedure TatIBBatchMoveLibrary.__GetTIBBatchMoveChangedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatchMove(CurrentObject).ChangedCount));
  end;
end;

procedure TatIBBatchMoveLibrary.__GetTIBBatchMoveKeyViolCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatchMove(CurrentObject).KeyViolCount));
  end;
end;

procedure TatIBBatchMoveLibrary.__GetTIBBatchMoveMovedCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatchMove(CurrentObject).MovedCount));
  end;
end;

procedure TatIBBatchMoveLibrary.__GetTIBBatchMoveProblemCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TIBBatchMove(CurrentObject).ProblemCount));
  end;
end;

procedure TatIBBatchMoveLibrary.Init;
begin
  With Scripter.DefineClass(TIBBatchMove) do
  begin
    DefineMethod('Create',1,tkClass,TIBBatchMove,__TIBBatchMoveCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TIBBatchMoveDestroy,false,0);
    DefineMethod('Execute',0,tkNone,nil,__TIBBatchMoveExecute,false,0);
    DefineProp('ChangedCount',tkInteger,__GetTIBBatchMoveChangedCount,nil,nil,false,0);
    DefineProp('KeyViolCount',tkInteger,__GetTIBBatchMoveKeyViolCount,nil,nil,false,0);
    DefineProp('MovedCount',tkInteger,__GetTIBBatchMoveMovedCount,nil,nil,false,0);
    DefineProp('ProblemCount',tkInteger,__GetTIBBatchMoveProblemCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('batAppend',batAppend);
    AddConstant('batUpdate',batUpdate);
    AddConstant('batAppendUpdate',batAppendUpdate);
    AddConstant('batDelete',batDelete);
    AddConstant('batCopy',batCopy);
  end;
end;

class function TatIBBatchMoveLibrary.LibraryName: string;
begin
  result := 'IBBatchMove';
end;

initialization
  RegisterScripterLibrary(TatIBBatchMoveLibrary, True);

{$WARNINGS ON}

end.

