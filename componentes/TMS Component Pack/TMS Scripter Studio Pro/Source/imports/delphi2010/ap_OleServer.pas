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
unit ap_OleServer;

interface

uses
  Windows,
  Messages,
  ActiveX,
  SysUtils,
  Classes,
  ComObj,
  OleServer,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatOleServerLibrary = class(TatScripterLibrary)
    procedure __TServerEventDispatchCreate(AMachine: TatVirtualMachine);
    procedure __TOleServerCreate(AMachine: TatVirtualMachine);
    procedure __TOleServerDestroy(AMachine: TatVirtualMachine);
    procedure __TOleServerConnect(AMachine: TatVirtualMachine);
    procedure __TOleServerDisconnect(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TServerEventDispatchClass = class of TServerEventDispatch;
  TOleServerClass = class of TOleServer;


  TServerDataWrapper = class(TatRecordWrapper)
  private
    FClassID: TGUID;
    FIntfIID: TGUID;
    FEventIID: TGUID;
    FVersion: Integer;
    FInstanceCount: Integer;
  public
    constructor Create(ARecord: TServerData);
    function ObjToRec: TServerData;
  published
    property ClassID: TGUID read FClassID write FClassID;
    property IntfIID: TGUID read FIntfIID write FIntfIID;
    property EventIID: TGUID read FEventIID write FEventIID;
    property Version: Integer read FVersion write FVersion;
    property InstanceCount: Integer read FInstanceCount write FInstanceCount;
  end;
  

implementation

constructor TServerDataWrapper.Create(ARecord: TServerData);
begin
  inherited Create;
  FClassID := ARecord.ClassID;
  FIntfIID := ARecord.IntfIID;
  FEventIID := ARecord.EventIID;
  FVersion := ARecord.Version;
  FInstanceCount := ARecord.InstanceCount;
end;

function TServerDataWrapper.ObjToRec: TServerData;
begin
  result.ClassID := FClassID;
  result.IntfIID := FIntfIID;
  result.EventIID := FEventIID;
  result.Version := FVersion;
  result.InstanceCount := FInstanceCount;
end;



procedure TatOleServerLibrary.__TServerEventDispatchCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TServerEventDispatchClass(CurrentClass.ClassRef).Create(TOleServer(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleServerLibrary.__TOleServerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TOleServerClass(CurrentClass.ClassRef).Create(TComponent(Integer(GetInputArg(0)))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatOleServerLibrary.__TOleServerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleServer(CurrentObject).Destroy;
  end;
end;

procedure TatOleServerLibrary.__TOleServerConnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleServer(CurrentObject).Connect;
  end;
end;

procedure TatOleServerLibrary.__TOleServerDisconnect(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TOleServer(CurrentObject).Disconnect;
  end;
end;

procedure TatOleServerLibrary.Init;
begin
  With Scripter.DefineClass(TServerEventDispatch) do
  begin
    DefineMethod('Create',1,tkClass,TServerEventDispatch,__TServerEventDispatchCreate,true,0);
  end;
  With Scripter.DefineClass(TOleServer) do
  begin
    DefineMethod('Create',1,tkClass,TOleServer,__TOleServerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TOleServerDestroy,false,0);
    DefineMethod('Connect',0,tkNone,nil,__TOleServerConnect,false,0);
    DefineMethod('Disconnect',0,tkNone,nil,__TOleServerDisconnect,false,0);
  end;
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('ckRunningOrNew',ckRunningOrNew);
    AddConstant('ckNewInstance',ckNewInstance);
    AddConstant('ckRunningInstance',ckRunningInstance);
    AddConstant('ckRemote',ckRemote);
    AddConstant('ckAttachToInterface',ckAttachToInterface);
  end;
end;

class function TatOleServerLibrary.LibraryName: string;
begin
  result := 'OleServer';
end;

initialization
  RegisterScripterLibrary(TatOleServerLibrary, True);

{$WARNINGS ON}

end.

