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
unit ap_ObjAuto;

interface

uses
  TypInfo,
  ObjAuto,
  Variants,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatObjAutoLibrary = class(TatScripterLibrary)
    procedure __ReleaseMethodPointer(AMachine: TatVirtualMachine);
    procedure __GetInvokeInstance(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  TMethodInfoHeaderWrapper = class(TatRecordWrapper)
  private
    FLen: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TMethodInfoHeader);
    function ObjToRec: TMethodInfoHeader;
  published
    property Len: Word read FLen write FLen;
    property Name: ShortString read FName write FName;
  end;
  
  TReturnInfoWrapper = class(TatRecordWrapper)
  private
    FVersion: Byte;
    FCallingConvention: TCallingConvention;
    FParamSize: Word;
    FParamCount: Byte;
  public
    constructor Create(ARecord: TReturnInfo);
    function ObjToRec: TReturnInfo;
  published
    property Version: Byte read FVersion write FVersion;
    property CallingConvention: TCallingConvention read FCallingConvention write FCallingConvention;
    property ParamSize: Word read FParamSize write FParamSize;
    property ParamCount: Byte read FParamCount write FParamCount;
  end;
  
  TParamInfoWrapper = class(TatRecordWrapper)
  private
    FFlags: TParamFlags;
    FAccess: Word;
    FName: ShortString;
  public
    constructor Create(ARecord: TParamInfo);
    function ObjToRec: TParamInfo;
  published
    property Flags: TParamFlags read FFlags write FFlags;
    property Access: Word read FAccess write FAccess;
    property Name: ShortString read FName write FName;
  end;
  
  TParametersWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: TParameters);
    function ObjToRec: TParameters;
  published
  end;
  

implementation

constructor TMethodInfoHeaderWrapper.Create(ARecord: TMethodInfoHeader);
begin
  inherited Create;
  FLen := ARecord.Len;
  FName := ARecord.Name;
end;

function TMethodInfoHeaderWrapper.ObjToRec: TMethodInfoHeader;
begin
  result.Len := FLen;
  result.Name := FName;
end;

constructor TReturnInfoWrapper.Create(ARecord: TReturnInfo);
begin
  inherited Create;
  FVersion := ARecord.Version;
  FCallingConvention := ARecord.CallingConvention;
  FParamSize := ARecord.ParamSize;
  FParamCount := ARecord.ParamCount;
end;

function TReturnInfoWrapper.ObjToRec: TReturnInfo;
begin
  result.Version := FVersion;
  result.CallingConvention := FCallingConvention;
  result.ParamSize := FParamSize;
  result.ParamCount := FParamCount;
end;

constructor TParamInfoWrapper.Create(ARecord: TParamInfo);
begin
  inherited Create;
  FFlags := ARecord.Flags;
  FAccess := ARecord.Access;
  FName := ARecord.Name;
end;

function TParamInfoWrapper.ObjToRec: TParamInfo;
begin
  result.Flags := FFlags;
  result.Access := FAccess;
  result.Name := FName;
end;

constructor TParametersWrapper.Create(ARecord: TParameters);
begin
  inherited Create;
end;

function TParametersWrapper.ObjToRec: TParameters;
begin
end;



procedure TatObjAutoLibrary.__ReleaseMethodPointer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ObjAuto.ReleaseMethodPointer(TMethodWrapper(integer(GetInputArg(0))).ObjToRec);
  end;
end;

procedure TatObjAutoLibrary.__GetInvokeInstance(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ObjAuto.GetInvokeInstance(TMethodWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatObjAutoLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('ReleaseMethodPointer',1,tkNone,nil,__ReleaseMethodPointer,false,0);
    DefineMethod('GetInvokeInstance',1,tkVariant,nil,__GetInvokeInstance,false,0);
    AddConstant('ccRegister',ccRegister);
    AddConstant('ccCdecl',ccCdecl);
    AddConstant('ccPascal',ccPascal);
    AddConstant('ccStdCall',ccStdCall);
    AddConstant('ccSafeCall',ccSafeCall);
    AddConstant('paEAX',paEAX);
    AddConstant('paEDX',paEDX);
    AddConstant('paECX',paECX);
    AddConstant('paStack',paStack);
  end;
end;

class function TatObjAutoLibrary.LibraryName: string;
begin
  result := 'ObjAuto';
end;

initialization
  RegisterScripterLibrary(TatObjAutoLibrary, True);

{$WARNINGS ON}

end.

