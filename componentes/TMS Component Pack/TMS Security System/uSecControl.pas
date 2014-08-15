{***********************************************************************}
{ TMS Security framework                                                }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2009                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}
unit uSecControl; 

interface

{$I TMSDEFS.INC}

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  StdCtrls,
  ExtCtrls,
  Db,
  uBindary
  //uChangePasswordForm
{$IFDEF DELPHI6_LVL}
  , Variants
{$ENDIF}
  ;

type
  TuilDisabledLoginEvent = procedure(Sender: TObject; UserName: string) of object;

  TuilFailedLoginDetailEvent = procedure(Sender: TObject; UserName, Password: string) of object;

  TuilSecurityManager = class(TComponent)
  private
    { Private declarations }
    FCurrentPermissions: TStrings;
    FCurrentUser: string;
    FCurrentPassword: string;
    FPolicies: TList;
    FUserBindary: TuilUserBindary;
    FGroupBindary: TuilGroupBindary;
    FPermissionBindary: TuilPermissionBindary;
    FLoggedIn: Boolean;
    FActive: Boolean;
    FOnBeforeLogin: TNotifyEvent;
    FOnSuccessfulLogin: TNotifyEvent;
    FOnFailedLogin: TNotifyEvent;
    FOnFailedLoginDetail: TuilFailedLoginDetailEvent;
    FOnDisabledLogin: TuilDisabledLoginEvent;
    FTryNumber: Integer;
    FTriesRemaining: Integer;
    function GetOnEncrypt: TuilEncryptEvent;
    procedure SetOnEncrypt(const Value: TuilEncryptEvent);
  protected
    { Protected declarations }
    procedure SetVersion(NewValue: string); virtual;
    function GetVersion: string; virtual;
    procedure GetPermissions; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure TriggerBeforeLoginEvent; virtual;
    procedure TriggerSuccessfulLoginEvent; virtual;
    procedure TriggerFailedLoginEvent(UserName, Password:string); virtual;
    procedure TriggerDisabledLoginEvent(UserName: string); virtual;
    property TriesRemaining: integer read FTriesRemaining write FTriesRemaining;
    property CurrentTry: integer read FTryNumber write FTryNumber;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Attach(Sender: TComponent); virtual;
    procedure Detach(Sender: TComponent); virtual;
    function Login(Username, Password: string): Boolean;
    procedure Logout; 
    property LoggedIn: boolean read FLoggedIn;
    //procedure ChangePassword;
    procedure ModifyPassword(NewPassword: string);
    function HasPermission(Permission: string): Boolean; virtual;
    property CurrentUser: string read FCurrentUser;
    property CurrentPassword: string read FCurrentPassword;
    property LoginTriesRemaining: integer read FTriesRemaining;
    property LoginTryNumber: integer read FTryNumber;
  published
    property Active: Boolean read FActive write FActive default True;
    { Published properties and events }
    property UserBindary: TuilUserBindary read FUserBindary write FUserBindary;
    property GroupBindary: TuilGroupBindary read FGroupBindary write FGroupBindary;
    property PermissionBindary: TuilPermissionBindary read FPermissionBindary write FPermissionBindary;
    property Version: string read GetVersion write SetVersion;

    property OnEncrypt: TuilEncryptEvent read GetOnEncrypt write SetOnEncrypt;
    property OnBeforeLogin: TNotifyEvent read FOnBeforeLogin write FOnBeforeLogin;
    property OnFailedLogin: TNotifyEvent read FOnFailedLogin write FOnFailedLogin;
    property OnFailedLoginDetail: TuilFailedLoginDetailEvent read FOnFailedLoginDetail write FOnFailedLoginDetail;
    property OnSuccessfulLogin: TNotifyEvent read FOnSuccessfulLogin write FOnSuccessfulLogin;
    property OnDisabledLogin: TuilDisabledLoginEvent read FOnDisabledLogin write FOnDisabledLogin;
  end; { TuilSecurityManager }

implementation

uses
  uFormPolicy,
  usmGlobals;


function TuilSecurityManager.GetVersion: string;
begin
  Result := VersionString;
end;

procedure TuilSecurityManager.SetVersion(NewValue: string);
begin
   // Do nothing
end;

function TuilSecurityManager.Login(Username, Password: string): boolean; { public }
var
  SavedPassword: string;
  SavedUsername: string;
  usermatch: boolean;
  j: integer;
  OldOpen: boolean;
  Fld: TField;
begin
  OldOpen := FUserBindary.DataSource.DataSet.Active;
  FUserBindary.DataSource.DataSet.Open;
  Result := False;

  Logout;
  TriggerBeforeLoginEvent;

  // Check for login success...
  if FUserBindary.Locate(Username) then
  begin
    usermatch := true;

    // fix for ADO issue with case sensitive Locate, do check again 
    if FUserBindary.CaseSensitiveUsername then
    begin
      SavedUserName := FUserBindary.FieldByName(FUserBindary.UserNameField).AsString;
      usermatch := (SavedUserName = UserName);
    end;

    SavedPassword := FUserBindary.FieldByName(FUserBindary.PasswordField).AsString;

    // if we are using case insensitive passwords
    if not FUserBindary.CaseSensitivePassword then
    begin
      SavedPassword := Uppercase(SavedPassword);
      Password := UpperCase(Password);
    end;

    FCurrentPassword := Password;

    if (SavedPassword = FUserBindary.Encrypt(Password)) and (usermatch) then
    begin
      Fld := FUserBindary.FieldByName(FUserBindary.EnabledField);

      if Fld.DataType = ftBoolean then
      begin
        if not Fld.AsBoolean then
        begin
          TriggerDisabledLoginEvent(Username);
          Exit;
        end;
      end
      else
      begin // in case database does not support boolean fields
        if (not Fld.AsInteger = 1) then
        begin
          TriggerDisabledLoginEvent(Username);
          Exit;
        end;
      end;

      Result := true;
      FLoggedIn := true;
      FCurrentUser := UserName;

       // Load up the rights this user has.
      GetPermissions;

      // Update Access Count and Last Access Date
      FUserBindary.UpdateLogin;

      for j := 0 to FPolicies.Count - 1 do // Iterate
        (TObject(FPolicies.Items[j]) as TuilFormPolicy).Apply;

      TriggerSuccessfulLoginEvent;
    end
    else
    begin
      TriggerFailedLoginEvent(UserName, Password);
    end;
  end
  else
    TriggerFailedLoginEvent(UserName, Password);

  if not OldOpen then
    FUserBindary.DataSource.DataSet.Close;
end; { Login }

procedure TuilSecurityManager.GetPermissions; { protected }
var
  uid: string;
  uperm: string;
  ugrp, sgrp: string;
  uimatch: boolean;
begin
  FCurrentPermissions.Clear;
  FUserBindary.UserPermissions.DataSource.DataSet.First;

  while not FUserBindary.UserPermissions.DataSource.DataSet.EOF do
  begin
    uid := FUserBindary.UserPermissions.FieldByName(FUserBindary.UserPermissions.UserNameField).AsString;

    if FUserBindary.CaseSensitiveUsername then
      uimatch := uid = FCurrentUser
    else
      uimatch := Uppercase(uid) = Uppercase(FCurrentUser);

    if uimatch then
    begin
      uperm := FUserBindary.UserPermissions.FieldByName(FUserBindary.UserPermissions.PermissionField).AsString;
      if FCurrentPermissions.IndexOf(uperm) = -1 then // not found, so add
        FCurrentPermissions.Add(uperm);
    end;
    FUserBindary.UserPermissions.DataSource.DataSet.Next;
  end; // while

  FGroupBindary.DataSource.DataSet.First;
  while not FGroupBindary.DataSource.DataSet.EOF do
  begin

    if FGroupBindary.GroupMembershipBindary.Locate(VarArrayOf([FCurrentUser, FGroupBindary.FieldByName(FGroupBindary.GroupNameField).AsString])) then
    begin
      ugrp := GroupBindary.GroupMembershipBindary.DataSource.DataSet.FieldByName(GroupBindary.GroupMembershipBindary.GroupNameField).AsString;
      FGroupBindary.GroupPermissions.DataSource.DataSet.First;
      while not FGroupBindary.GroupPermissions.DataSource.DataSet.EOF do
      begin
        sGrp := GroupBindary.GroupMembershipBindary.DataSource.DataSet.FieldByName(GroupBindary.GroupPermissions.GroupNameField).AsString;

        if (sgrp = ugrp) then
        begin
          if FCurrentPermissions.IndexOf(FGroupBindary.GroupPermissions.FieldByName(FGroupBindary.GroupPermissions.PermissionField).AsString) = -1 then
            FCurrentPermissions.Add(FGroupBindary.GroupPermissions.FieldByName(FGroupBindary.GroupPermissions.PermissionField).AsString);
        end;
        FGroupBindary.GroupPermissions.DataSource.DataSet.Next;
      end; // while
    end;
    FGroupBindary.DataSource.DataSet.Next;
  end; // while

end; { GetPermissions }

function TuilSecurityManager.HasPermission(Permission: string): boolean;
begin
  Result := FCurrentPermissions.IndexOf(Permission) <> -1;
end;

procedure TuilSecurityManager.Notification(AComponent: TComponent; operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if assigned(FGroupBindary) then
      FGroupBindary.Notification(AComponent, Operation);
    if assigned(FUserBindary) then
      FUserBindary.Notification(AComponent, Operation);
    if assigned(FPermissionBindary) then
      FPermissionBindary.Notification(AComponent, Operation);
  end;
end; { Notification }

procedure TuilSecurityManager.Detach(Sender: TComponent);
begin
  if Assigned(Sender) then
    FPolicies.Remove(Sender);
end;

procedure TuilSecurityManager.Attach(Sender: TComponent);
begin
  if Assigned(Sender) then
    FPolicies.Add(Sender);
end;

procedure TuilSecurityManager.Logout;
var
  j: Integer;
begin
  FLoggedIn := false;
  FCurrentPermissions.Clear;
  for j := 0 to FPolicies.Count - 1 do // Iterate
    (TObject(FPolicies[j]) as TuilFormPolicy).Apply; // was: .ActivateAll;  // changed Jan 24, 2000
end;

procedure TuilSecurityManager.TriggerBeforeLoginEvent;
{ Triggers the OnBeforeLogin event. This is a virtual method (descendants of this component can override it). }
begin
  if (Assigned(FOnBeforeLogin)) then
    FOnBeforeLogin(Self);
end; { TriggerBeforeLoginEvent }

procedure TuilSecurityManager.TriggerSuccessfulLoginEvent;
{ Triggers the OnSuccessfulLogin event. This is a virtual method (descendants of this component can override it). }
begin
  if (Assigned(FOnSuccessfulLogin)) then
    FOnSuccessfulLogin(Self);
end; { TriggerSuccessfulLoginEvent }

procedure TuilSecurityManager.TriggerFailedLoginEvent(UserName, Password: string);
{ Triggers the OnFailedLogin event. This is a virtual method (descendants of this component can override it). }
begin
  if (Assigned(FOnFailedLogin)) then
    FOnFailedLogin(Self);

  if Assigned(FOnFailedLoginDetail) then
    FOnFailedLoginDetail(Self, UserName, Password);
end; { TriggerFailedLoginEvent }

procedure TuilSecurityManager.TriggerDisabledLoginEvent(UserName: string);
{ Triggers the OnDisabledLogin event. This is a virtual method (descendants of this component can override it). }
begin
  if (Assigned(FOnDisabledLogin)) then
    FOnDisabledLogin(Self, UserName);
end; { TriggerDisabledLoginEvent }

destructor TuilSecurityManager.Destroy;
var
  j: Integer;
begin
  FCurrentPermissions.Free;
  FCurrentPermissions := nil;
  FUserBindary.Free;
  FUserBindary := nil;
  FGroupBindary.Free;
  FGroupBindary := nil;
  FPermissionBindary.Free;
  FPermissionBindary := nil;

  FPolicies.Pack;
  try
    for j := FPolicies.Count - 1 downto 0 do // Iterate
      (TObject(FPolicies.Items[j]) as TuilFormPolicy).SecurityManager := nil;
  except
  end;

  FPolicies.Free;
  FPolicies := nil;

  inherited Destroy;
end; { Destroy }

constructor TuilSecurityManager.Create(AOwner: TComponent);
{ Creates an object of type TuilSecurityManager, and initializes properties. }
begin
  inherited Create(AOwner);
  FPolicies := TList.Create;
  FCurrentPermissions := TStringList.Create;
  FUserBindary := TuilUserBindary.Create(Self);
  FGroupBindary := TuilGroupBindary.Create(Self);
  FPermissionBindary := TuilPermissionBindary.Create(Self);
  FLoggedIn := False;
  FActive := True;
end;



function TuilSecurityManager.GetOnEncrypt: TuilEncryptEvent;
begin
  Result := FUserBindary.OnEncrypt;
end;

procedure TuilSecurityManager.SetOnEncrypt(const Value: TuilEncryptEvent);
begin
  FUserBindary.OnEncrypt := Value;
end;

procedure TuilSecurityManager.ModifyPassword(NewPassword: string);
var
  OldOpen: Boolean;
begin
  OldOpen := FUserBindary.DataSource.DataSet.Active;
  FUserBindary.DataSource.DataSet.Open;

  if FUserBindary.Locate(CurrentUser) then
  begin
    FUserBindary.DataSource.DataSet.Edit;
    FUserBindary.FieldByName(FUserBindary.PasswordField).AsString := FUserBindary.Encrypt(NewPassword);
    FUserBindary.DataSource.DataSet.Post;
  end;

  if not OldOpen then
    FUserBindary.DataSource.DataSet.Close;
end;

(*
procedure TuilSecurityManager.ChangePassword;
var
  cpForm: TuilChangePasswordForm;
begin
  cpForm := TuilChangePasswordForm.Create(Application);
  try
    cpForm.CurPassword := FCurrentPassword;
    if cpForm.ShowModal = mrOk then
      ModifyPassword(cpForm.txtNewPassword.Text);
  finally
    cpForm.Free;
  end;
end;
*)

end.
