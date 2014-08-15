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

unit uChangePasswordForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TuilChangePasswordForm = class(TForm)
    labCurrPwd: TLabel;
    labNewPwd: TLabel;
    txtCurrentPassword: TEdit;
    btnOK: TButton;
    txtNewPassword: TEdit;
    btnCancel: TButton;
    Image1: TImage;
    labConfirmPwd: TLabel;
    txtConfirmPassword: TEdit;
    procedure txtNewPasswordChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurPassword:string;
  end;

var
  uilChangePasswordForm: TuilChangePasswordForm;

implementation

{$R *.DFM}

procedure TuilChangePasswordForm.txtNewPasswordChange(Sender: TObject);
begin
  btnOK.Enabled := (Uppercase(txtNewPassword.Text) = Uppercase(txtConfirmPassword.Text)) and
                      (Uppercase(CurPassword) = Uppercase(txtCurrentPassword.Text));
end;

end.
