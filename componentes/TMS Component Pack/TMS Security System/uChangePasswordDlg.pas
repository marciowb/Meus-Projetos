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

unit uChangePasswordDlg;

interface

uses
   Windows, SysUtils, Classes, Buttons, Forms, Dialogs, uSecControl, uChangePasswordForm,
   Controls;

type
   TuilChangePasswordDlg = class(TComponent)
   private
     FChangePasswordForm   : TuilChangePasswordForm;
     FSecurityManager      : TuilSecurityManager;
     FTitleCaption,
     FCurrPasswordCaption,
     FNewPasswordCaption,
     FConfirmPasswordCaption,
     FOkButtonCaption,
     FCancelButtonCaption  : string;
   protected
     procedure Notification(AComponent: TComponent; Operation: TOperation); override;
   public
     constructor Create(AOwner : TComponent); override;
     destructor Destroy; override;
     function Execute : boolean; virtual;
   published
     property SecurityManager: TuilSecurityManager read FSecurityManager write FSecurityManager;
     property TitleCaption : string read FTitleCaption write FTitleCaption;
     property CurrentPasswordCaption : string read FCurrPasswordCaption write FCurrPasswordCaption;
     property NewPasswordCaption : string read FNewPasswordCaption write FNewPasswordCaption;
     property ConfirmPasswordCaption : string read FConfirmPasswordCaption write FConfirmPasswordCaption;
     property OKButtonCaption : string read FOKButtonCaption write FOKButtonCaption;
     property CancelButtonCaption : string read FCancelButtonCaption write FCancelButtonCaption;
   end;

implementation

uses
   Registry;

{ TuilLoginDlg }

constructor TuilChangePasswordDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // Set defaults...
  FTitleCaption := 'Change Password';
  FCurrPasswordCaption := '&Current password:';
  FNewPasswordCaption := '&New password:';
  FConfirmPasswordCaption := 'C&onfirm password';
  FCancelButtonCaption := 'Cancel';
  FOkButtonCaption := 'OK';
end;

destructor TuilChangePasswordDlg.Destroy;
begin
  inherited Destroy;
end;


function TuilChangePasswordDlg.Execute: boolean;
begin
  Result := False;
  if not Assigned(FSecurityManager) then
     raise Exception.Create('You must specify a Security Contoller');

  FChangePasswordForm := TuilChangePasswordForm.Create(nil);
  try
    FChangePasswordForm.labCurrPwd.Caption := FCurrPasswordCaption;
    FChangePasswordForm.labNewPwd.Caption := FNewPasswordCaption;
    FChangePasswordForm.labConfirmPwd.Caption := FConfirmPasswordCaption;

    FChangePasswordForm.txtCurrentPassword.Text := FSecurityManager.CurrentPassword;
    FChangePasswordForm.CurPassword := FChangePasswordForm.txtCurrentPassword.Text;

    FChangePasswordForm.txtNewPassword.Text := '';
    FChangePasswordForm.txtConfirmPassword.Text := '';

    FChangePasswordForm.btnOK.Caption := FOKButtonCaption;
    FChangePasswordForm.btnCancel.Caption := FCancelButtonCaption;
    FChangePasswordForm.Caption := FTitleCaption;


    if FChangePasswordForm.ShowModal = idOK then
    begin
      FSecurityManager.ModifyPassword(FChangePasswordForm.txtNewPassword.Text);
    end;

  finally
    FChangePasswordForm.Free;
  end;
end;



procedure TuilChangePasswordDlg.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FSecurityManager) then
    FSecurityManager := nil;
end;

end.
