{***************************************************************************}
{ Scripter Studio Pro Components for Delphi & C++Builder                    }
{ version 1.6.0.1                                                           }
{                                                                           }
{ written by TMS Software                                                   }
{            copyright © 1997 - 2010                                        }
{            Email : info@tmssoftware.com                                   }
{            Web : http://www.tmssoftware.com                               }
{                                                                           }
{ For information about version history, check the section "What's New"     }
{ at Scripter Studio manual.                                                }                                                                         
{                                                                           }
{ The source code is given as is. The author is not responsible             }
{ for any possible damage done due to the use of this code.                 }
{ The component can be freely used in any application. The complete         }
{ source code remains property of the author and may not be distributed,    }
{ published, given or sold in any form as such. No parts of the source      }
{ code can be included in any other component or application without        }
{ written authorization of the author.                                      }
{***************************************************************************}

unit DesignerSizeDialog;

{$I ASCRIPT.INC}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF DELPHI2009_LVL}
  Character,
  {$ENDIF}
  StdCtrls;

type
  TfrmSize = class(TForm)
    grbWidth: TGroupBox;
    rbtWNoChange: TRadioButton;
    rbtWToSmallest: TRadioButton;
    rbtWToLargest: TRadioButton;
    rbtWidth: TRadioButton;
    edtWidth: TEdit;
    grbHeight: TGroupBox;
    rbtHNoChange: TRadioButton;
    rbtHToSmallest: TRadioButton;
    rbtHToLargest: TRadioButton;
    rbtHeight: TRadioButton;
    edtHeight: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure edtKeyPress(Sender: TObject; var Key: Char);
    procedure rbtClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{BJF} {$IFNDEF UseGreatisUnits} {$R *.DFM} {$ENDIF}

procedure TfrmSize.edtKeyPress(Sender: TObject; var Key: Char);
begin
  {$IFDEF DELPHI2009_LVL}
  if not (Character.IsDigit(Key) or (Ord(Key) = VK_DELETE) or (Ord(Key) = VK_BACK)) then
  {$ELSE}
  if not (Key in ['0'..'9',Char(VK_DELETE),Char(VK_BACK)]) then
  {$ENDIF}
  begin
    Key:=#0;
    MessageBeep(0);
  end;
end;

procedure TfrmSize.rbtClick(Sender: TObject);
begin
  edtWidth.Enabled:=rbtWidth.Checked;
  edtHeight.Enabled:=rbtHeight.Checked;
end;

end.
