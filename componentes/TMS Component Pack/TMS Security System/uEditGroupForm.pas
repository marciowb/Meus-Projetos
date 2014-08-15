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
unit uEditGroupForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, Db, Buttons, ExtCtrls;

type
  TfrmEditGroup = class(TForm)
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    dsGroups: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    txtGroupName: TDBEdit;
    txtGroupDescription: TDBEdit;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
