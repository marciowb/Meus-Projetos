{***************************************************************}
{ FIBPlus - component library for direct access to Firebird and }
{ Interbase databases                                           }
{                                                               }
{    FIBPlus is based in part on the product                    }
{    Free IB Components, written by Gregory H. Deatz for        }
{    Hoagland, Longo, Moran, Dunst & Doukas Company.            }
{    mailto:gdeatz@hlmdd.com                                    }
{                                                               }
{    Copyright (c) 1998-2001 Serge Buzadzhy                     }
{    Contact: buzz@devrace.com                                  }
{                                                               }
{ ------------------------------------------------------------- }
{    FIBPlus home page      : http://www.fibplus.net/           }
{    FIBPlus support e-mail : fibplus@devrace.com               }
{ ------------------------------------------------------------- }
{                                                               }
{  Please see the file License.txt for full license information }
{***************************************************************}
unit pFIBAutoUpdEditor;

interface


uses {$IFNDEF LINUX}
      Windows,
     {$ENDIF}
     Classes, Controls, Forms, FIBDataSet, pFIBProps, StdCtrls, Db,
     pFIBDataSet, fraAutoUpdEditor;

type

  TpFIBAutoUpdateOptionForm = class(TForm)
    OkB: TButton;
    CancelB: TButton;
    fAutoUpdateOptionForm1: TfAutoUpdateOptionForm;
    procedure FormCreate(Sender: TObject);
  private
  public
    { Public declarations }
  end;

function EditAutoUpdateOptions(aDataSet: TpFIBDataSet): boolean;

implementation
uses SysUtils,FIBConsts;

{$R *.dfm}

function EditAutoUpdateOptions(aDataSet: TpFIBDataSet): boolean;
var
   aForm: TpFIBAutoUpdateOptionForm;
begin
  Result := False;
  if aDataSet = nil then exit;

  aForm := TpFIBAutoUpdateOptionForm.Create(Application);
  try
    with aForm,aForm.fAutoUpdateOptionForm1 do
    begin
      Caption := Format(Caption, [aDataSet.Name]);
      FDataSet := aDataSet;
      PrepareControls;
      Result := ShowModal = mrOk;
      if Result then
       ApplyToDataSet
   end;
  finally
    aForm.Free;
  end;
end;


procedure TpFIBAutoUpdateOptionForm.FormCreate(Sender: TObject);
begin
  Caption := FPAutoOptEditorCaption;
  OkB.Caption := SOKButton;
  CancelB.Caption := SCancelButton;
end;


end.
