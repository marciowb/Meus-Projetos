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
unit ap_Winsafer;

interface

uses
  Windows,
  Winsafer,
  Variants,
  atScript;

{$WARNINGS OFF}

type
  TatWinsaferLibrary = class(TatScripterLibrary)
    procedure __SaferCloseLevel(AMachine: TatVirtualMachine);
    procedure __SaferGetLevelInformation(AMachine: TatVirtualMachine);
    procedure __SaferiIsExecutableFileType(AMachine: TatVirtualMachine);
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _SAFER_IDENTIFICATION_HEADERWrapper = class(TatRecordWrapper)
  private
    FdwIdentificationType: SAFER_IDENTIFICATION_TYPES;
    FcbStructSize: DWORD;
    FIdentificationGuid: TGUID;
  public
    constructor Create(ARecord: _SAFER_IDENTIFICATION_HEADER);
    function ObjToRec: _SAFER_IDENTIFICATION_HEADER;
  published
    property dwIdentificationType: SAFER_IDENTIFICATION_TYPES read FdwIdentificationType write FdwIdentificationType;
    property cbStructSize: DWORD read FcbStructSize write FcbStructSize;
    property IdentificationGuid: TGUID read FIdentificationGuid write FIdentificationGuid;
  end;
  
  _SAFER_PATHNAME_IDENTIFICATIONWrapper = class(TatRecordWrapper)
  private
    FdwSaferFlags: DWORD;
  public
    constructor Create(ARecord: _SAFER_PATHNAME_IDENTIFICATION);
    function ObjToRec: _SAFER_PATHNAME_IDENTIFICATION;
  published
    property dwSaferFlags: DWORD read FdwSaferFlags write FdwSaferFlags;
  end;
  
  _SAFER_HASH_IDENTIFICATIONWrapper = class(TatRecordWrapper)
  private
    FHashSize: DWORD;
    FHashAlgorithm: UINT;
    FdwSaferFlags: DWORD;
  public
    constructor Create(ARecord: _SAFER_HASH_IDENTIFICATION);
    function ObjToRec: _SAFER_HASH_IDENTIFICATION;
  published
    property HashSize: DWORD read FHashSize write FHashSize;
    property HashAlgorithm: UINT read FHashAlgorithm write FHashAlgorithm;
    property dwSaferFlags: DWORD read FdwSaferFlags write FdwSaferFlags;
  end;
  
  _SAFER_HASH_IDENTIFICATION2Wrapper = class(TatRecordWrapper)
  private
    FHashSize: DWORD;
    FHashAlgorithm: UINT;
  public
    constructor Create(ARecord: _SAFER_HASH_IDENTIFICATION2);
    function ObjToRec: _SAFER_HASH_IDENTIFICATION2;
  published
    property HashSize: DWORD read FHashSize write FHashSize;
    property HashAlgorithm: UINT read FHashAlgorithm write FHashAlgorithm;
  end;
  
  _SAFER_URLZONE_IDENTIFICATIONWrapper = class(TatRecordWrapper)
  private
    FUrlZoneId: DWORD;
    FdwSaferFlags: DWORD;
  public
    constructor Create(ARecord: _SAFER_URLZONE_IDENTIFICATION);
    function ObjToRec: _SAFER_URLZONE_IDENTIFICATION;
  published
    property UrlZoneId: DWORD read FUrlZoneId write FUrlZoneId;
    property dwSaferFlags: DWORD read FdwSaferFlags write FdwSaferFlags;
  end;
  

implementation

constructor _SAFER_IDENTIFICATION_HEADERWrapper.Create(ARecord: _SAFER_IDENTIFICATION_HEADER);
begin
  inherited Create;
  FdwIdentificationType := ARecord.dwIdentificationType;
  FcbStructSize := ARecord.cbStructSize;
  FIdentificationGuid := ARecord.IdentificationGuid;
end;

function _SAFER_IDENTIFICATION_HEADERWrapper.ObjToRec: _SAFER_IDENTIFICATION_HEADER;
begin
  result.dwIdentificationType := FdwIdentificationType;
  result.cbStructSize := FcbStructSize;
  result.IdentificationGuid := FIdentificationGuid;
end;

constructor _SAFER_PATHNAME_IDENTIFICATIONWrapper.Create(ARecord: _SAFER_PATHNAME_IDENTIFICATION);
begin
  inherited Create;
  FdwSaferFlags := ARecord.dwSaferFlags;
end;

function _SAFER_PATHNAME_IDENTIFICATIONWrapper.ObjToRec: _SAFER_PATHNAME_IDENTIFICATION;
begin
  result.dwSaferFlags := FdwSaferFlags;
end;

constructor _SAFER_HASH_IDENTIFICATIONWrapper.Create(ARecord: _SAFER_HASH_IDENTIFICATION);
begin
  inherited Create;
  FHashSize := ARecord.HashSize;
  FHashAlgorithm := ARecord.HashAlgorithm;
  FdwSaferFlags := ARecord.dwSaferFlags;
end;

function _SAFER_HASH_IDENTIFICATIONWrapper.ObjToRec: _SAFER_HASH_IDENTIFICATION;
begin
  result.HashSize := FHashSize;
  result.HashAlgorithm := FHashAlgorithm;
  result.dwSaferFlags := FdwSaferFlags;
end;

constructor _SAFER_HASH_IDENTIFICATION2Wrapper.Create(ARecord: _SAFER_HASH_IDENTIFICATION2);
begin
  inherited Create;
  FHashSize := ARecord.HashSize;
  FHashAlgorithm := ARecord.HashAlgorithm;
end;

function _SAFER_HASH_IDENTIFICATION2Wrapper.ObjToRec: _SAFER_HASH_IDENTIFICATION2;
begin
  result.HashSize := FHashSize;
  result.HashAlgorithm := FHashAlgorithm;
end;

constructor _SAFER_URLZONE_IDENTIFICATIONWrapper.Create(ARecord: _SAFER_URLZONE_IDENTIFICATION);
begin
  inherited Create;
  FUrlZoneId := ARecord.UrlZoneId;
  FdwSaferFlags := ARecord.dwSaferFlags;
end;

function _SAFER_URLZONE_IDENTIFICATIONWrapper.ObjToRec: _SAFER_URLZONE_IDENTIFICATION;
begin
  result.UrlZoneId := FUrlZoneId;
  result.dwSaferFlags := FdwSaferFlags;
end;



procedure TatWinsaferLibrary.__SaferCloseLevel(AMachine: TatVirtualMachine);
  var
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsafer.SaferCloseLevel(GetInputArg(0));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsaferLibrary.__SaferGetLevelInformation(AMachine: TatVirtualMachine);
  var
  Param3: DWORD;
  AResult: variant;
begin
  with AMachine do
  begin
Param3 := VarToInteger(GetInputArg(3));
AResult := Winsafer.SaferGetLevelInformation(GetInputArg(0),VarToInteger(GetInputArg(1)),VarToInteger(GetInputArg(2)),Param3);
    ReturnOutputArg(AResult);
    SetInputArg(3,Integer(Param3));
  end;
end;

procedure TatWinsaferLibrary.__SaferiIsExecutableFileType(AMachine: TatVirtualMachine);
  var
  Param0Buf: array[0..127] of WideChar;
  AResult: variant;
begin
  with AMachine do
  begin
AResult := Winsafer.SaferiIsExecutableFileType(StringToWideChar(VarToStr(GetInputArg(0)),Param0Buf,Length(VarToStr(GetInputArg(0)))),GetInputArg(1));
    ReturnOutputArg(AResult);
  end;
end;

procedure TatWinsaferLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    DefineMethod('SaferCloseLevel',1,tkVariant,nil,__SaferCloseLevel,false,0);
    DefineMethod('SaferGetLevelInformation',4,tkVariant,nil,__SaferGetLevelInformation,false,0).SetVarArgs([3]);
    DefineMethod('SaferiIsExecutableFileType',2,tkVariant,nil,__SaferiIsExecutableFileType,false,0);
    AddConstant('SAFER_SCOPEID_MACHINE',SAFER_SCOPEID_MACHINE);
    AddConstant('SAFER_SCOPEID_USER',SAFER_SCOPEID_USER);
    AddConstant('SAFER_LEVELID_FULLYTRUSTED',SAFER_LEVELID_FULLYTRUSTED);
    AddConstant('SAFER_LEVELID_NORMALUSER',SAFER_LEVELID_NORMALUSER);
    AddConstant('SAFER_LEVELID_CONSTRAINED',SAFER_LEVELID_CONSTRAINED);
    AddConstant('SAFER_LEVELID_UNTRUSTED',SAFER_LEVELID_UNTRUSTED);
    AddConstant('SAFER_LEVELID_DISALLOWED',SAFER_LEVELID_DISALLOWED);
    AddConstant('SAFER_LEVEL_OPEN',SAFER_LEVEL_OPEN);
    AddConstant('SAFER_MAX_FRIENDLYNAME_SIZE',SAFER_MAX_FRIENDLYNAME_SIZE);
    AddConstant('SAFER_MAX_DESCRIPTION_SIZE',SAFER_MAX_DESCRIPTION_SIZE);
    AddConstant('SAFER_MAX_HASH_SIZE',SAFER_MAX_HASH_SIZE);
    AddConstant('SAFER_TOKEN_NULL_IF_EQUAL',SAFER_TOKEN_NULL_IF_EQUAL);
    AddConstant('SAFER_TOKEN_COMPARE_ONLY',SAFER_TOKEN_COMPARE_ONLY);
    AddConstant('SAFER_TOKEN_MAKE_INERT',SAFER_TOKEN_MAKE_INERT);
    AddConstant('SAFER_TOKEN_WANT_FLAGS',SAFER_TOKEN_WANT_FLAGS);
    AddConstant('SAFER_CRITERIA_IMAGEPATH',SAFER_CRITERIA_IMAGEPATH);
    AddConstant('SAFER_CRITERIA_NOSIGNEDHASH',SAFER_CRITERIA_NOSIGNEDHASH);
    AddConstant('SAFER_CRITERIA_IMAGEHASH',SAFER_CRITERIA_IMAGEHASH);
    AddConstant('SAFER_CRITERIA_AUTHENTICODE',SAFER_CRITERIA_AUTHENTICODE);
    AddConstant('SAFER_CRITERIA_URLZONE',SAFER_CRITERIA_URLZONE);
    AddConstant('SAFER_CRITERIA_IMAGEPATH_NT',SAFER_CRITERIA_IMAGEPATH_NT);
    AddConstant('SAFER_POLICY_JOBID_MASK',SAFER_POLICY_JOBID_MASK);
    AddConstant('SAFER_POLICY_JOBID_CONSTRAINED',SAFER_POLICY_JOBID_CONSTRAINED);
    AddConstant('SAFER_POLICY_JOBID_UNTRUSTED',SAFER_POLICY_JOBID_UNTRUSTED);
    AddConstant('SAFER_POLICY_ONLY_EXES',SAFER_POLICY_ONLY_EXES);
    AddConstant('SAFER_POLICY_SANDBOX_INERT',SAFER_POLICY_SANDBOX_INERT);
    AddConstant('SAFER_POLICY_HASH_DUPLICATE',SAFER_POLICY_HASH_DUPLICATE);
    AddConstant('SAFER_POLICY_ONLY_AUDIT',SAFER_POLICY_ONLY_AUDIT);
    AddConstant('SAFER_POLICY_BLOCK_CLIENT_UI',SAFER_POLICY_BLOCK_CLIENT_UI);
    AddConstant('SAFER_POLICY_UIFLAGS_MASK',SAFER_POLICY_UIFLAGS_MASK);
    AddConstant('SAFER_POLICY_UIFLAGS_INFORMATION_PROMPT',SAFER_POLICY_UIFLAGS_INFORMATION_PROMPT);
    AddConstant('SAFER_POLICY_UIFLAGS_OPTION_PROMPT',SAFER_POLICY_UIFLAGS_OPTION_PROMPT);
    AddConstant('SAFER_POLICY_UIFLAGS_HIDDEN',SAFER_POLICY_UIFLAGS_HIDDEN);
    AddConstant('SaferPolicyLevelList',SaferPolicyLevelList);
    AddConstant('SaferPolicyEnableTransparentEnforcement',SaferPolicyEnableTransparentEnforcement);
    AddConstant('SaferPolicyDefaultLevel',SaferPolicyDefaultLevel);
    AddConstant('SaferPolicyEvaluateUserScope',SaferPolicyEvaluateUserScope);
    AddConstant('SaferPolicyScopeFlags',SaferPolicyScopeFlags);
    AddConstant('SaferPolicyDefaultLevelFlags',SaferPolicyDefaultLevelFlags);
    AddConstant('SaferPolicyAuthenticodeEnabled',SaferPolicyAuthenticodeEnabled);
    AddConstant('SaferObjectLevelId',SaferObjectLevelId);
    AddConstant('SaferObjectScopeId',SaferObjectScopeId);
    AddConstant('SaferObjectFriendlyName',SaferObjectFriendlyName);
    AddConstant('SaferObjectDescription',SaferObjectDescription);
    AddConstant('SaferObjectBuiltin',SaferObjectBuiltin);
    AddConstant('SaferObjectDisallowed',SaferObjectDisallowed);
    AddConstant('SaferObjectDisableMaxPrivilege',SaferObjectDisableMaxPrivilege);
    AddConstant('SaferObjectInvertDeletedPrivileges',SaferObjectInvertDeletedPrivileges);
    AddConstant('SaferObjectDeletedPrivileges',SaferObjectDeletedPrivileges);
    AddConstant('SaferObjectDefaultOwner',SaferObjectDefaultOwner);
    AddConstant('SaferObjectSidsToDisable',SaferObjectSidsToDisable);
    AddConstant('SaferObjectRestrictedSidsInverted',SaferObjectRestrictedSidsInverted);
    AddConstant('SaferObjectRestrictedSidsAdded',SaferObjectRestrictedSidsAdded);
    AddConstant('SaferObjectAllIdentificationGuids',SaferObjectAllIdentificationGuids);
    AddConstant('SaferObjectSingleIdentification',SaferObjectSingleIdentification);
    AddConstant('SaferObjectExtendedError',SaferObjectExtendedError);
    AddConstant('SaferIdentityDefault',SaferIdentityDefault);
    AddConstant('SaferIdentityTypeImageName',SaferIdentityTypeImageName);
    AddConstant('SaferIdentityTypeImageHash',SaferIdentityTypeImageHash);
    AddConstant('SaferIdentityTypeUrlZone',SaferIdentityTypeUrlZone);
    AddConstant('SaferIdentityTypeCertificate',SaferIdentityTypeCertificate);
  end;
end;

class function TatWinsaferLibrary.LibraryName: string;
begin
  result := 'Winsafer';
end;

initialization
  RegisterScripterLibrary(TatWinsaferLibrary, True);

{$WARNINGS ON}

end.

