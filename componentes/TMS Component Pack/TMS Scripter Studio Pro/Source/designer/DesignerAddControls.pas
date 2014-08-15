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

unit DesignerAddControls;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TfrmDesignerAddControls = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnSelectAll: TButton;
    lsbAddControls: TListBox;
    procedure lsvAddJobsEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure btnSelectAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TfrmDesignerAddControls.lsvAddJobsEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit:=False;
end;

procedure TfrmDesignerAddControls.btnSelectAllClick(Sender: TObject);
var
  i: Integer;
begin
  with lsbAddControls,Items do
    for i:=0 to Pred(Count) do Selected[i]:=True;
end;

procedure TfrmDesignerAddControls.FormShow(Sender: TObject);
begin
  with lsbAddControls,Items do
    if Count>0 then ItemIndex:=0;
end;

end.


