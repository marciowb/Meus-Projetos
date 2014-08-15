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
unit ap_VarUtils;

interface

uses
  SysUtils,
  Types,
  SysConst,
  VarUtils,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatVarUtilsLibrary = class(TatScripterLibrary)
    procedure __ESafeArrayErrorCreateHResult(AMachine: TatVirtualMachine);
    procedure __GetESafeArrayErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __SetESafeArrayErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __VarExceptionToResult(AMachine: TatVirtualMachine);
    procedure __VariantInit(AMachine: TatVirtualMachine);
    procedure __VariantClear(AMachine: TatVirtualMachine);
    procedure __VariantCopy(AMachine: TatVirtualMachine);
    procedure __VariantCopyInd(AMachine: TatVirtualMachine);
    procedure __VariantChangeType(AMachine: TatVirtualMachine);
    procedure __SafeArrayCheck(AMachine: TatVirtualMachine);
    procedure __SafeArrayError(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  ESafeArrayErrorClass = class of ESafeArrayError;
  ESafeArrayCreateErrorClass = class of ESafeArrayCreateError;
  ESafeArrayBoundsErrorClass = class of ESafeArrayBoundsError;
  ESafeArrayLockedErrorClass = class of ESafeArrayLockedError;


  TVarTypeToElementInfoWrapper = class(TatRecordWrapper)
  private
    FValidBase: Boolean;
    FValidElement: Boolean;
    FSize: Integer;
    FFlags: Word;
  public
    constructor Create(ARecord: TVarTypeToElementInfo);
    function ObjToRec: TVarTypeToElementInfo;
  published
    property ValidBase: Boolean read FValidBase write FValidBase;
    property ValidElement: Boolean read FValidElement write FValidElement;
    property Size: Integer read FSize write FSize;
    property Flags: Word read FFlags write FFlags;
  end;
  

implementation

constructor TVarTypeToElementInfoWrapper.Create(ARecord: TVarTypeToElementInfo);
begin
  inherited Create;
  FValidBase := ARecord.ValidBase;
  FValidElement := ARecord.ValidElement;
  FSize := ARecord.Size;
  FFlags := ARecord.Flags;
end;

function TVarTypeToElementInfoWrapper.ObjToRec: TVarTypeToElementInfo;
begin
  result.ValidBase := FValidBase;
  result.ValidElement := FValidElement;
  result.Size := FSize;
  result.Flags := FFlags;
end;



procedure TatVarUtilsLibrary.__ESafeArrayErrorCreateHResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
1: AResult := Integer(ESafeArrayErrorClass(CurrentClass.ClassRef).CreateHResult(VarToInteger(GetInputArg(0))));
2: AResult := Integer(ESafeArrayErrorClass(CurrentClass.ClassRef).CreateHResult(VarToInteger(GetInputArg(0)),GetInputArg(1)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarUtilsLibrary.__GetESafeArrayErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ESafeArrayError(CurrentObject).ErrorCode));
  end;
end;

procedure TatVarUtilsLibrary.__SetESafeArrayErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ESafeArrayError(CurrentObject).ErrorCode:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatVarUtilsLibrary.__VarExceptionToResult(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(VarUtils.VarExceptionToResult(Exception(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatVarUtilsLibrary.__VariantInit(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
    VarUtils.VariantInit(Param0);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantClear(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
AResult := Integer(VarUtils.VariantClear(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantCopy(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
AResult := Integer(VarUtils.VariantCopy(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantCopyInd(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
AResult := Integer(VarUtils.VariantCopyInd(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
  end;
end;

procedure TatVarUtilsLibrary.__VariantChangeType(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TVarData;
  Param3: Word;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is TVarDataWrapper) then 
  Param0Rec := TVarDataWrapper.Create(Param0);
Param0 := TVarDataWrapper(Param0Rec).ObjToRec;
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(VarUtils.VariantChangeType(Param0,TVarDataWrapper(integer(GetInputArg(1))).ObjToRec,VarToInteger(GetInputArg(2)),Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(TVarDataWrapper.Create(Param0)));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatVarUtilsLibrary.__SafeArrayCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    VarUtils.SafeArrayCheck(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatVarUtilsLibrary.__SafeArrayError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    VarUtils.SafeArrayError(VarToInteger(GetInputArg(0)));
  end;
end;

procedure TatVarUtilsLibrary.Init;
begin
  With Scripter.DefineClass(ESafeArrayError) do
  begin
    DefineMethod('CreateHResult',2,tkClass,ESafeArrayError,__ESafeArrayErrorCreateHResult,true,1);
    DefineProp('ErrorCode',tkInteger,__GetESafeArrayErrorErrorCode,__SetESafeArrayErrorErrorCode,nil,false,0);
  end;
  With Scripter.DefineClass(ESafeArrayCreateError) do
  begin
  end;
  With Scripter.DefineClass(ESafeArrayBoundsError) do
  begin
  end;
  With Scripter.DefineClass(ESafeArrayLockedError) do
  begin
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('VarExceptionToResult',1,tkInteger,nil,__VarExceptionToResult,false,0);
    DefineMethod('VariantInit',1,tkNone,nil,__VariantInit,false,0).SetVarArgs([0]);
    DefineMethod('VariantClear',1,tkInteger,nil,__VariantClear,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopy',2,tkInteger,nil,__VariantCopy,false,0).SetVarArgs([0]);
    DefineMethod('VariantCopyInd',2,tkInteger,nil,__VariantCopyInd,false,0).SetVarArgs([0]);
    DefineMethod('VariantChangeType',4,tkInteger,nil,__VariantChangeType,false,0).SetVarArgs([0,3]);
    DefineMethod('SafeArrayCheck',1,tkNone,nil,__SafeArrayCheck,false,0);
    DefineMethod('SafeArrayError',1,tkNone,nil,__SafeArrayError,false,0);
    AddConstant('GenericVarUtils',GenericVarUtils);
    AddConstant('GenericVariants',GenericVariants);
    AddConstant('GenericOperations',GenericOperations);
    AddConstant('GenericSafeArrays',GenericSafeArrays);
    AddConstant('GenericSafeArrayUsesLibC',GenericSafeArrayUsesLibC);
    AddConstant('VAR_OK',VAR_OK);
    AddConstant('VAR_PARAMNOTFOUND',VAR_PARAMNOTFOUND);
    AddConstant('VAR_TYPEMISMATCH',VAR_TYPEMISMATCH);
    AddConstant('VAR_BADVARTYPE',VAR_BADVARTYPE);
    AddConstant('VAR_EXCEPTION',VAR_EXCEPTION);
    AddConstant('VAR_OVERFLOW',VAR_OVERFLOW);
    AddConstant('VAR_BADINDEX',VAR_BADINDEX);
    AddConstant('VAR_ARRAYISLOCKED',VAR_ARRAYISLOCKED);
    AddConstant('VAR_NOTIMPL',VAR_NOTIMPL);
    AddConstant('VAR_OUTOFMEMORY',VAR_OUTOFMEMORY);
    AddConstant('VAR_INVALIDARG',VAR_INVALIDARG);
    AddConstant('VAR_UNEXPECTED',VAR_UNEXPECTED);
    AddConstant('ARR_NONE',ARR_NONE);
    AddConstant('ARR_FIXEDSIZE',ARR_FIXEDSIZE);
    AddConstant('ARR_OLESTR',ARR_OLESTR);
    AddConstant('ARR_UNKNOWN',ARR_UNKNOWN);
    AddConstant('ARR_DISPATCH',ARR_DISPATCH);
    AddConstant('ARR_VARIANT',ARR_VARIANT);
    AddConstant('VAR_CMP_LT',VAR_CMP_LT);
    AddConstant('VAR_CMP_EQ',VAR_CMP_EQ);
    AddConstant('VAR_CMP_GT',VAR_CMP_GT);
    AddConstant('VAR_CMP_NULL',VAR_CMP_NULL);
    AddConstant('VAR_LOCALE_USER_DEFAULT',VAR_LOCALE_USER_DEFAULT);
    AddConstant('CMinArrayVarType',CMinArrayVarType);
    AddConstant('CMaxArrayVarType',CMaxArrayVarType);
  end;
end;

class function TatVarUtilsLibrary.LibraryName: string;
begin
  result := 'VarUtils';
end;

initialization
  RegisterScripterLibrary(TatVarUtilsLibrary, True);

{$WARNINGS ON}

end.

