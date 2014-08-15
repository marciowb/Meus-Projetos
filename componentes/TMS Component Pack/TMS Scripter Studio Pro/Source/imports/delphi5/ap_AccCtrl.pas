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
unit ap_AccCtrl;

interface

uses
  Windows,
  AccCtrl,
  atScript;

{$WARNINGS OFF}

type
  TatAccCtrlLibrary = class(TatScripterLibrary)
    procedure Init; override;
    class function LibraryName: string; override;
  end;



  _TRUSTEE_AWrapper = class(TatRecordWrapper)
  private
    FMultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION;
    FTrusteeForm: TRUSTEE_FORM;
    FTrusteeType: TRUSTEE_TYPE;
  public
    constructor Create(ARecord: _TRUSTEE_A);
    function ObjToRec: _TRUSTEE_A;
  published
    property MultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION read FMultipleTrusteeOperation write FMultipleTrusteeOperation;
    property TrusteeForm: TRUSTEE_FORM read FTrusteeForm write FTrusteeForm;
    property TrusteeType: TRUSTEE_TYPE read FTrusteeType write FTrusteeType;
  end;
  
  _TRUSTEE_WWrapper = class(TatRecordWrapper)
  private
    FMultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION;
    FTrusteeForm: TRUSTEE_FORM;
    FTrusteeType: TRUSTEE_TYPE;
  public
    constructor Create(ARecord: _TRUSTEE_W);
    function ObjToRec: _TRUSTEE_W;
  published
    property MultipleTrusteeOperation: MULTIPLE_TRUSTEE_OPERATION read FMultipleTrusteeOperation write FMultipleTrusteeOperation;
    property TrusteeForm: TRUSTEE_FORM read FTrusteeForm write FTrusteeForm;
    property TrusteeType: TRUSTEE_TYPE read FTrusteeType write FTrusteeType;
  end;
  
  EXPLICIT_ACCESS_AWrapper = class(TatRecordWrapper)
  private
    FgrfAccessPermissions: DWORD;
    FgrfAccessMode: ACCESS_MODE;
    FgrfInheritance: DWORD;
  public
    constructor Create(ARecord: EXPLICIT_ACCESS_A);
    function ObjToRec: EXPLICIT_ACCESS_A;
  published
    property grfAccessPermissions: DWORD read FgrfAccessPermissions write FgrfAccessPermissions;
    property grfAccessMode: ACCESS_MODE read FgrfAccessMode write FgrfAccessMode;
    property grfInheritance: DWORD read FgrfInheritance write FgrfInheritance;
  end;
  
  EXPLICIT_ACCESS_WWrapper = class(TatRecordWrapper)
  private
    FgrfAccessPermissions: DWORD;
    FgrfAccessMode: ACCESS_MODE;
    FgrfInheritance: DWORD;
  public
    constructor Create(ARecord: EXPLICIT_ACCESS_W);
    function ObjToRec: EXPLICIT_ACCESS_W;
  published
    property grfAccessPermissions: DWORD read FgrfAccessPermissions write FgrfAccessPermissions;
    property grfAccessMode: ACCESS_MODE read FgrfAccessMode write FgrfAccessMode;
    property grfInheritance: DWORD read FgrfInheritance write FgrfInheritance;
  end;
  
  ACTRL_ACCESS_ENTRYAWrapper = class(TatRecordWrapper)
  private
    FfAccessFlags: ULONG;
    FAccess: ACCESS_RIGHTS;
    FProvSpecificAccess: ACCESS_RIGHTS;
    FInheritance: INHERIT_FLAGS;
  public
    constructor Create(ARecord: ACTRL_ACCESS_ENTRYA);
    function ObjToRec: ACTRL_ACCESS_ENTRYA;
  published
    property fAccessFlags: ULONG read FfAccessFlags write FfAccessFlags;
    property Access: ACCESS_RIGHTS read FAccess write FAccess;
    property ProvSpecificAccess: ACCESS_RIGHTS read FProvSpecificAccess write FProvSpecificAccess;
    property Inheritance: INHERIT_FLAGS read FInheritance write FInheritance;
  end;
  
  ACTRL_ACCESS_ENTRYWWrapper = class(TatRecordWrapper)
  private
    FfAccessFlags: ULONG;
    FAccess: ACCESS_RIGHTS;
    FProvSpecificAccess: ACCESS_RIGHTS;
    FInheritance: INHERIT_FLAGS;
  public
    constructor Create(ARecord: ACTRL_ACCESS_ENTRYW);
    function ObjToRec: ACTRL_ACCESS_ENTRYW;
  published
    property fAccessFlags: ULONG read FfAccessFlags write FfAccessFlags;
    property Access: ACCESS_RIGHTS read FAccess write FAccess;
    property ProvSpecificAccess: ACCESS_RIGHTS read FProvSpecificAccess write FProvSpecificAccess;
    property Inheritance: INHERIT_FLAGS read FInheritance write FInheritance;
  end;
  
  ACTRL_ACCESS_ENTRY_LISTAWrapper = class(TatRecordWrapper)
  private
    FcEntries: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESS_ENTRY_LISTA);
    function ObjToRec: ACTRL_ACCESS_ENTRY_LISTA;
  published
    property cEntries: ULONG read FcEntries write FcEntries;
  end;
  
  ACTRL_ACCESS_ENTRY_LISTWWrapper = class(TatRecordWrapper)
  private
    FcEntries: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESS_ENTRY_LISTW);
    function ObjToRec: ACTRL_ACCESS_ENTRY_LISTW;
  published
    property cEntries: ULONG read FcEntries write FcEntries;
  end;
  
  ACTRL_PROPERTY_ENTRYAWrapper = class(TatRecordWrapper)
  private
    FfListFlags: ULONG;
  public
    constructor Create(ARecord: ACTRL_PROPERTY_ENTRYA);
    function ObjToRec: ACTRL_PROPERTY_ENTRYA;
  published
    property fListFlags: ULONG read FfListFlags write FfListFlags;
  end;
  
  ACTRL_PROPERTY_ENTRYWWrapper = class(TatRecordWrapper)
  private
    FfListFlags: ULONG;
  public
    constructor Create(ARecord: ACTRL_PROPERTY_ENTRYW);
    function ObjToRec: ACTRL_PROPERTY_ENTRYW;
  published
    property fListFlags: ULONG read FfListFlags write FfListFlags;
  end;
  
  ACTRL_ACCESSAWrapper = class(TatRecordWrapper)
  private
    FcEntries: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESSA);
    function ObjToRec: ACTRL_ACCESSA;
  published
    property cEntries: ULONG read FcEntries write FcEntries;
  end;
  
  ACTRL_ACCESSWWrapper = class(TatRecordWrapper)
  private
    FcEntries: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESSW);
    function ObjToRec: ACTRL_ACCESSW;
  published
    property cEntries: ULONG read FcEntries write FcEntries;
  end;
  
  TRUSTEE_ACCESSAWrapper = class(TatRecordWrapper)
  private
    FAccess: ACCESS_RIGHTS;
    FfAccessFlags: ULONG;
    FfReturnedAccess: ULONG;
  public
    constructor Create(ARecord: TRUSTEE_ACCESSA);
    function ObjToRec: TRUSTEE_ACCESSA;
  published
    property Access: ACCESS_RIGHTS read FAccess write FAccess;
    property fAccessFlags: ULONG read FfAccessFlags write FfAccessFlags;
    property fReturnedAccess: ULONG read FfReturnedAccess write FfReturnedAccess;
  end;
  
  TRUSTEE_ACCESSWWrapper = class(TatRecordWrapper)
  private
    FAccess: ACCESS_RIGHTS;
    FfAccessFlags: ULONG;
    FfReturnedAccess: ULONG;
  public
    constructor Create(ARecord: TRUSTEE_ACCESSW);
    function ObjToRec: TRUSTEE_ACCESSW;
  published
    property Access: ACCESS_RIGHTS read FAccess write FAccess;
    property fAccessFlags: ULONG read FfAccessFlags write FfAccessFlags;
    property fReturnedAccess: ULONG read FfReturnedAccess write FfReturnedAccess;
  end;
  
  ACTRL_OVERLAPPEDWrapper = class(TatRecordWrapper)
  private
    FRsrvd2: ULONG;
    FhEvnt: THandle;
    FReserved1: ULONG;
    FReserved2: ULONG;
    FhEvent: THandle;
  public
    constructor Create(ARecord: ACTRL_OVERLAPPED);
    function ObjToRec: ACTRL_OVERLAPPED;
  published
    property Rsrvd2: ULONG read FRsrvd2 write FRsrvd2;
    property hEvnt: THandle read FhEvnt write FhEvnt;
    property Reserved1: ULONG read FReserved1 write FReserved1;
    property Reserved2: ULONG read FReserved2 write FReserved2;
    property hEvent: THandle read FhEvent write FhEvent;
  end;
  
  ACTRL_ACCESS_INFOAWrapper = class(TatRecordWrapper)
  private
    FfAccessPermission: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESS_INFOA);
    function ObjToRec: ACTRL_ACCESS_INFOA;
  published
    property fAccessPermission: ULONG read FfAccessPermission write FfAccessPermission;
  end;
  
  ACTRL_ACCESS_INFOWWrapper = class(TatRecordWrapper)
  private
    FfAccessPermission: ULONG;
  public
    constructor Create(ARecord: ACTRL_ACCESS_INFOW);
    function ObjToRec: ACTRL_ACCESS_INFOW;
  published
    property fAccessPermission: ULONG read FfAccessPermission write FfAccessPermission;
  end;
  
  ACTRL_CONTROL_INFOAWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: ACTRL_CONTROL_INFOA);
    function ObjToRec: ACTRL_CONTROL_INFOA;
  published
  end;
  
  ACTRL_CONTROL_INFOWWrapper = class(TatRecordWrapper)
  private
  public
    constructor Create(ARecord: ACTRL_CONTROL_INFOW);
    function ObjToRec: ACTRL_CONTROL_INFOW;
  published
  end;
  

implementation

constructor _TRUSTEE_AWrapper.Create(ARecord: _TRUSTEE_A);
begin
  inherited Create;
  FMultipleTrusteeOperation := ARecord.MultipleTrusteeOperation;
  FTrusteeForm := ARecord.TrusteeForm;
  FTrusteeType := ARecord.TrusteeType;
end;

function _TRUSTEE_AWrapper.ObjToRec: _TRUSTEE_A;
begin
  result.MultipleTrusteeOperation := FMultipleTrusteeOperation;
  result.TrusteeForm := FTrusteeForm;
  result.TrusteeType := FTrusteeType;
end;

constructor _TRUSTEE_WWrapper.Create(ARecord: _TRUSTEE_W);
begin
  inherited Create;
  FMultipleTrusteeOperation := ARecord.MultipleTrusteeOperation;
  FTrusteeForm := ARecord.TrusteeForm;
  FTrusteeType := ARecord.TrusteeType;
end;

function _TRUSTEE_WWrapper.ObjToRec: _TRUSTEE_W;
begin
  result.MultipleTrusteeOperation := FMultipleTrusteeOperation;
  result.TrusteeForm := FTrusteeForm;
  result.TrusteeType := FTrusteeType;
end;

constructor EXPLICIT_ACCESS_AWrapper.Create(ARecord: EXPLICIT_ACCESS_A);
begin
  inherited Create;
  FgrfAccessPermissions := ARecord.grfAccessPermissions;
  FgrfAccessMode := ARecord.grfAccessMode;
  FgrfInheritance := ARecord.grfInheritance;
end;

function EXPLICIT_ACCESS_AWrapper.ObjToRec: EXPLICIT_ACCESS_A;
begin
  result.grfAccessPermissions := FgrfAccessPermissions;
  result.grfAccessMode := FgrfAccessMode;
  result.grfInheritance := FgrfInheritance;
end;

constructor EXPLICIT_ACCESS_WWrapper.Create(ARecord: EXPLICIT_ACCESS_W);
begin
  inherited Create;
  FgrfAccessPermissions := ARecord.grfAccessPermissions;
  FgrfAccessMode := ARecord.grfAccessMode;
  FgrfInheritance := ARecord.grfInheritance;
end;

function EXPLICIT_ACCESS_WWrapper.ObjToRec: EXPLICIT_ACCESS_W;
begin
  result.grfAccessPermissions := FgrfAccessPermissions;
  result.grfAccessMode := FgrfAccessMode;
  result.grfInheritance := FgrfInheritance;
end;

constructor ACTRL_ACCESS_ENTRYAWrapper.Create(ARecord: ACTRL_ACCESS_ENTRYA);
begin
  inherited Create;
  FfAccessFlags := ARecord.fAccessFlags;
  FAccess := ARecord.Access;
  FProvSpecificAccess := ARecord.ProvSpecificAccess;
  FInheritance := ARecord.Inheritance;
end;

function ACTRL_ACCESS_ENTRYAWrapper.ObjToRec: ACTRL_ACCESS_ENTRYA;
begin
  result.fAccessFlags := FfAccessFlags;
  result.Access := FAccess;
  result.ProvSpecificAccess := FProvSpecificAccess;
  result.Inheritance := FInheritance;
end;

constructor ACTRL_ACCESS_ENTRYWWrapper.Create(ARecord: ACTRL_ACCESS_ENTRYW);
begin
  inherited Create;
  FfAccessFlags := ARecord.fAccessFlags;
  FAccess := ARecord.Access;
  FProvSpecificAccess := ARecord.ProvSpecificAccess;
  FInheritance := ARecord.Inheritance;
end;

function ACTRL_ACCESS_ENTRYWWrapper.ObjToRec: ACTRL_ACCESS_ENTRYW;
begin
  result.fAccessFlags := FfAccessFlags;
  result.Access := FAccess;
  result.ProvSpecificAccess := FProvSpecificAccess;
  result.Inheritance := FInheritance;
end;

constructor ACTRL_ACCESS_ENTRY_LISTAWrapper.Create(ARecord: ACTRL_ACCESS_ENTRY_LISTA);
begin
  inherited Create;
  FcEntries := ARecord.cEntries;
end;

function ACTRL_ACCESS_ENTRY_LISTAWrapper.ObjToRec: ACTRL_ACCESS_ENTRY_LISTA;
begin
  result.cEntries := FcEntries;
end;

constructor ACTRL_ACCESS_ENTRY_LISTWWrapper.Create(ARecord: ACTRL_ACCESS_ENTRY_LISTW);
begin
  inherited Create;
  FcEntries := ARecord.cEntries;
end;

function ACTRL_ACCESS_ENTRY_LISTWWrapper.ObjToRec: ACTRL_ACCESS_ENTRY_LISTW;
begin
  result.cEntries := FcEntries;
end;

constructor ACTRL_PROPERTY_ENTRYAWrapper.Create(ARecord: ACTRL_PROPERTY_ENTRYA);
begin
  inherited Create;
  FfListFlags := ARecord.fListFlags;
end;

function ACTRL_PROPERTY_ENTRYAWrapper.ObjToRec: ACTRL_PROPERTY_ENTRYA;
begin
  result.fListFlags := FfListFlags;
end;

constructor ACTRL_PROPERTY_ENTRYWWrapper.Create(ARecord: ACTRL_PROPERTY_ENTRYW);
begin
  inherited Create;
  FfListFlags := ARecord.fListFlags;
end;

function ACTRL_PROPERTY_ENTRYWWrapper.ObjToRec: ACTRL_PROPERTY_ENTRYW;
begin
  result.fListFlags := FfListFlags;
end;

constructor ACTRL_ACCESSAWrapper.Create(ARecord: ACTRL_ACCESSA);
begin
  inherited Create;
  FcEntries := ARecord.cEntries;
end;

function ACTRL_ACCESSAWrapper.ObjToRec: ACTRL_ACCESSA;
begin
  result.cEntries := FcEntries;
end;

constructor ACTRL_ACCESSWWrapper.Create(ARecord: ACTRL_ACCESSW);
begin
  inherited Create;
  FcEntries := ARecord.cEntries;
end;

function ACTRL_ACCESSWWrapper.ObjToRec: ACTRL_ACCESSW;
begin
  result.cEntries := FcEntries;
end;

constructor TRUSTEE_ACCESSAWrapper.Create(ARecord: TRUSTEE_ACCESSA);
begin
  inherited Create;
  FAccess := ARecord.Access;
  FfAccessFlags := ARecord.fAccessFlags;
  FfReturnedAccess := ARecord.fReturnedAccess;
end;

function TRUSTEE_ACCESSAWrapper.ObjToRec: TRUSTEE_ACCESSA;
begin
  result.Access := FAccess;
  result.fAccessFlags := FfAccessFlags;
  result.fReturnedAccess := FfReturnedAccess;
end;

constructor TRUSTEE_ACCESSWWrapper.Create(ARecord: TRUSTEE_ACCESSW);
begin
  inherited Create;
  FAccess := ARecord.Access;
  FfAccessFlags := ARecord.fAccessFlags;
  FfReturnedAccess := ARecord.fReturnedAccess;
end;

function TRUSTEE_ACCESSWWrapper.ObjToRec: TRUSTEE_ACCESSW;
begin
  result.Access := FAccess;
  result.fAccessFlags := FfAccessFlags;
  result.fReturnedAccess := FfReturnedAccess;
end;

constructor ACTRL_OVERLAPPEDWrapper.Create(ARecord: ACTRL_OVERLAPPED);
begin
  inherited Create;
  FRsrvd2 := ARecord.Rsrvd2;
  FhEvnt := ARecord.hEvnt;
  FReserved1 := ARecord.Reserved1;
  FReserved2 := ARecord.Reserved2;
  FhEvent := ARecord.hEvent;
end;

function ACTRL_OVERLAPPEDWrapper.ObjToRec: ACTRL_OVERLAPPED;
begin
  result.Rsrvd2 := FRsrvd2;
  result.hEvnt := FhEvnt;
  result.Reserved1 := FReserved1;
  result.Reserved2 := FReserved2;
  result.hEvent := FhEvent;
end;

constructor ACTRL_ACCESS_INFOAWrapper.Create(ARecord: ACTRL_ACCESS_INFOA);
begin
  inherited Create;
  FfAccessPermission := ARecord.fAccessPermission;
end;

function ACTRL_ACCESS_INFOAWrapper.ObjToRec: ACTRL_ACCESS_INFOA;
begin
  result.fAccessPermission := FfAccessPermission;
end;

constructor ACTRL_ACCESS_INFOWWrapper.Create(ARecord: ACTRL_ACCESS_INFOW);
begin
  inherited Create;
  FfAccessPermission := ARecord.fAccessPermission;
end;

function ACTRL_ACCESS_INFOWWrapper.ObjToRec: ACTRL_ACCESS_INFOW;
begin
  result.fAccessPermission := FfAccessPermission;
end;

constructor ACTRL_CONTROL_INFOAWrapper.Create(ARecord: ACTRL_CONTROL_INFOA);
begin
  inherited Create;
end;

function ACTRL_CONTROL_INFOAWrapper.ObjToRec: ACTRL_CONTROL_INFOA;
begin
end;

constructor ACTRL_CONTROL_INFOWWrapper.Create(ARecord: ACTRL_CONTROL_INFOW);
begin
  inherited Create;
end;

function ACTRL_CONTROL_INFOWWrapper.ObjToRec: ACTRL_CONTROL_INFOW;
begin
end;



procedure TatAccCtrlLibrary.Init;
begin
  With Scripter.DefineClass(ClassType) do
  begin
    AddConstant('TRUSTEE_IS_UNKNOWN',TRUSTEE_IS_UNKNOWN);
    AddConstant('TRUSTEE_IS_USER',TRUSTEE_IS_USER);
    AddConstant('TRUSTEE_IS_GROUP',TRUSTEE_IS_GROUP);
    AddConstant('TRUSTEE_IS_DOMAIN',TRUSTEE_IS_DOMAIN);
    AddConstant('TRUSTEE_IS_ALIAS',TRUSTEE_IS_ALIAS);
    AddConstant('TRUSTEE_IS_WELL_KNOWN_GROUP',TRUSTEE_IS_WELL_KNOWN_GROUP);
    AddConstant('TRUSTEE_IS_DELETED',TRUSTEE_IS_DELETED);
    AddConstant('TRUSTEE_IS_INVALID',TRUSTEE_IS_INVALID);
    AddConstant('TRUSTEE_IS_SID',TRUSTEE_IS_SID);
    AddConstant('TRUSTEE_IS_NAME',TRUSTEE_IS_NAME);
    AddConstant('TRUSTEE_BAD_FORM',TRUSTEE_BAD_FORM);
    AddConstant('NO_MULTIPLE_TRUSTEE',NO_MULTIPLE_TRUSTEE);
    AddConstant('TRUSTEE_IS_IMPERSONATE',TRUSTEE_IS_IMPERSONATE);
    AddConstant('NOT_USED_ACCESS',NOT_USED_ACCESS);
    AddConstant('GRANT_ACCESS',GRANT_ACCESS);
    AddConstant('SET_ACCESS',SET_ACCESS);
    AddConstant('DENY_ACCESS',DENY_ACCESS);
    AddConstant('REVOKE_ACCESS',REVOKE_ACCESS);
    AddConstant('SET_AUDIT_SUCCESS',SET_AUDIT_SUCCESS);
    AddConstant('SET_AUDIT_FAILURE',SET_AUDIT_FAILURE);
    AddConstant('SE_UNKNOWN_OBJECT_TYPE',SE_UNKNOWN_OBJECT_TYPE);
    AddConstant('SE_FILE_OBJECT',SE_FILE_OBJECT);
    AddConstant('SE_SERVICE',SE_SERVICE);
    AddConstant('SE_PRINTER',SE_PRINTER);
    AddConstant('SE_REGISTRY_KEY',SE_REGISTRY_KEY);
    AddConstant('SE_LMSHARE',SE_LMSHARE);
    AddConstant('SE_KERNEL_OBJECT',SE_KERNEL_OBJECT);
    AddConstant('SE_WINDOW_OBJECT',SE_WINDOW_OBJECT);
    AddConstant('SE_DS_OBJECT',SE_DS_OBJECT);
    AddConstant('SE_DS_OBJECT_ALL',SE_DS_OBJECT_ALL);
    AddConstant('SE_PROVIDER_DEFINED_OBJECT',SE_PROVIDER_DEFINED_OBJECT);
    AddConstant('SE_WMIGUID_OBJECT',SE_WMIGUID_OBJECT);
    AddConstant('NO_INHERITANCE',NO_INHERITANCE);
    AddConstant('SUB_OBJECTS_ONLY_INHERIT',SUB_OBJECTS_ONLY_INHERIT);
    AddConstant('SUB_CONTAINERS_ONLY_INHERIT',SUB_CONTAINERS_ONLY_INHERIT);
    AddConstant('SUB_CONTAINERS_AND_OBJECTS_INHERIT',SUB_CONTAINERS_AND_OBJECTS_INHERIT);
    AddConstant('INHERIT_NO_PROPAGATE',INHERIT_NO_PROPAGATE);
    AddConstant('INHERIT_ONLY',INHERIT_ONLY);
    AddConstant('INHERITED_ACCESS_ENTRY',INHERITED_ACCESS_ENTRY);
    AddConstant('INHERITED_PARENT',INHERITED_PARENT);
    AddConstant('INHERITED_GRANDPARENT',INHERITED_GRANDPARENT);
    AddConstant('ACCCTRL_DEFAULT_PROVIDERA',ACCCTRL_DEFAULT_PROVIDERA);
    AddConstant('ACCCTRL_DEFAULT_PROVIDERW',ACCCTRL_DEFAULT_PROVIDERW);
    AddConstant('ACCCTRL_DEFAULT_PROVIDER',ACCCTRL_DEFAULT_PROVIDER);
    AddConstant('TRUSTEE_ACCESS_ALLOWED',TRUSTEE_ACCESS_ALLOWED);
    AddConstant('TRUSTEE_ACCESS_READ',TRUSTEE_ACCESS_READ);
    AddConstant('TRUSTEE_ACCESS_WRITE',TRUSTEE_ACCESS_WRITE);
    AddConstant('TRUSTEE_ACCESS_EXPLICIT',TRUSTEE_ACCESS_EXPLICIT);
    AddConstant('TRUSTEE_ACCESS_READ_WRITE',TRUSTEE_ACCESS_READ_WRITE);
    AddConstant('TRUSTEE_ACCESS_ALL',TRUSTEE_ACCESS_ALL);
    AddConstant('ACTRL_RESERVED',ACTRL_RESERVED);
    AddConstant('ACTRL_PERM_1',ACTRL_PERM_1);
    AddConstant('ACTRL_PERM_2',ACTRL_PERM_2);
    AddConstant('ACTRL_PERM_3',ACTRL_PERM_3);
    AddConstant('ACTRL_PERM_4',ACTRL_PERM_4);
    AddConstant('ACTRL_PERM_5',ACTRL_PERM_5);
    AddConstant('ACTRL_PERM_6',ACTRL_PERM_6);
    AddConstant('ACTRL_PERM_7',ACTRL_PERM_7);
    AddConstant('ACTRL_PERM_8',ACTRL_PERM_8);
    AddConstant('ACTRL_PERM_9',ACTRL_PERM_9);
    AddConstant('ACTRL_PERM_10',ACTRL_PERM_10);
    AddConstant('ACTRL_PERM_11',ACTRL_PERM_11);
    AddConstant('ACTRL_PERM_12',ACTRL_PERM_12);
    AddConstant('ACTRL_PERM_13',ACTRL_PERM_13);
    AddConstant('ACTRL_PERM_14',ACTRL_PERM_14);
    AddConstant('ACTRL_PERM_15',ACTRL_PERM_15);
    AddConstant('ACTRL_PERM_16',ACTRL_PERM_16);
    AddConstant('ACTRL_PERM_17',ACTRL_PERM_17);
    AddConstant('ACTRL_PERM_18',ACTRL_PERM_18);
    AddConstant('ACTRL_PERM_19',ACTRL_PERM_19);
    AddConstant('ACTRL_PERM_20',ACTRL_PERM_20);
    AddConstant('ACTRL_ACCESS_ALLOWED',ACTRL_ACCESS_ALLOWED);
    AddConstant('ACTRL_ACCESS_DENIED',ACTRL_ACCESS_DENIED);
    AddConstant('ACTRL_AUDIT_SUCCESS',ACTRL_AUDIT_SUCCESS);
    AddConstant('ACTRL_AUDIT_FAILURE',ACTRL_AUDIT_FAILURE);
    AddConstant('ACTRL_ACCESS_PROTECTED',ACTRL_ACCESS_PROTECTED);
    AddConstant('ACTRL_SYSTEM_ACCESS',ACTRL_SYSTEM_ACCESS);
    AddConstant('ACTRL_DELETE',ACTRL_DELETE);
    AddConstant('ACTRL_READ_CONTROL',ACTRL_READ_CONTROL);
    AddConstant('ACTRL_CHANGE_ACCESS',ACTRL_CHANGE_ACCESS);
    AddConstant('ACTRL_CHANGE_OWNER',ACTRL_CHANGE_OWNER);
    AddConstant('ACTRL_SYNCHRONIZE',ACTRL_SYNCHRONIZE);
    AddConstant('ACTRL_STD_RIGHTS_ALL',ACTRL_STD_RIGHTS_ALL);
    AddConstant('ACTRL_STD_RIGHT_REQUIRED',ACTRL_STD_RIGHT_REQUIRED);
    AddConstant('ACTRL_DS_OPEN',ACTRL_DS_OPEN);
    AddConstant('ACTRL_DS_CREATE_CHILD',ACTRL_DS_CREATE_CHILD);
    AddConstant('ACTRL_DS_DELETE_CHILD',ACTRL_DS_DELETE_CHILD);
    AddConstant('ACTRL_DS_LIST',ACTRL_DS_LIST);
    AddConstant('ACTRL_DS_SELF',ACTRL_DS_SELF);
    AddConstant('ACTRL_DS_READ_PROP',ACTRL_DS_READ_PROP);
    AddConstant('ACTRL_DS_WRITE_PROP',ACTRL_DS_WRITE_PROP);
    AddConstant('ACTRL_DS_DELETE_TREE',ACTRL_DS_DELETE_TREE);
    AddConstant('ACTRL_DS_LIST_OBJECT',ACTRL_DS_LIST_OBJECT);
    AddConstant('ACTRL_DS_CONTROL_ACCESS',ACTRL_DS_CONTROL_ACCESS);
    AddConstant('ACTRL_FILE_READ',ACTRL_FILE_READ);
    AddConstant('ACTRL_FILE_WRITE',ACTRL_FILE_WRITE);
    AddConstant('ACTRL_FILE_APPEND',ACTRL_FILE_APPEND);
    AddConstant('ACTRL_FILE_READ_PROP',ACTRL_FILE_READ_PROP);
    AddConstant('ACTRL_FILE_WRITE_PROP',ACTRL_FILE_WRITE_PROP);
    AddConstant('ACTRL_FILE_EXECUTE',ACTRL_FILE_EXECUTE);
    AddConstant('ACTRL_FILE_READ_ATTRIB',ACTRL_FILE_READ_ATTRIB);
    AddConstant('ACTRL_FILE_WRITE_ATTRIB',ACTRL_FILE_WRITE_ATTRIB);
    AddConstant('ACTRL_FILE_CREATE_PIPE',ACTRL_FILE_CREATE_PIPE);
    AddConstant('ACTRL_DIR_LIST',ACTRL_DIR_LIST);
    AddConstant('ACTRL_DIR_CREATE_OBJECT',ACTRL_DIR_CREATE_OBJECT);
    AddConstant('ACTRL_DIR_CREATE_CHILD',ACTRL_DIR_CREATE_CHILD);
    AddConstant('ACTRL_DIR_DELETE_CHILD',ACTRL_DIR_DELETE_CHILD);
    AddConstant('ACTRL_DIR_TRAVERSE',ACTRL_DIR_TRAVERSE);
    AddConstant('ACTRL_KERNEL_TERMINATE',ACTRL_KERNEL_TERMINATE);
    AddConstant('ACTRL_KERNEL_THREAD',ACTRL_KERNEL_THREAD);
    AddConstant('ACTRL_KERNEL_VM',ACTRL_KERNEL_VM);
    AddConstant('ACTRL_KERNEL_VM_READ',ACTRL_KERNEL_VM_READ);
    AddConstant('ACTRL_KERNEL_VM_WRITE',ACTRL_KERNEL_VM_WRITE);
    AddConstant('ACTRL_KERNEL_DUP_HANDLE',ACTRL_KERNEL_DUP_HANDLE);
    AddConstant('ACTRL_KERNEL_PROCESS',ACTRL_KERNEL_PROCESS);
    AddConstant('ACTRL_KERNEL_SET_INFO',ACTRL_KERNEL_SET_INFO);
    AddConstant('ACTRL_KERNEL_GET_INFO',ACTRL_KERNEL_GET_INFO);
    AddConstant('ACTRL_KERNEL_CONTROL',ACTRL_KERNEL_CONTROL);
    AddConstant('ACTRL_KERNEL_ALERT',ACTRL_KERNEL_ALERT);
    AddConstant('ACTRL_KERNEL_GET_CONTEXT',ACTRL_KERNEL_GET_CONTEXT);
    AddConstant('ACTRL_KERNEL_SET_CONTEXT',ACTRL_KERNEL_SET_CONTEXT);
    AddConstant('ACTRL_KERNEL_TOKEN',ACTRL_KERNEL_TOKEN);
    AddConstant('ACTRL_KERNEL_IMPERSONATE',ACTRL_KERNEL_IMPERSONATE);
    AddConstant('ACTRL_KERNEL_DIMPERSONATE',ACTRL_KERNEL_DIMPERSONATE);
    AddConstant('ACTRL_PRINT_SADMIN',ACTRL_PRINT_SADMIN);
    AddConstant('ACTRL_PRINT_SLIST',ACTRL_PRINT_SLIST);
    AddConstant('ACTRL_PRINT_PADMIN',ACTRL_PRINT_PADMIN);
    AddConstant('ACTRL_PRINT_PUSE',ACTRL_PRINT_PUSE);
    AddConstant('ACTRL_PRINT_JADMIN',ACTRL_PRINT_JADMIN);
    AddConstant('ACTRL_SVC_GET_INFO',ACTRL_SVC_GET_INFO);
    AddConstant('ACTRL_SVC_SET_INFO',ACTRL_SVC_SET_INFO);
    AddConstant('ACTRL_SVC_STATUS',ACTRL_SVC_STATUS);
    AddConstant('ACTRL_SVC_LIST',ACTRL_SVC_LIST);
    AddConstant('ACTRL_SVC_START',ACTRL_SVC_START);
    AddConstant('ACTRL_SVC_STOP',ACTRL_SVC_STOP);
    AddConstant('ACTRL_SVC_PAUSE',ACTRL_SVC_PAUSE);
    AddConstant('ACTRL_SVC_INTERROGATE',ACTRL_SVC_INTERROGATE);
    AddConstant('ACTRL_SVC_UCONTROL',ACTRL_SVC_UCONTROL);
    AddConstant('ACTRL_REG_QUERY',ACTRL_REG_QUERY);
    AddConstant('ACTRL_REG_SET',ACTRL_REG_SET);
    AddConstant('ACTRL_REG_CREATE_CHILD',ACTRL_REG_CREATE_CHILD);
    AddConstant('ACTRL_REG_LIST',ACTRL_REG_LIST);
    AddConstant('ACTRL_REG_NOTIFY',ACTRL_REG_NOTIFY);
    AddConstant('ACTRL_REG_LINK',ACTRL_REG_LINK);
    AddConstant('ACTRL_WIN_CLIPBRD',ACTRL_WIN_CLIPBRD);
    AddConstant('ACTRL_WIN_GLOBAL_ATOMS',ACTRL_WIN_GLOBAL_ATOMS);
    AddConstant('ACTRL_WIN_CREATE',ACTRL_WIN_CREATE);
    AddConstant('ACTRL_WIN_LIST_DESK',ACTRL_WIN_LIST_DESK);
    AddConstant('ACTRL_WIN_LIST',ACTRL_WIN_LIST);
    AddConstant('ACTRL_WIN_READ_ATTRIBS',ACTRL_WIN_READ_ATTRIBS);
    AddConstant('ACTRL_WIN_WRITE_ATTRIBS',ACTRL_WIN_WRITE_ATTRIBS);
    AddConstant('ACTRL_WIN_SCREEN',ACTRL_WIN_SCREEN);
    AddConstant('ACTRL_WIN_EXIT',ACTRL_WIN_EXIT);
    AddConstant('ACTRL_ACCESS_NO_OPTIONS',ACTRL_ACCESS_NO_OPTIONS);
    AddConstant('ACTRL_ACCESS_SUPPORTS_OBJECT_ENTRIES',ACTRL_ACCESS_SUPPORTS_OBJECT_ENTRIES);
  end;
end;

class function TatAccCtrlLibrary.LibraryName: string;
begin
  result := 'AccCtrl';
end;

initialization
  RegisterScripterLibrary(TatAccCtrlLibrary, True);

{$WARNINGS ON}

end.

