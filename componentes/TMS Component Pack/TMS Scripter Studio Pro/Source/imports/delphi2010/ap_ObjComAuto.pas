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
unit ap_ObjComAuto;

interface

uses
  Windows,
  ObjAuto,
  ActiveX,
  TypInfo,
  ObjComAuto,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatObjComAutoLibrary = class(TatScripterLibrary)
    procedure __TObjectDispatchGetTypeInfo(AMachine: TatVirtualMachine);
    procedure __TObjectDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
    procedure __TObjectDispatchCreate(AMachine: TatVirtualMachine);
    procedure __TObjectDispatchDestroy(AMachine: TatVirtualMachine);
    procedure __ReleaseMethodPointer(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TObjectDispatchClass = class of TObjectDispatch;


  TDispatchInfoWrapper = class(TatRecordWrapper)
  private
    FInstance: TObject;
    FIndex: Integer;
  public
    constructor Create(ARecord: TDispatchInfo);
    function ObjToRec: TDispatchInfo;
  published
    property Instance: TObject read FInstance write FInstance;
    property Index: Integer read FIndex write FIndex;
  end;
  

implementation

constructor TDispatchInfoWrapper.Create(ARecord: TDispatchInfo);
begin
  inherited Create;
  FInstance := ARecord.Instance;
  FIndex := ARecord.Index;
end;

function TDispatchInfoWrapper.ObjToRec: TDispatchInfo;
begin
  result.Instance := FInstance;
  result.Index := FIndex;
end;



procedure TatObjComAutoLibrary.__TObjectDispatchGetTypeInfo(AMachine: TatVirtualMachine);
  var
  Param2: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param2 := GetInputArg(2);
AResult := TObjectDispatch(CurrentObject).GetTypeInfo(VarToInteger(GetInputArg(0)),VarToInteger(GetInputArg(1)),Param2);
    ReturnOutputArg(AResult);
    SetInputArg(2,Param2);
  end;
end;

procedure TatObjComAutoLibrary.__TObjectDispatchGetTypeInfoCount(AMachine: TatVirtualMachine);
  var
  Param0: Integer;
  AResult: variant;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
AResult := TObjectDispatch(CurrentObject).GetTypeInfoCount(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,Integer(Param0));
  end;
end;

procedure TatObjComAutoLibrary.__TObjectDispatchCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(TObjectDispatchClass(CurrentClass.ClassRef).Create(TObject(integer(GetInputArg(0)))));
2: AResult := Integer(TObjectDispatchClass(CurrentClass.ClassRef).Create(TObject(integer(GetInputArg(0))),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjComAutoLibrary.__TObjectDispatchDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TObjectDispatch(CurrentObject).Destroy;
  end;
end;

procedure TatObjComAutoLibrary.__ReleaseMethodPointer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ObjComAuto.ReleaseMethodPointer(TMethodWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatObjComAutoLibrary.Init;
begin
  With Scripter.DefineClass(TObjectDispatch) do
  begin
    DefineMethod('GetTypeInfo',3,tkVariant,nil,__TObjectDispatchGetTypeInfo,false,0).SetVarArgs([2]);
    DefineMethod('GetTypeInfoCount',1,tkVariant,nil,__TObjectDispatchGetTypeInfoCount,false,0).SetVarArgs([0]);
    DefineMethod('Create',2,tkClass,TObjectDispatch,__TObjectDispatchCreate,true,1);
    DefineMethod('Destroy',0,tkNone,nil,__TObjectDispatchDestroy,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ReleaseMethodPointer',1,tkNone,nil,__ReleaseMethodPointer,false,0);
    AddConstant('dkMethod',dkMethod);
    AddConstant('dkProperty',dkProperty);
    AddConstant('dkSubComponent',dkSubComponent);
  end;
end;

class function TatObjComAutoLibrary.LibraryName: string;
begin
  result := 'ObjComAuto';
end;

initialization
  RegisterScripterLibrary(TatObjComAutoLibrary, True);

{$WARNINGS ON}

end.

