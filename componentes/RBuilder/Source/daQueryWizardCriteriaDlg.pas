{ RRRRRR                  ReportBuilder Class Library                  BBBBB
  RR   RR                                                              BB   BB
  RRRRRR                 Digital Metaphors Corporation                 BB BB
  RR  RR                                                               BB   BB
  RR   RR                   Copyright (c) 1996-2002                    BBBBB   }

unit daQueryWizardCriteriaDlg;

interface

{$I ppIfDef.pas}

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  ppTypes, ppUtils, daSQL;

type

  { TdaQueryWizardCriteriaDialog }
  TdaQueryWizardCriteriaDialog = class(TForm)
    lblField: TLabel;
    cbxAvailableFields: TComboBox;
    cbxOperators: TComboBox;
    lblOperator: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    lblValue: TLabel;
    edtValue: TEdit;
    procedure btnOKClick(Sender: TObject);
    procedure cbxAvailableFieldsChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end; {class, TdaQueryWizardCriteriaDialog}

implementation

{$R *.DFM}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCriteriaDialog.FormCreate }

procedure TdaQueryWizardCriteriaDialog.FormCreate(Sender: TObject);
begin

  Caption := ppLoadStr(819); {Search Criteria}

  btnOK.Caption := ppLoadStr(ppMsgOK); {OK}
  btnCancel.Caption := ppLoadStr(ppMsgCancel); {Cancel}

  lblField.Caption := ppLoadStr(760); {Field}
  lblOperator.Caption := ppLoadStr(802); {Operator}
  lblValue.Caption := ppLoadStr(837); {Value}

end; {procedure, FormCreate}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCriteriaDialog.btnOKClick }

procedure TdaQueryWizardCriteriaDialog.btnOKClick(Sender: TObject);
begin
  if ((cbxAvailableFields.ItemIndex > -1) and (cbxOperators.ItemIndex > -1)) then
    ModalResult := mrOK
  else
    {Please select a field and operator.}
    MessageDlg(ppLoadStr(806), mtWarning, [mbOK], 0);
end; {procedure, btnOKClick}

{------------------------------------------------------------------------------}
{ TdaQueryWizardCriteriaDialog.cbxAvailableFieldsChange }

procedure TdaQueryWizardCriteriaDialog.cbxAvailableFieldsChange(Sender: TObject);
begin
  {put some validation here}
end; {procedure, cbxAvailableFieldsChange}



end.
