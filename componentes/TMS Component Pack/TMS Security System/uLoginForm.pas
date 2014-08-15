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
unit uLoginForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TuilLoginForm = class(TForm)
    labUsername: TLabel;
    labPassword: TLabel;
    txtUsername: TEdit;
    btnLogin: TButton;
    txtPassword: TEdit;
    btnCancel: TButton;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  uilLoginForm: TuilLoginForm;

implementation

{$R *.DFM}

end.
