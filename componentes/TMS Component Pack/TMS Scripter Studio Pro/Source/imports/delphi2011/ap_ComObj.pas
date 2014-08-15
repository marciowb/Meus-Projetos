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
unit ap_ComObj;

interface

uses
  Variants,
  Windows,
  ActiveX,
  SysUtils,
  Classes,
  ComObj,
  ap_ActiveX,
  ap_System,
  atScript;

{$WARNINGS OFF}

type
  TatComObjLibrary = class(TatScripterLibrary)
    procedure __TComServerObjectGetRegRootAndPrefix(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectHelpFileName(AMachine: TatVirtualMachine);
    procedure __SetTComServerObjectHelpFileName(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectServerFileName(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectServerKey(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectServerName(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectStartSuspended(AMachine: TatVirtualMachine);
    procedure __GetTComServerObjectPerUserRegistration(AMachine: TatVirtualMachine);
    procedure __SetTComServerObjectPerUserRegistration(AMachine: TatVirtualMachine);
    procedure __TComClassManagerCreate(AMachine: TatVirtualMachine);
    procedure __TComClassManagerDestroy(AMachine: TatVirtualMachine);
    procedure __TComClassManagerGetFactoryFromClassID(AMachine: TatVirtualMachine);
    procedure __TComObjectCreate(AMachine: TatVirtualMachine);
    procedure __TComObjectCreateAggregated(AMachine: TatVirtualMachine);
    procedure __TComObjectCreateFromFactory(AMachine: TatVirtualMachine);
    procedure __TComObjectDestroy(AMachine: TatVirtualMachine);
    procedure __TComObjectInitialize(AMachine: TatVirtualMachine);
    procedure __TComObjectObjAddRef(AMachine: TatVirtualMachine);
    procedure __TComObjectObjQueryInterface(AMachine: TatVirtualMachine);
    procedure __TComObjectObjRelease(AMachine: TatVirtualMachine);
    procedure __TComObjectError(AMachine: TatVirtualMachine);
    procedure __GetTComObjectController(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactory(AMachine: TatVirtualMachine);
    procedure __GetTComObjectRefCount(AMachine: TatVirtualMachine);
    procedure __TComObjectFactoryDestroy(AMachine: TatVirtualMachine);
    procedure __TComObjectFactoryCreateComObject(AMachine: TatVirtualMachine);
    procedure __TComObjectFactoryRegisterClassObject(AMachine: TatVirtualMachine);
    procedure __TComObjectFactoryUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryClassID(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryClassName(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryComServer(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryDescription(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryErrorIID(AMachine: TatVirtualMachine);
    procedure __SetTComObjectFactoryErrorIID(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryLicString(AMachine: TatVirtualMachine);
    procedure __SetTComObjectFactoryLicString(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryProgID(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryInstancing(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryShowErrors(AMachine: TatVirtualMachine);
    procedure __SetTComObjectFactoryShowErrors(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactorySupportsLicensing(AMachine: TatVirtualMachine);
    procedure __SetTComObjectFactorySupportsLicensing(AMachine: TatVirtualMachine);
    procedure __GetTComObjectFactoryThreadingModel(AMachine: TatVirtualMachine);
    procedure __TTypedComObjectCreate(AMachine: TatVirtualMachine);
    procedure __TTypedComObjectCreateAggregated(AMachine: TatVirtualMachine);
    procedure __TTypedComObjectCreateFromFactory(AMachine: TatVirtualMachine);
    procedure __TTypedComObjectFactoryUpdateRegistry(AMachine: TatVirtualMachine);
    procedure __TAutoObjectCreate(AMachine: TatVirtualMachine);
    procedure __TAutoObjectCreateAggregated(AMachine: TatVirtualMachine);
    procedure __TAutoObjectCreateFromFactory(AMachine: TatVirtualMachine);
    procedure __TAutoObjectInitialize(AMachine: TatVirtualMachine);
    procedure __GetTAutoObjectFactoryEventIID(AMachine: TatVirtualMachine);
    procedure __GetTAutoIntfObjectDispIID(AMachine: TatVirtualMachine);
    procedure __TConnectionPointGetSink(AMachine: TatVirtualMachine);
    procedure __TConnectionPointGetCount(AMachine: TatVirtualMachine);
    procedure __TConnectionPointDestroy(AMachine: TatVirtualMachine);
    procedure __GetTConnectionPointCount(AMachine: TatVirtualMachine);
    procedure __GetTConnectionPointSinkList(AMachine: TatVirtualMachine);
    procedure __TConnectionPointsCreate(AMachine: TatVirtualMachine);
    procedure __TConnectionPointsDestroy(AMachine: TatVirtualMachine);
    procedure __GetTConnectionPointsController(AMachine: TatVirtualMachine);
    procedure __TAutoObjectEventCreate(AMachine: TatVirtualMachine);
    procedure __TAutoObjectEventDestroy(AMachine: TatVirtualMachine);
    procedure __TAutoObjectEventCreateAggregated(AMachine: TatVirtualMachine);
    procedure __TAutoObjectEventCreateFromFactory(AMachine: TatVirtualMachine);
    procedure __TAutoObjectEventInitialize(AMachine: TatVirtualMachine);
    procedure __GetTAutoObjectEventConnectionPoint(AMachine: TatVirtualMachine);
    procedure __EOleSysErrorCreate(AMachine: TatVirtualMachine);
    procedure __GetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __SetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
    procedure __EOleExceptionCreate(AMachine: TatVirtualMachine);
    procedure __GetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
    procedure __SetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
    procedure __GetEOleExceptionSource(AMachine: TatVirtualMachine);
    procedure __SetEOleExceptionSource(AMachine: TatVirtualMachine);
    procedure __DispatchInvokeError(AMachine: TatVirtualMachine);
    procedure __CreateComObject(AMachine: TatVirtualMachine);
    procedure __CreateRemoteComObject(AMachine: TatVirtualMachine);
    procedure __CreateOleObject(AMachine: TatVirtualMachine);
    procedure __GetActiveOleObject(AMachine: TatVirtualMachine);
    procedure __OleError(AMachine: TatVirtualMachine);
    procedure __OleCheck(AMachine: TatVirtualMachine);
    procedure __StringToGUID(AMachine: TatVirtualMachine);
    procedure __GUIDToString(AMachine: TatVirtualMachine);
    procedure __ProgIDToClassID(AMachine: TatVirtualMachine);
    procedure __ClassIDToProgID(AMachine: TatVirtualMachine);
    procedure __CreateRegKey(AMachine: TatVirtualMachine);
    procedure __DeleteRegKey(AMachine: TatVirtualMachine);
    procedure __GetRegStringValue(AMachine: TatVirtualMachine);
    procedure __StringToLPOLESTR(AMachine: TatVirtualMachine);
    procedure __RegisterComServer(AMachine: TatVirtualMachine);
    procedure __RegisterAsService(AMachine: TatVirtualMachine);
    procedure __CreateClassID(AMachine: TatVirtualMachine);
    procedure __InterfaceConnect(AMachine: TatVirtualMachine);
    procedure __InterfaceDisconnect(AMachine: TatVirtualMachine);
    procedure __GetDispatchPropValue(AMachine: TatVirtualMachine);
    procedure __SetDispatchPropValue(AMachine: TatVirtualMachine);
    procedure __ComClassManager(AMachine: TatVirtualMachine);
    procedure __GetCoInitFlags(AMachine: TatVirtualMachine);
    procedure __SetCoInitFlags(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;

  TComServerObjectClass = class of TComServerObject;
  TComClassManagerClass = class of TComClassManager;
  TComObjectClass = class of TComObject;
  TComObjectFactoryClass = class of TComObjectFactory;
  TTypedComObjectClass = class of TTypedComObject;
  TTypedComObjectFactoryClass = class of TTypedComObjectFactory;
  TAutoObjectClass = class of TAutoObject;
  TAutoObjectFactoryClass = class of TAutoObjectFactory;
  TAutoIntfObjectClass = class of TAutoIntfObject;
  TConnectionPointClass = class of TConnectionPoint;
  TConnectionPointsClass = class of TConnectionPoints;
  TAutoObjectEventClass = class of TAutoObjectEvent;
  EOleErrorClass = class of EOleError;
  EOleSysErrorClass = class of EOleSysError;
  EOleExceptionClass = class of EOleException;
  EOleRegistrationErrorClass = class of EOleRegistrationError;

  TatComObjDispatcher = class(TatEventDispatcher)
  private
    procedure __TFactoryProc( Factory: TComObjectFactory);
    procedure __TConnectEvent(const Sink: IUnknown;  Connecting: Boolean);
  end;


implementation



procedure TatComObjLibrary.__TComServerObjectGetRegRootAndPrefix(AMachine: TatVirtualMachine);
  var
  Param0: HKEY;
  Param1: string;
begin
  with AMachine do
  begin
Param0 := VarToInteger(GetInputArg(0));
Param1 := GetInputArg(1);
    TComServerObjectClass(CurrentClass.ClassRef).GetRegRootAndPrefix(Param0,Param1);
    SetInputArg(0,Integer(Param0));
    SetInputArg(1,Param1);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectHelpFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).HelpFileName);
  end;
end;

procedure TatComObjLibrary.__SetTComServerObjectHelpFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServerObject(CurrentObject).HelpFileName:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectServerFileName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).ServerFileName);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectServerKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).ServerKey);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectServerName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).ServerName);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectStartSuspended(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).StartSuspended);
  end;
end;

procedure TatComObjLibrary.__GetTComServerObjectPerUserRegistration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComServerObject(CurrentObject).PerUserRegistration);
  end;
end;

procedure TatComObjLibrary.__SetTComServerObjectPerUserRegistration(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComServerObject(CurrentObject).PerUserRegistration:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__TComClassManagerCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComClassManagerClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComClassManagerDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComClassManager(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__TComClassManagerGetFactoryFromClassID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComClassManager(CurrentObject).GetFactoryFromClassID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectCreateAggregated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObjectClass(CurrentClass.ClassRef).CreateAggregated(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectCreateFromFactory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObjectClass(CurrentClass.ClassRef).CreateFromFactory(TComObjectFactory(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObject(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__TComObjectInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObject(CurrentObject).Initialize;
  end;
end;

procedure TatComObjLibrary.__TComObjectObjAddRef(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObject(CurrentObject).ObjAddRef);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectObjQueryInterface(AMachine: TatVirtualMachine);
  var
  Param1: Variant;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TComObject(CurrentObject).ObjQueryInterface(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec,Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatComObjLibrary.__TComObjectObjRelease(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObject(CurrentObject).ObjRelease);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectError(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := TComObject(CurrentObject).Error(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectController(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObject(CurrentObject).Controller);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactory(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComObject(CurrentObject).Factory));
  end;
end;

procedure TatComObjLibrary.__GetTComObjectRefCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComObject(CurrentObject).RefCount));
  end;
end;

procedure TatComObjLibrary.__TComObjectFactoryDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__TComObjectFactoryCreateComObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TComObjectFactory(CurrentObject).CreateComObject(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TComObjectFactoryRegisterClassObject(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).RegisterClassObject;
  end;
end;

procedure TatComObjLibrary.__TComObjectFactoryUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryClassID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TComObjectFactory(CurrentObject).ClassID)));
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryClassName(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).ClassName);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryComServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TComObjectFactory(CurrentObject).ComServer));
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryDescription(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).Description);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryErrorIID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TComObjectFactory(CurrentObject).ErrorIID)));
  end;
end;

procedure TatComObjLibrary.__SetTComObjectFactoryErrorIID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).ErrorIID:=TGUIDWrapper(integer(GetInputArg(0))).ObjToRec;
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryLicString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).LicString);
  end;
end;

procedure TatComObjLibrary.__SetTComObjectFactoryLicString(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).LicString:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryProgID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).ProgID);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryInstancing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).Instancing);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryShowErrors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).ShowErrors);
  end;
end;

procedure TatComObjLibrary.__SetTComObjectFactoryShowErrors(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).ShowErrors:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactorySupportsLicensing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).SupportsLicensing);
  end;
end;

procedure TatComObjLibrary.__SetTComObjectFactorySupportsLicensing(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TComObjectFactory(CurrentObject).SupportsLicensing:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__GetTComObjectFactoryThreadingModel(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TComObjectFactory(CurrentObject).ThreadingModel);
  end;
end;

procedure TatComObjLibrary.__TTypedComObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTypedComObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TTypedComObjectCreateAggregated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTypedComObjectClass(CurrentClass.ClassRef).CreateAggregated(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TTypedComObjectCreateFromFactory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TTypedComObjectClass(CurrentClass.ClassRef).CreateFromFactory(TComObjectFactory(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TTypedComObjectFactoryUpdateRegistry(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TTypedComObjectFactory(CurrentObject).UpdateRegistry(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.__TAutoObjectCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectCreateAggregated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectClass(CurrentClass.ClassRef).CreateAggregated(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectCreateFromFactory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectClass(CurrentClass.ClassRef).CreateFromFactory(TComObjectFactory(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutoObject(CurrentObject).Initialize;
  end;
end;

procedure TatComObjLibrary.__GetTAutoObjectFactoryEventIID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TAutoObjectFactory(CurrentObject).EventIID)));
  end;
end;

procedure TatComObjLibrary.__GetTAutoIntfObjectDispIID(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(integer(TGUIDWrapper.Create(TAutoIntfObject(CurrentObject).DispIID)));
  end;
end;

procedure TatComObjLibrary.__TConnectionPointGetSink(AMachine: TatVirtualMachine);
  var
  Param1: IUnknown;
  AResult: variant;
begin
  with AMachine do
  begin
Param1 := GetInputArg(1);
AResult := TConnectionPoint(CurrentObject).GetSink(VarToInteger(GetInputArg(0)),Param1);
    ReturnOutputArg(AResult);
    SetInputArg(1,Param1);
  end;
end;

procedure TatComObjLibrary.__TConnectionPointGetCount(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConnectionPoint(CurrentObject).GetCount);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TConnectionPointDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConnectionPoint(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__GetTConnectionPointCount(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TConnectionPoint(CurrentObject).Count));
  end;
end;

procedure TatComObjLibrary.__GetTConnectionPointSinkList(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TConnectionPoint(CurrentObject).SinkList));
  end;
end;

procedure TatComObjLibrary.__TConnectionPointsCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TConnectionPointsClass(CurrentClass.ClassRef).Create(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TConnectionPointsDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TConnectionPoints(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__GetTConnectionPointsController(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(TConnectionPoints(CurrentObject).Controller);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectEventCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectEventClass(CurrentClass.ClassRef).Create);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectEventDestroy(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutoObjectEvent(CurrentObject).Destroy;
  end;
end;

procedure TatComObjLibrary.__TAutoObjectEventCreateAggregated(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectEventClass(CurrentClass.ClassRef).CreateAggregated(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectEventCreateFromFactory(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(TAutoObjectEventClass(CurrentClass.ClassRef).CreateFromFactory(TComObjectFactory(Integer(GetInputArg(0))),GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__TAutoObjectEventInitialize(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    TAutoObjectEvent(CurrentObject).Initialize;
  end;
end;

procedure TatComObjLibrary.__GetTAutoObjectEventConnectionPoint(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(TAutoObjectEvent(CurrentObject).ConnectionPoint));
  end;
end;

procedure TatComObjLibrary.__EOleSysErrorCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EOleSysErrorClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EOleSysError(CurrentObject).ErrorCode);
  end;
end;

procedure TatComObjLibrary.__SetEOleSysErrorErrorCode(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EOleSysError(CurrentObject).ErrorCode:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__EOleExceptionCreate(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(EOleExceptionClass(CurrentClass.ClassRef).Create(GetInputArg(0),GetInputArg(1),GetInputArg(2),GetInputArg(3),VarToInteger(GetInputArg(4))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EOleException(CurrentObject).HelpFile);
  end;
end;

procedure TatComObjLibrary.__SetEOleExceptionHelpFile(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EOleException(CurrentObject).HelpFile:=GetInputArg(0);
  end;
end;

procedure TatComObjLibrary.__GetEOleExceptionSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(EOleException(CurrentObject).Source);
  end;
end;

procedure TatComObjLibrary.__SetEOleExceptionSource(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    EOleException(CurrentObject).Source:=GetInputArg(0);
  end;
end;

procedure TatComObjDispatcher.__TFactoryProc( Factory: TComObjectFactory);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TFactoryProc(BeforeCall)(Factory);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Factory]);
    if AssignedMethod(AfterCall) then
      TFactoryProc(AfterCall)(Factory);
  end;
end;

procedure TatComObjDispatcher.__TConnectEvent(const Sink: IUnknown;  Connecting: Boolean);
begin
  if DoOnExecuteEvent then
  begin
    if AssignedMethod(BeforeCall) then
      TConnectEvent(BeforeCall)(Sink,Connecting);
    if Assigned(Scripter) and (RoutineName > '') then
      Scripter.ExecuteSubroutine(RoutineName, [Sink,Connecting]);
    if AssignedMethod(AfterCall) then
      TConnectEvent(AfterCall)(Sink,Connecting);
  end;
end;

procedure TatComObjLibrary.__DispatchInvokeError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.DispatchInvokeError(VarToInteger(GetInputArg(0)),tagEXCEPINFOWrapper(integer(GetInputArg(1))).ObjToRec);
  end;
end;

procedure TatComObjLibrary.__CreateComObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.CreateComObject(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__CreateRemoteComObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.CreateRemoteComObject(GetInputArg(0),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__CreateOleObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.CreateOleObject(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GetActiveOleObject(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.GetActiveOleObject(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__OleError(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.OleError(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.__OleCheck(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.OleCheck(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.__StringToGUID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(ComObj.StringToGUID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GUIDToString(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.GUIDToString(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__ProgIDToClassID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := integer(TGUIDWrapper.Create(ComObj.ProgIDToClassID(GetInputArg(0))));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__ClassIDToProgID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.ClassIDToProgID(TGUIDWrapper(integer(GetInputArg(0))).ObjToRec);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__CreateRegKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      3: ComObj.CreateRegKey(GetInputArg(0),GetInputArg(1),GetInputArg(2));
      4: ComObj.CreateRegKey(GetInputArg(0),GetInputArg(1),GetInputArg(2),VarToInteger(GetInputArg(3)));
    end;
  end;
end;

procedure TatComObjLibrary.__DeleteRegKey(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    Case InputArgCount of
      1: ComObj.DeleteRegKey(GetInputArg(0));
      2: ComObj.DeleteRegKey(GetInputArg(0),VarToInteger(GetInputArg(1)));
    end;
  end;
end;

procedure TatComObjLibrary.__GetRegStringValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
case InputArgCount of
2: AResult := ComObj.GetRegStringValue(GetInputArg(0),GetInputArg(1));
3: AResult := ComObj.GetRegStringValue(GetInputArg(0),GetInputArg(1),VarToInteger(GetInputArg(2)));
end;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__StringToLPOLESTR(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := WideCharToString(ComObj.StringToLPOLESTR(GetInputArg(0)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__RegisterComServer(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.RegisterComServer(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.__RegisterAsService(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.RegisterAsService(GetInputArg(0),GetInputArg(1));
  end;
end;

procedure TatComObjLibrary.__CreateClassID(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.CreateClassID;
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__InterfaceConnect(AMachine: TatVirtualMachine);
  var
  Param3: Longint;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
    ComObj.InterfaceConnect(GetInputArg(0),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,GetInputArg(2),Param3);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatComObjLibrary.__InterfaceDisconnect(AMachine: TatVirtualMachine);
  var
  Param2: Longint;
begin
  with AMachine do
  begin
Param2 := VarToInteger(GetInputArg(2));
    ComObj.InterfaceDisconnect(GetInputArg(0),TGUIDWrapper(integer(GetInputArg(1))).ObjToRec,Param2);
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatComObjLibrary.__GetDispatchPropValue(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := ComObj.GetDispatchPropValue(GetInputArg(0),VarToInteger(GetInputArg(1)));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__SetDispatchPropValue(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.SetDispatchPropValue(GetInputArg(0),VarToInteger(GetInputArg(1)),GetInputArg(2));
  end;
end;

procedure TatComObjLibrary.__ComClassManager(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Integer(ComObj.ComClassManager);
    ReturnOutputArg(AResult);
  end;
end;

procedure TatComObjLibrary.__GetCoInitFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ReturnOutputArg(Integer(ComObj.CoInitFlags));
  end;
end;

procedure TatComObjLibrary.__SetCoInitFlags(AMachine: TatVirtualMachine);
begin
  with AMachine do
  begin
    ComObj.CoInitFlags:=VarToInteger(GetInputArg(0));
  end;
end;

procedure TatComObjLibrary.Init;
begin
  With Scripter.DefineClass(TComServerObject) do
  begin
    DefineMethod('GetRegRootAndPrefix',2,tkNone,nil,__TComServerObjectGetRegRootAndPrefix,true,0).SetVarArgs([0,1]);
    DefineProp('HelpFileName',tkVariant,__GetTComServerObjectHelpFileName,__SetTComServerObjectHelpFileName,nil,false,0);
    DefineProp('ServerFileName',tkVariant,__GetTComServerObjectServerFileName,nil,nil,false,0);
    DefineProp('ServerKey',tkVariant,__GetTComServerObjectServerKey,nil,nil,false,0);
    DefineProp('ServerName',tkVariant,__GetTComServerObjectServerName,nil,nil,false,0);
    DefineProp('StartSuspended',tkVariant,__GetTComServerObjectStartSuspended,nil,nil,false,0);
    DefineProp('PerUserRegistration',tkVariant,__GetTComServerObjectPerUserRegistration,__SetTComServerObjectPerUserRegistration,nil,false,0);
  end;
  With Scripter.DefineClass(TComClassManager) do
  begin
    DefineMethod('Create',0,tkClass,TComClassManager,__TComClassManagerCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TComClassManagerDestroy,false,0);
    DefineMethod('GetFactoryFromClassID',1,tkClass,TComObjectFactory,__TComClassManagerGetFactoryFromClassID,false,0);
  end;
  With Scripter.DefineClass(TComObject) do
  begin
    DefineMethod('Create',0,tkClass,TComObject,__TComObjectCreate,true,0);
    DefineMethod('CreateAggregated',1,tkClass,TComObject,__TComObjectCreateAggregated,true,0);
    DefineMethod('CreateFromFactory',2,tkClass,TComObject,__TComObjectCreateFromFactory,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TComObjectDestroy,false,0);
    DefineMethod('Initialize',0,tkNone,nil,__TComObjectInitialize,false,0);
    DefineMethod('ObjAddRef',0,tkInteger,nil,__TComObjectObjAddRef,false,0);
    DefineMethod('ObjQueryInterface',2,tkVariant,nil,__TComObjectObjQueryInterface,false,0).SetVarArgs([1]);
    DefineMethod('ObjRelease',0,tkInteger,nil,__TComObjectObjRelease,false,0);
    DefineMethod('Error',1,tkVariant,nil,__TComObjectError,false,0);
    DefineProp('Controller',tkVariant,__GetTComObjectController,nil,nil,false,0);
    DefineProp('Factory',tkClass,__GetTComObjectFactory,nil,TComObjectFactory,false,0);
    DefineProp('RefCount',tkInteger,__GetTComObjectRefCount,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TComObjectFactory) do
  begin
    DefineMethod('Destroy',0,tkNone,nil,__TComObjectFactoryDestroy,false,0);
    DefineMethod('CreateComObject',1,tkClass,TComObject,__TComObjectFactoryCreateComObject,false,0);
    DefineMethod('RegisterClassObject',0,tkNone,nil,__TComObjectFactoryRegisterClassObject,false,0);
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TComObjectFactoryUpdateRegistry,false,0);
    DefineProp('ClassID',tkVariant,__GetTComObjectFactoryClassID,nil,nil,false,0);
    DefineProp('ClassName',tkVariant,__GetTComObjectFactoryClassName,nil,nil,false,0);
    DefineProp('ComServer',tkClass,__GetTComObjectFactoryComServer,nil,TComServerObject,false,0);
    DefineProp('Description',tkVariant,__GetTComObjectFactoryDescription,nil,nil,false,0);
    DefineProp('ErrorIID',tkVariant,__GetTComObjectFactoryErrorIID,__SetTComObjectFactoryErrorIID,nil,false,0);
    DefineProp('LicString',tkVariant,__GetTComObjectFactoryLicString,__SetTComObjectFactoryLicString,nil,false,0);
    DefineProp('ProgID',tkVariant,__GetTComObjectFactoryProgID,nil,nil,false,0);
    DefineProp('Instancing',tkEnumeration,__GetTComObjectFactoryInstancing,nil,nil,false,0);
    DefineProp('ShowErrors',tkVariant,__GetTComObjectFactoryShowErrors,__SetTComObjectFactoryShowErrors,nil,false,0);
    DefineProp('SupportsLicensing',tkVariant,__GetTComObjectFactorySupportsLicensing,__SetTComObjectFactorySupportsLicensing,nil,false,0);
    DefineProp('ThreadingModel',tkEnumeration,__GetTComObjectFactoryThreadingModel,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TTypedComObject) do
  begin
    DefineMethod('Create',0,tkClass,TTypedComObject,__TTypedComObjectCreate,true,0);
    DefineMethod('CreateAggregated',1,tkClass,TTypedComObject,__TTypedComObjectCreateAggregated,true,0);
    DefineMethod('CreateFromFactory',2,tkClass,TTypedComObject,__TTypedComObjectCreateFromFactory,true,0);
  end;
  With Scripter.DefineClass(TTypedComObjectFactory) do
  begin
    DefineMethod('UpdateRegistry',1,tkNone,nil,__TTypedComObjectFactoryUpdateRegistry,false,0);
  end;
  With Scripter.DefineClass(TAutoObject) do
  begin
    DefineMethod('Create',0,tkClass,TAutoObject,__TAutoObjectCreate,true,0);
    DefineMethod('CreateAggregated',1,tkClass,TAutoObject,__TAutoObjectCreateAggregated,true,0);
    DefineMethod('CreateFromFactory',2,tkClass,TAutoObject,__TAutoObjectCreateFromFactory,true,0);
    DefineMethod('Initialize',0,tkNone,nil,__TAutoObjectInitialize,false,0);
  end;
  With Scripter.DefineClass(TAutoObjectFactory) do
  begin
    DefineProp('EventIID',tkVariant,__GetTAutoObjectFactoryEventIID,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TAutoIntfObject) do
  begin
    DefineProp('DispIID',tkVariant,__GetTAutoIntfObjectDispIID,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TConnectionPoint) do
  begin
    DefineMethod('GetSink',2,tkVariant,nil,__TConnectionPointGetSink,false,0).SetVarArgs([1]);
    DefineMethod('GetCount',0,tkInteger,nil,__TConnectionPointGetCount,false,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConnectionPointDestroy,false,0);
    DefineProp('Count',tkInteger,__GetTConnectionPointCount,nil,nil,false,0);
    DefineProp('SinkList',tkClass,__GetTConnectionPointSinkList,nil,TList,false,0);
  end;
  With Scripter.DefineClass(TConnectionPoints) do
  begin
    DefineMethod('Create',1,tkClass,TConnectionPoints,__TConnectionPointsCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TConnectionPointsDestroy,false,0);
    DefineProp('Controller',tkVariant,__GetTConnectionPointsController,nil,nil,false,0);
  end;
  With Scripter.DefineClass(TAutoObjectEvent) do
  begin
    DefineMethod('Create',0,tkClass,TAutoObjectEvent,__TAutoObjectEventCreate,true,0);
    DefineMethod('Destroy',0,tkNone,nil,__TAutoObjectEventDestroy,false,0);
    DefineMethod('CreateAggregated',1,tkClass,TAutoObjectEvent,__TAutoObjectEventCreateAggregated,true,0);
    DefineMethod('CreateFromFactory',2,tkClass,TAutoObjectEvent,__TAutoObjectEventCreateFromFactory,true,0);
    DefineMethod('Initialize',0,tkNone,nil,__TAutoObjectEventInitialize,false,0);
    DefineProp('ConnectionPoint',tkClass,__GetTAutoObjectEventConnectionPoint,nil,TConnectionPoint,false,0);
  end;
  With Scripter.DefineClass(EOleError) do
  begin
  end;
  With Scripter.DefineClass(EOleSysError) do
  begin
    DefineMethod('Create',3,tkClass,EOleSysError,__EOleSysErrorCreate,true,0);
    DefineProp('ErrorCode',tkVariant,__GetEOleSysErrorErrorCode,__SetEOleSysErrorErrorCode,nil,false,0);
  end;
  With Scripter.DefineClass(EOleException) do
  begin
    DefineMethod('Create',5,tkClass,EOleException,__EOleExceptionCreate,true,0);
    DefineProp('HelpFile',tkVariant,__GetEOleExceptionHelpFile,__SetEOleExceptionHelpFile,nil,false,0);
    DefineProp('Source',tkVariant,__GetEOleExceptionSource,__SetEOleExceptionSource,nil,false,0);
  end;
  With Scripter.DefineClass(EOleRegistrationError) do
  begin
  end;
  DefineEventAdapter(TypeInfo(TFactoryProc), TatComObjDispatcher, @TatComObjDispatcher.__TFactoryProc);
  DefineEventAdapter(TypeInfo(TConnectEvent), TatComObjDispatcher, @TatComObjDispatcher.__TConnectEvent);
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('DispatchInvokeError',2,tkNone,nil,__DispatchInvokeError,false,0);
    DefineMethod('CreateComObject',1,tkVariant,nil,__CreateComObject,false,0);
    DefineMethod('CreateRemoteComObject',2,tkVariant,nil,__CreateRemoteComObject,false,0);
    DefineMethod('CreateOleObject',1,tkVariant,nil,__CreateOleObject,false,0);
    DefineMethod('GetActiveOleObject',1,tkVariant,nil,__GetActiveOleObject,false,0);
    DefineMethod('OleError',1,tkNone,nil,__OleError,false,0);
    DefineMethod('OleCheck',1,tkNone,nil,__OleCheck,false,0);
    DefineMethod('StringToGUID',1,tkVariant,nil,__StringToGUID,false,0);
    DefineMethod('GUIDToString',1,tkVariant,nil,__GUIDToString,false,0);
    DefineMethod('ProgIDToClassID',1,tkVariant,nil,__ProgIDToClassID,false,0);
    DefineMethod('ClassIDToProgID',1,tkVariant,nil,__ClassIDToProgID,false,0);
    DefineMethod('CreateRegKey',4,tkNone,nil,__CreateRegKey,false,1);
    DefineMethod('DeleteRegKey',2,tkNone,nil,__DeleteRegKey,false,1);
    DefineMethod('GetRegStringValue',3,tkVariant,nil,__GetRegStringValue,false,1);
    DefineMethod('StringToLPOLESTR',1,tkVariant,nil,__StringToLPOLESTR,false,0);
    DefineMethod('RegisterComServer',1,tkNone,nil,__RegisterComServer,false,0);
    DefineMethod('RegisterAsService',2,tkNone,nil,__RegisterAsService,false,0);
    DefineMethod('CreateClassID',0,tkVariant,nil,__CreateClassID,false,0);
    DefineMethod('InterfaceConnect',4,tkNone,nil,__InterfaceConnect,false,0).SetVarArgs([3]);
    DefineMethod('InterfaceDisconnect',3,tkNone,nil,__InterfaceDisconnect,false,0).SetVarArgs([2]);
    DefineMethod('GetDispatchPropValue',2,tkVariant,nil,__GetDispatchPropValue,false,0);
    DefineMethod('SetDispatchPropValue',3,tkNone,nil,__SetDispatchPropValue,false,0);
    DefineMethod('ComClassManager',0,tkClass,TComClassManager,__ComClassManager,false,0);
    DefineProp('CoInitFlags',tkInteger,__GetCoInitFlags,__SetCoInitFlags,nil,false,0);
    AddConstant('ciInternal',ciInternal);
    AddConstant('ciSingleInstance',ciSingleInstance);
    AddConstant('ciMultiInstance',ciMultiInstance);
    AddConstant('tmSingle',tmSingle);
    AddConstant('tmApartment',tmApartment);
    AddConstant('tmFree',tmFree);
    AddConstant('tmBoth',tmBoth);
    AddConstant('tmNeutral',tmNeutral);
    AddConstant('ckSingle',ckSingle);
    AddConstant('ckMulti',ckMulti);
  end;
end;

class function TatComObjLibrary.LibraryName: string;
begin
  result := 'ComObj';
end;

initialization
  RegisterScripterLibrary(TatComObjLibrary, True);

{$WARNINGS ON}

end.

