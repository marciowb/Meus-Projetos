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
unit uEditUserForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, DBCtrls, Mask, ExtCtrls;

type
  TfrmEditUser = class(TForm)
    Label1: TLabel;
    txtUsername: TDBEdit;
    Label2: TLabel;
    txtFullName: TDBEdit;
    Label3: TLabel;
    txtPassword: TDBEdit;
    Label4: TLabel;
    txtPasswordVerify: TEdit;
    cbEnabled: TDBCheckBox;
    Label5: TLabel;
    Label6: TLabel;
    labAccessCount: TDBText;
    labCreatedDate: TDBText;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    dsUsers: TDataSource;
    Label7: TLabel;
    labLastAccess: TDBText;
    Image1: TImage;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmEditUser.btnOKClick(Sender: TObject);
begin
   if txtPassword.Text = txtPasswordVerify.Text then
      ModalResult := mrOK
   else
      ShowMessage('Passwords do not match.');
end;

end.
