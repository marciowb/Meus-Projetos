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
unit uLoginDlg;

interface

uses
  Windows, SysUtils, Classes, Buttons, Forms, Dialogs, uSecControl, uLoginForm,
  Controls;

type
  TuilLoginDlg = class(TComponent)
  private
    FLoginForm            : TuilLoginForm;
    FSecurityManager      : TuilSecurityManager;
    FUseWindowsUserName   : boolean;
    FTitleCaption,
    FUsernameCaption,
    FPasswordCaption,
    FLoginButtonCaption,
    FCancelButtonCaption  : string;
    FRetries              : integer;
    FTryNumber            : integer;
    FUserName             : string;
    FOnBeforeLoginAttempt : TNotifyEvent;
    FOnAfterLoginAttempt  : TNotifyEvent;
    function GetTriesRemaining: integer;
  protected
    function GetWindowsUserName : string; virtual;
    procedure TriggerBeforeLoginAttempt;
    procedure TriggerAfterLoginAttempt;
    function GetLoginUserName : string;
    procedure SetLoginUserName(newValue : string);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function Execute : boolean; virtual;
    property UserName : string read GetLoginUserName write SetLoginUserName stored False;
    property TriesRemaining: integer read GetTriesRemaining;
    property CurrentTry: integer read FTryNumber;
  published
    property SecurityManager: TuilSecurityManager read FSecurityManager write FSecurityManager;
    property UseWindowsUserName : boolean read FUseWindowsUserName write FUseWindowsUserName default true;
    property TitleCaption : string read FTitleCaption write FTitleCaption;
    property UsernameCaption : string read FUsernameCaption write FUsernameCaption;
    property PasswordCaption : string read FPasswordCaption write FPasswordCaption;
    property LoginButtonCaption : string read FLoginButtonCaption write FLoginButtonCaption;
    property CancelButtonCaption : string read FCancelButtonCaption write FCancelButtonCaption;
    property Retries : integer read FRetries write FRetries default 3;
    property OnBeforeLoginAttempt : TNotifyEvent read FOnBeforeLoginAttempt write FOnBeforeLoginAttempt;
    property OnAfterLoginAttempt : TNotifyEvent read FOnAfterLoginAttempt write FOnAfterLoginAttempt;
  end;

implementation

uses
   Registry;

type

  TuilSecurityManagerEx = class(TuilSecurityManager);
     

{ TuilLoginDlg }

constructor TuilLoginDlg.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);

   // Set defaults...
   FTitleCaption := 'Login';
   FUsernameCaption := 'Username:';
   FPasswordCaption := 'Password:';
   FLoginButtonCaption := 'Login';
   FCancelButtonCaption := 'Cancel';
   FUseWindowsUserName := true;
   FRetries := 3;
   FTryNumber := 1;
end;

destructor TuilLoginDlg.Destroy;
begin
  inherited Destroy;
end;

function TuilLoginDlg.GetWindowsUserName : string;
var
   buf   : array [0..128] of char;
   nSize : DWORD;
begin
   Result := '';
   nSize := SizeOf(buf);
   if GetUsername(buf, nSize) then
      Result := buf;
end;

procedure TuilLoginDlg.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSecurityManager) then
    FSecurityManager := nil;
end;

function TuilLoginDlg.Execute: boolean;
begin
   FTryNumber := 1;
   Result := False;
   if not assigned(FSecurityManager) then
      raise Exception.Create('You must specify a Security Contoller');

   FLoginForm := TuilLoginForm.Create(nil);
   try
      FLoginForm.labUsername.Caption := FUsernameCaption;
      FLoginForm.labPassword.Caption := FPasswordCaption;
      FLoginForm.btnLogin.Caption := FLoginButtonCaption;
      FLoginForm.btnCancel.Caption := FCancelButtonCaption;
      FLoginForm.Caption := FTitleCaption;
      if FUseWindowsUserName and (FUserName = '')then
         FUserName := GetWindowsUserName;

      if FUserName <> '' then
      begin
         FLoginForm.txtUsername.Text := FUserName;
         FLoginForm.ActiveControl := FLoginForm.txtPassword;
      end;

      repeat
         if FLoginForm.ShowModal = idOK then
         begin
            FUserName := FLoginForm.txtUserName.Text;
            TriggerBeforeLoginAttempt;
            TuilSecurityManagerEx(FSecurityManager).CurrentTry := FTryNumber;             
            TuilSecurityManagerEx(FSecurityManager).TriesRemaining := FRetries - FTryNumber;
            Result := FSecurityManager.Login(FLoginForm.txtUsername.Text, FLoginForm.txtPassword.Text);
         end
         else
         begin
            FTryNumber := FRetries + 1;  // Force an exit
         end;

         TriggerAfterLoginAttempt;
         Inc(FTryNumber)
      until (FTryNumber > FRetries) or Result;
   finally
      FLoginForm.Release;
   end;
end;


procedure TuilLoginDlg.TriggerAfterLoginAttempt;
begin
  if Assigned(FOnAfterLoginAttempt) then
    FOnAfterLoginAttempt(Self);
end;

procedure TuilLoginDlg.TriggerBeforeLoginAttempt;
begin
  if Assigned(FOnBeforeLoginAttempt) then
    FOnBeforeLoginAttempt(Self);
end;

function TuilLoginDlg.GetLoginUserName: string;
begin
  Result := FUserName;
end;

function TuilLoginDlg.GetTriesRemaining: integer;
begin
  Result := FRetries - FTryNumber;
end;

procedure TuilLoginDlg.SetLoginUserName(newValue: string);
begin
  if FUserName <> newValue then
    FUserName := newValue;
end;

end.
