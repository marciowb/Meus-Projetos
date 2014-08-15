{***********************************************************************}
{ TMS Security framework                                                }
{ for Delphi & C++Builder                                               }
{                                                                       }
{ written by                                                            }
{   TMS Software                                                        }
{   Copyright © 2003 - 2008                                             }
{   Email : info@tmssoftware.com                                        }
{   Web : http://www.tmssoftware.com                                    }
{***********************************************************************}

unit uSecDlg;

interface

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
  uSecControl,
  uSecDlgForm;

const
  REG_SettingsSectionName = 'Security Dialog';

type
  TuilSecurityDlg = class(TComponent)
  private
    { Private declarations }
    FSaveToRegistry: Boolean;
    FWidth: Integer;
    FHeight: Integer;
    FPanelWidth: integer;
    FRegistryKey: string;
    FSecurityManager: TuilSecurityManager;
    FFormCaption: string;
    FUsersCaption: string;
    FGroupsCaption: string;
    FMembershipCaption: string;
    FShowGroups: Boolean;
    FOnUserAdded: TuilUserEvent;
    FOnUserDeleted: TuilUserEvent;
    FOnUserEdited: TuilUserEvent;
    FOnGroupAdded: TuilGroupEvent;
    FOnGroupDeleted: TuilGroupEvent;
    FOnGroupEdited: TuilGroupEvent;
    FCanAddUser: Boolean;
    FCanDeleteUser: Boolean;
    FCanEditUser: Boolean;
    FCanAddGroup: boolean;
    FCanEditGroup: boolean;
    FCanDeleteGroup: boolean;
    
    procedure SetSecurityManager(newValue: TuilSecurityManager);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; operation: TOperation); override;
    procedure SaveComponentOptionsToRegistry; dynamic;
    procedure LoadComponentOptionsFromRegistry; dynamic;
    procedure Loaded; override;
    procedure TriggerUserAdded(Sender: TObject; UserName:string);                                     
    procedure TriggerUserDeleted(Sender: TObject; UserName:string);
    procedure TriggerUserEdited(Sender: TObject; UserName:string);
    procedure TriggerGroupAdded(Sender: TObject; GroupName:string);
    procedure TriggerGroupDeleted(Sender: TObject; GroupName:string);
    procedure TriggerGroupEdited(Sender: TObject; GroupName:string);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: boolean;
  published
    { Published properties and events }
    property CanAddUser: Boolean read FCanAddUser Write FCanAddUser default True;
    property CanDeleteUser: Boolean read FCanDeleteUser Write FCanDeleteUser default True;
    property CanEditUser: Boolean read FCanEditUser Write FCanEditUser default True;
    property CanAddGroup: Boolean read FCanAddGroup Write FCanAddGroup default True;
    property CanDeleteGroup: Boolean read FCanDeleteGroup Write FCanDeleteGroup default True;
    property CanEditGroup: Boolean read FCanEditGroup Write FCanEditGroup default True;
    
    property FormCaption: string read FFormCaption write FFormCaption;
    property UsersCaption: string read FUsersCaption write FUsersCaption;
    property GroupsCaption: string read FGroupsCaption write FGroupsCaption;
    property MembershipCaption: string read FMembershipCaption write FMembershipCaption;
    property ShowGroups: Boolean read FShowGroups write FShowGroups default True;
    property SecurityManager: TuilSecurityManager read FSecurityManager write SetSecurityManager;
    property RegistryKey: string read FRegistryKey write FRegistryKey;
    property SaveToRegistry: Boolean read FSaveToRegistry write FSaveToRegistry; 

    property OnUserAdded: TuilUserEvent read FOnUserAdded write FOnUserAdded;
    property OnUserDeleted: TuilUserEvent read FOnUserDeleted write FOnUserDeleted;
    property OnUserEdited: TuilUserEvent read FOnUserEdited write FOnUserEdited;

    property OnGroupAdded: TuilGroupEvent read FOnGroupAdded write FOnGroupAdded;
    property OnGroupDeleted: TuilGroupEvent read FOnGroupDeleted write FOnGroupDeleted;
    property OnGroupEdited: TuilGroupEvent read FOnGroupEdited write FOnGroupEdited;
  end; { TuilSecurityDlg }

implementation

uses
  ComCtrls, Registry;

function TuilSecurityDlg.Execute: boolean;
var
  FrmDialogComponent: TfrmPermissionsDlg;
begin
  Result := false;
  FrmDialogComponent := TfrmPermissionsDlg.Create(self);
  try
    FrmDialogComponent.OnUserAdded := TriggerUserAdded;
    FrmDialogComponent.OnUserDeleted := TriggerUserDeleted;
    FrmDialogComponent.OnUserEdited := TriggerUserEdited;

    FrmDialogComponent.OnGroupAdded := TriggerGroupAdded;
    FrmDialogComponent.OnGroupDeleted := TriggerGroupDeleted;
    FrmDialogComponent.OnGroupEdited := TriggerGroupEdited;

    FrmDialogComponent.Caption := FFormCaption;
    FrmDialogComponent.tsUsers.Caption := FUsersCaption;
    FrmDialogComponent.tsGroups.Caption := FGroupsCaption;
    FrmDialogComponent.tsMembership.Caption := FMembershipCaption;
    FrmDialogComponent.SecurityManager := FSecurityManager;
    FrmDialogComponent.Width := FWidth;
    FrmDialogComponent.Height := FHeight;
    FrmDialogComponent.Panel1.Width := FPanelWidth;
    FrmDialogComponent.Panel3.Width := FPanelWidth;
    FrmDialogComponent.Panel8.Width := FPanelWidth;        
    frmDialogComponent.tsGroups.TabVisible := FShowGroups;
    frmDialogComponent.tsMembership.TabVisible := FShowGroups;
    frmDialogComponent.btnAddUser.Enabled := FCanAddUser;
    frmDialogComponent.btnDeleteUser.Enabled := FCanDeleteUser;
    frmDialogComponent.btnEditUser.Enabled := FCanEditUser;

    if FrmDialogComponent.ShowModal = mrOk then
    begin
      FWidth := FrmDialogComponent.Width;
      FHeight := FrmDialogComponent.Height;
      FPanelWidth := FrmDialogComponent.Panel1.Width;
      Result := true;
    end;
  finally
    FrmDialogComponent.Free;
  end;
end; { Execute }

procedure TuilSecurityDlg.SetSecurityManager(newValue: TuilSecurityManager);
begin
  if FSecurityManager <> newValue then
  begin
    FSecurityManager := newValue;
{$IFDEF UIL_WIN32}
    if newValue <> nil then
      newValue.FreeNotification(Self);
{$ENDIF}
  end;
end;

procedure TuilSecurityDlg.TriggerGroupAdded(Sender: TObject; GroupName: string);
begin
  if Assigned(OnGroupAdded) then
    OnGroupAdded(Self, GroupName);

end;

procedure TuilSecurityDlg.TriggerGroupDeleted(Sender: TObject;
  GroupName: string);
begin
  if Assigned(OnGroupDeleted) then
    OnGroupDeleted(Self, GroupName);
end;

procedure TuilSecurityDlg.TriggerGroupEdited(Sender: TObject;
  GroupName: string);
begin
  if Assigned(OnGroupEdited) then
    OnGroupEdited(Self, GroupName);
end;

procedure TuilSecurityDlg.TriggerUserAdded(Sender: TObject; UserName: string);
begin
  if Assigned(OnUserAdded) then
    OnUserAdded(Self, UserName);
end;

procedure TuilSecurityDlg.TriggerUserDeleted(Sender: TObject; UserName: string);
begin
  if Assigned(OnUserDeleted) then
    OnUserDeleted(Self, UserName);
end;

procedure TuilSecurityDlg.TriggerUserEdited(Sender: TObject; UserName: string);
begin
  if Assigned(OnUserEdited) then
    OnUserEdited(Self, UserName);
end;

{ SetSecurityManager }

procedure TuilSecurityDlg.Notification(AComponent: TComponent; operation: TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if AComponent = FSecurityManager then
      FSecurityManager := nil;
  end;
end; 

procedure TuilSecurityDlg.SaveComponentOptionsToRegistry;
begin
  with TRegIniFile.Create(FRegistryKey) do
  try
    RootKey := HKEY_CURRENT_USER;
    WriteInteger(REG_SettingsSectionName, 'Width', FWidth);
    WriteInteger(REG_SettingsSectionName, 'Height', FHeight);
    WriteInteger(REG_SettingsSectionName, 'PanelWidth', FPanelWidth);
  finally
    Free;
  end;
end;

procedure TuilSecurityDlg.LoadComponentOptionsFromRegistry;
begin
  with TRegIniFile.Create(FRegistryKey) do
  try
    RootKey := HKEY_CURRENT_USER;
    FWidth := ReadInteger(REG_SettingsSectionName, 'Width', 455);
    FHeight := ReadInteger(REG_SettingsSectionName, 'Height', 292);
    FPanelWidth := ReadInteger(REG_SettingsSectionName, 'PanelWidth', 145);

    if FWidth = 0 then
      FWidth := 455;
    if FHeight = 0 then
      FHeight := 292;
    if FPanelWidth = 0 then
      FPanelWidth := 145;
  finally
    Free;
  end;
end;

procedure TuilSecurityDlg.Loaded;
begin
  inherited Loaded;
  FWidth := 455;
  FHeight := 292;
  FPanelWidth := 145; 
  if FSaveToRegistry then
    LoadComponentOptionsFromRegistry;
end; 

destructor TuilSecurityDlg.Destroy;
begin
  if FSaveToRegistry then
    SaveComponentOptionsToRegistry;
  inherited Destroy;
end;

constructor TuilSecurityDlg.Create(AOwner: TComponent);
{ Creates an object of type TuilSecurityDlg, and initializes properties. }
begin
  inherited Create(AOwner);

  { Initialize properties with default values: }
  FShowGroups := True;
  FFormCaption := 'Security Settings';
  FUsersCaption := 'Users';
  FGroupsCaption := 'Groups';
  FMembershipCaption := 'Membership';
  FRegistryKey := 'Software\tmssoftware\Security System';
  FCanAddUser := True;
  FCanDeleteUser := True;
  FCanEditUser := True;
  FCanAddGroup := true;
  FCanDeleteGroup := true;
  FCanEditGroup := true;
end;

end.
