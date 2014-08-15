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
unit ap_AclAPI;

interface

uses
  Windows,
  AccCtrl,
  AclAPI,
  Variants,
  ap_Windows,
  ap_AccCtrl,
  atScript;

{$WARNINGS OFF}

type
  TatAclAPILibrary = class(TatScripterLibrary)
    procedure __GetEffectiveRightsFromAcl(AMachine: TatVirtualMachine);
    procedure __GetEffectiveRightsFromAclA(AMachine: TatVirtualMachine);
    procedure __GetEffectiveRightsFromAclW(AMachine: TatVirtualMachine);
    procedure __GetAuditedPermissionsFromAcl(AMachine: TatVirtualMachine);
    procedure __GetAuditedPermissionsFromAclA(AMachine: TatVirtualMachine);
    procedure __GetAuditedPermissionsFromAclW(AMachine: TatVirtualMachine);
    procedure __GetTrusteeName(AMachine: TatVirtualMachine);
    procedure __GetTrusteeNameA(AMachine: TatVirtualMachine);
    procedure __GetTrusteeNameW(AMachine: TatVirtualMachine);
    procedure __GetTrusteeType(AMachine: TatVirtualMachine);
    procedure __GetTrusteeTypeA(AMachine: TatVirtualMachine);
    procedure __GetTrusteeTypeW(AMachine: TatVirtualMachine);
    procedure __GetTrusteeForm(AMachine: TatVirtualMachine);
    procedure __GetTrusteeFormA(AMachine: TatVirtualMachine);
    procedure __GetTrusteeFormW(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;




implementation



procedure TatAclAPILibrary.__GetEffectiveRightsFromAcl(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_;
  Param2: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_AWrapper) then 
  Param1Rec := _TRUSTEE_AWrapper.Create(Param1);
Param1 := _TRUSTEE_AWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(AclAPI.GetEffectiveRightsFromAcl(Param0,Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_AWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatAclAPILibrary.__GetEffectiveRightsFromAclA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_A;
  Param2: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_AWrapper) then 
  Param1Rec := _TRUSTEE_AWrapper.Create(Param1);
Param1 := _TRUSTEE_AWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(AclAPI.GetEffectiveRightsFromAclA(Param0,Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_AWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatAclAPILibrary.__GetEffectiveRightsFromAclW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_W;
  Param2: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_WWrapper) then 
  Param1Rec := _TRUSTEE_WWrapper.Create(Param1);
Param1 := _TRUSTEE_WWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
AResult := Integer(AclAPI.GetEffectiveRightsFromAclW(Param0,Param1,Param2));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_WWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
  end;
end;

procedure TatAclAPILibrary.__GetAuditedPermissionsFromAcl(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_;
  Param2: ACCESS_MASK;
  Param3: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_AWrapper) then 
  Param1Rec := _TRUSTEE_AWrapper.Create(Param1);
Param1 := _TRUSTEE_AWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(AclAPI.GetAuditedPermissionsFromAcl(Param0,Param1,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_AWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatAclAPILibrary.__GetAuditedPermissionsFromAclA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_A;
  Param2: ACCESS_MASK;
  Param3: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_AWrapper) then 
  Param1Rec := _TRUSTEE_AWrapper.Create(Param1);
Param1 := _TRUSTEE_AWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(AclAPI.GetAuditedPermissionsFromAclA(Param0,Param1,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_AWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatAclAPILibrary.__GetAuditedPermissionsFromAclW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: ACL;
  Param1Rec: TObject;
  Param1: TRUSTEE_W;
  Param2: ACCESS_MASK;
  Param3: ACCESS_MASK;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _ACLWrapper) then 
  Param0Rec := _ACLWrapper.Create(Param0);
Param0 := _ACLWrapper(Param0Rec).ObjToRec;
Param1Rec := TObject(integer(GetInputArg(1)));
if not Assigned(Param1Rec) or not (Param1Rec is _TRUSTEE_WWrapper) then 
  Param1Rec := _TRUSTEE_WWrapper.Create(Param1);
Param1 := _TRUSTEE_WWrapper(Param1Rec).ObjToRec;
Param2 := VarToInteger(GetInputArg(2));
Param3 := VarToInteger(GetInputArg(3));
AResult := Integer(AclAPI.GetAuditedPermissionsFromAclW(Param0,Param1,Param2,Param3));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_ACLWrapper.Create(Param0)));
    SetInputArg(1,integer(_TRUSTEE_WWrapper.Create(Param1)));
    SetInputArg(2,Integer(Param2));
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeName(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := string(AclAPI.GetTrusteeName(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeNameA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_A;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := string(AclAPI.GetTrusteeNameA(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeNameW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_W;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_WWrapper) then 
  Param0Rec := _TRUSTEE_WWrapper.Create(Param0);
Param0 := _TRUSTEE_WWrapper(Param0Rec).ObjToRec;
AResult := string(AclAPI.GetTrusteeNameW(Param0));
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_WWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeType(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeType(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeTypeA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_A;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeTypeA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeTypeW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_W;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_WWrapper) then 
  Param0Rec := _TRUSTEE_WWrapper.Create(Param0);
Param0 := _TRUSTEE_WWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeTypeW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_WWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeForm(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeForm(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeFormA(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_A;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_AWrapper) then 
  Param0Rec := _TRUSTEE_AWrapper.Create(Param0);
Param0 := _TRUSTEE_AWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeFormA(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_AWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.__GetTrusteeFormW(AMachine: TatVirtualMachine);
  var
  Param0Rec: TObject;
  Param0: TRUSTEE_W;
  AResult: variant;
begin
  with AMachine do
  begin
Param0Rec := TObject(integer(GetInputArg(0)));
if not Assigned(Param0Rec) or not (Param0Rec is _TRUSTEE_WWrapper) then 
  Param0Rec := _TRUSTEE_WWrapper.Create(Param0);
Param0 := _TRUSTEE_WWrapper(Param0Rec).ObjToRec;
AResult := AclAPI.GetTrusteeFormW(Param0);
    ReturnOutputArg(AResult);
    SetInputArg(0,integer(_TRUSTEE_WWrapper.Create(Param0)));
  end;
end;

procedure TatAclAPILibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('GetEffectiveRightsFromAcl',3,tkInteger,nil,__GetEffectiveRightsFromAcl,false,0).SetVarArgs([0,1,2]);
    DefineMethod('GetEffectiveRightsFromAclA',3,tkInteger,nil,__GetEffectiveRightsFromAclA,false,0).SetVarArgs([0,1,2]);
    DefineMethod('GetEffectiveRightsFromAclW',3,tkInteger,nil,__GetEffectiveRightsFromAclW,false,0).SetVarArgs([0,1,2]);
    DefineMethod('GetAuditedPermissionsFromAcl',4,tkInteger,nil,__GetAuditedPermissionsFromAcl,false,0).SetVarArgs([0,1,2,3]);
    DefineMethod('GetAuditedPermissionsFromAclA',4,tkInteger,nil,__GetAuditedPermissionsFromAclA,false,0).SetVarArgs([0,1,2,3]);
    DefineMethod('GetAuditedPermissionsFromAclW',4,tkInteger,nil,__GetAuditedPermissionsFromAclW,false,0).SetVarArgs([0,1,2,3]);
    DefineMethod('GetTrusteeName',1,tkVariant,nil,__GetTrusteeName,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeNameA',1,tkVariant,nil,__GetTrusteeNameA,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeNameW',1,tkVariant,nil,__GetTrusteeNameW,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeType',1,tkEnumeration,nil,__GetTrusteeType,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeTypeA',1,tkEnumeration,nil,__GetTrusteeTypeA,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeTypeW',1,tkEnumeration,nil,__GetTrusteeTypeW,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeForm',1,tkEnumeration,nil,__GetTrusteeForm,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeFormA',1,tkEnumeration,nil,__GetTrusteeFormA,false,0).SetVarArgs([0]);
    DefineMethod('GetTrusteeFormW',1,tkEnumeration,nil,__GetTrusteeFormW,false,0).SetVarArgs([0]);
  end;
end;

class function TatAclAPILibrary.LibraryName: string;
begin
  result := 'AclAPI';
end;

initialization
  RegisterScripterLibrary(TatAclAPILibrary, True);

{$WARNINGS ON}

end.

