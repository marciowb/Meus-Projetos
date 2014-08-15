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

unit StringsInspEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, PropertyInspEditors;

type

  TfrmStrings = class(TForm)
    lblCount: TLabel;
    redStrings: TRichEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    function GetStrings: TStrings;
    procedure redStringsChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  public
    { Public declarations }
    property Strings: TStrings read GetStrings;
  end;

  TStringsPropertyEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;

implementation

{$R *.DFM}

function TfrmStrings.GetStrings: TStrings;
begin
  Result:=redStrings.Lines;
end;

procedure TfrmStrings.redStringsChange(Sender: TObject);
var
  S: string;
begin
  with redStrings.Lines do
  begin
    S:=Format('%d line',[Count]);
    if Count<>1 then S:=S+'s';
  end;
  lblCount.Caption:=S;
end;

procedure TfrmStrings.btnClearClick(Sender: TObject);
begin
  redStrings.Lines.Clear;
end;

function TStringsPropertyEditor.Execute: Boolean;
{$IFDEF GOISETPROC}
type
  TSetStringsProc = procedure (NewStrings: TStrings) of object;
var
  SetProc: TSetStringsProc;
{$ELSE}
var
{$ENDIF}
  propStrings: TPersistent;
begin
  with TfrmStrings.Create(nil) do
  try
    {$IFDEF DELPHI9_LVL}
    if Prop.AsObject is TWideStrings then
      propStrings := TWideStrings(Prop.AsObject)
    else
    {$ENDIF}
      propStrings := TStrings(Prop.AsObject);

    redStrings.Lines.Assign(propStrings);
    Result:=ShowModal=mrOk;
    if Result then
    begin
      {$IFDEF GOISETPROC}
      TMethod(SetProc).Code:=Prop.SetProc;
      TMethod(SetProc).Data:=Pointer(Prop.Instance);
      SetProc(redStrings.Lines);
      {$ELSE}
      propStrings.Assign(redStrings.Lines);
      {$ENDIF}
    end;
  finally
    Free;
  end;
end;

end.

