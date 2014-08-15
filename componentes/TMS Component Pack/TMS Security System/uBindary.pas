{***********************************************************************}
{ TMS Security System                                                   }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uBindary;

interface

{$I TMSDEFS.INC}

uses
  DB,
  Classes, Forms, Windows, Dialogs
{$IFDEF DELPHI6_LVL}
  , Variants
{$ENDIF}
  ;

type
  TuilEncryptEvent = procedure(Sender: TObject; PlainText: string; var EncryptedText: string) of object;

  TuilBindary = class(TPersistent)
  private
    FDataSource: TDataSource;
    FKeyField: string;
    FPassword: string;
    FSecurityManager: TComponent;
    FOnEncrypt: TuilEncryptEvent;
  protected
    procedure SetDataSource(newValue: TDataSource);
    property SecurityManager: TComponent read FSecurityManager write FSecurityManager;
  public
    constructor Create(ASecurityManager: TComponent); virtual;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); virtual;
    function FieldByName(FieldName: string): TField; virtual;
    function Locate(const KeyValues: Variant): boolean; virtual;
    function Encrypt(const S: string): string; virtual;
    property KeyField: string read FKeyField write FKeyField;
  published
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property Password: string read FPassword write FPassword;
    property OnEncrypt: TuilEncryptEvent read FOnEncrypt write FOnEncrypt;
  end;

  TuilAccessBindary = class(TuilBindary)
  protected
    function GetPermissionField: string;
    procedure SetPermissionField(newValue: string);
  public
    constructor Create(ASecurityManager: TComponent); override;
    function HasAccess(Permission: string): boolean; virtual;
    function AddAccess(Permission: string): boolean; virtual;
    function RemoveAccess(Permission: string): boolean; virtual;
  published
    property PermissionField: string read GetPermissionField write SetPermissionField;
  end;

  TuilPermissionStorage = (psForm, psTable);

  TuilPermissionBindary = class(TuilAccessBindary)
  private
    FItemField: string;
    FActionField: string;
    FStorage: TuilPermissionStorage;
    FFormName: string;
    FFormNameField: string;
  public
    function HasAccess(Permission: string): boolean; override;
    function AddPermission(Permission, Items, FormName: string; Action: Integer): Boolean; virtual;
    function UpdatePermission(Permission, Items, FormName: string; Action: Integer): Boolean; virtual;
    property FormName: string read FFormName write FFormName;
  published
    property ActionField: string read FActionField write FActionField;
    property ItemField: string read FItemField write FItemField;
    property FormNameField: string read FFormNameField write FFormNameField;
    property Storage: TuilPermissionStorage read FStorage write FStorage;
  end;

  TuilUserAccessBindary = class(TuilAccessBindary)
  private
    FUserNameField: string;
  public
    constructor Create(ASecurityManager: TComponent); override;
    function AddAccess(Permission: string): boolean; override;

    function AddUserAccess(UserName, Permission: string): boolean; virtual;
    function RemoveUserAccess(UserName, Permission: string): boolean; virtual;
    function HasUserAccess(UserName, Permission: string): boolean; virtual;

  published
    property UserNameField: string read FUserNameField write FUserNameField;
  end;

  TuilGroupAccessBindary = class(TuilAccessBindary)
  private
    FGroupNameField: string;
  public
    constructor Create(ASecurityManager: TComponent); override;
    function AddAccess(Permission: string): boolean; override;

    function AddGroupAccess(Group, Permission: string): boolean; virtual;
    function RemoveGroupAccess(Group, Permission: string): boolean; virtual;
    function HasGroupAccess(Group, Permission: string): boolean; virtual;
  published
    property GroupNameField: string read FGroupNameField write FGroupNameField;
  end;

  TuilGroupMembershipBindary = class(TuilBindary)
  private
    FUserNameField: string;
  protected
    function GetGroupNameField: string;
    procedure SetGroupNameField(newValue: string);
  public
    constructor Create(ASecurityManager: TComponent); override;
    function Locate(const KeyValues: Variant): boolean; override;
    function AddUserToGroup(Username, GroupName: string): boolean; virtual;
    function RemoveUserFromGroup(Username, GroupName: string): boolean; virtual;
  published
    property GroupNameField: string read GetGroupNameField write SetGroupNameField;
    property UserNameField: string read FUserNameField write FUserNameField;
  end;

  TuilUserBindary = class(TuilBindary)
  private
    FCaseSensUsername,
    FCaseSensPassword: boolean;
    FFullNameField, // char
    FPasswordField, // char
    FAccessCountField, // integer
    FCreatedDateField, // date
    FCreatedTimeField, // time
    FEnabledField, // boolean
    FLastAccessField, // date
    FLastAccessTimeField: string; // time
    FUserPermissions: TuilUserAccessBindary;
  protected
    function GetUserNameField: string;
    procedure SetUserNameField(newValue: string);
  public
    procedure AddUser; virtual;
    procedure UpdateLogin; virtual;
    constructor Create(ASecurityManager: TComponent); override;
    destructor Destroy; override;
    procedure ChangePassword(NewPassword: string);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function Locate(const KeyValues: Variant): boolean; override;
  published
    property CaseSensitiveUsername: boolean read FCaseSensUsername write FCaseSensUsername default false;
    property CaseSensitivePassword: boolean read FCaseSensPassword write FCaseSensPassword default true;
    property UserNameField: string read GetUserNameField write SetUserNameField;
    property FullNameField: string read FFullNameField write FFullNameField;
    property PasswordField: string read FPasswordField write FPasswordField;
    property AccessCountField: string read FAccessCountField write FAccessCountField;
    property CreatedDateField: string read FCreatedDateField write FCreatedDateField;
    property CreatedTimeField: string read FCreatedTimeField write FCreatedTimeField;
    property EnabledField: string read FEnabledField write FEnabledField;
    property LastAccessField: string read FLastAccessField write FLastAccessField;
    property LastAccessTimeField: string read FLastAccessTimeField write FLastAccessTimeField;
    property UserPermissions: TuilUserAccessBindary read FUserPermissions write FUserPermissions;
  end;

  TuilGroupBindary = class(TuilBindary)
  private
    FGroupDescriptionField: string; // char
    FGroupPermissions: TuilGroupAccessBindary;
    FGroupMemBindary: TuilGroupMembershipBindary;
  protected
    function GetGroupNameField: string;
    procedure SetGroupNameField(newValue: string);
  public
    constructor Create(ASecurityManager: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  published
    property GroupNameField: string read GetGroupNameField write SetGroupNameField;
    property GroupDescriptionField: string read FGroupDescriptionField write FGroupDescriptionField;
    property GroupPermissions: TuilGroupAccessBindary read FGroupPermissions write FGroupPermissions;
    property GroupMembershipBindary: TuilGroupMembershipBindary read FGroupMemBindary write FGroupMemBindary;
  end;

implementation

uses
  SysUtils, uSecControl;

{ TuilBindary }

constructor TuilBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create;
  FSecurityManager := ASecurityManager;
end;

destructor TuilBindary.Destroy;
begin
  FSecurityManager := nil;
  inherited Destroy;
end;

function TuilBindary.FieldByName(FieldName: string): TField;
begin
  Result := nil;
  if DataSource = nil then Exit;
  Result := FDataSource.DataSet.FieldByName(FieldName);
end;

function TuilBindary.Locate(const KeyValues: Variant): boolean;
begin
  Result := False;
  if DataSource = nil then Exit;
  try
    Result := FDataSource.DataSet.Locate(FKeyField, KeyValues, [loCaseInsensitive]);
  except
    on EDatabaseError do Result := false;
  end
end;

procedure TuilBindary.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FDataSource) then
    FDataSource := nil;
end;

procedure TuilBindary.SetDataSource(newValue: TDataSource);
begin
  if (FDataSource <> newValue) then
  begin
    FDataSource := newValue;
    if newValue <> nil then
      newValue.FreeNotification(newValue);
  end;
end;

function TuilBindary.Encrypt(const S: string): string;
var
  j: Integer;
begin
  Result := S;

   // If we have an event handler for the encryption, use it
  if (assigned(FOnEncrypt)) then
  begin
    FOnEncrypt(Self, S, Result);
    Exit;
  end;

   // otherwize, use the internal encryption (but only if there
   // is no password!)
  if FPassword = '' then Exit;
  for j := 1 to Length(S) do
  begin
    Result[j] := char(byte(S[j]) xor (Ord(FPassword[j mod length(FPassword)]) shr 4));
  end;
end;

{ TuilUserBindary }

procedure TuilUserBindary.ChangePassword(NewPassword: string);
begin
  if Locate((SecurityManager as TuilSecurityManager).CurrentUser) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.FieldByName(FPasswordField).AsString := Encrypt(NewPassword);
    DataSource.DataSet.Post;
  end;
end;

constructor TuilUserBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  FUserPermissions := TuilUserAccessBindary.Create(ASecurityManager);

  FCaseSensUsername := false;
  FCaseSensPassword := true;

  UserNameField := 'UserName';
  FFullNameField := 'FullName';
  FPasswordField := 'Password';
  FAccessCountField := 'AccessCount';
  FCreatedDateField := 'CreatedDate';
  FEnabledField := 'Enabled';
  FLastAccessField := 'LastAccess';
  FCreatedTimeField := 'CreatedTime';
  FLastAccessTimeField := 'LastAccTime';
end;

destructor TuilUserBindary.Destroy;
begin
  FUserPermissions.Free;
  FUserPermissions := nil;
  inherited Destroy;
end;

function TuilUserBindary.GetUserNameField: string;
begin
  result := KeyField;
end;

procedure TuilUserBindary.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Assigned(FUserPermissions) then
    FUserPermissions.Notification(AComponent, Operation);
end;

procedure TuilUserBindary.SetUserNameField(newValue: string);
begin
  KeyField := newValue;
end;

function TuilUserBindary.Locate(const KeyValues: Variant): boolean;
begin
  Result := False;
  if DataSource = nil then Exit;
  try
    if FCaseSensUsername then
      Result := DataSource.DataSet.Locate(FKeyField, KeyValues, [])
    else
      Result := DataSource.DataSet.Locate(FKeyField, KeyValues, [loCaseInsensitive])
  except
    on EDatabaseError do Result := false;
  end
end;

// Does not currently do anything in this release.

procedure TuilUserBindary.AddUser;
begin
  if not Assigned(DataSource) then Exit;
  if not Assigned(DataSource.DataSet) then Exit;
end;

procedure TuilUserBindary.UpdateLogin;
begin
  if not Assigned(DataSource) then Exit;
  if not Assigned(DataSource.DataSet) then Exit;

  try
    DataSource.DataSet.Edit;
    if Trim(FLastAccessField) <> '' then
    begin
      if Assigned(DataSource.DataSet.FieldByName(FLastAccessField)) then
        DataSource.DataSet.FieldByName(FLastAccessField).AsDateTime := Date;
    end;

    if Trim(FLastAccessTimeField) <> '' then
    begin
      if  Assigned(DataSource.DataSet.FieldByName(FLastAccessTimeField)) then
        DataSource.DataSet.FieldByName(FLastAccessTimeField).AsDateTime := Time;
    end;
    
    if Trim(FAccessCountField) <> '' then
    begin
      if Assigned(DataSource.DataSet.FieldByName(FAccessCountField)) then
        DataSource.DataSet.FieldByName(FAccessCountField).AsInteger :=
          DataSource.DataSet.FieldByName(FAccessCountField).AsInteger + 1;
    end;      
    DataSource.DataSet.Post;
  except
    DataSource.DataSet.Cancel;
  end;
end;


{ TuilGroupBindary }

constructor TuilGroupBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  FGroupPermissions := TuilGroupAccessBindary.Create(ASecurityManager);
  FGroupMemBindary := TuilGroupMembershipBindary.Create(ASecurityManager);

  GroupNameField := 'GroupName';
  FGroupDescriptionField := 'Description';
end;

destructor TuilGroupBindary.Destroy;
begin
  FGroupPermissions.Free;
  FGroupPermissions := nil;
  FGroupMemBindary.Free;
  FGroupMemBindary := nil;
  inherited Destroy;
end;

function TuilGroupBindary.GetGroupNameField: string;
begin
  result := KeyField;
end;

procedure TuilGroupBindary.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if assigned(FGroupPermissions) then
    FGroupPermissions.Notification(AComponent, Operation);

  if assigned(FGroupMemBindary) then
    FGroupMemBindary.Notification(AComponent, Operation);
end;

procedure TuilGroupBindary.SetGroupNameField(newValue: string);
begin
  KeyField := newValue;
end;

{ TuilAccessBindary }

constructor TuilAccessBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  PermissionField := 'Permission';
end;

function TuilAccessBindary.GetPermissionField: string;
begin
  result := KeyField;
end;

procedure TuilAccessBindary.SetPermissionField(newValue: string);
begin
  KeyField := newValue;
end;

function TuilAccessBindary.AddAccess(Permission: string): Boolean;
begin
  Result := false;
  if not HasAccess(Permission) then
  begin
    DataSource.DataSet.Append;
    DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
    DataSource.DataSet.Post;
    Result := true;
  end;
end;

function TuilAccessBindary.HasAccess(Permission: string): boolean;
begin
  Result := Locate(Permission);
end;

function TuilAccessBindary.RemoveAccess(Permission: string): boolean;
begin
  Result := false;
  if HasAccess(Permission) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.Delete;
    Result := true;
  end;
end;

{ TuilUserAccessBindary }

constructor TuilUserAccessBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  FUserNameField := 'UserName';
end;

function TuilUserAccessBindary.AddAccess(Permission: string): boolean;
begin
  Result := false;
  if not HasAccess(Permission) then
    with (SecurityManager as TuilSecurityManager) do
    begin
      DataSource.DataSet.Append;
      DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
      DataSource.DataSet.FieldByName(FUserNameField).AsString := UserBindary.DataSource.DataSet.FieldByName(UserBindary.UserNameField).AsString;
      DataSource.DataSet.Post;
      Result := true;
    end; // with
end;


function TuilUserAccessBindary.AddUserAccess(UserName,
  Permission: string): boolean;
begin
  Result := false;
  if not HasUserAccess(UserName, Permission) then
    with (SecurityManager as TuilSecurityManager) do
    begin
      DataSource.DataSet.Append;
      DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
      DataSource.DataSet.FieldByName(FUserNameField).AsString := UserName;
      DataSource.DataSet.Post;
      Result := true;
    end; // with
end;

function TuilUserAccessBindary.HasUserAccess(UserName,
  Permission: string): boolean;
begin
  Result := False;
  if DataSource = nil then Exit;
  try
    Result := FDataSource.DataSet.Locate(FKeyField+';'+UserNameField, VarArrayOf([Permission,UserName]), [loCaseInsensitive]);
  except
    on EDatabaseError do Result := false;
  end
end;

function TuilUserAccessBindary.RemoveUserAccess(UserName,
  Permission: string): boolean;
begin
  Result := false;
  if HasUserAccess(UserName,Permission) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.Delete;
    Result := true;
  end;
end;

{ TuilGroupAccessBindary }

constructor TuilGroupAccessBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  FGroupNameField := 'UserName';
end;

function TuilGroupAccessBindary.AddAccess(Permission: string): boolean;
begin
  Result := false;
  if not HasAccess(Permission) then
    with (SecurityManager as TuilSecurityManager) do
    begin
      DataSource.DataSet.Append;
      DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
      DataSource.DataSet.FieldByName(FGroupNameField).AsString := GroupBindary.DataSource.DataSet.FieldByName(GroupBindary.GroupNameField).AsString;
      DataSource.DataSet.Post;
      Result := true;
    end; // with
end;


function TuilGroupAccessBindary.AddGroupAccess(Group,
  Permission: string): boolean;
begin
  Result := false;
  if not HasGroupAccess(Group, Permission) then
    with (SecurityManager as TuilSecurityManager) do
    begin
      DataSource.DataSet.Append;
      DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
      DataSource.DataSet.FieldByName(GroupNameField).AsString := Group;
      DataSource.DataSet.Post;
      Result := true;
    end; // with
end;

function TuilGroupAccessBindary.HasGroupAccess(Group,
  Permission: string): boolean;
begin
  Result := False;
  if DataSource = nil then Exit;
  try
    Result := FDataSource.DataSet.Locate(FKeyField+';'+GroupNameField, VarArrayOf([Permission,Group]), [loCaseInsensitive]);
  except
    on EDatabaseError do Result := false;
  end
end;

function TuilGroupAccessBindary.RemoveGroupAccess(Group,
  Permission: string): boolean;
begin
  Result := false;
  if HasGroupAccess(Group,Permission) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.Delete;
    Result := true;
  end;
end;

{ TuilGroupMembershipBindary }

constructor TuilGroupMembershipBindary.Create(ASecurityManager: TComponent);
begin
  inherited Create(ASecurityManager);
  FUserNameField := 'UserName';
  GroupNameField := 'GroupName';
end;

function TuilGroupMembershipBindary.GetGroupNameField: string;
begin
  Result := KeyField;
end;

procedure TuilGroupMembershipBindary.SetGroupNameField(newValue: string);
begin
  KeyField := newValue;
end;

function TuilGroupMembershipBindary.Locate(const KeyValues: Variant): boolean;
begin
  Result := False;
  if DataSource = nil then Exit;
  Result := FDataSource.DataSet.Locate(FUserNameField + ';' + FKeyField, KeyValues, [loCaseInsensitive]);
end;

function TuilGroupMembershipBindary.AddUserToGroup(Username, GroupName: string): boolean;
begin
  Result := false;
  if Locate(VarArrayOf([Username, GroupName])) then Exit;

  DataSource.DataSet.Append;
  FieldByName(FUserNameField).AsString := UserName;
  FieldByName(KeyField).AsString := GroupName;
  DataSource.DataSet.Post;
  Result := true;
end;

function TuilGroupMembershipBindary.RemoveUserFromGroup(Username, GroupName: string): boolean;
begin
  Result := false;
  if Locate(VarArrayOf([Username, GroupName])) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.Delete;
    Result := true;
  end;
end;


{ TuilPermissionBindary }

function TuilPermissionBindary.AddPermission(Permission, Items, FormName: string;
  Action: Integer): Boolean;
begin
  self.FormName := FormName;
  if not HasAccess(Permission) then
    DataSource.DataSet.Append
  else
    DataSource.DataSet.Edit;

  DataSource.DataSet.FieldByName(KeyField).AsString := Permission;
  if ItemField <> '' then
    DataSource.DataSet.FieldByName(ItemField).AsString := Items;
  if ActionField <> '' then
    DataSource.DataSet.FieldByName(ActionField).AsInteger := Action;
  if FormNameField <> '' then
    DataSource.DataSet.FieldByName(FormNameField).AsString := FormName;

  DataSource.DataSet.Post;
  Result := true;
end;

function TuilPermissionBindary.HasAccess(Permission: string): boolean;
begin
  if Storage = psForm then
    Result := Locate(Permission)
  else
  begin
    Result := DataSource.DataSet.Locate(PermissionField+';'+FormNameField,
      VarArrayOf([Permission, FormName]),[]);
  end;
end;

function TuilPermissionBindary.UpdatePermission(Permission, Items, FormName: string;
  Action: Integer): Boolean;
begin
  Result := false;
  self.FormName := FormName;
  if HasAccess(Permission) then
  begin
    DataSource.DataSet.Edit;
    DataSource.DataSet.FieldByName(KeyField).AsString := Permission;

    if ItemField <> '' then
      DataSource.DataSet.FieldByName(ItemField).AsString := Items;
    if ActionField <> '' then
      DataSource.DataSet.FieldByName(ActionField).AsInteger := Action;
    if FormNameField <> '' then
      DataSource.DataSet.FieldByName(FormNameField).AsString := FormName;

    DataSource.DataSet.Post;
    Result := true;
  end;
end;



{$IFDEF FREEWARE}
{$I TRIAL.INC}
{$ENDIF}


end.
