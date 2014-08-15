{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daQueryWizardCalcDlg;

interface

{$I ppIfDef.pas}

uses


  Windows,
  SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ppTypes, ppUtils, daSQL;

type

  { TdaQueryWizardCalcDialog }
  TdaQueryWizardCalcDialog = class(TForm)
    lblFunction: TLabel;
    cbxFunctions: TComboBox;
    cbxAvailableFields: TComboBox;
    lblField: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    procedure btnOKClick(Sender: TObject);
    procedure cbxFunctionsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure EnableControls;

  public

  end; {class, TdaQueryWizardCalcDialog}

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCalcDialog.FormCreate }

procedure TdaQueryWizardCalcDialog.FormCreate(Sender: TObject);
begin

  Caption := ppLoadStr(736); {Calculated Fields}

  btnOK.Caption := ppLoadStr(ppMsgOK); {OK}
  btnCancel.Caption := ppLoadStr(ppMsgCancel); {Cancel}

  lblFunction.Caption := ppLoadStr(766); {Function}
  lblField.Caption := ppLoadStr(799); {Numeric Field}

end; {procedure, cbFunctionChange}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCalcDialog.FormActivate }

procedure TdaQueryWizardCalcDialog.FormActivate(Sender: TObject);
begin
  EnableControls;
end; {procedure, FormActivate}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCalcDialog.btnOKClick }

procedure TdaQueryWizardCalcDialog.btnOKClick(Sender: TObject);
begin
  if (cbxFunctions.ItemIndex = Ord(dacaCount)) or ((cbxFunctions.ItemIndex > -1) and (cbxAvailableFields.ItemIndex > -1)) then
    ModalResult := mrOK
  else
    {message: You must select a function and a field.}
    MessageDlg(ppLoadStr(704), mtError, [mbOK],0);
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCalcDialog.cbFunctionChange }

procedure TdaQueryWizardCalcDialog.cbxFunctionsChange(Sender: TObject);
begin
  EnableControls;
end; {procedure, cbFunctionChange}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCalcDialog.EnableControls }

procedure TdaQueryWizardCalcDialog.EnableControls;
begin

  if (cbxFunctions.ItemIndex = Ord(dacaCount)) then
    begin
      cbxAvailableFields.Font.Color := clBtnFace;
      cbxAvailableFields.Enabled := False;
      lblField.Enabled := False;
    end
  else
    begin
      cbxAvailableFields.Font.Color := clBtnText;
      cbxAvailableFields.Enabled := True;
      lblField.Enabled := True;
    end;
    
end; {procedure, EnableControls}


end.
